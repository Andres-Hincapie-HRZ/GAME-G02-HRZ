package net.msg.commanderMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_CLEARCOMMANDERPERCENT extends MsgHead
   {
      
      public var CommanderId:int;
      
      public var Level:int;
      
      public var Exp:int;
      
      public var Aim:int;
      
      public var Blench:int;
      
      public var Priority:int;
      
      public var Electron:int;
      
      public var LockFlag:int;
      
      public var AimPer:int;
      
      public var BlenchPer:int;
      
      public var PriorityPer:int;
      
      public var ElectronPer:int;
      
      public function MSG_RESP_CLEARCOMMANDERPERCENT()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_CLEARCOMMANDERPERCENT;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.CommanderId = _loc2_.readInt(param1);
         this.Level = _loc2_.readInt(param1);
         this.Exp = _loc2_.readInt(param1);
         this.Aim = _loc2_.readShort(param1);
         this.Blench = _loc2_.readShort(param1);
         this.Priority = _loc2_.readShort(param1);
         this.Electron = _loc2_.readShort(param1);
         this.LockFlag = _loc2_.readInt(param1);
         this.AimPer = _loc2_.readChar(param1);
         this.BlenchPer = _loc2_.readChar(param1);
         this.PriorityPer = _loc2_.readChar(param1);
         this.ElectronPer = _loc2_.readChar(param1);
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         param1.position = 0;
         _loc2_.writeShort(param1,usSize);
         _loc2_.writeShort(param1,usType);
         _loc2_.writeInt(param1,this.CommanderId);
         _loc2_.writeInt(param1,this.Level);
         _loc2_.writeInt(param1,this.Exp);
         _loc2_.writeShort(param1,this.Aim);
         _loc2_.writeShort(param1,this.Blench);
         _loc2_.writeShort(param1,this.Priority);
         _loc2_.writeShort(param1,this.Electron);
         _loc2_.writeInt(param1,this.LockFlag);
         _loc2_.writeChar(param1,this.AimPer);
         _loc2_.writeChar(param1,this.BlenchPer);
         _loc2_.writeChar(param1,this.PriorityPer);
         _loc2_.writeChar(param1,this.ElectronPer);
         _loc2_.PushByte(param1,usSize - param1.position);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         return param1 + 28;
      }
      
      public function release() : void
      {
      }
   }
}

