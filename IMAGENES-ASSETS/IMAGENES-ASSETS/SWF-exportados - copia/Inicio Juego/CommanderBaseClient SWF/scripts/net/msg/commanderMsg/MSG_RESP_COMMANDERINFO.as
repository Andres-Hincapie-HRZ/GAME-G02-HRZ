package net.msg.commanderMsg
{
   import flash.external.ExternalInterface;
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_COMMANDERINFO extends MsgHead
   {
      
      public var CommanderId:int;
      
      public var ShipTeamId:int;
      
      public var RestTime:int;
      
      public var Exp:int;
      
      public var Aim:int;
      
      public var Blench:int;
      
      public var Priority:int;
      
      public var Electron:int;
      
      public var Skill:int;
      
      public var CardLevel:int;
      
      public var Level:int;
      
      public var Type:int;
      
      public var State:int;
      
      public var ShowType:int;
      
      public var CommanderZJ:String = "";
      
      public var TeamBody:Array;
      
      public var Target:int;
      
      public var TargetInterval:int;
      
      public var Reserve:int;
      
      public var AllStatusLen:int;
      
      public var AllStatus:Array;
      
      public var Stone:Array;
      
      public var StoneHole:int;
      
      public var AimPer:int;
      
      public var BlenchPer:int;
      
      public var PriorityPer:int;
      
      public var ElectronPer:int;
      
      public var CmosExp:Array;
      
      public var Cmos:Array;
      
      public function MSG_RESP_COMMANDERINFO()
      {
         var _loc3_:MSG_SHIPTEAM_NUM = null;
         var _loc4_:MSG_RESP_COMMANDERINFO_TEMP = null;
         this.TeamBody = new Array(MsgTypes.MAX_SHIPTEAMBODY);
         this.AllStatus = new Array(MsgTypes.MAX_COMMANDERNUM);
         this.Stone = new Array(MsgTypes.MAX_COMMANDERSTORE);
         this.CmosExp = new Array(MsgTypes.MAX_COMMANDERCMOS);
         this.Cmos = new Array(MsgTypes.MAX_COMMANDERCMOS);
         super();
         var _loc1_:int = 0;
         while(_loc1_ < MsgTypes.MAX_SHIPTEAMBODY)
         {
            _loc3_ = new MSG_SHIPTEAM_NUM();
            this.TeamBody[_loc1_] = _loc3_;
            _loc1_++;
         }
         var _loc2_:int = 0;
         while(_loc2_ < MsgTypes.MAX_COMMANDERNUM)
         {
            _loc4_ = new MSG_RESP_COMMANDERINFO_TEMP();
            this.AllStatus[_loc2_] = _loc4_;
            _loc2_++;
         }
         usSize = uint(uint(uint(uint(uint(uint(this.getLength()))))));
         usType = uint(uint(uint(uint(uint(uint(MsgTypes._MSG_RESP_COMMANDERINFO))))));
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         ExternalInterface.call("console.log","[#] READ ");
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = uint(uint(uint(uint(uint(uint(_loc2_.readMsgSize(param1)))))));
         usType = uint(uint(uint(uint(uint(uint(_loc2_.readMsgType(param1)))))));
         this.CommanderId = int(int(int(int(int(int(_loc2_.readInt(param1)))))));
         ExternalInterface.call("console.log","[#] READ 1 " + this.CommanderId);
         this.ShipTeamId = int(int(int(int(int(int(_loc2_.readInt(param1)))))));
         this.RestTime = int(int(int(int(int(int(_loc2_.readInt(param1)))))));
         this.Exp = int(int(int(int(int(int(_loc2_.readInt(param1)))))));
         this.Aim = int(int(int(int(int(int(_loc2_.readShort(param1)))))));
         this.Blench = int(int(int(int(int(int(_loc2_.readShort(param1)))))));
         this.Priority = int(int(int(int(int(int(_loc2_.readShort(param1)))))));
         this.Electron = int(int(int(int(int(int(_loc2_.readShort(param1)))))));
         ExternalInterface.call("console.log","[#] READ 2");
         this.Skill = int(int(int(int(int(int(_loc2_.readShort(param1)))))));
         this.CardLevel = int(int(int(int(int(int(_loc2_.readShort(param1)))))));
         this.Level = int(int(int(int(int(int(_loc2_.readChar(param1)))))));
         this.Type = int(int(int(int(int(int(_loc2_.readChar(param1)))))));
         ExternalInterface.call("console.log","[#] READ 3");
         this.State = int(int(int(int(int(int(_loc2_.readChar(param1)))))));
         this.ShowType = int(int(int(int(int(int(_loc2_.readChar(param1)))))));
         ExternalInterface.call("console.log","[#] Skill " + this.Skill);
         ExternalInterface.call("console.log","[#] Type " + this.Type);
         ExternalInterface.call("console.log","[#] Level " + this.Level);
         ExternalInterface.call("console.log","[#] State " + this.State);
         ExternalInterface.call("console.log","[#] CardLevel " + this.CardLevel);
         ExternalInterface.call("console.log","[#] READ 4 " + this.ShowType);
         this.CommanderZJ = _loc2_.readUtf8Str(param1,MsgTypes.COMMANDERZJCOUNT);
         var _loc3_:int = 0;
         ExternalInterface.call("console.log","[#] WTF " + this.CommanderZJ);
         while(_loc3_ < MsgTypes.MAX_SHIPTEAMBODY)
         {
            if(param1.length > param1.position)
            {
               this.TeamBody[_loc3_].readBuf(param1);
            }
            _loc3_++;
         }
         this.Target = int(int(int(int(int(int(_loc2_.readChar(param1)))))));
         this.TargetInterval = int(int(int(int(int(int(_loc2_.readChar(param1)))))));
         this.Reserve = int(int(int(int(int(int(_loc2_.readChar(param1)))))));
         this.AllStatusLen = int(int(int(int(int(int(_loc2_.readChar(param1)))))));
         var _loc4_:int = 0;
         while(_loc4_ < MsgTypes.MAX_COMMANDERNUM)
         {
            if(param1.length > param1.position)
            {
               this.AllStatus[_loc4_].readBuf(param1);
            }
            _loc4_++;
         }
         var _loc5_:int = 0;
         ExternalInterface.call("console.log","[#] WTF 2 " + this.AllStatusLen);
         while(_loc5_ < MsgTypes.MAX_COMMANDERSTORE)
         {
            if(param1.length - param1.position >= 2)
            {
               this.Stone[_loc5_] = _loc2_.readShort(param1);
            }
            _loc5_++;
         }
         this.StoneHole = int(int(int(int(int(int(_loc2_.readInt(param1)))))));
         this.AimPer = int(int(int(int(int(int(_loc2_.readChar(param1)))))));
         this.BlenchPer = int(int(int(int(int(int(_loc2_.readChar(param1)))))));
         this.PriorityPer = int(int(int(int(int(int(_loc2_.readChar(param1)))))));
         this.ElectronPer = int(int(int(int(int(int(_loc2_.readChar(param1)))))));
         var _loc6_:int = 0;
         ExternalInterface.call("console.log","[#] Electron Per = " + this.ElectronPer + ", Electron = " + this.Electron);
         while(_loc6_ < MsgTypes.MAX_COMMANDERCMOS)
         {
            if(param1.length - param1.position >= 4)
            {
               this.CmosExp[_loc6_] = _loc2_.readInt(param1);
            }
            _loc6_++;
         }
         var _loc7_:int = 0;
         ExternalInterface.call("console.log","[#] WTF 4 " + this.StoneHole);
         while(_loc7_ < MsgTypes.MAX_COMMANDERCMOS)
         {
            if(param1.length - param1.position >= 2)
            {
               this.Cmos[_loc7_] = _loc2_.readShort(param1);
            }
            _loc7_++;
         }
         _loc2_ = null;
         ExternalInterface.call("console.log","[#] WTF OUT " + this.Stone);
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 32;
         param1 += MsgTypes.COMMANDERZJCOUNT;
         var _loc2_:int = 0;
         while(_loc2_ < MsgTypes.MAX_SHIPTEAMBODY)
         {
            param1 = int(this.TeamBody[_loc2_].getLength(param1));
            _loc2_++;
         }
         param1 = (param1 + (4 - param1)) % 4 % 4;
         param1 += 4;
         var _loc3_:int = 0;
         while(_loc3_ < MsgTypes.MAX_COMMANDERNUM)
         {
            param1 = int(this.AllStatus[_loc3_].getLength(param1));
            _loc3_++;
         }
         param1 += MsgTypes.MAX_COMMANDERSTORE * 2;
         param1 = (param1 + (4 - param1)) % 4 % 4;
         param1 += 8;
         param1 = (param1 + (4 - param1)) % 4 % 4;
         param1 += MsgTypes.MAX_COMMANDERCMOS * 4;
         return param1 + MsgTypes.MAX_COMMANDERCMOS * 2;
      }
      
      public function release() : void
      {
         var _loc1_:int = MsgTypes.MAX_SHIPTEAMBODY - 1;
         while(_loc1_ >= 0)
         {
            this.TeamBody[_loc1_].release();
            _loc1_--;
         }
         this.TeamBody.splice(0);
         this.TeamBody = null;
         var _loc2_:int = MsgTypes.MAX_COMMANDERNUM - 1;
         while(_loc2_ >= 0)
         {
            this.AllStatus[_loc2_].release();
            _loc2_--;
         }
         this.AllStatus.splice(0);
         this.AllStatus = null;
         this.Stone.splice(0);
         this.Stone = null;
         this.CmosExp.splice(0);
         this.CmosExp = null;
         this.Cmos.splice(0);
         this.Cmos = null;
      }
   }
}

