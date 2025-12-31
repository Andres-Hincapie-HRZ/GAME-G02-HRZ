package net.msg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_LOGINSERVER_GAMESERVERLISTRESP extends MsgHead
   {
      
      public var DataLen:int;
      
      public var DefaultServerId:int;
      
      public var NewServerId:int;
      
      public var Data:Array;
      
      public function MSG_LOGINSERVER_GAMESERVERLISTRESP()
      {
         var _loc2_:MSG_LOGINSERVER_GAMESERVERLISTRESP_TEMP = null;
         this.Data = new Array(MsgTypes.MAX_GAMESERVERLIST);
         super();
         var _loc1_:int = 0;
         while(_loc1_ < MsgTypes.MAX_GAMESERVERLIST)
         {
            _loc2_ = new MSG_LOGINSERVER_GAMESERVERLISTRESP_TEMP();
            this.Data[_loc1_] = _loc2_;
            _loc1_++;
         }
         usSize = this.getLength();
         usType = MsgTypes._MSG_LOGINSERVER_GAMESERVERLISTRESP;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.DataLen = _loc2_.readInt(param1);
         this.DefaultServerId = _loc2_.readInt(param1);
         this.NewServerId = _loc2_.readInt(param1);
         var _loc3_:int = 0;
         while(_loc3_ < MsgTypes.MAX_GAMESERVERLIST)
         {
            if(param1.length > param1.position)
            {
               this.Data[_loc3_].readBuf(param1);
            }
            _loc3_++;
         }
         _loc2_ = null;
      }
      
      public function writeBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         param1.position = 0;
         _loc2_.writeShort(param1,usSize);
         _loc2_.writeShort(param1,usType);
         _loc2_.writeInt(param1,this.DataLen);
         _loc2_.writeInt(param1,this.DefaultServerId);
         _loc2_.writeInt(param1,this.NewServerId);
         var _loc3_:int = 0;
         while(_loc3_ < MsgTypes.MAX_GAMESERVERLIST)
         {
            this.Data[_loc3_].writeBuf(param1);
            _loc3_++;
         }
         _loc2_.PushByte(param1,usSize - param1.position);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 12;
         var _loc2_:int = 0;
         while(_loc2_ < MsgTypes.MAX_GAMESERVERLIST)
         {
            param1 = int(this.Data[_loc2_].getLength(param1));
            _loc2_++;
         }
         return param1;
      }
      
      public function release() : void
      {
         var _loc1_:int = MsgTypes.MAX_GAMESERVERLIST - 1;
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

