package com.go2super.service.battle.pathfinder;

import com.go2super.logger.BotLogger;
import lombok.Data;

import java.util.List;

@Data
public class GO2Path implements Comparable<GO2Path> {

    private List<GO2Node> nodes;

    private GO2Node start;
    private GO2Node end;

    private GO2Node objective;
    private GO2Node target;

    public GO2Path(GO2Node start, GO2Node end, GO2Node target, List<GO2Node> nodes) {

        this.nodes = nodes;

        this.start = start;
        this.end = end;
        this.target = target;

    }

    public int turns() {

        int turns = 0;
        GO2Node last = null;

        Boolean alignedX = null;

        for(GO2Node node : nodes)
            if(last == null) {
                last = node;
            } else if(last.getX() == node.getX()) {
                if(alignedX != null && !alignedX) {
                    turns++;
                }
                last = node;
                alignedX = true;
                continue;
            } else if(last.getY() == node.getY()) {
                if(alignedX != null && alignedX) {
                    turns++;
                }
                last = node;
                alignedX = false;
                continue;
            } else {
                last = node;
                turns++;
            }

        return turns;

    }

    @Override
    public int compareTo(GO2Path other) {

        GO2Node lastNode = getEnd();
        GO2Node ccLastNode = other.getEnd();

        boolean lastAlignedX = target.getX() == lastNode.getX();
        boolean lastAlignedY = target.getY() == lastNode.getY();

        boolean ccLastAlignedX = target.getX() == ccLastNode.getX();
        boolean ccLastAlignedY = target.getY() == ccLastNode.getY();

        BotLogger.dev("LastAligned (X: " + lastAlignedX + " Y: " + lastAlignedY + ")");
        BotLogger.dev("CCLastAligned (X: " + ccLastAlignedX + " Y: " + ccLastAlignedY + ")");

        if(lastNode.isInRange() && !ccLastNode.isInRange())
            return -1;

        if(!lastNode.isInRange() && ccLastNode.isInRange())
            return 1;

        BotLogger.dev("IsInRange (Last: " + lastNode.isInRange() + " CC: " + ccLastNode.isInRange() + ")");

        if(lastAlignedX && lastAlignedY)
            return -1;

        if(ccLastAlignedX && ccLastAlignedY)
            return 1;

        if(lastAlignedX && !ccLastAlignedX)
            return -1;

        if(!lastAlignedX && ccLastAlignedX)
            return 1;

        if(lastAlignedY && !ccLastAlignedY)
            return -1;

        if(!lastAlignedY && ccLastAlignedY)
            return 1;

        /*
        if(turns() < other.turns())
            return 1;

        if(turns() > other.turns())
            return -1;


        if(start.getX() == target.getX() && (target.getX() == lastNode.getX() && target.getX() != ccLastNode.getX()))
            return -1;

        if(start.getX() == target.getX() && (target.getX() != lastNode.getX() && target.getX() == ccLastNode.getX()))
            return 1;

        if(start.getY() == target.getY() && (target.getY() == lastNode.getY() && target.getY() != ccLastNode.getY()))
            return -1;

        if(start.getY() == target.getY() && (target.getY() != lastNode.getY() && target.getY() == ccLastNode.getY()))
            return 1;
        */

        /*
        if(lastNode.getY() == start.getY() && ccLastNode.getY() != start.getY())
            return -1;

        if(lastNode.getY() != start.getY() && ccLastNode.getY() == start.getY())
            return 1;

        if(lastNode.getX() == start.getX() && ccLastNode.getX() != start.getX())
            return -1;

        if(lastNode.getX() != start.getX() && ccLastNode.getX() == start.getX())
            return 1;
         */

        //if((end.getDiffX() > other.getEnd().getDiffX()) && (end.getDiffY() > other.getEnd().getDiffY()))
        //    return -1;

        //if((end.getDiffX() < other.getEnd().getDiffX()) && (end.getDiffY() < other.getEnd().getDiffY()))
        //    return 1;

        return 0;

    }

}