package net.msg.corpsMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgTypes;
   
   public class MSG_RESP_CONSORTIAMEMBER_TEMP
   {
      
      public var Name:String = "";
      
      public var UserId:Number;
      
      public var OfflineTime:int;
      
      public var ThrowValue:int;
      
      public var Guid:int;
      
      public var Level:int;
      
      public var Status:int;
      
      public var Job:int;
      
      public var Reserver:int;
      
      public var _Status:int;
      
      public var _Job:int;
      
      public function MSG_RESP_CONSORTIAMEMBER_TEMP()
      {
         super();
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.GetByte(param1,(8 - param1.position % 8) % 8);
         this.Name = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.UserId = _loc2_.readInt64(param1);
         this.OfflineTime = _loc2_.readInt(param1);
         this.ThrowValue = _loc2_.readInt(param1);
         this.Guid = _loc2_.readInt(param1);
         this.Level = _loc2_.readUnsignChar(param1);
         this.Status = _loc2_.readChar(param1);
         this.Job = _loc2_.readChar(param1);
         this.Reserver = _loc2_.readChar(param1);
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

