package net.msg.RaidProps
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_CAPTURE_ARK_INFO extends MsgHead
   {
      
      public var Place:int;
      
      public var RoomID:int;
      
      public var Capture:int;
      
      public var Search:int;
      
      public var Countdown:uint;
      
      public var Reserve:int;
      
      public var SpareType:int;
      
      public var SpareTime:uint;
      
      public function MSG_RESP_CAPTURE_ARK_INFO()
      {
         super();
         this.Reserve = 0;
         this.SpareType = 0;
         this.SpareTime = 0;
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_CAPTURE_ARK_INFO;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.Place = _loc2_.readUnsignChar(param1);
         this.RoomID = _loc2_.readUnsignChar(param1);
         this.Capture = _loc2_.readUnsignChar(param1);
         this.Search = _loc2_.readUnsignChar(param1);
         this.Countdown = _loc2_.readUnsignShort(param1);
         this.Reserve = _loc2_.readUnsignChar(param1);
         this.SpareType = _loc2_.readUnsignChar(param1);
         this.SpareTime = _loc2_.readUnsignInt(param1);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         return param1 + 12;
      }
      
      public function release() : void
      {
      }
   }
}

