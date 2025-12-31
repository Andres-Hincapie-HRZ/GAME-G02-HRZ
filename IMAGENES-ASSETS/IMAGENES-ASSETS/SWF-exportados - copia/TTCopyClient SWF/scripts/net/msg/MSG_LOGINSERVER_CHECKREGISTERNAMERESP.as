package net.msg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_LOGINSERVER_CHECKREGISTERNAMERESP extends MsgHead
   {
      
      public var SocketAutoId:int;
      
      public var UserId:Number;
      
      public var GameServerId:int;
      
      public var ErrorCode:int;
      
      public function MSG_LOGINSERVER_CHECKREGISTERNAMERESP()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_LOGINSERVER_CHECKREGISTERNAMERESP;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.SocketAutoId = _loc2_.readInt(param1);
         this.UserId = _loc2_.readInt64(param1);
         this.GameServerId = _loc2_.readInt(param1);
         this.ErrorCode = _loc2_.readInt(param1);
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         param1.position = 0;
         _loc2_.writeShort(param1,usSize);
         _loc2_.writeShort(param1,usType);
         _loc2_.writeInt(param1,this.SocketAutoId);
         _loc2_.writeInt64(param1,this.UserId);
         _loc2_.writeInt(param1,this.GameServerId);
         _loc2_.writeInt(param1,this.ErrorCode);
         _loc2_.PushByte(param1,usSize - param1.position);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         return param1 + 20;
      }
      
      public function release() : void
      {
      }
   }
}

