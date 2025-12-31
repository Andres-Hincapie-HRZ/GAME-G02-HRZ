package logic.entry
{
   import com.star.frameworks.geom.PointKit;
   import flash.display.Shape;
   import logic.action.StarSurfaceAction;
   import logic.widget.PrimitiveWidget;
   
   public class StarSufaceMarkZone
   {
      
      private static var instance:StarSufaceMarkZone;
      
      private static const VAR:Number = 1.25;
      
      private var _starSurFaceAction:StarSurfaceAction;
      
      private var _isOpen:Boolean;
      
      private var _center:Shape;
      
      private var _border:Shape;
      
      private var p1:PointKit;
      
      private var p2:PointKit;
      
      private var p3:PointKit;
      
      private var p4:PointKit;
      
      public function StarSufaceMarkZone()
      {
         super();
         this.p1 = new PointKit(0,400 * StarSufaceMarkZone.VAR);
         this.p2 = new PointKit(800 * StarSufaceMarkZone.VAR,0);
         this.p3 = new PointKit(1600 * StarSufaceMarkZone.VAR,400 * StarSufaceMarkZone.VAR);
         this.p4 = new PointKit(800 * StarSufaceMarkZone.VAR,800 * StarSufaceMarkZone.VAR);
         this._starSurFaceAction = StarSurfaceAction.getInstance();
      }
      
      public static function getInstance() : StarSufaceMarkZone
      {
         if(instance == null)
         {
            instance = new StarSufaceMarkZone();
         }
         return instance;
      }
      
      public function get BorderMarkZone() : Shape
      {
         return this._border;
      }
      
      public function get CenterMarkZone() : Shape
      {
         return this._center;
      }
      
      public function rePaint(param1:int, param2:int, param3:PointKit, param4:PointKit, param5:PointKit, param6:PointKit) : void
      {
         this.p1 = param3;
         this.p2 = param4;
         this.p3 = param5;
         this.p4 = param6;
         this.Draw(param1,param2);
      }
      
      public function Draw(param1:int, param2:int) : void
      {
         this.paintBorder(param1,param2);
         this.paintCenter(param1,param2);
      }
      
      internal function paintCenter(param1:int, param2:int) : void
      {
         this._center = new Shape();
         this._center.graphics.clear();
         this._center.graphics.beginFill(16777215,0.001);
         this._center.graphics.moveTo(this.p1.x,this.p1.y);
         this._center.graphics.lineTo(this.p2.x,this.p2.y);
         this._center.graphics.lineTo(this.p3.x,this.p3.y);
         this._center.graphics.lineTo(this.p4.x,this.p4.y);
         this._center.graphics.lineTo(this.p1.x,this.p1.y);
         this._center.x = param1;
         this._center.y = param2;
         this._starSurFaceAction.LayOut.addChildAt(this._center,0);
      }
      
      internal function paintBorder(param1:int, param2:int) : void
      {
         if(this._border)
         {
            this._border.graphics.clear();
         }
         this._border = PrimitiveWidget.drawRect(param1,param2,this.p1,this.p2,this.p3,this.p4,5456944);
         this._starSurFaceAction.LayOut.addChildAt(this._border,0);
      }
   }
}

