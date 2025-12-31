package com.star.frameworks.graphics
{
   import flash.display.Graphics;
   
   public interface IBrush
   {
      
      function beginFill(param1:Graphics) : void;
      
      function endFill(param1:Graphics) : void;
   }
}

