package net.msg.ChipLottery
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   
   public class CmosInfo
   {
      
      public var Exp:uint;
      
      public var PropsId:int;
      
      public var Reserve:int;
      
      public function CmosInfo()
      {
         super();
         this.Exp = 0;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.GetByte(param1,(4 - param1.position % 4) % 4);
         this.Exp = _loc2_.readUnsignInt(param1);
         this.PropsId = _loc2_.readShort(param1);
         this.Reserve = _loc2_.readShort(param1);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 += (4 - param1 % 4) % 4;
         return param1 + 8;
      }
      
      public function release() : void
      {
      }
   }
}

