package logic.ui.info
{
   import flash.display.DisplayObject;
   
   public interface IInfoDecorate
   {
      
      function ShowTip(param1:int, param2:int, param3:Boolean = false) : void;
      
      function Show(param1:int, param2:int, param3:Boolean = false) : void;
      
      function Update(param1:String, param2:String, param3:int = -1, param4:Boolean = true) : void;
      
      function replaceTexture(param1:String, param2:DisplayObject) : void;
      
      function Hide() : void;
      
      function ReSetShowState(param1:String) : void;
      
      function Load(param1:String) : void;
      
      function setInfoValue(param1:int, param2:int = -1, param3:int = 0, param4:int = 0) : void;
      
      function setDisableState(param1:String, param2:Boolean = true) : void;
      
      function changeState() : void;
      
      function setSpecialColor(param1:String, param2:uint) : void;
   }
}

