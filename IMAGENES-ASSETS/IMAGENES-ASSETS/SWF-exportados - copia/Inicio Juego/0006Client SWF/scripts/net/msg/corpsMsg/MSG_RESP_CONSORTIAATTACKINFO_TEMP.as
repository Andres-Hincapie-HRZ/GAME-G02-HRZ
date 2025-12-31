package net.msg.corpsMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgTypes;
   
   public class MSG_RESP_CONSORTIAATTACKINFO_TEMP
   {
      
      public var SrcName:String = "";
      
      public var SrcConsortiaName:String = "";
      
      public var ObjName:String = "";
      
      public var SrcUserId:Number;
      
      public var ObjUserId:Number;
      
      public var ObjGuid:int;
      
      public var ObjGalaxyId:int;
      
      public var SrcGuid:int;
      
      public var SrcGalaxyId:int;
      
      public var NeedTime:int;
      
      public var Reserve:int;
      
      public function MSG_RESP_CONSORTIAATTACKINFO_TEMP()
      {
         super();
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.GetByte(param1,(8 - param1.position % 8) % 8);
         this.SrcName = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.SrcConsortiaName = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.ObjName = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.SrcUserId = _loc2_.readInt64(param1);
         this.ObjUserId = _loc2_.readInt64(param1);
         this.ObjGuid = _loc2_.readInt(param1);
         this.ObjGalaxyId = _loc2_.readInt(param1);
         this.SrcGuid = _loc2_.readInt(param1);
         this.SrcGalaxyId = _loc2_.readInt(param1);
         this.NeedTime = _loc2_.readInt(param1);
         this.Reserve = _loc2_.readInt(param1);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 += (8 - param1 % 8) % 8;
         param1 += MsgTypes.MAX_NAME;
         param1 += MsgTypes.MAX_NAME;
         param1 += MsgTypes.MAX_NAME;
         param1 += (8 - param1 % 8) % 8;
         return param1 + 40;
      }
      
      public function release() : void
      {
      }
   }
}

