package logic.widget.com
{
   import flash.display.DisplayObject;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import flash.text.TextFormat;
   
   public class ComText extends Component
   {
      
      private var _textFiled:TextField;
      
      public function ComText(param1:ComFormat)
      {
         super();
         setType(ComFormat.TEXT);
         setFormat(param1);
         setName(getFormat().name);
         setRect(getFormat().rectangle);
      }
      
      override public function Init() : void
      {
         this._textFiled = new TextField();
         this._textFiled.name = getName();
         this._textFiled.x = getRect().x;
         this._textFiled.y = getRect().y;
         this._textFiled.width = getRect().width;
         this._textFiled.height = getRect().height;
         this._textFiled.visible = getFormat().visible;
         this._textFiled.selectable = getFormat().selectable;
         this._textFiled.displayAsPassword = getFormat().password;
         this._textFiled.wordWrap = getFormat().wrapWord;
         this._textFiled.multiline = true;
         this._textFiled.autoSize = getFormat().autoSize;
         this._textFiled.mouseEnabled = getFormat().textType != TextFieldType.DYNAMIC;
         this._textFiled.text = getFormat().textDefault;
         this._textFiled.textColor = getFormat().fontColor;
         var _loc1_:TextFormat = new TextFormat(getFormat().font,getFormat().fontSize,getFormat().fontColor);
         this._textFiled.defaultTextFormat = _loc1_;
         this._textFiled.setTextFormat(_loc1_);
         if(getFormat().border)
         {
            this._textFiled.border = true;
            this._textFiled.borderColor = getFormat().borderColor;
         }
         if(getFormat().restrict)
         {
            this._textFiled.restrict = getFormat().restrict;
         }
      }
      
      override public function getComponent() : DisplayObject
      {
         return this._textFiled;
      }
   }
}

