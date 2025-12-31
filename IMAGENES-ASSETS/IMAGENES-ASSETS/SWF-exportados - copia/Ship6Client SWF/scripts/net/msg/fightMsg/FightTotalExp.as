package net.msg.fightMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgTypes;
   
   public class FightTotalExp
   {
      
      public var UserId:Number;
      
      public var CommanderUserId:Number;
      
      public var Exp:uint;
      
      public var HeadId:int;
      
      public var LevelId:uint;
      
      public var CommanderName:String = "";
      
      public var RoleName:String = "";
      
      public function FightTotalExp()
      {
         super();
         this.CommanderUserId = -1;
         this.UserId = -1;
         this.HeadId = -1;
         this.Exp = 0;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.GetByte(param1,(8 - param1.position % 8) % 8);
         this.UserId = _loc2_.readInt64(param1);
         this.CommanderUserId = _loc2_.readInt64(param1);
         this.Exp = _loc2_.readUnsignInt(param1);
         this.HeadId = _loc2_.readShort(param1);
         this.LevelId = _loc2_.readUnsignShort(param1);
         this.CommanderName = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.RoleName = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.PushByte(param1,(8 - param1.position % 8) % 8);
         _loc2_.writeInt64(param1,this.UserId);
         _loc2_.writeInt64(param1,this.CommanderUserId);
         _loc2_.writeUnsignInt(param1,this.Exp);
         _loc2_.writeShort(param1,this.HeadId);
         _loc2_.writeUnsignShort(param1,this.LevelId);
         _loc2_.writeUtf8Str(param1,this.CommanderName,MsgTypes.MAX_NAME);
         _loc2_.writeUtf8Str(param1,this.RoleName,MsgTypes.MAX_NAME);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 += (8 - param1 % 8) % 8;
         param1 += 24;
         param1 += MsgTypes.MAX_NAME;
         return param1 + MsgTypes.MAX_NAME;
      }
      
      public function release() : void
      {
      }
   }
}

