package logic.widget
{
   import com.star.frameworks.geom.PointKit;
   import flash.display.Shape;
   
   public class PrimitiveWidget
   {
      
      public function PrimitiveWidget()
      {
         super();
      }
      
      public static function drawSegement(param1:int, param2:int, param3:PointKit, param4:PointKit, param5:uint = 16777215, param6:uint = 16711680, param7:Number = 0.5, param8:Number = 5) : Shape
      {
         var _loc9_:Shape = new Shape();
         _loc9_.graphics.clear();
         _loc9_.graphics.lineStyle(param8,param5);
         _loc9_.graphics.beginFill(param6,param7);
         _loc9_.graphics.moveTo(param3.x,param3.y);
         _loc9_.graphics.lineTo(param4.x,param4.y);
         _loc9_.x = param1;
         _loc9_.y = param2;
         return _loc9_;
      }
      
      public static function drawRect(param1:int, param2:int, param3:PointKit, param4:PointKit, param5:PointKit, param6:PointKit, param7:uint = 16777215, param8:uint = 16711680, param9:Number = 0.5, param10:Number = 2) : Shape
      {
         var _loc11_:Shape = null;
         _loc11_ = new Shape();
         _loc11_.graphics.clear();
         _loc11_.graphics.lineStyle(param10,param7);
         _loc11_.graphics.moveTo(param3.x,param3.y);
         _loc11_.graphics.lineTo(param4.x,param4.y);
         _loc11_.graphics.lineTo(param5.x,param5.y);
         _loc11_.graphics.lineTo(param6.x,param6.y);
         _loc11_.graphics.lineTo(param3.x,param3.y);
         _loc11_.x = param1;
         _loc11_.y = param2;
         return _loc11_;
      }
   }
}

