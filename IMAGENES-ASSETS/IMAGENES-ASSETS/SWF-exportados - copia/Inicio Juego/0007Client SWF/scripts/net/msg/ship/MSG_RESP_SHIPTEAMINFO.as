package net.msg.ship
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   import net.msg.fleetMsg.MSG_SHIPTEAM_BODY;
   
   public class MSG_RESP_SHIPTEAMINFO extends MsgHead
   {
      
      public var ShipTeamId:int;
      
      public var UserId:Number;
      
      public var Gas:uint;
      
      public var CommanderId:int;
      
      public var TeamName:String = "";
      
      public var Commander:String = "";
      
      public var TeamOwner:String = "";
      
      public var Consortia:String = "";
      
      public var TeamBody:Array;
      
      public var SkillId:int;
      
      public var AttackObjInterval:int;
      
      public var AttackObjType:int;
      
      public var LevelId:int;
      
      public var CardLevel:int;
      
      public function MSG_RESP_SHIPTEAMINFO()
      {
         var _loc2_:MSG_SHIPTEAM_BODY = null;
         this.TeamBody = new Array(MsgTypes.MAX_SHIPTEAMBODY);
         super();
         var _loc1_:int = 0;
         while(_loc1_ < MsgTypes.MAX_SHIPTEAMBODY)
         {
            _loc2_ = new MSG_SHIPTEAM_BODY();
            this.TeamBody[_loc1_] = _loc2_;
            _loc1_++;
         }
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_SHIPTEAMINFO;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.ShipTeamId = _loc2_.readInt(param1);
         this.UserId = _loc2_.readInt64(param1);
         this.Gas = _loc2_.readUnsignInt(param1);
         this.CommanderId = _loc2_.readInt(param1);
         this.TeamName = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.Commander = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.TeamOwner = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.Consortia = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         var _loc3_:int = 0;
         while(_loc3_ < MsgTypes.MAX_SHIPTEAMBODY)
         {
            if(param1.length > param1.position)
            {
               this.TeamBody[_loc3_].readBuf(param1);
            }
            _loc3_++;
         }
         this.SkillId = _loc2_.readShort(param1);
         this.AttackObjInterval = _loc2_.readChar(param1);
         this.AttackObjType = _loc2_.readChar(param1);
         this.LevelId = _loc2_.readUnsignChar(param1);
         this.CardLevel = _loc2_.readChar(param1);
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         param1.position = 0;
         _loc2_.writeShort(param1,usSize);
         _loc2_.writeShort(param1,usType);
         _loc2_.writeInt(param1,this.ShipTeamId);
         _loc2_.writeInt64(param1,this.UserId);
         _loc2_.writeUnsignInt(param1,this.Gas);
         _loc2_.writeInt(param1,this.CommanderId);
         _loc2_.writeUtf8Str(param1,this.TeamName,MsgTypes.MAX_NAME);
         _loc2_.writeUtf8Str(param1,this.Commander,MsgTypes.MAX_NAME);
         _loc2_.writeUtf8Str(param1,this.TeamOwner,MsgTypes.MAX_NAME);
         _loc2_.writeUtf8Str(param1,this.Consortia,MsgTypes.MAX_NAME);
         var _loc3_:int = 0;
         while(_loc3_ < MsgTypes.MAX_SHIPTEAMBODY)
         {
            this.TeamBody[_loc3_].writeBuf(param1);
            _loc3_++;
         }
         _loc2_.writeShort(param1,this.SkillId);
         _loc2_.writeChar(param1,this.AttackObjInterval);
         _loc2_.writeChar(param1,this.AttackObjType);
         _loc2_.writeUnsignChar(param1,this.LevelId);
         _loc2_.writeChar(param1,this.CardLevel);
         _loc2_.PushByte(param1,usSize - param1.position);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 20;
         param1 += MsgTypes.MAX_NAME;
         param1 += MsgTypes.MAX_NAME;
         param1 += MsgTypes.MAX_NAME;
         param1 += MsgTypes.MAX_NAME;
         var _loc2_:int = 0;
         while(_loc2_ < MsgTypes.MAX_SHIPTEAMBODY)
         {
            param1 = int(this.TeamBody[_loc2_].getLength(param1));
            _loc2_++;
         }
         param1 += (8 - param1 % 8) % 8;
         return param1 + 6;
      }
      
      public function release() : void
      {
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

