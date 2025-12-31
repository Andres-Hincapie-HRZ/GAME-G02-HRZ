package net.msg.corpsMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgTypes;
   
   public class MSG_RESP_CONSORTIAAUTHUSER_TEMP
   {
      
      public var Name:String = "";
      
      public var UserId:Number;
      
      public var KillTotal:int;
      
      public var Guid:int;
      
      public var Level:int;
      
      public var Reserve:int;
      
      public function MSG_RESP_CONSORTIAAUTHUSER_TEMP()
      {
         super();
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.GetByte(param1,(8 - param1.position % 8) % 8);
         this.Name = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.UserId = _loc2_.readInt64(param1);
         this.KillTotal = _loc2_.readInt(param1);
         this.Guid = _loc2_.readInt(param1);
         this.Level = _loc2_.readInt(param1);
         this.Reserve = _loc2_.readInt(param1);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 += (8 - param1 % 8) % 8;
         param1 += MsgTypes.MAX_NAME;
         param1 += (8 - param1 % 8) % 8;
         return param1 + 24;
      }
      
      public function release() : void
      {
      }
   }
}

