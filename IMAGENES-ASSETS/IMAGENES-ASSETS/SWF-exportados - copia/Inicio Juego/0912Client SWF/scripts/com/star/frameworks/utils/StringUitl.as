package com.star.frameworks.utils
{
   import com.star.frameworks.errors.CError;
   
   public class StringUitl
   {
      
      public function StringUitl()
      {
         super();
      }
      
      public static function splitStrToArray(param1:String, param2:String = ".") : Array
      {
         if(param1 == null)
         {
            return null;
         }
         return param1.split(param2);
      }
      
      public static function delSuffix(param1:String) : String
      {
         if(param1.indexOf(".") == -1)
         {
            return param1;
         }
         return param1.split(".")[0];
      }
      
      public static function Trim(param1:String) : String
      {
         if(ObjectUtil.isNull(param1))
         {
            return "";
         }
         param1 = param1.replace(/^\s+/,"");
         return param1.replace(/\s+$/,"");
      }
      
      public static function Replace(param1:String, param2:String) : String
      {
         if(ObjectUtil.isNull(param1) && !ObjectUtil.isString(param1))
         {
            throw new CError("字符串对象为空或者类型不匹配");
         }
         return param1.replace(param1,param2);
      }
      
      public static function getStrPrex(param1:String) : String
      {
         if(param1.indexOf("_") != -1)
         {
            return param1.split("_")[0];
         }
         return param1;
      }
      
      public static function splitInfluenceStr(param1:String) : Object
      {
         var _loc2_:Array = param1.split(":");
         var _loc3_:Object = new Object();
         _loc3_.X = _loc2_[0];
         _loc3_.Y = _loc2_[1];
         return _loc3_;
      }
      
      public static function toint(param1:String) : int
      {
         if(param1 == "")
         {
            return 0;
         }
         var _loc2_:String = "";
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            if(param1.charAt(_loc3_) != ",")
            {
               _loc2_ += param1.charAt(_loc3_);
            }
            _loc3_++;
         }
         return int(_loc2_);
      }
      
      public static function toUSFormat(param1:int) : String
      {
         if(param1 <= 0)
         {
            return param1.toString();
         }
         var _loc2_:String = param1.toString();
         var _loc3_:String = ",";
         var _loc4_:int = _loc2_.length;
         if(_loc4_ <= 3)
         {
            return _loc2_;
         }
         var _loc5_:int = 3;
         var _loc6_:String = "";
         var _loc7_:String = "";
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         if(_loc4_ % _loc5_ == 0)
         {
            _loc8_ = _loc4_ / _loc5_;
         }
         else
         {
            _loc8_ = int(_loc4_ / _loc5_) + 1;
         }
         var _loc10_:int = 1;
         while(_loc10_ <= _loc8_)
         {
            _loc9_ = _loc4_ - _loc10_ * _loc5_;
            if(_loc9_ < 0)
            {
               _loc6_ = _loc2_.substr(0,_loc5_ + _loc9_);
            }
            else
            {
               _loc6_ = _loc2_.substr(_loc9_,_loc5_);
            }
            _loc7_ = _loc6_.concat(_loc7_);
            if(_loc9_ > 0)
            {
               _loc7_ = _loc3_.concat(_loc7_);
            }
            _loc10_++;
         }
         return _loc7_;
      }
      
      public static function getMathFormatTwo(param1:String) : String
      {
         var _loc2_:Array = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(param1 == "" || param1 == null)
         {
            return "";
         }
         if(param1.indexOf(".") != -1)
         {
            _loc2_ = param1.split(".");
            _loc3_ = _loc2_[0];
            _loc4_ = String(_loc2_[1]).substr(0,1);
            _loc3_ = _loc3_.concat(".");
            return _loc3_.concat(_loc4_);
         }
         return param1.concat(".") + "0";
      }
   }
}

