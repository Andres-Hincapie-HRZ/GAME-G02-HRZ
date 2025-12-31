package net.msg.gymkhanaMSg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_REQUEST_SETRACINGSHIPTEAM extends MsgHead
   {
      
      public var SeqId:int;
      
      public var Guid:int;
      
      public var ShipTeamLen:uint;
      
      public var ShipTeamId:Array = new Array(MsgTypes.MAX_RACINGSHIPTEAMNUM);
      
      public function MSG_REQUEST_SETRACINGSHIPTEAM()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_REQUEST_SETRACINGSHIPTEAM;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.SeqId = _loc2_.readInt(param1);
         this.Guid = _loc2_.readInt(param1);
         this.ShipTeamLen = _loc2_.readUnsignInt(param1);
         var _loc3_:int = 0;
         while(_loc3_ < MsgTypes.MAX_RACINGSHIPTEAMNUM)
         {
            if(param1.length - param1.position >= 4)
            {
               this.ShipTeamId[_loc3_] = _loc2_.readInt(param1);
            }
            _loc3_++;
         }
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         param1.position = 0;
         _loc2_.writeShort(param1,usSize);
         _loc2_.writeShort(param1,usType);
         _loc2_.writeInt(param1,this.SeqId);
         _loc2_.writeInt(param1,this.Guid);
         _loc2_.writeUnsignInt(param1,this.ShipTeamLen);
         var _loc3_:int = 0;
         while(_loc3_ < MsgTypes.MAX_RACINGSHIPTEAMNUM)
         {
            _loc2_.writeInt(param1,this.ShipTeamId[_loc3_]);
            _loc3_++;
         }
         _loc2_.PushByte(param1,usSize - param1.position);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 12;
         return param1 + MsgTypes.MAX_RACINGSHIPTEAMNUM * 4;
      }
      
      public function release() : void
      {
         this.ShipTeamId.splice(0);
         this.ShipTeamId = null;
      }
   }
}

