package com.go2super.service;

import com.go2super.database.entity.User;
import com.go2super.obj.game.CaptureArk;
import com.go2super.obj.utility.UnsignedChar;
import com.go2super.obj.utility.UnsignedInteger;
import com.go2super.obj.utility.UnsignedShort;
import com.go2super.packet.raids.ResponseCaptureArkInfoPacket;
import com.go2super.packet.raids.ResponseCaptureArkListPacket;
import com.go2super.service.raids.Raid;
import com.go2super.service.raids.RaidStatus;
import lombok.Getter;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Getter
@Service
public class RaidsService {

    private static RaidsService instance;

    private List<Raid> raids;

    public RaidsService() {

        instance = this;

        raids = new ArrayList<>();

        addRooms();

    }

    public ResponseCaptureArkInfoPacket getArkInfoPacket(User user) {

        ResponseCaptureArkInfoPacket captureArkInfoPacket = new ResponseCaptureArkInfoPacket();

        captureArkInfoPacket.setRoomId(UnsignedChar.of(255));
        captureArkInfoPacket.setCountdown(UnsignedShort.of(0));

        captureArkInfoPacket.setCapture(UnsignedChar.of((5 << 4) | 1)); // (max << 4) | current
        captureArkInfoPacket.setSearch(UnsignedChar.of((5 << 4) | 1)); // (max << 4) | current

        // 0 = Can fleet
        // 5 = Hides buttons (can't fleet)
        captureArkInfoPacket.setPlace(UnsignedChar.of(0));

        // 0 = Ends in
        // 1 = Starts in
        // 2 = In progress
        captureArkInfoPacket.setSpareType(UnsignedChar.of(2));
        captureArkInfoPacket.setSpareTime(UnsignedInteger.of(60 * 20));

        return captureArkInfoPacket;

    }

    public ResponseCaptureArkListPacket getArkRoomsPacket() {

        ResponseCaptureArkListPacket captureArkListPacket = new ResponseCaptureArkListPacket();

        captureArkListPacket.setCaptureFleets(UnsignedChar.of(4));
        captureArkListPacket.setSearchFleets(UnsignedChar.of(3));
        captureArkListPacket.setReserve(UnsignedChar.of(0));

        // 0 = None
        // 1 = Right
        // 2 = Left
        // 3 = Both (time freeze)
        // 4 = Both - Intercept Button (time freeze)
        CaptureArk captureArk = new CaptureArk(4417, 4413, 60, 1, 0);

        captureArkListPacket.setRooms(Arrays.asList(captureArk));
        captureArkListPacket.setDataLen(UnsignedChar.of(captureArkListPacket.getRooms().size()));

        return captureArkListPacket;

    }

    private void addRooms() {

        for(int i = 0; i < 5; i++) {

            Raid raid = new Raid();

            raid.setStatus(RaidStatus.WAITING);

            raid.setFirstGuid(-1);
            raid.setSecondGuid(-1);

            raid.setFirstPropId(-1);
            raid.setSecondPropId(-1);

            raid.setTime(-1);
            raids.add(raid);

        }

    }

    public static RaidsService getInstance() {
        return instance;
    }

}
