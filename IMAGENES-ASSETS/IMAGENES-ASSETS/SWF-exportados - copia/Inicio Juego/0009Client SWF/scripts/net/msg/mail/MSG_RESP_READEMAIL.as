package net.msg.mail
{
   import flash.external.ExternalInterface;
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_READEMAIL extends MsgHead
   {
      
      public var AutoId:int;
      
      public var DataLen:int;
      
      public var Content:String = "";
      
      public var Data:Array;
      
      private var m_reg:RegExp;
      
      private var m_reg2:RegExp;
      
      private var m_reg3:RegExp;
      
      private var m_reg4:RegExp;
      
      public function MSG_RESP_READEMAIL()
      {
         ExternalInterface.call("console.log","[#] READ EMAIL RESP 1");
         var _loc2_:MSG_RESP_READEMAIL_TEMP = null;
         this.Data = new Array(MsgTypes.MAX_EMAILGOODS);
         this.m_reg = /</g;
         this.m_reg2 = />/g;
         this.m_reg3 = /"/g;
         this.m_reg4 = /'/g;
         super();
         var _loc1_:int = 0;
         while(_loc1_ < MsgTypes.MAX_EMAILGOODS)
         {
            _loc2_ = new MSG_RESP_READEMAIL_TEMP();
            this.Data[_loc1_] = _loc2_;
            _loc1_++;
         }
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_READEMAIL;
         ExternalInterface.call("console.log","[#] READ EMAIL RESP 2");
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         ExternalInterface.call("console.log","[#] READ EMAIL RESP 3");
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.AutoId = _loc2_.readInt(param1);
         this.DataLen = _loc2_.readInt(param1);
         this.Content = _loc2_.readUtf8Str(param1,MsgTypes.MAX_EMAILCONTENT);
         this.Content = this.FieldContent(this.Content);
         var _loc3_:int = 0;
         while(_loc3_ < MsgTypes.MAX_EMAILGOODS)
         {
            if(param1.length > param1.position)
            {
               ExternalInterface.call("console.log","[#] READING ONE PROP");
               this.Data[_loc3_].readBuf(param1);
            }
            _loc3_++;
         }
         _loc2_ = null;
         ExternalInterface.call("console.log","[#] READ EMAIL RESP 4");
      }
      
      private function FieldContent(param1:String) : String
      {
         param1 = param1.replace(this.m_reg,"&lt;");
         param1 = param1.replace(this.m_reg2,"&gt;");
         param1 = param1.replace(this.m_reg3,"&quot;");
         return param1.replace(this.m_reg4,"&#039;");
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         param1 += 8;
         param1 += MsgTypes.MAX_EMAILCONTENT;
         var _loc2_:int = 0;
         while(_loc2_ < MsgTypes.MAX_EMAILGOODS)
         {
            param1 = int(this.Data[_loc2_].getLength(param1));
            _loc2_++;
         }
         return param1;
      }
      
      public function release() : void
      {
         var _loc1_:int = MsgTypes.MAX_EMAILGOODS - 1;
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

