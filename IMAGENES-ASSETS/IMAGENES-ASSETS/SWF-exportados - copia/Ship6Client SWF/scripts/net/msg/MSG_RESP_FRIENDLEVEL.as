package net.msg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_FRIENDLEVEL extends MsgHead
   {
      
      public var DataLen:int;
      
      public var Data:Array = new Array(MsgTypes.MAX_MSGFRIENDLEN);
      
      public var DataLevel:Array = new Array(MsgTypes.MAX_MSGFRIENDLEN);
      
      public function MSG_RESP_FRIENDLEVEL()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_FRIENDLEVEL;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.DataLen = _loc2_.readInt(param1);
         var _loc3_:int = 0;
         while(_loc3_ < MsgTypes.MAX_MSGFRIENDLEN)
         {
            if(param1.length - param1.position >= 8)
            {
               this.Data[_loc3_] = _loc2_.readInt64(param1);
            }
            _loc3_++;
         }
         var _loc4_:int = 0;
         while(_loc4_ < MsgTypes.MAX_MSGFRIENDLEN)
         {
            if(param1.length - param1.position >= 1)
            {
               this.DataLevel[_loc4_] = _loc2_.readUnsignChar(param1);
            }
            _loc4_++;
         }
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 4;
         param1 += (8 - param1 % 8) % 8;
         param1 += MsgTypes.MAX_MSGFRIENDLEN * 8;
         return param1 + MsgTypes.MAX_MSGFRIENDLEN * 1;
      }
      
      public function release() : void
      {
         this.Data.splice(0);
         this.Data = null;
         this.DataLevel.splice(0);
         this.DataLevel = null;
      }
   }
}

