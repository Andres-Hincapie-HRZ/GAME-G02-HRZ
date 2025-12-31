package net.msg.gymkhanaMSg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_REQUEST_JOINRACING extends MsgHead
   {
      
      public var UserId:Number;
      
      public function MSG_REQUEST_JOINRACING()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_REQUEST_JOINRACING;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         _loc2_.GetByte(param1,4);
         this.UserId = _loc2_.readInt64(param1);
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         param1.position = 0;
         _loc2_.writeShort(param1,usSize);
         _loc2_.writeShort(param1,usType);
         _loc2_.PushByte(param1,4);
         _loc2_.writeInt64(param1,this.UserId);
         _loc2_.PushByte(param1,usSize - param1.position);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += (8 - param1 % 8) % 8;
         return param1 + 8;
      }
      
      public function release() : void
      {
      }
   }
}

