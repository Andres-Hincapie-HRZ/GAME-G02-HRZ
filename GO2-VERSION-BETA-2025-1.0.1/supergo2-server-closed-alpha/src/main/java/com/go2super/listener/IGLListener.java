package com.go2super.listener;

import com.go2super.database.entity.User;
import com.go2super.obj.utility.UnsignedChar;
import com.go2super.obj.utility.UnsignedInteger;
import com.go2super.obj.utility.WideString;
import com.go2super.packet.PacketListener;
import com.go2super.packet.PacketProcessor;
import com.go2super.packet.custom.CustomWarScorePacket;
import com.go2super.packet.custom.CustomWarnPacket;
import com.go2super.packet.igl.*;
import com.go2super.service.LoginService;
import com.go2super.service.UserService;
import com.go2super.service.exception.BadGuidException;

import java.util.ArrayList;

public class IGLListener implements PacketListener {

    @PacketProcessor
    public void onClaim(RequestRacingAwardPacket packet) throws BadGuidException {

        LoginService.validate(packet, packet.getGuid());

        User user = UserService.getInstance().getUserCache().findByGuid(packet.getGuid());
        if(user == null) return;

        if(user.getStats().isCollectedPoints()) return;

        user.getStats().setCollectedPoints(true);
        user.getResources().setChampionPoints(user.getResources().getChampionPoints() + 100);

        user.update();
        user.save();

        CustomWarnPacket popup = new CustomWarnPacket();

        popup.setName(WideString.of(user.getUsername(), 32));
        popup.setToName(WideString.of(user.getUsername(), 32));
        popup.setBuffer(WideString.of("Collected 1150 champion points!", 1024));

        ResponseRacingAwardPacket response = new ResponseRacingAwardPacket();
        response.setAmount(UnsignedInteger.of(0));

        CustomWarScorePacket warScore = new CustomWarScorePacket();
        warScore.setPoints(Long.valueOf(user.getResources().getChampionPoints()).intValue());

        packet.reply(response, popup, warScore);

    }

    @PacketProcessor
    public void onInformation(RequestRacingInformationPacket packet) throws BadGuidException {

        LoginService.validate(packet, packet.getGuid());

        User user = UserService.getInstance().getUserCache().findByGuid(packet.getGuid());
        if(user == null) return;

        ResponseRacingInformationPacket response = new ResponseRacingInformationPacket();

        response.setRankId(UnsignedInteger.of(0));
        response.setRewardValue(0);
        response.setRacingNum(UnsignedChar.of(15));
        response.setRacingRewardFlag((byte) (user.getStats().isCollectedPoints() ? 1 : 0));

        response.setEnemyLen(UnsignedChar.of(0));
        response.setReportLen(UnsignedChar.of(0));

        response.setUserId(user.getUserId());

        response.setEnemyInfo(new ArrayList<>());
        response.setReportInfo(new ArrayList<>());

        ResponseRacingShipTeamInfoPacket shipResponse = new ResponseRacingShipTeamInfoPacket();

        shipResponse.setKind((byte) 0);
        shipResponse.setDataLen((byte) 0);
        shipResponse.setShipTeamInfos(new ArrayList<>());

        packet.reply(response, shipResponse);

    }

}
