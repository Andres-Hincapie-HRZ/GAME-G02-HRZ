package net.msg.mail
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgTypes;
   
   public class MSG_RESP_EMAILINFO_TEMP
   {
      
      public var Title:String = "";
      
      public var Name:String = "";
      
      public var DateTime:Number;
      
      public var SrcUserid:Number;
      
      public var SrcGuid:int;
      
      public var AutoId:int;
      
      public var FightGalaxyId:int;
      
      public var Type:int;
      
      public var ReadFlag:int;
      
      public var GoodFlag:int;
      
      public var TitleType:int;
      
      public function MSG_RESP_EMAILINFO_TEMP()
      {
         super();
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = MsgSocket.Instance();
         _loc2_.GetByte(param1,(8 - param1.position % 8) % 8);
         this.Title = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.Name = _loc2_.readUtf8Str(param1,MsgTypes.MAX_NAME);
         this.DateTime = _loc2_.readInt64(param1);
         this.SrcUserid = _loc2_.readInt64(param1);
         this.SrcGuid = _loc2_.readInt(param1);
         this.AutoId = _loc2_.readInt(param1);
         this.FightGalaxyId = _loc2_.readInt(param1);
         this.Type = _loc2_.readChar(param1);
         this.ReadFlag = _loc2_.readChar(param1);
         this.GoodFlag = _loc2_.readChar(param1);
         this.TitleType = _loc2_.readChar(param1);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 += (8 - param1 % 8) % 8;
         param1 += MsgTypes.MAX_NAME;
         param1 += MsgTypes.MAX_NAME;
         param1 += (8 - param1 % 8) % 8;
         return param1 + 32;
      }
      
      public function release() : void
      {
      }
   }
}

