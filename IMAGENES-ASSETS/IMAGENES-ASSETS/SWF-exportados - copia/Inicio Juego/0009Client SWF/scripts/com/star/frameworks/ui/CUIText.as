package com.star.frameworks.ui
{
   import com.star.frameworks.formatters.CUITextFormat;
   import flash.display.DisplayObject;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import flash.text.TextFormat;
   
   public class CUIText extends CUIComponent implements ICUIText
   {
      
      private var textInstance:TextField;
      
      public function CUIText(param1:CUIFormat = null)
      {
         super(param1);
      }
      
      override public function initComponent() : void
      {
         setType("CUIText");
         setXYWH(getFormat().rectangle);
         setName(getFormat().name);
         setShow(getFormat().isShow);
         setVisible(getFormat().visible);
         this.textInstance = new TextField();
         this.textInstance.name = getName();
         this.textInstance.x = getX();
         this.textInstance.y = getY();
         this.textInstance.width = getWidth();
         this.textInstance.height = getHeight();
         this.textInstance.visible = isVisible();
         this.textInstance.selectable = getFormat().selectable;
         this.textInstance.displayAsPassword = getFormat().password;
         this.textInstance.wordWrap = getFormat().wrapWord;
         this.textInstance.mouseEnabled = getFormat().textType != TextFieldType.DYNAMIC;
         if(getFormat().border)
         {
            this.textInstance.border = true;
            this.textInstance.borderColor = getFormat().borderColor;
         }
         this.textInstance.text = getFormat().textDefault;
         if(getFormat().restrict)
         {
            this.textInstance.restrict = getFormat().restrict;
         }
         this.textInstance = TextField(CUITextFormat.SetTextFormat(this.textInstance,getFormat()));
         this.textInstance.defaultTextFormat = CUITextFormat.getTextFormat(getFormat());
         this.textInstance.textColor = CUITextFormat.getTextFormat(getFormat()).color as uint;
         if(getFormat().isAutoSize)
         {
            this.textInstance.autoSize = getFormat().autoSize;
         }
         if(getFormat().textType)
         {
            this.textInstance.type = getFormat().textType;
         }
      }
      
      public function setLabel(param1:String) : void
      {
         this.textInstance.text = param1;
      }
      
      public function getLabel() : String
      {
         return this.textInstance.text;
      }
      
      public function getTextFormat() : TextFormat
      {
         return this.textInstance.getTextFormat();
      }
      
      public function applyTextFormat(param1:TextFormat) : void
      {
         this.textInstance.setTextFormat(param1);
      }
      
      override public function getComponent() : DisplayObject
      {
         return this.textInstance;
      }
   }
}

