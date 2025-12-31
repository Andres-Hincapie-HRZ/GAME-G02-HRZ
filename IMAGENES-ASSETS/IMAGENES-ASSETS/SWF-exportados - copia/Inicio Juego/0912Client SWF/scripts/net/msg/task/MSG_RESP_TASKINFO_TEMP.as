package net.msg.task
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   
   public class MSG_RESP_TASKINFO_TEMP
   {
      
      public var TaskId:int;
      
      public var Num:int;
      
      public var Type:int;
      
      public var LevelId:int;
      
      public var CompleteFlag:int;
      
      public var GainFlag:int;
      
      public function MSG_RESP_TASKINFO_TEMP()
      {
         super();
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.GetByte(param1,(4 - param1.position % 4) % 4);
         this.TaskId = _loc2_.readShort(param1);
         this.Num = _loc2_.readShort(param1);
         this.Type = _loc2_.readChar(param1);
         this.LevelId = _loc2_.readChar(param1);
         this.CompleteFlag = _loc2_.readChar(param1);
         this.GainFlag = _loc2_.readChar(param1);
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

