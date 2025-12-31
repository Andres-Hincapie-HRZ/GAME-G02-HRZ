package net.msg.ship
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_REQUEST_JUMPSHIPTEAM extends MsgHead
   {
      
      public var SeqId:int;
      
      public var Guid:int;
      
      public var ToGalaxyMapId:int;
      
      public var ToGalaxyId:int;
      
      public var DataLen:int;
      
      public var JumpType:int;
      
      public var Type:int;
      
      public var ShipTeamId:Array = new Array(100);
      
      public function MSG_REQUEST_JUMPSHIPTEAM()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_REQUEST_JUMPSHIPTEAM;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.SeqId = _loc2_.readInt(param1);
         this.Guid = _loc2_.readInt(param1);
         this.ToGalaxyMapId = _loc2_.readInt(param1);
         this.ToGalaxyId = _loc2_.readInt(param1);
         this.DataLen = _loc2_.readShort(param1);
         this.JumpType = _loc2_.readChar(param1);
         this.Type = _loc2_.readChar(param1);
         var _loc3_:int = 0;
         while(_loc3_ < 100)
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
         _loc2_.writeInt(param1,this.ToGalaxyMapId);
         _loc2_.writeInt(param1,this.ToGalaxyId);
         _loc2_.writeShort(param1,this.DataLen);
         _loc2_.writeChar(param1,this.JumpType);
         _loc2_.writeChar(param1,this.Type);
         var _loc3_:int = 0;
         while(_loc3_ < 100)
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
         param1 += 20;
         param1 += (4 - param1 % 4) % 4;
         return param1 + 100 * 4;
      }
      
      public function release() : void
      {
         this.ShipTeamId.splice(0);
         this.ShipTeamId = null;
      }
   }
}

