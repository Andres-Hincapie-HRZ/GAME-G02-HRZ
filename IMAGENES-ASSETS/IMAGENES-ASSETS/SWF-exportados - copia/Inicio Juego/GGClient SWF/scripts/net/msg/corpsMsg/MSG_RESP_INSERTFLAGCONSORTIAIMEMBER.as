package net.msg.corpsMsg
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_INSERTFLAGCONSORTIAIMEMBER extends MsgHead
   {
      
      public var Name:String = "";
      
      public var ThrowWealth:int;
      
      public var HoldGalaxyArea:Array;
      
      public var HeadId:int;
      
      public var Level:int;
      
      public var HoldGalaxy:int;
      
      public var MemberCount:int;
      
      public var DataLen:int;
      
      public var Data:Array;
      
      public function MSG_RESP_INSERTFLAGCONSORTIAIMEMBER()
      {
         var _loc2_:MSG_RESP_INSERTFLAGCONSORTIAIMEMBER_TEMP = null;
         this.HoldGalaxyArea = new Array(MsgTypes.MAX_CONSORTIAFIELD);
         this.Data = new Array(10);
         super();
         var _loc1_:int = 0;
         while(_loc1_ < 10)
         {
            _loc2_ = new MSG_RESP_INSERTFLAGCONSORTIAIMEMBER_TEMP();
            this.Data[_loc1_] = _loc2_;
            _loc1_++;
         }
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_INSERTFLAGCONSORTIAIMEMBER;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.Name = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.ThrowWealth = _loc2_.readInt(param1);
         var _loc3_:int = 0;
         while(_loc3_ < MsgTypes.MAX_CONSORTIAFIELD)
         {
            if(param1.length - param1.position >= 4)
            {
               this.HoldGalaxyArea[_loc3_] = _loc2_.readInt(param1);
            }
            _loc3_++;
         }
         this.HeadId = _loc2_.readUnsignChar(param1);
         this.Level = _loc2_.readUnsignChar(param1);
         this.HoldGalaxy = _loc2_.readUnsignChar(param1);
         this.MemberCount = _loc2_.readUnsignChar(param1);
         this.DataLen = _loc2_.readInt(param1);
         var _loc4_:int = 0;
         while(_loc4_ < 10)
         {
            if(param1.length > param1.position)
            {
               this.Data[_loc4_].readBuf(param1);
            }
            _loc4_++;
         }
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += MsgTypes.MAX_NAME;
         param1 += (4 - param1 % 4) % 4;
         param1 += 4;
         param1 += MsgTypes.MAX_CONSORTIAFIELD * 4;
         param1 += 4;
         param1 += (4 - param1 % 4) % 4;
         param1 += 4;
         var _loc2_:int = 0;
         while(_loc2_ < 10)
         {
            param1 = int(this.Data[_loc2_].getLength(param1));
            _loc2_++;
         }
         return param1;
      }
      
      public function release() : void
      {
         this.HoldGalaxyArea.splice(0);
         this.HoldGalaxyArea = null;
         var _loc1_:int = 10 - 1;
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

