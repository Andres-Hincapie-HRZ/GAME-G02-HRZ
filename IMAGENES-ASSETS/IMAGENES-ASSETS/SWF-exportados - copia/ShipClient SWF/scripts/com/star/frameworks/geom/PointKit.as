package com.star.frameworks.geom
{
   import flash.geom.Point;
   
   public class PointKit
   {
      
      public var x:int = 0;
      
      public var y:int = 0;
      
      public function PointKit(param1:int = 0, param2:int = 0)
      {
         super();
         this.x = param1;
         this.y = param2;
      }
      
      public function toPoint() : Point
      {
         return new Point(this.x,this.y);
      }
      
      public function toReversePoint() : Point
      {
         return new Point(this.y,this.x);
      }
      
      public function setPoint(param1:Point) : void
      {
         this.x = param1.x;
         this.y = param1.y;
      }
      
      public function createPoint(param1:Point) : PointKit
      {
         return new PointKit(param1.x,param1.y);
      }
      
      public function setLocation(param1:PointKit) : void
      {
         this.x = param1.x;
         this.y = param1.y;
      }
      
      public function setLocationXY(param1:int, param2:int) : void
      {
         this.x = param1;
         this.y = param2;
      }
      
      public function movePointKit(param1:int, param2:int) : PointKit
      {
         this.x += param1;
         this.y += param2;
         return this;
      }
      
      public function moveRadians(param1:int, param2:int) : PointKit
      {
         this.x += Math.round(Math.cos(param1) * param2);
         this.y += Math.round(Math.sin(param1) * param2);
         return this;
      }
      
      public function distanceTwoPointKitSq(param1:PointKit) : int
      {
         return (this.x - param1.x) * (this.x - param1.x) + (this.y - param1.y) * (this.y - param1.y);
      }
      
      public function distanceTwoPointKit(param1:PointKit) : int
      {
         return Math.sqrt(this.distanceTwoPointKit(param1));
      }
      
      public function clonePointKit() : PointKit
      {
         return new PointKit(this.x,this.y);
      }
      
      public function toString() : String
      {
         return "PointKit[" + this.x + "," + this.y + "]";
      }
      
      public function equels(param1:Object) : Boolean
      {
         var _loc2_:PointKit = param1 as PointKit;
         if(_loc2_ == null)
         {
            return false;
         }
         return this.x === _loc2_.x && this.y === _loc2_.y;
      }
   }
}

