package net.msg.upgrade
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   
   public class MSG_RESP_SHIPBODYINFO_TEMP
   {
      
      public var BodyPartId:int;
      
      public var NeedTime:int;
      
      public function MSG_RESP_SHIPBODYINFO_TEMP()
      {
         super();
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.GetByte(param1,(4 - param1.position % 4) % 4);
         this.BodyPartId = _loc2_.readInt(param1);
         this.NeedTime = _loc2_.readInt(param1);
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

