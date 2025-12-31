package net.msg.corpsMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgTypes;
   
   public class MSG_RESP_INSERTFLAGCONSORTIAIMEMBER_TEMP
   {
      
      public var Name:String = "";
      
      public var Guid:int;
      
      public var GalaxyId:int;
      
      public var Assault:int;
      
      public var GalaxyArea:int;
      
      public var LevelId:int;
      
      public var Job:int;
      
      public function MSG_RESP_INSERTFLAGCONSORTIAIMEMBER_TEMP()
      {
         super();
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.GetByte(param1,(4 - param1.position % 4) % 4);
         this.Name = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.Guid = _loc2_.readInt(param1);
         this.GalaxyId = _loc2_.readInt(param1);
         this.Assault = _loc2_.readInt(param1);
         this.GalaxyArea = _loc2_.readShort(param1);
         this.LevelId = _loc2_.readUnsignChar(param1);
         this.Job = _loc2_.readChar(param1);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 += (4 - param1 % 4) % 4;
         param1 += MsgTypes.MAX_NAME;
         param1 += (4 - param1 % 4) % 4;
         return param1 + 16;
      }
      
      public function release() : void
      {
      }
   }
}

