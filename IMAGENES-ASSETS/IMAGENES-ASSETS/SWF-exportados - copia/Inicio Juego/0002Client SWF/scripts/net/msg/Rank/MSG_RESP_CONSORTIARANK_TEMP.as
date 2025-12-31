package net.msg.Rank
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgTypes;
   
   public class MSG_RESP_CONSORTIARANK_TEMP
   {
      
      public var Name:String = "";
      
      public var ConsortiaId:int;
      
      public var RankId:int;
      
      public var ThrowWealth:int;
      
      public var HoldGalaxyArea:Array = new Array(MsgTypes.MAX_CONSORTIAFIELD);
      
      public var Reserve1:int;
      
      public var HeadId:int;
      
      public var Level:int;
      
      public var HoldGalaxy:int;
      
      public var Member:int;
      
      public var MaxMember:int;
      
      public var Reserve2:int;
      
      public function MSG_RESP_CONSORTIARANK_TEMP()
      {
         super();
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.GetByte(param1,(4 - param1.position % 4) % 4);
         this.Name = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.ConsortiaId = _loc2_.readInt(param1);
         this.RankId = _loc2_.readInt(param1);
         this.ThrowWealth = _loc2_.readInt(param1);
         var _loc3_:int = 0;
         while(_loc3_ < MsgTypes.MAX_CONSORTIAFIELD)
         {
            if(param1.length - param1.position >= 4)
            {
               this.HoldGalaxyArea[_loc3_] = _loc2_.readInt(param1);
            }
            _loc3_++;
         }
         this.Reserve1 = _loc2_.readShort(param1);
         this.HeadId = _loc2_.readUnsignChar(param1);
         this.Level = _loc2_.readUnsignChar(param1);
         this.HoldGalaxy = _loc2_.readUnsignChar(param1);
         this.Member = _loc2_.readUnsignChar(param1);
         this.MaxMember = _loc2_.readUnsignChar(param1);
         this.Reserve2 = _loc2_.readChar(param1);
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.PushByte(param1,(4 - param1.position % 4) % 4);
         _loc2_.writeUtf8Str(param1,this.Name,MsgTypes.MAX_NAME);
         _loc2_.writeInt(param1,this.ConsortiaId);
         _loc2_.writeInt(param1,this.RankId);
         _loc2_.writeInt(param1,this.ThrowWealth);
         var _loc3_:int = 0;
         while(_loc3_ < MsgTypes.MAX_CONSORTIAFIELD)
         {
            _loc2_.writeInt(param1,this.HoldGalaxyArea[_loc3_]);
            _loc3_++;
         }
         _loc2_.writeShort(param1,this.Reserve1);
         _loc2_.writeUnsignChar(param1,this.HeadId);
         _loc2_.writeUnsignChar(param1,this.Level);
         _loc2_.writeUnsignChar(param1,this.HoldGalaxy);
         _loc2_.writeUnsignChar(param1,this.Member);
         _loc2_.writeUnsignChar(param1,this.MaxMember);
         _loc2_.writeChar(param1,this.Reserve2);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 += (4 - param1 % 4) % 4;
         param1 += MsgTypes.MAX_NAME;
         param1 += (4 - param1 % 4) % 4;
         param1 += 12;
         param1 += MsgTypes.MAX_CONSORTIAFIELD * 4;
         return param1 + 8;
      }
      
      public function release() : void
      {
         this.HoldGalaxyArea.splice(0);
         this.HoldGalaxyArea = null;
      }
   }
}

