package net.msg.friend
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgTypes;
   
   public class FriendChatUserInfo
   {
      
      public var Name:String = "";
      
      public var UserId:Number;
      
      public var Guid:int;
      
      public var Status:int;
      
      public var Level:int;
      
      public var HeadId:int;
      
      public var Reserve:int;
      
      public function FriendChatUserInfo()
      {
         super();
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.GetByte(param1,(8 - param1.position % 8) % 8);
         this.Name = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.UserId = _loc2_.readInt64(param1);
         this.Guid = _loc2_.readInt(param1);
         this.Status = _loc2_.readChar(param1);
         this.Level = _loc2_.readUnsignChar(param1);
         this.HeadId = _loc2_.readUnsignChar(param1);
         this.Reserve = _loc2_.readChar(param1);
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.PushByte(param1,(8 - param1.position % 8) % 8);
         _loc2_.writeUtf8Str(param1,this.Name,MsgTypes.MAX_NAME);
         _loc2_.writeInt64(param1,this.UserId);
         _loc2_.writeInt(param1,this.Guid);
         _loc2_.writeChar(param1,this.Status);
         _loc2_.writeUnsignChar(param1,this.Level);
         _loc2_.writeUnsignChar(param1,this.HeadId);
         _loc2_.writeChar(param1,this.Reserve);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 += (8 - param1 % 8) % 8;
         param1 += MsgTypes.MAX_NAME;
         param1 += (8 - param1 % 8) % 8;
         return param1 + 16;
      }
      
      public function release() : void
      {
      }
   }
}

