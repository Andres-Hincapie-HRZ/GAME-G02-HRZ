package net.msg.commanderMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   
   public class MSG_RESP_REFRESHCOMMANDERBASEINFO_TEMP
   {
      
      public var CommanderId:int;
      
      public var Exp:int;
      
      public var Aim:int;
      
      public var Blench:int;
      
      public var Priority:int;
      
      public var Electron:int;
      
      public var Reserve:int;
      
      public var Level:int;
      
      public var Reserve2:int;
      
      public function MSG_RESP_REFRESHCOMMANDERBASEINFO_TEMP()
      {
         super();
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.GetByte(param1,(4 - param1.position % 4) % 4);
         this.CommanderId = _loc2_.readInt(param1);
         this.Exp = _loc2_.readInt(param1);
         this.Aim = _loc2_.readShort(param1);
         this.Blench = _loc2_.readShort(param1);
         this.Priority = _loc2_.readShort(param1);
         this.Electron = _loc2_.readShort(param1);
         this.Reserve = _loc2_.readShort(param1);
         this.Level = _loc2_.readChar(param1);
         this.Reserve2 = _loc2_.readChar(param1);
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.PushByte(param1,(4 - param1.position % 4) % 4);
         _loc2_.writeInt(param1,this.CommanderId);
         _loc2_.writeInt(param1,this.Exp);
         _loc2_.writeShort(param1,this.Aim);
         _loc2_.writeShort(param1,this.Blench);
         _loc2_.writeShort(param1,this.Priority);
         _loc2_.writeShort(param1,this.Electron);
         _loc2_.writeShort(param1,this.Reserve);
         _loc2_.writeChar(param1,this.Level);
         _loc2_.writeChar(param1,this.Reserve2);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 += (4 - param1 % 4) % 4;
         return param1 + 20;
      }
      
      public function release() : void
      {
      }
   }
}

