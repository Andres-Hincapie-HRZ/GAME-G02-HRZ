package logic.entry.test
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFieldType;
   
   public class BirthTextField extends Sprite
   {
      
      private var _textField:TextField;
      
      private var _text:String;
      
      private var _panel:BirthPanelRect;
      
      private var oldStr:String = "";
      
      public function BirthTextField(param1:String = "", param2:uint = 80, param3:uint = 20)
      {
         super();
         addChild(new BirthPanelRect(0,0,param2,param3,0.3));
         this._textField = new TextField();
         this._textField.x = 0;
         this._textField.y = 0;
         this._textField.width = 80;
         this._textField.height = 20;
         this._textField.autoSize = TextFieldAutoSize.LEFT;
         this._textField.type = TextFieldType.INPUT;
         this._textField.text = param1;
         this._textField.multiline = false;
         this._textField.wordWrap = false;
         addChild(this._textField);
      }
      
      private function onInput(param1:Event) : void
      {
      }
      
      public function setAutoSize(param1:String) : void
      {
         this._textField.autoSize = param1;
      }
      
      public function setType(param1:String) : void
      {
         this._textField.type = param1;
      }
      
      public function setXY(param1:int, param2:int) : void
      {
         this.x = param1;
         this.y = param2;
      }
      
      public function setX(param1:int) : void
      {
         this.x = param1;
      }
      
      public function setY(param1:int) : void
      {
         this.y = param1;
      }
      
      public function get text() : String
      {
         return this._textField.text;
      }
      
      public function set text(param1:String) : void
      {
         this._textField.text = param1;
      }
      
      public function get textField() : TextField
      {
         return this._textField;
      }
      
      public function set textField(param1:TextField) : void
      {
         this._textField = param1;
      }
   }
}

