package net.msg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_LOGINSERVER_VALIDATE extends MsgHead
   {
      
      public var Port:int;
      
      public var UserId:Number;
      
      public var Ip:String;
      
      public var CheckOutText:String;
      
      public function MSG_LOGINSERVER_VALIDATE()
      {
         super();
         usSize = 73;
         usType = MsgTypes._MSG_LOGINSERVER_VALIDATE;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.Port = _loc2_.readInt(param1);
         this.UserId = _loc2_.readInt64(param1);
         this.Ip = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.CheckOutText = _loc2_.readUtf8Str(param1,MsgTypes.VALIDATECODE_LENTH);
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : int
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         param1.position = 0;
         var _loc3_:int = 0;
         _loc2_.writeShort(param1,usSize);
         _loc2_.writeShort(param1,usType);
         _loc2_.writeInt(param1,this.Port);
         _loc2_.writeInt64(param1,this.UserId);
         _loc2_.writeUtf8Str(param1,this.Ip,MsgTypes.MAX_NAME);
         _loc2_.writeUtf8Str(param1,this.CheckOutText,MsgTypes.VALIDATECODE_LENTH);
         param1.position = 0;
         _loc2_.writeShort(param1,_loc3_ + 73);
         _loc2_ = null;
         return _loc3_ + 73;
      }
      
      public function getLength() : int
      {
         return 73;
      }
      
      public function release() : void
      {
      }
   }
}

