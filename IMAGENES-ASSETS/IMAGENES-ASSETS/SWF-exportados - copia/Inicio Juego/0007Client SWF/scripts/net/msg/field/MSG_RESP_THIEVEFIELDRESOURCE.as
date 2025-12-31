package net.msg.field
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_THIEVEFIELDRESOURCE extends MsgHead
   {
      
      public var ErrorCode:int;
      
      public var GalaxyId:int;
      
      public var Gas:int;
      
      public var Metal:int;
      
      public var Money:int;
      
      public function MSG_RESP_THIEVEFIELDRESOURCE()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_THIEVEFIELDRESOURCE;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.ErrorCode = _loc2_.readInt(param1);
         this.GalaxyId = _loc2_.readInt(param1);
         this.Gas = _loc2_.readInt(param1);
         this.Metal = _loc2_.readInt(param1);
         this.Money = _loc2_.readInt(param1);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         return param1 + 20;
      }
      
      public function release() : void
      {
      }
   }
}

