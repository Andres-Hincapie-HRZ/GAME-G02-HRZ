package net.msg.sciencesystem
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_PROPSINFO extends MsgHead
   {
      
      public var DataLen:int;
      
      public const MAX_CONSORTIASTORAGE:int = 100;
      
      public const MAX_PRIVATESTORAGE:int = 150;
      
      public var Data:Array = new Array(this.MAX_PRIVATESTORAGE + this.MAX_CONSORTIASTORAGE);
      
      public function MSG_RESP_PROPSINFO()
      {
         super();
         usType = MsgTypes._MSG_RESP_PROPSINFO;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.DataLen = _loc2_.readInt(param1);
         var _loc3_:int = 0;
         while(_loc3_ < this.DataLen)
         {
            if(this.Data[_loc3_] == null)
            {
               this.Data[_loc3_] = new Props();
            }
            if(param1.length > param1.position)
            {
               this.Data[_loc3_].readBuf(param1);
            }
            _loc3_++;
         }
         _loc2_ = null;
      }
   }
}

