package com.go2super.logger;

import com.go2super.service.PacketService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.exception.ExceptionUtils;
import org.fusesource.jansi.Ansi;
import org.fusesource.jansi.AnsiConsole;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import static org.fusesource.jansi.Ansi.ansi;

@Slf4j
public class BotLogger {

    private static final String pattern = "MM/dd/yyyy HH:mm:ss";
    private static final DateFormat dateFormat = new SimpleDateFormat(pattern);

    public static void setup() {
        AnsiConsole.systemInstall();
    }

    public static void log() {
        log("");
    }

    public static void log(Object message) {
        if(PacketService.getInstance().getVerbose() >= 5)
            log.info(ansi().reset().a(message).toString());
    }

    public static void chat(String message) {
        if(PacketService.getInstance().getVerbose() >= 2)
            log.info(ansi().reset().fg(Ansi.Color.GREEN).a(message).reset().toString());
    }

    public static void info(String message) {
        if(PacketService.getInstance().getVerbose() >= 3)
            log.info(ansi().reset().fg(Ansi.Color.CYAN).a(message).reset().toString());
    }

    public static void error(Exception exception) {
        if(PacketService.getInstance().getVerbose() >= 1)
            log.info(ansi().reset().fg(Ansi.Color.RED).a("ERR :: ").reset().a(ExceptionUtils.getStackTrace(exception)).toString());
    }

    public static void error(String message) {
        if(PacketService.getInstance().getVerbose() >= 1)
            log.info(ansi().reset().fg(Ansi.Color.RED).a("ERR :: ").reset().a(message).toString());
    }

    public static void warn(String message) {
        if(PacketService.getInstance().getVerbose() >= 4)
            log.info(ansi().reset().fg(Ansi.Color.YELLOW).a("WRN :: ").reset().a(message).toString());
    }

    public static void dev(String message) {
        //if(PacketService.getInstance().getVerbose() >= 1)
        //    log.info(ansi().reset().fg(Ansi.Color.MAGENTA).a("DEV :: ").reset().a(message).toString());
    }

    public static void thread(String message) {
        //if(PacketService.getInstance().getVerbose() >= 4)
            //log.info(ansi().reset().fg(Ansi.Color.YELLOW).a("TRH :: ").reset().a(message).toString());
    }

    public static void packet(String message) {
        if(PacketService.getInstance().getVerbose() >= 5)
            log.info(ansi().reset().fg(Ansi.Color.BLUE).a("PKT :: ").reset().a(message).toString());
    }

    public static void login(String message) {
        //if(PacketService.getInstance().getVerbose() >= 5)
            //log.info(ansi().reset().fg(Ansi.Color.RED).a("LOG :: ").reset().a(message).toString());
    }

    public static void debug(String message) {
        if(PacketService.getInstance().getVerbose() >= 1)
            log.info(message);
    }

    public static String getDate() {
        return dateFormat.format(Calendar.getInstance().getTime());
    }

}
