package com.go2super.listener;

import com.go2super.database.entity.User;
import com.go2super.packet.PacketListener;
import com.go2super.packet.PacketProcessor;
import com.go2super.packet.raids.RequestCaptureStatePacket;
import com.go2super.packet.raids.ResponseCaptureArkInfoPacket;
import com.go2super.packet.raids.ResponseCaptureArkListPacket;
import com.go2super.service.LoginService;
import com.go2super.service.RaidsService;
import com.go2super.service.UserService;
import com.go2super.service.exception.BadGuidException;

public class RaidsListener implements PacketListener {

    @PacketProcessor
    public void onCaptureState(RequestCaptureStatePacket packet) throws BadGuidException {

        LoginService.validate(packet, packet.getGuid());

        User user = UserService.getInstance().getUserCache().findByGuid(packet.getGuid());
        if(user == null) return;
        if(true) return;

        int request = packet.getRequest().getValue();
        System.out.println(request + " | " + packet);

        ResponseCaptureArkInfoPacket captureArkInfoPacket = RaidsService.getInstance().getArkInfoPacket(user);
        ResponseCaptureArkListPacket captureArkListPacket = RaidsService.getInstance().getArkRoomsPacket();

        packet.reply(captureArkListPacket, captureArkInfoPacket);

    }

}
