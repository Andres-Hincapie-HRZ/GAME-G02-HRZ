package net.msg.sciencesystem
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   
   public class MSG_RESP_TECHINFO_TEMP
   {
      
      public var TechId:int;
      
      public var levelId:int;
      
      public function MSG_RESP_TECHINFO_TEMP()
      {
         super();
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.GetByte(param1,(4 - param1.position % 4) % 4);
         this.TechId = _loc2_.readShort(param1);
         this.levelId = _loc2_.readShort(param1);
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.PushByte(param1,(4 - param1.position % 4) % 4);
         _loc2_.writeShort(param1,this.TechId);
         _loc2_.writeShort(param1,this.levelId);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 += (4 - param1 % 4) % 4;
         return param1 + 4;
      }
      
      public function release() : void
      {
      }
   }
}

