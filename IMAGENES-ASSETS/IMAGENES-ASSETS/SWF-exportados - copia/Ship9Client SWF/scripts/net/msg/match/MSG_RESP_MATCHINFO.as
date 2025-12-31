package net.msg.match
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_MATCHINFO extends MsgHead
   {
      
      public var SpareTime:int;
      
      public var MatchWeekTop:int;
      
      public var Reserve:int;
      
      public var MatchWin:int;
      
      public var MatchLost:int;
      
      public var MatchDogfall:int;
      
      public var MatchLevel:int;
      
      public var MatchCount:int;
      
      public var MatchType:int;
      
      public function MSG_RESP_MATCHINFO()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_MATCHINFO;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.SpareTime = _loc2_.readInt(param1);
         this.MatchWeekTop = _loc2_.readInt(param1);
         this.Reserve = _loc2_.readShort(param1);
         this.MatchWin = _loc2_.readChar(param1);
         this.MatchLost = _loc2_.readChar(param1);
         this.MatchDogfall = _loc2_.readChar(param1);
         this.MatchLevel = _loc2_.readChar(param1);
         this.MatchCount = _loc2_.readChar(param1);
         this.MatchType = _loc2_.readChar(param1);
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         param1.position = 0;
         _loc2_.writeShort(param1,usSize);
         _loc2_.writeShort(param1,usType);
         _loc2_.writeInt(param1,this.SpareTime);
         _loc2_.writeInt(param1,this.MatchWeekTop);
         _loc2_.writeShort(param1,this.Reserve);
         _loc2_.writeChar(param1,this.MatchWin);
         _loc2_.writeChar(param1,this.MatchLost);
         _loc2_.writeChar(param1,this.MatchDogfall);
         _loc2_.writeChar(param1,this.MatchLevel);
         _loc2_.writeChar(param1,this.MatchCount);
         _loc2_.writeChar(param1,this.MatchType);
         _loc2_.PushByte(param1,usSize - param1.position);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         return param1 + 16;
      }
      
      public function release() : void
      {
      }
   }
}

