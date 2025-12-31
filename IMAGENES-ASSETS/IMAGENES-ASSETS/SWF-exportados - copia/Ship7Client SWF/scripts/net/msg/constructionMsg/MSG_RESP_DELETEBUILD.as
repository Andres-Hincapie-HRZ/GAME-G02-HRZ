package net.msg.constructionMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_DELETEBUILD extends MsgHead
   {
      
      public var IndexId:int;
      
      public function MSG_RESP_DELETEBUILD()
      {
         super();
         usSize = 8;
         usType = MsgTypes._MSG_RESP_DELETEBUILD;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.IndexId = _loc2_.readInt(param1);
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : int
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         param1.position = 0;
         var _loc3_:int = 0;
         _loc2_.writeShort(param1,usSize);
         _loc2_.writeShort(param1,usType);
         _loc2_.writeInt(param1,this.IndexId);
         param1.position = 0;
         _loc2_.writeShort(param1,_loc3_ + 8);
         _loc2_ = null;
         return _loc3_ + 8;
      }
      
      public function getLength() : int
      {
         return 8;
      }
      
      public function release() : void
      {
      }
   }
}

