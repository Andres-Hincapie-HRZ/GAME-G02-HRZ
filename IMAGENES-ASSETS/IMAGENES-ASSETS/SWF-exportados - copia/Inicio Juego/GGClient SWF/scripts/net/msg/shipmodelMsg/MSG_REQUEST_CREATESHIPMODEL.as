package net.msg.shipmodelMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_REQUEST_CREATESHIPMODEL extends MsgHead
   {
      
      public var SeqId:int;
      
      public var Guid:int;
      
      public var ShipName:String = "";
      
      public var BodyId:int;
      
      public var PartNum:int;
      
      public var PartId:Array = new Array(MsgTypes.MAX_SHIPPART);
      
      public function MSG_REQUEST_CREATESHIPMODEL()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_REQUEST_CREATESHIPMODEL;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         param1.position = 0;
         _loc2_.writeShort(param1,usSize);
         _loc2_.writeShort(param1,usType);
         _loc2_.writeInt(param1,this.SeqId);
         _loc2_.writeInt(param1,this.Guid);
         _loc2_.writeUtf8Str(param1,this.ShipName,MsgTypes.MAX_NAME);
         _loc2_.writeShort(param1,this.BodyId);
         _loc2_.writeShort(param1,this.PartNum);
         var _loc3_:int = 0;
         while(_loc3_ < MsgTypes.MAX_SHIPPART)
         {
            _loc2_.writeShort(param1,this.PartId[_loc3_]);
            _loc3_++;
         }
         _loc2_.PushByte(param1,usSize - param1.position);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 8;
         param1 += MsgTypes.MAX_NAME;
         param1 += (2 - param1 % 2) % 2;
         param1 += 4;
         return param1 + MsgTypes.MAX_SHIPPART * 2;
      }
      
      public function release() : void
      {
         this.PartId.splice(0);
         this.PartId = null;
      }
   }
}

