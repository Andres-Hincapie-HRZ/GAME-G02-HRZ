package net.router
{
   import flash.utils.ByteArray;
   import logic.entry.GamePlayer;
   import logic.ui.ResPlaneUI;
   import net.base.NetManager;
   import net.msg.reward.MSG_RESP_GETONLINEAWARD;
   import net.msg.reward.MSG_RESP_ONLINEAWARD;
   
   public class RewardRouter
   {
      
      private static var _instance:RewardRouter;
      
      public function RewardRouter()
      {
         super();
      }
      
      public static function get instance() : RewardRouter
      {
         if(_instance == null)
         {
            _instance = new RewardRouter();
         }
         return _instance;
      }
      
      public function Resp_MSG_RESP_ONLINEAWARD(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_ONLINEAWARD = new MSG_RESP_ONLINEAWARD();
         NetManager.Instance().readObject(_loc4_,param3);
         GamePlayer.getInstance().RewardMsg = _loc4_;
         ResPlaneUI.getInstance().ShowReward();
      }
      
      public function Resp_MSG_RESP_GETONLINEAWARD(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_GETONLINEAWARD = new MSG_RESP_GETONLINEAWARD();
         NetManager.Instance().readObject(_loc4_,param3);
         ResPlaneUI.getInstance().Resp_MSG_RESP_GETONLINEAWARD(_loc4_);
      }
   }
}

