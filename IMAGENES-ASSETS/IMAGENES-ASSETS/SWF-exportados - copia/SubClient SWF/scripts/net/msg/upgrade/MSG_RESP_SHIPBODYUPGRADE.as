package net.msg.upgrade
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_SHIPBODYUPGRADE extends MsgHead
   {
      
      public var BodyPartId:int;
      
      public var NeedTime:int;
      
      public var Type:int;
      
      public var CancelFlag:int;
      
      public var Reserve:int;
      
      public var Money:int;
      
      public var Metal:int;
      
      public var Gas:int;
      
      public function MSG_RESP_SHIPBODYUPGRADE()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_SHIPBODYUPGRADE;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.BodyPartId = _loc2_.readInt(param1);
         this.NeedTime = _loc2_.readInt(param1);
         this.Type = _loc2_.readChar(param1);
         this.CancelFlag = _loc2_.readChar(param1);
         this.Reserve = _loc2_.readShort(param1);
         this.Money = _loc2_.readInt(param1);
         this.Metal = _loc2_.readInt(param1);
         this.Gas = _loc2_.readInt(param1);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         return param1 + 24;
      }
      
      public function release() : void
      {
      }
   }
}

