package net.msg.Rank
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgTypes;
   
   public class MSG_RANKUSERINFO
   {
      
      public var Name:String = "";
      
      public var ConsortiaName:String = "";
      
      public var UserId:Number;
      
      public var Assault:int;
      
      public var RankId:int;
      
      public var KillTotal:int;
      
      public var Guid:int;
      
      public var ConsortiaId:int;
      
      public var HeadId:int;
      
      public var Level:int;
      
      public var Reserve2:int;
      
      public function MSG_RANKUSERINFO()
      {
         super();
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.GetByte(param1,(8 - param1.position % 8) % 8);
         this.Name = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.ConsortiaName = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.UserId = _loc2_.readInt64(param1);
         this.Assault = _loc2_.readInt(param1);
         this.RankId = _loc2_.readInt(param1);
         this.KillTotal = _loc2_.readInt(param1);
         this.Guid = _loc2_.readInt(param1);
         this.ConsortiaId = _loc2_.readInt(param1);
         this.HeadId = _loc2_.readShort(param1);
         this.Level = _loc2_.readUnsignChar(param1);
         this.Reserve2 = _loc2_.readChar(param1);
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.PushByte(param1,(8 - param1.position % 8) % 8);
         _loc2_.writeUtf8Str(param1,this.Name,MsgTypes.MAX_NAME);
         _loc2_.writeUtf8Str(param1,this.ConsortiaName,MsgTypes.MAX_NAME);
         _loc2_.writeInt64(param1,this.UserId);
         _loc2_.writeInt(param1,this.Assault);
         _loc2_.writeInt(param1,this.RankId);
         _loc2_.writeInt(param1,this.KillTotal);
         _loc2_.writeInt(param1,this.Guid);
         _loc2_.writeInt(param1,this.ConsortiaId);
         _loc2_.writeShort(param1,this.HeadId);
         _loc2_.writeUnsignChar(param1,this.Level);
         _loc2_.writeChar(param1,this.Reserve2);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 += (8 - param1 % 8) % 8;
         param1 += MsgTypes.MAX_NAME;
         param1 += MsgTypes.MAX_NAME;
         param1 += (8 - param1 % 8) % 8;
         return param1 + 32;
      }
      
      public function release() : void
      {
      }
   }
}

