package net.msg.galaxyMap
{
   import flash.external.ExternalInterface;
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_MAPAREA extends MsgHead
   {
      
      public var RegionId:uint;
      
      public var GalaxyMapId:int;
      
      public var DataLen:int;
      
      public var Data:Array;
      
      public function MSG_RESP_MAPAREA()
      {
         var _loc2_:MSG_RESP_MAPAREA_TMP = null;
         this.Data = new Array(25);
         super();
         var _loc1_:int = 0;
         while(_loc1_ < 25)
         {
            _loc2_ = new MSG_RESP_MAPAREA_TMP();
            this.Data[_loc1_] = _loc2_;
            _loc1_++;
         }
         usSize = uint(uint(this.getLength()));
         usType = uint(uint(MsgTypes._MSG_RESP_MAPAREA));
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = uint(uint(_loc2_.readMsgSize(param1)));
         usType = uint(uint(_loc2_.readMsgType(param1)));
         this.RegionId = uint(uint(_loc2_.readUnsignShort(param1)));
         this.GalaxyMapId = int(int(_loc2_.readChar(param1)));
         this.DataLen = int(int(_loc2_.readUnsignChar(param1)));
         var _loc3_:int = 0;
         ExternalInterface.call("console.log","[#] INT (PL) => " + this.RegionId + ", " + this.GalaxyMapId);
         ExternalInterface.call("console.log","[#] INT (DataLen) => " + this.DataLen);
         while(_loc3_ < 25)
         {
            if(param1.length > param1.position)
            {
               this.Data[_loc3_].readBuf(param1);
            }
            _loc3_++;
         }
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         param1.position = 0;
         _loc2_.writeShort(param1,usSize);
         _loc2_.writeShort(param1,usType);
         _loc2_.writeUnsignShort(param1,this.RegionId);
         _loc2_.writeChar(param1,this.GalaxyMapId);
         _loc2_.writeUnsignChar(param1,this.DataLen);
         var _loc3_:int = 0;
         while(_loc3_ < 25)
         {
            this.Data[_loc3_].writeBuf(param1);
            _loc3_++;
         }
         _loc2_.PushByte(param1,usSize - param1.position);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 4;
         var _loc2_:int = 0;
         while(_loc2_ < 25)
         {
            param1 = int(this.Data[_loc2_].getLength(param1));
            _loc2_++;
         }
         return param1;
      }
      
      public function release() : void
      {
         var _loc1_:int = 25 - 1;
         while(_loc1_ >= 0)
         {
            this.Data[_loc1_].release();
            _loc1_--;
         }
         this.Data.splice(0);
         this.Data = null;
      }
   }
}

