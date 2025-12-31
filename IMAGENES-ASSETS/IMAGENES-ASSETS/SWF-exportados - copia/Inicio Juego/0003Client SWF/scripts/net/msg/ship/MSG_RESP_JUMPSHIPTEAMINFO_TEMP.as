package net.msg.ship
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgTypes;
   
   public class MSG_RESP_JUMPSHIPTEAMINFO_TEMP
   {
      
      public var UserId:Number;
      
      public var UserName:String = "";
      
      public var ShipTeamId:int;
      
      public var FromGalaxyId:int;
      
      public var ToGalaxyId:int;
      
      public var SpareTime:int;
      
      public var TotalTime:int;
      
      public var FromGalaxyMapId:int;
      
      public var ToGalaxyMapId:int;
      
      public var Type:int;
      
      public var GalaxyType:int;
      
      public function MSG_RESP_JUMPSHIPTEAMINFO_TEMP()
      {
         super();
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.GetByte(param1,(8 - param1.position % 8) % 8);
         this.UserId = _loc2_.readInt64(param1);
         this.UserName = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.ShipTeamId = _loc2_.readInt(param1);
         this.FromGalaxyId = _loc2_.readInt(param1);
         this.ToGalaxyId = _loc2_.readInt(param1);
         this.SpareTime = _loc2_.readInt(param1);
         this.TotalTime = _loc2_.readInt(param1);
         this.FromGalaxyMapId = _loc2_.readChar(param1);
         this.ToGalaxyMapId = _loc2_.readChar(param1);
         this.Type = _loc2_.readChar(param1);
         this.GalaxyType = _loc2_.readChar(param1);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 += (8 - param1 % 8) % 8;
         param1 += 8;
         param1 += MsgTypes.MAX_NAME;
         param1 += (4 - param1 % 4) % 4;
         return param1 + 24;
      }
      
      public function release() : void
      {
      }
   }
}

