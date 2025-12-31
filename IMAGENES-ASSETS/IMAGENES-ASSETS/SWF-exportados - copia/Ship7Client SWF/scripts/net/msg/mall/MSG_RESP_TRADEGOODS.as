package net.msg.mall
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_TRADEGOODS extends MsgHead
   {
      
      public var ErrorCode:int;
      
      public var Id:int;
      
      public var Num:int;
      
      public var TradeType:int;
      
      public var Type:int;
      
      public var PriceType:int;
      
      public var TimeType:int;
      
      public var Value:int;
      
      public function MSG_RESP_TRADEGOODS()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_TRADEGOODS;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.ErrorCode = _loc2_.readInt(param1);
         this.Id = _loc2_.readInt(param1);
         this.Num = _loc2_.readInt(param1);
         this.TradeType = _loc2_.readChar(param1);
         this.Type = _loc2_.readChar(param1);
         this.PriceType = _loc2_.readChar(param1);
         this.TimeType = _loc2_.readChar(param1);
         this.Value = _loc2_.readInt(param1);
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

