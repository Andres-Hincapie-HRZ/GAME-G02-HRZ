package net.msg.galaxyMap
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_MOVEHOMEBRO extends MsgHead
   {
      
      public var DelGalaxy:int;
      
      public var Data:MSG_RESP_MAPAREA_TMP = new MSG_RESP_MAPAREA_TMP();
      
      public function MSG_RESP_MOVEHOMEBRO()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_MOVEHOMEBRO;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.DelGalaxy = _loc2_.readInt(param1);
         this.Data.readBuf(param1);
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         param1.position = 0;
         _loc2_.writeShort(param1,usSize);
         _loc2_.writeShort(param1,usType);
         _loc2_.writeInt(param1,this.DelGalaxy);
         this.Data.writeBuf(param1);
         _loc2_.PushByte(param1,usSize - param1.position);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 4;
         return this.Data.getLength(param1);
      }
      
      public function release() : void
      {
         this.Data.release();
      }
   }
}

