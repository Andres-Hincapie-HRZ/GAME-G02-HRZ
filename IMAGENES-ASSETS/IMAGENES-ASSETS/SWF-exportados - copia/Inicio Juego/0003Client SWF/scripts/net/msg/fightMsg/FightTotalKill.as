package net.msg.fightMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgTypes;
   
   public class FightTotalKill
   {
      
      public var UserId:Number;
      
      public var Num:int;
      
      public var BodyId:uint;
      
      public var Reserve:int;
      
      public var ModelName:String = "";
      
      public var RoleName:String = "";
      
      public function FightTotalKill()
      {
         super();
         this.UserId = -1;
         this.Num = 0;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.GetByte(param1,(8 - param1.position % 8) % 8);
         this.UserId = _loc2_.readInt64(param1);
         this.Num = _loc2_.readInt(param1);
         this.BodyId = _loc2_.readUnsignShort(param1);
         this.Reserve = _loc2_.readShort(param1);
         this.ModelName = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.RoleName = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.PushByte(param1,(8 - param1.position % 8) % 8);
         _loc2_.writeInt64(param1,this.UserId);
         _loc2_.writeInt(param1,this.Num);
         _loc2_.writeUnsignShort(param1,this.BodyId);
         _loc2_.writeShort(param1,this.Reserve);
         _loc2_.writeUtf8Str(param1,this.ModelName,MsgTypes.MAX_NAME);
         _loc2_.writeUtf8Str(param1,this.RoleName,MsgTypes.MAX_NAME);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 += (8 - param1 % 8) % 8;
         param1 += 16;
         param1 += MsgTypes.MAX_NAME;
         return param1 + MsgTypes.MAX_NAME;
      }
      
      public function release() : void
      {
      }
   }
}

