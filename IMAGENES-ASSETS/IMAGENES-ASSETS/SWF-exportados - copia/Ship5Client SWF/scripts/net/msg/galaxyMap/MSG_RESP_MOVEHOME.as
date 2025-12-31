package net.msg.galaxyMap
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_MOVEHOME extends MsgHead
   {
      
      public var ConsortiaName:String = "";
      
      public var ToGalaxyMapId:int;
      
      public var ToGalaxyId:int;
      
      public var ErrorCode:int;
      
      public var PropsId:int;
      
      public var LockFlag:int;
      
      public function MSG_RESP_MOVEHOME()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_MOVEHOME;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.ConsortiaName = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.ToGalaxyMapId = _loc2_.readInt(param1);
         this.ToGalaxyId = _loc2_.readInt(param1);
         this.ErrorCode = _loc2_.readInt(param1);
         this.PropsId = _loc2_.readInt(param1);
         this.LockFlag = _loc2_.readInt(param1);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += MsgTypes.MAX_NAME;
         param1 += (4 - param1 % 4) % 4;
         return param1 + 20;
      }
      
      public function release() : void
      {
      }
   }
}

