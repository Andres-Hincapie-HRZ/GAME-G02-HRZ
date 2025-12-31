package com.go2super.listener;

import com.go2super.database.entity.Account;
import com.go2super.database.entity.User;
import com.go2super.database.entity.sub.SameIPIncident;
import com.go2super.database.entity.sub.UserSameIPIncidentInfo;
import com.go2super.database.entity.type.UserRank;
import com.go2super.hooks.discord.RayoBot;
import com.go2super.logger.BotLogger;
import com.go2super.logger.data.UserActionLog;
import com.go2super.obj.model.LoggedGameUser;
import com.go2super.obj.model.LoggedSessionUser;
import com.go2super.obj.type.AuditType;
import com.go2super.packet.PacketListener;
import com.go2super.packet.PacketProcessor;
import com.go2super.packet.login.GameServerLoginPacket;
import com.go2super.packet.login.PlayerLoginServerValidatePacket;
import com.go2super.packet.login.PlayerLoginTogPacket;
import com.go2super.packet.login.PlayerLoginTolPacket;
import com.go2super.server.GameServerReceiver;
import com.go2super.service.*;
import com.go2super.socket.util.DateUtil;
import com.go2super.socket.util.SocketUtil;
import lombok.SneakyThrows;

import java.awt.*;
import java.util.Date;
import java.util.Optional;

public class LoginListener implements PacketListener {

    private static final int MAX_PLAYERS = 500;

    @SneakyThrows
    @PacketProcessor
    public void onLoginTol(PlayerLoginTolPacket packet) {

        LoginService loginService = LoginService.getInstance();
        Optional<LoggedSessionUser> sessionUser = loginService.getSession(packet.getUserId());

        if(!sessionUser.isPresent()) {
            cancel(packet);
            return;
        }

        LoggedSessionUser session = sessionUser.get();
        String sessionKey = session.getSessionKey();

        if(!packet.getSessionKey().shrink(25).equals(sessionKey)) {
            cancel(packet);
            return;
        }

        User user = session.getUser();
        if(user == null) return;

        Optional<Account> optionalAccount = AccountService.getInstance().getAccountCache().findById(user.getAccountId());
        if(optionalAccount.isEmpty()) return;

        loginService.disconnectGame(session);

        if(!PacketService.getInstance().isLogin()) {
            if(!PacketService.getInstance().getWhitelist().contains(user.getId().toString())) {
                cancel(packet);
                return;
            }
            // packet.reply();
        }

        PlayerLoginServerValidatePacket response = new PlayerLoginServerValidatePacket();

        response.setPort(90);
        response.setUserId(packet.getUserId());
        response.getIp().setValue(PacketService.getInstance().getServerIp());
        response.getSessionKey().setValue(sessionKey);

        packet.reply(response);
        BotLogger.login("Login (Name: " + user.getUsername() + ", Id: " + user.getGuid() + ", IP: " + packet.getUserIp() + ")");

        // Audit
        Account account = optionalAccount.get();

        StringBuffer buffer = new StringBuffer();
        buffer.append("**Login:** `" + user.getUsername() + " (ID: " + user.getGuid() + ", EMAIL: " + account.getEmail() + ")`\n");

        DiscordService.getInstance().getRayoBot().sendAudit(buffer.toString(), "", Color.green, AuditType.LOGIN);

    }

    @PacketProcessor
    public void onLoginTog(PlayerLoginTogPacket packet) {

        LoginService loginService = LoginService.getInstance();
        Optional<LoggedSessionUser> optionalSessionUser = loginService.getSession(packet.getUserId());

        if(!optionalSessionUser.isPresent()) {
            cancel(packet);
            return;
        }

        LoggedSessionUser sessionUser = optionalSessionUser.get();
        String sessionKey = sessionUser.getSessionKey();

        if(!packet.getSessionKey().shrink(25).equals(sessionKey)) {
            cancel(packet);
            return;
        }

        Optional<Account> optionalAccount = AccountService.getInstance().getAccountCache().findById(sessionUser.getUser().getAccountId());
        if(optionalAccount.isEmpty()) return;

        // * Disconnect old session
        loginService.disconnectGame(sessionUser);

        Account account = optionalAccount.get();
        int error = 0;

        if(PacketService.getInstance().isMaintenance() && (account.getUserRank() != UserRank.ADMIN && (account.getMaintenanceBypass() == null || !account.getMaintenanceBypass()))) error = 3;
        else if(LoginService.getInstance().getGameUsers().size() + 1 > MAX_PLAYERS) error = 4;
        else if(account.getBanUntil() != null) {
            if(DateUtil.now().before(account.getBanUntil())) {
                error = 7;
            } else {
                account.setBanUntil(null);
                AccountService.getInstance().getAccountCache().save(account);
            }
        }

        if(error > 0) {

            GameServerLoginPacket response = new GameServerLoginPacket();

            response.setError((byte) error);
            response.setGuid(0);
            response.setGuide(1);

            packet.reply(response);
            return;

        }

        // * Make new logged user
        LoggedGameUser gameUser = loginService.login(sessionUser, packet);
        User updatedUser = gameUser.getUpdatedUser();

        GameServerLoginPacket response = new GameServerLoginPacket();

        response.setGuid(gameUser.getGuid());
        response.setGuide(1);

        // * Put guid to the receiver
        GameServerReceiver serverReceiver = (GameServerReceiver) packet.getSmartServer();

        serverReceiver.setAccountId(account.getId().toString());
        serverReceiver.setAccountEmail(account.getEmail());
        serverReceiver.setAccountName(account.getUsername());

        serverReceiver.setHostname(serverReceiver.getSocket().getInetAddress().getHostName());
        serverReceiver.setIp(SocketUtil.getIpAddress(serverReceiver.getSocket().getInetAddress().getAddress()));
        serverReceiver.setPort(serverReceiver.getSocket().getPort());

        serverReceiver.setUserId(gameUser.getUserId());
        serverReceiver.setGuid(gameUser.getGuid());

        serverReceiver.setLoginTime(new Date());
        serverReceiver.setUserMaxPpt(updatedUser.getUserMaxPpt());

        Thread.currentThread().setName("game-receiver-guid-" + gameUser.getGuid());

        if(account.getDiscordHook() != null && account.getDiscordHook().getDiscordId() != null)
            serverReceiver.setDiscordId(account.getDiscordHook().getDiscordId());

        packet.reply(response);

        UserActionLog action = UserActionLog.builder()
                .action("user-login")
                .message("[Login] " + updatedUser.getUsername() + " (IP: " + serverReceiver.getIp() + ":" + serverReceiver.getPort() + ", Guid: " + serverReceiver.getGuid() + ", UserId: " + serverReceiver.getUserId() + ")")
                .build();

        // EventLogger.sendUserAction(action, updatedUser, serverReceiver);

        Optional<SameIPIncident> optionalSameIPIncident = RiskService.getInstance().getRiskIncidentRepository().checkSameIPAndSave(account, updatedUser, serverReceiver);
        if(optionalSameIPIncident.isPresent()) {

            SameIPIncident sameIPIncident = optionalSameIPIncident.get();

            // LOG SYSTEM
            action = UserActionLog.builder()
                    .action("user-risk-same-ip")
                    .message("[RiskIncident/SameIP] " + updatedUser.getUsername() + " (IP: " + serverReceiver.getIp() + ":" + serverReceiver.getPort() + ", Guid: " + serverReceiver.getGuid() + ", UserId: " + serverReceiver.getUserId() + ")")
                    .build();

            // EventLogger.sendUserAction(action, updatedUser, serverReceiver);

            // RAYO AUDIT
            if(!sameIPIncident.isIgnore()) {

                Optional<UserSameIPIncidentInfo> current = sameIPIncident.getUsers().stream().filter(user -> user.getGuid() == serverReceiver.getGuid()).findFirst();

                if(current.isPresent()) {

                    UserSameIPIncidentInfo currentIncidentInfo = current.get();
                    boolean ignore = currentIncidentInfo.getIgnore() != null && currentIncidentInfo.getIgnore();

                    if(!ignore) {

                        StringBuffer buffer = new StringBuffer();

                        buffer.append("**Risk Type:** `SameIPIncident`\n");
                        buffer.append("**Risk ID:** `" + sameIPIncident.getId().toString() + "`\n\n");

                        UserSameIPIncidentInfo first = sameIPIncident.getUsers().get(0);

                        buffer.append("**Username:** " + currentIncidentInfo.getUsername() + "\n");
                        buffer.append("**Country:** " + first.getCountry() + "\n");
                        buffer.append("**ISP:** " + first.getIsp() + "\n");
                        buffer.append("**IP:** " + sameIPIncident.getIp() + "\n");
                        buffer.append("**Detections:**\n");

                        for(UserSameIPIncidentInfo incidentInfo : sameIPIncident.getUsers()) {
                            boolean userIgnore = incidentInfo.getIgnore() != null && incidentInfo.getIgnore();
                            String description = incidentInfo.getDescription() != null ? ", INFO: " + incidentInfo.getDescription() : "";
                            buffer.append((userIgnore ? "~ " : "") + "[_" + incidentInfo.getCount() + "_] " + incidentInfo.getUsername() + " `(ID: " + incidentInfo.getGuid() + ", EMAIL: " + incidentInfo.getEmail() + description + ")`\n");
                        }

                        buffer.append("\n");
                        buffer.append("Ignore this incident: `/ignore id:" + sameIPIncident.getId().toString() + "`\n");
                        buffer.append("Ignore this user: `/user-ignore id:" + sameIPIncident.getId().toString() + " guid:" + serverReceiver.getGuid() + " info:description`");

                        RayoBot rayoBot = DiscordService.getInstance().getRayoBot();
                        rayoBot.sendAudit(buffer.toString());

                    }

                }

            }

        }

    }

    @SneakyThrows
    public void cancel(PlayerLoginTolPacket packet) {
        packet.getSocket().close();
    }

    @SneakyThrows
    public void cancel(PlayerLoginTogPacket packet) {
        packet.getSocket().close();
    }

}
