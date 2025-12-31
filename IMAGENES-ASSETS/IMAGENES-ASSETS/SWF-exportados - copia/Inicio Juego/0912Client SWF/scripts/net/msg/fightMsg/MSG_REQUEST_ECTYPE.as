package net.msg.fightMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_REQUEST_ECTYPE extends MsgHead
   {
      
      public var SeqId:int;
      
      public var Guid:int;
      
      public var EctypeId:int;
      
      public var GateId:int;
      
      public var DataLen:int;
      
      public var ShipTeamId:Array = new Array(MsgTypes.MAX_USERSHIPTEAMNUM);
      
      public var PassKey:int;
      
      public var RoomId:int;
      
      public function MSG_REQUEST_ECTYPE()
      {
         super();
         this.PassKey = -1;
         this.RoomId = -1;
         usSize = this.getLength();
         usType = MsgTypes._MSG_REQUEST_ECTYPE;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         param1.position = 0;
         _loc2_.writeShort(param1,usSize);
         _loc2_.writeShort(param1,usType);
         _loc2_.writeInt(param1,this.SeqId);
         _loc2_.writeInt(param1,this.Guid);
         _loc2_.writeShort(param1,this.EctypeId);
         _loc2_.writeUnsignChar(param1,this.GateId);
         _loc2_.writeUnsignChar(param1,this.DataLen);
         var _loc3_:int = 0;
         while(_loc3_ < MsgTypes.MAX_USERSHIPTEAMNUM)
         {
            _loc2_.writeInt(param1,this.ShipTeamId[_loc3_]);
            _loc3_++;
         }
         _loc2_.writeInt(param1,this.PassKey);
         _loc2_.writeInt(param1,this.RoomId);
         _loc2_.PushByte(param1,usSize - param1.position);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 12;
         param1 += (4 - param1 % 4) % 4;
         param1 += MsgTypes.MAX_USERSHIPTEAMNUM * 4;
         return param1 + 8;
      }
      
      public function release() : void
      {
         this.ShipTeamId.splice(0);
         this.ShipTeamId = null;
      }
   }
}

