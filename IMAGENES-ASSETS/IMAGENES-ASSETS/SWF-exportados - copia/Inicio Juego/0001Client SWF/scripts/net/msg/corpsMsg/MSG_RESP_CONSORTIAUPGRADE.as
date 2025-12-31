package net.msg.corpsMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_CONSORTIAUPGRADE extends MsgHead
   {
      
      public var Type:int;
      
      public var ConsortiaId:int;
      
      public var Needtime:int;
      
      public function MSG_RESP_CONSORTIAUPGRADE()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_CONSORTIAUPGRADE;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.Type = _loc2_.readInt(param1);
         this.ConsortiaId = _loc2_.readInt(param1);
         this.Needtime = _loc2_.readInt(param1);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         return param1 + 12;
      }
      
      public function release() : void
      {
      }
   }
}

