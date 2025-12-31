package net.msg.shipmodelMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_CREATESHIPMODEL extends MsgHead
   {
      
      public var ShipModelId:int;
      
      public var ShipName:String = "";
      
      public var BodyId:int;
      
      public var PartNum:int;
      
      public var PartId:Array = new Array(MsgTypes.MAX_SHIPPART);
      
      public var NeedMoney:int;
      
      public function MSG_RESP_CREATESHIPMODEL()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_CREATESHIPMODEL;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.ShipModelId = _loc2_.readInt(param1);
         this.ShipName = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.BodyId = _loc2_.readShort(param1);
         this.PartNum = _loc2_.readShort(param1);
         var _loc3_:int = 0;
         while(_loc3_ < MsgTypes.MAX_SHIPPART)
         {
            if(param1.length - param1.position >= 2)
            {
               this.PartId[_loc3_] = _loc2_.readShort(param1);
            }
            _loc3_++;
         }
         this.NeedMoney = _loc2_.readInt(param1);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 4;
         param1 += MsgTypes.MAX_NAME;
         param1 += (2 - param1 % 2) % 2;
         param1 += 4;
         param1 += MsgTypes.MAX_SHIPPART * 2;
         param1 += (4 - param1 % 4) % 4;
         return param1 + 4;
      }
      
      public function release() : void
      {
         this.PartId.splice(0);
         this.PartId = null;
      }
   }
}

