package net.msg.commanderMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_COMMANDERCHANGECARD extends MsgHead
   {
      
      public var CommanderId:int;
      
      public var PropsId:int;
      
      public var LockFlag:int;
      
      public var UsePropsId:int;
      
      public var UseLockFlag:int;
      
      public function MSG_RESP_COMMANDERCHANGECARD()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_COMMANDERCHANGECARD;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.CommanderId = _loc2_.readInt(param1);
         this.PropsId = _loc2_.readInt(param1);
         this.LockFlag = _loc2_.readInt(param1);
         this.UsePropsId = _loc2_.readInt(param1);
         this.UseLockFlag = _loc2_.readInt(param1);
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         param1.position = 0;
         _loc2_.writeShort(param1,usSize);
         _loc2_.writeShort(param1,usType);
         _loc2_.writeInt(param1,this.CommanderId);
         _loc2_.writeInt(param1,this.PropsId);
         _loc2_.writeInt(param1,this.LockFlag);
         _loc2_.writeInt(param1,this.UsePropsId);
         _loc2_.writeInt(param1,this.UseLockFlag);
         _loc2_.PushByte(param1,usSize - param1.position);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         return param1 + 20;
      }
      
      public function release() : void
      {
      }
   }
}

