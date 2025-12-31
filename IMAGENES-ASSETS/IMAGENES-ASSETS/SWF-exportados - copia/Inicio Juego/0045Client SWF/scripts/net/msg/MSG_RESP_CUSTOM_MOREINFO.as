package net.msg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   
   public class MSG_RESP_CUSTOM_MOREINFO extends MsgHead
   {
      
      public var Guid:int;
      
      public var Kind:int;
      
      public var UserId:Number;
      
      public var ProfileImage:String;
      
      public function MSG_RESP_CUSTOM_MOREINFO()
      {
         super();
         usSize = this.getLength();
         usType = 5001;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.UserId = _loc2_.readInt64(param1);
         this.Guid = _loc2_.readInt(param1);
         this.Kind = _loc2_.readChar(param1);
         this.ProfileImage = _loc2_.readInt(param1);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         return 8 + 4 + 1 + 4;
      }
      
      public function release() : void
      {
      }
   }
}

