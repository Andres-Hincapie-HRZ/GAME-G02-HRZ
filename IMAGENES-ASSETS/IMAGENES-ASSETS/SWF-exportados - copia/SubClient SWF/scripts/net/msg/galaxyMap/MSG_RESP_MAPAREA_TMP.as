package net.msg.galaxyMap
{
   import flash.external.ExternalInterface;
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgTypes;
   
   public class MSG_RESP_MAPAREA_TMP
   {
      
      public var ConsortiaName:String = "";
      
      public var UserName:String = "";
      
      public var UserId:Number;
      
      public var GalaxyId:int;
      
      public var Reserve1:int;
      
      public var StarFace:int;
      
      public var InsertFlagStatus:int;
      
      public var ConsortiaHeadId:int;
      
      public var ConsortiaLevelId:int;
      
      public var Type:int;
      
      public var FightFlag:int;
      
      public var Camp:int;
      
      public var SpaceLevelId:int;
      
      public function MSG_RESP_MAPAREA_TMP()
      {
         super();
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.GetByte(param1,(8 - param1.position) % 8 % 8);
         this.ConsortiaName = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.UserName = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.UserId = Number(_loc2_.readInt64(param1));
         this.GalaxyId = int(_loc2_.readInt(param1));
         this.Reserve1 = int(_loc2_.readInt(param1));
         this.StarFace = int(_loc2_.readChar(param1));
         this.InsertFlagStatus = int(_loc2_.readChar(param1));
         this.ConsortiaHeadId = int(_loc2_.readUnsignChar(param1));
         this.ConsortiaLevelId = int(_loc2_.readUnsignChar(param1));
         this.Type = int(_loc2_.readChar(param1));
         if(this.Type == 2)
         {
         }
         this.FightFlag = int(_loc2_.readChar(param1));
         this.Camp = int(_loc2_.readChar(param1));
         this.SpaceLevelId = int(_loc2_.readChar(param1));
         _loc2_ = null;
         ExternalInterface.call("console.log","[#] [GID] = " + this.GalaxyId);
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.PushByte(param1,(8 - param1.position) % 8 % 8);
         _loc2_.writeUtf8Str(param1,this.ConsortiaName,MsgTypes.MAX_NAME);
         _loc2_.writeUtf8Str(param1,this.UserName,MsgTypes.MAX_NAME);
         _loc2_.writeInt64(param1,this.UserId);
         _loc2_.writeInt(param1,this.GalaxyId);
         _loc2_.writeInt(param1,this.Reserve1);
         _loc2_.writeChar(param1,this.StarFace);
         _loc2_.writeChar(param1,this.InsertFlagStatus);
         _loc2_.writeUnsignChar(param1,this.ConsortiaHeadId);
         _loc2_.writeUnsignChar(param1,this.ConsortiaLevelId);
         _loc2_.writeChar(param1,this.Type);
         _loc2_.writeChar(param1,this.FightFlag);
         _loc2_.writeChar(param1,this.Camp);
         _loc2_.writeChar(param1,this.SpaceLevelId);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = (param1 + (8 - param1)) % 8 % 8;
         param1 += MsgTypes.MAX_NAME;
         param1 += MsgTypes.MAX_NAME;
         param1 = (param1 + (8 - param1)) % 8 % 8;
         return param1 + 24;
      }
      
      public function release() : void
      {
      }
   }
}

