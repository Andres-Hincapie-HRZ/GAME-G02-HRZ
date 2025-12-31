package net.msg.Rank
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgTypes;
   
   public class MSG_RESP_RANKMATCH_TEMP
   {
      
      public var UserName:String = "";
      
      public var Guid:int;
      
      public var MatchWeekTop:int;
      
      public var MatchLevel:int;
      
      public var MatchWin:int;
      
      public var MatchLost:int;
      
      public var MatchDogfall:int;
      
      public function MSG_RESP_RANKMATCH_TEMP()
      {
         super();
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.GetByte(param1,(4 - param1.position % 4) % 4);
         this.UserName = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.Guid = _loc2_.readInt(param1);
         this.MatchWeekTop = _loc2_.readInt(param1);
         this.MatchLevel = _loc2_.readChar(param1);
         this.MatchWin = _loc2_.readChar(param1);
         this.MatchLost = _loc2_.readChar(param1);
         this.MatchDogfall = _loc2_.readChar(param1);
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.PushByte(param1,(4 - param1.position % 4) % 4);
         _loc2_.writeUtf8Str(param1,this.UserName,MsgTypes.MAX_NAME);
         _loc2_.writeInt(param1,this.Guid);
         _loc2_.writeInt(param1,this.MatchWeekTop);
         _loc2_.writeChar(param1,this.MatchLevel);
         _loc2_.writeChar(param1,this.MatchWin);
         _loc2_.writeChar(param1,this.MatchLost);
         _loc2_.writeChar(param1,this.MatchDogfall);
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

