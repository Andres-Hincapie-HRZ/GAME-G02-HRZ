package logic.ui
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import logic.entry.HButton;
   
   public class XButton extends HButton
   {
      
      private var _OnClick:Function;
      
      private var _OnMouseOver:Function;
      
      private var _OnDoubleClick:Function;
      
      private var _OnMouseDown:Function;
      
      private var _OnMouseUp:Function;
      
      public var Data:*;
      
      public function XButton(param1:MovieClip, param2:int = 2, param3:Boolean = false, param4:String = "", param5:Boolean = false)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      public function set OnClick(param1:Function) : void
      {
         this._OnClick = param1;
         if(this._OnClick != null)
         {
            this.m_movie.addEventListener(MouseEvent.CLICK,this.ButtonClick);
         }
         else
         {
            this.m_movie.removeEventListener(MouseEvent.CLICK,this.ButtonClick);
         }
      }
      
      public function set OnMouseOver(param1:Function) : void
      {
         this._OnMouseOver = param1;
         if(this._OnMouseOver != null)
         {
            this.m_movie.addEventListener(MouseEvent.MOUSE_OVER,this.ButtonMouseOver);
         }
         else
         {
            this.m_movie.removeEventListener(MouseEvent.MOUSE_OVER,this.ButtonMouseOver);
         }
      }
      
      public function set OnDoubleClick(param1:Function) : void
      {
         this._OnDoubleClick = param1;
         if(this._OnDoubleClick != null)
         {
            this.m_movie.doubleClickEnabled = true;
            this.m_movie.addEventListener(MouseEvent.DOUBLE_CLICK,this.ButtonDoubleClick);
         }
         else
         {
            this.m_movie.doubleClickEnabled = false;
            this.m_movie.removeEventListener(MouseEvent.DOUBLE_CLICK,this.ButtonDoubleClick);
         }
      }
      
      public function set OnMouseDown(param1:Function) : void
      {
         this._OnMouseDown = param1;
         if(this._OnMouseDown != null)
         {
            this.m_movie.addEventListener(MouseEvent.MOUSE_DOWN,this.ButtonMouseDown);
         }
         else
         {
            this.m_movie.removeEventListener(MouseEvent.MOUSE_DOWN,this.ButtonMouseDown);
         }
      }
      
      public function set OnMouseUp(param1:Function) : void
      {
         this._OnMouseUp = param1;
         if(this._OnMouseUp != null)
         {
            this.m_movie.addEventListener(MouseEvent.MOUSE_UP,this.ButtonMouseUp);
         }
         else
         {
            this.m_movie.removeEventListener(MouseEvent.MOUSE_UP,this.ButtonMouseUp);
         }
      }
      
      public function DoClick() : void
      {
         this.ButtonClick(null);
      }
      
      private function ButtonClick(param1:MouseEvent) : void
      {
         if(this._OnClick != null)
         {
            this._OnClick(param1,this);
         }
      }
      
      private function ButtonMouseOver(param1:MouseEvent) : void
      {
         if(this._OnMouseOver != null)
         {
            this._OnMouseOver(param1,this);
         }
      }
      
      private function ButtonDoubleClick(param1:MouseEvent) : void
      {
         if(this._OnDoubleClick != null)
         {
            this._OnDoubleClick(param1,this);
         }
      }
      
      private function ButtonMouseDown(param1:MouseEvent) : void
      {
         if(this._OnMouseDown != null)
         {
            this._OnMouseDown(param1,this);
         }
      }
      
      private function ButtonMouseUp(param1:MouseEvent) : void
      {
         if(this._OnMouseUp != null)
         {
            this._OnMouseUp(param1,this);
         }
      }
   }
}

