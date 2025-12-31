package com.go2super;

import com.go2super.resources.json.*;
import com.go2super.service.*;
import com.go2super.socket.util.Crypto;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

@Slf4j
@SpringBootApplication
public class Go2SuperApplication implements ApplicationListener<ContextRefreshedEvent> {

    public static String VIRTUAL_VERSION = "V2022.2811a.closed-alpha";
    public static Date UPTIME_DATE = new Date();

    public List<Object> RUNTIME_REFLECTION = Arrays.asList(

            new GalaxyMapJson(),
            new BuildsJson(),
            new CommandersJson(),
            new TasksJson(),

            new FarmLandsJson(),
            new FieldResourcesJson(),

            new ShipPartJson(),
            new ShipBodyJson(),

            new CorpsPirateJson(),
            new CorpsShopJson(),
            new CorpsLevelJson(),
            new InstancesJson(),
            new ShipModelsJson(),

            new LotteryJson()

    );

    public static void main(String[] args) {
        SpringApplication.run(Go2SuperApplication.class, args);
    }

    @Value("${spring.application.name}")
    String name;
    @Value("${spring.application.version}")
    String version;
    @Value("${spring.application.restPort}")
    String restPort;

    @Autowired
    private GalaxyService galaxyService;
    @Autowired
    private BattleService battleService;
    @Autowired
    private PacketService packetService;
    @Autowired
    private SocketService socketService;
    @Autowired
    private JobService jobService;

    @Override
    public void onApplicationEvent(ContextRefreshedEvent event) {

        try {

            disableAccessWarnings();

            galaxyService.calculatePositions();
            // jobService.dispatcher();
            battleService.setup();
            socketService.setup();

            System.out.println(Crypto.decrypt("zp1YSRcwKMRVOvCON29wF0OJX1Pw9tf7"));
            /*
             * System.out.println(Crypto.decrypt("FAaSirPJXkHWR+E+lRAMtpzGSCcnF1Ap"));
             * System.out.println(Crypto.decrypt("mhTjpiE+tFLcwxgvqgmJH6tJcPJo67sU"));
             * System.out.println(Crypto.decrypt("0xQoHQR6rCcEUq27WU3gNW3EKEbz1XPI"));
             * System.out.println(Crypto.decrypt("oLnIMvU80lGXgnfLKjrEpIM8VyupwPCs"));
             * System.out.println(Crypto.decrypt("La89fmJq6AK/hEPGRUs3boVN8+EDSjpV"));
             * System.out.println(Crypto.decrypt("u37jA2WFA5132ZI56Ic9Ag+oqo5Iic2y"));
             * System.out.println(Crypto.decrypt("2PA2ho0okfto7jNJMPu7646UpedjwjRy"));
             * System.out.println(Crypto.decrypt("cFSiwfq9adS4T2m0g4nz6eQRlmFxNJoU"));
             * System.out.println(Crypto.decrypt("P5m+xxU7GTo1aSw/gEJIMREfBJqEkdnL"));
             */

            log.info("SuperGO2 server has been initialized!");

            /*
             * Runnable runnable = new Runnable() {
             * 
             * @Override
             * public void run() {
             * while(true) {
             * int testId = AutoIncrementService.getInstance().getNextTestId();
             * System.out.println("TestID: " + testId);
             * }
             * }
             * };
             * 
             * Thread threadA = new Thread(runnable);
             * Thread threadB = new Thread(runnable);
             * Thread threadC = new Thread(runnable);
             * 
             * threadA.start();
             * threadB.start();
             * threadC.start();
             */

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public static void disableAccessWarnings() {

        try {

            Class unsafeClass = Class.forName("sun.misc.Unsafe");
            Field field = unsafeClass.getDeclaredField("theUnsafe");
            field.setAccessible(true);
            Object unsafe = field.get(null);

            Method putObjectVolatile = unsafeClass.getDeclaredMethod("putObjectVolatile", Object.class, long.class,
                    Object.class);
            Method staticFieldOffset = unsafeClass.getDeclaredMethod("staticFieldOffset", Field.class);

            Class loggerClass = Class.forName("jdk.internal.module.IllegalAccessLogger");
            Field loggerField = loggerClass.getDeclaredField("logger");
            Long offset = (Long) staticFieldOffset.invoke(unsafe, loggerField);

            putObjectVolatile.invoke(unsafe, loggerClass, offset, null);

        } catch (Exception ignored) {
        }

    }

}
