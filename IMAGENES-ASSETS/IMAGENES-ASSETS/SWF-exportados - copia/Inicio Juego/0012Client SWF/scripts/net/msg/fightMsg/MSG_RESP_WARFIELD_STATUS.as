package net.msg.fightMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_WARFIELD_STATUS extends MsgHead
   {
      
      public var Warfield:int;
      
      public var UserNumber:uint;
      
      public var Status:int;
      
      public var MatchLevel:int;
      
      public function MSG_RESP_WARFIELD_STATUS()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_WARFIELD_STATUS;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.Warfield = _loc2_.readInt(param1);
         this.UserNumber = _loc2_.readUnsignShort(param1);
         this.Status = _loc2_.readChar(param1);
         this.MatchLevel = _loc2_.readChar(param1);
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

