package net.msg.RaidProps
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_CAPTURE_ARK_LIST extends MsgHead
   {
      
      public var SearchFleets:int;
      
      public var CaptureFleets:int;
      
      public var Reserve:int;
      
      public var DataLen:int;
      
      public var Room:Array;
      
      public function MSG_RESP_CAPTURE_ARK_LIST()
      {
         var _loc2_:MSG_RESP_CAPTURE_ARK_TMP = null;
         this.Room = new Array(100);
         super();
         var _loc1_:int = 0;
         while(_loc1_ < 100)
         {
            _loc2_ = new MSG_RESP_CAPTURE_ARK_TMP();
            this.Room[_loc1_] = _loc2_;
            _loc1_++;
         }
         this.SearchFleets = 0;
         this.CaptureFleets = 0;
         this.Reserve = 0;
         this.DataLen = 0;
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_CAPTURE_ARK_LIST;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.SearchFleets = _loc2_.readUnsignChar(param1);
         this.CaptureFleets = _loc2_.readUnsignChar(param1);
         this.Reserve = _loc2_.readUnsignChar(param1);
         this.DataLen = _loc2_.readUnsignChar(param1);
         var _loc3_:int = 0;
         while(_loc3_ < 100)
         {
            if(param1.length > param1.position)
            {
               this.Room[_loc3_].readBuf(param1);
            }
            _loc3_++;
         }
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 4;
         var _loc2_:int = 0;
         while(_loc2_ < 100)
         {
            param1 = int(this.Room[_loc2_].getLength(param1));
            _loc2_++;
         }
         return param1;
      }
      
      public function release() : void
      {
         var _loc1_:int = 100 - 1;
         while(_loc1_ >= 0)
         {
            this.Room[_loc1_].release();
            _loc1_--;
         }
         this.Room.splice(0);
         this.Room = null;
      }
   }
}

