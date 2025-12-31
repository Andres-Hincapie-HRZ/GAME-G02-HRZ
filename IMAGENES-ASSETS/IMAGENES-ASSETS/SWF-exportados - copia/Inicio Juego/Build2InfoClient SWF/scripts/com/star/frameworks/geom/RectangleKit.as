package com.star.frameworks.geom
{
   import flash.geom.Rectangle;
   
   public class RectangleKit
   {
      
      public var x:int = 0;
      
      public var y:int = 0;
      
      public var width:int = 0;
      
      public var height:int = 0;
      
      public function RectangleKit(param1:int = 0, param2:int = 0, param3:int = 0, param4:int = 0)
      {
         super();
         this.setXYWH(param1,param2,param3,param4);
      }
      
      public static function CreateRectangleKit(param1:Rectangle) : RectangleKit
      {
         return new RectangleKit(param1.x,param1.y,param1.width,param1.height);
      }
      
      public function toRectangle() : Rectangle
      {
         return new Rectangle(this.x,this.y,this.width,this.height);
      }
      
      public function setRectangle(param1:Rectangle) : void
      {
         this.x = param1.x;
         this.y = param1.y;
         this.width = param1.width;
         this.height = param1.height;
      }
      
      public function setXYWH(param1:int, param2:int, param3:int, param4:int) : void
      {
         this.x = param1;
         this.y = param2;
         this.width = param3;
         this.height = param4;
      }
      
      public function getLocation() : PointKit
      {
         return new PointKit(this.x,this.y);
      }
      
      public function setLocation(param1:PointKit) : void
      {
         this.x = param1.x;
         this.y = param1.y;
      }
      
      public function setDimension(param1:DimensionKit) : void
      {
         this.width = param1.width;
         this.height = param1.height;
      }
      
      public function moveRectangleKit(param1:int, param2:int) : void
      {
         this.x += param1;
         this.y += param2;
      }
      
      public function getLeftTop() : PointKit
      {
         return new PointKit(this.x,this.y);
      }
      
      public function getRightTip() : PointKit
      {
         return new PointKit(this.x + this.width,this.y);
      }
      
      public function getLeftBottom() : PointKit
      {
         return new PointKit(this.x,this.y + this.height);
      }
      
      public function getRightBottom() : PointKit
      {
         return new PointKit(this.x + this.width,this.y + this.height);
      }
      
      public function clone() : RectangleKit
      {
         return new RectangleKit(this.x,this.y,this.width,this.height);
      }
      
      public function Merger(param1:int = 0, param2:int = 0, param3:int = 0, param4:int = 0) : RectangleKit
      {
         var _loc5_:RectangleKit = new RectangleKit();
         _loc5_.x = this.x + param1;
         _loc5_.y = this.y + param2;
         _loc5_.width = this.width + param3;
         _loc5_.height = this.height + param4;
         return _loc5_;
      }
      
      public function containerPointKit(param1:PointKit) : Boolean
      {
         if(param1.x < this.x || param1.y < this.y || param1.x > this.x + this.width || param1.y > this.y + this.height)
         {
            return false;
         }
         return true;
      }
      
      public function equals(param1:Object) : Boolean
      {
         var _loc2_:RectangleKit = param1 as RectangleKit;
         if(_loc2_ == null)
         {
            return false;
         }
         return this.x == _loc2_.x && this.y == _loc2_.y && this.width == _loc2_.width && this.height == _loc2_.height;
      }
      
      public function toString() : String
      {
         return "RectangleKit[x:" + this.x + ",y:" + this.y + ",width:" + this.width + ",height:" + this.height + "]";
      }
   }
}

