package com.go2super.service.command.trigger;

import com.go2super.database.entity.Account;
import com.go2super.database.entity.User;
import com.go2super.obj.entry.SmartServer;
import com.go2super.service.PacketService;
import com.go2super.service.command.Command;

public class IconCommand extends Command {

    public IconCommand() {
        super("icon", "permission.icon", "permission.qa");
    }

    @Override
    public void execute(User user, Account account, SmartServer smartServer, String label, String[] parts) {

        if(parts.length < 2) {

            sendMessage("Your current icon is " + user.getIcon() + ".", user);
            sendMessage("For change your icon you need to type the id (example: /icon 1)", user);
            return;

        }

        int icon = Integer.parseInt(parts[1]);

        if(icon == 1000) {

            boolean staff = account.getUserRank().hasPermission("permission.staff");
            if(!staff) icon = -1;

        } else if(icon < 1 || icon > 15) icon = -1;

        if(icon == -1) {

            sendMessage("That icon does not exists! The range is 1-15", user);
            return;

        }

        user.setIcon(icon);

        user.update();
        user.save();

        smartServer.send(PacketService.getInstance().getMoreInfoPacket(0, user));
        sendMessage("Your icon has been changed!", user);

    }

}
