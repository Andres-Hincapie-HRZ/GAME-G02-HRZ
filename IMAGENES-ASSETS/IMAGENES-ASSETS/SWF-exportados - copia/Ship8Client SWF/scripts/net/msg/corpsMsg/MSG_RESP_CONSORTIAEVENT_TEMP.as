package net.msg.corpsMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgTypes;
   
   public class MSG_RESP_CONSORTIAEVENT_TEMP
   {
      
      public var SrcName:String = "";
      
      public var ObjName:String = "";
      
      public var SrcUserId:Number;
      
      public var ObjUserId:Number;
      
      public var Guid:int;
      
      public var Extend:int;
      
      public var PassTime:int;
      
      public var BigType:int;
      
      public var SmallType:int;
      
      public var JumpType:int;
      
      public var Reserve:int;
      
      public function MSG_RESP_CONSORTIAEVENT_TEMP()
      {
         super();
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.GetByte(param1,(8 - param1.position % 8) % 8);
         this.SrcName = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.ObjName = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.SrcUserId = _loc2_.readInt64(param1);
         this.ObjUserId = _loc2_.readInt64(param1);
         this.Guid = _loc2_.readInt(param1);
         this.Extend = _loc2_.readInt(param1);
         this.PassTime = _loc2_.readInt(param1);
         this.BigType = _loc2_.readChar(param1);
         this.SmallType = _loc2_.readChar(param1);
         this.JumpType = _loc2_.readChar(param1);
         this.Reserve = _loc2_.readChar(param1);
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

