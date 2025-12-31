package net.msg.Compose
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_COMMANDERPROPERTYSTONE extends MsgHead
   {
      
      public var Type:int;
      
      public var LockFlag:int;
      
      public var ObjStoneId:int;
      
      public var SrcStoneId1:int;
      
      public var SrcStoneId2:int;
      
      public var SrcStoneId3:int;
      
      public var BroFlag:int;
      
      public var Guid:int;
      
      public var Name:String = "";
      
      public function MSG_RESP_COMMANDERPROPERTYSTONE()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_COMMANDERPROPERTYSTONE;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.Type = _loc2_.readInt(param1);
         this.LockFlag = _loc2_.readInt(param1);
         this.ObjStoneId = _loc2_.readInt(param1);
         this.SrcStoneId1 = _loc2_.readInt(param1);
         this.SrcStoneId2 = _loc2_.readInt(param1);
         this.SrcStoneId3 = _loc2_.readInt(param1);
         this.BroFlag = _loc2_.readInt(param1);
         this.Guid = _loc2_.readInt(param1);
         this.Name = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 32;
         return param1 + MsgTypes.MAX_NAME;
      }
      
      public function release() : void
      {
      }
   }
}

