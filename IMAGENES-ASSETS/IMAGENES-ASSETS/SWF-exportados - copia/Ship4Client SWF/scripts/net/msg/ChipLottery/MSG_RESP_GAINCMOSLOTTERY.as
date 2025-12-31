package net.msg.ChipLottery
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_GAINCMOSLOTTERY extends MsgHead
   {
      
      public var Guid:int;
      
      public var LotteryId:int;
      
      public var PropsId:int;
      
      public var Type:int;
      
      public var Credit:int;
      
      public var LotteryPhase:int;
      
      public var BroFlag:int;
      
      public var Name:String = "";
      
      public function MSG_RESP_GAINCMOSLOTTERY()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_GAINCMOSLOTTERY;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.Guid = _loc2_.readInt(param1);
         this.LotteryId = _loc2_.readInt(param1);
         this.PropsId = _loc2_.readInt(param1);
         this.Type = _loc2_.readInt(param1);
         this.Credit = _loc2_.readInt(param1);
         this.LotteryPhase = _loc2_.readChar(param1);
         this.BroFlag = _loc2_.readChar(param1);
         this.Name = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 22;
         return param1 + MsgTypes.MAX_NAME;
      }
      
      public function release() : void
      {
      }
   }
}

