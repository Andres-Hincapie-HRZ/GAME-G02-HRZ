package net.msg.field
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   
   public class MSG_RESP_FRIENDFIELDSTATUS_TEMP
   {
      
      public var UserId:Number;
      
      public var Guid:int;
      
      public var GalaxyMapId:int;
      
      public var GalaxyId:int;
      
      public var Reserve:int;
      
      public var HelpFlag:int;
      
      public var ThieveFlag:int;
      
      public function MSG_RESP_FRIENDFIELDSTATUS_TEMP()
      {
         super();
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.GetByte(param1,(8 - param1.position % 8) % 8);
         this.UserId = _loc2_.readInt64(param1);
         this.Guid = _loc2_.readInt(param1);
         this.GalaxyMapId = _loc2_.readInt(param1);
         this.GalaxyId = _loc2_.readInt(param1);
         this.Reserve = _loc2_.readShort(param1);
         this.HelpFlag = _loc2_.readChar(param1);
         this.ThieveFlag = _loc2_.readChar(param1);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 += (8 - param1 % 8) % 8;
         return param1 + 24;
      }
      
      public function release() : void
      {
      }
   }
}

