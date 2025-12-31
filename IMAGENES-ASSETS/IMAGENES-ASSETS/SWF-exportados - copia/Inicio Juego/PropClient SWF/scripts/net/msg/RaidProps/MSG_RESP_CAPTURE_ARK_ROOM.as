package net.msg.RaidProps
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_CAPTURE_ARK_ROOM extends MsgHead
   {
      
      public var RightPropsID:uint;
      
      public var LeftPropsID:uint;
      
      public var Countdown:uint;
      
      public var RoomState:int;
      
      public var RoomID:int;
      
      public function MSG_RESP_CAPTURE_ARK_ROOM()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_CAPTURE_ARK_ROOM;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.RightPropsID = _loc2_.readUnsignShort(param1);
         this.LeftPropsID = _loc2_.readUnsignShort(param1);
         this.Countdown = _loc2_.readUnsignShort(param1);
         this.RoomState = _loc2_.readUnsignChar(param1);
         this.RoomID = _loc2_.readUnsignChar(param1);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         return param1 + 8;
      }
      
      public function release() : void
      {
      }
   }
}

