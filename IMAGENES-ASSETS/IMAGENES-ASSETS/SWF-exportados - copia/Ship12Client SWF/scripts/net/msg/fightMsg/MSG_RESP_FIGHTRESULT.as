package net.msg.fightMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_FIGHTRESULT extends MsgHead
   {
      
      public var Type:int;
      
      public var GalaxyMapId:int;
      
      public var TopAssault_UserId:Number;
      
      public var GalaxyId:int;
      
      public var TopAssault_ModelName:String = "";
      
      public var TopAssault_Commander:String = "";
      
      public var TopAssault_Owner:String = "";
      
      public var TopAssault_Value:int;
      
      public var TopAssault_BodyId:int;
      
      public var Victory:int;
      
      public var AttackShipNumber:int;
      
      public var AttackLossNumber:int;
      
      public var DefendShipNumber:int;
      
      public var DefendLossNumber:int;
      
      public var Kill:Array;
      
      public var Exp:Array;
      
      public var Prize:Array;
      
      public function MSG_RESP_FIGHTRESULT()
      {
         var _loc4_:FightTotalKill = null;
         var _loc5_:FightTotalExp = null;
         var _loc6_:FightRobResource = null;
         this.Kill = new Array(MsgTypes.MAX_FIGHTRESULTKILL);
         this.Exp = new Array(MsgTypes.MAX_FIGHTRESULTEXP);
         this.Prize = new Array(MsgTypes.MAX_FIGHTRESULTPRIZE);
         super();
         var _loc1_:int = 0;
         while(_loc1_ < MsgTypes.MAX_FIGHTRESULTKILL)
         {
            _loc4_ = new FightTotalKill();
            this.Kill[_loc1_] = _loc4_;
            _loc1_++;
         }
         var _loc2_:int = 0;
         while(_loc2_ < MsgTypes.MAX_FIGHTRESULTEXP)
         {
            _loc5_ = new FightTotalExp();
            this.Exp[_loc2_] = _loc5_;
            _loc2_++;
         }
         var _loc3_:int = 0;
         while(_loc3_ < MsgTypes.MAX_FIGHTRESULTPRIZE)
         {
            _loc6_ = new FightRobResource();
            this.Prize[_loc3_] = _loc6_;
            _loc3_++;
         }
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_FIGHTRESULT;
         this.AttackShipNumber = 0;
         this.AttackLossNumber = 0;
         this.DefendShipNumber = 0;
         this.DefendLossNumber = 0;
         this.Type = 0;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.Type = _loc2_.readShort(param1);
         this.GalaxyMapId = _loc2_.readShort(param1);
         this.TopAssault_UserId = _loc2_.readInt64(param1);
         this.GalaxyId = _loc2_.readInt(param1);
         this.TopAssault_ModelName = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.TopAssault_Commander = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.TopAssault_Owner = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.TopAssault_Value = _loc2_.readInt(param1);
         this.TopAssault_BodyId = _loc2_.readShort(param1);
         this.Victory = _loc2_.readShort(param1);
         this.AttackShipNumber = _loc2_.readInt(param1);
         this.AttackLossNumber = _loc2_.readInt(param1);
         this.DefendShipNumber = _loc2_.readInt(param1);
         this.DefendLossNumber = _loc2_.readInt(param1);
         var _loc3_:int = 0;
         while(_loc3_ < MsgTypes.MAX_FIGHTRESULTKILL)
         {
            if(param1.length > param1.position)
            {
               this.Kill[_loc3_].readBuf(param1);
            }
            _loc3_++;
         }
         var _loc4_:int = 0;
         while(_loc4_ < MsgTypes.MAX_FIGHTRESULTEXP)
         {
            if(param1.length > param1.position)
            {
               this.Exp[_loc4_].readBuf(param1);
            }
            _loc4_++;
         }
         var _loc5_:int = 0;
         while(_loc5_ < MsgTypes.MAX_FIGHTRESULTPRIZE)
         {
            if(param1.length > param1.position)
            {
               this.Prize[_loc5_].readBuf(param1);
            }
            _loc5_++;
         }
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 16;
         param1 += MsgTypes.MAX_NAME;
         param1 += MsgTypes.MAX_NAME;
         param1 += MsgTypes.MAX_NAME;
         param1 += (4 - param1 % 4) % 4;
         param1 += 8;
         param1 += (4 - param1 % 4) % 4;
         param1 += 16;
         var _loc2_:int = 0;
         while(_loc2_ < MsgTypes.MAX_FIGHTRESULTKILL)
         {
            param1 = int(this.Kill[_loc2_].getLength(param1));
            _loc2_++;
         }
         var _loc3_:int = 0;
         while(_loc3_ < MsgTypes.MAX_FIGHTRESULTEXP)
         {
            param1 = int(this.Exp[_loc3_].getLength(param1));
            _loc3_++;
         }
         var _loc4_:int = 0;
         while(_loc4_ < MsgTypes.MAX_FIGHTRESULTPRIZE)
         {
            param1 = int(this.Prize[_loc4_].getLength(param1));
            _loc4_++;
         }
         return param1;
      }
      
      public function release() : void
      {
         var _loc1_:int = MsgTypes.MAX_FIGHTRESULTKILL - 1;
         while(_loc1_ >= 0)
         {
            this.Kill[_loc1_].release();
            _loc1_--;
         }
         this.Kill.splice(0);
         this.Kill = null;
         var _loc2_:int = MsgTypes.MAX_FIGHTRESULTEXP - 1;
         while(_loc2_ >= 0)
         {
            this.Exp[_loc2_].release();
            _loc2_--;
         }
         this.Exp.splice(0);
         this.Exp = null;
         var _loc3_:int = MsgTypes.MAX_FIGHTRESULTPRIZE - 1;
         while(_loc3_ >= 0)
         {
            this.Prize[_loc3_].release();
            _loc3_--;
         }
         this.Prize.splice(0);
         this.Prize = null;
      }
   }
}

