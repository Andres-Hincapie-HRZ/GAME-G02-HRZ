package net.msg.commanderMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_COMMANDERSTONEINFO extends MsgHead
   {
      
      public var UserName:String = "";
      
      public var CommanderZJ:String = "";
      
      public var Exp:int;
      
      public var SkillId:int;
      
      public var Level:int;
      
      public var CardLevel:int;
      
      public var Aim:int;
      
      public var Blench:int;
      
      public var Priority:int;
      
      public var Electron:int;
      
      public var S_Aim:int;
      
      public var S_Blench:int;
      
      public var S_Electron:int;
      
      public var S_Priority:int;
      
      public var S_Assault:int;
      
      public var S_Endure:int;
      
      public var S_Shield:int;
      
      public var S_BlastHurt:int;
      
      public var S_Blast:int;
      
      public var S_DoubleHit:int;
      
      public var S_RepairShield:int;
      
      public var S_Exp:int;
      
      public var AimPer:int;
      
      public var BlenchPer:int;
      
      public var PriorityPer:int;
      
      public var ElectronPer:int;
      
      public var Cmos:Array = new Array(MsgTypes.MAX_COMMANDERCMOS);
      
      public function MSG_RESP_COMMANDERSTONEINFO()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_COMMANDERSTONEINFO;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.UserName = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.CommanderZJ = _loc2_.readUtf8Str(param1,MsgTypes.COMMANDERZJCOUNT);
         this.Exp = _loc2_.readInt(param1);
         this.SkillId = _loc2_.readInt(param1);
         this.Level = _loc2_.readInt(param1);
         this.CardLevel = _loc2_.readInt(param1);
         this.Aim = _loc2_.readInt(param1);
         this.Blench = _loc2_.readInt(param1);
         this.Priority = _loc2_.readInt(param1);
         this.Electron = _loc2_.readInt(param1);
         this.S_Aim = _loc2_.readInt(param1);
         this.S_Blench = _loc2_.readInt(param1);
         this.S_Electron = _loc2_.readInt(param1);
         this.S_Priority = _loc2_.readInt(param1);
         this.S_Assault = _loc2_.readInt(param1);
         this.S_Endure = _loc2_.readInt(param1);
         this.S_Shield = _loc2_.readInt(param1);
         this.S_BlastHurt = _loc2_.readInt(param1);
         this.S_Blast = _loc2_.readInt(param1);
         this.S_DoubleHit = _loc2_.readInt(param1);
         this.S_RepairShield = _loc2_.readInt(param1);
         this.S_Exp = _loc2_.readInt(param1);
         this.AimPer = _loc2_.readChar(param1);
         this.BlenchPer = _loc2_.readChar(param1);
         this.PriorityPer = _loc2_.readChar(param1);
         this.ElectronPer = _loc2_.readChar(param1);
         var _loc3_:int = 0;
         while(_loc3_ < MsgTypes.MAX_COMMANDERCMOS)
         {
            if(param1.length - param1.position >= 2)
            {
               this.Cmos[_loc3_] = _loc2_.readShort(param1);
            }
            _loc3_++;
         }
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += MsgTypes.MAX_NAME;
         param1 += MsgTypes.COMMANDERZJCOUNT;
         param1 += (4 - param1 % 4) % 4;
         param1 += 84;
         param1 += (2 - param1 % 2) % 2;
         return param1 + MsgTypes.MAX_COMMANDERCMOS * 2;
      }
      
      public function release() : void
      {
         this.Cmos.splice(0);
         this.Cmos = null;
      }
   }
}

