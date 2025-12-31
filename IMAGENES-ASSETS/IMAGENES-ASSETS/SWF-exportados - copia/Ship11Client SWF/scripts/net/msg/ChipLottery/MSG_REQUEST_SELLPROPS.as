package net.msg.ChipLottery
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_REQUEST_SELLPROPS extends MsgHead
   {
      
      public var SeqId:int;
      
      public var Guid:int;
      
      public var Type:int;
      
      public var Id:int;
      
      public var LockFlag:int;
      
      public var Num:int;
      
      public function MSG_REQUEST_SELLPROPS()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_REQUEST_SELLPROPS;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         param1.position = 0;
         _loc2_.writeShort(param1,usSize);
         _loc2_.writeShort(param1,usType);
         _loc2_.writeInt(param1,this.SeqId);
         _loc2_.writeInt(param1,this.Guid);
         _loc2_.writeInt(param1,this.Type);
         _loc2_.writeInt(param1,this.Id);
         _loc2_.writeInt(param1,this.LockFlag);
         _loc2_.writeInt(param1,this.Num);
         _loc2_.PushByte(param1,usSize - param1.position);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         return param1 + 24;
      }
      
      public function release() : void
      {
      }
   }
}

