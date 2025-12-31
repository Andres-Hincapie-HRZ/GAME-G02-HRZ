package net.msg.upgrade
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_SHIPBODYUPGRADEINFO extends MsgHead
   {
      
      public var IncUpgradePercent:int;
      
      public var BodyNum:int;
      
      public var PartNum:int;
      
      public var BodyId:Array;
      
      public var PartId:Array;
      
      public function MSG_RESP_SHIPBODYUPGRADEINFO()
      {
         var _loc3_:MSG_RESP_SHIPBODYINFO_TEMP = null;
         var _loc4_:MSG_RESP_SHIPBODYINFO_TEMP = null;
         this.BodyId = new Array(MsgTypes.MAX_SHIPBODYUPGRADELIST);
         this.PartId = new Array(MsgTypes.MAX_SHIPBODYUPGRADELIST);
         super();
         var _loc1_:int = 0;
         while(_loc1_ < MsgTypes.MAX_SHIPBODYUPGRADELIST)
         {
            _loc3_ = new MSG_RESP_SHIPBODYINFO_TEMP();
            this.BodyId[_loc1_] = _loc3_;
            _loc1_++;
         }
         var _loc2_:int = 0;
         while(_loc2_ < MsgTypes.MAX_SHIPBODYUPGRADELIST)
         {
            _loc4_ = new MSG_RESP_SHIPBODYINFO_TEMP();
            this.PartId[_loc2_] = _loc4_;
            _loc2_++;
         }
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_SHIPBODYUPGRADEINFO;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.IncUpgradePercent = _loc2_.readInt(param1);
         this.BodyNum = _loc2_.readShort(param1);
         this.PartNum = _loc2_.readShort(param1);
         var _loc3_:int = 0;
         while(_loc3_ < MsgTypes.MAX_SHIPBODYUPGRADELIST)
         {
            if(param1.length > param1.position)
            {
               this.BodyId[_loc3_].readBuf(param1);
            }
            _loc3_++;
         }
         var _loc4_:int = 0;
         while(_loc4_ < MsgTypes.MAX_SHIPBODYUPGRADELIST)
         {
            if(param1.length > param1.position)
            {
               this.PartId[_loc4_].readBuf(param1);
            }
            _loc4_++;
         }
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 8;
         var _loc2_:int = 0;
         while(_loc2_ < MsgTypes.MAX_SHIPBODYUPGRADELIST)
         {
            param1 = int(this.BodyId[_loc2_].getLength(param1));
            _loc2_++;
         }
         var _loc3_:int = 0;
         while(_loc3_ < MsgTypes.MAX_SHIPBODYUPGRADELIST)
         {
            param1 = int(this.PartId[_loc3_].getLength(param1));
            _loc3_++;
         }
         return param1;
      }
      
      public function release() : void
      {
         var _loc1_:int = MsgTypes.MAX_SHIPBODYUPGRADELIST - 1;
         while(_loc1_ >= 0)
         {
            this.BodyId[_loc1_].release();
            _loc1_--;
         }
         this.BodyId.splice(0);
         this.BodyId = null;
         var _loc2_:int = MsgTypes.MAX_SHIPBODYUPGRADELIST - 1;
         while(_loc2_ >= 0)
         {
            this.PartId[_loc2_].release();
            _loc2_--;
         }
         this.PartId.splice(0);
         this.PartId = null;
      }
   }
}

