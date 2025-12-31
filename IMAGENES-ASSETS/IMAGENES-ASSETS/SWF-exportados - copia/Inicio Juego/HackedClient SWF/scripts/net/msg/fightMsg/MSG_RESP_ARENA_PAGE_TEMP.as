package net.msg.fightMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgTypes;
   
   public class MSG_RESP_ARENA_PAGE_TEMP
   {
      
      public var SrcUserId:Number;
      
      public var ObjUserId:Number;
      
      public var SrcName:String = "";
      
      public var ObjName:String = "";
      
      public var SrcGuid:int;
      
      public var ObjGuid:int;
      
      public var SrcShipnum:uint;
      
      public var ObjShipnum:uint;
      
      public var PassKey:int;
      
      public function MSG_RESP_ARENA_PAGE_TEMP()
      {
         super();
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.GetByte(param1,(8 - param1.position % 8) % 8);
         this.SrcUserId = _loc2_.readInt64(param1);
         this.ObjUserId = _loc2_.readInt64(param1);
         this.SrcName = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.ObjName = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.SrcGuid = _loc2_.readInt(param1);
         this.ObjGuid = _loc2_.readInt(param1);
         this.SrcShipnum = _loc2_.readUnsignInt(param1);
         this.ObjShipnum = _loc2_.readUnsignInt(param1);
         this.PassKey = _loc2_.readChar(param1);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 += (8 - param1 % 8) % 8;
         param1 += 16;
         param1 += MsgTypes.MAX_NAME;
         param1 += MsgTypes.MAX_NAME;
         param1 += (4 - param1 % 4) % 4;
         return param1 + 13;
      }
      
      public function release() : void
      {
      }
   }
}

