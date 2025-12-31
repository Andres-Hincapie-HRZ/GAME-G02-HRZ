package net.msg.fightMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_REQUEST_ARENA_PAGE extends MsgHead
   {
      
      public var SeqId:int;
      
      public var Guid:int;
      
      public var PageId:uint;
      
      public var ItemNum:int;
      
      public var ArenaFlag:int;
      
      public var cName:String = "";
      
      public function MSG_REQUEST_ARENA_PAGE()
      {
         super();
         this.ArenaFlag = 0;
         usSize = this.getLength();
         usType = MsgTypes._MSG_REQUEST_ARENA_PAGE;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         param1.position = 0;
         _loc2_.writeShort(param1,usSize);
         _loc2_.writeShort(param1,usType);
         _loc2_.writeInt(param1,this.SeqId);
         _loc2_.writeInt(param1,this.Guid);
         _loc2_.writeUnsignShort(param1,this.PageId);
         _loc2_.writeUnsignChar(param1,this.ItemNum);
         _loc2_.writeUnsignChar(param1,this.ArenaFlag);
         _loc2_.writeUtf8Str(param1,this.cName,MsgTypes.MAX_NAME);
         _loc2_.PushByte(param1,usSize - param1.position);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 12;
         return param1 + MsgTypes.MAX_NAME;
      }
      
      public function release() : void
      {
      }
   }
}

