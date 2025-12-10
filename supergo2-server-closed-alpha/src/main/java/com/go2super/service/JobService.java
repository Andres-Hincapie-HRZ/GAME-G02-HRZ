package com.go2super.service;

import com.go2super.database.cache.*;
import com.go2super.database.entity.AutoIncrement;
import com.go2super.database.entity.User;
import com.go2super.obj.entry.SmartServer;
import com.go2super.obj.model.LoggedGameUser;
import com.go2super.packet.DispatchType;
import com.go2super.packet.Packet;
import com.go2super.packet.reward.ResponseOnlineAwardPacket;
import com.go2super.service.jobs.GalaxyUserJob;
import com.go2super.service.jobs.OfflineJob;
import com.go2super.service.jobs.corp.CorpUpgradeJob;
import com.go2super.service.jobs.other.HumaroidJob;
import com.go2super.service.jobs.other.RBPJob;
import com.go2super.service.jobs.other.TransitionJob;
import com.go2super.service.jobs.trade.TradeJob;
import com.go2super.service.jobs.user.*;
import com.go2super.socket.util.RandomUtil;
import lombok.Data;
import lombok.Getter;
import lombok.SneakyThrows;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.TaskScheduler;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.stream.Collectors;

@Data
@Getter
@Service
@EnableScheduling
public class JobService {

    private static final List<String> messages = new ArrayList<>();

    static {

        messages.add("Please check the rules of the game in our discord.");
        messages.add("Multi-account is permanently banned, avoid to be part of the banned people!");
        messages.add("Welcome to Super GO2! join our discord and participate with our community (+1300 members): discord.gg/ApPQErfvJw");
        messages.add("The current stage is Open-Alpha, please report bugs in: github.com/SuperGO2/supergo2-issues/issues");
        messages.add("All the progress will be DELETED the 1st of december. Check #information.");

    }

    private static JobService instance;
    // private LinkedBlockingDeque<Task> tasks;

    private LinkedList<GalaxyUserJob> jobs;
    private LinkedList<OfflineJob> offlineJobs;

    private RankJob rankJob;
    private ThreadPoolTaskExecutor threadPool;

    @Autowired private TaskScheduler executor;
    @Autowired private RankService rankService;

    private AutoIncrementCache autoIncrementCache;
    private ShipModelCache shipModelCache;
    private CommanderCache commanderCache;
    private PlanetCache planetCache;
    private FleetCache fleetCache;
    private TradeCache tradeCache;
    private CorpCache corpCache;
    private UserCache userCache;

    @Autowired
    public JobService(AutoIncrementCache autoIncrementCache, CommanderCache commanderCache, PlanetCache planetCache, FleetCache fleetCache, UserCache userCache, CorpCache corpCache, ShipModelCache shipModelCache, TradeCache tradeCache) {

        instance = this;

        this.autoIncrementCache = autoIncrementCache;
        this.shipModelCache = shipModelCache;
        this.commanderCache = commanderCache;
        this.planetCache = planetCache;
        this.fleetCache = fleetCache;
        this.corpCache = corpCache;
        this.userCache = userCache;
        this.tradeCache = tradeCache;

        jobs = new LinkedList<>();
        offlineJobs = new LinkedList<>();

        jobs.add(new BuilderJob());
        jobs.add(new UpgradeJob());

        offlineJobs.add(new HumaroidJob());
        offlineJobs.add(new RBPJob());
        offlineJobs.add(new TechJob());
        offlineJobs.add(new TradeJob());
        offlineJobs.add(new TransitionJob());
        offlineJobs.add(new CorpUpgradeJob());
        offlineJobs.add(new ShipConstructionJob());

        // offlineJobs.add(new ChatGameJob());
        // offlineJobs.add(new DefendJob());

        rankJob = new RankJob();

        threadPool = new ThreadPoolTaskExecutor();
        threadPool.setCorePoolSize(1);
        threadPool.setMaxPoolSize(1);
        threadPool.setKeepAliveSeconds(1);
        threadPool.initialize();

        for(OfflineJob offlineJob : offlineJobs)
            offlineJob.setup();

    }

    @Scheduled(cron = "0 0 0 * * *")
    public void refresh() {

        JobService.submit(() -> {

            for(LoggedGameUser gameUser : LoginService.getInstance().getGameUsers()) {

                User user = gameUser.getUpdatedUser();
                if(user == null) continue;

                user.update();
                user.save();

                ResponseOnlineAwardPacket onlineAwardPacket = ResourcesService.getInstance().getOnlineAwardPacket(user);
                if(onlineAwardPacket != null) gameUser.getSmartServer().send(onlineAwardPacket);

                gameUser.getSmartServer().send(ResourcesService.getInstance().getPlayerResourcePacket(user));
                gameUser.getSmartServer().sendMessage("A new intergalactic day has come! Now you can claim the rewards of the day!");

            }

        }, "user-refresh-job");

    }

    @Scheduled(fixedDelay = 100L)
    public void saveUsersTask() {

        List<User> users = userCache.findToSave();
        if(users.isEmpty()) return;

        userCache.saveAll(users);

    }

    @Scheduled(fixedDelay = 100L)
    public void saveIncrementsTask() {

        List<AutoIncrement> users = autoIncrementCache.findToSave();
        if(users.isEmpty()) return;

        autoIncrementCache.saveAll(users);

    }

    @Scheduled(fixedDelay = 2000000L)
    public void chatTask() {

        String message = messages.get(RandomUtil.getRandomInt(messages.size()));
        ChatService.getInstance().broadcastMessage(message);

    }

    @Scheduled(fixedDelay = 6000000L)
    public void medusaTask() {

        long count = PacketService.getInstance().getSanctionCache().count();
        ChatService.getInstance().medusaMessage("There have been " + count + " sanctions to date. Avoid being part of the list!");

    }

    @Scheduled(fixedDelay = 10000L)
    public void rankTask() {
        rankJob.run();
    }

    @Scheduled(fixedDelay = 500L)
    public void offlineTasks() {

        for(OfflineJob job : offlineJobs)
            job.run();

    }

    @Scheduled(fixedDelay = 500L)
    public void userTasks() {

        CopyOnWriteArrayList<LoggedGameUser> users = new CopyOnWriteArrayList<LoggedGameUser>(LoginService.getInstance().getGameUsers());
        if(users.isEmpty()) return;

        CopyOnWriteArrayList<Integer> toUpdateGuid = new CopyOnWriteArrayList<>();
        List<Integer> guids = users.stream().map(LoggedGameUser::getGuid).collect(Collectors.toList());

        for(User updated : UserService.getInstance().getUserCache().findByGuid(guids)) {
            for(GalaxyUserJob galaxyUserJob : jobs)
                if(galaxyUserJob.needUpdate(updated)) {
                    toUpdateGuid.add(updated.getGuid());
                    continue;
                }
        }

        if(toUpdateGuid.isEmpty()) return;
        submit(() -> {

            List<User> usersToUpdate = UserService.getInstance().getUserCache().findByGuid(toUpdateGuid);
            List<CompletableFuture> futures = new ArrayList<>();

            for(LoggedGameUser gameUser : users) {
                futures.add(CompletableFuture.runAsync(() -> {
                    boolean save = false;
                    User updatedUser = usersToUpdate.stream().filter(user -> user.getGuid() == gameUser.getGuid()).findFirst().orElse(null);
                    if(updatedUser == null) return;
                    for(GalaxyUserJob galaxyJob : jobs)
                        if(galaxyJob.needUpdate(updatedUser) && galaxyJob.run(gameUser, updatedUser)) save = true;
                    if(save) {
                        updatedUser.update();
                        updatedUser.save();
                    }
                }));
            }

            CompletableFuture.allOf(futures.toArray(new CompletableFuture[futures.size()])).join();

        }, "user-job");

    }

    @SneakyThrows
    public void sleep(long millis) {
        Thread.sleep(millis);
    }

    public static <E extends GalaxyUserJob> E getUserJob(Class<E> clazz) {
        for(GalaxyUserJob job : getInstance().getJobs())
            if(job.getClass().isAssignableFrom(clazz))
                return (E) job;
        return null;
    }

    public static <E extends OfflineJob> E getOfflineJob(Class<E> clazz) {
        for(OfflineJob job : getInstance().getOfflineJobs())
            if(job.getClass().isAssignableFrom(clazz))
                return (E) job;
        return null;
    }

    public static void submit(Runnable runnable, Packet request, SmartServer smartServer) {
        submit(runnable, request, smartServer, DispatchType.LOCK);
    }

    @SneakyThrows
    public static void submit(Runnable runnable, Packet request, SmartServer smartServer, DispatchType dispatchType) {
        runnable.run();
    }

    @SneakyThrows
    public static void submit(Runnable runnable, String taskName) {
        runnable.run();
    }

    public ThreadPoolTaskExecutor getThreadPool() {
        return threadPool;
    }

    public TaskScheduler getExecutor() {
        return executor;
    }

    public static JobService getInstance() {
        return instance;
    }

}
