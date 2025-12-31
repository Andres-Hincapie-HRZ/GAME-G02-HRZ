package net.msg.corpsMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_REQUEST_EDITCONSORTIA extends MsgHead
   {
      
      public var SeqId:int;
      
      public var Guid:int;
      
      public var Notice:String = "";
      
      public var Proclaim:String = "";
      
      public var HeadId:int;
      
      public function MSG_REQUEST_EDITCONSORTIA()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_REQUEST_EDITCONSORTIA;
         this.HeadId = -1;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         param1.position = 0;
         _loc2_.writeShort(param1,usSize);
         _loc2_.writeShort(param1,usType);
         _loc2_.writeInt(param1,this.SeqId);
         _loc2_.writeInt(param1,this.Guid);
         _loc2_.writeUtf8Str(param1,this.Notice,MsgTypes.MAX_MEMO);
         _loc2_.writeUtf8Str(param1,this.Proclaim,MsgTypes.MAX_MEMO);
         _loc2_.writeChar(param1,this.HeadId);
         _loc2_.PushByte(param1,usSize - param1.position);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 8;
         param1 += MsgTypes.MAX_MEMO;
         param1 += MsgTypes.MAX_MEMO;
         return param1 + 1;
      }
      
      public function release() : void
      {
      }
   }
}

