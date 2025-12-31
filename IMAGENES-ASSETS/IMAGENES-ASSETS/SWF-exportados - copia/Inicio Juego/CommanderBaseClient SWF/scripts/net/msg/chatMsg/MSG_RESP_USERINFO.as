package net.msg.chatMsg
{
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
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_USERINFO;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.Guid = _loc2_.readInt(param1);
         this.UserId = _loc2_.readInt64(param1);
         this.UserName = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.Consortia = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.RankId = _loc2_.readInt(param1);
         this.PosX = _loc2_.readInt(param1);
         this.PosY = _loc2_.readInt(param1);
         this.PeaceTime = _loc2_.readInt(param1);
         this.GalaxyId = _loc2_.readInt(param1);
         this.SpaceLevel = _loc2_.readChar(param1);
         this.CityLevel = _loc2_.readChar(param1);
         this.LevelId = _loc2_.readUnsignChar(param1);
         this.MatchLevel = _loc2_.readUnsignChar(param1);
         this.PassMaxEctypt = _loc2_.readInt(param1);
         this.ConsortiaId = _loc2_.readInt(param1);
         this.PassInsertFlagTime = _loc2_.readInt(param1);
         this.InsertFlagConsortiaId = _loc2_.readInt(param1);
         this.InsertFlagConsortia = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 12;
         param1 += MsgTypes.MAX_NAME;
         param1 += MsgTypes.MAX_NAME;
         param1 += (4 - param1 % 4) % 4;
         param1 += 24;
         param1 += (4 - param1 % 4) % 4;
         param1 += 16;
         return param1 + MsgTypes.MAX_NAME;
      }
      
      public function release() : void
      {
      }
   }
}

