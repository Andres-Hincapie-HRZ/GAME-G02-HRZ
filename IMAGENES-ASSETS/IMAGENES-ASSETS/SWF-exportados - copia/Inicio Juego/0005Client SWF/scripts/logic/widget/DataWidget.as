package logic.widget
{
   import logic.entry.GamePlayer;
   
   public class DataWidget
   {
      
      public function DataWidget()
      {
         super();
      }
      
      public static function localToDataZone(param1:int) : String
      {
         return secondFormatToTime(param1);
      }
      
      private static function toFormat(param1:int) : String
      {
         return param1 < 10 ? "0" + param1 : param1 + "";
      }
      
      public static function secondFormatToTime(param1:int, param2:String = ":") : String
      {
         var _loc3_:int = 0;
         _loc3_ = param1 % 60;
         var _loc4_:String = _loc3_ < 10 ? "0" + _loc3_ : _loc3_ + "";
         _loc3_ = Math.floor(param1 / 60) % 60;
         var _loc5_:String = _loc3_ < 10 ? "0" + _loc3_ : _loc3_ + "";
         _loc3_ = Math.floor(param1 / 3600);
         var _loc6_:String = _loc3_ < 10 ? "0" + _loc3_ : _loc3_ + "";
         return _loc6_ + param2 + _loc5_ + param2 + _loc4_;
      }
      
      public static function GetDateTime(param1:Number) : String
      {
         var _loc3_:String = null;
         var _loc2_:Date = new Date(param1);
         if(GamePlayer.getInstance().language == 0)
         {
            _loc3_ = FormateNumber(_loc2_.fullYear) + "-" + FormateNumber(_loc2_.getMonth() + 1) + "-" + FormateNumber(_loc2_.getDate()) + " " + FormateNumber(_loc2_.getHours()) + ":" + FormateNumber(_loc2_.getMinutes()) + ":" + FormateNumber(_loc2_.getSeconds());
         }
         else
         {
            _loc3_ = _loc2_.getMonth() + 1 + "-" + _loc2_.getDate() + "-" + _loc2_.fullYear + " " + _loc2_.getHours() + ":" + _loc2_.getMinutes() + ":" + _loc2_.getSeconds();
         }
         return _loc3_;
      }
      
      public static function GetTimeString2(param1:int) : String
      {
         var _loc2_:uint = uint(param1 / 60 / 60 >> 0);
         var _loc3_:uint = param1 / 60 % 60;
         var _loc4_:uint = param1 % 60;
         return FormateNumber(_loc2_) + ":" + FormateNumber(_loc3_);
      }
      
      public static function GetTimeString(param1:int) : String
      {
         var _loc2_:uint = uint(param1 / 60 / 60 >> 0);
         var _loc3_:uint = param1 / 60 % 60;
         var _loc4_:uint = param1 % 60;
         return FormateNumber(_loc2_) + ":" + FormateNumber(_loc3_) + ":" + FormateNumber(_loc4_);
      }
      
      public static function FormateNumber(param1:int) : String
      {
         var _loc2_:String = param1.toString();
         if(_loc2_.length < 2)
         {
            _loc2_ = "0" + _loc2_;
         }
         return _loc2_;
      }
   }
}

