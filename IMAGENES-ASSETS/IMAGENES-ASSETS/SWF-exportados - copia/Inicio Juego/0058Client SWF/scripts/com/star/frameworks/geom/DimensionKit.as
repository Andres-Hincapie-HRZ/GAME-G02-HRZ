package com.star.frameworks.geom
{
   public class DimensionKit
   {
      
      public var width:int = 0;
      
      public var height:int = 0;
      
      public function DimensionKit(param1:int = 0, param2:int = 0)
      {
         super();
         this.width = param1;
         this.height = param2;
      }
      
      public function setSize(param1:DimensionKit) : void
      {
         this.width = param1.width;
         this.height = param1.height;
      }
      
      public function setSizeWH(param1:int, param2:int) : void
      {
         this.width = param1;
         this.height = param2;
      }
      
      public function increaseSize(param1:DimensionKit) : DimensionKit
      {
         this.width += param1.width;
         this.height += param1.height;
         return this;
      }
      
      public function decreaseSize(param1:DimensionKit) : DimensionKit
      {
         this.width -= param1.width;
         this.height -= param1.height;
         return this;
      }
      
      public function change(param1:int, param2:int) : DimensionKit
      {
         this.width += param1;
         this.height += param2;
         return this;
      }
      
      public function combineSize(param1:DimensionKit) : DimensionKit
      {
         this.width = Math.max(this.width,param1.width);
         this.height = Math.max(this.height,param1.height);
         return this;
      }
      
      public function getBound(param1:int = 0, param2:int = 0) : RectangleKit
      {
         var _loc3_:PointKit = new PointKit(param1,param2);
         var _loc4_:RectangleKit = new RectangleKit();
         _loc4_.setLocation(_loc3_);
         _loc4_.setDimension(this);
         return _loc4_;
      }
      
      public function equals(param1:Object) : Boolean
      {
         var _loc2_:DimensionKit = param1 as DimensionKit;
         if(_loc2_ == null)
         {
            return false;
         }
         return this.width === _loc2_.width && this.height === _loc2_.height;
      }
      
      public function clone() : DimensionKit
      {
         return new DimensionKit(this.width,this.height);
      }
      
      public function toString() : String
      {
         return "DimensionKit[" + this.width + "," + this.height + "]";
      }
   }
}

