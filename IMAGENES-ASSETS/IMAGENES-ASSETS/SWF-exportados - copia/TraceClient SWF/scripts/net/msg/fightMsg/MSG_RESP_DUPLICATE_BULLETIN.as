package net.msg.fightMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_DUPLICATE_BULLETIN extends MsgHead
   {
      
      public var DuplicateType:int;
      
      public var BulletinType:int;
      
      public var Countdown:uint;
      
      public function MSG_RESP_DUPLICATE_BULLETIN()
      {
         super();
         this.DuplicateType = 1;
         this.BulletinType = 0;
         this.Countdown = 0;
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_DUPLICATE_BULLETIN;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.DuplicateType = _loc2_.readUnsignChar(param1);
         this.BulletinType = _loc2_.readUnsignChar(param1);
         this.Countdown = _loc2_.readUnsignShort(param1);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         return param1 + 4;
      }
      
      public function release() : void
      {
      }
   }
}

