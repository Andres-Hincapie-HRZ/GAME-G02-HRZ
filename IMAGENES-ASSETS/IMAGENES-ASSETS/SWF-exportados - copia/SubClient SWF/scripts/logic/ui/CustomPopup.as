package logic.ui
{
   import flash.display.MovieClip;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import gs.TweenLite;
   
   public class CustomPopup
   {
      
      private var _TextField:TextField;
      
      private var _parent:MovieClip;
      
      public function CustomPopup()
      {
         super();
         this._TextField = new TextField();
      }
      
      public function SetText(param1:MovieClip, param2:String, param3:Point, param4:int = 1, param5:int = 30, param6:int = 2) : void
      {
         this._TextField.x = param3.x;
         this._TextField.y = param3.y;
         this._TextField.text = param2;
         param1.addChild(this._TextField);
         this._parent = param1;
         var _loc7_:TextFormat = new TextFormat();
         _loc7_.color = 16763907;
         _loc7_.size = 14;
         _loc7_.bold = 1;
         this._TextField.setTextFormat(_loc7_);
         TweenLite.to(this._TextField,param6,{
            "x":param3.x,
            "y":param3.y - param5,
            "alpha":1,
            "onComplete":this.ShowComplete
         });
      }
      
      private function ShowComplete() : void
      {
         if(this._parent.contains(this._TextField))
         {
            this._parent.removeChild(this._TextField);
         }
      }
   }
}

