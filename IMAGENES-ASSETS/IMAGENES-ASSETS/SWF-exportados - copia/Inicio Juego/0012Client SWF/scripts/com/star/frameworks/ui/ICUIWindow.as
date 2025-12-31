package com.star.frameworks.ui
{
   public interface ICUIWindow extends ICUIComponent
   {
      
      function installText(param1:ICUIText, param2:ICUIComponent = null) : void;
      
      function installTitle(param1:ICUIcon) : void;
      
      function installButton(param1:ICUIButton) : void;
      
      function installTexture(param1:ICUIcon) : void;
      
      function installUI(param1:String) : void;
   }
}

