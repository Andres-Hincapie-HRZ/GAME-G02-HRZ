package net.msg.corpsMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_CONSORTIAPROCLAIM extends MsgHead
   {
      
      public var ConsortiaId:int;
      
      public var ConsortiaLeadUserId:Number;
      
      public var Cent:Number;
      
      public var ConsortiaLeadGuid:int;
      
      public var ConsortiaLead:String = "";
      
      public var Proclaim:String = "";
      
      public var MemberCount:int;
      
      public var MaxMemberCount:int;
      
      public var consortiaLevel:int;
      
      public var HeadId:int;
      
      public var LimitJoin:int;
      
      public function MSG_RESP_CONSORTIAPROCLAIM()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_CONSORTIAPROCLAIM;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.ConsortiaId = _loc2_.readInt(param1);
         this.ConsortiaLeadUserId = _loc2_.readInt64(param1);
         this.Cent = _loc2_.readInt64(param1);
         this.ConsortiaLeadGuid = _loc2_.readInt(param1);
         this.ConsortiaLead = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.Proclaim = _loc2_.readUtf8Str(param1,MsgTypes.MAX_MEMO);
         this.MemberCount = _loc2_.readUnsignChar(param1);
         this.MaxMemberCount = _loc2_.readUnsignChar(param1);
         this.consortiaLevel = _loc2_.readUnsignChar(param1);
         this.HeadId = _loc2_.readUnsignChar(param1);
         this.LimitJoin = _loc2_.readChar(param1);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 24;
         param1 += MsgTypes.MAX_NAME;
         param1 += MsgTypes.MAX_MEMO;
         return param1 + 5;
      }
      
      public function release() : void
      {
      }
   }
}

