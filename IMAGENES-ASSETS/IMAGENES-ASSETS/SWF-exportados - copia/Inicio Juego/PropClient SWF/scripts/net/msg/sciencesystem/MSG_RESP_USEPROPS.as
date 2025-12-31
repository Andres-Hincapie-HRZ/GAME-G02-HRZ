package net.msg.sciencesystem
{
   import flash.external.ExternalInterface;
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_USEPROPS extends MsgHead
   {
      
      public var PropsId:int;
      
      public var LockFlag:int;
      
      public var ErrorCode:int;
      
      public var AwardFlag:int;
      
      public var AwardLockFlag:int;
      
      public var AwardGas:int;
      
      public var AwardMoney:int;
      
      public var AwardMetal:int;
      
      public var AwardPropsLen:int;
      
      public var AwardPropsId:Array = new Array(10);
      
      public var AwardPropsNum:Array = new Array(10);
      
      public var MoveHomeFlag:int;
      
      public var ToGalaxyMapId:int;
      
      public var ToGalaxyId:int;
      
      public var Num:int;
      
      public var SpValue:int;
      
      public var AwardCoins:int;
      
      public var AwardBadge:int;
      
      public var AwardHonor:int;
      
      public var AwardActiveCredit:int;
      
      public var PirateMoney:int;
      
      public function MSG_RESP_USEPROPS()
      {
         super();
         usSize = uint(uint(uint(uint(this.getLength()))));
         usType = uint(uint(uint(uint(MsgTypes._MSG_RESP_USEPROPS))));
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = uint(uint(uint(uint(_loc2_.readMsgSize(param1)))));
         usType = uint(uint(uint(uint(_loc2_.readMsgType(param1)))));
         this.PropsId = int(int(int(int(_loc2_.readInt(param1)))));
         this.LockFlag = int(int(int(int(_loc2_.readChar(param1)))));
         this.ErrorCode = int(int(int(int(_loc2_.readChar(param1)))));
         this.AwardFlag = int(int(int(int(_loc2_.readChar(param1)))));
         this.AwardLockFlag = int(int(int(int(_loc2_.readChar(param1)))));
         this.AwardGas = int(int(int(int(_loc2_.readInt(param1)))));
         this.AwardMoney = int(int(int(int(_loc2_.readInt(param1)))));
         this.AwardMetal = int(int(int(int(_loc2_.readInt(param1)))));
         this.AwardPropsLen = int(int(int(int(_loc2_.readInt(param1)))));
         var _loc3_:int = 0;
         while(_loc3_ < 10)
         {
            if(param1.length - param1.position >= 4)
            {
               this.AwardPropsId[_loc3_] = _loc2_.readInt(param1);
            }
            _loc3_++;
         }
         var _loc4_:int = 0;
         while(_loc4_ < 10)
         {
            if(param1.length - param1.position >= 4)
            {
               this.AwardPropsNum[_loc4_] = _loc2_.readInt(param1);
            }
            _loc4_++;
         }
         this.MoveHomeFlag = int(int(int(int(_loc2_.readInt(param1)))));
         this.ToGalaxyMapId = int(int(int(int(_loc2_.readInt(param1)))));
         this.ToGalaxyId = int(int(int(int(_loc2_.readInt(param1)))));
         this.Num = int(int(int(int(_loc2_.readInt(param1)))));
         this.SpValue = int(int(int(int(_loc2_.readInt(param1)))));
         this.AwardCoins = int(int(int(int(_loc2_.readInt(param1)))));
         this.AwardBadge = int(int(int(int(_loc2_.readInt(param1)))));
         this.AwardHonor = int(int(int(int(_loc2_.readInt(param1)))));
         this.AwardActiveCredit = int(int(int(int(_loc2_.readInt(param1)))));
         this.PirateMoney = int(int(int(int(_loc2_.readInt(param1)))));
         _loc2_ = null;
         ExternalInterface.call("console.log","[#] #USEPROP ======================= ");
         ExternalInterface.call("console.log","[#] SIZE => " + usSize);
         ExternalInterface.call("console.log","[#] TYPE => " + usType);
         ExternalInterface.call("console.log","[#] PropsId => " + this.PropsId);
         ExternalInterface.call("console.log","[#] LockFlag => " + this.LockFlag);
         ExternalInterface.call("console.log","[#] ErrorCode => " + this.ErrorCode);
         ExternalInterface.call("console.log","[#] AwardFlag => " + this.AwardFlag);
         ExternalInterface.call("console.log","[#] AwardLockFlag => " + this.AwardLockFlag);
         ExternalInterface.call("console.log","[#] AwardGas => " + this.AwardGas);
         ExternalInterface.call("console.log","[#] AwardMoney => " + this.AwardMoney);
         ExternalInterface.call("console.log","[#] AwardMetal => " + this.AwardMetal);
         ExternalInterface.call("console.log","[#] AwardPropsLen => " + this.AwardPropsLen);
         ExternalInterface.call("console.log","[#] AwardPropsId => " + this.AwardPropsId);
         ExternalInterface.call("console.log","[#] AwardPropsNum => " + this.AwardPropsNum);
         ExternalInterface.call("console.log","[#] MoveHomeFlag => " + this.MoveHomeFlag);
         ExternalInterface.call("console.log","[#] ToGalaxyMapId => " + this.ToGalaxyMapId);
         ExternalInterface.call("console.log","[#] ToGalaxyId => " + this.ToGalaxyId);
         ExternalInterface.call("console.log","[#] Num => " + this.Num);
         ExternalInterface.call("console.log","[#] SpValue => " + this.SpValue);
         ExternalInterface.call("console.log","[#] AwardCoins => " + this.AwardCoins);
         ExternalInterface.call("console.log","[#] AwardBadge => " + this.AwardBadge);
         ExternalInterface.call("console.log","[#] AwardHonor => " + this.AwardHonor);
         ExternalInterface.call("console.log","[#] AwardActiveCredit => " + this.AwardActiveCredit);
         ExternalInterface.call("console.log","[#] PirateMoney => " + this.PirateMoney);
         ExternalInterface.call("console.log","[#] ======================= ");
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 24;
         param1 += 10 * 4;
         param1 += 10 * 4;
         return param1 + 40;
      }
      
      public function release() : void
      {
         this.AwardPropsId.splice(0);
         this.AwardPropsId = null;
         this.AwardPropsNum.splice(0);
         this.AwardPropsNum = null;
      }
   }
}

