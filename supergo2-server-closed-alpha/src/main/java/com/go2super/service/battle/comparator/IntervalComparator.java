package com.go2super.service.battle.comparator;

import com.go2super.database.entity.sub.BattleElement;
import com.go2super.database.entity.sub.BattleFleet;
import lombok.Getter;

import javax.annotation.processing.Generated;
import java.util.Comparator;

@Getter
public abstract class IntervalComparator implements Comparator<BattleElement> {

    private BattleFleet attacker;

    public IntervalComparator(BattleFleet attacker) {
        this.attacker = attacker;
    }

}
