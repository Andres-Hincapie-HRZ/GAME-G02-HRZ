package net.msg.shipmodelMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_CREATESHIPINFO extends MsgHead
   {
      
      public var MaxCreateShipNum:int;
      
      public var IncShipPercent:int;
      
      public var DataLen:int;
      
      public var Data:Array;
      
      public function MSG_RESP_CREATESHIPINFO()
      {
         var _loc2_:MSG_RESP_CREATESHIPINFO_TEMP = null;
         this.Data = new Array(MsgTypes.MAX_CREATESHIPLIST);
         super();
         var _loc1_:int = 0;
         while(_loc1_ < MsgTypes.MAX_CREATESHIPLIST)
         {
            _loc2_ = new MSG_RESP_CREATESHIPINFO_TEMP();
            this.Data[_loc1_] = _loc2_;
            _loc1_++;
         }
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_CREATESHIPINFO;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.MaxCreateShipNum = _loc2_.readInt(param1);
         this.IncShipPercent = _loc2_.readShort(param1);
         this.DataLen = _loc2_.readShort(param1);
         var _loc3_:int = 0;
         while(_loc3_ < MsgTypes.MAX_CREATESHIPLIST)
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
         _loc2_.writeInt(param1,this.MaxCreateShipNum);
         _loc2_.writeShort(param1,this.IncShipPercent);
         _loc2_.writeShort(param1,this.DataLen);
         var _loc3_:int = 0;
         while(_loc3_ < MsgTypes.MAX_CREATESHIPLIST)
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
         param1 += 8;
         var _loc2_:int = 0;
         while(_loc2_ < MsgTypes.MAX_CREATESHIPLIST)
         {
            param1 = int(this.Data[_loc2_].getLength(param1));
            _loc2_++;
         }
         return param1;
      }
      
      public function release() : void
      {
         var _loc1_:int = MsgTypes.MAX_CREATESHIPLIST - 1;
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

