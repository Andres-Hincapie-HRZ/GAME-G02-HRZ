package com.star.frameworks.formatters
{
   import com.star.frameworks.errors.CError;
   import com.star.frameworks.ui.CUIFormat;
   import com.star.frameworks.utils.ObjectUtil;
   import flash.display.DisplayObject;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.text.TextFormatDisplay;
   
   public class CUITextFormat
   {
      
      public function CUITextFormat()
      {
         super();
      }
      
      public static function SetTextFormat(param1:DisplayObject, param2:CUIFormat) : DisplayObject
      {
         var _loc3_:TextFormat = null;
         if(ObjectUtil.isNull(param2) || ObjectUtil.isNull(param1))
         {
            throw new CError("对象为空");
         }
         _loc3_ = new TextFormat();
         switch(param2.textFormat)
         {
            case 0:
               _loc3_.align = TextFormatAlign.CENTER;
               _loc3_.font = "宋体";
               _loc3_.color = 16777215;
               _loc3_.size = 12;
               _loc3_.display = TextFormatDisplay.BLOCK;
               break;
            case 1:
               _loc3_.align = param2.align;
               _loc3_.color = param2.fontColor;
               _loc3_.size = param2.fontSize;
               _loc3_.display = TextFormatDisplay.BLOCK;
         }
         if(param1 is TextField)
         {
            TextField(param1).setTextFormat(_loc3_);
         }
         return param1;
      }
      
      public static function getTextFormat(param1:CUIFormat) : TextFormat
      {
         var _loc2_:TextFormat = null;
         if(ObjectUtil.isNull(param1))
         {
            throw new CError("样式表为空");
         }
         _loc2_ = new TextFormat();
         switch(param1.textFormat)
         {
            case 0:
               _loc2_.align = TextFormatAlign.CENTER;
               _loc2_.font = "宋体";
               _loc2_.color = 16777215;
               _loc2_.size = 12;
               _loc2_.display = TextFormatDisplay.BLOCK;
               break;
            case 1:
               _loc2_.align = param1.align;
               _loc2_.font = param1.font;
               _loc2_.color = param1.fontColor;
               _loc2_.size = param1.fontSize;
         }
         return _loc2_;
      }
      
      public static function setTextStyle(param1:TextField, param2:String) : void
      {
      }
   }
}

