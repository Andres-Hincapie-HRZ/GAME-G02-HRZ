package net.msg
{
   import flash.external.ExternalInterface;
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_CLIENT_LOGINTOL extends MsgHead
   {
      
      public var SeqId:int;
      
      public var UserId:Number;
      
      public var SessionKey:String = "";
      
      public var GameServerId:int;
      
      public var RegisterFlag:int;
      
      public var RegisterName:String = "";
      
      public function MSG_CLIENT_LOGINTOL()
      {
         super();
         usSize = uint(this.getLength());
         usType = uint(MsgTypes._MSG_CLIENT_LOGINTOL);
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = uint(_loc2_.readMsgSize(param1));
         usType = uint(_loc2_.readMsgType(param1));
         this.SeqId = int(_loc2_.readInt(param1));
         this.UserId = Number(_loc2_.readInt64(param1));
         this.SessionKey = _loc2_.readUtf8Str(param1,128);
         this.GameServerId = int(_loc2_.readInt(param1));
         this.RegisterFlag = int(_loc2_.readInt(param1));
         this.RegisterName = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         _loc2_ = null;
         ExternalInterface.call("console.log","[#] >>> SeqId => " + this.SeqId);
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         param1.position = 0;
         _loc2_.writeShort(param1,usSize);
         _loc2_.writeShort(param1,usType);
         _loc2_.writeInt(param1,this.SeqId);
         _loc2_.writeInt64(param1,this.UserId);
         _loc2_.writeUtf8Str(param1,this.SessionKey,128);
         _loc2_.writeInt(param1,this.GameServerId);
         _loc2_.writeInt(param1,this.RegisterFlag);
         _loc2_.writeUtf8Str(param1,this.RegisterName,MsgTypes.MAX_NAME);
         _loc2_.PushByte(param1,usSize - param1.position);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 12;
         param1 += 128;
         param1 = (param1 + (4 - param1)) % 4 % 4;
         param1 += 8;
         return param1 + MsgTypes.MAX_NAME;
      }
      
      public function release() : void
      {
      }
   }
}

