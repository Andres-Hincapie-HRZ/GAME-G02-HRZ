package net.msg.fightMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   
   public class MSG_RESP_FIGHTINIT_BUILD_TEMP
   {
      
      public var MaxEndure:uint;
      
      public var Endure:uint;
      
      public var IndexId:uint;
      
      public var HeadId:int;
      
      public var Reserve:int;
      
      public function MSG_RESP_FIGHTINIT_BUILD_TEMP()
      {
         super();
         this.IndexId = 0;
         this.MaxEndure = 0;
         this.Endure = 0;
         this.HeadId = 0;
         this.Reserve = 0;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.GetByte(param1,(4 - param1.position % 4) % 4);
         this.MaxEndure = _loc2_.readUnsignInt(param1);
         this.Endure = _loc2_.readUnsignInt(param1);
         this.IndexId = _loc2_.readUnsignShort(param1);
         this.HeadId = _loc2_.readUnsignChar(param1);
         this.Reserve = _loc2_.readUnsignChar(param1);
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.PushByte(param1,(4 - param1.position % 4) % 4);
         _loc2_.writeUnsignInt(param1,this.MaxEndure);
         _loc2_.writeUnsignInt(param1,this.Endure);
         _loc2_.writeUnsignShort(param1,this.IndexId);
         _loc2_.writeUnsignChar(param1,this.HeadId);
         _loc2_.writeUnsignChar(param1,this.Reserve);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 += (4 - param1 % 4) % 4;
         return param1 + 12;
      }
      
      public function release() : void
      {
      }
   }
}

