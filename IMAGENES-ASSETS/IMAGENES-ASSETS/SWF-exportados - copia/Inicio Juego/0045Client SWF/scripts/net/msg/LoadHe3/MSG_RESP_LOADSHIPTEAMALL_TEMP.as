package net.msg.LoadHe3
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgTypes;
   
   public class MSG_RESP_LOADSHIPTEAMALL_TEMP
   {
      
      public var ShipName:String = "";
      
      public var ShipTeamId:int;
      
      public var ShipNum:int;
      
      public var ShipSpace:int;
      
      public var Gas:int;
      
      public var Supply:int;
      
      public function MSG_RESP_LOADSHIPTEAMALL_TEMP()
      {
         super();
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.GetByte(param1,(4 - param1.position % 4) % 4);
         this.ShipName = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.ShipTeamId = _loc2_.readInt(param1);
         this.ShipNum = _loc2_.readInt(param1);
         this.ShipSpace = _loc2_.readInt(param1);
         this.Gas = _loc2_.readInt(param1);
         this.Supply = _loc2_.readInt(param1);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 += (4 - param1 % 4) % 4;
         param1 += MsgTypes.MAX_NAME;
         param1 += (4 - param1 % 4) % 4;
         return param1 + 20;
      }
      
      public function release() : void
      {
      }
   }
}

