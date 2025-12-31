package net.msg.sciencesystem
{
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
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_USEPROPS;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.PropsId = _loc2_.readInt(param1);
         this.LockFlag = _loc2_.readChar(param1);
         this.ErrorCode = _loc2_.readChar(param1);
         this.AwardFlag = _loc2_.readChar(param1);
         this.AwardLockFlag = _loc2_.readChar(param1);
         this.AwardGas = _loc2_.readInt(param1);
         this.AwardMoney = _loc2_.readInt(param1);
         this.AwardMetal = _loc2_.readInt(param1);
         this.AwardPropsLen = _loc2_.readInt(param1);
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
         this.MoveHomeFlag = _loc2_.readInt(param1);
         this.ToGalaxyMapId = _loc2_.readInt(param1);
         this.ToGalaxyId = _loc2_.readInt(param1);
         this.Num = _loc2_.readInt(param1);
         this.SpValue = _loc2_.readInt(param1);
         this.AwardCoins = _loc2_.readInt(param1);
         this.AwardBadge = _loc2_.readInt(param1);
         this.AwardHonor = _loc2_.readInt(param1);
         this.AwardActiveCredit = _loc2_.readInt(param1);
         this.PirateMoney = _loc2_.readInt(param1);
         _loc2_ = null;
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

