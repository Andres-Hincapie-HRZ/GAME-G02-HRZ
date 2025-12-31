package logic.ui
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class XTextField
   {
      
      private var _OnChange:Function;
      
      private var _TextField:TextField;
      
      public var Data:*;
      
      private var _DefaultText:String;
      
      private var TextFieldClicked:Boolean;
      
      private var _OnClick:Function;
      
      public function XTextField(param1:TextField, param2:String = null)
      {
         super();
         this._TextField = param1;
         if(param2 != null)
         {
            this.TextFieldClicked = false;
            this._DefaultText = param2;
            this._TextField.text = this._DefaultText;
            this._TextField.addEventListener(MouseEvent.CLICK,this.TextFieldClick);
         }
      }
      
      public function set OnClick(param1:Function) : void
      {
         this._OnClick = param1;
         if(this._OnClick != null)
         {
            this._TextField.addEventListener(MouseEvent.CLICK,this.TextClick);
         }
         else
         {
            this._TextField.removeEventListener(MouseEvent.CLICK,this.TextClick);
         }
      }
      
      public function set OnChange(param1:Function) : void
      {
         this._OnChange = param1;
         if(this._OnChange != null)
         {
            this._TextField.addEventListener(Event.CHANGE,this.TextChange);
         }
         else
         {
            this._TextField.removeEventListener(Event.CHANGE,this.TextChange);
         }
      }
      
      private function TextFieldClick(param1:MouseEvent) : void
      {
         if(!this.TextFieldClicked)
         {
            this._TextField.text = "";
            this.TextFieldClicked = true;
         }
      }
      
      public function ResetDefaultText() : void
      {
         this.TextFieldClicked = false;
         this._TextField.text = this._DefaultText;
      }
      
      public function get text() : String
      {
         return this._TextField.text;
      }
      
      public function set text(param1:String) : void
      {
         this._TextField.text = param1;
      }
      
      public function get DefaultText() : String
      {
         return this._DefaultText;
      }
      
      private function TextChange(param1:Event) : void
      {
         if(this._OnChange != null)
         {
            this._OnChange(param1,this);
         }
      }
      
      private function TextClick(param1:MouseEvent) : void
      {
         if(this._OnClick != null)
         {
            this._OnClick(param1,this);
         }
      }
   }
}

