package com.go2super;

import com.go2super.database.cache.DashboardAccountCache;
import com.go2super.database.cache.PlanetCache;
import com.go2super.database.cache.ShipModelCache;
import com.go2super.database.entity.DashboardAccount;
import com.go2super.database.entity.GameBoost;
import com.go2super.database.entity.Planet;
import com.go2super.database.entity.ShipModel;
import com.go2super.database.entity.sub.HumaroidPlanet;
import com.go2super.database.entity.sub.ResourcePlanet;
import com.go2super.database.entity.type.DashboardRank;
import com.go2super.database.repository.GameBoostRepository;
import com.go2super.logger.BotLogger;
import com.go2super.obj.type.BonusType;
import com.go2super.obj.utility.GalaxyTile;
import com.go2super.resources.ResourceManager;
import com.go2super.resources.data.DefaultModelData;
import com.go2super.resources.localization.Localization;
import com.go2super.service.GalaxyService;
import com.go2super.service.PacketService;
import com.go2super.socket.util.Crypto;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.scheduling.annotation.EnableScheduling;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.Properties;

@Configuration
@EnableCaching
@EnableScheduling
// @EnableWebSocketMessageBroker
public class Go2SuperApplicationConfig implements ApplicationRunner {

    @Autowired private GalaxyService galaxyService;
    @Autowired private GameBoostRepository boostRepository;

    @Autowired private PlanetCache planetCache;
    @Autowired private ShipModelCache shipModelCache;
    @Autowired private DashboardAccountCache dashboardAccountCache;

    @Override
    public void run(ApplicationArguments args) {

        setupDefaultModels();
        setupItemBoosts();
        setupPlanets();
        setupDashboard();

    }

    /*@Override
    public void configureMessageBroker(MessageBrokerRegistry registry) {
        registry.setApplicationDestinationPrefixes("/app")
                .enableSimpleBroker("/message");
    }

    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        registry.addEndpoint("/socket")
                .setAllowedOriginPatterns("*")
                .withSockJS();
    }*/

    /*
    @Override
    public void configureTasks(ScheduledTaskRegistrar taskRegistrar) {
        taskRegistrar.setScheduler(taskExecutor());
    }*/

    @Bean
    public JavaMailSender getJavaMailSender() {

        JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
        mailSender.setHost(PacketService.getInstance().getSmtpHost());
        mailSender.setPort(587);

        mailSender.setUsername(PacketService.getInstance().getSmtpUsername());
        mailSender.setPassword(PacketService.getInstance().getSmtpPassword());

        Properties props = mailSender.getJavaMailProperties();
        props.put("mail.transport.protocol", "smtp");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.debug", "false");

        return mailSender;

    }

    /*
    @Bean
    public Executor taskExecutor() {
        return Executors.newScheduledThreadPool(100);
    }*/

    public void setupDashboard() {

        String defaultAdminUsername = PacketService.getInstance().getDefaultAdminEmail();
        String defaultAdminPassword = PacketService.getInstance().getDefaultAdminPassword();

        if(defaultAdminUsername == null || defaultAdminPassword == null)
            throw new RuntimeException("Invalid admin account values");

        Optional<DashboardAccount> optionalAccount = dashboardAccountCache.findByEmail(defaultAdminUsername);

        if(optionalAccount.isEmpty()) {

            BotLogger.info("Creating admin user...");

            DashboardAccount dashboardAccount = DashboardAccount.builder()
                    .id(ObjectId.get())
                    .email(defaultAdminUsername)
                    .password(Crypto.encrypt(defaultAdminPassword))
                    .rank(DashboardRank.ADMIN)
                    .build();

            dashboardAccountCache.save(dashboardAccount);
            BotLogger.info("Dashboard admin account created!");

        }

    }

    public void setupDefaultModels() {

        List<DefaultModelData> toRegister = new ArrayList<>();

        for(DefaultModelData model : ResourceManager.getShipModels().getModels())
            if(shipModelCache.findByShipModelId(model.getId()) == null)
                toRegister.add(model);

        if(!toRegister.isEmpty()) {

            BotLogger.info("Registering game ship models...");

            for(DefaultModelData model : toRegister) {

                int[] parts = model.getPartsArray();
                ShipModel shipModel = makeShipModel(-1, model.getId(), model.getBodyId(), Localization.EN_US.get(model.getName()), parts);

                shipModelCache.save(shipModel);

            }

            BotLogger.info("Game ship models registered!");

        }

    }

    public void setupItemBoosts() {

        if(boostRepository.count() != 0)
            return;

        BotLogger.info("Registering game item boosters...");

        boostRepository.save(makeBoost(900, 0, 259200, BonusType.CONSTRUCTION_SLOTS));
        boostRepository.save(makeBoost(902, 1, 43200, BonusType.PLANET_PROTECTION));
        boostRepository.save(makeBoost(937, 1, 259200, BonusType.PLANET_PROTECTION));
        boostRepository.save(makeBoost(-1, 6, 46800, BonusType.TRUCE_IMPEDIMENT));

        boostRepository.save(makeBoost(905, 2, 43200, BonusType.BASIC_METAL_RESOURCE_PRODUCTION));
        boostRepository.save(makeBoost(906, 3, 43200, BonusType.BASIC_HE3_RESOURCE_PRODUCTION));
        boostRepository.save(makeBoost(907, 4, 43200, BonusType.BASIC_GOLD_RESOURCE_PRODUCTION));
        boostRepository.save(makeBoost(930, 5, 86400, BonusType.ADVANCED_GOLD_RESOURCE_PRODUCTION));

        boostRepository.save(makeBoost(943, 7, 604800, BonusType.MVP_SHIP_BUILDING_RATE, BonusType.MVP_SHIP_REPAIRING_RATE, BonusType.MVP_CONSTRUCTION_SPEED, BonusType.MVP_DAILY_DRAWS_BONUS, BonusType.MVP_RESOURCE_PRODUCTION));

        boostRepository.save(makeBoost(979, 14, 604800, BonusType.PLANET_APPEARANCE, BonusType.CHRISTMAS_RESOURCE_PRODUCTION, BonusType.CHRISTMAS_SHIP_BUILDING_SPEED));
        boostRepository.save(makeBoost(4458, 15, 86400, BonusType.PLANET_APPEARANCE, BonusType.GF_RESOURCE_PRODUCTION, BonusType.GF_SHIP_BUILDING_SPEED, BonusType.GF_SHIP_REPAIRING_SPEED));
        boostRepository.save(makeBoost(4513, 16, 86400, BonusType.PLANET_APPEARANCE,  BonusType.HALLOWEEN_RESOURCE_PRODUCTION, BonusType.HALLOWEEN_SHIP_BUILDING_RATE));

        boostRepository.save(makeBoost(939, 10, 604800, BonusType.PLANET_APPEARANCE, BonusType.LUXURIOUS_GOLD_RESOURCE_PRODUCTION));
        boostRepository.save(makeBoost(940, 11, 604800, BonusType.PLANET_APPEARANCE, BonusType.METALLIC_METAL_RESOURCE_PRODUCTION));
        boostRepository.save(makeBoost(941, 12, 604800, BonusType.PLANET_APPEARANCE, BonusType.GASEOUS_HE3_RESOURCE_PRODUCTION));
        boostRepository.save(makeBoost(942, 13, 604800, BonusType.PLANET_APPEARANCE, BonusType.ORDINARY_PLANET));

        BotLogger.info("Game item boosters registered!");

    }

    public void setupPlanets() {

        if(planetCache.count() != 0)
            return;

        BotLogger.info("Registering game system planets...");

        List<Planet> planets = new ArrayList<>();

        List<GalaxyTile> humaroids = galaxyService.getPossibleHumaroidPositions();
        List<GalaxyTile> pdrs = galaxyService.getPossibleRBPPositions();

        long userId = 0;

        for(GalaxyTile tile : humaroids)
            planets.add(new HumaroidPlanet(tile, ++userId));

        for(GalaxyTile tile : pdrs)
            planets.add(new ResourcePlanet(tile, ++userId));

        planetCache.saveAll(planets);
        BotLogger.info("Game system planets registered!");

    }

    private GameBoost makeBoost(int propId, int mimeType, int seconds, BonusType...bonusTypes) {

        GameBoost gameBoost = new GameBoost();

        gameBoost.setPropId(propId);
        gameBoost.setMimeType(mimeType);
        gameBoost.setSeconds(seconds);

        for(BonusType bonus : bonusTypes)
            gameBoost.getBonuses().add(bonus);

        return gameBoost;

    }

    private ShipModel makeShipModel(int guid, int shipModelId, int bodyId, String name, int...parts) {

        ShipModel model = new ShipModel();

        model.setShipModelId(shipModelId);
        model.setGuid(guid);
        model.setBodyId(bodyId);
        model.setName(name);

        List<Integer> partList = new ArrayList<>();

        for(int part : parts)
            partList.add(part);

        model.setParts(partList);
        return model;

    }

}