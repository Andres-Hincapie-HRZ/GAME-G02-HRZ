package com.star.frameworks.managers
{
   import flash.filters.BitmapFilter;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class FontManager
   {
      
      private static var instance:FontManager;
      
      private var fmt_00:TextFormat;
      
      private var fmt_01:TextFormat;
      
      private var fmt_02:TextFormat;
      
      public function FontManager()
      {
         super();
      }
      
      public static function getInstance() : FontManager
      {
         if(instance == null)
         {
            instance = new FontManager();
         }
         return instance;
      }
      
      public static function applyTextFormat(param1:TextField, param2:uint = 12, param3:uint = 16777215, param4:Boolean = false, param5:String = "left", param6:Boolean = false, param7:Boolean = false) : void
      {
         var _loc8_:TextFormat = FontManager.getInstance().getTextFormat("Tahoma",param2,param3,param4,param5,param6,param7);
         if(param1)
         {
            param1.defaultTextFormat = _loc8_;
            param1.setTextFormat(_loc8_);
         }
      }
      
      public function getTitleFmt() : TextFormat
      {
         return this.fmt_00;
      }
      
      public function getContentFmt() : TextFormat
      {
         return this.fmt_01;
      }
      
      public function getMedicationContentFmt() : TextFormat
      {
         return this.fmt_02;
      }
      
      public function getTextFormat(param1:String = "Tahoma", param2:uint = 12, param3:uint = 0, param4:Boolean = false, param5:String = "left", param6:Boolean = false, param7:Boolean = false) : TextFormat
      {
         return new TextFormat(param1,param2,param3,param4,param6,param7,"","",param5);
      }
      
      public function getDefaultTextFilter(param1:uint = 7948288, param2:int = 4, param3:int = 40) : BitmapFilter
      {
         return new DropShadowFilter(0,90,param1,1,param2,param2,param3);
      }
      
      public function getDefaultTextFilter_1(param1:uint = 7948288, param2:int = 4, param3:int = 40, param4:int = 1) : BitmapFilter
      {
         return new GlowFilter(param1,1,param2,param2,param3,param4);
      }
      
      public function getCenterFormat() : TextFormat
      {
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.align = "center";
         return _loc1_;
      }
   }
}

