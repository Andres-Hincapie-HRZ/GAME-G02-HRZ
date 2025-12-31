package net.msg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_CLIENT_LOGINTOG extends MsgHead
   {
      
      public var SeqId:int;
      
      public var UserId:Number;
      
      public var CheckOutText:String = "";
      
      public var SessionKey:String = "";
      
      public var RegisterName:String = "";
      
      public var RegisterFlag:int;
      
      public function MSG_CLIENT_LOGINTOG()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_CLIENT_LOGINTOG;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.SeqId = _loc2_.readInt(param1);
         this.UserId = _loc2_.readInt64(param1);
         this.CheckOutText = _loc2_.readUtf8Str(param1,MsgTypes.VALIDATECODE_LENTH);
         this.SessionKey = _loc2_.readUtf8Str(param1,MsgTypes.SESSIONKEY_LENGTH);
         this.RegisterName = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.RegisterFlag = _loc2_.readChar(param1);
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         param1.position = 0;
         _loc2_.writeShort(param1,usSize);
         _loc2_.writeShort(param1,usType);
         _loc2_.writeInt(param1,this.SeqId);
         _loc2_.writeInt64(param1,this.UserId);
         _loc2_.writeUtf8Str(param1,this.CheckOutText,MsgTypes.VALIDATECODE_LENTH);
         _loc2_.writeUtf8Str(param1,this.SessionKey,MsgTypes.SESSIONKEY_LENGTH);
         _loc2_.writeUtf8Str(param1,this.RegisterName,MsgTypes.MAX_NAME);
         _loc2_.writeChar(param1,this.RegisterFlag);
         _loc2_.PushByte(param1,usSize - param1.position);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 12;
         param1 += MsgTypes.VALIDATECODE_LENTH;
         param1 += MsgTypes.SESSIONKEY_LENGTH;
         param1 += MsgTypes.MAX_NAME;
         return param1 + 1;
      }
      
      public function release() : void
      {
      }
   }
}

