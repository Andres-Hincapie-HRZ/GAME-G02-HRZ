package net.router
{
   import flash.utils.ByteArray;
   import logic.entry.GamePlayer;
   import logic.ui.GalaxyMatchUI;
   import net.base.NetManager;
   import net.msg.match.MSG_REQUEST_MATCHINFO;
   import net.msg.match.MSG_REQUEST_MATCHPAGE;
   import net.msg.match.MSG_RESP_MATCHINFO;
   import net.msg.match.MSG_RESP_MATCHPAGE;
   
   public class GalaxyMatchRouter
   {
      
      private static var _instance:GalaxyMatchRouter = null;
      
      public function GalaxyMatchRouter(param1:HHH)
      {
         super();
      }
      
      public static function request_MSG_REQUEST_MATCHINFO() : void
      {
         var _loc1_:MSG_REQUEST_MATCHINFO = new MSG_REQUEST_MATCHINFO();
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc1_);
      }
      
      public static function resp_MSG_RESP_MATCHINFO(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_MATCHINFO = new MSG_RESP_MATCHINFO();
         NetManager.Instance().readObject(_loc4_,param3);
         GalaxyMatchUI.instance.InitUI(_loc4_);
      }
      
      public static function request_MSG_REQUEST_MATCHPAGE(param1:int = 0) : void
      {
         var _loc2_:MSG_REQUEST_MATCHPAGE = null;
         _loc2_ = new MSG_REQUEST_MATCHPAGE();
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         _loc2_.PageId = param1;
         NetManager.Instance().sendObject(_loc2_);
      }
      
      public static function resp_MSG_RESP_MATCHPAGE(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_MATCHPAGE = new MSG_RESP_MATCHPAGE();
         NetManager.Instance().readObject(_loc4_,param3);
         GalaxyMatchUI.instance.InitTop(_loc4_);
      }
      
      public static function get instance() : GalaxyMatchRouter
      {
         if(!_instance)
         {
            _instance = new GalaxyMatchRouter(new HHH());
         }
         return _instance;
      }
   }
}

class HHH
{
   
   public function HHH()
   {
      super();
   }
}
