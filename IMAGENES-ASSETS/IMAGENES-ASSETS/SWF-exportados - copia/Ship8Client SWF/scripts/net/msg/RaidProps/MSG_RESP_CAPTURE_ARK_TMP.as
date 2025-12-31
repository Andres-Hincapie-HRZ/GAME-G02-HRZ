package net.msg.RaidProps
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   
   public class MSG_RESP_CAPTURE_ARK_TMP
   {
      
      public var RightPropsID:uint;
      
      public var LeftPropsID:uint;
      
      public var Countdown:uint;
      
      public var RoomState:int;
      
      public var RoomID:int;
      
      public function MSG_RESP_CAPTURE_ARK_TMP()
      {
         super();
         this.RightPropsID = 0;
         this.LeftPropsID = 0;
         this.Countdown = 0;
         this.RoomState = 0;
         this.RoomID = 0;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.GetByte(param1,(4 - param1.position % 4) % 4);
         this.RightPropsID = _loc2_.readUnsignShort(param1);
         this.LeftPropsID = _loc2_.readUnsignShort(param1);
         this.Countdown = _loc2_.readUnsignShort(param1);
         this.RoomState = _loc2_.readUnsignChar(param1);
         this.RoomID = _loc2_.readUnsignChar(param1);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 += (4 - param1 % 4) % 4;
         return param1 + 8;
      }
      
      public function release() : void
      {
      }
   }
}

