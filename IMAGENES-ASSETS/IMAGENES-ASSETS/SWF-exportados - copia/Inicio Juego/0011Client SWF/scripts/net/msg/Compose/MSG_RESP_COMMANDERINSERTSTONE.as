package net.msg.Compose
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_COMMANDERINSERTSTONE extends MsgHead
   {
      
      public var Type:int;
      
      public var CommanderId:int;
      
      public var HoleId:int;
      
      public var PropsId:int;
      
      public var LockFlag:int;
      
      public function MSG_RESP_COMMANDERINSERTSTONE()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_COMMANDERINSERTSTONE;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.Type = _loc2_.readInt(param1);
         this.CommanderId = _loc2_.readInt(param1);
         this.HoleId = _loc2_.readInt(param1);
         this.PropsId = _loc2_.readInt(param1);
         this.LockFlag = _loc2_.readInt(param1);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         return param1 + 20;
      }
      
      public function release() : void
      {
      }
   }
}

