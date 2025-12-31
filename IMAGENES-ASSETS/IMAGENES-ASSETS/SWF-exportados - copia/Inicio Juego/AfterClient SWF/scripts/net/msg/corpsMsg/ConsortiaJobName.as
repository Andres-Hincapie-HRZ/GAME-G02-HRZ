package net.msg.corpsMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgTypes;
   
   public class ConsortiaJobName
   {
      
      public var Name0:String = "";
      
      public var Name1:String = "";
      
      public var Name2:String = "";
      
      public var Name3:String = "";
      
      public var Name4:String = "";
      
      public function ConsortiaJobName()
      {
         super();
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.GetByte(param1,(4 - param1.position % 4) % 4);
         this.Name0 = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.Name1 = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.Name2 = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.Name3 = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.Name4 = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.PushByte(param1,(4 - param1.position % 4) % 4);
         _loc2_.writeUtf8Str(param1,this.Name0,MsgTypes.MAX_NAME);
         _loc2_.writeUtf8Str(param1,this.Name1,MsgTypes.MAX_NAME);
         _loc2_.writeUtf8Str(param1,this.Name2,MsgTypes.MAX_NAME);
         _loc2_.writeUtf8Str(param1,this.Name3,MsgTypes.MAX_NAME);
         _loc2_.writeUtf8Str(param1,this.Name4,MsgTypes.MAX_NAME);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 += (4 - param1 % 4) % 4;
         param1 += MsgTypes.MAX_NAME;
         param1 += MsgTypes.MAX_NAME;
         param1 += MsgTypes.MAX_NAME;
         param1 += MsgTypes.MAX_NAME;
         return param1 + MsgTypes.MAX_NAME;
      }
      
      public function release() : void
      {
      }
   }
}

