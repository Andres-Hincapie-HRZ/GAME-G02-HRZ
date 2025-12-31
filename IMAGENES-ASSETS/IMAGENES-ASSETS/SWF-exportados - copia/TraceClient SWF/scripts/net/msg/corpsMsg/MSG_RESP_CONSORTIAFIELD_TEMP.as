package net.msg.corpsMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   
   public class MSG_RESP_CONSORTIAFIELD_TEMP
   {
      
      public var MaxShipNum:int;
      
      public var ShipNum:int;
      
      public var GalaxyId:int;
      
      public var NeedTime:int;
      
      public var Status:int;
      
      public var Level:int;
      
      public var Reserve:int;
      
      public function MSG_RESP_CONSORTIAFIELD_TEMP()
      {
         super();
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.GetByte(param1,(4 - param1.position % 4) % 4);
         this.MaxShipNum = _loc2_.readInt(param1);
         this.ShipNum = _loc2_.readInt(param1);
         this.GalaxyId = _loc2_.readInt(param1);
         this.NeedTime = _loc2_.readInt(param1);
         this.Status = _loc2_.readChar(param1);
         this.Level = _loc2_.readChar(param1);
         this.Reserve = _loc2_.readShort(param1);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 += (4 - param1 % 4) % 4;
         return param1 + 20;
      }
      
      public function release() : void
      {
      }
   }
}

