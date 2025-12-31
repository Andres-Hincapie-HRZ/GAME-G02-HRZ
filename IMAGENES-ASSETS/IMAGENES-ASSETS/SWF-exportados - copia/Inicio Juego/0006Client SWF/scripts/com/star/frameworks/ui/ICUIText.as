package com.star.frameworks.ui
{
   import flash.text.TextFormat;
   
   public interface ICUIText extends ICUIComponent
   {
      
      function setLabel(param1:String) : void;
      
      function getLabel() : String;
      
      function getTextFormat() : TextFormat;
      
      function applyTextFormat(param1:TextFormat) : void;
   }
}

