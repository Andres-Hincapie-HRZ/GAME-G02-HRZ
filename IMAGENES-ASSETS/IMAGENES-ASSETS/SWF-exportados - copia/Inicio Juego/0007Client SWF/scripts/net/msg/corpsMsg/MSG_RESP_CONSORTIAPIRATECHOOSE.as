package net.msg.corpsMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_CONSORTIAPIRATECHOOSE extends MsgHead
   {
      
      public var ErrorCode:int;
      
      public var ObjGuid:int;
      
      public var ObjName:String = "";
      
      public var GalaxyId:int;
      
      public var Assault:int;
      
      public var LevelId:int;
      
      public function MSG_RESP_CONSORTIAPIRATECHOOSE()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_CONSORTIAPIRATECHOOSE;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.ErrorCode = _loc2_.readInt(param1);
         this.ObjGuid = _loc2_.readInt(param1);
         this.ObjName = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.GalaxyId = _loc2_.readInt(param1);
         this.Assault = _loc2_.readInt(param1);
         this.LevelId = _loc2_.readInt(param1);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 8;
         param1 += MsgTypes.MAX_NAME;
         param1 += (4 - param1 % 4) % 4;
         return param1 + 12;
      }
      
      public function release() : void
      {
      }
   }
}

