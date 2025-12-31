package net.msg.ship
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_MOVESHIPTEAM extends MsgHead
   {
      
      public var GalaxyMapId:int;
      
      public var GalaxyId:int;
      
      public var ShipTeamId:int;
      
      public var PosX:int;
      
      public var PosY:int;
      
      public function MSG_RESP_MOVESHIPTEAM()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_MOVESHIPTEAM;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.GalaxyMapId = _loc2_.readInt(param1);
         this.GalaxyId = _loc2_.readInt(param1);
         this.ShipTeamId = _loc2_.readInt(param1);
         this.PosX = _loc2_.readInt(param1);
         this.PosY = _loc2_.readInt(param1);
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         param1.position = 0;
         _loc2_.writeShort(param1,usSize);
         _loc2_.writeShort(param1,usType);
         _loc2_.writeInt(param1,this.GalaxyMapId);
         _loc2_.writeInt(param1,this.GalaxyId);
         _loc2_.writeInt(param1,this.ShipTeamId);
         _loc2_.writeInt(param1,this.PosX);
         _loc2_.writeInt(param1,this.PosY);
         _loc2_.PushByte(param1,usSize - param1.position);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         return param1 + 20;
      }
      
      public function release() : void
      {
      }
   }
}

