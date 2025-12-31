package net.msg.fleetMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_ARRANGESHIPTEAM extends MsgHead
   {
      
      public var DataLen:int;
      
      public var Type:int;
      
      public var TeamBody:Array;
      
      public function MSG_RESP_ARRANGESHIPTEAM()
      {
         var _loc2_:MSG_SHIPTEAM_NUM = null;
         this.TeamBody = new Array(120);
         super();
         var _loc1_:int = 0;
         while(_loc1_ < 120)
         {
            _loc2_ = new MSG_SHIPTEAM_NUM();
            this.TeamBody[_loc1_] = _loc2_;
            _loc1_++;
         }
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_ARRANGESHIPTEAM;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.DataLen = _loc2_.readShort(param1);
         this.Type = _loc2_.readShort(param1);
         var _loc3_:int = 0;
         while(_loc3_ < 120)
         {
            if(param1.length > param1.position)
            {
               this.TeamBody[_loc3_].readBuf(param1);
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
         while(_loc2_ < 120)
         {
            param1 = int(this.TeamBody[_loc2_].getLength(param1));
            _loc2_++;
         }
         return param1;
      }
      
      public function release() : void
      {
         var _loc1_:int = 120 - 1;
         while(_loc1_ >= 0)
         {
            this.TeamBody[_loc1_].release();
            _loc1_--;
         }
         this.TeamBody.splice(0);
         this.TeamBody = null;
      }
   }
}

