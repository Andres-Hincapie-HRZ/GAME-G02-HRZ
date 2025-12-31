package net.msg.fightMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.msg.ship.MSG_RESP_SHIPFIGHT;
   
   public class MSG_RESP_FIGHTSECTION extends MsgHead
   {
      
      private var MAX_SHIPTEAMBODY:int = 9;
      
      private var MAX_FIGHTMOVEPATH:int = 16;
      
      public var GalaxyId:int = -1;
      
      public var NeedTime:uint = 0;
      
      public var BoutId:int;
      
      public var SrcShipTeamId:int = -1;
      
      public var ObjShipTeamId:int = -1;
      
      public var SrcRepairSupply:int = 0;
      
      public var SrcRepairShield:Array;
      
      public var SrcRepairEndure:Array;
      
      public var ObjRepairShield:Array;
      
      public var ObjRepairEndure:Array;
      
      public var GalaxyMapId:int = -1;
      
      public var SrcSkill:int = 0;
      
      public var SrcDirection:int = 0;
      
      public var DelFlag:int = 0;
      
      public var BothStatus:int = 0;
      
      public var RepelStep:int = 0;
      
      public var SrcMovePath:Array;
      
      public var ObjMatrixId:Array;
      
      public var ShipFight:Array;
      
      public function MSG_RESP_FIGHTSECTION()
      {
         var _loc3_:MSG_RESP_SHIPFIGHT = null;
         this.SrcRepairShield = new Array(this.MAX_SHIPTEAMBODY);
         this.SrcRepairEndure = new Array(this.MAX_SHIPTEAMBODY);
         this.ObjRepairShield = new Array(this.MAX_SHIPTEAMBODY);
         this.ObjRepairEndure = new Array(this.MAX_SHIPTEAMBODY);
         this.SrcMovePath = new Array(this.MAX_FIGHTMOVEPATH);
         this.ObjMatrixId = new Array(this.MAX_SHIPTEAMBODY);
         this.ShipFight = new Array(this.MAX_SHIPTEAMBODY);
         super();
         var _loc1_:int = 0;
         while(_loc1_ < this.MAX_SHIPTEAMBODY)
         {
            _loc3_ = new MSG_RESP_SHIPFIGHT();
            this.ShipFight[_loc1_] = _loc3_;
            _loc1_++;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this.MAX_SHIPTEAMBODY)
         {
            this.ObjMatrixId[_loc2_] = -1;
            this.SrcRepairShield[_loc2_] = 0;
            this.SrcRepairEndure[_loc2_] = 0;
            this.ObjRepairShield[_loc2_] = 0;
            this.ObjRepairEndure[_loc2_] = 0;
            _loc2_++;
         }
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.GalaxyId = _loc2_.readInt(param1);
         this.NeedTime = _loc2_.readUnsignShort(param1);
         this.BoutId = _loc2_.readShort(param1);
         this.SrcShipTeamId = _loc2_.readInt(param1);
         this.ObjShipTeamId = _loc2_.readInt(param1);
         this.SrcRepairSupply = _loc2_.readInt(param1);
         var _loc3_:int = 0;
         while(_loc3_ < this.MAX_SHIPTEAMBODY)
         {
            if(param1.length - param1.position >= 4)
            {
               this.SrcRepairShield[_loc3_] = _loc2_.readInt(param1);
            }
            _loc3_++;
         }
         var _loc4_:int = 0;
         while(_loc4_ < this.MAX_SHIPTEAMBODY)
         {
            if(param1.length - param1.position >= 4)
            {
               this.SrcRepairEndure[_loc4_] = _loc2_.readInt(param1);
            }
            _loc4_++;
         }
         var _loc5_:int = 0;
         while(_loc5_ < this.MAX_SHIPTEAMBODY)
         {
            if(param1.length - param1.position >= 4)
            {
               this.ObjRepairShield[_loc5_] = _loc2_.readInt(param1);
            }
            _loc5_++;
         }
         var _loc6_:int = 0;
         while(_loc6_ < this.MAX_SHIPTEAMBODY)
         {
            if(param1.length - param1.position >= 4)
            {
               this.ObjRepairEndure[_loc6_] = _loc2_.readInt(param1);
            }
            _loc6_++;
         }
         this.GalaxyMapId = _loc2_.readChar(param1);
         this.SrcSkill = _loc2_.readUnsignChar(param1);
         this.SrcDirection = _loc2_.readChar(param1);
         this.DelFlag = _loc2_.readChar(param1);
         this.BothStatus = _loc2_.readChar(param1);
         this.RepelStep = _loc2_.readChar(param1);
         var _loc7_:int = 0;
         while(_loc7_ < this.MAX_FIGHTMOVEPATH)
         {
            this.SrcMovePath[_loc7_] = _loc2_.readChar(param1);
            _loc7_++;
         }
         var _loc8_:int = 0;
         while(_loc8_ < this.MAX_SHIPTEAMBODY)
         {
            this.ObjMatrixId[_loc8_] = _loc2_.readChar(param1);
            _loc8_++;
         }
         var _loc9_:int = 0;
         while(_loc9_ < this.MAX_SHIPTEAMBODY)
         {
            if(param1.length > param1.position)
            {
               this.ShipFight[_loc9_].readBuf(param1);
            }
            _loc9_++;
         }
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 20;
         param1 += this.MAX_SHIPTEAMBODY * 4;
         param1 += this.MAX_SHIPTEAMBODY * 4;
         param1 += this.MAX_SHIPTEAMBODY * 4;
         param1 += this.MAX_SHIPTEAMBODY * 4;
         param1 += 6;
         param1 += this.MAX_FIGHTMOVEPATH;
         param1 += this.MAX_SHIPTEAMBODY;
         var _loc2_:int = 0;
         while(_loc2_ < this.MAX_SHIPTEAMBODY)
         {
            param1 = int(this.ShipFight[_loc2_].getLength(param1));
            _loc2_++;
         }
         return param1;
      }
      
      public function release() : void
      {
         this.SrcRepairShield.splice(0);
         this.SrcRepairShield = null;
         this.SrcRepairEndure.splice(0);
         this.SrcRepairEndure = null;
         this.ObjRepairShield.splice(0);
         this.ObjRepairShield = null;
         this.ObjRepairEndure.splice(0);
         this.ObjRepairEndure = null;
         this.SrcMovePath.splice(0);
         this.SrcMovePath = null;
         this.ObjMatrixId.splice(0);
         this.ObjMatrixId = null;
         var _loc1_:int = this.MAX_SHIPTEAMBODY - 1;
         while(_loc1_ >= 0)
         {
            this.ShipFight[_loc1_].release();
            _loc1_--;
         }
         this.ShipFight.splice(0);
         this.ShipFight = null;
      }
   }
}

