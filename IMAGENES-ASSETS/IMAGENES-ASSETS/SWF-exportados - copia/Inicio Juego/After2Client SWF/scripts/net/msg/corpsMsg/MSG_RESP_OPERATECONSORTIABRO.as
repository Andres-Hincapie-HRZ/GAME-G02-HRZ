package net.msg.corpsMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_OPERATECONSORTIABRO extends MsgHead
   {
      
      public var ConsortiaId:int;
      
      public var Type:int;
      
      public var PropsCorpsPack:int;
      
      public var Job:int;
      
      public var UnionLevel:int;
      
      public var ShopLevel:int;
      
      public var Reserve2:int;
      
      public var NeedUnionValue:int;
      
      public var NeedShopValue:int;
      
      public function MSG_RESP_OPERATECONSORTIABRO()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_OPERATECONSORTIABRO;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.ConsortiaId = _loc2_.readInt(param1);
         this.Type = _loc2_.readInt(param1);
         this.PropsCorpsPack = _loc2_.readInt(param1);
         this.Job = _loc2_.readChar(param1);
         this.UnionLevel = _loc2_.readChar(param1);
         this.ShopLevel = _loc2_.readChar(param1);
         this.Reserve2 = _loc2_.readChar(param1);
         this.NeedUnionValue = _loc2_.readInt(param1);
         this.NeedShopValue = _loc2_.readInt(param1);
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         param1.position = 0;
         _loc2_.writeShort(param1,usSize);
         _loc2_.writeShort(param1,usType);
         _loc2_.writeInt(param1,this.ConsortiaId);
         _loc2_.writeInt(param1,this.Type);
         _loc2_.writeInt(param1,this.PropsCorpsPack);
         _loc2_.writeChar(param1,this.Job);
         _loc2_.writeChar(param1,this.UnionLevel);
         _loc2_.writeChar(param1,this.ShopLevel);
         _loc2_.writeChar(param1,this.Reserve2);
         _loc2_.writeInt(param1,this.NeedUnionValue);
         _loc2_.writeInt(param1,this.NeedShopValue);
         _loc2_.PushByte(param1,usSize - param1.position);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         return param1 + 24;
      }
      
      public function release() : void
      {
      }
   }
}

