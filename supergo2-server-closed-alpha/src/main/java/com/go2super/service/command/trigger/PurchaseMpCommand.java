package com.go2super.service.command.trigger;

import com.go2super.database.entity.Account;
import com.go2super.database.entity.User;
import com.go2super.obj.entry.SmartServer;
import com.go2super.obj.model.LoggedGameUser;
import com.go2super.packet.payment.ResponsePaymentSucceedPacket;
import com.go2super.service.UserService;
import com.go2super.service.command.Command;

import java.util.Optional;

public class PurchaseMpCommand extends Command {

    public PurchaseMpCommand() {
        super("purchasemp", "permission.purchasemp");
    }

    @Override
    public void execute(User user, Account account, SmartServer smartServer, String label, String[] parts) {

        if(parts.length < 3) {

            sendMessage("Command 'purchasemp' has invalid arguments! (purchasemp <guid> <mp>)", user);
            return;

        }

        int guid = Integer.parseInt(parts[1]);
        int mp = Integer.parseInt(parts[2]);

        User receiver = UserService.getInstance().getUserCache().findByGuid(guid);

        if(receiver == null) {

            sendMessage("Receiver with id " + guid + " does not exists!", user);
            return;

        }

        receiver.getResources().addMallPoints(mp);
        receiver.save();

        Optional<LoggedGameUser> optional = receiver.getLoggedGameUser();

        if(optional.isPresent()) {

            ResponsePaymentSucceedPacket responsePaymentSucceedPacket = new ResponsePaymentSucceedPacket();
            responsePaymentSucceedPacket.setCredit(mp);
            optional.get().getSmartServer().send(responsePaymentSucceedPacket);

            sendMessage("You have received " + mp + " MP!", receiver);

        }

        sendMessage("MP sent!", user);

    }

}
