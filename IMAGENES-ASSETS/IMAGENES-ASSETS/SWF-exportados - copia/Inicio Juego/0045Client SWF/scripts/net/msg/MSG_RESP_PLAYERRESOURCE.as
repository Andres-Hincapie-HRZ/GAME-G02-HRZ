package net.msg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_PLAYERRESOURCE extends MsgHead
   {
      
      public var UserGas:uint;
      
      public var UserMetal:uint;
      
      public var UserMoney:uint;
      
      public var Credit:uint;
      
      public var Level:int;
      
      public var Exp:int;
      
      public var Coins:int;
      
      public var OutGas:int;
      
      public var OutMetal:int;
      
      public var OutMoney:int;
      
      public var MaxSpValue:int;
      
      public var SpValue:int;
      
      public var MoneyBuyNum:int;
      
      public var DefyEctypeNum:int;
      
      public var MatchCount:int;
      
      public var TollGate:int;
      
      public var Reserve:int;
      
      public function MSG_RESP_PLAYERRESOURCE()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_PLAYERRESOURCE;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.UserGas = _loc2_.readUnsignInt(param1);
         this.UserMetal = _loc2_.readUnsignInt(param1);
         this.UserMoney = _loc2_.readUnsignInt(param1);
         this.Credit = _loc2_.readUnsignInt(param1);
         this.Level = _loc2_.readInt(param1);
         this.Exp = _loc2_.readInt(param1);
         this.Coins = _loc2_.readInt(param1);
         this.OutGas = _loc2_.readInt(param1);
         this.OutMetal = _loc2_.readInt(param1);
         this.OutMoney = _loc2_.readInt(param1);
         this.MaxSpValue = _loc2_.readInt(param1);
         this.SpValue = _loc2_.readInt(param1);
         this.MoneyBuyNum = _loc2_.readInt(param1);
         this.DefyEctypeNum = _loc2_.readInt(param1);
         this.MatchCount = _loc2_.readInt(param1);
         this.TollGate = _loc2_.readInt(param1);
         this.Reserve = _loc2_.readInt(param1);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         return param1 + 68;
      }
      
      public function release() : void
      {
      }
   }
}

