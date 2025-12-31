package net.msg.fightMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgTypes;
   
   public class MSG_RESP_FORTRESSFIGHT
   {
      
      public var ObjShipTeamId:int;
      
      public var ObjReduceSupply:uint;
      
      public var ObjReduceStorage:uint;
      
      public var ObjReduceHP:Array = new Array(MsgTypes.MAX_SHIPTEAMBODY);
      
      public var ObjReduceShipNum:Array = new Array(MsgTypes.MAX_SHIPTEAMBODY);
      
      public var DelFlag:int;
      
      public var reserve:int;
      
      public function MSG_RESP_FORTRESSFIGHT()
      {
         super();
         this.ObjShipTeamId = -1;
         this.ObjReduceStorage = 0;
         this.ObjReduceSupply = 0;
         this.DelFlag = 0;
         this.reserve = 0;
         var _loc1_:int = 0;
         while(_loc1_ < MsgTypes.MAX_SHIPTEAMBODY)
         {
            this.ObjReduceShipNum[_loc1_] = 0;
            this.ObjReduceHP[_loc1_] = 0;
            _loc1_++;
         }
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.GetByte(param1,(4 - param1.position % 4) % 4);
         this.ObjShipTeamId = _loc2_.readInt(param1);
         this.ObjReduceSupply = _loc2_.readUnsignInt(param1);
         this.ObjReduceStorage = _loc2_.readUnsignInt(param1);
         var _loc3_:int = 0;
         while(_loc3_ < MsgTypes.MAX_SHIPTEAMBODY)
         {
            if(param1.length - param1.position >= 4)
            {
               this.ObjReduceHP[_loc3_] = _loc2_.readInt(param1);
            }
            _loc3_++;
         }
         var _loc4_:int = 0;
         while(_loc4_ < MsgTypes.MAX_SHIPTEAMBODY)
         {
            if(param1.length - param1.position >= 2)
            {
               this.ObjReduceShipNum[_loc4_] = _loc2_.readUnsignShort(param1);
            }
            _loc4_++;
         }
         this.DelFlag = _loc2_.readChar(param1);
         this.reserve = _loc2_.readChar(param1);
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.PushByte(param1,(4 - param1.position % 4) % 4);
         _loc2_.writeInt(param1,this.ObjShipTeamId);
         _loc2_.writeUnsignInt(param1,this.ObjReduceSupply);
         _loc2_.writeUnsignInt(param1,this.ObjReduceStorage);
         var _loc3_:int = 0;
         while(_loc3_ < MsgTypes.MAX_SHIPTEAMBODY)
         {
            _loc2_.writeInt(param1,this.ObjReduceHP[_loc3_]);
            _loc3_++;
         }
         var _loc4_:int = 0;
         while(_loc4_ < MsgTypes.MAX_SHIPTEAMBODY)
         {
            _loc2_.writeUnsignShort(param1,this.ObjReduceShipNum[_loc4_]);
            _loc4_++;
         }
         _loc2_.writeChar(param1,this.DelFlag);
         _loc2_.writeChar(param1,this.reserve);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 += (4 - param1 % 4) % 4;
         param1 += 12;
         param1 += MsgTypes.MAX_SHIPTEAMBODY * 4;
         param1 += MsgTypes.MAX_SHIPTEAMBODY * 2;
         return param1 + 2;
      }
      
      public function release() : void
      {
         this.ObjReduceHP.splice(0);
         this.ObjReduceHP = null;
         this.ObjReduceShipNum.splice(0);
         this.ObjReduceShipNum = null;
      }
   }
}

