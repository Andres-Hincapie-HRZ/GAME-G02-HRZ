package net.msg.RaidProps
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_CAPTURE_BULLETIN extends MsgHead
   {
      
      public var RoomID:int;
      
      public var BulletinType:int;
      
      public var Countdown:uint;
      
      public var LeftUserName:String = "";
      
      public var RightUserName:String = "";
      
      public var CaptureUserName:String = "";
      
      public function MSG_RESP_CAPTURE_BULLETIN()
      {
         super();
         this.RoomID = 0;
         this.BulletinType = 0;
         this.Countdown = 0;
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_CAPTURE_BULLETIN;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.RoomID = _loc2_.readUnsignChar(param1);
         this.BulletinType = _loc2_.readUnsignChar(param1);
         this.Countdown = _loc2_.readUnsignShort(param1);
         this.LeftUserName = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.RightUserName = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.CaptureUserName = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 4;
         param1 += MsgTypes.MAX_NAME;
         param1 += MsgTypes.MAX_NAME;
         return param1 + MsgTypes.MAX_NAME;
      }
      
      public function release() : void
      {
      }
   }
}

