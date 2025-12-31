package net.msg.constructionMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   
   public class MSG_RESP_CREATEBUILDINFO_TEMP
   {
      
      public var IndexId:int;
      
      public var SpareTime:int;
      
      public function MSG_RESP_CREATEBUILDINFO_TEMP()
      {
         super();
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.GetByte(param1,(4 - param1.position % 4) % 4);
         this.IndexId = _loc2_.readInt(param1);
         this.SpareTime = _loc2_.readInt(param1);
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.PushByte(param1,(4 - param1.position % 4) % 4);
         _loc2_.writeInt(param1,this.IndexId);
         _loc2_.writeInt(param1,this.SpareTime);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 += (4 - param1 % 4) % 4;
         return param1 + 8;
      }
      
      public function release() : void
      {
      }
   }
}

