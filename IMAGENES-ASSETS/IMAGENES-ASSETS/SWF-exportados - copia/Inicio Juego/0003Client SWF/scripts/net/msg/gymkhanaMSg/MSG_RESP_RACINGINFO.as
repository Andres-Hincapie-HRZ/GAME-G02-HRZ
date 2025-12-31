package net.msg.gymkhanaMSg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_RACINGINFO extends MsgHead
   {
      
      public var RankId:uint;
      
      public var RewardValue:int;
      
      public var RacingNum:int;
      
      public var RacingRewardFlag:int;
      
      public var EnemyLen:int;
      
      public var ReportLen:int;
      
      public var UserId:Number;
      
      public var EnemyData:Array;
      
      public var ReportData:Array;
      
      public function MSG_RESP_RACINGINFO()
      {
         var _loc3_:RacingEnemyInfo = null;
         var _loc4_:RacingReportInfo = null;
         this.EnemyData = new Array(MsgTypes.MAX_RACINGENEMYNUM);
         this.ReportData = new Array(MsgTypes.MAX_RACINGREPORTNUM);
         super();
         var _loc1_:int = 0;
         while(_loc1_ < MsgTypes.MAX_RACINGENEMYNUM)
         {
            _loc3_ = new RacingEnemyInfo();
            this.EnemyData[_loc1_] = _loc3_;
            _loc1_++;
         }
         var _loc2_:int = 0;
         while(_loc2_ < MsgTypes.MAX_RACINGREPORTNUM)
         {
            _loc4_ = new RacingReportInfo();
            this.ReportData[_loc2_] = _loc4_;
            _loc2_++;
         }
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_RACINGINFO;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.RankId = _loc2_.readUnsignInt(param1);
         this.RewardValue = _loc2_.readInt(param1);
         this.RacingNum = _loc2_.readUnsignChar(param1);
         this.RacingRewardFlag = _loc2_.readChar(param1);
         this.EnemyLen = _loc2_.readUnsignChar(param1);
         this.ReportLen = _loc2_.readUnsignChar(param1);
         this.UserId = _loc2_.readInt64(param1);
         var _loc3_:int = 0;
         while(_loc3_ < MsgTypes.MAX_RACINGENEMYNUM)
         {
            if(param1.length > param1.position)
            {
               this.EnemyData[_loc3_].readBuf(param1);
            }
            _loc3_++;
         }
         var _loc4_:int = 0;
         while(_loc4_ < MsgTypes.MAX_RACINGREPORTNUM)
         {
            if(param1.length > param1.position)
            {
               this.ReportData[_loc4_].readBuf(param1);
            }
            _loc4_++;
         }
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         param1.position = 0;
         _loc2_.writeShort(param1,usSize);
         _loc2_.writeShort(param1,usType);
         _loc2_.writeUnsignInt(param1,this.RankId);
         _loc2_.writeInt(param1,this.RewardValue);
         _loc2_.writeUnsignChar(param1,this.RacingNum);
         _loc2_.writeChar(param1,this.RacingRewardFlag);
         _loc2_.writeUnsignChar(param1,this.EnemyLen);
         _loc2_.writeUnsignChar(param1,this.ReportLen);
         _loc2_.writeInt64(param1,this.UserId);
         var _loc3_:int = 0;
         while(_loc3_ < MsgTypes.MAX_RACINGENEMYNUM)
         {
            this.EnemyData[_loc3_].writeBuf(param1);
            _loc3_++;
         }
         var _loc4_:int = 0;
         while(_loc4_ < MsgTypes.MAX_RACINGREPORTNUM)
         {
            this.ReportData[_loc4_].writeBuf(param1);
            _loc4_++;
         }
         _loc2_.PushByte(param1,usSize - param1.position);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 20;
         var _loc2_:int = 0;
         while(_loc2_ < MsgTypes.MAX_RACINGENEMYNUM)
         {
            param1 = int(this.EnemyData[_loc2_].getLength(param1));
            _loc2_++;
         }
         var _loc3_:int = 0;
         while(_loc3_ < MsgTypes.MAX_RACINGREPORTNUM)
         {
            param1 = int(this.ReportData[_loc3_].getLength(param1));
            _loc3_++;
         }
         return param1;
      }
      
      public function release() : void
      {
         var _loc1_:int = MsgTypes.MAX_RACINGENEMYNUM - 1;
         while(_loc1_ >= 0)
         {
            this.EnemyData[_loc1_].release();
            _loc1_--;
         }
         this.EnemyData.splice(0);
         this.EnemyData = null;
         var _loc2_:int = MsgTypes.MAX_RACINGREPORTNUM - 1;
         while(_loc2_ >= 0)
         {
            this.ReportData[_loc2_].release();
            _loc2_--;
         }
         this.ReportData.splice(0);
         this.ReportData = null;
      }
   }
}

