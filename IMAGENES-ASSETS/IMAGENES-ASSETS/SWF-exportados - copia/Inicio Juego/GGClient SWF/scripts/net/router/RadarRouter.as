package net.router
{
   import flash.utils.ByteArray;
   import logic.widget.NotifyWidget;
   import net.base.NetManager;
   import net.msg.radarMsg.MSG_RESP_JUMPSHIPTEAMNOTICE;
   
   public class RadarRouter
   {
      
      private static var _instance:RadarRouter;
      
      public function RadarRouter()
      {
         super();
      }
      
      public static function get instance() : RadarRouter
      {
         if(_instance == null)
         {
            _instance = new RadarRouter();
         }
         return _instance;
      }
      
      public function resp_MSG_RESP_JUMPSHIPTEAMNOTICE(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_JUMPSHIPTEAMNOTICE = new MSG_RESP_JUMPSHIPTEAMNOTICE();
         NetManager.Instance().readObject(_loc4_,param3);
         if(_loc4_.Type == 2)
         {
            NotifyWidget.getInstance().addNotify(2);
            NotifyWidget.getInstance().addNotify(3);
         }
         else
         {
            NotifyWidget.getInstance().addNotify(2 + _loc4_.Type);
         }
      }
   }
}

