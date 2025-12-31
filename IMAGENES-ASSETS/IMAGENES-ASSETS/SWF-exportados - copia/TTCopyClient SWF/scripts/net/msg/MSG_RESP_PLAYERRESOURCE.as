package net.msg
{
   import flash.external.ExternalInterface;
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
         usSize = uint(this.getLength());
         usType = uint(MsgTypes._MSG_RESP_PLAYERRESOURCE);
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = uint(_loc2_.readMsgSize(param1));
         usType = uint(_loc2_.readMsgType(param1));
         this.UserGas = uint(_loc2_.readUnsignInt(param1));
         this.UserMetal = uint(_loc2_.readUnsignInt(param1));
         this.UserMoney = uint(_loc2_.readUnsignInt(param1));
         this.Credit = uint(_loc2_.readUnsignInt(param1));
         this.Level = int(_loc2_.readInt(param1));
         this.Exp = int(_loc2_.readInt(param1));
         this.Coins = int(_loc2_.readInt(param1));
         this.OutGas = int(_loc2_.readInt(param1));
         this.OutMetal = int(_loc2_.readInt(param1));
         this.OutMoney = int(_loc2_.readInt(param1));
         this.MaxSpValue = int(_loc2_.readInt(param1));
         this.SpValue = int(_loc2_.readInt(param1));
         this.MoneyBuyNum = int(_loc2_.readInt(param1));
         this.DefyEctypeNum = int(_loc2_.readInt(param1));
         this.MatchCount = int(_loc2_.readInt(param1));
         this.TollGate = int(_loc2_.readInt(param1));
         this.Reserve = int(_loc2_.readInt(param1));
         _loc2_ = null;
         ExternalInterface.call("console.log","[#] ############################ ");
         ExternalInterface.call("console.log","[#] usSize => " + usSize);
         ExternalInterface.call("console.log","[#] usType => " + usType);
         ExternalInterface.call("console.log","[#] UserGas => " + this.UserGas);
         ExternalInterface.call("console.log","[#] UserMetal => " + this.UserMetal);
         ExternalInterface.call("console.log","[#] UserMoney => " + this.UserMoney);
         ExternalInterface.call("console.log","[#] Credit => " + this.Credit);
         ExternalInterface.call("console.log","[#] Level => " + this.Level);
         ExternalInterface.call("console.log","[#] Exp => " + this.Exp);
         ExternalInterface.call("console.log","[#] Coins => " + this.Coins);
         ExternalInterface.call("console.log","[#] OutGas => " + this.OutGas);
         ExternalInterface.call("console.log","[#] OutMetal => " + this.OutMetal);
         ExternalInterface.call("console.log","[#] OutMoney => " + this.OutMoney);
         ExternalInterface.call("console.log","[#] MaxSpValue => " + this.MaxSpValue);
         ExternalInterface.call("console.log","[#] SpValue => " + this.SpValue);
         ExternalInterface.call("console.log","[#] MoneyBuyNum => " + this.MoneyBuyNum);
         ExternalInterface.call("console.log","[#] DefyEctypeNum => " + this.DefyEctypeNum);
         ExternalInterface.call("console.log","[#] MatchCount => " + this.MatchCount);
         ExternalInterface.call("console.log","[#] TollGate => " + this.TollGate);
         ExternalInterface.call("console.log","[#] Reserve => " + this.Reserve);
         ExternalInterface.call("console.log","[#] ############################ ");
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

