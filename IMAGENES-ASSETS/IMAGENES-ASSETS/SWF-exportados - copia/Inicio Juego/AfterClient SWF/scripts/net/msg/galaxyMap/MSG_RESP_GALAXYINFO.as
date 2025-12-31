package net.msg.galaxyMap
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_GALAXYINFO extends MsgHead
   {
      
      public var ObjGuid:int;
      
      public var ObjUserId:Number;
      
      public var GalaxyMapId:int;
      
      public var GalaxyId:int;
      
      public var Name:String = "";
      
      public var Consortia:String = "";
      
      public var Type:int;
      
      public var Level:int;
      
      public var Status:int;
      
      public function MSG_RESP_GALAXYINFO()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_GALAXYINFO;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.ObjGuid = _loc2_.readInt(param1);
         this.ObjUserId = _loc2_.readInt64(param1);
         this.GalaxyMapId = _loc2_.readInt(param1);
         this.GalaxyId = _loc2_.readInt(param1);
         this.Name = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.Consortia = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.Type = _loc2_.readChar(param1);
         this.Level = _loc2_.readChar(param1);
         this.Status = _loc2_.readChar(param1);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 20;
         param1 += MsgTypes.MAX_NAME;
         param1 += MsgTypes.MAX_NAME;
         return param1 + 3;
      }
      
      public function release() : void
      {
      }
   }
}

