package net.msg.corpsMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_REQUEST_CONSORTIAUPDATAVALUE extends MsgHead
   {
      
      public var SeqId:int;
      
      public var Guid:int;
      
      public var NeedUnionValue:int;
      
      public var NeedShopValue:int;
      
      public function MSG_REQUEST_CONSORTIAUPDATAVALUE()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_REQUEST_CONSORTIAUPDATAVALUE;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         param1.position = 0;
         _loc2_.writeShort(param1,usSize);
         _loc2_.writeShort(param1,usType);
         _loc2_.writeInt(param1,this.SeqId);
         _loc2_.writeInt(param1,this.Guid);
         _loc2_.writeInt(param1,this.NeedUnionValue);
         _loc2_.writeInt(param1,this.NeedShopValue);
         _loc2_.PushByte(param1,usSize - param1.position);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         return param1 + 16;
      }
      
      public function release() : void
      {
      }
   }
}

