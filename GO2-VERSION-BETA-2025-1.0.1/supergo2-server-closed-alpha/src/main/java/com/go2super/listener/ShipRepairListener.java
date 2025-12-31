package com.go2super.listener;

import com.go2super.database.entity.User;
import com.go2super.database.entity.sub.*;

import com.go2super.obj.game.BruiseShipInfo;
import com.go2super.packet.PacketListener;
import com.go2super.packet.PacketProcessor;
import com.go2super.packet.ship.RequestBruiseShipInfoPacket;

import com.go2super.packet.ship.ResponseBruiseShipInfoPacket;
import com.go2super.service.*;
import com.go2super.service.exception.BadGuidException;
import com.go2super.socket.util.DateUtil;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class ShipRepairListener implements PacketListener {

    @PacketProcessor
    public void onCreate(RequestBruiseShipInfoPacket packet) throws BadGuidException {

        LoginService.validate(packet, packet.getGuid());

        User user = UserService.getInstance().getUserCache().findByGuid(packet.getGuid());
        if(user == null) return;

        UserShips userShips = user.getShips();

        FactoryShip repairing = userShips.getRepairFactory();
        List<BruiseShip> bruiseShipList = userShips.getRepair();

        if(bruiseShipList == null) bruiseShipList = new ArrayList<>();
        List<BruiseShipInfo> infos = new ArrayList<>();

        for(BruiseShip bruiseShip : bruiseShipList)
            infos.add(new BruiseShipInfo(bruiseShip.getShipModelId(), bruiseShip.getNum()));

        ResponseBruiseShipInfoPacket response = new ResponseBruiseShipInfoPacket();

        if(repairing == null) {

            response.setShipModelId(-1);
            response.setNum(0);
            response.setNeedTime(0);

        } else {

            Date until = repairing.getUntil();
            int remains = until != null ? DateUtil.remains(until).intValue() : 0;

            response.setShipModelId(repairing.getShipModelId());
            response.setNum(repairing.getNum());
            response.setNeedTime((int) (remains + ((repairing.getNum() - 1)  * repairing.getBuildTime())));

        }

        response.setDeadShipData(infos);
        response.setDataLen(infos.size());

        packet.reply(response);

    }

}
