package logic.ui.tip
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class CaptionTip
   {
      
      private var _McCaption:MovieClip;
      
      private var _TipText:String;
      
      private var _TipDirection:int;
      
      private var _ShowPoint:Point;
      
      public function CaptionTip(param1:MovieClip, param2:String, param3:int = 1)
      {
         super();
         this._McCaption = param1;
         this._TipText = param2;
         switch(param3)
         {
            case 0:
               this._ShowPoint = new Point(0,0);
               break;
            case 1:
               this._ShowPoint = new Point(0,param1.height / this._McCaption.scaleY);
               break;
            case 2:
               this._ShowPoint = new Point(0,0);
               break;
            case 3:
               this._ShowPoint = new Point(param1.width / this._McCaption.scaleX,0);
         }
         param1.addEventListener(MouseEvent.MOUSE_OVER,this.ShowTip);
         param1.addEventListener(MouseEvent.MOUSE_OUT,this.HideTip);
      }
      
      private function ShowTip(param1:MouseEvent) : void
      {
         var _loc2_:Point = this._McCaption.localToGlobal(this._ShowPoint);
         CustomTip.GetInstance().ShowTip(this._TipText,_loc2_);
      }
      
      private function HideTip(param1:MouseEvent) : void
      {
         CustomTip.GetInstance().Hide();
      }
   }
}

