package net.msg.gymkhanaMSg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_DUPLICATE_STATUS extends MsgHead
   {
      
      public var SeqId:int;
      
      public var Guid:int;
      
      public var Duplicate:int;
      
      public var Status:int;
      
      public function MSG_DUPLICATE_STATUS()
      {
         super();
         this.SeqId = 0;
         this.Guid = 0;
         this.Duplicate = 0;
         this.Status = 0;
         usSize = this.getLength();
         usType = MsgTypes._MSG_DUPLICATE_STATUS;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.SeqId = _loc2_.readInt(param1);
         this.Guid = _loc2_.readInt(param1);
         this.Duplicate = _loc2_.readUnsignChar(param1);
         this.Status = _loc2_.readUnsignChar(param1);
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         param1.position = 0;
         _loc2_.writeShort(param1,usSize);
         _loc2_.writeShort(param1,usType);
         _loc2_.writeInt(param1,this.SeqId);
         _loc2_.writeInt(param1,this.Guid);
         _loc2_.writeUnsignChar(param1,this.Duplicate);
         _loc2_.writeUnsignChar(param1,this.Status);
         _loc2_.PushByte(param1,usSize - param1.position);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         return param1 + 10;
      }
      
      public function release() : void
      {
      }
   }
}

