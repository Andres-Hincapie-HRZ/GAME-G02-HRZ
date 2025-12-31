package net.msg.constructionMsg
{
   import flash.external.ExternalInterface;
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   
   public class MSG_RESP_BUILDINFO_TEMP
   {
      
      public var SpareTime:int;
      
      public var PosX:uint;
      
      public var PosY:uint;
      
      public var IndexId:uint;
      
      public var BuildingId:int;
      
      public var LevelId:int;
      
      public function MSG_RESP_BUILDINFO_TEMP()
      {
         super();
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         this.SpareTime = int(int(_loc2_.readInt(param1)));
         this.PosX = uint(uint(_loc2_.readUnsignShort(param1)));
         this.PosY = uint(uint(_loc2_.readUnsignShort(param1)));
         this.IndexId = uint(uint(_loc2_.readUnsignShort(param1)));
         this.BuildingId = int(int(_loc2_.readUnsignChar(param1)));
         this.LevelId = int(int(_loc2_.readChar(param1)));
         _loc2_ = null;
         ExternalInterface.call("console.log","buildInfoList.add(new BuildInfo(" + this.SpareTime + ", " + this.PosX + ", " + this.PosY + ", " + this.IndexId + ", " + this.BuildingId + ", " + this.LevelId + "));");
      }
      
      public function writeBuf(param1:ByteArray) : int
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         param1.position = 0;
         var _loc3_:int = 0;
         _loc2_.writeInt(param1,this.SpareTime);
         _loc2_.writeUnsignShort(param1,this.PosX);
         _loc2_.writeUnsignShort(param1,this.PosY);
         _loc2_.writeUnsignShort(param1,this.IndexId);
         _loc2_.writeUnsignChar(param1,this.BuildingId);
         _loc2_.writeChar(param1,this.LevelId);
         param1.position = 0;
         _loc2_.writeShort(param1,_loc3_ + 12);
         _loc2_ = null;
         return _loc3_ + 12;
      }
      
      public function getLength() : int
      {
         return 12;
      }
      
      public function release() : void
      {
      }
   }
}

