package com.star.frameworks.ui
{
   import flash.display.DisplayObject;
   
   public class CUIProgress extends CUIPopWnd
   {
      
      protected var m_Progresstype:int;
      
      private var progressTexture:DisplayObject;
      
      public function CUIProgress(param1:CUIFormat = null)
      {
         super(param1);
      }
      
      override public function initComponent() : void
      {
         if(getFormat().template)
         {
            CUIWindow(this).installUI("CUIProgress");
         }
         else
         {
            super.initComponent();
         }
      }
      
      public function setProgressType(param1:int) : void
      {
         this.m_Progresstype = param1;
      }
      
      public function getProgressType() : int
      {
         return this.m_Progresstype;
      }
      
      public function repaint(param1:String) : void
      {
      }
      
      public function repaintProgressText(param1:int, param2:int, param3:int, param4:Boolean = true, param5:int = 100) : void
      {
      }
   }
}

