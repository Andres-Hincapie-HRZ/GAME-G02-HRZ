package net.msg.match
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgTypes;
   
   public class MSG_RESP_MATCHPAGE_TEMP
   {
      
      public var Name:String = "";
      
      public var MatchWin:int;
      
      public var MatchLost:int;
      
      public var MatchDogfall:int;
      
      public var MatchResult:int;
      
      public function MSG_RESP_MATCHPAGE_TEMP()
      {
         super();
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.GetByte(param1,(4 - param1.position % 4) % 4);
         this.Name = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.MatchWin = _loc2_.readChar(param1);
         this.MatchLost = _loc2_.readChar(param1);
         this.MatchDogfall = _loc2_.readChar(param1);
         this.MatchResult = _loc2_.readChar(param1);
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.PushByte(param1,(4 - param1.position % 4) % 4);
         _loc2_.writeUtf8Str(param1,this.Name,MsgTypes.MAX_NAME);
         _loc2_.writeChar(param1,this.MatchWin);
         _loc2_.writeChar(param1,this.MatchLost);
         _loc2_.writeChar(param1,this.MatchDogfall);
         _loc2_.writeChar(param1,this.MatchResult);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 += (4 - param1 % 4) % 4;
         param1 += MsgTypes.MAX_NAME;
         return param1 + 4;
      }
      
      public function release() : void
      {
      }
   }
}

