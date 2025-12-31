package net.msg.constructionMsg
{
   import flash.external.ExternalInterface;
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_TIMEQUEUE extends MsgHead
   {
      
      public var DataLen:int;
      
      public var Data:Array;
      
      public function MSG_RESP_TIMEQUEUE()
      {
         var _loc2_:MSG_RESP_TIMEQUEUE_TEMP = null;
         this.Data = new Array(10);
         super();
         var _loc1_:int = 0;
         while(_loc1_ < 10)
         {
            _loc2_ = new MSG_RESP_TIMEQUEUE_TEMP();
            this.Data[_loc1_] = _loc2_;
            _loc1_++;
         }
         usSize = uint(this.getLength());
         usType = uint(MsgTypes._MSG_RESP_TIMEQUEUE);
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = uint(_loc2_.readMsgSize(param1));
         usType = uint(_loc2_.readMsgType(param1));
         this.DataLen = int(_loc2_.readInt(param1));
         ExternalInterface.call("console.log","[#] #TimeQueue ======================= ");
         ExternalInterface.call("console.log","[#] DataLen => " + this.DataLen);
         var _loc3_:int = 0;
         while(_loc3_ < 10)
         {
            if(param1.length > param1.position)
            {
               this.Data[_loc3_].readBuf(param1);
            }
            _loc3_++;
         }
         ExternalInterface.call("console.log","[#] ======================= ");
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         param1.position = 0;
         _loc2_.writeShort(param1,usSize);
         _loc2_.writeShort(param1,usType);
         _loc2_.writeInt(param1,this.DataLen);
         var _loc3_:int = 0;
         while(_loc3_ < 10)
         {
            this.Data[_loc3_].writeBuf(param1);
            _loc3_++;
         }
         _loc2_.PushByte(param1,usSize - param1.position);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 4;
         var _loc2_:int = 0;
         while(_loc2_ < 10)
         {
            param1 = int(this.Data[_loc2_].getLength(param1));
            _loc2_++;
         }
         return param1;
      }
      
      public function release() : void
      {
         var _loc1_:int = 10 - 1;
         while(_loc1_ >= 0)
         {
            this.Data[_loc1_].release();
            _loc1_--;
         }
         this.Data.splice(0);
         this.Data = null;
      }
   }
}

