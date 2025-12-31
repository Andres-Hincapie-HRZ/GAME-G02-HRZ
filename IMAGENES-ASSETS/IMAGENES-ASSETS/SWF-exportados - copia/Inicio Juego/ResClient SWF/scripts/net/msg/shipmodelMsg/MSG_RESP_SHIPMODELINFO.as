package net.msg.shipmodelMsg
{
   import flash.external.ExternalInterface;
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_SHIPMODELINFO extends MsgHead
   {
      
      public var DataLen:uint;
      
      public var Data:Array;
      
      public function MSG_RESP_SHIPMODELINFO()
      {
         var _loc2_:MSG_RESP_SHIPMODELINFO_TEMP = null;
         this.Data = new Array(7);
         super();
         var _loc1_:int = 0;
         while(_loc1_ < 7)
         {
            _loc2_ = new MSG_RESP_SHIPMODELINFO_TEMP();
            this.Data[_loc1_] = _loc2_;
            _loc1_++;
         }
         usSize = uint(this.getLength());
         usType = uint(MsgTypes._MSG_RESP_SHIPMODELINFO);
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         ExternalInterface.call("console.log","[#] zzz ");
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = uint(_loc2_.readMsgSize(param1));
         usType = uint(_loc2_.readMsgType(param1));
         this.DataLen = uint(_loc2_.readUnsignShort(param1));
         var _loc3_:int = 0;
         while(_loc3_ < this.DataLen)
         {
            if(param1.length > param1.position)
            {
               this.Data[_loc3_].readBuf(param1);
            }
            _loc3_++;
         }
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         param1.position = 0;
         _loc2_.writeShort(param1,usSize);
         _loc2_.writeShort(param1,usType);
         _loc2_.writeUnsignShort(param1,this.DataLen);
         var _loc3_:int = 0;
         while(_loc3_ < 7)
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
         param1 += 2;
         var _loc2_:int = 0;
         while(_loc2_ < 7)
         {
            param1 = int(this.Data[_loc2_].getLength(param1));
            _loc2_++;
         }
         return param1;
      }
      
      public function release() : void
      {
         var _loc1_:int = 7 - 1;
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

