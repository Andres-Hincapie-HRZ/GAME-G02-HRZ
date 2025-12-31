package net.msg.miniMap
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_MAPBLOCKUSERINFO extends MsgHead
   {
      
      public var GalaxyId:int;
      
      public var UserId:Number;
      
      public var Name:String = "";
      
      public var ConsortiaName:String = "";
      
      public function MSG_RESP_MAPBLOCKUSERINFO()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_MAPBLOCKUSERINFO;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.GalaxyId = _loc2_.readInt(param1);
         this.UserId = _loc2_.readInt64(param1);
         this.Name = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.ConsortiaName = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         param1.position = 0;
         _loc2_.writeShort(param1,usSize);
         _loc2_.writeShort(param1,usType);
         _loc2_.writeInt(param1,this.GalaxyId);
         _loc2_.writeInt64(param1,this.UserId);
         _loc2_.writeUtf8Str(param1,this.Name,MsgTypes.MAX_NAME);
         _loc2_.writeUtf8Str(param1,this.ConsortiaName,MsgTypes.MAX_NAME);
         _loc2_.PushByte(param1,usSize - param1.position);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 12;
         param1 += MsgTypes.MAX_NAME;
         return param1 + MsgTypes.MAX_NAME;
      }
      
      public function release() : void
      {
      }
   }
}

