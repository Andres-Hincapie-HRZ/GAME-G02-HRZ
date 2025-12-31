package net.msg.fightMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_ARENA_STATUS extends MsgHead
   {
      
      public var Guid:int;
      
      public var cName:String = "";
      
      public var RoomId:int;
      
      public var Request:int;
      
      public var Status:int;
      
      public function MSG_RESP_ARENA_STATUS()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_ARENA_STATUS;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.Guid = _loc2_.readInt(param1);
         this.cName = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.RoomId = _loc2_.readInt(param1);
         this.Request = _loc2_.readUnsignChar(param1);
         this.Status = _loc2_.readChar(param1);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 4;
         param1 += MsgTypes.MAX_NAME;
         param1 += (4 - param1 % 4) % 4;
         return param1 + 6;
      }
      
      public function release() : void
      {
      }
   }
}

