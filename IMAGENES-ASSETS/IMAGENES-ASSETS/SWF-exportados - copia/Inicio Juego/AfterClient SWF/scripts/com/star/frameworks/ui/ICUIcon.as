package com.star.frameworks.ui
{
   import com.star.frameworks.geom.RectangleKit;
   
   public interface ICUIcon extends ICUIComponent
   {
      
      function loadTexture(param1:String, param2:String, param3:Boolean = false) : void;
      
      function loadRect(param1:String, param2:String, param3:RectangleKit) : void;
      
      function unLoadRect() : void;
      
      function changeRect(param1:RectangleKit) : void;
      
      function drawRect(param1:RectangleKit) : void;
      
      function drawRoundRect(param1:RectangleKit, param2:Number = 25) : void;
      
      function fillRoundRect(param1:RectangleKit, param2:Number = 25, param3:uint = 0, param4:Number = 1) : void;
      
      function fillRect(param1:RectangleKit, param2:uint = 0, param3:Number = 1) : void;
      
      function installText() : void;
   }
}

