package net.msg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   
   public class MSG_RESP_CUSTOM_CONFIGURATION extends MsgHead
   {
      
      public var ResourcesUrl:String;
      
      public function MSG_RESP_CUSTOM_CONFIGURATION()
      {
         super();
         usSize = this.getLength();
         usType = 5002;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.ResourcesUrl = _loc2_.readWideChar(param1,52);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         return 52;
      }
      
      public function release() : void
      {
      }
   }
}

