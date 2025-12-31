package net.msg.shipmodelMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_SHIPBODYINFO extends MsgHead
   {
      
      public var BodyNum:int;
      
      public var PartNum:int;
      
      public var BodyId:Array = new Array(200);
      
      public var PartId:Array = new Array(300);
      
      public function MSG_RESP_SHIPBODYINFO()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_SHIPBODYINFO;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.BodyNum = _loc2_.readShort(param1);
         this.PartNum = _loc2_.readShort(param1);
         var _loc3_:int = 0;
         while(_loc3_ < 200)
         {
            if(param1.length - param1.position >= 2)
            {
               this.BodyId[_loc3_] = _loc2_.readShort(param1);
            }
            _loc3_++;
         }
         var _loc4_:int = 0;
         while(_loc4_ < 300)
         {
            if(param1.length - param1.position >= 2)
            {
               this.PartId[_loc4_] = _loc2_.readShort(param1);
            }
            _loc4_++;
         }
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 4;
         param1 += 200 * 2;
         return param1 + 300 * 2;
      }
      
      public function release() : void
      {
         this.BodyId.splice(0);
         this.BodyId = null;
         this.PartId.splice(0);
         this.PartId = null;
      }
   }
}

