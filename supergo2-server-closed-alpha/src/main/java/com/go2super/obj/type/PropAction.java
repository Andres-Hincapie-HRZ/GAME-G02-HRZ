package com.go2super.obj.type;

import com.go2super.database.entity.Commander;
import com.go2super.database.entity.Fleet;
import com.go2super.database.entity.GameBoost;
import com.go2super.database.entity.Planet;
import com.go2super.database.entity.sub.*;
import com.go2super.logger.BotLogger;
import com.go2super.obj.game.MapArea;
import com.go2super.obj.model.LoggedGameUser;
import com.go2super.obj.utility.GalaxyTile;
import com.go2super.obj.utility.PropConsumption;
import com.go2super.obj.utility.SmartString;
import com.go2super.packet.Packet;
import com.go2super.packet.map.ResponseMapAreaPacket;
import com.go2super.packet.planet.ResponseMoveHomeBroPacket;
import com.go2super.packet.planet.ResponseMoveHomePacket;
import com.go2super.packet.props.ResponseUsePropsPacket;
import com.go2super.resources.ResourceManager;
import com.go2super.resources.data.CommanderStatsData;
import com.go2super.resources.data.PropData;
import com.go2super.resources.data.ShipBodyData;
import com.go2super.resources.data.ShipPartData;
import com.go2super.resources.data.meta.BodyLevelMeta;
import com.go2super.resources.data.meta.PartLevelMeta;
import com.go2super.resources.data.props.*;
import com.go2super.service.*;
import com.go2super.service.jobs.other.DefendJob;
import com.go2super.socket.util.RandomUtil;
import lombok.Getter;
import org.apache.commons.lang3.tuple.Pair;

import java.util.*;
import java.util.stream.IntStream;
import java.util.stream.Stream;

@Getter
public enum PropAction {

    BASIC_BOOSTERS(array(905, 906, 907, 900, 930, 943), ((prop, quantity, lock, packet, user) -> {

        GameBoost boost = ResourcesService.getInstance().getBoostRepository().findByPropId(prop.getPropId());

        if(boost == null) throw new IllegalArgumentException("Basic booster " + prop.getPropId() + " not found!");

        // MVP Tool
        if(boost.getBonuses().contains(BonusType.MVP_DAILY_DRAWS_BONUS) && !user.getStats().hasBonus(BonusType.MVP_DAILY_DRAWS_BONUS))
            user.getResources().setFreeSpins(user.getResources().getFreeSpins() + 2);

        user.getStats().addBonusTime(boost, quantity * boost.getSeconds());

        ResponseUsePropsPacket response = ResourcesService.getInstance().genericUseProps(boost.getPropId(), quantity, lock ? 1 : 0, 1);
        if(prop.getPropId() == 900) user.getMetrics().add("action:use.construction.card", 1);

        user.update();
        user.save();

        packet.reply(response);
        packet.reply(user.getQueuesAsPacket());
        return true;

    })),

    PLANET_BOOSTERS(array(979, 4458, 4513, 939, 940, 941, 942), ((prop, quantity, lock, packet, user) -> {

        GameBoost boost = ResourcesService.getInstance().getBoostRepository().findByPropId(prop.getPropId());
        if(boost == null) throw new IllegalArgumentException("Planet booster " + prop.getPropId() + " not found!");

        List<UserBoost> toRemove = new ArrayList<>();

        for(UserBoost userBoost : user.getStats().getBuffs())
            if(!userBoost.getGameBoostId().equals(boost.getId().toString()))
                for(BonusType bonusType : userBoost.boost().getBonuses())
                    if(bonusType == BonusType.PLANET_APPEARANCE)
                        toRemove.add(userBoost);

        user.getStats().getBuffs().removeAll(toRemove);
        user.getStats().addBonusTime(boost, quantity * boost.getSeconds());

        ResponseUsePropsPacket response = ResourcesService.getInstance().genericUseProps(boost.getPropId(), quantity, lock ? 1 : 0, 1);

        user.update();
        user.save();

        packet.reply(response);
        packet.reply(user.getQueuesAsPacket());
        return true;

    })),

    TRUCE_BOOSTERS(array(902, 937), ((prop, quantity, lock, packet, user) -> {

        if(quantity > 1) return false;

        GameBoost boost = ResourcesService.getInstance().getBoostRepository().findByPropId(prop.getPropId());
        if(boost == null) throw new IllegalArgumentException("Planet truce booster " + prop.getPropId() + " not found!");

        UserPlanet planet = user.getPlanet();
        if(planet == null || planet.isInWar() || PacketService.getInstance().hasFleetsDeployed(user)) return false;

        List<BonusType> bonuses = user.getStats().getAllBonuses();
        if(bonuses.contains(BonusType.TRUCE_IMPEDIMENT) || bonuses.contains(BonusType.PLANET_PROTECTION)) return false;

        if(prop.getPropId() == 902) {

            GameBoost impediment = ResourcesService.getInstance().getBoostRepository().findByMimeType(6);
            user.getStats().addBonusTime(impediment, impediment.getSeconds());

        }

        user.getStats().addBonusTime(boost, boost.getSeconds());

        ResponseUsePropsPacket response = ResourcesService.getInstance().genericUseProps(boost.getPropId(), quantity, lock ? 1 : 0, 1);

        user.update();
        user.save();

        packet.reply(response);
        packet.reply(user.getQueuesAsPacket());
        return true;

    })),

    COMMANDERS_CARDS(matrix(range(0, 512), range(2007, 2501)), ((prop, quantity, lock, packet, user) -> {

        if(quantity > 1)
            return false;

        PropData propData = CommanderService.getInstance().getCommanderPropData(prop.getPropId());
        BotLogger.log(propData + ", " + prop.getPropId());

        if(propData == null)
            return false;

        CommanderStatsData commanderData = propData.getCommanderData().getCommander();
        Commander commander = user.getCommanderBySkill(commanderData.getId());

        if(commander != null)
            return false;

        int stars = prop.getPropId() - propData.getId();

        commander = CommanderService.getInstance().basic(commanderData.getId(), stars, 0, user.getPlanet().getUserId());
        commander.save();

        ResponseUsePropsPacket response = ResourcesService.getInstance().genericUseProps(prop.getPropId(), quantity, lock ? 1 : 0, 1);
        UserService.getInstance().getUserCache().save(user);

        packet.reply(CommanderService.getInstance().getCreateCommander(commander));
        packet.reply(response);
        return true;

    })),

    SP_CARD(927, ((prop, quantity, lock, packet, user) -> {

        if(quantity > 1) return false;

        int sp = user.getStats().getSp();
        int maxSp = user.getStats().getMaxSp();

        user.getStats().setSp(sp + 10 > maxSp ? maxSp : sp + 10);

        if(user.getStats().getSp() >= user.getStats().getMaxSp()) return false;

        ResponseUsePropsPacket response = ResourcesService.getInstance().genericUseProps(prop.getPropId(), quantity, user.getStats().getSp(),  lock ? 1 : 0, 1);

        user.save();
        user.update();
        packet.reply(response);
        ResourcesService.getInstance().getPlayerResourcePacket(user);
        return true;

    })),

    SUPER_COMMANDER_CHEST(1572, ((prop, quantity, lock, packet, user) -> {

        if(quantity > 1) return false;

        List<PropData> propData = CommanderService.getInstance().getCommanderPropData("super");
        if(propData == null || propData.isEmpty()) return false;

        UserInventory userInventory = user.getInventory();
        Collections.shuffle(propData);

        PropData selected = propData.get(0);
        if(selected == null || !selected.hasCommanderData()) return false;

        userInventory.addProp(selected.getId(), 1, 0, true);
        Packet response = ResourcesService.getInstance().smartUseProps(prop.getPropId(), quantity, lock ? 1 : 0, 0, 0, 0, 1, 1, Arrays.asList(Pair.of(selected.getId(), 1)));

        CommanderStatsData commanderStatsData = selected.getCommanderData().getCommander();
        String commanderName = commanderStatsData.getLocalizedName();

        user.update();
        user.save();

        packet.getSmartServer().sendMessage("Congratulations on getting the commander " + commanderName + ", create a command center to get 1000 vouchers!");
        packet.reply(response);
        return true;

    })),

    LIFE_BOAT(range(1552, 1558), ((prop, quantity, lock, packet, user) -> {

        if(quantity > 1) return false;

        List<PropData> propData = CommanderService.getInstance().getCommanderPropData("skill");
        if(propData == null || propData.isEmpty()) return false;

        UserInventory userInventory = user.getInventory();
        Collections.shuffle(propData);

        PropData selected = propData.get(0);
        if(selected == null || !selected.hasCommanderData()) return false;

        int stars = -(1558 - prop.getPropId()) + 8;
        int newPropId = selected.getId() + stars;

        userInventory.addProp(newPropId, 1, 0, false);
        Packet response = ResourcesService.getInstance().smartUseProps(prop.getPropId(), quantity, lock ? 1 : 0, 0, 0, 0, 1, 0, Arrays.asList(Pair.of(newPropId, 1)));

        user.update();
        user.save();

        packet.reply(response);
        return true;

    })),

    SUPER_LIFE_BOAT(range(1560, 1566), ((prop, quantity, lock, packet, user) -> {

        if(quantity > 1) return false;

        List<PropData> propData = CommanderService.getInstance().getCommanderPropData("super");
        if(propData == null || propData.isEmpty()) return false;

        UserInventory userInventory = user.getInventory();
        Collections.shuffle(propData);

        PropData selected = propData.get(0);
        if(selected == null || !selected.hasCommanderData()) return false;

        int stars = -(1566 - prop.getPropId()) + 8;
        int newPropId = selected.getId() + stars;

        userInventory.addProp(newPropId, 1, 0, false);
        Packet response = ResourcesService.getInstance().smartUseProps(prop.getPropId(), quantity, lock ? 1 : 0, 0, 0, 0, 1, 0, Arrays.asList(Pair.of(newPropId, 1)));

        user.update();
        user.save();

        packet.reply(response);
        return true;

    })),

    LEGENDARY_LIFE_BOAT(range(1574, 1580), ((prop, quantity, lock, packet, user) -> {

        if(quantity > 1) return false;

        List<PropData> propData = CommanderService.getInstance().getCommanderPropData("legendary");
        if(propData == null || propData.isEmpty()) return false;

        UserInventory userInventory = user.getInventory();
        Collections.shuffle(propData);

        PropData selected = propData.get(0);
        if(selected == null || !selected.hasCommanderData()) return false;

        int stars = -(1580 - prop.getPropId()) + 8;
        int newPropId = selected.getId() + stars;

        userInventory.addProp(newPropId, 1, 0, false);
        Packet response = ResourcesService.getInstance().smartUseProps(prop.getPropId(), quantity, lock ? 1 : 0, 0, 0, 0, 1, 0, Arrays.asList(Pair.of(newPropId, 1)));

        user.update();
        user.save();

        packet.reply(response);
        return true;

    })),

    DIVINE_LIFE_BOAT(range(1581, 1587), ((prop, quantity, lock, packet, user) -> {

        if(quantity > 1) return false;

        List<PropData> propData = CommanderService.getInstance().getCommanderPropData("divine");
        if(propData == null || propData.isEmpty()) return false;

        UserInventory userInventory = user.getInventory();
        Collections.shuffle(propData);

        PropData selected = propData.get(0);
        if(selected == null || !selected.hasCommanderData()) return false;

        int stars = -(1587 - prop.getPropId()) + 8;
        int newPropId = selected.getId() + stars;

        userInventory.addProp(newPropId, 1, 0, false);
        Packet response = ResourcesService.getInstance().smartUseProps(prop.getPropId(), quantity, lock ? 1 : 0, 0, 0, 0, 1, 0, Arrays.asList(Pair.of(newPropId, 1)));

        user.update();
        user.save();

        packet.reply(response);
        return true;

    })),

    TREASURE_BOX(931, ((prop, quantity, lock, packet, user) -> {

        Packet response = ResourcesService.getInstance().genericUseProps(prop.getPropId(), quantity, 0, 0, 0, 0, 0, quantity,0, lock ? 1 : 0, 1, 0);

        user.getResources().addBadges(quantity);
        user.update();
        user.save();

        packet.reply(response);
        return true;

    })),

    VOUCHER_AWARD(array(933, 935), ((prop, quantity, lock, packet, user) -> {

        int award = prop.getPropId() == 935 ? 10 : 30;
        award *= quantity;

        Packet response = ResourcesService.getInstance().genericUseProps(prop.getPropId(), quantity, 0, 0, 0, award, 0, 0,0, lock ? 1 : 0, 1, 0);

        user.getResources().addVouchers(award);
        user.update();
        user.save();

        packet.reply(response);
        return true;

    })),

    BADGE_AWARD(931, ((prop, quantity, lock, packet, user) -> {

        Packet response = ResourcesService.getInstance().genericUseProps(prop.getPropId(), quantity, 0, 0, 0, 0, 0, quantity,0, lock ? 1 : 0, 1, 0);

        user.getResources().addBadges(quantity);
        user.update();
        user.save();

        packet.reply(response);
        return true;

    })),

    CORSAIR_CHEST(3101, ((prop, quantity, lock, packet, user) -> {

        Packet response = ResourcesService.getInstance().genericUseProps(prop.getPropId(), quantity, 0, 0, 0, quantity, lock ? 1 : 0, 1, 0);

        user.getResources().addCorsairs(quantity);
        user.update();
        user.save();

        packet.reply(response);
        return true;

    })),

    EMBLEM_OF_HONOR(934, ((prop, quantity, lock, packet, user) -> {

        Packet response = ResourcesService.getInstance().genericUseProps(prop.getPropId(), quantity, 0, 0, 0, 0, quantity, 0,0, lock ? 1 : 0, 1, 0);

        user.getResources().addHonor(quantity);
        user.update();
        user.save();

        packet.reply(response);
        return true;

    })),

    GALAXY_TRANSFER(923, ((prop, quantity, lock, packet, user) -> {

        if(quantity > 1) return false;

        if(DefendJob.getInstance().getCurrentFlag() == user.getGuid()) {
            user.sendWarning("<strong><font face=\"Verdana\" color=\'#ffa500\'>You can't use this while defending!</font></strong>");
            return false;
        }

        List<Fleet> fleets = PacketService.getInstance().getFleetCache().findAllByGuid(user.getGuid());

        if(!fleets.isEmpty()) {

            packet.reply(ResponseMoveHomePacket.builder()
                    .consortiaName(SmartString.of("", 32))
                    .errorCode(1)
                    .toGalaxyId(-1)
                    .toGalaxyMapId(0)
                    .propsId(prop.getPropId())
                    .lockFlag(lock ? 1 : 0)
                    .build());

            return false;

        }

        GalaxyTile randomTile = GalaxyService.getInstance().randomAvailablePosition(); // random tile

        UserPlanet planet = user.getPlanet();
        if(planet.isInWar()) return false;

        Planet userPlanetGalaxyTile = GalaxyService.getInstance().getPlanet(randomTile);

        int fromGalaxyId = planet.getPosition().galaxyId();

        if(userPlanetGalaxyTile != null) {

            packet.reply(ResponseMoveHomePacket.builder()
                    .consortiaName(SmartString.of("", 32))
                    .errorCode(2)
                    .toGalaxyId(planet.getPosition().galaxyId())
                    .toGalaxyMapId(0)
                    .propsId(prop.getPropId())
                    .lockFlag(lock ? 1 : 0)
                    .build());

            return false;

        }

        planet.setPosition(randomTile);

        int zoneId = planet.getPosition().getParentZone().zoneId();
        int regionId = planet.getPosition().getParentRegion().regionId();
        int galaxyId = planet.getPosition().galaxyId();

        String name = CorpService.getCorpName(user.getGuid());

        ResponseMoveHomeBroPacket responseMoveHomeBroPacket = ResponseMoveHomeBroPacket.builder()
                .delGalaxyId(fromGalaxyId)
                .mapArea(new MapArea(name,
                        user.getUsername(),
                        user.getUserId(),
                        galaxyId,
                        0,
                        user.getStarFace(),
                        1,
                        21,
                        5,
                        user.getStarType(),
                        0,
                        -1,
                        user.getSpaceStationLevel()))
                .build();

        ResponseMoveHomePacket responseMoveHome = ResponseMoveHomePacket.builder()
                .consortiaName(SmartString.of(name, 32))
                .errorCode(0)
                .toGalaxyId(planet.getPosition().galaxyId())
                .toGalaxyMapId(0)
                .propsId(prop.getPropId())
                .lockFlag(lock ? 1 : 0)
                .build();

        ResponseMapAreaPacket responseMapAreaPacket = GalaxyService.getInstance().getMapAreaPacketByRegionId(user, regionId);

        GalaxyService.getInstance().getPlanetCache().save(planet);
        UserService.getInstance().getUserCache().save(user);

        packet.reply(responseMoveHome, responseMapAreaPacket);

        for (LoggedGameUser loggedGameUser : LoginService.getInstance().getGameUsers()) // usuarios en linea
            loggedGameUser.getSmartServer().send(responseMoveHomeBroPacket);

        return true;

    })),

    INSTANCE_DROP(getAllChests(), ((prop, quantity, lock, packet, user) -> {

        if(quantity > 1)
            return false;

        PropData propData = ResourceManager.getProps().getData(prop.getPropId());

        if(propData == null)
            return false;

        UserResources userResources = user.getResources();
        UserInventory userInventory = user.getInventory();

        PropChestData chestData = propData.getChestData();

        Pair<PropData, Integer> reward = null;
        int he3 = 0, metal = 0, gold = 0, voucher = 0, badge = 0, honor = 0;

        List<String> randomContent = chestData.getRandomContentList();
        List<String> unlockedRandomContent = chestData.getUnlockedRandomContentList();

        List<String> allContent = Stream.concat(randomContent.stream(), unlockedRandomContent.stream()).toList();

        // * Random contents
        if(!allContent.isEmpty()) {

            int amount = chestData.getContentAmount();
            int chance = chestData.getContentChance();

            if(chance == -1 || RandomUtil.getRandomInt(0, 100) <= chance) {

                int length = allContent.size();
                String selection = allContent.get(RandomUtil.getRandomInt(length));

                PropData propReward = ResourceManager.getProps().getData(selection);
                reward = Pair.of(propReward, amount <= 0 ? 1 : amount);
            }
        }

        ResponseUsePropsPacket response;

        if(reward != null) {

            boolean locked = chestData.isContentLock();
            if(unlockedRandomContent.contains(reward.getLeft().getName())) locked = false;

            int id = reward.getLeft().getId();
            int amount = reward.getRight();

            userInventory.addProp(id, amount, 0, locked);
            response = ResourcesService.getInstance().smartUseProps(prop.getPropId(), quantity, lock ? 1 : 0, 0, 0, 0, 1, locked ? 1 : 0, reward);

        } else {

            // * Resource contents
            if(chestData.getContents() != null && chestData.getContents().length > 0) {

                int length = chestData.getContents().length;
                PropContentData data = chestData.getContents()[RandomUtil.getRandomInt(length)];

                BotLogger.log(length);
                BotLogger.log(data.getResource());

                switch (data.getResource()) {
                    case "resource:metal":
                        metal = RandomUtil.getRandomInt(data.getMin(), data.getMax());
                        userResources.addMetal(metal);
                        break;
                    case "resource:he3":
                        he3 = RandomUtil.getRandomInt(data.getMin(), data.getMax());
                        userResources.addHe3(he3);
                        break;
                    case "resource:gold":
                        gold = RandomUtil.getRandomInt(data.getMin(), data.getMax());
                        userResources.addGold(gold);
                        break;
                }
            }

            response = ResourcesService.getInstance().genericUseProps(prop.getPropId(), quantity, metal, he3, gold, 0, 0, lock ? 1 : 0, 1, 1);

        }

        user.getMetrics().add("action:use.anychest", 1);
        user.update();
        user.save();

        packet.reply(response);
        return true;

    })),

    BODY_BLUEPRINT_USAGE(getAllBodyBlueprints(), ((prop, quantity, lock, packet, user) -> {

        if (quantity > 1) return false;

        PropData propData = ResourceManager.getProps().getData(prop.getPropId());
        if (propData == null) return false;

        PropBodyData propMetaData = (PropBodyData) propData.getData();
        if (propMetaData.getBody() == null) return false;

        ShipBodyData shipBodyData = ResourceManager.getShipBodies().findByBodyName(propMetaData.getBody());
        UserShipUpgrades shipUpgrades = user.getShipUpgrades();

        if (shipBodyData == null)
            return false;

        for (BodyLevelMeta level : shipBodyData.getLevels())
            if (shipUpgrades.getCurrentBodies().contains(level.getId()))
                return false;

        if (propMetaData.getRequirement() != null)
            for (Integer requirement : propMetaData.getRequirement())
                if (!shipUpgrades.hasBodyUpgrade(requirement)) {
                    BotLogger.error(user.getUsername() + " tried to use " + propData.getName() + " but didn't have the required upgrade: " + requirement);
                    return false;
                }

        shipUpgrades.getCurrentBodies().add(shipBodyData.getLevels().get(0).getId());

        ResponseUsePropsPacket response = ResourcesService.getInstance().genericUseProps(prop.getPropId(), quantity, lock ? 1 : 0, 1);
        user.update();
        user.save();

        packet.reply(response);
        return true;

    })),

    PART_BLUEPRINT_USAGE(getAllPartBlueprints(), ((prop, quantity, lock, packet, user) -> {

        if(quantity > 1) return false;

        PropData propData = ResourceManager.getProps().getData(prop.getPropId());
        if(propData == null) return false;

        PropPartData propMetaData = (PropPartData) propData.getData();
        if(propMetaData.getPart() == null) return false;

        ShipPartData shipPartData = ResourceManager.getShipParts().findByPartName(propMetaData.getPart());
        UserShipUpgrades shipUpgrades = user.getShipUpgrades();
        if(shipPartData == null) return false;

        for(PartLevelMeta level : shipPartData.getLevels())
            if(shipUpgrades.getCurrentParts().contains(level.getId()))
                return false;

        if(propMetaData.getRequirement() != null)
            for(Integer requirement : propMetaData.getRequirement())
                if(!shipUpgrades.hasPartUpgrade(requirement)) {
                    BotLogger.error(user.getUsername() + " tried to use " + propData.getName() + " but didn't have the required upgrade: " + requirement);
                    return false;
                }

        shipUpgrades.getCurrentParts().add(shipPartData.getLevels().get(0).getId());

        ResponseUsePropsPacket response = ResourcesService.getInstance().genericUseProps(prop.getPropId(), quantity, lock ? 1 : 0, 1);
        user.update();
        user.save();

        packet.reply(response);
        return true;

    })),

    PACK_USAGE(getAllPacks(), ((prop, quantity, lock, packet, user) -> {

        PropData propData = ResourceManager.getProps().getData(prop.getPropId());

        if(propData == null)
            return false;

        PropContainerData propMetaData = (PropContainerData) propData.getData();

        if(propMetaData.getContents() == null)
            return false;

        UserResources userResources = user.getResources();

        int he3 = 0;
        int metal = 0;
        int gold = 0;

        for(int i = 0; i < quantity; i++) {
            for(PropContentData data : propMetaData.getContents()) {
                switch (data.getResource()) {
                    case "resource:metal":
                        metal += RandomUtil.getRandomInt(data.getMin(), data.getMax());
                        break;
                    case "resource:he3":
                        he3 += RandomUtil.getRandomInt(data.getMin(), data.getMax());
                        break;
                    case "resource:gold":
                        gold += RandomUtil.getRandomInt(data.getMin(), data.getMax());
                        break;
                }
            }
        }

        userResources.addMetal(metal);
        userResources.addHe3(he3);
        userResources.addGold(gold);

        ResponseUsePropsPacket response = ResourcesService.getInstance().genericUseProps(prop.getPropId(), quantity, metal, he3, gold, lock ? 1 : 0, 1, 1);

        user.getMetrics().add("action:use.anypack", quantity);
        user.update();
        user.save();

        packet.reply(response);
        return true;

    }))

    ;

    private LinkedList<Integer> listen = new LinkedList<>();

    private PropConsumption action;

    PropAction(int propId, PropConsumption consumption) {
        this.listen.add(propId);
        this.action = consumption;
    }

    PropAction(int start, int end, PropConsumption consumption) {
        for(int i = start; i < end; i++)
            listen.add(i);
        this.action = consumption;
    }

    PropAction(int[][] ranges, PropConsumption consumption) {
        for(int i = 0; i < ranges.length; i++)
            for(int j = 0; j < ranges[i].length; j++)
                listen.add(ranges[i][j]);
        this.action = consumption;
    }

    PropAction(int[] some, PropConsumption consumption) {
        for(int i : some)
            listen.add(i);
        this.action = consumption;
    }

    public static PropAction getAction(int propId) {
        for(PropAction type : values())
            if(type.getListen().contains(propId))
                return type;
        return null;
    }

    public static int[][] matrix(int[]...some) {
        return some;
    }

    public static int[] array(int...some) {
        return some;
    }

    public static int[] range(int from, int to) {
        return IntStream.rangeClosed(from, to).toArray();
    }

    public static int[] getAllPacks() {
        return getIdsByType("pack");
    }

    public static int[] getAllChests() {
        return getIdsByType("chest");
    }

    public static int[] getAllBodyBlueprints() {
        return getIdsByType("blueprintBody");
    }

    public static int[] getAllPartBlueprints() {
        return getIdsByType("blueprintPart");
    }

    public static int[] getIdsByType(String type) {

        List<Integer> ids = new ArrayList<>();

        for(PropData propData : ResourceManager.getProps().getProps())
            if(propData.getType().equals(type))
                ids.add(propData.getId());

        int[] result = new int[ids.size()];

        for(int i = 0; i < ids.size(); i++)
            result[i] = ids.get(i);

        return result;

    }

}
