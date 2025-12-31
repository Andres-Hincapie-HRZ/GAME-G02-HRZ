package logic.impl
{
   import flash.display.DisplayObject;
   
   public interface IDiagPopUp
   {
      
      function Init() : void;
      
      function setParent(param1:IPopUp) : void;
      
      function getParent() : IPopUp;
      
      function setDiagPopUpName(param1:String) : void;
      
      function getDiagPopUpName() : String;
      
      function getDiagPopUp() : DisplayObject;
      
      function Hide() : void;
   }
}

