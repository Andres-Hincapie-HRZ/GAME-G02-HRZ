package logic.impl
{
   import logic.entry.MObject;
   
   public interface IPopUp
   {
      
      function IsVisible() : Boolean;
      
      function setVisible(param1:Boolean) : void;
      
      function setPopUpName(param1:String) : void;
      
      function getPopUpName() : String;
      
      function Init() : void;
      
      function initMcElement() : void;
      
      function getPopUp() : MObject;
      
      function setPriority(param1:int) : void;
      
      function getPriority() : int;
      
      function Remove() : void;
      
      function setLocationXY(param1:int, param2:int) : void;
      
      function RestRawLocation() : void;
      
      function Invalid(param1:Boolean) : void;
      
      function unstallDiagPopUp(param1:IDiagPopUp) : void;
   }
}

