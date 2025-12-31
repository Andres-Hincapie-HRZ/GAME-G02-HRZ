package com.star.frameworks.module
{
   import logic.entry.MObject;
   
   public interface IModule
   {
      
      function Init() : void;
      
      function Release() : void;
      
      function getUI() : MObject;
      
      function SetVisible(param1:Boolean) : void;
   }
}

