package com.go2super.listener;

import com.go2super.database.entity.Corp;
import com.go2super.database.entity.ShipModel;
import com.go2super.database.entity.TeamModelSlot;
import com.go2super.database.entity.User;
import com.go2super.database.entity.sub.*;
import com.go2super.obj.game.CreateShipInfo;
import com.go2super.obj.game.ShipModelInfo;
import com.go2super.obj.utility.UnsignedShort;
import com.go2super.packet.PacketListener;
import com.go2super.packet.PacketProcessor;
import com.go2super.packet.ship.RequestCreateTeamModelPacket;
import com.go2super.packet.ship.RequestSpeedShipPacket;
import com.go2super.packet.ship.ResponseSpeedShipPacket;
import com.go2super.packet.shipmodel.*;
import com.go2super.service.*;
import com.go2super.service.exception.BadGuidException;
import com.go2super.socket.util.DateUtil;

import java.util.ArrayList;
import java.util.List;

public class ShipFactoryListener implements PacketListener {

    public static int MAX_SHIPS = 2000000;

    @PacketProcessor
    public void onCreate(RequestCreateShipPacket packet) throws BadGuidException {

        LoginService.validate(packet, packet.getGuid());

        User user = UserService.getInstance().getUserCache().findByGuid(packet.getGuid());
        if(user == null || packet.getNum() <= 0) return;

        int currentShips = user.totalShips();
        if(currentShips + packet.getNum() >= MAX_SHIPS) return;

        UserTechs techs = user.getTechs();
        UserBuilding building = user.getBuildings().getBuilding("build:shipFactory");
        if(building == null) return;

        ShipModel shipModel = PacketService.getShipModel(packet.getShipModelId());

        // ← AÑADIDO: Validación y log de debugging
        if(shipModel == null) {
            System.out.println("[ERROR onCreate] ShipModel NULL para shipModelId: " + packet.getShipModelId());
            return;
        }

        System.out.println("[onCreate] Fabricando nave:");
        System.out.println("  - shipModelId: " + shipModel.getShipModelId());
        System.out.println("  - bodyId: " + shipModel.getBodyId());
        System.out.println("  - name: " + shipModel.getName());

        if(shipModel.getGuid() != -1)
            if(shipModel.getGuid() != user.getGuid() || shipModel.isDeleted())
                return;

        UserShips ships = user.getShips();
        UserResources resources = user.getResources();

        int slots = 0;

        double shipQueueSlots = building.getLevelData().getEffect("shipQueueSlots").getValue();
        double shipBuildBonus = building.getLevelData().getEffect("shipBuildBonus").getValue();

        Corp userCorp = user.getCorp();
        if(userCorp != null) shipBuildBonus += userCorp.getRBPBonus();

        UserTech boostTech = techs.getTech("science:ship.building.boost");
        if(boostTech != null) shipBuildBonus += boostTech.getEffectValue("increase.shipbuilding.speed") * 0.01;

        slots += (int) shipQueueSlots;

        UserTech syncTech = techs.getTech("science:sync.shipbuilding");
        if(syncTech != null) slots += syncTech.getEffectValue("increase.shipbuilding.queue");
        if(ships.getFactory().size() + 1 > slots) return;

        UserTech qualityTech = techs.getTech("science:ship.building.logistics");
        double decreaseMetal = 0.0, decreaseGold = 0.0, decreaseHe3 = 0.0;

        if(qualityTech != null) {
            decreaseMetal = qualityTech.getEffectValue("decrease.ship.metal.consume");
            decreaseGold = qualityTech.getEffectValue("decrease.ship.gold.consume");
            decreaseHe3 = qualityTech.getEffectValue("decrease.ship.he3.consume");
        }

        double unitGas = (int) Math.floor(shipModel.getHe3BuildCost() * (1 - (decreaseHe3 * 0.01)));
        double unitMetal = (int) Math.floor(shipModel.getMetalBuildCost() * (1 - (decreaseMetal * 0.01)));
        double unitGold = (int) Math.floor(shipModel.getGoldBuildCost() * (1 - (decreaseGold * 0.01)));

        double gas = unitGas * packet.getNum();
        double metal = unitMetal * packet.getNum();
        double gold = unitGold * packet.getNum();

        if(resources.getGold() < gold || resources.getMetal() < metal || resources.getHe3() < gas) return;

        resources.setHe3(resources.getHe3() - (long) gas);
        resources.setMetal(resources.getMetal() - (long) metal);
        resources.setGold(resources.getGold() - (long) gold);

        double buildTime = PacketService.getInstance().getFastShipBuilding() ? (double) (shipModel.getBuildTime()) / (1.0 + shipBuildBonus): 3;

        int fixedBuildTime = (int) buildTime;
        double needTime = fixedBuildTime * packet.getNum();

        if(!ships.fabricate(packet.getShipModelId(), packet.getNum(), fixedBuildTime))
            return;

        ResponseCreateShipPacket response = new ResponseCreateShipPacket();

        response.setGas((int) gas);
        response.setMetal((int) metal);
        response.setMoney((int) gold);
        response.setNeedTime((int) needTime);
        response.setNum(packet.getNum());
        response.setShipModelId(packet.getShipModelId());

        user.save();
        packet.reply(response);

    }

    @PacketProcessor
    public void onDesignShip(RequestCreateShipModelPacket packet) throws BadGuidException {

        LoginService.validate(packet, packet.getGuid());

        User user = UserService.getInstance().getUserCache().findByGuid(packet.getGuid());
        if(user == null || packet.getPartNum() <= 0 || packet.getPartNum() > 50) return;

        List<ShipModel> models = PacketService.getInstance().getShipModelCache().findAllByGuidAndDeleted(packet.getGuid(), false);
        if(models.size() >= 29) return;

        // ← AÑADIDO: Log del paquete recibido
        System.out.println("=======================================================");
        System.out.println("[onDesignShip] RECIBIENDO DISEÑO DE NAVE:");
        System.out.println("  - GUID: " + packet.getGuid());
        System.out.println("  - BodyId del paquete: " + packet.getBodyId());
        System.out.println("  - Nombre: " + packet.getShipName());
        System.out.println("  - PartNum: " + packet.getPartNum());
        System.out.println("=======================================================");

        // ← AÑADIDO: Validación del bodyId
        int bodyId = packet.getBodyId();
        if(bodyId < 0) {
            System.out.println("[ERROR onDesignShip] BodyId inválido: " + bodyId);
            return;
        }

        List<Integer> parts = new ArrayList<>();
        for(int i = 0; i < packet.getPartNum(); i++) {
            parts.add(packet.getParts().get(i));
        }

        // ← AÑADIDO: Obtener el ID de forma segura
        int newShipModelId = AutoIncrementService.getInstance().getNextShipModelId();

        System.out.println("[onDesignShip] Nuevo shipModelId generado: " + newShipModelId);

        // ← CORREGIDO: Crear el modelo con el bodyId correcto
        ShipModel model = ShipModel.builder()
                .shipModelId(newShipModelId)
                .bodyId(bodyId)                              // ← Usando variable local validada
                .deleted(false)
                .guid(packet.getGuid())
                .name(packet.getShipName().noSpaces())
                .parts(parts)
                .build();

        // ← AÑADIDO: Log del modelo creado ANTES de guardar
        System.out.println("[onDesignShip] MODELO CREADO:");
        System.out.println("  - shipModelId: " + model.getShipModelId());
        System.out.println("  - bodyId: " + model.getBodyId());
        System.out.println("  - name: " + model.getName());
        System.out.println("  - guid: " + model.getGuid());
        System.out.println("  - parts: " + model.getParts());

        // ← IMPORTANTE: GUARDAR PRIMERO en la base de datos y caché
        PacketService.getInstance().getShipModelCache().save(model);

        // ← AÑADIDO: Verificar que se guardó correctamente
        ShipModel verificacion = PacketService.getShipModel(model.getShipModelId());
        if(verificacion != null) {
            System.out.println("[onDesignShip] VERIFICACIÓN después de guardar:");
            System.out.println("  - shipModelId: " + verificacion.getShipModelId());
            System.out.println("  - bodyId: " + verificacion.getBodyId());
            System.out.println("  - name: " + verificacion.getName());

            if(verificacion.getBodyId() != bodyId) {
                System.out.println("[ERROR] ¡¡¡BODYID NO COINCIDE!!! Esperado: " + bodyId + ", Obtenido: " + verificacion.getBodyId());
            }
        } else {
            System.out.println("[ERROR] No se pudo verificar el modelo guardado!");
        }

        // Preparar respuesta
        ResponseCreateShipModelPacket response = new ResponseCreateShipModelPacket();

        response.setShipModelId(model.getShipModelId());
        response.setBodyId((short) model.getBodyId());
        response.getShipName().setValue(model.getName());
        response.setParts(packet.getParts());
        response.setPartNum(packet.getPartNum());
        response.setNeedMoney(0);

        // ← AÑADIDO: Log de la respuesta
        System.out.println("[onDesignShip] RESPUESTA:");
        System.out.println("  - shipModelId: " + response.getShipModelId());
        System.out.println("  - bodyId: " + response.getBodyId());
        System.out.println("=======================================================");

        user.getMetrics().add("action:design", 1);
        user.update();
        user.save();

        packet.reply(response);

    }

    @PacketProcessor
    public void onCancelShip(RequestCancelShipPacket packet) throws BadGuidException {

        LoginService.validate(packet, packet.getGuid());

        User user = UserService.getInstance().getUserCache().findByGuid(packet.getGuid());

        if(user == null)
            return;

        if(packet.getIndexId() < 0 || packet.getIndexId() > 4)
            return;

        UserShips ships = user.getShips();
        List<FactoryShip> factory = ships.getFactory();

        if(factory.size() <= packet.getIndexId())
            return;

        FactoryShip factoryShip = factory.get(packet.getIndexId());
        factory.remove(factoryShip);

        ShipModel shipModel = PacketService.getShipModel(factoryShip.getShipModelId());

        // ← AÑADIDO: Validación null
        if(shipModel == null) {
            System.out.println("[ERROR onCancelShip] ShipModel NULL para: " + factoryShip.getShipModelId());
            return;
        }

        double goldRefund = (shipModel.getGoldBuildCost() * factoryShip.getNum()) * 0.1;
        double he3Refund = (shipModel.getHe3BuildCost() * factoryShip.getNum()) * 0.1;
        double metalRefund = (shipModel.getMetalBuildCost() * factoryShip.getNum()) * 0.1;

        user.getResources().addGold((long) goldRefund);
        user.getResources().addHe3((long) he3Refund);
        user.getResources().addMetal((long) metalRefund);

        user.update();
        user.save();

        ResponseCancelShipPacket response = new ResponseCancelShipPacket();

        response.setIndexId(packet.getIndexId());
        response.setNum(factoryShip.getNum());
        response.setStatus(1);

        packet.reply(response);
        packet.reply(ResourcesService.getInstance().getPlayerResourcePacket(user));

    }

    @PacketProcessor
    public void onDelete(RequestDeleteShipModelPacket packet) throws BadGuidException {

        LoginService.validate(packet, packet.getGuid());

        User user = UserService.getInstance().getUserCache().findByGuid(packet.getGuid());

        if(user == null)
            return;

        ShipModel model = PacketService.getShipModel(packet.getShipModelId());

        if(model == null || model.getGuid() != packet.getGuid())
            return;

        model.setDeleted(true);
        PacketService.getInstance().getShipModelCache().save(model);

    }

    @PacketProcessor
    public void onFactory(RequestCreateShipInfoPacket packet) throws BadGuidException {

        LoginService.validate(packet, packet.getGuid());

        User user = UserService.getInstance().getUserCache().findByGuid(packet.getGuid());
        if(user == null) return;

        UserBuilding building = user.getBuildings().getBuilding("build:shipFactory");
        UserTechs techs = user.getTechs();
        UserShips ships = user.getShips();
        if(building == null) return;

        double shipBuildBonus = building.getLevelData().getEffect("shipBuildBonus").getValue();

        Corp userCorp = user.getCorp();
        if(userCorp != null) shipBuildBonus += userCorp.getRBPBonus();

        UserTech boostTech = techs.getTech("science:ship.building.boost");
        if(boostTech != null) shipBuildBonus += boostTech.getEffectValue("increase.shipbuilding.speed") * 0.01;

        ResponseCreateShipInfoPacket response = new ResponseCreateShipInfoPacket();

        response.setMaxCreateShipNum(2000000 - user.totalShips());
        response.setIncShipPercent((short) (shipBuildBonus * 100));
        response.setDataLen((short) ships.getFactory().size());

        List<CreateShipInfo> factory = user.getShips().getFactoryAsBuffer();
        CreateShipInfo reference = new CreateShipInfo();

        for(FactoryShip ship : ships.getFactory())
            factory.add(ship.packet());

        while(factory.size() < 10)
            factory.add(reference.trash());

        response.setCreateShipList(factory);
        packet.reply(response);

    }

    @PacketProcessor
    public void onSpeedShip(RequestSpeedShipPacket packet) throws BadGuidException {

        LoginService.validate(packet, packet.getGuid());

        User user = UserService.getInstance().getUserCache().findByGuid(packet.getGuid());
        if(user == null) return;

        UserShips ships = user.getShips();
        if(ships.getFactory().size() <= packet.getIndexId()) return;

        UserResources resources = user.getResources();
        if(resources.getMallPoints() < 8) return;

        FactoryShip factoryShip = ships.getFactory().get(packet.getIndexId());
        if(factoryShip == null) return;

        int remains = DateUtil.remains(factoryShip.getUntil()).intValue();
        double newRemains = (double) remains / 1.1;

        double buildTime = factoryShip.getBuildTime() / 1.1;
        double needTime = newRemains + (buildTime * (factoryShip.getNum() - 1));

        if(needTime - factoryShip.getNum() <= 0) return;

        factoryShip.setIncSpeed(factoryShip.getIncSpeed() + 10);
        factoryShip.setUntil(DateUtil.now((int) newRemains));
        factoryShip.setBuildTime(buildTime);

        resources.setMallPoints(resources.getMallPoints() - 8);

        ResponseSpeedShipPacket response = ResponseSpeedShipPacket.builder()
                .errorCode(0)
                .spareTime((int) needTime)
                .indexSpareTime(packet.getIndexId())
                .build();

        user.getMetrics().add("action:speedup.shipbuilding", 1);
        user.update();
        user.save();

        packet.reply(response);

    }

    @PacketProcessor
    public void onAddShipModelDel(RequestAddShipModelDelPacket packet) throws BadGuidException {

        LoginService.validate(packet, packet.getGuid());

        User user = UserService.getInstance().getUserCache().findByGuid(packet.getGuid());
        if(user == null) return;

        ShipModel shipModel = PacketService.getShipModel(packet.getShipModelId());

        // ← AÑADIDO: Log de debugging
        System.out.println("[onAddShipModelDel] Buscando shipModelId: " + packet.getShipModelId());

        if(shipModel == null) {
            System.out.println("[ERROR onAddShipModelDel] ShipModel NULL!");
            return;
        }

        System.out.println("[onAddShipModelDel] Modelo encontrado:");
        System.out.println("  - name: " + shipModel.getName());
        System.out.println("  - bodyId: " + shipModel.getBodyId());

        ResponseShipModelInfoDelPacket response = new ResponseShipModelInfoDelPacket();

        response.setDataLen(UnsignedShort.of(1));
        response.setShipModelInfoList(new ArrayList<>());

        response.getShipModelInfoList().add(
                ShipModelInfo.of(
                        shipModel.getName(),
                        shipModel.partNum(),
                        shipModel.getShipModelId() == 0 ? 1 : 0,
                        shipModel.getBodyId(),
                        shipModel.partArray(),
                        shipModel.getShipModelId())
        );

        packet.reply(response);

    }

    @PacketProcessor
    public void onCreateTeamModel(RequestCreateTeamModelPacket packet) throws BadGuidException {

        LoginService.validate(packet, packet.getGuid());

        User user = UserService.getInstance().getUserCache().findByGuid(packet.getGuid());
        if(user == null) return;

        TeamModelSlot teamModelSlot = TeamModelService.getInstance().getTeamModelsRepository().findByGuidAndIndexId(packet.getGuid(), packet.getIndexId());

        if(packet.getDelFlag() == 0) {

            if (teamModelSlot == null) {

                TeamModelSlot newTeamModelSlot = TeamModelSlot.builder()
                        .guid(packet.getGuid())
                        .indexId(packet.getIndexId())
                        .teamModel(packet.getTeamModel())
                        .build();

                newTeamModelSlot.save();

            } else {

                teamModelSlot.setTeamModel(packet.getTeamModel());
                teamModelSlot.save();

            }

        } else if(packet.getDelFlag() == 1) {

            TeamModelService.getInstance().getTeamModelsRepository().delete(teamModelSlot);
            return;

        }

    }

}
