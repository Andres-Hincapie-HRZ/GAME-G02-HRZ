package net.msg.ship
{
   import flash.external.ExternalInterface;
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   
   public class MSG_RESP_SHIPFIGHT
   {
      
      private var MAX_SHIPTEAMBODY:int = 9;
      
      private var MAX_MSG_PART:int = 7;
      
      public var SrcReduceSupply:int;
      
      public var ObjReduceSupply:int;
      
      public var SrcReduceStorage:int;
      
      public var ObjReduceStorage:int;
      
      public var SrcReduceHp:int;
      
      public var ObjReduceShield:Array = new Array(this.MAX_SHIPTEAMBODY);
      
      public var ObjReduceEndure:int;
      
      public var SrcReduceShipNum:uint;
      
      public var ObjReduceShipNum:Array = new Array(this.MAX_SHIPTEAMBODY);
      
      public var SrcPartId:Array = new Array(this.MAX_MSG_PART);
      
      public var SrcPartNum:Array = new Array(this.MAX_MSG_PART);
      
      public var SrcPartRate:Array = new Array(this.MAX_MSG_PART);
      
      public var ObjPartId:Array = new Array(this.MAX_MSG_PART);
      
      public var ObjPartNum:Array = new Array(this.MAX_MSG_PART);
      
      public var SrcSkill:int;
      
      public var ObjSkill:int;
      
      public var ObjBlast:int;
      
      public function MSG_RESP_SHIPFIGHT()
      {
         super();
         this.ObjBlast = 0;
         this.SrcSkill = 0;
         this.ObjSkill = 0;
         this.SrcReduceStorage = 0;
         this.ObjReduceStorage = 0;
         this.SrcReduceSupply = 0;
         this.ObjReduceSupply = 0;
         this.SrcReduceHp = 0;
         this.SrcReduceShipNum = 0;
         this.ObjReduceEndure = 0;
         var _loc1_:int = 0;
         while(_loc1_ < this.MAX_SHIPTEAMBODY)
         {
            this.ObjReduceShipNum[_loc1_] = 0;
            this.ObjReduceShield[_loc1_] = 0;
            _loc1_++;
         }
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.GetByte(param1,(4 - param1.position % 4) % 4);
         this.SrcReduceSupply = _loc2_.readInt(param1);
         this.ObjReduceSupply = _loc2_.readInt(param1);
         this.SrcReduceStorage = _loc2_.readInt(param1);
         this.ObjReduceStorage = _loc2_.readInt(param1);
         this.SrcReduceHp = _loc2_.readInt(param1);
         var _loc3_:int = 0;
         while(_loc3_ < this.MAX_SHIPTEAMBODY)
         {
            if(param1.length - param1.position >= 4)
            {
               this.ObjReduceShield[_loc3_] = _loc2_.readInt(param1);
               ExternalInterface.call("console.log","[#] OBJ REDUCE SHIELD: " + _loc3_ + ", " + this.ObjReduceShield[_loc3_]);
            }
            _loc3_++;
         }
         this.ObjReduceEndure = _loc2_.readInt(param1);
         this.SrcReduceShipNum = _loc2_.readUnsignShort(param1);
         var _loc4_:int = 0;
         while(_loc4_ < this.MAX_SHIPTEAMBODY)
         {
            if(param1.length - param1.position >= 2)
            {
               this.ObjReduceShipNum[_loc4_] = _loc2_.readUnsignShort(param1);
            }
            _loc4_++;
         }
         var _loc5_:int = 0;
         while(_loc5_ < this.MAX_MSG_PART)
         {
            if(param1.length - param1.position >= 2)
            {
               this.SrcPartId[_loc5_] = _loc2_.readShort(param1);
            }
            _loc5_++;
         }
         var _loc6_:int = 0;
         while(_loc6_ < this.MAX_MSG_PART)
         {
            if(param1.length - param1.position >= 1)
            {
               this.SrcPartNum[_loc6_] = _loc2_.readUnsignChar(param1);
            }
            _loc6_++;
         }
         var _loc7_:int = 0;
         while(_loc7_ < this.MAX_MSG_PART)
         {
            if(param1.length - param1.position >= 1)
            {
               this.SrcPartRate[_loc7_] = _loc2_.readUnsignChar(param1);
            }
            _loc7_++;
         }
         var _loc8_:int = 0;
         while(_loc8_ < this.MAX_MSG_PART)
         {
            if(param1.length - param1.position >= 2)
            {
               this.ObjPartId[_loc8_] = _loc2_.readShort(param1);
            }
            _loc8_++;
         }
         var _loc9_:int = 0;
         while(_loc9_ < this.MAX_MSG_PART)
         {
            if(param1.length - param1.position >= 1)
            {
               this.ObjPartNum[_loc9_] = _loc2_.readUnsignChar(param1);
            }
            _loc9_++;
         }
         this.SrcSkill = _loc2_.readUnsignChar(param1);
         this.ObjSkill = _loc2_.readUnsignChar(param1);
         this.ObjBlast = _loc2_.readChar(param1);
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.PushByte(param1,(4 - param1.position % 4) % 4);
         _loc2_.writeInt(param1,this.SrcReduceSupply);
         _loc2_.writeInt(param1,this.ObjReduceSupply);
         _loc2_.writeInt(param1,this.SrcReduceStorage);
         _loc2_.writeInt(param1,this.ObjReduceStorage);
         _loc2_.writeInt(param1,this.SrcReduceHp);
         var _loc3_:int = 0;
         while(_loc3_ < this.MAX_SHIPTEAMBODY)
         {
            _loc2_.writeInt(param1,this.ObjReduceShield[_loc3_]);
            _loc3_++;
         }
         _loc2_.writeInt(param1,this.ObjReduceEndure);
         _loc2_.writeUnsignShort(param1,this.SrcReduceShipNum);
         var _loc4_:int = 0;
         while(_loc4_ < this.MAX_SHIPTEAMBODY)
         {
            _loc2_.writeUnsignShort(param1,this.ObjReduceShipNum[_loc4_]);
            _loc4_++;
         }
         var _loc5_:int = 0;
         while(_loc5_ < this.MAX_MSG_PART)
         {
            _loc2_.writeShort(param1,this.SrcPartId[_loc5_]);
            _loc5_++;
         }
         var _loc6_:int = 0;
         while(_loc6_ < this.MAX_MSG_PART)
         {
            _loc2_.writeUnsignChar(param1,this.SrcPartNum[_loc6_]);
            _loc6_++;
         }
         var _loc7_:int = 0;
         while(_loc7_ < this.MAX_MSG_PART)
         {
            _loc2_.writeUnsignChar(param1,this.SrcPartRate[_loc7_]);
            _loc7_++;
         }
         var _loc8_:int = 0;
         while(_loc8_ < this.MAX_MSG_PART)
         {
            _loc2_.writeShort(param1,this.ObjPartId[_loc8_]);
            _loc8_++;
         }
         var _loc9_:int = 0;
         while(_loc9_ < this.MAX_MSG_PART)
         {
            _loc2_.writeUnsignChar(param1,this.ObjPartNum[_loc9_]);
            _loc9_++;
         }
         _loc2_.writeUnsignChar(param1,this.SrcSkill);
         _loc2_.writeUnsignChar(param1,this.ObjSkill);
         _loc2_.writeChar(param1,this.ObjBlast);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 += (4 - param1 % 4) % 4;
         param1 += 20;
         param1 += this.MAX_SHIPTEAMBODY * 4;
         param1 += 6;
         param1 += this.MAX_SHIPTEAMBODY * 2;
         param1 += this.MAX_MSG_PART * 2;
         param1 += this.MAX_MSG_PART * 1;
         param1 += this.MAX_MSG_PART * 1;
         param1 += (2 - param1 % 2) % 2;
         param1 += this.MAX_MSG_PART * 2;
         param1 += this.MAX_MSG_PART * 1;
         return int(param1 + 3);
      }
      
      public function release() : void
      {
         this.ObjReduceShield.splice(0);
         this.ObjReduceShield = null;
         this.ObjReduceShipNum.splice(0);
         this.ObjReduceShipNum = null;
         this.SrcPartId.splice(0);
         this.SrcPartId = null;
         this.SrcPartNum.splice(0);
         this.SrcPartNum = null;
         this.SrcPartRate.splice(0);
         this.SrcPartRate = null;
         this.ObjPartId.splice(0);
         this.ObjPartId = null;
         this.ObjPartNum.splice(0);
         this.ObjPartNum = null;
      }
   }
}

