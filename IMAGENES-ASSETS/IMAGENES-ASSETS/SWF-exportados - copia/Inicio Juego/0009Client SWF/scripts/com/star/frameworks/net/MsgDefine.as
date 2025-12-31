package com.star.frameworks.net
{
   import flash.utils.ByteArray;
   
   public class MsgDefine
   {
      
      private static var _instance:MsgDefine;
      
      public static const MAX_BUILDING:int = 100;
      
      public static const MAX_SHIPPART:int = 50;
      
      public static const MAX_SHIPTEAMBODY:int = 9;
      
      public static const SHIPMODEL_TECH:int = 5;
      
      public static const FIGHTSTARMATRIX:int = 4;
      
      public static const MAX_CREATECONSORTIALEVEL:int = 8;
      
      public static const TECHSTART_CONSORTIA:int = 201;
      
      public static const TECHSTART_CAMP:int = 101;
      
      public static const MAX_SHIPMODEL:int = 20;
      
      public static const MAX_SHIPCREATING:int = 30;
      
      public static const MAX_SHIPDISTYPE:int = 200;
      
      public static const MAX_TOGALAXYPATH:int = 50;
      
      public static const MIN_HOLDSTAR:int = 0;
      
      public static const MAX_COMMANDNUM:int = 30;
      
      public static const MAX_USERSHIPTEAMNUM:int = 50;
      
      public static const MAX_USERSTARNUM:int = 50;
      
      public static const MAX_GALAXYSTARNUM:int = 50;
      
      public static const MAX_874_COUNT:int = 5;
      
      public static const MAX_874_ALLCOUNT:int = 20;
      
      public static const MAX_FIGHTRESULTEXP:int = 30;
      
      public static const MAX_FIGHTRESULTKILL:int = 10;
      
      public static const MAX_GALAXYCAMP:int = 80;
      
      public static const MAX_FIGHTMOVEPATH:int = 10;
      
      public static const MAX_MAP_CELL:int = 21;
      
      public static const MAX_CAMP:int = 7;
      
      public static const MAX_MSG_PART:int = 7;
      
      public static const MAX_SENDTEAMINFO:int = 10;
      
      public static const MAX_CHATFRIEDN:int = 50;
      
      public static const MAX_DATETIME:int = 20;
      
      public static const MAX_MATRIXSHIP:int = 30000;
      
      public static const MAX_VALIDSHIP:int = 1000;
      
      public static const MAX_CAMPLOCKNUM:int = 30;
      
      public static const MAX_DOWNLOADURL:int = 60;
      
      public static const MAX_VOTEPERSON:int = 50;
      
      public static const MAX_OFFICIALCOUNT:int = 4;
      
      public var MsgRespAccountAuth:MSG_RESP_ACCOUNTAUTH;
      
      public function MsgDefine()
      {
         super();
         this.MsgRespAccountAuth = new MSG_RESP_ACCOUNTAUTH();
      }
      
      public static function Instance() : MsgDefine
      {
         if(_instance == null)
         {
            _instance = new MsgDefine();
         }
         return _instance;
      }
      
      public function FillMsgLength(param1:ByteArray, param2:int) : void
      {
         if(param2 == 1)
         {
            param1.readByte();
         }
         else if(param2 == 2)
         {
            param1.readShort();
         }
         else
         {
            param1.readShort();
            param1.readByte();
         }
      }
      
      public function GetCharFromBuffer(param1:int) : int
      {
         return param1;
      }
      
      public function GetUnsignCharFromBuffer(param1:int) : int
      {
         if(param1 < 0)
         {
            param1 += 256;
         }
         return param1;
      }
      
      public function GetUnsignShortFromBuffer(param1:int, param2:int) : int
      {
         if(param1 < 0)
         {
            param1 += 256;
         }
         if(param2 < 0)
         {
            param2 += 256;
         }
         return param2 * 256 + param1;
      }
      
      public function GetShortFromBuffer(param1:int, param2:int) : int
      {
         var _loc3_:int = 0;
         if(param1 < 0)
         {
            param1 += 256;
         }
         if(param2 < 0)
         {
            param2 += 256;
         }
         _loc3_ = param2 * 256 + param1;
         if(_loc3_ > 32767)
         {
            _loc3_ -= 65536;
         }
         return _loc3_;
      }
      
      public function GetIntFromBuffer(param1:int, param2:int, param3:int, param4:int) : int
      {
         if(param1 < 0)
         {
            param1 += 256;
         }
         if(param2 < 0)
         {
            param2 += 256;
         }
         if(param3 < 0)
         {
            param3 += 256;
         }
         if(param4 < 0)
         {
            param4 += 256;
         }
         return param4 * 256 * 256 * 256 + param3 * 256 * 256 + param2 * 256 + param1;
      }
      
      public function GetInt64FromBuffer(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int) : Number
      {
         var _loc9_:Number = NaN;
         if(param1 < 0)
         {
            param1 += 256;
         }
         if(param2 < 0)
         {
            param2 += 256;
         }
         if(param3 < 0)
         {
            param3 += 256;
         }
         if(param4 < 0)
         {
            param4 += 256;
         }
         if(param5 < 0)
         {
            param5 += 256;
         }
         if(param6 < 0)
         {
            param6 += 256;
         }
         if(param7 < 0)
         {
            param7 += 256;
         }
         if(param8 < 0)
         {
            param8 += 256;
         }
         if(param8 > 127)
         {
            param1 = 255 - param1;
            param2 = 255 - param2;
            param3 = 255 - param3;
            param4 = 255 - param4;
            param5 = 255 - param5;
            param6 = 255 - param6;
            param7 = 255 - param7;
            param8 = 255 - param8;
            _loc9_ = param8 * 256 * 256 * 256 * 256 * 256 * 256 * 256 + param7 * 256 * 256 * 256 * 256 * 256 * 256 + param6 * 256 * 256 * 256 * 256 * 256 + param5 * 256 * 256 * 256 * 256 + param4 * 256 * 256 * 256 + param3 * 256 * 256 + param2 * 256 + param1;
            _loc9_ = -_loc9_ - 1;
         }
         else
         {
            _loc9_ = param8 * 256 * 256 * 256 * 256 * 256 * 256 * 256 + param7 * 256 * 256 * 256 * 256 * 256 * 256 + param6 * 256 * 256 * 256 * 256 * 256 + param5 * 256 * 256 * 256 * 256 + param4 * 256 * 256 * 256 + param3 * 256 * 256 + param2 * 256 + param1;
         }
         return _loc9_;
      }
      
      public function GetStrFromBuffer(param1:ByteArray, param2:int) : String
      {
         var _loc3_:String = "";
         return param1.readMultiByte(param2,"utf-8");
      }
      
      public function Resp_MSG_RESP_ACCOUNTAUTH(param1:int, param2:ByteArray) : void
      {
         this.MsgRespAccountAuth.Result = param2.readByte();
         this.MsgRespAccountAuth.cIP = param2.readMultiByte(MsgTypes.MAX_NAME,"utf-8");
         this.FillMsgLength(param2,1);
         this.MsgRespAccountAuth.uiPort = this.GetShortFromBuffer(param2.readByte(),param2.readByte());
         this.MsgRespAccountAuth.cCheckOutText = param2.readMultiByte(MsgTypes.VALIDATECODE_LENTH,"utf-8");
         this.MsgRespAccountAuth.Accounts = param2.readMultiByte(MsgTypes.MAX_NAME,"utf-8");
      }
      
      public function GetWideChar(param1:int, param2:ByteArray) : String
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = "";
         var _loc6_:Boolean = false;
         var _loc7_:int = int(param2.position);
         while(_loc7_ < param2.position + param1)
         {
            if(_loc4_ % 2 == 0)
            {
               _loc3_ = param2[_loc7_] + param2[_loc7_ + 1] * 256;
               if(_loc3_ == 0)
               {
                  _loc6_ = true;
               }
               if(_loc6_)
               {
                  break;
               }
               _loc5_ += String.fromCharCode(_loc3_);
            }
            _loc4_++;
            _loc7_++;
         }
         param2.position += param1;
         return _loc5_;
      }
      
      public function Message_DecodeEncode_Send(param1:ByteArray, param2:int, param3:int) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:int = 4;
         if(param3 > 0)
         {
            _loc5_ = (param2 + 1979) % 256;
            _loc6_ = 0;
            while(_loc6_ < param3)
            {
               param1[_loc4_] ^= _loc5_;
               _loc4_++;
               _loc6_++;
            }
         }
      }
      
      public function Message_DecodeEncode_Get(param1:ByteArray, param2:int, param3:int) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         if(param3 > 0)
         {
            _loc5_ = (param2 + 1979) % 256;
            _loc6_ = 0;
            while(_loc6_ < param3)
            {
               param1[_loc4_] ^= _loc5_;
               _loc4_++;
               _loc6_++;
            }
         }
      }
   }
}

class MSG_RESP_ACCOUNTAUTH
{
   
   public var Result:int;
   
   public var cIP:String;
   
   public var uiPort:int;
   
   public var cCheckOutText:String;
   
   public var Accounts:String;
   
   public function MSG_RESP_ACCOUNTAUTH()
   {
      super();
   }
}
