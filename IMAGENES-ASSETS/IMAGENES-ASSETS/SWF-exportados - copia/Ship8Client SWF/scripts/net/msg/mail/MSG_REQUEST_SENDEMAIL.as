package net.msg.mail
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_REQUEST_SENDEMAIL extends MsgHead
   {
      
      public var SeqId:int;
      
      public var Guid:int;
      
      public var SendGuid:int;
      
      public var Title:String = "";
      
      public var Content:String = "";
      
      public function MSG_REQUEST_SENDEMAIL()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_REQUEST_SENDEMAIL;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.SeqId = _loc2_.readInt(param1);
         this.Guid = _loc2_.readInt(param1);
         this.SendGuid = _loc2_.readInt(param1);
         this.Title = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.Content = _loc2_.readUtf8Str(param1,MsgTypes.MAX_EMAILCONTENT);
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
         _loc2_.writeInt(param1,this.SendGuid);
         _loc2_.writeUtf8Str(param1,this.Title,MsgTypes.MAX_NAME);
         _loc2_.writeUtf8Str(param1,this.Content,MsgTypes.MAX_EMAILCONTENT);
         _loc2_.PushByte(param1,usSize - param1.position);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 12;
         param1 += MsgTypes.MAX_NAME;
         return param1 + MsgTypes.MAX_EMAILCONTENT;
      }
      
      public function release() : void
      {
      }
   }
}

