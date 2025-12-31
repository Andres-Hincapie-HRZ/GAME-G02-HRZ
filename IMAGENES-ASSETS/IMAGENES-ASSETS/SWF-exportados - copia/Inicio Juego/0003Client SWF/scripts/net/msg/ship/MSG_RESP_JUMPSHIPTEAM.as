package net.msg.ship
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_JUMPSHIPTEAM extends MsgHead
   {
      
      public var Data:MSG_RESP_JUMPSHIPTEAMINFO_TEMP = new MSG_RESP_JUMPSHIPTEAMINFO_TEMP();
      
      public function MSG_RESP_JUMPSHIPTEAM()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_JUMPSHIPTEAM;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.Data.readBuf(param1);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         return this.Data.getLength(param1);
      }
      
      public function release() : void
      {
         this.Data.release();
      }
   }
}

