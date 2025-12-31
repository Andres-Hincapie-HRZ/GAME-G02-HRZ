package net.msg.Rank
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgTypes;
   
   public class MSG_RESP_RANKFIGHT_TEMP
   {
      
      public var ConsortiaName:String = "";
      
      public var UserName:String = "";
      
      public var UserId:Number;
      
      public var Guid:int;
      
      public var GalaxyId:int;
      
      public var StarType:int;
      
      public var Reserve:int;
      
      public function MSG_RESP_RANKFIGHT_TEMP()
      {
         super();
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.GetByte(param1,(8 - param1.position % 8) % 8);
         this.ConsortiaName = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.UserName = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.UserId = _loc2_.readInt64(param1);
         this.Guid = _loc2_.readInt(param1);
         this.GalaxyId = _loc2_.readInt(param1);
         this.StarType = _loc2_.readInt(param1);
         this.Reserve = _loc2_.readInt(param1);
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.PushByte(param1,(8 - param1.position % 8) % 8);
         _loc2_.writeUtf8Str(param1,this.ConsortiaName,MsgTypes.MAX_NAME);
         _loc2_.writeUtf8Str(param1,this.UserName,MsgTypes.MAX_NAME);
         _loc2_.writeInt64(param1,this.UserId);
         _loc2_.writeInt(param1,this.Guid);
         _loc2_.writeInt(param1,this.GalaxyId);
         _loc2_.writeInt(param1,this.StarType);
         _loc2_.writeInt(param1,this.Reserve);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 += (8 - param1 % 8) % 8;
         param1 += MsgTypes.MAX_NAME;
         param1 += MsgTypes.MAX_NAME;
         param1 += (8 - param1 % 8) % 8;
         return param1 + 24;
      }
      
      public function release() : void
      {
      }
   }
}

