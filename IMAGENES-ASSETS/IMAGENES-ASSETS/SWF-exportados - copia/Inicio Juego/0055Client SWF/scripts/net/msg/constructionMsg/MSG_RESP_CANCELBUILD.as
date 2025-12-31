package net.msg.constructionMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_CANCELBUILD extends MsgHead
   {
      
      public var IndexId:int;
      
      public var Gas:int;
      
      public var Metal:int;
      
      public var Money:int;
      
      public var Status:int;
      
      public function MSG_RESP_CANCELBUILD()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_CANCELBUILD;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.IndexId = _loc2_.readInt(param1);
         this.Gas = _loc2_.readInt(param1);
         this.Metal = _loc2_.readInt(param1);
         this.Money = _loc2_.readInt(param1);
         this.Status = _loc2_.readChar(param1);
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         param1.position = 0;
         _loc2_.writeShort(param1,usSize);
         _loc2_.writeShort(param1,usType);
         _loc2_.writeInt(param1,this.IndexId);
         _loc2_.writeInt(param1,this.Gas);
         _loc2_.writeInt(param1,this.Metal);
         _loc2_.writeInt(param1,this.Money);
         _loc2_.writeChar(param1,this.Status);
         _loc2_.PushByte(param1,usSize - param1.position);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         return param1 + 17;
      }
      
      public function release() : void
      {
      }
   }
}

