package com.star.frameworks.ui
{
   import com.star.frameworks.formatters.CUITextFormat;
   import flash.display.DisplayObject;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class CUIHtmlText extends CUIComponent implements ICUIText
   {
      
      private var htmlTxt:TextField;
      
      public function CUIHtmlText(param1:CUIFormat = null)
      {
         super(param1);
      }
      
      override public function initComponent() : void
      {
         setType("CUIHtmlText");
         setXYWH(getFormat().rectangle);
         setEnable(getFormat().enabled);
         setVisible(getFormat().visible);
         this.htmlTxt = new TextField();
         this.htmlTxt.name = getFormat().name;
         this.htmlTxt.wordWrap = getFormat().wrapWord;
         this.htmlTxt.autoSize = getFormat().autoSize == null ? "left" : getFormat().autoSize;
         this.htmlTxt.x = getRect().x;
         this.htmlTxt.y = getRect().y;
         if(getRect().width)
         {
            this.htmlTxt.width = getRect().width;
         }
         if(getRect().height)
         {
            this.htmlTxt.width = getRect().height;
         }
         if(getFormat().border && Boolean(getFormat().borderColor))
         {
            this.htmlTxt.border = getFormat().border;
            this.htmlTxt.borderColor = getFormat().borderColor;
         }
         if(getFormat().restrict)
         {
            this.htmlTxt.restrict = getFormat().restrict;
         }
         if(getFormat().selectable)
         {
            this.htmlTxt.selectable = getFormat().selectable;
         }
         this.htmlTxt.mouseEnabled = isEnabled();
         this.htmlTxt.visible = isVisible();
         this.htmlTxt.htmlText = getFormat().textDefault;
         this.htmlTxt = TextField(CUITextFormat.SetTextFormat(this.htmlTxt,getFormat()));
         this.htmlTxt.defaultTextFormat = CUITextFormat.getTextFormat(getFormat());
      }
      
      public function setLabel(param1:String) : void
      {
         this.htmlTxt.htmlText = param1;
      }
      
      public function getLabel() : String
      {
         return this.htmlTxt.htmlText;
      }
      
      public function getTextFormat() : TextFormat
      {
         return this.htmlTxt.defaultTextFormat;
      }
      
      public function applyTextFormat(param1:TextFormat) : void
      {
         this.htmlTxt.defaultTextFormat = param1;
      }
      
      override public function getComponent() : DisplayObject
      {
         return this.htmlTxt;
      }
   }
}

