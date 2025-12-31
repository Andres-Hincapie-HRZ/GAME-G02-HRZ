package net.msg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_REQUEST_FRIENDLEVEL extends MsgHead
   {
      
      public var SeqId:int;
      
      public var Guid:int;
      
      public var DataLen:int;
      
      public var Data:Array = new Array(MsgTypes.MAX_MSGFRIENDLEN);
      
      public function MSG_REQUEST_FRIENDLEVEL()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_REQUEST_FRIENDLEVEL;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         param1.position = 0;
         _loc2_.writeShort(param1,usSize);
         _loc2_.writeShort(param1,usType);
         _loc2_.writeInt(param1,this.SeqId);
         _loc2_.writeInt(param1,this.Guid);
         _loc2_.writeInt(param1,this.DataLen);
         var _loc3_:int = 0;
         while(_loc3_ < MsgTypes.MAX_MSGFRIENDLEN)
         {
            _loc2_.writeInt64(param1,this.Data[_loc3_]);
            _loc3_++;
         }
         _loc2_.PushByte(param1,usSize - param1.position);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 12;
         param1 += (8 - param1 % 8) % 8;
         return param1 + MsgTypes.MAX_MSGFRIENDLEN * 8;
      }
      
      public function release() : void
      {
         this.Data.splice(0);
         this.Data = null;
      }
   }
}

