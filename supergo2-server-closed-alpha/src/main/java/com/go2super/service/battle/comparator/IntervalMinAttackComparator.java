package com.go2super.service.battle.comparator;

import com.go2super.database.entity.sub.BattleCommander;
import com.go2super.database.entity.sub.BattleElement;
import com.go2super.database.entity.sub.BattleFleet;
import com.go2super.database.entity.type.BattleElementType;

public class IntervalMinAttackComparator extends IntervalComparator {

    public IntervalMinAttackComparator(BattleFleet attacker) {
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

        double powerIncrement1 = commander1.getAttackPowerIncrement();
        double powerIncrement2 = commander2.getAttackPowerIncrement();

        double attackPower1 = fleet1.getAttackPower(true) * (1 + powerIncrement1);
        double attackPower2 = fleet2.getAttackPower(true) * (1 + powerIncrement2);

        if(attackPower1 > attackPower2) return 1;
        if(attackPower1 < attackPower2) return -1;

        return fleet1.compareTo(fleet2);

    }

}
