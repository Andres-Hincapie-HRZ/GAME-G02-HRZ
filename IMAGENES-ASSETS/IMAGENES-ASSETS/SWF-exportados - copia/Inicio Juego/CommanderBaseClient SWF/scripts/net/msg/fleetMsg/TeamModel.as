package net.msg.fleetMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgTypes;
   
   public class TeamModel
   {
      
      public var model:Array;
      
      public function TeamModel()
      {
         var _loc2_:MSG_SHIPTEAM_NUM = null;
         this.model = new Array(MsgTypes.MAX_SHIPTEAMBODY);
         super();
         var _loc1_:int = 0;
         while(_loc1_ < MsgTypes.MAX_SHIPTEAMBODY)
         {
            _loc2_ = new MSG_SHIPTEAM_NUM();
            this.model[_loc1_] = _loc2_;
            _loc1_++;
         }
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.GetByte(param1,(4 - param1.position % 4) % 4);
         var _loc3_:int = 0;
         while(_loc3_ < MsgTypes.MAX_SHIPTEAMBODY)
         {
            if(param1.length > param1.position)
            {
               this.model[_loc3_].readBuf(param1);
            }
            _loc3_++;
         }
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.PushByte(param1,(4 - param1.position % 4) % 4);
         var _loc3_:int = 0;
         while(_loc3_ < MsgTypes.MAX_SHIPTEAMBODY)
         {
            this.model[_loc3_].writeBuf(param1);
            _loc3_++;
         }
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         var _loc2_:int = 0;
         while(_loc2_ < MsgTypes.MAX_SHIPTEAMBODY)
         {
            param1 = int(this.model[_loc2_].getLength(param1));
            _loc2_++;
         }
         return param1;
      }
      
      public function release() : void
      {
         var _loc1_:int = MsgTypes.MAX_SHIPTEAMBODY - 1;
         while(_loc1_ >= 0)
         {
            this.model[_loc1_].release();
            _loc1_--;
         }
         this.model.splice(0);
         this.model = null;
      }
   }
}

