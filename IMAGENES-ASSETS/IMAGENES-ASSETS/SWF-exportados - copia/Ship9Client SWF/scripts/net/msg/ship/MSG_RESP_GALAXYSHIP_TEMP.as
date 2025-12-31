package net.msg.ship
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   
   public class MSG_RESP_GALAXYSHIP_TEMP
   {
      
      public var ShipTeamId:int;
      
      public var ShipNum:int;
      
      public var BodyId:int;
      
      public var Reserve:int;
      
      public var Direction:int;
      
      public var PosX:int;
      
      public var PosY:int;
      
      public var Owner:int;
      
      public function MSG_RESP_GALAXYSHIP_TEMP()
      {
         super();
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.GetByte(param1,(4 - param1.position % 4) % 4);
         this.ShipTeamId = _loc2_.readInt(param1);
         this.ShipNum = _loc2_.readInt(param1);
         this.BodyId = _loc2_.readShort(param1);
         this.Reserve = _loc2_.readShort(param1);
         this.Direction = _loc2_.readChar(param1);
         this.PosX = _loc2_.readChar(param1);
         this.PosY = _loc2_.readChar(param1);
         this.Owner = _loc2_.readChar(param1);
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.PushByte(param1,(4 - param1.position % 4) % 4);
         _loc2_.writeInt(param1,this.ShipTeamId);
         _loc2_.writeInt(param1,this.ShipNum);
         _loc2_.writeShort(param1,this.BodyId);
         _loc2_.writeShort(param1,this.Reserve);
         _loc2_.writeChar(param1,this.Direction);
         _loc2_.writeChar(param1,this.PosX);
         _loc2_.writeChar(param1,this.PosY);
         _loc2_.writeChar(param1,this.Owner);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 += (4 - param1 % 4) % 4;
         return param1 + 16;
      }
      
      public function release() : void
      {
      }
   }
}

