package com.go2super.service.command.trigger;

import com.go2super.database.entity.Account;
import com.go2super.database.entity.User;
import com.go2super.database.entity.sub.Email;
import com.go2super.database.entity.sub.EmailGood;
import com.go2super.database.entity.sub.UserEmailStorage;
import com.go2super.obj.entry.SmartServer;
import com.go2super.obj.model.LoggedGameUser;
import com.go2super.packet.mail.ResponseNewEmailNoticePacket;
import com.go2super.resources.ResourceManager;
import com.go2super.resources.data.PropData;
import com.go2super.service.UserService;
import com.go2super.service.command.Command;
import com.go2super.socket.util.DateUtil;

import java.util.ArrayList;
import java.util.Optional;

public class GiftCommand extends Command {

    public GiftCommand() {
        super("gift", "permission.gift");
    }

    @Override
    public void execute(User user, Account account, SmartServer smartServer, String label, String[] parts) {

        if(parts.length < 4) {

            sendMessage("Command 'gift' need more arguments!", user);
            return;

        }

        String lock = parts[1];
        boolean isLock = false;

        if(lock.equals("lock")) isLock = true;

        int propId = -1;
        int amount = -1;

        propId = Integer.parseInt(parts[2]);
        amount = Integer.parseInt(parts[3]);

        if(propId < 0 || amount < 0 || amount > 9999) {

            sendMessage("Invalid arguments for 'gift' command! (gift lock <propId> <amount>)", user);
            return;

        }

        PropData propData = ResourceManager.getProps().getData(propId);

        if(propData == null && propId > 2501) {

            sendMessage("Invalid propId argument for 'give' command! (give lock <propId> <amount>)", user);
            return;

        }

        int[] propIds = new int[10];
        int[] propNums = new int[10];

        propIds[0] = propId;
        propNums[0] = amount;

        sendMessage("Gift sent!", user);

        ResponseNewEmailNoticePacket noticePacket = ResponseNewEmailNoticePacket.builder()
                .errorCode(0)
                .build();

        for(User player : UserService.getInstance().getUserCache().findAll()) {

            UserEmailStorage userEmailStorage = player.getUserEmailStorage();

            Email email = Email.builder()
                    .autoId(userEmailStorage.nextAutoId())
                    .type(2)
                    .name("System")
                    .subject("\uD83C\uDF81 Council Gift")
                    .emailContent(
                            "Dear Commander " + player.getUsername() + ", \n" +
                            "Thank you for being part of the Alpha, here's a gift for you, we hope it will be very useful to you!")
                    .readFlag(0)
                    .date(DateUtil.now())
                    .goods(new ArrayList<>())
                    .guid(-1)
                    .build();

            email.addGood(EmailGood.builder()
                    .goodId(propId)
                    .lockNum(isLock ? amount : 0)
                    .num(isLock ? 0 : amount)
                    .build());

            userEmailStorage.addEmail(email);

            player.update();
            player.save();

            Optional<LoggedGameUser> optionalGameUser = player.getLoggedGameUser();
            if(optionalGameUser.isPresent()) {

                optionalGameUser.get().getSmartServer().send(noticePacket);
                sendMessage("You have received a gift from the council!", player);

            }

        }

    }

}
