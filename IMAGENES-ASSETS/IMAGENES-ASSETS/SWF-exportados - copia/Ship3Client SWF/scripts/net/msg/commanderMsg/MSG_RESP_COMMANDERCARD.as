package net.msg.commanderMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_COMMANDERCARD extends MsgHead
   {
      
      public var PropsId:int;
      
      public var UserId:Number;
      
      public var CardLevel:int;
      
      public var Name:String = "";
      
      public var NextCardPropsId1:int;
      
      public var NextCardPropsId2:int;
      
      public var CommanderType:int;
      
      public var Guid:int;
      
      public function MSG_RESP_COMMANDERCARD()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_COMMANDERCARD;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.PropsId = _loc2_.readInt(param1);
         this.UserId = _loc2_.readInt64(param1);
         this.CardLevel = _loc2_.readInt(param1);
         this.Name = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.NextCardPropsId1 = _loc2_.readInt(param1);
         this.NextCardPropsId2 = _loc2_.readInt(param1);
         this.CommanderType = _loc2_.readInt(param1);
         this.Guid = _loc2_.readInt(param1);
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         param1.position = 0;
         _loc2_.writeShort(param1,usSize);
         _loc2_.writeShort(param1,usType);
         _loc2_.writeInt(param1,this.PropsId);
         _loc2_.writeInt64(param1,this.UserId);
         _loc2_.writeInt(param1,this.CardLevel);
         _loc2_.writeUtf8Str(param1,this.Name,MsgTypes.MAX_NAME);
         _loc2_.writeInt(param1,this.NextCardPropsId1);
         _loc2_.writeInt(param1,this.NextCardPropsId2);
         _loc2_.writeInt(param1,this.CommanderType);
         _loc2_.writeInt(param1,this.Guid);
         _loc2_.PushByte(param1,usSize - param1.position);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 16;
         param1 += MsgTypes.MAX_NAME;
         param1 += (4 - param1 % 4) % 4;
         return param1 + 16;
      }
      
      public function release() : void
      {
      }
   }
}

