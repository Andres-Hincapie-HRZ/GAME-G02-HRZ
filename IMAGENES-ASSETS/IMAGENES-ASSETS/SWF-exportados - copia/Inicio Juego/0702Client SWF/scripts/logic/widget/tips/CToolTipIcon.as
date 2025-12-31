package logic.widget.tips
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.geom.RectangleKit;
   import flash.display.Bitmap;
   
   public class CToolTipIcon
   {
      
      private var _instance:Container;
      
      private var _IconType:String;
      
      private var _rect:RectangleKit;
      
      public function CToolTipIcon(param1:String)
      {
         super();
         this._IconType = param1;
         this._instance = new Container("CToolTipIcon_" + param1);
         this._instance.mouseChildren = false;
         this.setIcon();
      }
      
      public function getInstance() : Container
      {
         return this._instance;
      }
      
      private function setIcon() : void
      {
         var _loc1_:Bitmap = CToolTipIconLoader.getTexture(this._IconType);
         this._instance.addChild(CToolTipIconLoader.getTexture(this._IconType));
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._instance.numChildren)
         {
            this._instance.removeChildAt(_loc1_);
            _loc1_++;
         }
      }
      
      public function getHeigth() : int
      {
         return this._instance.height;
      }
      
      public function setHeight(param1:int) : void
      {
         this._instance.height = param1;
      }
      
      public function setWidth(param1:int) : void
      {
         this._instance.width = param1;
      }
      
      public function getWidth() : int
      {
         return this._instance.width;
      }
      
      public function setLocationXY(param1:int, param2:int) : void
      {
         this._instance.x = param1;
         this._instance.y = param2;
      }
      
      public function setWH(param1:int = 0, param2:int = 0) : void
      {
         this._instance.width = param1;
         this._instance.height = param2;
      }
   }
}

