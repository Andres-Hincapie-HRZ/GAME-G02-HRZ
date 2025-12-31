package logic.entry.test
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import logic.game.GameKernel;
   
   public class Dirt extends Bitmap
   {
      
      private var _resKey:String;
      
      private var _moveNum:Number;
      
      private var _drag:Boolean = false;
      
      private var _startX:int = -999;
      
      private var _startY:int = -999;
      
      public function Dirt(param1:String)
      {
         super();
         this._resKey = param1;
         var _loc2_:BitmapData = GameKernel.getTextureInstance(param1);
         if(_loc2_)
         {
            this.bitmapData = _loc2_;
         }
      }
      
      public function BeginDrag() : void
      {
         this._drag = true;
         this._startX = x;
         this._startY = y;
      }
      
      public function EndDrag() : void
      {
         this._drag = false;
         this._startX = -999;
         this._startY = -999;
      }
      
      public function Draging(param1:int, param2:int) : void
      {
         x = this.startX + param1 * this.moveNum;
         y = this.startY + param2 * this.moveNum;
      }
      
      public function get moveNum() : Number
      {
         return this._moveNum;
      }
      
      public function set moveNum(param1:Number) : void
      {
         this._moveNum = param1;
      }
      
      public function get resKey() : String
      {
         return this._resKey;
      }
      
      public function get startX() : int
      {
         return this._startX;
      }
      
      public function set startX(param1:int) : void
      {
         this._startX = param1;
      }
      
      public function get startY() : int
      {
         return this._startY;
      }
      
      public function set startY(param1:int) : void
      {
         this._startY = param1;
      }
      
      public function get drag() : Boolean
      {
         return this._drag;
      }
      
      public function set drag(param1:Boolean) : void
      {
         this._drag = param1;
      }
   }
}

