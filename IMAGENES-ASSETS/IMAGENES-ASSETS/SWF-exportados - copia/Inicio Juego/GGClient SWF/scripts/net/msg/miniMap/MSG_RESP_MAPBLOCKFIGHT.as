package net.msg.miniMap
{
   import flash.external.ExternalInterface;
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_MAPBLOCKFIGHT extends MsgHead
   {
      
      public var BlockId:int;
      
      public var GalaxyMapId:int;
      
      public var DataLen:int;
      
      public var Data:Array = new Array(250);
      
      public function MSG_RESP_MAPBLOCKFIGHT()
      {
         super();
         usSize = uint(this.getLength());
         usType = uint(MsgTypes._MSG_RESP_MAPBLOCKFIGHT);
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = uint(_loc2_.readMsgSize(param1));
         usType = uint(_loc2_.readMsgType(param1));
         this.BlockId = int(_loc2_.readInt(param1));
         this.GalaxyMapId = int(_loc2_.readShort(param1));
         this.DataLen = int(_loc2_.readShort(param1));
         ExternalInterface.call("console.log","[#] ================================================");
         ExternalInterface.call("console.log","[#] BlockId => " + this.BlockId + ", GalaxyMapId => " + this.GalaxyMapId + ", DataLen => " + this.DataLen);
         var _loc3_:int = 0;
         while(_loc3_ < 250)
         {
            if(param1.length - param1.position >= 4)
            {
               this.Data[_loc3_] = _loc2_.readInt(param1);
            }
            _loc3_++;
         }
         ExternalInterface.call("console.log","[#] DataLength = " + this.Data.length + ", Data = {" + this.Data + "}");
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         param1.position = 0;
         _loc2_.writeShort(param1,usSize);
         _loc2_.writeShort(param1,usType);
         _loc2_.writeInt(param1,this.BlockId);
         _loc2_.writeShort(param1,this.GalaxyMapId);
         _loc2_.writeShort(param1,this.DataLen);
         var _loc3_:int = 0;
         while(_loc3_ < 250)
         {
            _loc2_.writeInt(param1,this.Data[_loc3_]);
            _loc3_++;
         }
         _loc2_.PushByte(param1,usSize - param1.position);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 8;
         param1 = (param1 + (4 - param1)) % 4 % 4;
         return param1 + 250 * 4;
      }
      
      public function release() : void
      {
         this.Data.splice(0);
         this.Data = null;
      }
   }
}

