package com.star.frameworks.ui
{
   import com.star.frameworks.geom.RectangleKit;
   import flash.display.DisplayObject;
   
   public interface ICUIButton extends ICUIComponent
   {
      
      function createIcon(param1:String, param2:String, param3:Boolean = false) : DisplayObject;
      
      function createRectIcon(param1:String, param2:String, param3:RectangleKit) : DisplayObject;
      
      function updateIcon(param1:DisplayObject, param2:String = null) : void;
      
      function installText(param1:String, param2:RectangleKit) : void;
      
      function setDisabled() : void;
      
      function setEnabled() : void;
   }
}

