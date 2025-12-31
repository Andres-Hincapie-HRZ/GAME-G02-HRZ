package net.msg.mall
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgTypes;
   
   public class MSG_RESP_TRADEINFO_TEMP
   {
      
      public var SellUserId:Number;
      
      public var SellName:String = "";
      
      public var SellGuid:int;
      
      public var IndexId:int;
      
      public var Id:int;
      
      public var Num:int;
      
      public var Price:int;
      
      public var SpareTime:int;
      
      public var Reserve:int;
      
      public var BodyId:int;
      
      public var TradeType:int;
      
      public var PriceType:int;
      
      public function MSG_RESP_TRADEINFO_TEMP()
      {
         super();
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.GetByte(param1,(8 - param1.position % 8) % 8);
         this.SellUserId = _loc2_.readInt64(param1);
         this.SellName = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.SellGuid = _loc2_.readInt(param1);
         this.IndexId = _loc2_.readInt(param1);
         this.Id = _loc2_.readInt(param1);
         this.Num = _loc2_.readInt(param1);
         this.Price = _loc2_.readInt(param1);
         this.SpareTime = _loc2_.readInt(param1);
         this.Reserve = _loc2_.readInt(param1);
         this.BodyId = _loc2_.readShort(param1);
         this.TradeType = _loc2_.readChar(param1);
         this.PriceType = _loc2_.readChar(param1);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 += (8 - param1 % 8) % 8;
         param1 += 8;
         param1 += MsgTypes.MAX_NAME;
         param1 += (4 - param1 % 4) % 4;
         return param1 + 32;
      }
      
      public function release() : void
      {
      }
   }
}

