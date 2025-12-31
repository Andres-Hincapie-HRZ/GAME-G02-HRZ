package logic.game
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class GameFont
   {
      
      public static var numberTexture:BitmapData = GameKernel.getTextureInstance("font.png");
      
      private static const charWidth:int = 8;
      
      private static const charHeight:int = 9;
      
      public function GameFont()
      {
         super();
      }
      
      public static function getInt(param1:int) : BitmapData
      {
         var _loc4_:int = 0;
         var _loc2_:String = param1.toString();
         var _loc3_:BitmapData = new BitmapData(charWidth * _loc2_.length,charHeight);
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc4_ = parseInt(_loc2_.charAt(_loc5_),10);
            _loc3_.copyPixels(numberTexture,new Rectangle(charWidth * _loc4_,0,charWidth,charHeight),new Point(charWidth * _loc5_,0));
            _loc5_++;
         }
         return _loc3_;
      }
      
      public static function getIntByString(param1:String) : BitmapData
      {
         var _loc5_:int = 0;
         var _loc2_:RegExp = /^\d+$/g;
         var _loc3_:Boolean = Boolean(_loc2_.test(param1));
         if(!_loc3_)
         {
            return null;
         }
         var _loc4_:BitmapData = new BitmapData(charWidth * param1.length,charHeight);
         var _loc6_:int = 0;
         while(_loc6_ < param1.length)
         {
            _loc5_ = parseInt(param1.charAt(_loc6_),10);
            _loc4_.copyPixels(numberTexture,new Rectangle(charWidth * _loc5_,0,charWidth,charHeight),new Point(charWidth * _loc6_,0));
            _loc6_++;
         }
         return _loc4_;
      }
   }
}

