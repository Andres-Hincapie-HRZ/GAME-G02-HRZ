package com.go2super.listener;

import com.go2super.database.entity.User;
import com.go2super.database.entity.sub.BattleFleet;
import com.go2super.database.entity.sub.BattleFort;
import com.go2super.obj.game.BuildInfo;
import com.go2super.obj.game.FightInitBuild;
import com.go2super.obj.game.GalaxyFleetInfo;
import com.go2super.obj.model.LoggedGameUser;
import com.go2super.packet.Packet;
import com.go2super.packet.PacketListener;
import com.go2super.packet.PacketProcessor;
import com.go2super.packet.construction.ResponseBuildInfoPacket;
import com.go2super.packet.fight.ResponseFightBoutBegPacket;
import com.go2super.packet.fight.ResponseFightInitBuildPacket;
import com.go2super.packet.match.RequestMatchInfoPacket;
import com.go2super.packet.match.ResponseMatchInfoPacket;
import com.go2super.packet.ship.ResponseGalaxyShipPacket;
import com.go2super.service.BattleService;
import com.go2super.service.LoginService;
import com.go2super.service.UserService;
import com.go2super.service.battle.Match;
import com.go2super.service.battle.MatchRunnable;
import com.go2super.service.exception.BadGuidException;
import lombok.SneakyThrows;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Optional;

public class MatchListener implements PacketListener {

    @SneakyThrows
    @PacketProcessor
    public void onMatchInfo(RequestMatchInfoPacket packet) throws BadGuidException {

        LoginService.validate(packet, packet.getGuid());

        User user = UserService.getInstance().getUserCache().findByGuid(packet.getGuid());
        if(user == null) return;

        Optional<LoggedGameUser> optionalLoggedGameUser = user.getLoggedGameUser();
        if(optionalLoggedGameUser.isEmpty()) return;

        LoggedGameUser loggedGameUser = optionalLoggedGameUser.get();
        if(loggedGameUser.getMatchViewing() == null) return;

        MatchRunnable matchRunnable = BattleService.getInstance().getRunnable(loggedGameUser.getMatchViewing());
        if(matchRunnable == null) return;

        // Thread.sleep(160L); // todo may this delay fix the client visual bug
        LinkedList<Packet> packets = new LinkedList<>();
        Match current = matchRunnable.getMatch();

        List<BattleFort> battleFortsList = current.getFortsSorted();
        List<BattleFleet> battleFleetList = current.getFleetsSorted();

        ResponseGalaxyShipPacket response = null;

        for(BattleFleet battleFleet : battleFleetList) {

            if(response == null) {

                response = new ResponseGalaxyShipPacket();
                response.setGalaxyId(user.getPlanet().getPosition().galaxyId());
                response.setGalaxyMapId((short) 0);
                response.setFleets(new ArrayList<>());

            } else if(response.getFleets().size() == 189) {

                packets.add(response);
                response = new ResponseGalaxyShipPacket();
                response.setGalaxyId(user.getPlanet().getPosition().galaxyId());
                response.setGalaxyMapId((short) 0);
                response.setFleets(new ArrayList<>());

            }

            GalaxyFleetInfo fleetInfo = GalaxyFleetInfo.builder()
                    .shipTeamId(battleFleet.getShipTeamId())
                    .shipNum(battleFleet.ships())
                    .bodyId((short) battleFleet.getBodyId())
                    .reserve((short) 1)
                    .direction((byte) battleFleet.getDirection())
                    .posX((byte) battleFleet.getPosX())
                    .posY((byte) battleFleet.getPosY())
                    .owner((byte) (user.getGuid() == battleFleet.getGuid() ? 2 : 0)) // 0 = Attacker (Red), 2 = Mine (Magenta), 3 = Defender (Blue)
                    .build();

            response.getFleets().add(fleetInfo);
            response.setDataLen((short) response.getFleets().size());

        }

        if(response != null) packets.add(response);

        ResponseFightInitBuildPacket responseFightInitBuildPacket = null;
        ResponseBuildInfoPacket responseBuildInfoPacket = null;

        for(BattleFort battleFort : battleFortsList) {

            if(responseBuildInfoPacket == null) {
                responseBuildInfoPacket = new ResponseBuildInfoPacket();
                responseBuildInfoPacket.setGalaxyId(user.getPlanet().getPosition().galaxyId());
                responseBuildInfoPacket.setViewFlag((byte) 1);
            } else if(responseBuildInfoPacket.getBuildInfoList().size() == 200) {
                packets.addFirst(responseBuildInfoPacket);
                responseBuildInfoPacket = new ResponseBuildInfoPacket();
                responseBuildInfoPacket.setGalaxyId(user.getPlanet().getPosition().galaxyId());
                responseBuildInfoPacket.setViewFlag((byte) 1);
            }

            if(responseFightInitBuildPacket == null) {
                responseFightInitBuildPacket = new ResponseFightInitBuildPacket();
                responseFightInitBuildPacket.setGalaxyId(user.getPlanet().getPosition().galaxyId());
            } else if(responseFightInitBuildPacket.getFightInitBuilds().size() == 80) {
                packets.addFirst(responseFightInitBuildPacket);
                responseFightInitBuildPacket = new ResponseFightInitBuildPacket();
                responseFightInitBuildPacket.setGalaxyId(user.getPlanet().getPosition().galaxyId());
            }

            BuildInfo buildInfo = new BuildInfo(0, battleFort.getPosX(), battleFort.getPosY(), battleFort.getFortId(), battleFort.getFortType().getDataId(), battleFort.getLevelId());
            FightInitBuild fightInitBuild = new FightInitBuild(battleFort.getMaxHealth(), battleFort.getHealth(), battleFort.getFortId(), (char) 0, (char) 0);

            responseBuildInfoPacket.getBuildInfoList().add(buildInfo);
            responseFightInitBuildPacket.getFightInitBuilds().add(fightInitBuild);

            responseBuildInfoPacket.setDataLen((short) responseBuildInfoPacket.getBuildInfoList().size());
            responseFightInitBuildPacket.setDataLen((short) responseFightInitBuildPacket.getFightInitBuilds().size());

        }

        if(responseBuildInfoPacket != null) packets.addFirst(responseBuildInfoPacket);
        if(responseFightInitBuildPacket != null) packets.addFirst(responseFightInitBuildPacket);

        ResponseFightBoutBegPacket responseFightBoutBegPacket = new ResponseFightBoutBegPacket();
        responseFightBoutBegPacket.setGalaxyMapId(-1);
        responseFightBoutBegPacket.setGalaxyId(-1);
        responseFightBoutBegPacket.setBoutId((short) (current.getRound() < 0 ? 0 : current.getRound()));
        packets.addFirst(responseFightBoutBegPacket);

        ResponseMatchInfoPacket responseMatchInfoPacket = new ResponseMatchInfoPacket();
        packets.addFirst(responseMatchInfoPacket);

        // ? First send MatchInfo
        // ? then BoutBeg
        // ? and then fleets
        user.getLoggedGameUser().get().setMatchViewing(current.getId());
        packet.reply(packets);

    }

}
