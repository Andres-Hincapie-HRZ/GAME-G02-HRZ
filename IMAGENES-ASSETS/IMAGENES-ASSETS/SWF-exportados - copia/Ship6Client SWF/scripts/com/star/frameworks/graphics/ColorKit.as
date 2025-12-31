package com.star.frameworks.graphics
{
   import flash.display.Bitmap;
   import flash.geom.ColorTransform;
   import flash.geom.Rectangle;
   
   public class ColorKit
   {
      
      public static const WHITE:ColorKit = new ColorKit(16777215);
      
      public static const LIGHT_GRAY:ColorKit = new ColorKit(12632256);
      
      public static const GRAY:ColorKit = new ColorKit(8421504);
      
      public static const DARK_GRAY:ColorKit = new ColorKit(4210752);
      
      public static const BLACK:ColorKit = new ColorKit(0);
      
      public static const RED:ColorKit = new ColorKit(16711680);
      
      public static const PINK:ColorKit = new ColorKit(16756655);
      
      public static const ORANGE:ColorKit = new ColorKit(16762880);
      
      public static const HALO_ORANGE:ColorKit = new ColorKit(16761344);
      
      public static const YELLOW:ColorKit = new ColorKit(16776960);
      
      public static const GREEN:ColorKit = new ColorKit(65280);
      
      public static const HALO_GREEN:ColorKit = new ColorKit(8453965);
      
      public static const MAGENTA:ColorKit = new ColorKit(16711935);
      
      public static const CYAN:ColorKit = new ColorKit(65535);
      
      public static const BLUE:ColorKit = new ColorKit(255);
      
      public static const HALO_BLUE:ColorKit = new ColorKit(2881013);
      
      protected var rgb:uint = 0;
      
      protected var alpha:Number = 1;
      
      public function ColorKit(param1:uint = 0, param2:Number = 1)
      {
         super();
         this.rgb = param1;
         this.alpha = param2;
      }
      
      public static function fillDressColor(param1:Bitmap, param2:uint) : void
      {
         var _loc3_:uint = uint(param2 & 16711680 >> 16);
         var _loc4_:uint = uint(param2 & 65280 >> 8);
         var _loc5_:uint = uint(param2 & 0xFF);
         param1.bitmapData.colorTransform(new Rectangle(0,0,param1.bitmapData.width,param1.bitmapData.height),new ColorTransform(_loc3_,_loc4_,_loc5_));
      }
      
      public static function blendColor(param1:uint, param2:Boolean = true) : ColorTransform
      {
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:ColorTransform = new ColorTransform();
         if(param2)
         {
            _loc4_ = uint(param1 >> 24 & 0xFF);
            _loc5_ = uint(param1 >> 16 & 0xFF);
            _loc6_ = uint(param1 >> 8 & 0xFF);
            _loc7_ = uint(param1 & 0xFF);
            _loc3_.redOffset = _loc5_;
            _loc3_.greenOffset = _loc6_;
            _loc3_.blueOffset = _loc7_;
         }
         else
         {
            _loc3_.color = param1;
         }
         return _loc3_;
      }
      
      public static function blendRedGreenBlueColor(param1:uint, param2:uint, param3:uint, param4:Array = null) : ColorTransform
      {
         if(!param4)
         {
            param4 = [1,1,1,1];
         }
         return new ColorTransform(param1,param2,param3,1,param4[0],param4[1],param4[2],param4[3]);
      }
      
      public function getAlpha() : Number
      {
         return this.alpha;
      }
      
      public function getRGB() : uint
      {
         return this.rgb;
      }
      
      public function getARGB() : uint
      {
         return this.rgb | this.alpha * 255 << 24;
      }
      
      public function getRed() : uint
      {
         return this.rgb >> 16 & 0xFF;
      }
      
      public function getGreen() : uint
      {
         return this.rgb >> 8 & 0xFF;
      }
      
      public function getBlue() : uint
      {
         return this.rgb & 0xFF;
      }
      
      public function newAlpha(param1:Number) : ColorKit
      {
         return new ColorKit(this.getRGB(),param1);
      }
      
      public function getRGBKit(param1:uint, param2:uint, param3:uint) : uint
      {
         var _loc4_:uint = param1;
         var _loc5_:uint = param2;
         var _loc6_:uint = param3;
         if(_loc4_ > 255)
         {
            _loc4_ = 255;
         }
         if(_loc5_ > 255)
         {
            _loc5_ = 255;
         }
         if(_loc6_ > 255)
         {
            _loc6_ = 255;
         }
         return (_loc4_ << 16) + (_loc5_ << 8) + _loc6_;
      }
      
      public function newRGBKit(param1:uint) : ColorKit
      {
         return new ColorKit(param1 & 0xFFFFFF,param1 >> 24 & 0xFF);
      }
      
      public function equals(param1:Object) : Boolean
      {
         var _loc2_:ColorKit = param1 as ColorKit;
         if(_loc2_ != null)
         {
            return _loc2_.alpha === this.alpha && _loc2_.rgb === this.rgb;
         }
         return false;
      }
   }
}

