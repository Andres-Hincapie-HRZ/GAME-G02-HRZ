package net.msg.friend
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_FRIENDLIST extends MsgHead
   {
      
      public var DataLen:int;
      
      public var Type:int;
      
      public var FriendCount:int;
      
      public var Data:Array;
      
      public function MSG_RESP_FRIENDLIST()
      {
         var _loc2_:FriendChatUserInfo = null;
         this.Data = new Array(9);
         super();
         var _loc1_:int = 0;
         while(_loc1_ < 9)
         {
            _loc2_ = new FriendChatUserInfo();
            this.Data[_loc1_] = _loc2_;
            _loc1_++;
         }
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_FRIENDLIST;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.DataLen = _loc2_.readChar(param1);
         this.Type = _loc2_.readChar(param1);
         this.FriendCount = _loc2_.readShort(param1);
         var _loc3_:int = 0;
         while(_loc3_ < 9)
         {
            if(param1.length > param1.position)
            {
               this.Data[_loc3_].readBuf(param1);
            }
            _loc3_++;
         }
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 4;
         var _loc2_:int = 0;
         while(_loc2_ < 9)
         {
            param1 = int(this.Data[_loc2_].getLength(param1));
            _loc2_++;
         }
         return param1;
      }
      
      public function release() : void
      {
         var _loc1_:int = 9 - 1;
         while(_loc1_ >= 0)
         {
            this.Data[_loc1_].release();
            _loc1_--;
         }
         this.Data.splice(0);
         this.Data = null;
      }
   }
}

