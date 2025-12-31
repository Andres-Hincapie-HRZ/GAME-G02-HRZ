package net.msg.commanderMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_COMMANDERCARDBRO extends MsgHead
   {
      
      public var Guid:int;
      
      public var SrcPropsId:int;
      
      public var ObjPropsId:int;
      
      public var CardLevel:int;
      
      public var Name:String = "";
      
      public function MSG_RESP_COMMANDERCARDBRO()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_COMMANDERCARDBRO;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.Guid = _loc2_.readInt(param1);
         this.SrcPropsId = _loc2_.readInt(param1);
         this.ObjPropsId = _loc2_.readInt(param1);
         this.CardLevel = _loc2_.readInt(param1);
         this.Name = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 16;
         return param1 + MsgTypes.MAX_NAME;
      }
      
      public function release() : void
      {
      }
   }
}

