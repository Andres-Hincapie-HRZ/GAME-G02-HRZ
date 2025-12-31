package net.msg.ship
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_REQUEST_UNITESHIPTEAM extends MsgHead
   {
      
      public var SeqId:int;
      
      public var Guid:int;
      
      public var GalaxyMapId:int;
      
      public var GalaxyId:int;
      
      public var ShipTeamId:int;
      
      public var ShipTeamId2:int;
      
      public var Gas:uint;
      
      public var Gas2:uint;
      
      public var TeamBody:Array;
      
      public var TeamBody2:Array;
      
      public function MSG_REQUEST_UNITESHIPTEAM()
      {
         var _loc3_:MSG_SHIPTEAM_NUM = null;
         var _loc4_:MSG_SHIPTEAM_NUM = null;
         this.TeamBody = new Array(MsgTypes.MAX_SHIPTEAMBODY);
         this.TeamBody2 = new Array(MsgTypes.MAX_SHIPTEAMBODY);
         super();
         var _loc1_:int = 0;
         while(_loc1_ < MsgTypes.MAX_SHIPTEAMBODY)
         {
            _loc3_ = new MSG_SHIPTEAM_NUM();
            this.TeamBody[_loc1_] = _loc3_;
            _loc1_++;
         }
         var _loc2_:int = 0;
         while(_loc2_ < MsgTypes.MAX_SHIPTEAMBODY)
         {
            _loc4_ = new MSG_SHIPTEAM_NUM();
            this.TeamBody2[_loc2_] = _loc4_;
            _loc2_++;
         }
         usSize = this.getLength();
         usType = MsgTypes._MSG_REQUEST_UNITESHIPTEAM;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         param1.position = 0;
         _loc2_.writeShort(param1,usSize);
         _loc2_.writeShort(param1,usType);
         _loc2_.writeInt(param1,this.SeqId);
         _loc2_.writeInt(param1,this.Guid);
         _loc2_.writeInt(param1,this.GalaxyMapId);
         _loc2_.writeInt(param1,this.GalaxyId);
         _loc2_.writeInt(param1,this.ShipTeamId);
         _loc2_.writeInt(param1,this.ShipTeamId2);
         _loc2_.writeUnsignInt(param1,this.Gas);
         _loc2_.writeUnsignInt(param1,this.Gas2);
         var _loc3_:int = 0;
         while(_loc3_ < MsgTypes.MAX_SHIPTEAMBODY)
         {
            this.TeamBody[_loc3_].writeBuf(param1);
            _loc3_++;
         }
         var _loc4_:int = 0;
         while(_loc4_ < MsgTypes.MAX_SHIPTEAMBODY)
         {
            this.TeamBody2[_loc4_].writeBuf(param1);
            _loc4_++;
         }
         _loc2_.PushByte(param1,usSize - param1.position);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 32;
         var _loc2_:int = 0;
         while(_loc2_ < MsgTypes.MAX_SHIPTEAMBODY)
         {
            param1 = int(this.TeamBody[_loc2_].getLength(param1));
            _loc2_++;
         }
         var _loc3_:int = 0;
         while(_loc3_ < MsgTypes.MAX_SHIPTEAMBODY)
         {
            param1 = int(this.TeamBody2[_loc3_].getLength(param1));
            _loc3_++;
         }
         return param1;
      }
      
      public function release() : void
      {
         var _loc1_:int = MsgTypes.MAX_SHIPTEAMBODY - 1;
         while(_loc1_ >= 0)
         {
            this.TeamBody[_loc1_].release();
            _loc1_--;
         }
         this.TeamBody.splice(0);
         this.TeamBody = null;
         var _loc2_:int = MsgTypes.MAX_SHIPTEAMBODY - 1;
         while(_loc2_ >= 0)
         {
            this.TeamBody2[_loc2_].release();
            _loc2_--;
         }
         this.TeamBody2.splice(0);
         this.TeamBody2 = null;
      }
   }
}

