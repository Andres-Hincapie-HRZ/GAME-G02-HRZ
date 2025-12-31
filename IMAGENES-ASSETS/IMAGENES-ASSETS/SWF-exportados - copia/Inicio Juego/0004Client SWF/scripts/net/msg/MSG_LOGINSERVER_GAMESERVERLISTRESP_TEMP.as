package net.msg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   
   public class MSG_LOGINSERVER_GAMESERVERLISTRESP_TEMP
   {
      
      public var UserCount:int;
      
      public var OnlineCount:int;
      
      public var ServerId:int;
      
      public var Reserver:int;
      
      public function MSG_LOGINSERVER_GAMESERVERLISTRESP_TEMP()
      {
         super();
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.GetByte(param1,(4 - param1.position % 4) % 4);
         this.UserCount = _loc2_.readInt(param1);
         this.OnlineCount = _loc2_.readShort(param1);
         this.ServerId = _loc2_.readUnsignChar(param1);
         this.Reserver = _loc2_.readChar(param1);
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.PushByte(param1,(4 - param1.position % 4) % 4);
         _loc2_.writeInt(param1,this.UserCount);
         _loc2_.writeShort(param1,this.OnlineCount);
         _loc2_.writeUnsignChar(param1,this.ServerId);
         _loc2_.writeChar(param1,this.Reserver);
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

