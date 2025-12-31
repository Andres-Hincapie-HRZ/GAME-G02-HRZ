package net.msg.field
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_HELPFIELDCENTERRESOURCE extends MsgHead
   {
      
      public var ErrorCode:int;
      
      public var ObjGuid:int;
      
      public function MSG_RESP_HELPFIELDCENTERRESOURCE()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_HELPFIELDCENTERRESOURCE;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.ErrorCode = _loc2_.readInt(param1);
         this.ObjGuid = _loc2_.readInt(param1);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         return param1 + 8;
      }
      
      public function release() : void
      {
      }
   }
}

