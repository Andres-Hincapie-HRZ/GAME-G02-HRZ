package logic.widget.tips
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.geom.RectangleKit;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import logic.widget.com.ComFormat;
   
   public class CToolTip
   {
      
      private var _type:int;
      
      private var _spacing:int;
      
      private var _data:Array;
      
      private var _name:String;
      
      private var _instance:Container;
      
      private var _bgDecorate:CToolTipBgDecorate;
      
      private var _mouseOver:Boolean = false;
      
      public function CToolTip(param1:RectangleKit)
      {
         super();
         this._bgDecorate = new CToolTipBgDecorate(param1);
         this._instance = new Container();
         this._instance.mouseChildren = false;
         this._instance.x = param1.x;
         this._instance.y = param1.y;
         this._instance.addChild(this._bgDecorate.Decorate);
         this._data = new Array();
      }
      
      public function SetMoveEvent() : void
      {
         this._instance.mouseEnabled = true;
         this._instance.addEventListener(MouseEvent.MOUSE_MOVE,this._instanceMouseMove);
      }
      
      private function _instanceMouseMove(param1:MouseEvent) : void
      {
         if(this._instance.parent)
         {
            this._instance.parent.removeChild(this._instance);
         }
      }
      
      public function set LayOutType(param1:int) : void
      {
         this._type = param1;
      }
      
      public function get LayOutType() : int
      {
         return this._type;
      }
      
      public function set Spacing(param1:int) : void
      {
         this._spacing = param1;
      }
      
      public function get Spacing() : int
      {
         return this._spacing;
      }
      
      public function getComponentByName(param1:String) : DisplayObject
      {
         return this._instance.getChildByName(param1);
      }
      
      public function getObject(param1:String) : Object
      {
         var _loc2_:Object = null;
         for each(_loc2_ in this.Data)
         {
            if(ComFormat(_loc2_.Format).name == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function updateValue(param1:Object) : void
      {
         var _loc2_:Object = null;
         for each(_loc2_ in this.Data)
         {
            TextField(_loc2_.Display).text = param1.Value;
         }
      }
      
      public function get Data() : Array
      {
         return this._data;
      }
      
      public function get Name() : String
      {
         return this._name;
      }
      
      public function set Name(param1:String) : void
      {
         this._name = param1;
      }
      
      public function get mouseOver() : Boolean
      {
         return this._mouseOver;
      }
      
      public function getDecorate() : Container
      {
         return this._instance;
      }
      
      public function getDecorateBg() : CToolTipBgDecorate
      {
         return this._bgDecorate;
      }
   }
}

