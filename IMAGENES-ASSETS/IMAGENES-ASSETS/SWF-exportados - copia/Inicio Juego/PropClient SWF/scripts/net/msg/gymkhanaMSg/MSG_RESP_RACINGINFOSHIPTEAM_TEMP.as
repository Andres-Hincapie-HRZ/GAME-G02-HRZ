package net.msg.gymkhanaMSg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgTypes;
   
   public class MSG_RESP_RACINGINFOSHIPTEAM_TEMP
   {
      
      public var TeamName:String = "";
      
      public var ShipTeamId:int;
      
      public var CommanderId:int;
      
      public var BodyId:int;
      
      public var ShipNum:uint;
      
      public function MSG_RESP_RACINGINFOSHIPTEAM_TEMP()
      {
         super();
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.GetByte(param1,(4 - param1.position % 4) % 4);
         this.TeamName = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.ShipTeamId = _loc2_.readInt(param1);
         this.CommanderId = _loc2_.readInt(param1);
         this.BodyId = _loc2_.readShort(param1);
         this.ShipNum = _loc2_.readUnsignShort(param1);
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.PushByte(param1,(4 - param1.position % 4) % 4);
         _loc2_.writeUtf8Str(param1,this.TeamName,MsgTypes.MAX_NAME);
         _loc2_.writeInt(param1,this.ShipTeamId);
         _loc2_.writeInt(param1,this.CommanderId);
         _loc2_.writeShort(param1,this.BodyId);
         _loc2_.writeUnsignShort(param1,this.ShipNum);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 += (4 - param1 % 4) % 4;
         param1 += MsgTypes.MAX_NAME;
         param1 += (4 - param1 % 4) % 4;
         return param1 + 12;
      }
      
      public function release() : void
      {
      }
   }
}

