package net.msg.galaxyMap
{
   import flash.external.ExternalInterface;
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_REQUEST_GALAXY extends MsgHead
   {
      
      public var SeqId:int;
      
      public var Guid:int;
      
      public var GalaxyMapId:int;
      
      public var GalaxyId:int;
      
      public function MSG_REQUEST_GALAXY()
      {
         super();
         usSize = uint(this.getLength());
         usType = uint(MsgTypes._MSG_REQUEST_GALAXY);
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = uint(_loc2_.readMsgSize(param1));
         usType = uint(_loc2_.readMsgType(param1));
         this.SeqId = _loc2_.readInt(param1);
         this.Guid = _loc2_.readInt(param1);
         this.GalaxyMapId = _loc2_.readInt(param1);
         this.GalaxyId = _loc2_.readInt(param1);
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         param1.position = 0;
         _loc2_.writeShort(param1,usSize);
         _loc2_.writeShort(param1,usType);
         _loc2_.writeInt(param1,this.SeqId);
         _loc2_.writeInt(param1,this.Guid);
         _loc2_.writeInt(param1,this.GalaxyMapId);
         _loc2_.writeInt(param1,this.GalaxyId);
         _loc2_.PushByte(param1,usSize - param1.position);
         _loc2_ = null;
         ExternalInterface.call("console.log","[#] Guid => " + this.Guid);
         ExternalInterface.call("console.log","[#] RG => " + this.GalaxyId);
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         return param1 + 16;
      }
      
      public function release() : void
      {
      }
   }
}

