package net.msg.field
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   
   public class MSG_RESP_FIELDRESOURCE_TEMP
   {
      
      public var SpareTime:int;
      
      public var Guid:int;
      
      public var GalaxyId:int;
      
      public var Num:int;
      
      public var ResourceId:int;
      
      public var Status:int;
      
      public var ThieveCount:int;
      
      public var ThieveFlag:int;
      
      public function MSG_RESP_FIELDRESOURCE_TEMP()
      {
         super();
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.GetByte(param1,(4 - param1.position % 4) % 4);
         this.SpareTime = _loc2_.readInt(param1);
         this.Guid = _loc2_.readInt(param1);
         this.GalaxyId = _loc2_.readInt(param1);
         this.Num = _loc2_.readInt(param1);
         this.ResourceId = _loc2_.readChar(param1);
         this.Status = _loc2_.readChar(param1);
         this.ThieveCount = _loc2_.readChar(param1);
         this.ThieveFlag = _loc2_.readChar(param1);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 += (4 - param1 % 4) % 4;
         return param1 + 20;
      }
      
      public function release() : void
      {
      }
   }
}

