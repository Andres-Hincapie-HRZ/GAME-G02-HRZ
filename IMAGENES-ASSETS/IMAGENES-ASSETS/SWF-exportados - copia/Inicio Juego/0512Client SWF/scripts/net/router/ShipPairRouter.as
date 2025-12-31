package net.router
{
   import flash.utils.ByteArray;
   import logic.ui.ShipPairUI;
   import net.base.NetManager;
   import net.msg.ship.MSG_RESP_BRUISESHIPDELETE;
   import net.msg.ship.MSG_RESP_BRUISESHIPINFO;
   import net.msg.ship.MSG_RESP_BRUISESHIPRELIVE;
   import net.msg.ship.MSG_RESP_SPEEDBRUISESHIP;
   
   public class ShipPairRouter
   {
      
      private static var _instance:ShipPairRouter;
      
      public function ShipPairRouter()
      {
         super();
      }
      
      public static function get instance() : ShipPairRouter
      {
         if(_instance == null)
         {
            _instance = new ShipPairRouter();
         }
         return _instance;
      }
      
      public function resp_MSG_RESP_BRUISESHIPINFO(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_BRUISESHIPINFO = new MSG_RESP_BRUISESHIPINFO();
         NetManager.Instance().readObject(_loc4_,param3);
         ShipPairUI.getInstance().RespShipList(_loc4_);
      }
      
      public function resp_MSG_RESP_SPEEDBRUISESHIP(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_SPEEDBRUISESHIP = new MSG_RESP_SPEEDBRUISESHIP();
         NetManager.Instance().readObject(_loc4_,param3);
         ShipPairUI.getInstance().RespSpeetPair(_loc4_);
      }
      
      public function resp_MSG_RESP_BRUISESHIPRELIVE(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_BRUISESHIPRELIVE = new MSG_RESP_BRUISESHIPRELIVE();
         NetManager.Instance().readObject(_loc4_,param3);
         ShipPairUI.getInstance().RespPair(_loc4_);
      }
      
      public function resp_MSG_RESP_BRUISESHIPDELETE(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_BRUISESHIPDELETE = new MSG_RESP_BRUISESHIPDELETE();
         NetManager.Instance().readObject(_loc4_,param3);
         ShipPairUI.getInstance().RespDeleteShip(_loc4_);
      }
   }
}

