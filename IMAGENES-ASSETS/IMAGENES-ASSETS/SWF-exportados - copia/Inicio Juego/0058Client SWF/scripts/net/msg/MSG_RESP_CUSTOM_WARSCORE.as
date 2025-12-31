package net.msg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   
   public class MSG_RESP_CUSTOM_WARSCORE extends MsgHead
   {
      
      public var WarScoreExchange:int;
      
      public function MSG_RESP_CUSTOM_WARSCORE()
      {
         super();
         usSize = this.getLength();
         usType = 5003;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.WarScoreExchange = _loc2_.readInt(param1);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         return 4;
      }
      
      public function release() : void
      {
      }
   }
}

