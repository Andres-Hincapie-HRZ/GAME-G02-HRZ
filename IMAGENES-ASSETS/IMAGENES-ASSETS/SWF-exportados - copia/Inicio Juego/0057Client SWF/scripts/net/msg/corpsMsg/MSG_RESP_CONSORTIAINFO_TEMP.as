package net.msg.corpsMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgTypes;
   
   public class MSG_RESP_CONSORTIAINFO_TEMP
   {
      
      public var Name:String = "";
      
      public var ConsortiaId:int;
      
      public var RankId:int;
      
      public function MSG_RESP_CONSORTIAINFO_TEMP()
      {
         super();
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.GetByte(param1,(4 - param1.position % 4) % 4);
         this.Name = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.ConsortiaId = _loc2_.readInt(param1);
         this.RankId = _loc2_.readInt(param1);
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.PushByte(param1,(4 - param1.position % 4) % 4);
         _loc2_.writeUtf8Str(param1,this.Name,MsgTypes.MAX_NAME);
         _loc2_.writeInt(param1,this.ConsortiaId);
         _loc2_.writeInt(param1,this.RankId);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 += (4 - param1 % 4) % 4;
         param1 += MsgTypes.MAX_NAME;
         param1 += (4 - param1 % 4) % 4;
         return param1 + 8;
      }
      
      public function release() : void
      {
      }
   }
}

