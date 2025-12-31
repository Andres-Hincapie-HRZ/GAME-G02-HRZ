package com.go2super.listener;

import com.go2super.database.entity.User;
import com.go2super.obj.utility.UnsignedShort;
import com.go2super.packet.PacketListener;
import com.go2super.packet.PacketProcessor;
import com.go2super.packet.fight.RequestWarfieldStatusPacket;
import com.go2super.packet.fight.ResponseWarfieldStatusPacket;
import com.go2super.service.LoginService;
import com.go2super.service.UserService;
import com.go2super.service.exception.BadGuidException;

public class ChampionListener implements PacketListener {

    @PacketProcessor
    public void onStatus(RequestWarfieldStatusPacket packet) throws BadGuidException {

        LoginService.validate(packet, packet.getGuid());

        User user = UserService.getInstance().getUserCache().findByGuid(packet.getGuid());
        if(user == null) return;

        ResponseWarfieldStatusPacket response = new ResponseWarfieldStatusPacket();

        response.setWarfield(0);
        response.setUserNumber(UnsignedShort.of(0));
        response.setStatus((byte) 0);
        response.setMatchLevel((byte) 0);

        packet.reply(response);


    }

}
