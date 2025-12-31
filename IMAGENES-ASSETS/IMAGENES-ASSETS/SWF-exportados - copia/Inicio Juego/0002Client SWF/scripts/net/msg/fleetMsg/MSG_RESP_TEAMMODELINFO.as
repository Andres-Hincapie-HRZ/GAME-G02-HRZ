package net.msg.fleetMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_TEAMMODELINFO extends MsgHead
   {
      
      public var DataLen:int;
      
      public var teamModel:Array;
      
      public function MSG_RESP_TEAMMODELINFO()
      {
         var _loc2_:TeamModel = null;
         this.teamModel = new Array(MsgTypes.MAX_TEAMMODEL);
         super();
         var _loc1_:int = 0;
         while(_loc1_ < MsgTypes.MAX_TEAMMODEL)
         {
            _loc2_ = new TeamModel();
            this.teamModel[_loc1_] = _loc2_;
            _loc1_++;
         }
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_TEAMMODELINFO;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.DataLen = _loc2_.readInt(param1);
         var _loc3_:int = 0;
         while(_loc3_ < MsgTypes.MAX_TEAMMODEL)
         {
            if(param1.length > param1.position)
            {
               this.teamModel[_loc3_].readBuf(param1);
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
         while(_loc2_ < MsgTypes.MAX_TEAMMODEL)
         {
            param1 = int(this.teamModel[_loc2_].getLength(param1));
            _loc2_++;
         }
         return param1;
      }
      
      public function release() : void
      {
         var _loc1_:int = MsgTypes.MAX_TEAMMODEL - 1;
         while(_loc1_ >= 0)
         {
            this.teamModel[_loc1_].release();
            _loc1_--;
         }
         this.teamModel.splice(0);
         this.teamModel = null;
      }
   }
}

