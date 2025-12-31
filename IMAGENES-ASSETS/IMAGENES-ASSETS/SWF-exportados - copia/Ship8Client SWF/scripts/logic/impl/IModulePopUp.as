package logic.impl
{
   import flash.display.DisplayObject;
   
   public interface IModulePopUp
   {
      
      function Init() : void;
      
      function Show() : void;
      
      function Hide(param1:Boolean = false) : void;
      
      function getModulePopUp() : DisplayObject;
      
      function AddEvent() : void;
      
      function Remove() : void;
   }
}

