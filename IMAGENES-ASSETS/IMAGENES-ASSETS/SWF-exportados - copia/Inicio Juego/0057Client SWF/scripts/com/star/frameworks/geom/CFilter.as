package com.star.frameworks.geom
{
   import flash.filters.ColorMatrixFilter;
   
   public class CFilter
   {
      
      private var colorMatrix:ColorMatrixFilter;
      
      public function CFilter()
      {
         super();
         this.colorMatrix = new ColorMatrixFilter();
      }
      
      public function getFilter(param1:Boolean = false) : Array
      {
         var _loc2_:Array = new Array();
         if(!param1)
         {
            return null;
         }
         _loc2_.push(this.colorMatrix);
         return _loc2_;
      }
      
      public function generate_colorMatrix_filter(param1:uint = 0) : void
      {
         this.colorMatrix.matrix = [0.3086 * (1 - param1) + param1,0.6094 * (1 - param1),0.082 * (1 - param1),0,0,0.3086 * (1 - param1),0.6094 * (1 - param1) + param1,0.082 * (1 - param1),0,0,0.3086 * (1 - param1),0.6094 * (1 - param1),0.082 * (1 - param1) + param1,0,0,0,0,0,1,0];
      }
      
      public function generate_brightness_filter(param1:Number = 0) : void
      {
         this.colorMatrix.matrix = [1,0,0,0,param1,0,1,0,0,param1,0,0,1,0,param1,0,0,0,1,0];
      }
      
      public function generate_constrast_filter(param1:uint = 0) : void
      {
         this.colorMatrix.matrix = [param1,0,0,0,128 * (1 - param1),0,param1,0,0,128 * (1 - param1),0,0,param1,0,128 * (1 - param1),0,0,0,1,0];
      }
      
      public function generate_rever_filter() : void
      {
         this.colorMatrix.matrix = [-1,0,0,0,255,0,-1,0,0,255,0,0,-1,0,255,0,0,0,1,0];
      }
      
      public function generate_threshold_filter(param1:uint) : void
      {
         this.colorMatrix.matrix = [0.3086 * 256,0.6094 * 256,0.082 * 256,0,-256 * param1,0.3086 * 256,0.6094 * 256,0.082 * 256,0,-256 * param1,0.3086 * 256,0.6094 * 256,0.082 * 256,0,-256 * param1,0,0,0,1,0];
      }
      
      public function generate_colorChannel_filter(param1:int = 0, param2:int = 0, param3:int = 0, param4:int = 1) : void
      {
         this.colorMatrix.matrix = [param1,0,0,0,0,0,param2,0,0,0,0,0,param3,0,0,0,0,0,param4,0];
      }
   }
}

