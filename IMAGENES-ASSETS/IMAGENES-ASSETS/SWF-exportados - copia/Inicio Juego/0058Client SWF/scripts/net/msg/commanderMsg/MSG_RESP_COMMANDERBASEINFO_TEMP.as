package net.msg.commanderMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgTypes;
   
   public class MSG_RESP_COMMANDERBASEINFO_TEMP
   {
      
      public var Name:String = "";
      
      public var UserId:Number;
      
      public var CommanderId:int;
      
      public var ShipTeamId:int;
      
      public var State:int;
      
      public var Skill:int;
      
      public var Level:int;
      
      public var Type:int;
      
      public function MSG_RESP_COMMANDERBASEINFO_TEMP()
      {
         super();
         this.Skill = -1;
         this.UserId = -1;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.GetByte(param1,(8 - param1.position % 8) % 8);
         this.Name = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.UserId = _loc2_.readInt64(param1);
         this.CommanderId = _loc2_.readInt(param1);
         this.ShipTeamId = _loc2_.readInt(param1);
         this.State = _loc2_.readInt(param1);
         this.Skill = _loc2_.readShort(param1);
         this.Level = _loc2_.readChar(param1);
         this.Type = _loc2_.readChar(param1);
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.PushByte(param1,(8 - param1.position % 8) % 8);
         _loc2_.writeUtf8Str(param1,this.Name,MsgTypes.MAX_NAME);
         _loc2_.writeInt64(param1,this.UserId);
         _loc2_.writeInt(param1,this.CommanderId);
         _loc2_.writeInt(param1,this.ShipTeamId);
         _loc2_.writeInt(param1,this.State);
         _loc2_.writeShort(param1,this.Skill);
         _loc2_.writeChar(param1,this.Level);
         _loc2_.writeChar(param1,this.Type);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 += (8 - param1 % 8) % 8;
         param1 += MsgTypes.MAX_NAME;
         param1 += (8 - param1 % 8) % 8;
         return param1 + 24;
      }
      
      public function release() : void
      {
      }
   }
}

