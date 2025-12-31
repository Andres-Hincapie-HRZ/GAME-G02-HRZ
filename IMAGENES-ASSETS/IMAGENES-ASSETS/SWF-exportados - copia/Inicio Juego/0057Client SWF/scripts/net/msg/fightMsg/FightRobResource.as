package net.msg.fightMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgTypes;
   
   public class FightRobResource
   {
      
      public var UserId:Number;
      
      public var HeadId:int;
      
      public var Metal:uint;
      
      public var Gas:uint;
      
      public var Money:uint;
      
      public var RoleName:String = "";
      
      public function FightRobResource()
      {
         super();
         this.UserId = -1;
         this.Metal = 0;
         this.Gas = 0;
         this.Money = 0;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.GetByte(param1,(8 - param1.position % 8) % 8);
         this.UserId = _loc2_.readInt64(param1);
         this.HeadId = _loc2_.readInt(param1);
         this.Metal = _loc2_.readUnsignInt(param1);
         this.Gas = _loc2_.readUnsignInt(param1);
         this.Money = _loc2_.readUnsignInt(param1);
         this.RoleName = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.PushByte(param1,(8 - param1.position % 8) % 8);
         _loc2_.writeInt64(param1,this.UserId);
         _loc2_.writeInt(param1,this.HeadId);
         _loc2_.writeUnsignInt(param1,this.Metal);
         _loc2_.writeUnsignInt(param1,this.Gas);
         _loc2_.writeUnsignInt(param1,this.Money);
         _loc2_.writeUtf8Str(param1,this.RoleName,MsgTypes.MAX_NAME);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 += (8 - param1 % 8) % 8;
         param1 += 24;
         return param1 + MsgTypes.MAX_NAME;
      }
      
      public function release() : void
      {
      }
   }
}

