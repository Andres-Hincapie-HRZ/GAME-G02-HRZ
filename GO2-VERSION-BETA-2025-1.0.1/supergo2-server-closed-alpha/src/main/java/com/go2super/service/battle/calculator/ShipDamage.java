package com.go2super.service.battle.calculator;

import com.go2super.service.battle.module.BattleFleetAttackModule;
import com.go2super.socket.util.RandomUtil;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ShipDamage {

    private List<BattleFleetAttackModule> attackModules = new ArrayList<>();

    private double hitChance;
    private double hits;

    private double minDamage;
    private double maxDamage;

    public boolean isReload(int round) {
        for(BattleFleetAttackModule module : attackModules)
            if(module.getReload() >= round + 1)
                return false;
        return true;
    }

    public void shoot(int round) {
        for(BattleFleetAttackModule module : attackModules)
            module.setLastShoot(round);
    }

    public void addUsage(ShipUsage usage, double hitChance) {
        for(BattleFleetAttackModule module : attackModules)
            usage.add(module, hitChance, 0);
    }

    public double getFuelUsage(int effectiveStack) {
        return (getReference().getFuelUsage() * (double) attackModules.size()) * (double) effectiveStack;
    }

    public double getSteering() {
        return getReference().getSteering();
    }

    public void calculate(int effectiveStack) {
        hitChance = getReference().getHitRate();
        hits = attackModules.size() * effectiveStack;
    }

    public int currentDamage(int effectiveStack) {
        return RandomUtil.getRandomInt((int) minDamage, (int) maxDamage) * effectiveStack;
    }

    public BattleFleetAttackModule getReference() {
        return attackModules.iterator().next();
    }

    public void add(BattleFleetAttackModule attackModule) {

        minDamage += attackModule.getMinRange();
        maxDamage += attackModule.getMaxRange();

        attackModules.add(attackModule);

    }

}
