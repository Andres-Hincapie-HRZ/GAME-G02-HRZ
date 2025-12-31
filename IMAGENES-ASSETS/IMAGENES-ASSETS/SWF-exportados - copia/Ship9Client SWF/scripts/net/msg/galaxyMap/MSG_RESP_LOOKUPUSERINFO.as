package net.msg.galaxyMap
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_LOOKUPUSERINFO extends MsgHead
   {
      
      public var Guid:int;
      
      public var UserId:Number;
      
      public var UserName:String = "";
      
      public var PosX:int;
      
      public var PosY:int;
      
      public var GalaxyId:int;
      
      public var Type:int;
      
      public function MSG_RESP_LOOKUPUSERINFO()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_LOOKUPUSERINFO;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.Guid = _loc2_.readInt(param1);
         this.UserId = _loc2_.readInt64(param1);
         this.UserName = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.PosX = _loc2_.readInt(param1);
         this.PosY = _loc2_.readInt(param1);
         this.GalaxyId = _loc2_.readInt(param1);
         this.Type = _loc2_.readInt(param1);
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         param1.position = 0;
         _loc2_.writeShort(param1,usSize);
         _loc2_.writeShort(param1,usType);
         _loc2_.writeInt(param1,this.Guid);
         _loc2_.writeInt64(param1,this.UserId);
         _loc2_.writeUtf8Str(param1,this.UserName,MsgTypes.MAX_NAME);
         _loc2_.writeInt(param1,this.PosX);
         _loc2_.writeInt(param1,this.PosY);
         _loc2_.writeInt(param1,this.GalaxyId);
         _loc2_.writeInt(param1,this.Type);
         _loc2_.PushByte(param1,usSize - param1.position);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 12;
         param1 += MsgTypes.MAX_NAME;
         param1 += (4 - param1 % 4) % 4;
         return param1 + 16;
      }
      
      public function release() : void
      {
      }
   }
}

