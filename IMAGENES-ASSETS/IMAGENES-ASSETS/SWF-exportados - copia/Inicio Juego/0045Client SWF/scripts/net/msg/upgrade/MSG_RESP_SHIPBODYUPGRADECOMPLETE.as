package net.msg.upgrade
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_SHIPBODYUPGRADECOMPLETE extends MsgHead
   {
      
      public var BodyPartId:int;
      
      public var Type:int;
      
      public function MSG_RESP_SHIPBODYUPGRADECOMPLETE()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_SHIPBODYUPGRADECOMPLETE;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.BodyPartId = _loc2_.readInt(param1);
         this.Type = _loc2_.readChar(param1);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         return param1 + 5;
      }
      
      public function release() : void
      {
      }
   }
}

