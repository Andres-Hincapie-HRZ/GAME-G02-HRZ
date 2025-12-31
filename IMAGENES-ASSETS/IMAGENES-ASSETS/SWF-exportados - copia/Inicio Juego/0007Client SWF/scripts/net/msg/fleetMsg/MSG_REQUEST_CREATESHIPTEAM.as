package net.msg.fleetMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_REQUEST_CREATESHIPTEAM extends MsgHead
   {
      
      public var SeqId:int;
      
      public var Guid:int;
      
      public var TeamName:String = "";
      
      public var TeamBody:Array;
      
      public var CommanderId:int;
      
      public var Target:int;
      
      public var TargetInterval:int;
      
      public function MSG_REQUEST_CREATESHIPTEAM()
      {
         var _loc2_:MSG_SHIPTEAM_NUM = null;
         this.TeamBody = new Array(MsgTypes.MAX_SHIPTEAMBODY);
         super();
         var _loc1_:int = 0;
         while(_loc1_ < MsgTypes.MAX_SHIPTEAMBODY)
         {
            _loc2_ = new MSG_SHIPTEAM_NUM();
            this.TeamBody[_loc1_] = _loc2_;
            _loc1_++;
         }
         usSize = this.getLength();
         usType = MsgTypes._MSG_REQUEST_CREATESHIPTEAM;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         param1.position = 0;
         _loc2_.writeShort(param1,usSize);
         _loc2_.writeShort(param1,usType);
         _loc2_.writeInt(param1,this.SeqId);
         _loc2_.writeInt(param1,this.Guid);
         _loc2_.writeUtf8Str(param1,this.TeamName,MsgTypes.MAX_NAME);
         var _loc3_:int = 0;
         while(_loc3_ < MsgTypes.MAX_SHIPTEAMBODY)
         {
            this.TeamBody[_loc3_].writeBuf(param1);
            _loc3_++;
         }
         _loc2_.writeInt(param1,this.CommanderId);
         _loc2_.writeChar(param1,this.Target);
         _loc2_.writeChar(param1,this.TargetInterval);
         _loc2_.PushByte(param1,usSize - param1.position);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 8;
         param1 += MsgTypes.MAX_NAME;
         var _loc2_:int = 0;
         while(_loc2_ < MsgTypes.MAX_SHIPTEAMBODY)
         {
            param1 = int(this.TeamBody[_loc2_].getLength(param1));
            _loc2_++;
         }
         param1 += (4 - param1 % 4) % 4;
         return param1 + 6;
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

