package net.router
{
   import flash.utils.ByteArray;
   import logic.action.ConstructionAction;
   import logic.entry.GShipTeam;
   import logic.manager.GalaxyShipManager;
   import logic.ui.LoadFleetUI;
   import net.base.NetManager;
   import net.msg.LoadHe3.MSG_RESP_LOADSHIPTEAM;
   import net.msg.LoadHe3.MSG_RESP_LOADSHIPTEAMALL;
   import net.msg.LoadHe3.MSG_RESP_UNLOADSHIPTEAM;
   
   public class LoadHe3Router
   {
      
      private static var _instance:LoadHe3Router;
      
      public function LoadHe3Router()
      {
         super();
      }
      
      public static function get instance() : LoadHe3Router
      {
         if(_instance == null)
         {
            _instance = new LoadHe3Router();
         }
         return _instance;
      }
      
      public function resp_MSG_RESP_LOADSHIPTEAM(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_LOADSHIPTEAM = new MSG_RESP_LOADSHIPTEAM();
         NetManager.Instance().readObject(_loc4_,param3);
         var _loc5_:GShipTeam = GalaxyShipManager.instance.getShipDatas(_loc4_.ShipTeamId);
         if(_loc5_ != null)
         {
            _loc5_.Gas += _loc4_.Gas;
         }
         ConstructionAction.getInstance().costResource(_loc4_.Gas,0,0,0);
         _loc4_.release();
         _loc4_ = null;
      }
      
      public function resp_MSG_RESP_UNLOADSHIPTEAM(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_UNLOADSHIPTEAM = new MSG_RESP_UNLOADSHIPTEAM();
         NetManager.Instance().readObject(_loc4_,param3);
         var _loc5_:GShipTeam = GalaxyShipManager.instance.getShipDatas(_loc4_.ShipTeamId);
         if(_loc5_ != null)
         {
            _loc5_.Gas -= _loc4_.Gas;
         }
         ConstructionAction.getInstance().addResource(_loc4_.Gas,0,0,0);
         _loc4_.release();
         _loc4_ = null;
      }
      
      public function resp_MSG_RESP_LOADSHIPTEAMALL(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_LOADSHIPTEAMALL = new MSG_RESP_LOADSHIPTEAMALL();
         NetManager.Instance().readObject(_loc4_,param3);
         LoadFleetUI.getInstance().RespFleetList(_loc4_);
      }
   }
}

