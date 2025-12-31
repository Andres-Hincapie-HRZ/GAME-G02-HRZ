package net.msg.chatMsg
{
   import flash.external.ExternalInterface;
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_CHAT_MESSAGE extends MsgHead
   {
      
      public var SeqId:int;
      
      public var SrcUserId:Number;
      
      public var ObjUserId:Number;
      
      public var Guid:int;
      
      public var ObjGuid:int;
      
      public var Type:int;
      
      public var SpecialType:int;
      
      public var PropsId:int;
      
      public var name:String;
      
      public var ToName:String;
      
      public var buffer:String;
      
      public function MSG_CHAT_MESSAGE()
      {
         super();
         usSize = uint(this.getLength());
         usType = uint(MsgTypes._MSG_CHAT_MESSAGE);
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = uint(_loc2_.readMsgSize(param1));
         usType = uint(_loc2_.readMsgType(param1));
         this.SeqId = _loc2_.readInt(param1);
         this.SrcUserId = _loc2_.readInt64(param1);
         this.ObjUserId = _loc2_.readInt64(param1);
         this.Guid = _loc2_.readInt(param1);
         this.ObjGuid = _loc2_.readInt(param1);
         this.Type = _loc2_.readShort(param1);
         this.SpecialType = _loc2_.readShort(param1);
         this.PropsId = _loc2_.readInt(param1);
         this.name = _loc2_.readWideChar(param1,MsgTypes.MAX_NAME);
         this.ToName = _loc2_.readWideChar(param1,MsgTypes.MAX_NAME);
         this.buffer = _loc2_.readWideChar(param1,MsgTypes.CHAT_MESSAGE);
         _loc2_ = null;
         ExternalInterface.call("console.log","[CHAT] " + this.Guid + " :: " + this.name + " :: " + this.buffer);
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         param1.position = 0;
         _loc2_.writeShort(param1,usSize);
         _loc2_.writeShort(param1,usType);
         _loc2_.writeInt(param1,this.SeqId);
         _loc2_.writeInt64(param1,this.SrcUserId);
         _loc2_.writeInt64(param1,this.ObjUserId);
         _loc2_.writeInt(param1,this.Guid);
         _loc2_.writeInt(param1,this.ObjGuid);
         _loc2_.writeShort(param1,this.Type);
         _loc2_.writeShort(param1,this.SpecialType);
         _loc2_.writeInt(param1,this.PropsId);
         _loc2_.writeWideChar(param1,this.name,MsgTypes.MAX_NAME);
         _loc2_.writeWideChar(param1,this.ToName,MsgTypes.MAX_NAME);
         _loc2_.writeWideChar(param1,this.buffer,MsgTypes.CHAT_MESSAGE);
         _loc2_.PushByte(param1,usSize - param1.position);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         return param1 + (40 + 128 + 256 + 2 + 4);
      }
      
      public function release() : void
      {
      }
   }
}

