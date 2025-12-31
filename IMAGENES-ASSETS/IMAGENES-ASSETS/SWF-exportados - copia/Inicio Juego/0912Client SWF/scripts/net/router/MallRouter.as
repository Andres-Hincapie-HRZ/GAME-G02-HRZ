package net.router
{
   import com.star.frameworks.managers.StringManager;
   import flash.utils.ByteArray;
   import logic.action.ConstructionAction;
   import logic.entry.GamePlayer;
   import logic.entry.props.propsInfo;
   import logic.reader.CPropsReader;
   import logic.ui.BuyGoodsUI;
   import logic.ui.ChipLottery;
   import logic.ui.MallUI_Buy;
   import logic.ui.MallUI_Sell;
   import logic.ui.MallUI_Selling;
   import logic.ui.MessagePopup;
   import logic.ui.PackUi;
   import logic.utils.UpdateResource;
   import net.base.NetManager;
   import net.msg.mall.MSG_RESP_BUYGOODS;
   import net.msg.mall.MSG_RESP_BUYTRADEGOODS;
   import net.msg.mall.MSG_RESP_MYTRADEINFO;
   import net.msg.mall.MSG_RESP_TRADEGOODS;
   import net.msg.mall.MSG_RESP_TRADEINFO;
   
   public class MallRouter
   {
      
      private static var _instance:MallRouter;
      
      public var OnBuyGood:Function;
      
      public function MallRouter()
      {
         super();
      }
      
      public static function get instance() : MallRouter
      {
         if(_instance == null)
         {
            _instance = new MallRouter();
         }
         return _instance;
      }
      
      public function resp_MSG_RESP_TRADEGOODS(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_TRADEGOODS = new MSG_RESP_TRADEGOODS();
         NetManager.Instance().readObject(_loc4_,param3);
         if(_loc4_.ErrorCode == 0)
         {
            if(_loc4_.PriceType == 0)
            {
               ConstructionAction.getInstance().costResource(0,0,_loc4_.Value,0);
            }
            else
            {
               ConstructionAction.getInstance().costResource(0,0,0,_loc4_.Value);
            }
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("AuctionText42"),0);
         }
         else
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("AuctionText43"),0);
         }
         MallUI_Sell.getInstance().RespTrade(_loc4_);
         PackUi.getInstance().updateuseHd();
      }
      
      public function resp_MSG_RESP_MYTRADEINFO(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_MYTRADEINFO = new MSG_RESP_MYTRADEINFO();
         NetManager.Instance().readObject(_loc4_,param3);
         MallUI_Selling.getInstance().RespMyTradeInfo(_loc4_);
      }
      
      public function resp_MSG_RESP_TRADEINFO(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_TRADEINFO = new MSG_RESP_TRADEINFO();
         NetManager.Instance().readObject(_loc4_,param3);
         MallUI_Buy.getInstance().RespTradeInfo(_loc4_);
      }
      
      public function resp_MSG_RESP_BUYTRADEGOODS(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_BUYTRADEGOODS = new MSG_RESP_BUYTRADEGOODS();
         NetManager.Instance().readObject(_loc4_,param3);
         MallUI_Buy.getInstance().RespBuyResult(_loc4_);
         if(_loc4_.ErrorCode == 0)
         {
            if(_loc4_.PriceType == 0)
            {
               ConstructionAction.getInstance().costResource(0,0,_loc4_.Price,0);
            }
            else
            {
               ConstructionAction.getInstance().costResource(0,0,0,_loc4_.Price);
            }
            MallUI_Buy.getInstance().RespBuyResult(_loc4_);
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("AuctionText35"),1);
         }
         else if(_loc4_.ErrorCode == 1)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("AuctionText36"),1);
         }
         else if(_loc4_.ErrorCode == 2)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("ShipText27"),1);
         }
      }
      
      public function resp_MSG_RESP_BUYGOODS(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_BUYGOODS = new MSG_RESP_BUYGOODS();
         NetManager.Instance().readObject(_loc4_,param3);
         if(_loc4_.PropsId == 4221)
         {
            ChipLottery.getInstance().OnBuyExp(_loc4_);
            return;
         }
         this.AddToPack(_loc4_.PropsId,_loc4_.Num,_loc4_.LockFlag);
         var _loc5_:propsInfo = CPropsReader.getInstance().GetPropsInfo(_loc4_.PropsId);
         if(_loc4_.Type == 0)
         {
            ConstructionAction.getInstance().costResource(0,0,0,_loc4_.Price);
         }
         else if(_loc4_.Type == 1)
         {
            GamePlayer.getInstance().coins = GamePlayer.getInstance().coins - _loc4_.Price;
         }
         else if(_loc4_.Type == 2)
         {
            GamePlayer.getInstance().Badge = GamePlayer.getInstance().Badge - _loc4_.Price;
         }
         else if(_loc4_.Type == 3)
         {
            GamePlayer.getInstance().Honor = GamePlayer.getInstance().Honor - _loc4_.Price;
         }
         var _loc6_:String = StringManager.getInstance().getMessageString("AuctionText34");
         _loc6_ = _loc6_.replace("@@1",_loc5_.Name);
         MessagePopup.getInstance().Show(_loc6_,0);
         if(this.OnBuyGood != null)
         {
            this.OnBuyGood(_loc4_);
            this.OnBuyGood = null;
         }
         else
         {
            BuyGoodsUI.getInstance().ShowCash();
         }
         this.UpdateLimitValue(_loc4_.PropsId,_loc4_.Num);
      }
      
      private function UpdateLimitValue(param1:int, param2:int) : void
      {
         if(param1 == 918)
         {
            GamePlayer.getInstance().MoneyBuyNum = GamePlayer.getInstance().MoneyBuyNum + param2;
         }
      }
      
      private function AddToPack(param1:int, param2:int, param3:int) : void
      {
         UpdateResource.getInstance().AddToPack(param1,param2,param3);
      }
   }
}

