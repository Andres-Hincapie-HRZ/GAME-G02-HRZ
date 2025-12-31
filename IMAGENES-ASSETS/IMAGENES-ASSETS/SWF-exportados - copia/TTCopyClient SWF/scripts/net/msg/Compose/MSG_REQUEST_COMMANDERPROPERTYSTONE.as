package net.msg.Compose
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_REQUEST_COMMANDERPROPERTYSTONE extends MsgHead
   {
      
      public var SeqId:int;
      
      public var Guid:int;
      
      public var Type:int;
      
      public var LockFlag:int;
      
      public var ObjStoneId:int;
      
      public var SrcStoneId1:int;
      
      public var SrcStoneId2:int;
      
      public var SrcStoneId3:int;
      
      public function MSG_REQUEST_COMMANDERPROPERTYSTONE()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_REQUEST_COMMANDERPROPERTYSTONE;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         param1.position = 0;
         _loc2_.writeShort(param1,usSize);
         _loc2_.writeShort(param1,usType);
         _loc2_.writeInt(param1,this.SeqId);
         _loc2_.writeInt(param1,this.Guid);
         _loc2_.writeInt(param1,this.Type);
         _loc2_.writeInt(param1,this.LockFlag);
         _loc2_.writeInt(param1,this.ObjStoneId);
         _loc2_.writeInt(param1,this.SrcStoneId1);
         _loc2_.writeInt(param1,this.SrcStoneId2);
         _loc2_.writeInt(param1,this.SrcStoneId3);
         _loc2_.PushByte(param1,usSize - param1.position);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         return param1 + 32;
      }
      
      public function release() : void
      {
      }
   }
}

