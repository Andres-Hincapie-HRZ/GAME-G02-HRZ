package net.msg.ship
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_BRUISESHIPINFO extends MsgHead
   {
      
      public var DataLen:int;
      
      public var ShipModelId:int;
      
      public var Num:int;
      
      public var NeedTime:int;
      
      public var DeadShipData:Array;
      
      public function MSG_RESP_BRUISESHIPINFO()
      {
         var _loc2_:MSG_RESP_BRUISESHIPINFO_TEMP = null;
         this.DeadShipData = new Array(MsgTypes.MaxDeadShipData);
         super();
         var _loc1_:int = 0;
         while(_loc1_ < MsgTypes.MaxDeadShipData)
         {
            _loc2_ = new MSG_RESP_BRUISESHIPINFO_TEMP();
            this.DeadShipData[_loc1_] = _loc2_;
            _loc1_++;
         }
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_BRUISESHIPINFO;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.DataLen = _loc2_.readInt(param1);
         this.ShipModelId = _loc2_.readInt(param1);
         this.Num = _loc2_.readInt(param1);
         this.NeedTime = _loc2_.readInt(param1);
         var _loc3_:int = 0;
         while(_loc3_ < MsgTypes.MaxDeadShipData)
         {
            if(param1.length > param1.position)
            {
               this.DeadShipData[_loc3_].readBuf(param1);
            }
            _loc3_++;
         }
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 16;
         var _loc2_:int = 0;
         while(_loc2_ < MsgTypes.MaxDeadShipData)
         {
            param1 = int(this.DeadShipData[_loc2_].getLength(param1));
            _loc2_++;
         }
         return param1;
      }
      
      public function release() : void
      {
         var _loc1_:int = MsgTypes.MaxDeadShipData - 1;
         while(_loc1_ >= 0)
         {
            this.DeadShipData[_loc1_].release();
            _loc1_--;
         }
         this.DeadShipData.splice(0);
         this.DeadShipData = null;
      }
   }
}

