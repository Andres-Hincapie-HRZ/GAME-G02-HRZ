package logic.entry
{
   import com.star.frameworks.display.Container;
   import flash.display.DisplayObject;
   import logic.impl.IAbstractAction;
   
   public class AbstraceAction implements IAbstractAction
   {
      
      private var _actionName:String;
      
      private var _display:DisplayObject;
      
      public function AbstraceAction()
      {
         super();
      }
      
      public function set ActionName(param1:String) : void
      {
         this._actionName = param1;
      }
      
      public function get ActionName() : String
      {
         return this._actionName;
      }
      
      public function get Display() : DisplayObject
      {
         return this._display;
      }
      
      public function getUI() : Container
      {
         return null;
      }
      
      public function Init() : void
      {
      }
      
      public function setDisplayPop(param1:DisplayObject) : void
      {
         this._display = param1;
      }
   }
}

