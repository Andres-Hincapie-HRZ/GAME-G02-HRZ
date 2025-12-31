package net.msg.galaxyMap
{
   import flash.external.ExternalInterface;
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
         usSize = uint(this.getLength());
         usType = uint(MsgTypes._MSG_RESP_GALAXYINFO);
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = uint(_loc2_.readMsgSize(param1));
         usType = uint(_loc2_.readMsgType(param1));
         this.ObjGuid = int(_loc2_.readInt(param1));
         this.ObjUserId = Number(_loc2_.readInt64(param1));
         this.GalaxyMapId = int(_loc2_.readInt(param1));
         this.GalaxyId = int(_loc2_.readInt(param1));
         this.Name = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.Consortia = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.Type = int(_loc2_.readChar(param1));
         this.Level = int(_loc2_.readChar(param1));
         this.Status = int(_loc2_.readChar(param1));
         ExternalInterface.call("console.log","[#] HARDED ");
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

