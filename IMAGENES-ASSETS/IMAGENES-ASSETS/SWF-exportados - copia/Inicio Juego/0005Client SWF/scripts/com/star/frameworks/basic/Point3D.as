package com.star.frameworks.basic
{
   public class Point3D
   {
      
      public var x:Number;
      
      public var y:Number;
      
      public var z:Number;
      
      public function Point3D(param1:Number = 0, param2:Number = 0, param3:Number = 0)
      {
         super();
         this.x = param1;
         this.y = param2;
         this.z = param3;
      }
      
      public function toString() : String
      {
         return "[Point3D:" + "\tx:" + this.x + "\ty:" + this.y + "\tz:" + this.z + "]";
      }
   }
}

