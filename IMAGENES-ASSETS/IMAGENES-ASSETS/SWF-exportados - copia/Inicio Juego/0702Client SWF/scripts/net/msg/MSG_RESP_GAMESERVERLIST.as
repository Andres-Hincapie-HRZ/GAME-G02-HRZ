package net.msg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_GAMESERVERLIST extends MsgHead
   {
      
      public var Guid:int;
      
      public var DataLen:int;
      
      public var Data:Array = new Array(MsgTypes.MAX_GAMESERVERLIST);
      
      public var RegisterNum:Array = new Array(MsgTypes.MAX_GAMESERVERLIST);
      
      public var OnlineNum:Array = new Array(MsgTypes.MAX_GAMESERVERLIST);
      
      public function MSG_RESP_GAMESERVERLIST()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_GAMESERVERLIST;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.Guid = _loc2_.readInt(param1);
         this.DataLen = _loc2_.readInt(param1);
         var _loc3_:int = 0;
         while(_loc3_ < MsgTypes.MAX_GAMESERVERLIST)
         {
            if(param1.length - param1.position >= 1)
            {
               this.Data[_loc3_] = _loc2_.readUnsignChar(param1);
            }
            _loc3_++;
         }
         var _loc4_:int = 0;
         while(_loc4_ < MsgTypes.MAX_GAMESERVERLIST)
         {
            if(param1.length - param1.position >= 4)
            {
               this.RegisterNum[_loc4_] = _loc2_.readInt(param1);
            }
            _loc4_++;
         }
         var _loc5_:int = 0;
         while(_loc5_ < MsgTypes.MAX_GAMESERVERLIST)
         {
            if(param1.length - param1.position >= 4)
            {
               this.OnlineNum[_loc5_] = _loc2_.readInt(param1);
            }
            _loc5_++;
         }
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 8;
         param1 += MsgTypes.MAX_GAMESERVERLIST * 1;
         param1 += (4 - param1 % 4) % 4;
         param1 += MsgTypes.MAX_GAMESERVERLIST * 4;
         return param1 + MsgTypes.MAX_GAMESERVERLIST * 4;
      }
      
      public function release() : void
      {
         this.Data.splice(0);
         this.Data = null;
         this.RegisterNum.splice(0);
         this.RegisterNum = null;
         this.OnlineNum.splice(0);
         this.OnlineNum = null;
      }
   }
}

