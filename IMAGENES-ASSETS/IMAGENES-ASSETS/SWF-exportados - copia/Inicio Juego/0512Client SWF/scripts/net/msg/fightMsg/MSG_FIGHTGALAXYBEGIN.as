package net.msg.fightMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_FIGHTGALAXYBEGIN extends MsgHead
   {
      
      public var GalaxyMapId:int;
      
      public var GalaxyId:int;
      
      public var Type:int;
      
      public var PirateLevelId:int;
      
      public var ConsortiaId:int;
      
      public var ConsortiaName:String = "";
      
      public function MSG_FIGHTGALAXYBEGIN()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_FIGHTGALAXYBEGIN;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.GalaxyMapId = _loc2_.readInt(param1);
         this.GalaxyId = _loc2_.readInt(param1);
         this.Type = _loc2_.readInt(param1);
         this.PirateLevelId = _loc2_.readInt(param1);
         this.ConsortiaId = _loc2_.readInt(param1);
         this.ConsortiaName = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 20;
         return param1 + MsgTypes.MAX_NAME;
      }
      
      public function release() : void
      {
      }
   }
}

