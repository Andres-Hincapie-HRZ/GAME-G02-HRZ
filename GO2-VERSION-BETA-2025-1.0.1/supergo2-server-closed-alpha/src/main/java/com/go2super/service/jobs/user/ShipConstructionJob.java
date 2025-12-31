package com.go2super.service.jobs.user;

import com.go2super.database.entity.User;
import com.go2super.database.entity.sub.FactoryShip;
import com.go2super.database.entity.sub.UserShips;
import com.go2super.obj.model.LoggedGameUser;
import com.go2super.packet.ship.ResponseShipCreatingCompletePacket;
import com.go2super.service.JobService;
import com.go2super.service.UserService;
import com.go2super.service.jobs.OfflineJob;
import com.go2super.socket.util.DateUtil;

import java.util.*;
import java.util.concurrent.CopyOnWriteArrayList;

public class ShipConstructionJob implements OfflineJob {

    private long lastExecution = 0L;

    @Override
    public void setup() {

    }

    @Override
    public void run() {

        if(DateUtil.millis() - lastExecution < getInterval()) return;
        lastExecution = DateUtil.millis();

        List<User> users = UserService.getInstance().getUserCache().findByShipBuilding();
        CopyOnWriteArrayList<Integer> toUpdate = new CopyOnWriteArrayList<>();

        for(User user : users) {

            UserShips ships = user.getShips();
            if(ships == null || ships.getFactory() == null || ships.getFactory().isEmpty()) continue;

            boolean needSave = ships.getFactory().stream().anyMatch(factoryShip -> factoryShip.getUntil() == null || DateUtil.remainsMillis(factoryShip.getUntil()) <= 0);
            if(needSave) toUpdate.add(user.getGuid());

        }

        if(toUpdate.size() > 0) {

            JobService.submit(() -> {

                List<User> toSave = UserService.getInstance().getUserCache().findByGuid(toUpdate);
                Map<User, List<Integer>> toSend = new HashMap<>();

                for(User user : toSave) {

                    UserShips ships = user.getShips();
                    if(ships == null || ships.getFactory() == null || ships.getFactory().isEmpty()) continue;

                    List<FactoryShip> factoryShips = ships.getFactory();
                    List<FactoryShip> toDelete = new ArrayList<>();

                    boolean save = false;

                    for(FactoryShip factoryShip : factoryShips) {

                        if(factoryShip.getUntil() == null) {

                            save = true;
                            toDelete.add(factoryShip);
                            continue;

                        }

                        while(factoryShip.getUntil() != null && DateUtil.remainsMillis(factoryShip.getUntil()) <= 0) {

                            factoryShip.setUntil(DateUtil.nowMillis((int) (factoryShip.getBuildTime() * 1000.0)));
                            factoryShip.setNum(factoryShip.getNum() - 1);

                            if(factoryShip.getNum() == 0) {

                                factoryShip.setUntil(null);
                                toDelete.add(factoryShip);

                            }

                            ships.addShip(factoryShip.getShipModelId(), 1);

                            if(!toSend.containsKey(user))
                                toSend.put(user, new ArrayList<>());

                            toSend.get(user).add(factoryShips.indexOf(factoryShip));

                            user.getMetrics().add("action:build.ship", 1);
                            save = true;

                        }

                    }

                    factoryShips.removeAll(toDelete);

                    if(save) {

                        user.update();
                        user.save();

                    }

                }

                ResponseShipCreatingCompletePacket packet = new ResponseShipCreatingCompletePacket();

                for(Map.Entry<User, List<Integer>> entry : toSend.entrySet()) {

                    User user = entry.getKey();

                    Optional<LoggedGameUser> optionalLoggedGameUser = user.getLoggedGameUser();
                    if(optionalLoggedGameUser.isEmpty()) continue;

                    LoggedGameUser loggedGameUser = optionalLoggedGameUser.get();

                    for(Integer index : entry.getValue()) {
                        packet.setIndexId(index);
                        loggedGameUser.getSmartServer().send(packet);
                    }

                }

            }, "ship-construction-job");

        }

    }

    @Override
    public long getInterval() {
        return 1L;
    }

}
