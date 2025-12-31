package net.msg.corpsMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_REQUEST_GOTORESOURCESTAR extends MsgHead
   {
      
      public var SeqId:int;
      
      public var Guid:int;
      
      public var GalaxyMapId:int;
      
      public var GalaxyId:int;
      
      public var DataLen:int;
      
      public var ShipTeamId:Array = new Array(100);
      
      public function MSG_REQUEST_GOTORESOURCESTAR()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_REQUEST_GOTORESOURCESTAR;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         param1.position = 0;
         _loc2_.writeShort(param1,usSize);
         _loc2_.writeShort(param1,usType);
         _loc2_.writeInt(param1,this.SeqId);
         _loc2_.writeInt(param1,this.Guid);
         _loc2_.writeInt(param1,this.GalaxyMapId);
         _loc2_.writeInt(param1,this.GalaxyId);
         _loc2_.writeInt(param1,this.DataLen);
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
         return param1 + 100 * 4;
      }
      
      public function release() : void
      {
         this.ShipTeamId.splice(0);
         this.ShipTeamId = null;
      }
   }
}

