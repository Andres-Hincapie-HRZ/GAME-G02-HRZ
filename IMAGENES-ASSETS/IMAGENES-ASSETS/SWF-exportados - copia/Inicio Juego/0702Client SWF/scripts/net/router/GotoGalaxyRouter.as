package net.router
{
   import flash.utils.ByteArray;
   import logic.ui.GotoGalaxyUI;
   import net.base.NetManager;
   import net.msg.galaxyMap.MSG_RESP_LOOKUPUSERINFO;
   
   public class GotoGalaxyRouter
   {
      
      private static var _instance:GotoGalaxyRouter = null;
      
      public function GotoGalaxyRouter(param1:HHH)
      {
         super();
      }
      
      public static function resp_MSG_RESP_LOOKUPUSERINFO(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_LOOKUPUSERINFO = new MSG_RESP_LOOKUPUSERINFO();
         NetManager.Instance().readObject(_loc4_,param3);
         GotoGalaxyUI.instance.GotoGalaxyCallBack(_loc4_);
      }
      
      public static function get instance() : GotoGalaxyRouter
      {
         if(_instance == null)
         {
            _instance = new GotoGalaxyRouter(new HHH());
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
