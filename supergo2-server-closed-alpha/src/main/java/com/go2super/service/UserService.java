package com.go2super.service;

import com.go2super.database.cache.UserCache;
import com.go2super.database.entity.Corp;
import com.go2super.database.entity.GameBoost;
import com.go2super.database.entity.User;
import com.go2super.database.entity.sub.*;
import com.go2super.database.repository.GameBoostRepository;
import com.go2super.obj.game.BuildInfo;
import com.go2super.obj.game.ShipTeamNum;
import com.go2super.obj.game.TimeQueue;
import com.go2super.obj.type.BonusType;
import com.go2super.obj.utility.WarehouseCapacity;
import com.go2super.packet.mall.ResponseBuyGoodsPacket;
import com.go2super.packet.props.ResponseTimeQueuePacket;
import com.go2super.resources.data.PropData;
import com.go2super.resources.data.meta.BuildEffectMeta;
import com.go2super.resources.data.meta.BuildLevelMeta;
import com.go2super.resources.data.props.PropMallData;
import com.go2super.socket.util.DateUtil;
import lombok.Getter;
import org.apache.commons.lang3.tuple.Pair;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

@Service
public class UserService {

    private static UserService userService;

    @Autowired
    @Getter
    private GameBoostRepository boostRepository;

    @Getter private UserCache userCache;

    @Autowired
    public UserService(UserCache userCache) {

        userService = this;
        this.userCache = userCache;

        /*for(User user : userCache.findAll()) {
            boolean alphanumeric = StringUtils.isAlphanumeric(user.getUsername());
            if(!alphanumeric) BotLogger.info(user.getUsername() + ":" + user.getGuid() + ":" + alphanumeric);
        }*/

        // System.out.println("User Service Initialized");

        // for(User user : userCache.findAll()) {

            /*Collections.sort(user.getShipUpgrades().currentBodies);
            Collections.sort(user.getShipUpgrades().currentParts);

            Set<Integer> toRemoveBodies = new HashSet<>();
            Set<Integer> toRemoveParts = new HashSet<>();

            if(user.getShipUpgrades().getPartUpgrade() != null) {
                ShipUpgrade shipUpgrade = user.getShipUpgrades().getPartUpgrade();
                if(!user.getShipUpgrades().currentParts.contains(shipUpgrade.getUpgradeId())) {
                    System.out.println("Cancelling upgrade of " + user.getUsername() + " (ID:" + user.getGuid() + ") part " + shipUpgrade.getUpgradeId());
                    user.getShipUpgrades().setPartUpgrade(null);
                    user.save();
                }
            }

            if(user.getShipUpgrades().getShipUpgrade() != null) {
                ShipUpgrade shipUpgrade = user.getShipUpgrades().getShipUpgrade();
                if(!user.getShipUpgrades().currentBodies.contains(shipUpgrade.getUpgradeId())) {
                    System.out.println("Cancelling upgrade of " + user.getUsername() + " (ID:" + user.getGuid() + ") hull " + shipUpgrade.getUpgradeId());
                    user.getShipUpgrades().setShipUpgrade(null);
                    user.save();
                }
            }*/

            /*

            bodies : for(int body : user.getShipUpgrades().currentBodies) {
                PropBodyData bodyData = ResourceManager.getShipBodies().findByBodyId(body).getPropData();
                if(bodyData == null) continue;
                if(bodyData.getRequirement() == null) continue;
                if(!bodyData.canUse(user.getShipUpgrades().currentBodies)) {
                    toRemoveBodies.add(body);
                }
            }

            parts : for(int part : user.getShipUpgrades().currentParts) {
                PropPartData partData = ResourceManager.getShipParts().findByPartId(part).getPropData();
                if(partData == null) continue;
                if(partData.getRequirement() == null) continue;
                if(!partData.canUse(user.getShipUpgrades().currentParts)) {
                    toRemoveParts.add(part);
                }
            }

            if(toRemoveBodies.size() > 0 || toRemoveParts.size() > 0) {
                System.out.println("User: " + user.getUsername() + " - (ID: " + user.getGuid() + ")");
                System.out.println("ToRemoveBody: " + toRemoveBodies);
                System.out.println("ToRemovePart: " + toRemoveParts);
                user.getShipUpgrades().currentBodies.removeAll(toRemoveBodies);
                user.getShipUpgrades().currentParts.removeAll(toRemoveParts);
                user.save();
                System.out.println("User Saved!");
                System.out.println("-------------------");
            }*/

        // }

        // System.out.println("ShipModel Service Initialized");

        /*
        for(ShipModel model : PacketService.getInstance().getShipModelCache().findAll()) {

            if(model.getGuid() == -1) continue;

            List<PartLevelMeta> parts = model.getPartsMeta();
            BodyLevelMeta body = model.getBodyLevelMeta();

            User user = UserService.getInstance().getUserCache().findByGuid(model.getGuid());
            if(user == null) continue;

            boolean changed = false;

            List<Integer> oldParts = new ArrayList<>(model.getParts());
            int oldBody = model.getBodyId();

            if(!user.getShipUpgrades().hasBodyUpgrade(body.getId())) {
                model.setBodyId(0);
                changed = true;
            }

            for(PartLevelMeta part : parts)
                if(!user.getShipUpgrades().hasPartUpgrade(part.getId())) {
                    model.getParts().remove(Integer.valueOf(part.getId()));
                    changed = true;
                }

            PacketService.getInstance().getShipModelCache().save(model);

            if(changed) {
                System.out.println("ModelID: " + model.getShipModelId() + " by User: " + user.getUsername() + " - (ID: " + user.getGuid() + ")");
                System.out.println("OldBody: " + oldBody);
                System.out.println("OldParts: " + oldParts);
                System.out.println("NewBody: " + model.getBodyId());
                System.out.println("NewParts: " + model.getParts());
                System.out.println("Changed!");
                System.out.println("-------------------");
            }

        }*/

    }

    public ResponseTimeQueuePacket getUserQueues(User user) {

        ResponseTimeQueuePacket timeQueuePacket = new ResponseTimeQueuePacket();
        LinkedList<TimeQueue> queues = new LinkedList<>();

        List<Pair<UserBoost, GameBoost>> deBuffs = new ArrayList<>();

        for(UserBoost userBoost : user.getStats().getBuffs()) {

            if(queues.size() >= 10)
                break;

            if(userBoost.getUntil().getTime() < DateUtil.now().getTime())
                continue;

            Optional<GameBoost> optional = boostRepository.findById(userBoost.getGameBoostId());

            if(optional.isPresent()) {

                GameBoost boost = optional.get();

                if(boost.getPropId() == -1) {
                    deBuffs.add(Pair.of(userBoost, boost));
                    continue;
                }

                if(boost.getSeconds() > 0)
                    queues.add(new TimeQueue(boost.getMimeType(), userBoost.getSeconds()));

            }

        }

        for(Pair<UserBoost, GameBoost> deBuff : deBuffs)
            if(queues.size() < 10)
                queues.addFirst(new TimeQueue(deBuff.getValue().getMimeType(), deBuff.getKey().getSeconds()));

        timeQueuePacket.setDataLen(queues.size());
        timeQueuePacket.setTimeQueues(queues);

        while(timeQueuePacket.getTimeQueues().size() < 10)
            timeQueuePacket.getTimeQueues().add(TimeQueue.generate());


        return timeQueuePacket;

    }

    public void updateResources(User user) {

        user.getResources().refresh();

    }

    public void updateEmails(User user) {

        UserEmailStorage emailStorage = user.getUserEmailStorage();
        List<Email> sortedEmails = emailStorage.getSortedEmails();

        if(sortedEmails.size() > 50) {
            sortedEmails = sortedEmails.stream().limit(50).collect(Collectors.toList());
            emailStorage.setUserEmails(sortedEmails);
        }

    }

    public void updateShips(User user) {

        UserShips userShips = user.getShips();
        List<ShipTeamNum> teamNums = new ArrayList<>(userShips.getShips());

        for(ShipTeamNum teamNum : teamNums)
            if(teamNum.getNum() <= 0) userShips.getShips().remove(teamNum);

    }

    public void updateStats(User user) {

        Date lastCalculus = user.getStorage().getLastProductionCalculus();
        int seconds = DateUtil.seconds(lastCalculus).intValue();

        List<UserBoost> expiredBoosts = getExpiredBoosts(user);

        for(UserBoost expired : expiredBoosts) {

            updateStorage(user, lastCalculus, expired.getUntil());

            calculateProductivity(user);
            lastCalculus = expired.getUntil();
            user.getStats().removeBoost(expired);

        }

        Date now = DateUtil.now();
        updateStorage(user, lastCalculus, now);

        calculateProductivity(user);
        user.getStorage().setLastProductionCalculus(now);
        userCache.save(user);

    }

    public void updateStorage(User user, Date from, Date to) {

        WarehouseCapacity maximumStorage = getMaxWarehouseStorage(user);

        double goldProduction = user.getStorage().getGoldProduction();
        double he3Production = user.getStorage().getHe3Production();
        double metalProduction = user.getStorage().getMetalProduction();

        double time = Long.valueOf(TimeUnit.MILLISECONDS.toSeconds(to.getTime() - from.getTime())).intValue();

        int totalGoldProduction = (int) ((goldProduction / 3600) * time);
        int totalHe3Production = (int) ((he3Production / 3600)  * time);
        int totalMetalProduction = (int) ((metalProduction / 3600)  * time);

        user.getStorage().addGold(totalGoldProduction, maximumStorage.getGoldCapacity());
        user.getStorage().addHe3(totalHe3Production, maximumStorage.getHe3Capacity());
        user.getStorage().addMetal(totalMetalProduction, maximumStorage.getMetalCapacity());

    }

    public List<UserBoost> getExpiredBoosts(User user) {

        if(user.getStats().getBuffs() == null)
            user.getStats().setBuffs(new ArrayList<>());

        Date now = DateUtil.now();
        List<UserBoost> boosts = user.getStats().getBuffs().stream().filter(boost -> boost.getUntil().before(now)).collect(Collectors.toList());

        Collections.sort(boosts, (UserBoost ub1, UserBoost ub2) -> ub1.getUntil().after(ub2.getUntil()) ? 1 : 0);
        return boosts;

    }

    public List<BuildInfo> getBuilds(ResourcePlanet resourcePlanet) {

        List<BuildInfo> buildInfos = new ArrayList<>();
        boolean save = false;

        for(RBPBuilding rbpBuilding : resourcePlanet.getRbpBuildings().getBuildings()) {

            Long spareTime = Long.valueOf(0);

            Long repairingTime = rbpBuilding.repairingTime();
            Long updatingTime = rbpBuilding.updatingTime();

            if(rbpBuilding.getRepairing() != null)
                if(rbpBuilding.getRepairing() && repairingTime <= 0) {

                    save = true;

                    rbpBuilding.setRepairing(false);
                    rbpBuilding.setUntilRepair(null);

                } else {

                    spareTime = repairingTime;

                }

            if(rbpBuilding.getUpdating() != null)
                if(rbpBuilding.getUpdating() && updatingTime <= 0) {

                    save = true;

                    rbpBuilding.setLevelId(rbpBuilding.getLevelId() + 1);
                    rbpBuilding.setUpdating(false);
                    rbpBuilding.setUntilUpdate(null);

                } else if(rbpBuilding.getUpdating()){

                    spareTime = updatingTime;

                }

            buildInfos.add(rbpBuilding.getInfo(spareTime.intValue()));

        }

        return buildInfos;

    }

    public List<BuildInfo> getBuilds(User user) {

        List<BuildInfo> buildInfos = new ArrayList<>();
        boolean save = false;

        for(UserBuilding userBuilding : user.getBuildings().getBuildings()) {

            Long spareTime = Long.valueOf(0);

            Long repairingTime = userBuilding.repairingTime();
            Long updatingTime = userBuilding.updatingTime();

            if(userBuilding.getRepairing() != null)
                if(userBuilding.getRepairing() && repairingTime <= 0) {

                    save = true;

                    userBuilding.setRepairing(false);
                    userBuilding.setUntilRepair(null);

                } else {

                    spareTime = repairingTime;

                }

            if(userBuilding.getUpdating() != null)
                if(userBuilding.getUpdating() && updatingTime <= 0) {

                    save = true;

                    userBuilding.setLevelId(userBuilding.getLevelId() + 1);
                    userBuilding.setUpdating(false);
                    userBuilding.setUntilUpdate(null);

                } else if(userBuilding.getUpdating()){

                    spareTime = updatingTime;

                }

            buildInfos.add(userBuilding.getInfo(spareTime.intValue()));

        }

        if(save) user.save();
        return buildInfos;

    }

    public List<BuildInfo> getTerrainBuilds(User user) {

        List<BuildInfo> buildInfos = new ArrayList<>();
        boolean save = false;

        for(UserBuilding userBuilding : user.getBuildings().getBuildings()) {

            if(!userBuilding.getData().getType().equals("land")) continue;

            Long spareTime = Long.valueOf(0);

            Long repairingTime = userBuilding.repairingTime();
            Long updatingTime = userBuilding.updatingTime();

            if(userBuilding.getRepairing() != null)
                if(userBuilding.getRepairing() && repairingTime <= 0) {

                    save = true;

                    userBuilding.setRepairing(false);
                    userBuilding.setUntilRepair(null);

                } else {

                    spareTime = repairingTime;

                }

            if(userBuilding.getUpdating() != null)
                if(userBuilding.getUpdating() && updatingTime <= 0) {

                    save = true;

                    userBuilding.setLevelId(userBuilding.getLevelId() + 1);
                    userBuilding.setUpdating(false);
                    userBuilding.setUntilUpdate(null);

                } else if(userBuilding.getUpdating()){

                    spareTime = updatingTime;

                }

            buildInfos.add(userBuilding.getInfo(spareTime.intValue()));

        }

        if(save) user.save();
        return buildInfos;

    }

    public WarehouseCapacity getMaxWarehouseStorage(User user) {

        UserBuildings buildings = user.getBuildings();
        UserBuilding building = buildings.getBuilding("build:resourceStorage");

        if(building == null)
            return WarehouseCapacity.builder().build();

        UserTechs techs = user.getTechs();

        int goldCapacity = 0;
        int he3Capacity = 0;
        int metalCapacity = 0;

        UserTech expandCapacity = techs.getTech("science:expand.capacity");

        if(expandCapacity != null) {

            goldCapacity += expandCapacity.getEffect("increase.metal.capacity").getValue();
            he3Capacity += expandCapacity.getEffect("increase.he3.capacity").getValue();
            metalCapacity += expandCapacity.getEffect("increase.metal.capacity").getValue();

        }

        BuildLevelMeta meta = building.getLevelData();
        BuildEffectMeta effect = meta.getEffect("storage");

        int maximumStorage = (int) effect.getValue();
        return WarehouseCapacity.builder()
                .goldCapacity(maximumStorage + goldCapacity)
                .he3Capacity(maximumStorage + he3Capacity)
                .metalCapacity(maximumStorage + metalCapacity)
                .build();

    }

    public void calculateProductivity(User user) {

        int gainGold = user.getBuildings().getGoldGain();
        int gainHe3 = user.getBuildings().getHe3Gain();
        int gainMetal = user.getBuildings().getMetalGain();

        double goldBonus = user.getBuildings().getGoldBonus();
        double he3Bonus = user.getBuildings().getHe3Bonus();
        double metalBonus = user.getBuildings().getMetalBonus();

        UserTechs techs = user.getTechs();

        UserTech yieldMining = techs.getTech("science:high.yield.mining");
        if (yieldMining != null) metalBonus += yieldMining.getEffect("increase.metal.output").getValue() * 0.01;

        UserTech yieldChemistry = techs.getTech("science:high.yield.chemistry");
        if (yieldChemistry != null) he3Bonus += yieldChemistry.getEffect("increase.he3.output").getValue() * 0.01;

        UserTech yieldInvesting = techs.getTech("science:high.yield.investing");
        if (yieldInvesting != null) goldBonus += yieldInvesting.getEffect("increase.gold.output").getValue() * 0.01;

        List<UserBoost> boosts = user.getStats().getBuffs();

        for (UserBoost userBoost : boosts) {

            Optional<GameBoost> optionalGameBoost = userBoost.getGameBoost();

            if (optionalGameBoost.isEmpty())
                continue;

            GameBoost boost = optionalGameBoost.get();

            for (BonusType bonusType : boost.getBonuses()) {
                switch (bonusType) {
                    case BASIC_GOLD_RESOURCE_PRODUCTION:
                    case LUXURIOUS_GOLD_RESOURCE_PRODUCTION:
                    case ADVANCED_GOLD_RESOURCE_PRODUCTION:
                        goldBonus += bonusType.delta();
                        continue;
                    case BASIC_METAL_RESOURCE_PRODUCTION:
                    case METALLIC_METAL_RESOURCE_PRODUCTION:
                        metalBonus += bonusType.delta();
                        continue;
                    case BASIC_HE3_RESOURCE_PRODUCTION:
                    case GASEOUS_HE3_RESOURCE_PRODUCTION:
                        he3Bonus += bonusType.delta();
                        continue;
                    case GF_RESOURCE_PRODUCTION:
                    case MVP_RESOURCE_PRODUCTION:
                    case CHRISTMAS_RESOURCE_PRODUCTION:
                    case HALLOWEEN_RESOURCE_PRODUCTION:
                        goldBonus += bonusType.delta();
                        metalBonus += bonusType.delta();
                        he3Bonus += bonusType.delta();
                        continue;
                }
            }

        }

        Corp userCorp = CorpService.getInstance().getCorpCache().findByGuid(user.getGuid());

        if(userCorp != null) {

            double corpBonus = user.getCorp().getResourceBonus();

            goldBonus += corpBonus;
            metalBonus += corpBonus;
            he3Bonus += corpBonus;

            goldBonus += userCorp.getRBPBonus();
            metalBonus += userCorp.getRBPBonus();
            he3Bonus += userCorp.getRBPBonus();

        }

        int productionGold = (int) (gainGold * (1 + goldBonus));
        int productionMetal = (int) (gainMetal * (1 + metalBonus));
        int productionHe3 = (int) (gainHe3 * (1 + he3Bonus));

        user.getStorage().setGoldProduction(productionGold);
        user.getStorage().setMetalProduction(productionMetal);
        user.getStorage().setHe3Production(productionHe3);

    }

    public ResponseBuyGoodsPacket getBuyGoodsPacket(PropData good, PropMallData method, int lockFlag, int quantity, int price) {

        ResponseBuyGoodsPacket response = new ResponseBuyGoodsPacket();

        response.setPropsId(good.getId());
        response.setPrice(price);
        response.setLockFlag((byte) lockFlag);
        response.setNum(quantity);
        response.setCurrency((byte) method.currencyCode());

        return response;

    }

    public static UserService getInstance() {
        return userService;
    }

}
