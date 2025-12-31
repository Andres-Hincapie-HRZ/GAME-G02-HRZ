package net.router
{
   import flash.utils.ByteArray;
   import logic.action.ConstructionAction;
   import logic.entry.GamePlayer;
   import logic.entry.shipmodel.ShipTeamNum;
   import logic.ui.DestructionShipUI;
   import net.base.NetManager;
   import net.msg.DestructionShipMsg.*;
   import net.msg.fleetMsg.MSG_REQUEST_ARRANGESHIPTEAM;
   import net.msg.fleetMsg.MSG_RESP_ARRANGESHIPTEAM;
   
   public class DestructionShipRouter
   {
      
      private static var _instance:DestructionShipRouter = null;
      
      public var m_ShipTeamNumAry:Array = new Array();
      
      public function DestructionShipRouter()
      {
         super();
      }
      
      public static function get instance() : DestructionShipRouter
      {
         if(_instance == null)
         {
            _instance = new DestructionShipRouter();
         }
         return _instance;
      }
      
      public function sendmsgARRANGESHIPTEAM() : void
      {
         var _loc1_:MSG_REQUEST_ARRANGESHIPTEAM = new MSG_REQUEST_ARRANGESHIPTEAM();
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         _loc1_.Type = 2;
         NetManager.Instance().sendObject(_loc1_);
      }
      
      public function resp_shipTeamNum(param1:MSG_RESP_ARRANGESHIPTEAM) : void
      {
         var _loc3_:ShipTeamNum = null;
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < param1.DataLen)
         {
            _loc3_ = new ShipTeamNum();
            _loc4_ = false;
            _loc5_ = 0;
            while(_loc5_ < this.m_ShipTeamNumAry.length)
            {
               if(this.m_ShipTeamNumAry[_loc5_].ShipModelId == param1.TeamBody[_loc2_].ShipModelId)
               {
                  this.m_ShipTeamNumAry[_loc5_].Num = param1.TeamBody[_loc2_].Num;
                  _loc4_ = true;
                  break;
               }
               _loc5_++;
            }
            if(_loc4_ == false)
            {
               _loc3_.ShipModelId = param1.TeamBody[_loc2_].ShipModelId;
               _loc3_.Num = param1.TeamBody[_loc2_].Num;
               this.m_ShipTeamNumAry.push(_loc3_);
            }
            _loc2_++;
         }
         DestructionShipUI.getinstance().shipmodelInfo();
         DestructionShipUI.getinstance().InitPopUp();
      }
      
      public function sendmsgDESTROYSHIP(param1:int, param2:Array) : void
      {
         var _loc3_:MSG_REQUEST_DESTROYSHIP = new MSG_REQUEST_DESTROYSHIP();
         _loc3_.SeqId = GamePlayer.getInstance().seqID++;
         _loc3_.Guid = GamePlayer.getInstance().Guid;
         _loc3_.DataLen = param1;
         var _loc4_:int = 0;
         while(_loc4_ < param1)
         {
            _loc3_.Data[_loc4_].ShipModelId = param2[_loc4_].ShipModelId;
            _loc3_.Data[_loc4_].Num = param2[_loc4_].Num;
            _loc4_++;
         }
         NetManager.Instance().sendObject(_loc3_);
      }
      
      public function resp_MSG_RESP_DESTROYSHIP(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_DESTROYSHIP = new MSG_RESP_DESTROYSHIP();
         NetManager.Instance().readObject(_loc4_,param3);
         ConstructionAction.getInstance().addResource(_loc4_.Gas,_loc4_.Metal,_loc4_.Money,0);
         DestructionShipUI.getinstance().deleteDamageShipAry();
      }
   }
}

