package net.msg.fleetMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_COMMANDERINFOARRANGE extends MsgHead
   {
      
      public var DataLen:int;
      
      public var Data:Array = new Array(MsgTypes.MAX_COMMANDERNUM);
      
      public function MSG_RESP_COMMANDERINFOARRANGE()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_COMMANDERINFOARRANGE;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.DataLen = _loc2_.readInt(param1);
         var _loc3_:int = 0;
         while(_loc3_ < MsgTypes.MAX_COMMANDERNUM)
         {
            if(param1.length - param1.position >= 4)
            {
               this.Data[_loc3_] = _loc2_.readInt(param1);
            }
            _loc3_++;
         }
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 4;
         return param1 + MsgTypes.MAX_COMMANDERNUM * 4;
      }
      
      public function release() : void
      {
         this.Data.splice(0);
         this.Data = null;
      }
   }
}

