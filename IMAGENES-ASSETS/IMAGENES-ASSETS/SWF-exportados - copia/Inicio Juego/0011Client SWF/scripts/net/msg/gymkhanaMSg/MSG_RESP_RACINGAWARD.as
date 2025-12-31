package net.msg.gymkhanaMSg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_RACINGAWARD extends MsgHead
   {
      
      public var WarScoreExchange:uint;
      
      public function MSG_RESP_RACINGAWARD()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_RACINGAWARD;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.WarScoreExchange = _loc2_.readUnsignInt(param1);
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         param1.position = 0;
         _loc2_.writeShort(param1,usSize);
         _loc2_.writeShort(param1,usType);
         _loc2_.writeUnsignInt(param1,this.WarScoreExchange);
         _loc2_.PushByte(param1,usSize - param1.position);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         return param1 + 4;
      }
      
      public function release() : void
      {
      }
   }
}

