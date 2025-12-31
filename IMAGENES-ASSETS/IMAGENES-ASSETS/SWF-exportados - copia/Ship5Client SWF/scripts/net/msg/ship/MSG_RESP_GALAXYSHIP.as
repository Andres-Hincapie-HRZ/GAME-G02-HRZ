package net.msg.ship
{
   import flash.external.ExternalInterface;
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_GALAXYSHIP extends MsgHead
   {
      
      public var DataLen:int;
      
      public var GalaxyMapId:int;
      
      public var GalaxyId:int;
      
      public var Data:Array = new Array(MsgTypes.MAX_SENDTEAMINFO);
      
      public function MSG_RESP_GALAXYSHIP()
      {
         super();
         usType = uint(MsgTypes._MSG_RESP_GALAXYSHIP);
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = uint(_loc2_.readMsgSize(param1));
         usType = uint(_loc2_.readMsgType(param1));
         this.DataLen = _loc2_.readShort(param1);
         this.GalaxyMapId = _loc2_.readShort(param1);
         this.GalaxyId = _loc2_.readInt(param1);
         ExternalInterface.call("console.log","[#] BIG PROBLEM => " + this.GalaxyId);
         var _loc3_:int = 0;
         while(_loc3_ < this.DataLen)
         {
            if(this.Data[_loc3_] == null)
            {
               this.Data[_loc3_] = new MSG_RESP_GALAXYSHIP_TEMP();
            }
            if(param1.length > param1.position)
            {
               this.Data[_loc3_].readBuf(param1);
            }
            _loc3_++;
         }
         ExternalInterface.call("console.log","[#] BIG PROBLEM 2 => " + _loc3_);
         _loc2_ = null;
      }
      
      public function release() : void
      {
         var _loc1_:int = this.DataLen - 1;
         while(_loc1_ >= 0)
         {
            this.Data[_loc1_].release();
            _loc1_--;
         }
         this.Data.splice(0);
         this.Data = null;
      }
   }
}

