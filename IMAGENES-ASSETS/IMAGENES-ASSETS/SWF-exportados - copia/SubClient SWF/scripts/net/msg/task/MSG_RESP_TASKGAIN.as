package net.msg.task
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_TASKGAIN extends MsgHead
   {
      
      public var TaskId:int;
      
      public var Type:int;
      
      public var NextTaskId:int;
      
      public var CompleteFlag:int;
      
      public var Gas:int;
      
      public var Metal:int;
      
      public var Money:int;
      
      public var PropsId:int;
      
      public var PropsNum:int;
      
      public var Coins:int;
      
      public function MSG_RESP_TASKGAIN()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_TASKGAIN;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.TaskId = _loc2_.readInt(param1);
         this.Type = _loc2_.readInt(param1);
         this.NextTaskId = _loc2_.readInt(param1);
         this.CompleteFlag = _loc2_.readInt(param1);
         this.Gas = _loc2_.readInt(param1);
         this.Metal = _loc2_.readInt(param1);
         this.Money = _loc2_.readInt(param1);
         this.PropsId = _loc2_.readInt(param1);
         this.PropsNum = _loc2_.readInt(param1);
         this.Coins = _loc2_.readInt(param1);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         return param1 + 40;
      }
      
      public function release() : void
      {
      }
   }
}

