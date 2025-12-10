package com.go2super.service.battle.comparator;

import com.go2super.database.entity.sub.BattleElement;
import com.go2super.database.entity.sub.BattleFleet;
import com.go2super.database.entity.type.BattleElementType;

public class IntervalBuildingsComparator extends IntervalComparator {

    public IntervalBuildingsComparator(BattleFleet attacker) {
        super(attacker);
    }

    @Override
    public int compare(BattleElement element1, BattleElement element2) {

        if(element1.getType() == BattleElementType.FORTIFICATION) return -1;
        if(element2.getType() == BattleElementType.FORTIFICATION) return 1;

        return 0;

    }

}
