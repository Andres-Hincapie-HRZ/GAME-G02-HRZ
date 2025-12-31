package net.msg.Rank
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgTypes;
   
   public class MSG_RESP_WARFIELD_PAGE_TEMP
   {
      
      public var UserId:Number;
      
      public var Name:String = "";
      
      public var Guid:int;
      
      public var WarScore:uint;
      
      public var WarKilldown:uint;
      
      public var WarWin:uint;
      
      public function MSG_RESP_WARFIELD_PAGE_TEMP()
      {
         super();
         this.Guid = -1;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.GetByte(param1,(8 - param1.position % 8) % 8);
         this.UserId = _loc2_.readInt64(param1);
         this.Name = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.Guid = _loc2_.readInt(param1);
         this.WarScore = _loc2_.readUnsignInt(param1);
         this.WarKilldown = _loc2_.readUnsignInt(param1);
         this.WarWin = _loc2_.readUnsignShort(param1);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 += (8 - param1 % 8) % 8;
         param1 += 8;
         param1 += MsgTypes.MAX_NAME;
         param1 += (4 - param1 % 4) % 4;
         return param1 + 14;
      }
      
      public function release() : void
      {
      }
   }
}

