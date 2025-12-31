package net.msg
{
   import flash.external.ExternalInterface;
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_ROLE_INFO extends MsgHead
   {
      
      public var GalaxyMapId:int;
      
      public var GalaxyId:int;
      
      public var ConsortiaId:int;
      
      public var PropsPack:int;
      
      public var PropsCorpsPack:int;
      
      public var ConsortiaJob:int;
      
      public var ConsortiaUnionLevel:int;
      
      public var ConsortiaShopLevel:int;
      
      public var GameServerId:int;
      
      public var Commander_Card:int;
      
      public var Commander_Credit:int;
      
      public var Commander_Card2:int;
      
      public var Commander_Card3:int;
      
      public var Commander_CardUnion:int;
      
      public var ChargeFlag:int;
      
      public var AddPackMoney:int;
      
      public var LotteryCredit:int;
      
      public var ShipSpeedCredit:int;
      
      public var LotteryStatus:int;
      
      public var ConsortiaThrowValue:int;
      
      public var ConsortiaUnionValue:int;
      
      public var ConsortiaShopValue:int;
      
      public var Name:String = "";
      
      public var DefyEctypeNum:int;
      
      public var Badge:int;
      
      public var Honor:int;
      
      public var ServerTime:uint;
      
      public var TollGate:int;
      
      public var Year:int;
      
      public var Month:int;
      
      public var Day:int;
      
      public var NoviceGuide:int;
      
      public var WarScoreExchange:uint;
      
      public function MSG_ROLE_INFO()
      {
         super();
         usSize = uint(uint(this.getLength()));
         usType = uint(uint(MsgTypes._MSG_ROLE_INFO));
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = uint(uint(_loc2_.readMsgSize(param1)));
         usType = uint(uint(_loc2_.readMsgType(param1)));
         this.GalaxyMapId = int(int(_loc2_.readInt(param1)));
         this.GalaxyId = int(int(_loc2_.readInt(param1)));
         this.ConsortiaId = int(int(_loc2_.readInt(param1)));
         this.PropsPack = int(int(_loc2_.readInt(param1)));
         this.PropsCorpsPack = int(int(_loc2_.readInt(param1)));
         this.ConsortiaJob = int(int(_loc2_.readChar(param1)));
         this.ConsortiaUnionLevel = int(int(_loc2_.readChar(param1)));
         this.ConsortiaShopLevel = int(int(_loc2_.readChar(param1)));
         this.GameServerId = int(int(_loc2_.readChar(param1)));
         this.Commander_Card = int(int(_loc2_.readInt(param1)));
         this.Commander_Credit = int(int(_loc2_.readInt(param1)));
         this.Commander_Card2 = int(int(_loc2_.readInt(param1)));
         this.Commander_Card3 = int(int(_loc2_.readInt(param1)));
         this.Commander_CardUnion = int(int(_loc2_.readInt(param1)));
         this.ChargeFlag = int(int(_loc2_.readInt(param1)));
         this.AddPackMoney = int(int(_loc2_.readInt(param1)));
         this.LotteryCredit = int(int(_loc2_.readInt(param1)));
         this.ShipSpeedCredit = int(int(_loc2_.readInt(param1)));
         this.LotteryStatus = int(int(_loc2_.readInt(param1)));
         this.ConsortiaThrowValue = int(int(_loc2_.readInt(param1)));
         this.ConsortiaUnionValue = int(int(_loc2_.readInt(param1)));
         this.ConsortiaShopValue = int(int(_loc2_.readInt(param1)));
         this.Name = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.DefyEctypeNum = int(int(_loc2_.readInt(param1)));
         this.Badge = int(int(_loc2_.readInt(param1)));
         this.Honor = int(int(_loc2_.readInt(param1)));
         this.ServerTime = uint(uint(_loc2_.readUnsignInt(param1)));
         this.TollGate = int(int(_loc2_.readInt(param1)));
         this.Year = int(int(_loc2_.readShort(param1)));
         this.Month = int(int(_loc2_.readChar(param1)));
         this.Day = int(int(_loc2_.readChar(param1)));
         this.NoviceGuide = int(int(_loc2_.readInt(param1)));
         this.WarScoreExchange = uint(uint(_loc2_.readUnsignInt(param1)));
         _loc2_ = null;
         ExternalInterface.call("console.log","[#] GalaxyMapId => " + this.GalaxyMapId);
         ExternalInterface.call("console.log","[#] GalaxyId => " + this.GalaxyId);
         ExternalInterface.call("console.log","[#] ConsortiaId => " + this.ConsortiaId);
         ExternalInterface.call("console.log","[#] PropsPack => " + this.PropsPack);
         ExternalInterface.call("console.log","[#] PropsCorpsPack => " + this.PropsCorpsPack);
         ExternalInterface.call("console.log","[#] ConsortiaJob => " + this.ConsortiaJob);
         ExternalInterface.call("console.log","[#] ConsortiaUnionLevel => " + this.ConsortiaUnionLevel);
         ExternalInterface.call("console.log","[#] ConsortiaShopLevel => " + this.ConsortiaShopLevel);
         ExternalInterface.call("console.log","[#] GameServerId => " + this.GameServerId);
         ExternalInterface.call("console.log","[#] Commander_Card => " + this.Commander_Card);
         ExternalInterface.call("console.log","[#] Commander_Credit => " + this.Commander_Credit);
         ExternalInterface.call("console.log","[#] Commander_Card2 => " + this.Commander_Card2);
         ExternalInterface.call("console.log","[#] Commander_Card3 => " + this.Commander_Card3);
         ExternalInterface.call("console.log","[#] Commander_CardUnion => " + this.Commander_CardUnion);
         ExternalInterface.call("console.log","[#] Commander_ChargeFlag => " + this.ChargeFlag);
         ExternalInterface.call("console.log","[#] AddPackMoney => " + this.AddPackMoney);
         ExternalInterface.call("console.log","[#] ShipSpeedCredit => " + this.LotteryCredit);
         ExternalInterface.call("console.log","[#] LotteryStatus => " + this.LotteryStatus);
         ExternalInterface.call("console.log","[#] ConsortiaThrowValue => " + this.ConsortiaThrowValue);
         ExternalInterface.call("console.log","[#] ConsortiaUnionValue => " + this.ConsortiaUnionValue);
         ExternalInterface.call("console.log","[#] ConsortiaShopValue => " + this.ConsortiaShopValue);
         ExternalInterface.call("console.log","[#] Name => " + this.Name);
         ExternalInterface.call("console.log","[#] DefyEctypeNum => " + this.DefyEctypeNum);
         ExternalInterface.call("console.log","[#] Badge => " + this.Badge);
         ExternalInterface.call("console.log","[#] Honor => " + this.Honor);
         ExternalInterface.call("console.log","[#] ServerTime => " + this.ServerTime);
         ExternalInterface.call("console.log","[#] TollGate => " + this.TollGate);
         ExternalInterface.call("console.log","[#] Year => " + this.Year);
         ExternalInterface.call("console.log","[#] Month => " + this.Month);
         ExternalInterface.call("console.log","[#] Day => " + this.Day);
         ExternalInterface.call("console.log","[#] NoviceGuide => " + this.NoviceGuide);
         ExternalInterface.call("console.log","[#] WarScoreExchange => " + this.WarScoreExchange);
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 76;
         param1 += MsgTypes.MAX_NAME;
         param1 = (param1 + (4 - param1)) % 4 % 4;
         param1 += 24;
         param1 = (param1 + (4 - param1)) % 4 % 4;
         return param1 + 8;
      }
      
      public function release() : void
      {
      }
   }
}

