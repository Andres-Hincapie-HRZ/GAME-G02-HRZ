package net.msg.galaxyMap
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_REQUEST_MOVEHOME extends MsgHead
   {
      
      public var SeqId:int;
      
      public var Guid:int;
      
      public var ToGalaxyMapId:int;
      
      public var ToGalaxyId:int;
      
      public function MSG_REQUEST_MOVEHOME()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_REQUEST_MOVEHOME;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         param1.position = 0;
         _loc2_.writeShort(param1,usSize);
         _loc2_.writeShort(param1,usType);
         _loc2_.writeInt(param1,this.SeqId);
         _loc2_.writeInt(param1,this.Guid);
         _loc2_.writeInt(param1,this.ToGalaxyMapId);
         _loc2_.writeInt(param1,this.ToGalaxyId);
         _loc2_.PushByte(param1,usSize - param1.position);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         return param1 + 16;
      }
      
      public function release() : void
      {
      }
   }
}

