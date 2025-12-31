package net.msg.mall
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_BUYTRADEGOODS extends MsgHead
   {
      
      public var ErrorCode:int;
      
      public var SellGuid:int;
      
      public var IndexId:int;
      
      public var PriceType:int;
      
      public var Price:int;
      
      public function MSG_RESP_BUYTRADEGOODS()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_BUYTRADEGOODS;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.ErrorCode = _loc2_.readInt(param1);
         this.SellGuid = _loc2_.readInt(param1);
         this.IndexId = _loc2_.readInt(param1);
         this.PriceType = _loc2_.readInt(param1);
         this.Price = _loc2_.readInt(param1);
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

