package net.msg.fightMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_FORTRESSSECTION extends MsgHead
   {
      
      public var GalaxyId:int;
      
      public var SrcID:int;
      
      public var GalaxyMapId:int;
      
      public var BoutId:int;
      
      public var BuildType:int;
      
      public var Reserve1:int;
      
      public var Reserve2:int;
      
      public var DataLen:int;
      
      public var ShipFight:Array;
      
      public function MSG_RESP_FORTRESSSECTION()
      {
         var _loc2_:MSG_RESP_FORTRESSFIGHT = null;
         this.ShipFight = new Array(25);
         super();
         var _loc1_:int = 0;
         while(_loc1_ < 25)
         {
            _loc2_ = new MSG_RESP_FORTRESSFIGHT();
            this.ShipFight[_loc1_] = _loc2_;
            _loc1_++;
         }
         this.GalaxyMapId = -1;
         this.GalaxyId = -1;
         this.BoutId = -1;
         this.SrcID = -1;
         this.BuildType = -1;
         this.Reserve1 = 0;
         this.Reserve2 = 0;
         this.DataLen = 0;
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_FIGHTFORTRESSSECTION;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.GalaxyId = _loc2_.readInt(param1);
         this.SrcID = _loc2_.readInt(param1);
         this.GalaxyMapId = _loc2_.readShort(param1);
         this.BoutId = _loc2_.readShort(param1);
         this.BuildType = _loc2_.readChar(param1);
         this.Reserve1 = _loc2_.readUnsignChar(param1);
         this.Reserve2 = _loc2_.readUnsignChar(param1);
         this.DataLen = _loc2_.readChar(param1);
         var _loc3_:int = 0;
         while(_loc3_ < 25)
         {
            if(param1.length > param1.position)
            {
               this.ShipFight[_loc3_].readBuf(param1);
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
         _loc2_.writeInt(param1,this.GalaxyId);
         _loc2_.writeInt(param1,this.SrcID);
         _loc2_.writeShort(param1,this.GalaxyMapId);
         _loc2_.writeShort(param1,this.BoutId);
         _loc2_.writeChar(param1,this.BuildType);
         _loc2_.writeUnsignChar(param1,this.Reserve1);
         _loc2_.writeUnsignChar(param1,this.Reserve2);
         _loc2_.writeChar(param1,this.DataLen);
         var _loc3_:int = 0;
         while(_loc3_ < 25)
         {
            this.ShipFight[_loc3_].writeBuf(param1);
            _loc3_++;
         }
         _loc2_.PushByte(param1,usSize - param1.position);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 16;
         var _loc2_:int = 0;
         while(_loc2_ < 25)
         {
            param1 = int(this.ShipFight[_loc2_].getLength(param1));
            _loc2_++;
         }
         return param1;
      }
      
      public function release() : void
      {
         var _loc1_:int = 25 - 1;
         while(_loc1_ >= 0)
         {
            this.ShipFight[_loc1_].release();
            _loc1_--;
         }
         this.ShipFight.splice(0);
         this.ShipFight = null;
      }
   }
}

