package com.go2super.service.jobs.trade;

import com.go2super.database.entity.Trade;
import com.go2super.database.entity.User;
import com.go2super.service.JobService;
import com.go2super.service.TradeService;
import com.go2super.service.UserService;
import com.go2super.service.jobs.OfflineJob;
import com.go2super.socket.util.DateUtil;

import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

public class TradeJob implements OfflineJob {

    private long lastExecution = 0L;

    @Override
    public void setup() {

    }

    @Override
    public void run() {

        if(DateUtil.millis() - lastExecution < getInterval()) return;
        lastExecution = DateUtil.millis();

        List<Trade> trades = TradeService.getInstance().getTradeCache().findAll();
        CopyOnWriteArrayList<Integer> toUpdate = new CopyOnWriteArrayList<>();

        for(Trade trade : trades) {

            if(DateUtil.remains(trade.getUntil()).intValue() <= 0) toUpdate.add(trade.getTradeId());

        }

        if(toUpdate.size() > 0) {

            JobService.submit(() -> {

                List<Trade> toUpdateTrades = TradeService.getInstance().getTradeCache().findByTradeId(toUpdate);

                for(Trade trade : toUpdateTrades) {

                    if(trade == null) continue;
                    if(DateUtil.remains(trade.getUntil()).intValue() <= 0) {

                        User user = UserService.getInstance().getUserCache().findByGuid(trade.getSellerGuid());

                        TradeService.getInstance().getTradeCache().delete(trade);
                        TradeService.getInstance().giveTrade(user, null, trade);

                        user.update();
                        user.save();

                    }

                }

            }, "trade-job");

        }

    }

    @Override
    public long getInterval() {
        return 2000L;
    }

}
