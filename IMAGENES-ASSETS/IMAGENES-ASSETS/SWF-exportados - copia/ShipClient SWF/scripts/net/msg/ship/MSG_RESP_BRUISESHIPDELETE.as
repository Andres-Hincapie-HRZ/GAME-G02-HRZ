package net.msg.ship
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_BRUISESHIPDELETE extends MsgHead
   {
      
      public var ShipModelId:int;
      
      public function MSG_RESP_BRUISESHIPDELETE()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_BRUISESHIPDELETE;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.ShipModelId = _loc2_.readInt(param1);
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

