package net.msg.fleetMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_EDITSHIPTEAM extends MsgHead
   {
      
      public var GalaxyMapId:int;
      
      public var GalaxyId:int;
      
      public var Data:MSG_RESP_GALAXYSHIP_TEMP = new MSG_RESP_GALAXYSHIP_TEMP();
      
      public function MSG_RESP_EDITSHIPTEAM()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_EDITSHIPTEAM;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.GalaxyMapId = _loc2_.readInt(param1);
         this.GalaxyId = _loc2_.readInt(param1);
         this.Data.readBuf(param1);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 8;
         return this.Data.getLength(param1);
      }
      
      public function release() : void
      {
         this.Data.release();
      }
   }
}

