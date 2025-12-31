package net.msg.fightMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_WARFIELD_PLAYERLIST extends MsgHead
   {
      
      public var RoomID:int;
      
      public var Reserve:int;
      
      public var DataLen:int;
      
      public var AttackerNum:int;
      
      public var Data:Array;
      
      public function MSG_RESP_WARFIELD_PLAYERLIST()
      {
         var _loc2_:MSG_RESP_WARFIELD_PLAYERLIST_TEMP = null;
         this.Data = new Array(50);
         super();
         var _loc1_:int = 0;
         while(_loc1_ < 50)
         {
            _loc2_ = new MSG_RESP_WARFIELD_PLAYERLIST_TEMP();
            this.Data[_loc1_] = _loc2_;
            _loc1_++;
         }
         this.RoomID = 0;
         this.Reserve = 0;
         this.DataLen = 0;
         this.AttackerNum = 0;
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_WARFIELD_PLAYERLIST;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.RoomID = _loc2_.readUnsignChar(param1);
         this.Reserve = _loc2_.readUnsignChar(param1);
         this.DataLen = _loc2_.readUnsignChar(param1);
         this.AttackerNum = _loc2_.readUnsignChar(param1);
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
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 4;
         var _loc2_:int = 0;
         while(_loc2_ < 50)
         {
            param1 = int(this.Data[_loc2_].getLength(param1));
            _loc2_++;
         }
         return param1;
      }
      
      public function release() : void
      {
         var _loc1_:int = 50 - 1;
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

