package net.msg.ship
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   import net.msg.fleetMsg.MSG_SHIPTEAM_BODY;
   
   public class MSG_RESP_VIEWJUMPSHIPTEAM extends MsgHead
   {
      
      public var TeamBody:Array;
      
      public var UserId:Number;
      
      public var CommanderUserId:Number;
      
      public var TeamName:String = "";
      
      public var TeamOwner:String = "";
      
      public var ShipTeamId:int;
      
      public var Aim:int;
      
      public var Blench:int;
      
      public var Priority:int;
      
      public var Electron:int;
      
      public var SkillId:int;
      
      public var CardLevel:int;
      
      public function MSG_RESP_VIEWJUMPSHIPTEAM()
      {
         var _loc2_:MSG_SHIPTEAM_BODY = null;
         this.TeamBody = new Array(MsgTypes.MAX_SHIPTEAMBODY);
         super();
         var _loc1_:int = 0;
         while(_loc1_ < MsgTypes.MAX_SHIPTEAMBODY)
         {
            _loc2_ = new MSG_SHIPTEAM_BODY();
            this.TeamBody[_loc1_] = _loc2_;
            _loc1_++;
         }
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_VIEWJUMPSHIPTEAM;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         var _loc3_:int = 0;
         while(_loc3_ < MsgTypes.MAX_SHIPTEAMBODY)
         {
            if(param1.length > param1.position)
            {
               this.TeamBody[_loc3_].readBuf(param1);
            }
            _loc3_++;
         }
         this.UserId = _loc2_.readInt64(param1);
         this.CommanderUserId = _loc2_.readInt64(param1);
         this.TeamName = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.TeamOwner = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.ShipTeamId = _loc2_.readInt(param1);
         this.Aim = _loc2_.readShort(param1);
         this.Blench = _loc2_.readShort(param1);
         this.Priority = _loc2_.readShort(param1);
         this.Electron = _loc2_.readShort(param1);
         this.SkillId = _loc2_.readShort(param1);
         this.CardLevel = _loc2_.readChar(param1);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         var _loc2_:int = 0;
         while(_loc2_ < MsgTypes.MAX_SHIPTEAMBODY)
         {
            param1 = int(this.TeamBody[_loc2_].getLength(param1));
            _loc2_++;
         }
         param1 += (8 - param1 % 8) % 8;
         param1 += (8 - param1 % 8) % 8;
         param1 += 16;
         param1 += MsgTypes.MAX_NAME;
         param1 += MsgTypes.MAX_NAME;
         param1 += (4 - param1 % 4) % 4;
         return param1 + 15;
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
      }
   }
}

