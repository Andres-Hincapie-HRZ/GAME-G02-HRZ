package net.msg.chatMsg
{
   import flash.external.ExternalInterface;
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_USERINFO extends MsgHead
   {
      
      public var Guid:int;
      
      public var UserId:Number;
      
      public var UserName:String = "";
      
      public var Consortia:String = "";
      
      public var RankId:int;
      
      public var PosX:int;
      
      public var PosY:int;
      
      public var PeaceTime:int;
      
      public var GalaxyId:int;
      
      public var SpaceLevel:int;
      
      public var CityLevel:int;
      
      public var LevelId:int;
      
      public var MatchLevel:int;
      
      public var PassMaxEctypt:int;
      
      public var ConsortiaId:int;
      
      public var PassInsertFlagTime:int;
      
      public var InsertFlagConsortiaId:int;
      
      public var InsertFlagConsortia:String = "";
      
      public function MSG_RESP_USERINFO()
      {
         super();
         usSize = uint(this.getLength());
         usType = uint(MsgTypes._MSG_RESP_USERINFO);
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = uint(_loc2_.readMsgSize(param1));
         usType = uint(_loc2_.readMsgType(param1));
         this.Guid = int(_loc2_.readInt(param1));
         this.UserId = Number(_loc2_.readInt64(param1));
         this.UserName = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.Consortia = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.RankId = int(_loc2_.readInt(param1));
         this.PosX = int(_loc2_.readInt(param1));
         this.PosY = int(_loc2_.readInt(param1));
         this.PeaceTime = int(_loc2_.readInt(param1));
         this.GalaxyId = int(_loc2_.readInt(param1));
         this.SpaceLevel = int(_loc2_.readChar(param1));
         this.CityLevel = int(_loc2_.readChar(param1));
         this.LevelId = int(_loc2_.readUnsignChar(param1));
         this.MatchLevel = int(_loc2_.readUnsignChar(param1));
         this.PassMaxEctypt = int(_loc2_.readInt(param1));
         this.ConsortiaId = int(_loc2_.readInt(param1));
         this.PassInsertFlagTime = int(_loc2_.readInt(param1));
         this.InsertFlagConsortiaId = int(_loc2_.readInt(param1));
         this.InsertFlagConsortia = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         _loc2_ = null;
         ExternalInterface.call("console.log","(= [" + this.UserName + "] =)");
         ExternalInterface.call("console.log","ID del Planeta :: " + this.Guid);
         ExternalInterface.call("console.log","ID del Usuario :: " + this.UserId);
         ExternalInterface.call("console.log","(=== ===)");
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 12;
         param1 += MsgTypes.MAX_NAME;
         param1 += MsgTypes.MAX_NAME;
         param1 = (param1 + (4 - param1)) % 4 % 4;
         param1 += 24;
         param1 = (param1 + (4 - param1)) % 4 % 4;
         param1 += 16;
         return param1 + MsgTypes.MAX_NAME;
      }
      
      public function release() : void
      {
      }
   }
}

