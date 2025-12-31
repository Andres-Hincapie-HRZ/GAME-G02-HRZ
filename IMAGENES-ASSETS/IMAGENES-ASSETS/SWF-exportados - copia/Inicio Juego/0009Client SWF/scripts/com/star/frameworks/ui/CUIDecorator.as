package com.star.frameworks.ui
{
   import com.star.frameworks.errors.CError;
   import flash.display.DisplayObject;
   
   public class CUIDecorator
   {
      
      private var impl:ICUIComponent;
      
      public function CUIDecorator(param1:CUIFormat)
      {
         super();
         this.InitUI(param1);
      }
      
      private function InitUI(param1:CUIFormat) : void
      {
         if(param1 == null)
         {
            throw new CError("UI样式对象为空");
         }
         switch(param1.type)
         {
            case CUIFormat.POPWND:
               this.impl = new CUIPopWnd(param1);
               break;
            case CUIFormat.WINDOW:
               this.impl = new CUIWindow(param1);
               break;
            case CUIFormat.BUTTON:
               this.impl = new CUIButton(param1);
               break;
            case CUIFormat.TEXT:
               this.impl = new CUIText(param1);
               break;
            case CUIFormat.IMAGE:
               this.impl = new CUIIcon(param1);
               break;
            case CUIFormat.TOGGLEBUTTON:
               this.impl = new CUIToggleButton(param1);
               break;
            case CUIFormat.PROGRESSS:
               this.impl = new CUIProgress(param1);
               break;
            case CUIFormat.TABPANEL:
               this.impl = new CUITabPanel(param1);
               break;
            case CUIFormat.CHECKBOX:
               this.impl = new CUICheckBox(param1);
               break;
            case CUIFormat.HTMLTEXT:
               this.impl = new CUIHtmlText(param1);
               break;
            case CUIFormat.MOVIECLIP:
               this.impl = new CUIMovieClip(param1);
         }
         this.impl.initComponent();
      }
      
      public function getICUImpl() : ICUIComponent
      {
         return this.impl;
      }
      
      public function getDisplayObject() : DisplayObject
      {
         return this.getICUImpl().getComponent();
      }
   }
}

