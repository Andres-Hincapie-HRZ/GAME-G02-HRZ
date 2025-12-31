package logic.ui
{
   import com.star.frameworks.geom.CFilter;
   import logic.entry.MObject;
   import logic.impl.IDiagPopUp;
   import logic.impl.IPopUp;
   
   public class AbstractPopUp implements IPopUp
   {
      
      private static var instance:AbstractPopUp;
      
      protected var _name:String;
      
      protected var _Priority:int;
      
      protected var _mc:MObject;
      
      protected var _visible:Boolean;
      
      private var RawX:int = -1;
      
      private var RawY:int;
      
      public function AbstractPopUp()
      {
         super();
         this._visible = false;
      }
      
      public static function getInstance() : AbstractPopUp
      {
         if(instance == null)
         {
            instance = new AbstractPopUp();
         }
         return instance;
      }
      
      public function Init() : void
      {
         if(this._mc)
         {
            return;
         }
         this._mc = new MObject();
      }
      
      public function initMcElement() : void
      {
      }
      
      public function IsVisible() : Boolean
      {
         return this._visible;
      }
      
      public function getPopUp() : MObject
      {
         return this._mc;
      }
      
      public function setPopUpName(param1:String) : void
      {
         this._name = param1;
      }
      
      public function getPopUpName() : String
      {
         return this._name;
      }
      
      public function setPriority(param1:int) : void
      {
         this._Priority = param1;
      }
      
      public function getPriority() : int
      {
         return this._Priority;
      }
      
      public function setLocationXY(param1:int, param2:int) : void
      {
         if(this._mc)
         {
            if(this.RawX == -1)
            {
               this.RawX = this._mc.x;
               this.RawY = this._mc.y;
            }
            this._mc.x = param1;
            this._mc.y = param2;
         }
      }
      
      public function RestRawLocation() : void
      {
         if(this.RawX != -1)
         {
            this._mc.x = this.RawX;
            this._mc.y = this.RawY;
         }
      }
      
      public function setVisible(param1:Boolean) : void
      {
         this._visible = param1;
      }
      
      public function Remove() : void
      {
         this._visible = false;
      }
      
      public function unstallDiagPopUp(param1:IDiagPopUp) : void
      {
         if(param1 == null || param1.getDiagPopUp() == null)
         {
            return;
         }
         if(this.getPopUp().contains(param1.getDiagPopUp()))
         {
            this.getPopUp().removeChild(param1.getDiagPopUp());
         }
      }
      
      public function Invalid(param1:Boolean) : void
      {
         var _loc2_:CFilter = null;
         if(param1)
         {
            if(this._mc.getMC().filters.length)
            {
               this._mc.getMC().filters = null;
            }
         }
         else if(this._mc.getMC().filters.length == 0)
         {
            _loc2_ = new CFilter();
            _loc2_.generate_brightness_filter(-10);
            this._mc.getMC().filters = _loc2_.getFilter(true);
         }
         this._mc.mouseEnabled = param1;
         this._mc.getMC().mouseEnabled = param1;
         this._mc.getMC().mouseChildren = param1;
      }
   }
}

