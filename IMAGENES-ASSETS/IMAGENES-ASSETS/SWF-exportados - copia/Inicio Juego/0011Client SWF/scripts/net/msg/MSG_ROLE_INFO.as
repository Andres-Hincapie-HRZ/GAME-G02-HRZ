package net.msg
{
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
         usSize = this.getLength();
         usType = MsgTypes._MSG_ROLE_INFO;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.GalaxyMapId = _loc2_.readInt(param1);
         this.GalaxyId = _loc2_.readInt(param1);
         this.ConsortiaId = _loc2_.readInt(param1);
         this.PropsPack = _loc2_.readInt(param1);
         this.PropsCorpsPack = _loc2_.readInt(param1);
         this.ConsortiaJob = _loc2_.readChar(param1);
         this.ConsortiaUnionLevel = _loc2_.readChar(param1);
         this.ConsortiaShopLevel = _loc2_.readChar(param1);
         this.GameServerId = _loc2_.readChar(param1);
         this.Commander_Card = _loc2_.readInt(param1);
         this.Commander_Credit = _loc2_.readInt(param1);
         this.Commander_Card2 = _loc2_.readInt(param1);
         this.Commander_Card3 = _loc2_.readInt(param1);
         this.Commander_CardUnion = _loc2_.readInt(param1);
         this.ChargeFlag = _loc2_.readInt(param1);
         this.AddPackMoney = _loc2_.readInt(param1);
         this.LotteryCredit = _loc2_.readInt(param1);
         this.ShipSpeedCredit = _loc2_.readInt(param1);
         this.LotteryStatus = _loc2_.readInt(param1);
         this.ConsortiaThrowValue = _loc2_.readInt(param1);
         this.ConsortiaUnionValue = _loc2_.readInt(param1);
         this.ConsortiaShopValue = _loc2_.readInt(param1);
         this.Name = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.DefyEctypeNum = _loc2_.readInt(param1);
         this.Badge = _loc2_.readInt(param1);
         this.Honor = _loc2_.readInt(param1);
         this.ServerTime = _loc2_.readUnsignInt(param1);
         this.TollGate = _loc2_.readInt(param1);
         this.Year = _loc2_.readShort(param1);
         this.Month = _loc2_.readChar(param1);
         this.Day = _loc2_.readChar(param1);
         this.NoviceGuide = _loc2_.readInt(param1);
         this.WarScoreExchange = _loc2_.readUnsignInt(param1);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 76;
         param1 += MsgTypes.MAX_NAME;
         param1 += (4 - param1 % 4) % 4;
         param1 += 24;
         param1 += (4 - param1 % 4) % 4;
         return param1 + 8;
      }
      
      public function release() : void
      {
      }
   }
}

