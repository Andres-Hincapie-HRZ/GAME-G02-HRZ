package net.msg.chatMsg
{
   import flash.external.ExternalInterface;
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_REQUEST_USERINFO extends MsgHead
   {
      
      public var SeqId:int;
      
      public var Guid:int;
      
      public var ObjGuid:int;
      
      public var ObjGalaxyId:int;
      
      public var Reserve:int;
      
      public var UserId:Number;
      
      public var UserName:String = "";
      
      public function MSG_REQUEST_USERINFO()
      {
         super();
         usSize = uint(this.getLength());
         usType = uint(MsgTypes._MSG_REQUEST_USERINFO);
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         param1.position = 0;
         _loc2_.writeShort(param1,usSize);
         _loc2_.writeShort(param1,usType);
         _loc2_.writeInt(param1,this.SeqId);
         _loc2_.writeInt(param1,this.Guid);
         _loc2_.writeInt(param1,this.ObjGuid);
         _loc2_.writeInt(param1,this.ObjGalaxyId);
         _loc2_.writeInt(param1,this.Reserve);
         _loc2_.writeInt64(param1,this.UserId);
         _loc2_.writeUtf8Str(param1,this.UserName,MsgTypes.MAX_NAME);
         _loc2_.PushByte(param1,usSize - param1.position);
         _loc2_ = null;
         ExternalInterface.call("console.log","[#] GID => " + this.ObjGalaxyId);
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 28;
         return param1 + MsgTypes.MAX_NAME;
      }
      
      public function release() : void
      {
      }
   }
}

