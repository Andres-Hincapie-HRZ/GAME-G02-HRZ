package com.go2super.listener;

import com.go2super.database.entity.Fleet;
import com.go2super.database.entity.User;
import com.go2super.database.entity.sub.BattleFleet;
import com.go2super.database.entity.type.MatchType;
import com.go2super.logger.BotLogger;
import com.go2super.obj.model.LoggedGameUser;
import com.go2super.obj.utility.GameInstance;
import com.go2super.obj.utility.SmartString;
import com.go2super.obj.utility.UnsignedChar;
import com.go2super.packet.PacketListener;
import com.go2super.packet.PacketProcessor;
import com.go2super.packet.fight.ResponseArenaStatusPacket;
import com.go2super.packet.instance.RequestEctypeInfoPacket;
import com.go2super.packet.instance.RequestEctypePacket;
import com.go2super.packet.instance.ResponseEctypeStatePacket;
import com.go2super.resources.ResourceManager;
import com.go2super.service.BattleService;
import com.go2super.service.LoginService;
import com.go2super.service.PacketService;
import com.go2super.service.UserService;
import com.go2super.service.battle.Match;
import com.go2super.service.battle.MatchRunnable;
import com.go2super.service.battle.match.ArenaMatch;
import com.go2super.service.battle.type.StopCause;
import com.go2super.service.exception.BadGuidException;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class InstanceListener implements PacketListener {

    @PacketProcessor
    public void onEctype(RequestEctypePacket packet) throws BadGuidException {

        LoginService.validate(packet, packet.getGuid());

        User user = UserService.getInstance().getUserCache().findByGuid(packet.getGuid());
        if(user == null || packet.getDataLen().getValue() <= 0) return;

        Optional<Match> optionalCurrent = BattleService.getInstance().getVirtual(user.getGuid());
        if(optionalCurrent.isPresent()) return;

        Optional<LoggedGameUser> optionalLoggedGameUser = user.getLoggedGameUser();
        if(optionalLoggedGameUser.isEmpty()) return;

        LoggedGameUser loggedGameUser = optionalLoggedGameUser.get();

        // * Arena
        if(packet.getEctypeId() == 1001) {

            BotLogger.log(packet);

            // Create
            if(packet.getRoomId() == -1) {

                List<Integer> fleetIds = new ArrayList<>();

                for(int i = 0; i < packet.getDataLen().getValue(); i++)
                    fleetIds.add(packet.getShips().getArray()[i]);

                if(fleetIds.size() > 60 || fleetIds.size() < 1)
                    return;

                MatchRunnable runnable = BattleService.getInstance().makeArenaMatch(user, fleetIds, packet.getPassKey());
                if(runnable == null) return;

                ResponseEctypeStatePacket response = new ResponseEctypeStatePacket();

                response.setEctypeId(packet.getEctypeId());
                response.setGateId(UnsignedChar.of(1));
                response.setState((byte) 4);

                packet.reply(response);

                ResponseArenaStatusPacket status = new ResponseArenaStatusPacket();

                status.setGuid(user.getGuid());
                status.setCName(SmartString.of(user.getUsername(), 32));

                status.setRoomId(user.getGuid());
                status.setRequest(UnsignedChar.of(100));

                status.setStatus((byte) 1);
                packet.reply(status);

            } else if(packet.getRoomId() != user.getGuid()) {

                Optional<ArenaMatch> optionalMatch = BattleService.getInstance().getArenaByOwner(packet.getRoomId(), true);

                if(optionalMatch.isEmpty())
                    return;

                ArenaMatch arenaMatch = optionalMatch.get();

                if(arenaMatch.getTargetGuid() != -1)
                    return;

                if(arenaMatch.getPassword() != -1 && arenaMatch.getPassword() != packet.getPassKey()) {

                    ResponseEctypeStatePacket response = new ResponseEctypeStatePacket();

                    response.setEctypeId(packet.getEctypeId());
                    response.setGateId(UnsignedChar.of(0));
                    response.setState((byte) 0);

                    packet.reply(response);

                    ResponseArenaStatusPacket status = new ResponseArenaStatusPacket();

                    status.setGuid(user.getGuid());
                    status.setCName(SmartString.of(user.getUsername(), 32));

                    status.setRoomId(arenaMatch.getSourceGuid());
                    status.setRequest(UnsignedChar.of(101));

                    status.setStatus((byte) 2);
                    packet.reply(status);
                    return;

                }

                List<Integer> fleetIds = new ArrayList<>();

                for(int i = 0; i < packet.getDataLen().getValue(); i++)
                    fleetIds.add(packet.getShips().getArray()[i]);

                if(fleetIds.size() > 60 || fleetIds.size() < 1)
                    return;

                Optional<LoggedGameUser> optionalOwner = LoginService.getInstance().getGame(arenaMatch.getSourceUserId());

                if(optionalOwner.isEmpty())
                    return;

                LoggedGameUser owner = optionalOwner.get();
                arenaMatch.addOpponent(user, fleetIds);

                ResponseEctypeStatePacket response = new ResponseEctypeStatePacket();

                response.setEctypeId(packet.getEctypeId());
                response.setGateId(UnsignedChar.of(0));
                response.setState((byte) 4);

                packet.reply(response);

                ResponseArenaStatusPacket status = new ResponseArenaStatusPacket();

                status.setGuid(user.getGuid());
                status.setCName(SmartString.of(user.getUsername(), 32));

                status.setRoomId(arenaMatch.getSourceGuid());
                status.setRequest(UnsignedChar.of(101));

                status.setStatus((byte) 1);
                packet.reply(status);

                ResponseArenaStatusPacket ownerStatus = new ResponseArenaStatusPacket();

                ownerStatus.setGuid(user.getGuid());
                ownerStatus.setCName(SmartString.of(user.getUsername(), 32));

                ownerStatus.setRoomId(arenaMatch.getSourceGuid());
                ownerStatus.setRequest(UnsignedChar.of(101));

                status.setStatus((byte) 1);
                owner.getSmartServer().send(status);

                // BotLogger.dev("JOINING TO ARENA MATCH: " + arenaMatch);

            }

            return;

        }

        GameInstance gameInstance = ResourceManager.getGameInstance(packet.getEctypeId());

        // * Basic instances
        if(gameInstance != null && gameInstance.isValid()) {

            List<Integer> fleetIds = new ArrayList<>();

            for(int i = 0; i < packet.getDataLen().getValue(); i++)
                fleetIds.add(packet.getShips().getArray()[i]);

            MatchRunnable runnable = BattleService.getInstance().makeInstanceMatch(user, fleetIds, gameInstance);
            if(runnable == null) return;

            Match current = runnable.getMatch();
            loggedGameUser.setMatchViewing(current.getId());

            ResponseEctypeStatePacket response = new ResponseEctypeStatePacket();

            response.setEctypeId((short) 0);
            response.setGateId(UnsignedChar.of(0));
            response.setState((byte) 1);

            packet.reply(response);
            return;

        }

        System.out.println("Not found: " + packet.getEctypeId());

        // ! Debug user
        packet.getSmartServer().sendMessage("Sorry, that instance is not done yet!");

        ResponseEctypeStatePacket response = new ResponseEctypeStatePacket();

        response.setEctypeId((short) 0);
        response.setGateId(UnsignedChar.of(0));
        response.setState((byte) 0);

        packet.reply(response);
        return;

    }
    @PacketProcessor
    public void onEctypeInfo(RequestEctypeInfoPacket packet) throws BadGuidException {

        LoginService.validate(packet, packet.getGuid());

        User user = UserService.getInstance().getUserCache().findByGuid(packet.getGuid());
        if(user == null) return;

        Optional<LoggedGameUser> optionalLoggedGameUser = user.getLoggedGameUser();
        if(optionalLoggedGameUser.isEmpty()) return;

        LoggedGameUser loggedGameUser = optionalLoggedGameUser.get();
        Optional<Match> optionalMatch = BattleService.getInstance().getVirtualViewing(loggedGameUser);;

        if(optionalMatch.isEmpty()) optionalMatch = BattleService.getInstance().getVirtual(user.getGuid());
        if(optionalMatch.isEmpty()) return;

        Match current = optionalMatch.get();

        // Request:
        // 2 - Leave view
        // 1 - Resume Instance
        // 0 - Stop
        if(packet.getRequest() == 0) {

            if(current.getMatchType().isVirtual() && current.getMatchType() == MatchType.INSTANCE_MATCH) {

                // BotLogger.log("Stopping and deleting instance match: " + current.getId());

                for(BattleFleet battleFleet : current.getFleets()) {

                    Fleet fleet = PacketService.getInstance().getFleetCache().findByShipTeamId(battleFleet.getShipTeamId());
                    if(fleet == null) continue;

                    if(fleet.getGuid() == -1)
                        PacketService.getInstance().getFleetCache().delete(fleet);

                    if(fleet.getGuid() == user.getGuid()) {
                        fleet.setGalaxyId(user.getPlanet().getPosition().galaxyId());
                        fleet.save();
                    }

                }

                BattleService.getInstance().stopMatch(current, StopCause.MANUAL);
                return;

            }

        } else if(packet.getRequest() == 1) {

            loggedGameUser.setMatchViewing(current.getId());

            ResponseEctypeStatePacket response = new ResponseEctypeStatePacket();

            // BotLogger.log("EctypeID: " + packet.getEctypeId() + ", PACKET FULL: " + packet);

            response.setEctypeId((short) current.getEctype());
            response.setGateId(UnsignedChar.of(0));
            response.setState((byte) 1);

            packet.reply(response);

        } else if(packet.getRequest() == 2) {

            loggedGameUser.setViewing(user.getGalaxyId());
            loggedGameUser.setMatchViewing(null);

            if(current.getMatchType() == MatchType.ARENA_MATCH) {

                ArenaMatch arenaMatch = (ArenaMatch) current;
                ResponseArenaStatusPacket status = new ResponseArenaStatusPacket();

                status.setGuid(user.getGuid());
                status.setCName(SmartString.of(user.getUsername(), 32));

                status.setRoomId(arenaMatch.getSourceGuid());
                status.setRequest(UnsignedChar.of(6));

                status.setStatus((byte) 1);
                packet.reply(status);

                BotLogger.log(status);

            }

            ResponseEctypeStatePacket ectypeStatePacket = BattleService.getInstance().getCurrentEctypeState(user, 2);
            if(ectypeStatePacket.getEctypeId() != -1 && ectypeStatePacket.getState() != 0) packet.reply(ectypeStatePacket);
            BotLogger.log((int) ectypeStatePacket.getState());
            return;

        }

    }


}
