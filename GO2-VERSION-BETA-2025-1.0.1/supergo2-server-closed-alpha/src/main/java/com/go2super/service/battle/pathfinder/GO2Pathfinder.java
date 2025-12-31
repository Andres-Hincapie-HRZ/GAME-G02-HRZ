package com.go2super.service.battle.pathfinder;

import com.go2super.logger.BotLogger;
import com.go2super.service.battle.type.Target;

import java.util.*;

public class GO2Pathfinder {

    private GO2Node start;
    private GO2Node target;

    private int[][] blocks;

    private int minRange;
    private int maxRange;
    private int idealRange;

    private int movement;

    public GO2Pathfinder(GO2Node start, GO2Node target, int[][] blocks, int minRange, int maxRange, int movement, Target config) {

        this.start = start;
        this.target = target;
        this.blocks = blocks;
        this.minRange = minRange;
        this.maxRange = maxRange;
        this.movement = movement;

        this.idealRange = config == Target.MIN_RANGE ? minRange : maxRange;

    }

    public GO2Path findBestPath() {

        List<GO2Path> paths = findPaths();

        if(paths == null || paths.isEmpty())
            return null;

        if(paths.size() == 1)
            return paths.get(0);

        BotLogger.dev("Start: " + start);
        BotLogger.dev("Target: " + target);
        BotLogger.dev("Min Range: " + minRange + " Max Range: " + maxRange + " Ideal Range: " + idealRange);

        Collections.sort(paths);
        return paths.get(0);

    }

    public GO2Path findPath() {

        List<GO2Path> paths = findPaths();

        if(paths == null || paths.isEmpty())
            return null;

        return paths.get(0);

    }

    public List<GO2Path> findPaths() {

        List<GO2Path> paths = new ArrayList<>();

        List<GO2Node> possibilities = possibilities();
        Collections.sort(possibilities);

        GO2Node current = null;

        for(int nodeIndex = 0; nodeIndex < possibilities.size(); nodeIndex++) {

            GO2Node possible = possibilities.get(nodeIndex);
            possible.setIndex(nodeIndex);

            if(possible.getX() == start.getX() && possible.getY() == start.getY())
                break;

            List<GO2Node> possiblePath = isAccessible(possible);

            if(possiblePath.isEmpty())
                continue;

            while(possiblePath.size() > movement + 1)
                possiblePath.remove(possiblePath.size() - 1);

            // Remove first because is
            // same as start
            possiblePath.remove(0);

            if(possiblePath.isEmpty())
                continue;

            // Turn the node into an accessible list
            possible.setAccessible(true);

            if(current == null) {

                current = possible;
                paths.add(new GO2Path(start, possible, target, possiblePath));
                continue;

            }

            if(current.getDistance() < possible.getDistance())
                break;

            current = possible;
            paths.add(new GO2Path(start, possible, target, possiblePath));

        }

        // Collections.sort(paths);

        BotLogger.log("Found " + paths.size() + " paths in total!");

        if(paths.isEmpty())
            return null;

        return paths;

    }

    public List<GO2Node> isAccessible(GO2Node go2Node) {

        GO2AStar aStar = new GO2AStar(25, 25, start, go2Node, 0);
        aStar.setBlocks(blocks);

        return aStar.findPath();

    }

    public static void main(String...args) {

        GO2Node startNode = new GO2Node(6, 11);
        // GO2Node targetNode = new GO2Node(16, 5);
        GO2Node targetNode = new GO2Node(10, 10);
        // GO2Node targetNode = new GO2Node(0, 0);

        int[][] blocks = new int[1][2];
        blocks[0] = new int[]{12, 8};

        GO2Pathfinder go2Pathfinder = new GO2Pathfinder(startNode, targetNode, blocks, 5, 8, 6, Target.MAX_RANGE);
        List<GO2Node> possibilities = go2Pathfinder.possibilities();

        long before = new Date().getTime();

        Collections.sort(possibilities);

        GO2Path path = go2Pathfinder.findPath();
        long after = new Date().getTime();
        BotLogger.log(after - before + "ms");
        BotLogger.log(path);

        boolean printpath = true;

        for(int i = 0; i < 25; i++) {
            kloop: for (int j = 0; j < 25; j++) {

                if (i == go2Pathfinder.start.getX() && j == go2Pathfinder.start.getY()) {
                    System.out.print("FFF ");
                    continue;
                }

                if (i == go2Pathfinder.target.getX() && j == go2Pathfinder.target.getY()) {
                    System.out.print("TTT ");
                    continue;
                }

                if(printpath)
                    for(GO2Node part : path.getNodes()) {
                        if (part.getX() == i && part.getY() == j) {
                            System.out.print("~~~ ");
                            continue kloop;
                        }
                    }

                for (GO2Node node : possibilities)
                    if (node.getX() == i && node.getY() == j) {
                        System.out.print(String.format("%03d ", possibilities.indexOf(node)));
                        // System.out.print("... ");
                        continue kloop;
                    }

                System.out.print("... ");

            }
            BotLogger.log();
        }

    }

    public List<GO2Node> possibilities() {

        List<GO2Node> result = new ArrayList<>();

        int startX = start.getX();
        int startY = start.getY();

        for(int i = 0; i < 25; i++)
            for(int j = 0; j < 25; j++) {

                GO2Node node = new GO2Node(i, j);

                node.setDistance(Math.abs(node.getX() - target.getX()) + Math.abs(node.getY() - target.getY()));
                node.setOriginDistance(Math.abs(node.getX() - start.getX()) + Math.abs(node.getY() - start.getY()));
                node.setInRange(node.getDistance() >= minRange && node.getDistance() <= maxRange);
                node.setNeedTurn((node.getX() != startX && node.getY() == startY) || (node.getX() == startX && node.getY() != startY));
                node.setIdeal(node.getDistance() == idealRange);

                // System.out.println("Distance: " + node.getDistance() + ", " + minRange + ", " + maxRange);

                node.setHeuristic(Math.sqrt((target.getX() - node.getX()) * (target.getX() - node.getX()) + (target.getY() - node.getY()) * (target.getY() - node.getY())));
                node.setDiffX(Math.abs(node.getX() - target.getX()));
                node.setDiffY(Math.abs(node.getY() - target.getY()));

                result.add(node);

            }

        return result;

    }

}