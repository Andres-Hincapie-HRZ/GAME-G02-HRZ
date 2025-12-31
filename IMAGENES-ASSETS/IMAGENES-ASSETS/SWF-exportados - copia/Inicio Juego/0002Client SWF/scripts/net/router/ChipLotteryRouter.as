package net.router
{
   import com.star.frameworks.managers.StringManager;
   import flash.utils.ByteArray;
   import logic.action.ChatAction;
   import logic.entry.ChannelEnum;
   import logic.entry.GamePlayer;
   import logic.entry.props.propsInfo;
   import logic.reader.CPropsReader;
   import logic.ui.ChipLottery;
   import logic.ui.ComposeUI_CommanderChip;
   import logic.ui.SaleForPriatecoinUI;
   import net.base.NetManager;
   import net.msg.ChipLottery.MSG_RESP_CMOSLOTTERYINFO;
   import net.msg.ChipLottery.MSG_RESP_GAINCMOSLOTTERY;
   
   public class ChipLotteryRouter
   {
      
      private static var _instance:ChipLotteryRouter;
      
      public var FirstShow:Boolean = true;
      
      public function ChipLotteryRouter()
      {
         super();
      }
      
      public static function get instance() : ChipLotteryRouter
      {
         if(_instance == null)
         {
            _instance = new ChipLotteryRouter();
         }
         return _instance;
      }
      
      public function Resp_MSG_RESP_CMOSLOTTERYINFO(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_CMOSLOTTERYINFO = new MSG_RESP_CMOSLOTTERYINFO();
         NetManager.Instance().readObject(_loc4_,param3);
         ChipLottery.getInstance().Resp_MSG_RESP_CMOSLOTTERYINFO(_loc4_);
         ComposeUI_CommanderChip.GetInstance().Resp_MSG_RESP_CMOSLOTTERYINFO(_loc4_);
         if(SaleForPriatecoinUI.getInstance().SaleCount > 0)
         {
            --SaleForPriatecoinUI.getInstance().SaleCount;
            if(SaleForPriatecoinUI.getInstance().SaleCount == 0)
            {
               SaleForPriatecoinUI.getInstance().Clear();
               SaleForPriatecoinUI.getInstance().SetPriateCoins(_loc4_.PirateMoney);
            }
         }
         this.FirstShow = false;
      }
      
      public function Resp_MSG_RESP_GAINCMOSLOTTERY(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc5_:propsInfo = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc4_:MSG_RESP_GAINCMOSLOTTERY = new MSG_RESP_GAINCMOSLOTTERY();
         NetManager.Instance().readObject(_loc4_,param3);
         if(_loc4_.Guid == GamePlayer.getInstance().Guid)
         {
            ChipLottery.getInstance().Resp_MSG_RESP_GAINCMOSLOTTERY(_loc4_);
         }
         if(_loc4_.BroFlag == 1)
         {
            _loc5_ = CPropsReader.getInstance().GetPropsInfo(_loc4_.PropsId);
            if(_loc5_.PropsColor == 3)
            {
               _loc6_ = "#FF00FF";
            }
            else if(_loc5_.PropsColor == 4)
            {
               _loc6_ = "#FF9900";
            }
            _loc7_ = StringManager.getInstance().getMessageString("Boss77");
            _loc7_ = _loc7_.replace("@@1","<a href=\"event:" + _loc4_.Guid + "," + _loc4_.Name + "\">[" + _loc4_.Name + "]</a>");
            _loc7_ = _loc7_ + ("<font color=\'" + _loc6_ + "\'><a href=\"event:" + ChatAction.TOOL_TYPE + "," + _loc5_.Id + "," + _loc4_.Guid + "," + _loc5_.Name + "\">" + "[" + _loc5_.Name + "]" + "</a></font>");
            ChatAction.getInstance().appendMsgContent(_loc7_,ChannelEnum.CHANNEL_SYSTEM,_loc4_.Name);
         }
      }
   }
}

