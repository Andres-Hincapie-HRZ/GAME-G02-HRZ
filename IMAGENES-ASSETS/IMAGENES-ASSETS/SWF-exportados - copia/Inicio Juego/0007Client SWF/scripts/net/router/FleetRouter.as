package net.router
{
   import flash.utils.ByteArray;
   import logic.entry.GShipTeam;
   import logic.manager.GalaxyShipManager;
   import logic.ui.FleetEditUI;
   import logic.ui.MallUI_Sell;
   import net.base.NetManager;
   import net.msg.fleetMsg.MSG_RESP_ARRANGESHIPTEAM;
   import net.msg.fleetMsg.MSG_RESP_COMMANDERINFOARRANGE;
   import net.msg.fleetMsg.MSG_RESP_EDITSHIPTEAM;
   import net.msg.fleetMsg.MSG_RESP_GALAXYSHIP_TEMP;
   import net.msg.fleetMsg.MSG_RESP_TEAMMODELINFO;
   
   public class FleetRouter
   {
      
      private static var _instance:FleetRouter;
      
      private var TeamList:Array;
      
      public var TeamModelInfo:MSG_RESP_TEAMMODELINFO = new MSG_RESP_TEAMMODELINFO();
      
      public function FleetRouter()
      {
         super();
      }
      
      public static function get instance() : FleetRouter
      {
         if(_instance == null)
         {
            _instance = new FleetRouter();
         }
         return _instance;
      }
      
      public function resp_MSG_RESP_ARRANGESHIPTEAM(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_ARRANGESHIPTEAM = new MSG_RESP_ARRANGESHIPTEAM();
         NetManager.Instance().readObject(_loc4_,param3);
         if(_loc4_.Type == 0)
         {
            FleetEditUI.getInstance().RespArrangeShipTeam(_loc4_);
         }
         else if(_loc4_.Type == 1)
         {
            MallUI_Sell.getInstance().RespShipList(_loc4_);
         }
         else if(_loc4_.Type == 2)
         {
            DestructionShipRouter.instance.resp_shipTeamNum(_loc4_);
         }
      }
      
      public function resp_MSG_RESP_TEAMMODELINFO(param1:int, param2:int, param3:ByteArray) : void
      {
         NetManager.Instance().readObject(this.TeamModelInfo,param3);
      }
      
      public function resp_MSG_RESP_EDITSHIPTEAM(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc5_:MSG_RESP_GALAXYSHIP_TEMP = null;
         var _loc4_:MSG_RESP_EDITSHIPTEAM = new MSG_RESP_EDITSHIPTEAM();
         NetManager.Instance().readObject(_loc4_,param3);
         _loc5_ = _loc4_.Data;
         var _loc6_:GShipTeam = GalaxyShipManager.instance.getShipDatas(_loc5_.ShipTeamId);
         _loc6_.BodyId = _loc5_.BodyId;
         _loc6_.ShipNum = _loc5_.ShipNum;
         _loc6_.UserId = -1;
         _loc6_.freshShipBody();
      }
      
      public function resp_MSG_RESP_COMMANDERINFOARRANGE(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_COMMANDERINFOARRANGE = new MSG_RESP_COMMANDERINFOARRANGE();
         NetManager.Instance().readObject(_loc4_,param3);
         FleetEditUI.getInstance().IniCommanderList(_loc4_);
      }
   }
}

