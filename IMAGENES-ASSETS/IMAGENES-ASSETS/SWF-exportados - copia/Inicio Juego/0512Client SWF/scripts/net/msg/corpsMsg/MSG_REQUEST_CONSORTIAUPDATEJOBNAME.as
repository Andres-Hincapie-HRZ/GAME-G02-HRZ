package net.msg.corpsMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_REQUEST_CONSORTIAUPDATEJOBNAME extends MsgHead
   {
      
      public var SeqId:int;
      
      public var Guid:int;
      
      public var JobName:ConsortiaJobName = new ConsortiaJobName();
      
      public function MSG_REQUEST_CONSORTIAUPDATEJOBNAME()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_REQUEST_CONSORTIAUPDATEJOBNAME;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         param1.position = 0;
         _loc2_.writeShort(param1,usSize);
         _loc2_.writeShort(param1,usType);
         _loc2_.writeInt(param1,this.SeqId);
         _loc2_.writeInt(param1,this.Guid);
         this.JobName.writeBuf(param1);
         _loc2_.PushByte(param1,usSize - param1.position);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 8;
         return this.JobName.getLength(param1);
      }
      
      public function release() : void
      {
         this.JobName.release();
      }
   }
}

