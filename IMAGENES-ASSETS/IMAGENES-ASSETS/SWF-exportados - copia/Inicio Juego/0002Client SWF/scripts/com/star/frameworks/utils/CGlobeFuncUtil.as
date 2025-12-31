package com.star.frameworks.utils
{
   import com.star.frameworks.geom.RectangleKit;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   
   public class CGlobeFuncUtil
   {
      
      public function CGlobeFuncUtil()
      {
         super();
      }
      
      public static function ParserStrToRectangle(param1:String) : RectangleKit
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:Array = param1.split(",");
         return new RectangleKit(_loc2_[0],_loc2_[1],_loc2_[2],_loc2_[3]);
      }
      
      public static function ParserIntToString(param1:int) : String
      {
         var _loc2_:String = null;
         if(param1 < 10)
         {
            _loc2_ = "00" + param1;
         }
         else
         {
            _loc2_ = "0" + param1;
         }
         return _loc2_;
      }
      
      public static function BitmapDataToByteArray(param1:Bitmap) : ByteArray
      {
         var _loc2_:uint = param1.width;
         var _loc3_:uint = param1.height;
         var _loc4_:BitmapData = new BitmapData(_loc2_,_loc3_);
         _loc4_.draw(param1);
         var _loc5_:ByteArray = _loc4_.getPixels(new Rectangle(0,0,_loc2_,_loc3_));
         _loc5_.writeShort(_loc3_);
         _loc5_.writeShort(_loc2_);
         return _loc5_;
      }
      
      public static function ByteArrayToBitmap(param1:ByteArray) : Bitmap
      {
         var _loc8_:uint = 0;
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:ByteArray = param1;
         _loc2_.position = _loc2_.length - 2;
         var _loc3_:int = _loc2_.readShort();
         _loc2_.position = _loc2_.length - 4;
         var _loc4_:int = _loc2_.readShort();
         var _loc5_:BitmapData = new BitmapData(_loc3_,_loc4_,true);
         _loc2_.position = 0;
         var _loc6_:uint = 0;
         while(_loc6_ < _loc4_)
         {
            _loc8_ = 0;
            while(_loc8_ < _loc3_)
            {
               _loc5_.setPixel(_loc8_,_loc6_,_loc2_.readUnsignedInt());
               _loc8_++;
            }
            _loc6_++;
         }
         return new Bitmap(_loc5_);
      }
      
      public static function randRange(param1:Number, param2:Number) : Number
      {
         return Math.floor(Math.random() * (param2 - param1 + 1)) + param1;
      }
      
      public static function randPercent(param1:int) : Boolean
      {
         if(randRange(1,100) <= param1)
         {
            return true;
         }
         return false;
      }
      
      public static function copyTexture(param1:Bitmap, param2:String = null) : Bitmap
      {
         if(param1 == null)
         {
            return new Bitmap();
         }
         if(param1.bitmapData == null)
         {
            return new Bitmap();
         }
         var _loc3_:Bitmap = new Bitmap(param1.bitmapData.clone());
         if(param2)
         {
            _loc3_.name = param2;
         }
         return _loc3_;
      }
      
      public static function randRangeArray(param1:Array) : *
      {
         var _loc2_:int = 0;
         if(param1)
         {
            if(param1.length == 1)
            {
               return param1[0];
            }
            _loc2_ = randRange(0,param1.length - 1);
            return param1[_loc2_];
         }
         return null;
      }
      
      public static function makeString(param1:int) : String
      {
         var _loc2_:String = null;
         if(param1 < 10)
         {
            _loc2_ = "0" + param1;
         }
         else
         {
            _loc2_ = param1.toString();
         }
         return _loc2_;
      }
   }
}

