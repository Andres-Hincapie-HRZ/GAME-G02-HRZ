package net.msg.sciencesystem
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_GAINLOTTERY extends MsgHead
   {
      
      public var Guid:int;
      
      public var UserId:Number;
      
      public var Name:String = "";
      
      public var Type:int;
      
      public var LotteryId:int;
      
      public var LotteryType:int;
      
      public var PropsId:int;
      
      public var Num:int;
      
      public var Coins:int;
      
      public var Metal:int;
      
      public var Gas:int;
      
      public var Money:int;
      
      public var BroFlag:int;
      
      public var LockFlag:int;
      
      public function MSG_RESP_GAINLOTTERY()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_GAINLOTTERY;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.Guid = _loc2_.readInt(param1);
         this.UserId = _loc2_.readInt64(param1);
         this.Name = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.Type = _loc2_.readInt(param1);
         this.LotteryId = _loc2_.readInt(param1);
         this.LotteryType = _loc2_.readInt(param1);
         this.PropsId = _loc2_.readInt(param1);
         this.Num = _loc2_.readInt(param1);
         this.Coins = _loc2_.readInt(param1);
         this.Metal = _loc2_.readInt(param1);
         this.Gas = _loc2_.readInt(param1);
         this.Money = _loc2_.readInt(param1);
         this.BroFlag = _loc2_.readInt(param1);
         this.LockFlag = _loc2_.readInt(param1);
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         param1.position = 0;
         _loc2_.writeShort(param1,usSize);
         _loc2_.writeShort(param1,usType);
         _loc2_.writeInt(param1,this.Guid);
         _loc2_.writeInt64(param1,this.UserId);
         _loc2_.writeUtf8Str(param1,this.Name,MsgTypes.MAX_NAME);
         _loc2_.writeInt(param1,this.Type);
         _loc2_.writeInt(param1,this.LotteryId);
         _loc2_.writeInt(param1,this.LotteryType);
         _loc2_.writeInt(param1,this.PropsId);
         _loc2_.writeInt(param1,this.Num);
         _loc2_.writeInt(param1,this.Coins);
         _loc2_.writeInt(param1,this.Metal);
         _loc2_.writeInt(param1,this.Gas);
         _loc2_.writeInt(param1,this.Money);
         _loc2_.writeInt(param1,this.BroFlag);
         _loc2_.writeInt(param1,this.LockFlag);
         _loc2_.PushByte(param1,usSize - param1.position);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 12;
         param1 += MsgTypes.MAX_NAME;
         param1 += (4 - param1 % 4) % 4;
         return param1 + 44;
      }
      
      public function release() : void
      {
      }
   }
}

