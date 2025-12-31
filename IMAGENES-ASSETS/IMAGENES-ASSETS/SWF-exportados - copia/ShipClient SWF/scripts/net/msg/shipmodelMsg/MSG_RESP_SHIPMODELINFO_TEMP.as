package net.msg.shipmodelMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgTypes;
   
   public class MSG_RESP_SHIPMODELINFO_TEMP
   {
      
      public var ShipName:String = "";
      
      public var PartNum:int;
      
      public var PubFlag:int;
      
      public var BodyId:int;
      
      public var PartId:Array = new Array(MsgTypes.MAX_SHIPPART);
      
      public var ShipModelId:int;
      
      public function MSG_RESP_SHIPMODELINFO_TEMP()
      {
         super();
         this.PubFlag = 0;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.GetByte(param1,(4 - param1.position % 4) % 4);
         this.ShipName = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.PartNum = _loc2_.readChar(param1);
         this.PubFlag = _loc2_.readChar(param1);
         this.BodyId = _loc2_.readShort(param1);
         var _loc3_:int = 0;
         while(_loc3_ < MsgTypes.MAX_SHIPPART)
         {
            if(param1.length - param1.position >= 2)
            {
               this.PartId[_loc3_] = _loc2_.readShort(param1);
            }
            _loc3_++;
         }
         this.ShipModelId = _loc2_.readInt(param1);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 += (4 - param1 % 4) % 4;
         param1 += MsgTypes.MAX_NAME;
         param1 += 2;
         param1 += (2 - param1 % 2) % 2;
         param1 += 2;
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

