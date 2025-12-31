package net.msg.gymkhanaMSg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgTypes;
   
   public class RacingReportInfo
   {
      
      public var Type:int;
      
      public var Time:uint;
      
      public var ReportDate:int;
      
      public var RankChange:int;
      
      public var Name:String = "";
      
      public function RacingReportInfo()
      {
         super();
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.GetByte(param1,(4 - param1.position % 4) % 4);
         this.Type = _loc2_.readInt(param1);
         this.Time = _loc2_.readUnsignInt(param1);
         this.ReportDate = _loc2_.readInt(param1);
         this.RankChange = _loc2_.readInt(param1);
         this.Name = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.PushByte(param1,(4 - param1.position % 4) % 4);
         _loc2_.writeInt(param1,this.Type);
         _loc2_.writeUnsignInt(param1,this.Time);
         _loc2_.writeInt(param1,this.ReportDate);
         _loc2_.writeInt(param1,this.RankChange);
         _loc2_.writeUtf8Str(param1,this.Name,MsgTypes.MAX_NAME);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 += (4 - param1 % 4) % 4;
         param1 += 16;
         return param1 + MsgTypes.MAX_NAME;
      }
      
      public function release() : void
      {
      }
   }
}

