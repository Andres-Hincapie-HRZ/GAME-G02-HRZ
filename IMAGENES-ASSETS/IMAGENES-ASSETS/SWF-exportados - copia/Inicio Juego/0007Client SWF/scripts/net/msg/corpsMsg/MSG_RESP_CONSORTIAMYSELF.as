package net.msg.corpsMsg
{
   import flash.external.ExternalInterface;
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_CONSORTIAMYSELF extends MsgHead
   {
      
      public var ConsortiaId:int;
      
      public var ConsortiaLeadUserId:Number;
      
      public var Cent:Number;
      
      public var Name:String = "";
      
      public var Notice:String = "";
      
      public var Proclaim:String = "";
      
      public var ConsortiaLead:String = "";
      
      public var JobName:ConsortiaJobName = new ConsortiaJobName();
      
      public var ConsortiaGuid:int;
      
      public var SortId:int;
      
      public var Wealth:int;
      
      public var RepairWealth:int;
      
      public var MemberCount:int;
      
      public var MaxMemberCount:int;
      
      public var HeadId:int;
      
      public var Level:int;
      
      public var HoldGalaxy:int;
      
      public var MaxHoldGalaxy:int;
      
      public var StorageLevel:int;
      
      public var UnionLevel:int;
      
      public var MyWealth:int;
      
      public var UpgradeTime:int;
      
      public var UpgradeType:int;
      
      public var PiratePassLevel:int;
      
      public var AttackUserLevel:int;
      
      public var PirateNum:int;
      
      public var AttackUser:String = "";
      
      public var AttackUserGalaxyId:int;
      
      public var AttackUserAssault:int;
      
      public function MSG_RESP_CONSORTIAMYSELF()
      {
         super();
         this.SortId = 0;
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_CONSORTIAMYSELF;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         ExternalInterface.call("console.log","Empezando a leer");
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         ExternalInterface.call("console.log","Test0");
         this.ConsortiaId = _loc2_.readInt(param1);
         this.ConsortiaLeadUserId = _loc2_.readInt64(param1);
         this.Cent = _loc2_.readInt64(param1);
         this.Name = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.Notice = _loc2_.readUtf8Str(param1,MsgTypes.MAX_MEMO);
         ExternalInterface.call("console.log","Name=" + this.Name);
         ExternalInterface.call("console.log","Notice=" + this.Notice);
         this.Proclaim = _loc2_.readUtf8Str(param1,MsgTypes.MAX_MEMO);
         ExternalInterface.call("console.log","Proclaim=" + this.Proclaim);
         this.ConsortiaLead = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         ExternalInterface.call("console.log","ConsortiaLead=" + this.ConsortiaLead);
         ExternalInterface.call("console.log","Test2");
         this.JobName.readBuf(param1);
         ExternalInterface.call("console.log","Test3");
         this.ConsortiaGuid = _loc2_.readInt(param1);
         this.SortId = _loc2_.readInt(param1);
         this.Wealth = _loc2_.readInt(param1);
         this.RepairWealth = _loc2_.readInt(param1);
         ExternalInterface.call("console.log","Test4");
         this.MemberCount = _loc2_.readUnsignChar(param1);
         this.MaxMemberCount = _loc2_.readUnsignChar(param1);
         this.HeadId = _loc2_.readUnsignChar(param1);
         this.Level = _loc2_.readUnsignChar(param1);
         this.HoldGalaxy = _loc2_.readUnsignChar(param1);
         this.MaxHoldGalaxy = _loc2_.readUnsignChar(param1);
         ExternalInterface.call("console.log","Test5");
         this.StorageLevel = _loc2_.readChar(param1);
         this.UnionLevel = _loc2_.readChar(param1);
         this.MyWealth = _loc2_.readInt(param1);
         this.UpgradeTime = _loc2_.readInt(param1);
         this.UpgradeType = _loc2_.readChar(param1);
         this.PiratePassLevel = _loc2_.readChar(param1);
         this.AttackUserLevel = _loc2_.readUnsignChar(param1);
         this.PirateNum = _loc2_.readChar(param1);
         ExternalInterface.call("console.log","Test6");
         this.AttackUser = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.AttackUserGalaxyId = _loc2_.readInt(param1);
         this.AttackUserAssault = _loc2_.readInt(param1);
         ExternalInterface.call("console.log","AttackUser=" + this.AttackUser);
         ExternalInterface.call("console.log","AttackUserAssault=" + this.AttackUserAssault);
         ExternalInterface.call("console.log","Terminando leer");
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 20;
         param1 += MsgTypes.MAX_NAME;
         param1 += MsgTypes.MAX_MEMO;
         param1 += MsgTypes.MAX_MEMO;
         param1 += MsgTypes.MAX_NAME;
         param1 = this.JobName.getLength(param1);
         param1 += (8 - param1 % 8) % 8;
         param1 += 24;
         param1 += (4 - param1 % 4) % 4;
         param1 += 12;
         param1 += MsgTypes.MAX_NAME;
         param1 += (4 - param1 % 4) % 4;
         return int(param1 + 8);
      }
      
      public function release() : void
      {
         this.JobName.release();
      }
   }
}

