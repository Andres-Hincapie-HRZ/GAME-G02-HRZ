package com.go2super.service.battle.comparator;

import com.go2super.database.entity.sub.BattleCommander;
import com.go2super.database.entity.sub.BattleElement;
import com.go2super.database.entity.sub.BattleFleet;
import com.go2super.database.entity.type.BattleElementType;

public class IntervalMinDurabilityComparator extends IntervalComparator {

    public IntervalMinDurabilityComparator(BattleFleet attacker) {
        super(attacker);
    }

    @Override
    public int compare(BattleElement element1, BattleElement element2) {

        if(element1.getType() != BattleElementType.FLEET) return 1;
        if(element2.getType() != BattleElementType.FLEET) return -1;

        BattleFleet fleet1 = (BattleFleet) element1;
        BattleFleet fleet2 = (BattleFleet) element2;

        BattleCommander commander1 = fleet1.getBattleCommander();
        BattleCommander commander2 = fleet2.getBattleCommander();

        // todo chips

        double shieldIncrement1 = commander1.getShieldIncrement();
        double shieldIncrement2 = commander2.getShieldIncrement();

        double structureIncrement1 = commander1.getStructureIncrement();
        double structureIncrement2 = commander2.getStructureIncrement();

        double durability1 = (fleet1.getTotalShields() * (1 + shieldIncrement1)) + (fleet1.getTotalStructure() * (1 + structureIncrement1));
        double durability2 = (fleet2.getTotalShields() * (1 + shieldIncrement2)) + (fleet2.getTotalStructure() * (1 + structureIncrement2));

        if(durability1 > durability2) return 1;
        if(durability1 < durability2) return -1;

        return fleet1.compareTo(fleet2);

    }

}
