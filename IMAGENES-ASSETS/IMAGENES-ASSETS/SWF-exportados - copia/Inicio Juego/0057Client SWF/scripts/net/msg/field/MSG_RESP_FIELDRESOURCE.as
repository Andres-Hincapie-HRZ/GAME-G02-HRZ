package net.msg.field
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_FIELDRESOURCE extends MsgHead
   {
      
      public var GalaxyMapId:int;
      
      public var GalaxyId:int;
      
      public var ConsortiaPer:int;
      
      public var FriendFlag:int;
      
      public var FieldCenterStatus:int;
      
      public var TechPerMetal:int;
      
      public var TechPerGas:int;
      
      public var TechPerMoney:int;
      
      public var PropsPerMetal:int;
      
      public var PropsPerGas:int;
      
      public var PropsPerMoney:int;
      
      public var Data:Array;
      
      public var FieldCenterTime:int;
      
      public var HelpGuid:Array;
      
      public function MSG_RESP_FIELDRESOURCE()
      {
         var _loc2_:MSG_RESP_FIELDRESOURCE_TEMP = null;
         this.Data = new Array(MsgTypes.MAX_FIELDRESOURCE);
         this.HelpGuid = new Array(MsgTypes.MAX_HELPCOUNT);
         super();
         var _loc1_:int = 0;
         while(_loc1_ < MsgTypes.MAX_FIELDRESOURCE)
         {
            _loc2_ = new MSG_RESP_FIELDRESOURCE_TEMP();
            this.Data[_loc1_] = _loc2_;
            _loc1_++;
         }
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_FIELDRESOURCE;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.GalaxyMapId = _loc2_.readInt(param1);
         this.GalaxyId = _loc2_.readInt(param1);
         this.ConsortiaPer = _loc2_.readInt(param1);
         this.FriendFlag = _loc2_.readChar(param1);
         this.FieldCenterStatus = _loc2_.readChar(param1);
         this.TechPerMetal = _loc2_.readChar(param1);
         this.TechPerGas = _loc2_.readChar(param1);
         this.TechPerMoney = _loc2_.readChar(param1);
         this.PropsPerMetal = _loc2_.readChar(param1);
         this.PropsPerGas = _loc2_.readChar(param1);
         this.PropsPerMoney = _loc2_.readChar(param1);
         var _loc3_:int = 0;
         while(_loc3_ < MsgTypes.MAX_FIELDRESOURCE)
         {
            if(param1.length > param1.position)
            {
               this.Data[_loc3_].readBuf(param1);
            }
            _loc3_++;
         }
         this.FieldCenterTime = _loc2_.readInt(param1);
         var _loc4_:int = 0;
         while(_loc4_ < MsgTypes.MAX_HELPCOUNT)
         {
            if(param1.length - param1.position >= 4)
            {
               this.HelpGuid[_loc4_] = _loc2_.readInt(param1);
            }
            _loc4_++;
         }
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 20;
         var _loc2_:int = 0;
         while(_loc2_ < MsgTypes.MAX_FIELDRESOURCE)
         {
            param1 = int(this.Data[_loc2_].getLength(param1));
            _loc2_++;
         }
         param1 += (4 - param1 % 4) % 4;
         param1 += 4;
         return param1 + MsgTypes.MAX_HELPCOUNT * 4;
      }
      
      public function release() : void
      {
         var _loc1_:int = MsgTypes.MAX_FIELDRESOURCE - 1;
         while(_loc1_ >= 0)
         {
            this.Data[_loc1_].release();
            _loc1_--;
         }
         this.Data.splice(0);
         this.Data = null;
         this.HelpGuid.splice(0);
         this.HelpGuid = null;
      }
   }
}

