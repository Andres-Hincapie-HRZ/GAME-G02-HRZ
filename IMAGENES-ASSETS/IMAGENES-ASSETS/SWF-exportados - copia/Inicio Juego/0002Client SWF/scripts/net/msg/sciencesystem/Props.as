package net.msg.sciencesystem
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   
   public class Props
   {
      
      public var PropsId:int;
      
      public var PropsNum:int;
      
      public var PropsLockNum:int;
      
      public var StorageType:int;
      
      public var Reserve:int;
      
      public function Props()
      {
         super();
         this.PropsNum = 0;
         this.PropsLockNum = 0;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.GetByte(param1,(4 - param1.position % 4) % 4);
         this.PropsId = _loc2_.readShort(param1);
         this.PropsNum = _loc2_.readShort(param1);
         this.PropsLockNum = _loc2_.readShort(param1);
         this.StorageType = _loc2_.readChar(param1);
         this.Reserve = _loc2_.readChar(param1);
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.PushByte(param1,(4 - param1.position % 4) % 4);
         _loc2_.writeShort(param1,this.PropsId);
         _loc2_.writeShort(param1,this.PropsNum);
         _loc2_.writeShort(param1,this.PropsLockNum);
         _loc2_.writeChar(param1,this.StorageType);
         _loc2_.writeChar(param1,this.Reserve);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 += (4 - param1 % 4) % 4;
         return param1 + 8;
      }
      
      public function release() : void
      {
      }
   }
}

