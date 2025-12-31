package net.msg.mail
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   
   public class MSG_RESP_READEMAIL_TEMP
   {
      
      public var Id:int;
      
      public var Num:int;
      
      public var LockNum:int;
      
      public var BodyId:int;
      
      public function MSG_RESP_READEMAIL_TEMP()
      {
         super();
         this.Num = 0;
         this.LockNum = 0;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.GetByte(param1,(4 - param1.position % 4) % 4);
         this.Id = _loc2_.readInt(param1);
         this.Num = _loc2_.readInt(param1);
         this.LockNum = _loc2_.readShort(param1);
         this.BodyId = _loc2_.readShort(param1);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 += (4 - param1 % 4) % 4;
         return param1 + 12;
      }
      
      public function release() : void
      {
      }
   }
}

