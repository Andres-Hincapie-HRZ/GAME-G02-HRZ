package logic.ui
{
   import com.star.frameworks.events.ActionEvent;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.impl.IDiagPopUp;
   import logic.impl.IPopUp;
   import logic.manager.GameInterActiveManager;
   
   public class DestructionShipNumUI implements IDiagPopUp
   {
      
      private static var instance:DestructionShipNumUI;
      
      private var _mc:MObject;
      
      private var _diagName:String;
      
      private var _parent:IPopUp;
      
      private var _build:HButton;
      
      private var _cancel:HButton;
      
      private var _txtnum:TextField = null;
      
      public var _num:int = 0;
      
      public var _maxNum:int = 0;
      
      public function DestructionShipNumUI()
      {
         super();
         this.setDiagPopUpName("DestructionShipNumUI");
      }
      
      public static function getInstance() : DestructionShipNumUI
      {
         if(instance == null)
         {
            instance = new DestructionShipNumUI();
         }
         return instance;
      }
      
      public function Init() : void
      {
         if(this._mc)
         {
            return;
         }
         this._mc = new MObject("Addfriendpopup",400,250);
         this.initMcElement();
      }
      
      public function initMcElement() : void
      {
         MovieClip(this._mc.getMC().getChildByName("btn_front") as MovieClip).visible = false;
         MovieClip(this._mc.getMC().getChildByName("btn_next") as MovieClip).visible = false;
         this._txtnum = TextField(this._mc.getMC().tf_id);
         this._txtnum.type = TextFieldType.INPUT;
         this._txtnum.addEventListener(Event.CHANGE,this.textInput);
         this._txtnum.restrict = "0-9";
         this._build = new HButton(this._mc.getMC().btn_ensure);
         GameInterActiveManager.InstallInterActiveEvent(this._build.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         this._cancel = new HButton(this._mc.getMC().btn_cancel);
         GameInterActiveManager.InstallInterActiveEvent(this._cancel.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
      }
      
      private function textInput(param1:Event) : void
      {
         this._num = Number(this._txtnum.text);
         if(this._num > this._maxNum)
         {
            this._num = this._maxNum;
            this._txtnum.text = String(this._num);
         }
      }
      
      public function setDiagPopUpName(param1:String) : void
      {
         this._diagName = param1;
      }
      
      public function getDiagPopUpName() : String
      {
         return this._diagName;
      }
      
      public function Show(param1:int, param2:String = null) : void
      {
         if(this._parent)
         {
            this._parent.getPopUp().addChild(instance._mc);
         }
         if(param2)
         {
            TextField(this._mc.getMC().tf_title).text = param2;
         }
         TextField(this._mc.getMC().tf_id).text = "";
         this._maxNum = param1;
      }
      
      public function Hide() : void
      {
         if(instance._mc.parent)
         {
            this._parent.getPopUp().removeChild(instance._mc);
         }
      }
      
      public function setParent(param1:IPopUp) : void
      {
         this._parent = param1;
      }
      
      public function getParent() : IPopUp
      {
         return this._parent;
      }
      
      private function chickButton(param1:Event) : void
      {
         if(param1.currentTarget.name == "btn_ensure")
         {
            if(this._txtnum.text == "")
            {
               return;
            }
            this._num = Number(this._txtnum.text);
            if(this._num == 0)
            {
               return;
            }
            DestructionShipUI.getinstance().moveList(this._num);
            this.Hide();
         }
         else if(param1.currentTarget.name == "btn_cancel")
         {
            this.Hide();
         }
      }
      
      public function getDiagPopUp() : DisplayObject
      {
         return this._mc;
      }
   }
}

