package net.msg.fightMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_ARENA_PAGE extends MsgHead
   {
      
      public var PageId:uint;
      
      public var PageNum:uint;
      
      public var ArenaFlag:int;
      
      public var DataLen:int;
      
      public var Data:Array;
      
      public function MSG_RESP_ARENA_PAGE()
      {
         var _loc2_:MSG_RESP_ARENA_PAGE_TEMP = null;
         this.Data = new Array(10);
         super();
         var _loc1_:int = 0;
         while(_loc1_ < 10)
         {
            _loc2_ = new MSG_RESP_ARENA_PAGE_TEMP();
            this.Data[_loc1_] = _loc2_;
            _loc1_++;
         }
         usType = MsgTypes._MSG_RESP_ARENA_PAGE;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.PageId = _loc2_.readUnsignShort(param1);
         this.PageNum = _loc2_.readUnsignShort(param1);
         this.ArenaFlag = _loc2_.readUnsignChar(param1);
         this.DataLen = _loc2_.readUnsignChar(param1);
         var _loc3_:int = 0;
         while(_loc3_ < 10 && _loc3_ < this.DataLen)
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
         param1 += 10;
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

