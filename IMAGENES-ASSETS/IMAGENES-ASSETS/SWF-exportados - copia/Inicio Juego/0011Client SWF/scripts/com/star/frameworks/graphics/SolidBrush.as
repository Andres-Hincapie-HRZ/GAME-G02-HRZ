package com.star.frameworks.graphics
{
   import flash.display.Graphics;
   
   public class SolidBrush implements IBrush
   {
      
      private var m_color:ColorKit = null;
      
      public function SolidBrush(param1:ColorKit)
      {
         super();
         this.m_color = param1;
      }
      
      public function getColor() : ColorKit
      {
         return this.m_color;
      }
      
      public function setColor(param1:ColorKit) : void
      {
         this.m_color = param1;
      }
      
      public function beginFill(param1:Graphics) : void
      {
         param1.beginFill(this.m_color.getRGB(),this.m_color.getAlpha());
      }
      
      public function endFill(param1:Graphics) : void
      {
         param1.endFill();
      }
   }
}

