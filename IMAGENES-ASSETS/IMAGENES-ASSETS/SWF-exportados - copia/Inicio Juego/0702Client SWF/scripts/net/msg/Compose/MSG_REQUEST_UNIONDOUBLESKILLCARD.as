package net.msg.Compose
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_REQUEST_UNIONDOUBLESKILLCARD extends MsgHead
   {
      
      public var SeqId:int;
      
      public var Guid:int;
      
      public var Card1:int;
      
      public var Card2:int;
      
      public var Goods:int;
      
      public var GoodsLockFlag:int;
      
      public var Chip:int;
      
      public var ChipLockFlag:int;
      
      public function MSG_REQUEST_UNIONDOUBLESKILLCARD()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_REQUEST_UNIONDOUBLESKILLCARD;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         param1.position = 0;
         _loc2_.writeShort(param1,usSize);
         _loc2_.writeShort(param1,usType);
         _loc2_.writeInt(param1,this.SeqId);
         _loc2_.writeInt(param1,this.Guid);
         _loc2_.writeInt(param1,this.Card1);
         _loc2_.writeInt(param1,this.Card2);
         _loc2_.writeInt(param1,this.Goods);
         _loc2_.writeInt(param1,this.GoodsLockFlag);
         _loc2_.writeInt(param1,this.Chip);
         _loc2_.writeInt(param1,this.ChipLockFlag);
         _loc2_.PushByte(param1,usSize - param1.position);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         return param1 + 32;
      }
      
      public function release() : void
      {
      }
   }
}

