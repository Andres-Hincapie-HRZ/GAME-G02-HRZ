package com.go2super.service.command.trigger;

import com.go2super.database.entity.Account;
import com.go2super.database.entity.User;
import com.go2super.obj.entry.SmartServer;
import com.go2super.service.ChatService;
import com.go2super.service.JobService;
import com.go2super.service.command.Command;
import com.go2super.socket.util.TimeReader;

import java.time.Duration;
import java.util.concurrent.ScheduledFuture;

public class RestartCommand extends Command {

    public ScheduledFuture nextScheduledRestart;
    private int leftSeconds;

    public static final TimeReader timeReader =
            new TimeReader()
                    .addUnit("h", 3600000l)
                    .addUnit("m", 60000l)
                    .addUnit("s", 1000l);

    public RestartCommand() {
        super("restart", "permission.restart");
    }

    @Override
    public void execute(User user, Account account, SmartServer smartServer, String label, String[] parts) {

        if(parts.length < 1) {

            ChatService.getInstance().broadcastMessage("Restarting server...");
            System.exit(0);
            return;

        }

        if(nextScheduledRestart != null) {

            nextScheduledRestart.cancel(false);

            leftSeconds = 0;
            nextScheduledRestart = null;

            ChatService.getInstance().broadcastMessage("Scheduled restart has been cancelled.");
            return;

        }

        String delayToRestart = "";
        for(int i = 1; i < parts.length; i++) delayToRestart += parts[i];

        long parsed = timeReader.parse(delayToRestart);
        leftSeconds = (int) (parsed / 1000);

        if(leftSeconds <= 0) {

            ChatService.getInstance().broadcastMessage("Restarting server...");
            System.exit(0);
            return;

        }

        nextScheduledRestart = JobService.getInstance().getExecutor().scheduleAtFixedRate(() -> {

            leftSeconds--;

            if(leftSeconds == 60 * 5) {
                ChatService.getInstance().broadcastMessage("Restarting server in 5 minutes...");
            } else if(leftSeconds == 60) {
                ChatService.getInstance().broadcastMessage("Restarting server in 1 minute...");
            } else if(leftSeconds <= 5 && leftSeconds > 0) {
                if(leftSeconds == 1) {
                    ChatService.getInstance().broadcastMessage("Restarting server in 1 second...");
                } else {
                    ChatService.getInstance().broadcastMessage("Restarting server in " + leftSeconds + " seconds...");
                }
            } else if(leftSeconds == 0) {

                ChatService.getInstance().broadcastMessage("Restarting server...");
                System.exit(0);

            }

        }, Duration.ofSeconds(1));

    }

}
