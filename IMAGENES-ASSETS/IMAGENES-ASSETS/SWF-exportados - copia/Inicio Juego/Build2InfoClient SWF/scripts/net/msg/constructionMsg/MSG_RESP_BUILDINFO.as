package net.msg.constructionMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_BUILDINFO extends MsgHead
   {
      
      public var GalaxyMapId:int;
      
      public var GalaxyId:int;
      
      public var ConsortiaLeader:int;
      
      public var ViewFlag:int;
      
      public var StarType:int;
      
      public var DataLen:int;
      
      public var Data:Array;
      
      public function MSG_RESP_BUILDINFO()
      {
         var _loc2_:MSG_RESP_BUILDINFO_TEMP = null;
         this.Data = new Array(MsgTypes.MAX_BUILDING);
         super();
         var _loc1_:int = 0;
         while(_loc1_ < MsgTypes.MAX_BUILDING)
         {
            _loc2_ = new MSG_RESP_BUILDINFO_TEMP();
            this.Data[_loc1_] = _loc2_;
            _loc1_++;
         }
         usSize = uint(uint(uint(uint(uint(this.getLength())))));
         usType = uint(uint(uint(uint(uint(MsgTypes._MSG_RESP_BUILDINFO)))));
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = uint(uint(uint(uint(uint(_loc2_.readMsgSize(param1))))));
         usType = uint(uint(uint(uint(uint(_loc2_.readMsgType(param1))))));
         this.GalaxyMapId = int(int(int(int(int(_loc2_.readInt(param1))))));
         this.GalaxyId = int(int(int(int(int(_loc2_.readInt(param1))))));
         this.ConsortiaLeader = int(int(int(int(int(_loc2_.readShort(param1))))));
         this.ViewFlag = int(int(int(int(int(_loc2_.readChar(param1))))));
         this.StarType = int(int(int(int(int(_loc2_.readChar(param1))))));
         this.DataLen = int(int(int(int(int(_loc2_.readInt(param1))))));
         var _loc3_:int = 0;
         while(_loc3_ < MsgTypes.MAX_BUILDING)
         {
            if(param1.length > param1.position)
            {
               this.Data[_loc3_].readBuf(param1);
            }
            _loc3_++;
         }
         _loc2_ = null;
         this.ViewFlag = 1;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         param1.position = 0;
         _loc2_.writeShort(param1,usSize);
         _loc2_.writeShort(param1,usType);
         _loc2_.writeInt(param1,this.GalaxyMapId);
         _loc2_.writeInt(param1,this.GalaxyId);
         _loc2_.writeShort(param1,this.ConsortiaLeader);
         _loc2_.writeChar(param1,this.ViewFlag);
         _loc2_.writeChar(param1,this.StarType);
         _loc2_.writeInt(param1,this.DataLen);
         var _loc3_:int = 0;
         while(_loc3_ < MsgTypes.MAX_BUILDING)
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
         return param1 + 16;
      }
      
      public function release() : void
      {
         var _loc1_:int = MsgTypes.MAX_BUILDING - 1;
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

