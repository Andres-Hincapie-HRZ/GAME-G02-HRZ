package net.msg.friend
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_FRIENDPASSAUTH extends MsgHead
   {
      
      public var FriendGuid:int;
      
      public var UserId:Number;
      
      public var FriendName:String = "";
      
      public function MSG_RESP_FRIENDPASSAUTH()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_FRIENDPASSAUTH;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.FriendGuid = _loc2_.readInt(param1);
         this.UserId = _loc2_.readInt64(param1);
         this.FriendName = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 12;
         return param1 + MsgTypes.MAX_NAME;
      }
      
      public function release() : void
      {
      }
   }
}

