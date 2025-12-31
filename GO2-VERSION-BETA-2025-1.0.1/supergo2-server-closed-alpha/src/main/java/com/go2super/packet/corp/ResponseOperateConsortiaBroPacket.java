package com.go2super.packet.corp;

import com.go2super.packet.Packet;
import lombok.Data;

@Data
public class ResponseOperateConsortiaBroPacket extends Packet {

    public static final int TYPE = 1568;

    private int consortiaId;
    private int type;
    private int propsCorpsPack;

    private byte job;
    private byte unionLevel;
    private byte shopLevel;
    private byte reserve2;

    private int needUnionValue;
    private int needShopValue;


}
