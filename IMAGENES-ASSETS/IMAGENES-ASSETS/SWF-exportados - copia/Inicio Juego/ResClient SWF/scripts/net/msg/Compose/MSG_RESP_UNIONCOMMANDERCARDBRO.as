package net.msg.Compose
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_UNIONCOMMANDERCARDBRO extends MsgHead
   {
      
      public var Guid:int;
      
      public var UserId:Number;
      
      public var Name:String = "";
      
      public var SkillId:int;
      
      public var CardLevel:int;
      
      public var SuccessFlag:int;
      
      public function MSG_RESP_UNIONCOMMANDERCARDBRO()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_UNIONCOMMANDERCARDBRO;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.Guid = _loc2_.readInt(param1);
         this.UserId = _loc2_.readInt64(param1);
         this.Name = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.SkillId = _loc2_.readInt(param1);
         this.CardLevel = _loc2_.readInt(param1);
         this.SuccessFlag = _loc2_.readInt(param1);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 12;
         param1 += MsgTypes.MAX_NAME;
         param1 += (4 - param1 % 4) % 4;
         return param1 + 12;
      }
      
      public function release() : void
      {
      }
   }
}

