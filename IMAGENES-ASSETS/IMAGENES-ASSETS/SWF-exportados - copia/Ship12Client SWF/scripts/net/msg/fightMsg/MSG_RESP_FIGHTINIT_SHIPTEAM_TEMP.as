package net.msg.fightMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgTypes;
   import net.msg.fleetMsg.MSG_SHIPTEAM_BODY;
   
   public class MSG_RESP_FIGHTINIT_SHIPTEAM_TEMP
   {
      
      public var TeamName:String = "";
      
      public var Commander:String = "";
      
      public var TeamOwner:String = "";
      
      public var Consortia:String = "";
      
      public var UserId:Number;
      
      public var ShipTeamId:int;
      
      public var Gas:uint;
      
      public var Storage:uint;
      
      public var MaxShield:Array;
      
      public var MaxEndure:Array;
      
      public var Shield:Array;
      
      public var Endure:Array;
      
      public var TeamBody:Array;
      
      public var SkillId:int;
      
      public var Reserve1:int;
      
      public var AttackObjInterval:int;
      
      public var AttackObjType:int;
      
      public var LevelId:int;
      
      public var CardLevel:int;
      
      public function MSG_RESP_FIGHTINIT_SHIPTEAM_TEMP()
      {
         var _loc2_:MSG_SHIPTEAM_BODY = null;
         this.MaxShield = new Array(MsgTypes.MAX_SHIPTEAMBODY);
         this.MaxEndure = new Array(MsgTypes.MAX_SHIPTEAMBODY);
         this.Shield = new Array(MsgTypes.MAX_SHIPTEAMBODY);
         this.Endure = new Array(MsgTypes.MAX_SHIPTEAMBODY);
         this.TeamBody = new Array(MsgTypes.MAX_SHIPTEAMBODY);
         super();
         var _loc1_:int = 0;
         while(_loc1_ < MsgTypes.MAX_SHIPTEAMBODY)
         {
            _loc2_ = new MSG_SHIPTEAM_BODY();
            this.TeamBody[_loc1_] = _loc2_;
            _loc1_++;
         }
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.GetByte(param1,(8 - param1.position % 8) % 8);
         this.TeamName = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.Commander = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.TeamOwner = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.Consortia = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.UserId = _loc2_.readInt64(param1);
         this.ShipTeamId = _loc2_.readInt(param1);
         this.Gas = _loc2_.readUnsignInt(param1);
         this.Storage = _loc2_.readUnsignInt(param1);
         var _loc3_:int = 0;
         while(_loc3_ < MsgTypes.MAX_SHIPTEAMBODY)
         {
            if(param1.length - param1.position >= 4)
            {
               this.MaxShield[_loc3_] = _loc2_.readUnsignInt(param1);
            }
            _loc3_++;
         }
         var _loc4_:int = 0;
         while(_loc4_ < MsgTypes.MAX_SHIPTEAMBODY)
         {
            if(param1.length - param1.position >= 4)
            {
               this.MaxEndure[_loc4_] = _loc2_.readUnsignInt(param1);
            }
            _loc4_++;
         }
         var _loc5_:int = 0;
         while(_loc5_ < MsgTypes.MAX_SHIPTEAMBODY)
         {
            if(param1.length - param1.position >= 4)
            {
               this.Shield[_loc5_] = _loc2_.readUnsignInt(param1);
            }
            _loc5_++;
         }
         var _loc6_:int = 0;
         while(_loc6_ < MsgTypes.MAX_SHIPTEAMBODY)
         {
            if(param1.length - param1.position >= 4)
            {
               this.Endure[_loc6_] = _loc2_.readUnsignInt(param1);
            }
            _loc6_++;
         }
         var _loc7_:int = 0;
         while(_loc7_ < MsgTypes.MAX_SHIPTEAMBODY)
         {
            if(param1.length > param1.position)
            {
               this.TeamBody[_loc7_].readBuf(param1);
            }
            _loc7_++;
         }
         this.SkillId = _loc2_.readShort(param1);
         this.Reserve1 = _loc2_.readShort(param1);
         this.AttackObjInterval = _loc2_.readChar(param1);
         this.AttackObjType = _loc2_.readChar(param1);
         this.LevelId = _loc2_.readUnsignChar(param1);
         this.CardLevel = _loc2_.readChar(param1);
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 += (8 - param1 % 8) % 8;
         param1 += MsgTypes.MAX_NAME;
         param1 += MsgTypes.MAX_NAME;
         param1 += MsgTypes.MAX_NAME;
         param1 += MsgTypes.MAX_NAME;
         param1 += (8 - param1 % 8) % 8;
         param1 += 20;
         param1 += MsgTypes.MAX_SHIPTEAMBODY * 4;
         param1 += MsgTypes.MAX_SHIPTEAMBODY * 4;
         param1 += MsgTypes.MAX_SHIPTEAMBODY * 4;
         param1 += MsgTypes.MAX_SHIPTEAMBODY * 4;
         var _loc2_:int = 0;
         while(_loc2_ < MsgTypes.MAX_SHIPTEAMBODY)
         {
            param1 = int(this.TeamBody[_loc2_].getLength(param1));
            _loc2_++;
         }
         return param1 + 8;
      }
      
      public function release() : void
      {
         this.MaxShield.splice(0);
         this.MaxShield = null;
         this.MaxEndure.splice(0);
         this.MaxEndure = null;
         this.Shield.splice(0);
         this.Shield = null;
         this.Endure.splice(0);
         this.Endure = null;
         var _loc1_:int = MsgTypes.MAX_SHIPTEAMBODY - 1;
         while(_loc1_ >= 0)
         {
            this.TeamBody[_loc1_].release();
            _loc1_--;
         }
         this.TeamBody.splice(0);
         this.TeamBody = null;
      }
   }
}

