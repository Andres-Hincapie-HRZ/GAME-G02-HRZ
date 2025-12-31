package logic.ui
{
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.StringUitl;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.entry.shipmodel.ShipModelProperty;
   import logic.entry.shipmodel.ShipbodyInfo;
   import logic.entry.shipmodel.ShippartInfo;
   import logic.impl.IDiagPopUp;
   import logic.impl.IPopUp;
   import logic.manager.GameInterActiveManager;
   import logic.reader.CShipmodelReader;
   import net.router.ShipmodelRouter;
   
   public class CreateShipUI implements IDiagPopUp
   {
      
      private static var instance:CreateShipUI;
      
      private var _mc:MObject;
      
      private var _diagName:String;
      
      private var _parent:IPopUp;
      
      private var _build:HButton;
      
      private var _cancel:HButton;
      
      private var _txtnum:TextField = null;
      
      public var _num:int = 0;
      
      private var _ShipModelProperty:ShipModelProperty = new ShipModelProperty();
      
      public function CreateShipUI()
      {
         super();
         this.setDiagPopUpName("CreateShipUI");
      }
      
      public static function getInstance() : CreateShipUI
      {
         if(instance == null)
         {
            instance = new CreateShipUI();
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
         var _loc2_:int = 0;
         this._num = Number(this._txtnum.text);
         if(this._num * this._ShipModelProperty.Metal > GamePlayer.getInstance().UserMetal || this._num * this._ShipModelProperty.He3 > GamePlayer.getInstance().UserHe3 || this._num * this._ShipModelProperty.money > GamePlayer.getInstance().UserMoney)
         {
            _loc2_ = GamePlayer.getInstance().UserMetal / this._ShipModelProperty.Metal;
            if(GamePlayer.getInstance().UserHe3 / this._ShipModelProperty.He3 < _loc2_)
            {
               _loc2_ = GamePlayer.getInstance().UserHe3 / this._ShipModelProperty.He3;
            }
            if(GamePlayer.getInstance().UserMoney / this._ShipModelProperty.money < _loc2_)
            {
               _loc2_ = GamePlayer.getInstance().UserMoney / this._ShipModelProperty.money;
            }
            this._txtnum.text = String(_loc2_);
         }
         if(ShipmodelRouter.instance.m_MaxCreateShipNum < Number(this._txtnum.text))
         {
            this._txtnum.text = String(ShipmodelRouter.instance.m_MaxCreateShipNum);
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
      
      public function Show(param1:String = null) : void
      {
         var _loc4_:String = null;
         var _loc6_:int = 0;
         var _loc7_:ShippartInfo = null;
         if(this._parent)
         {
            this._parent.getPopUp().addChild(instance._mc);
         }
         if(param1)
         {
            TextField(this._mc.getMC().tf_title).text = param1;
            TextField(this._mc.getMC().tf_id).addEventListener(ActionEvent.ACTION_CLICK,this.chicktext);
         }
         var _loc2_:ShipbodyInfo = CShipmodelReader.getInstance().getShipBodyInfo(ShipmodelRouter.instance.m_ShipmodelInfoAry[ShipmodelUI.getInstance().m_num].m_BodyId);
         this._ShipModelProperty.Metal = _loc2_.Metal;
         this._ShipModelProperty.He3 = _loc2_.He3;
         this._ShipModelProperty.money = _loc2_.Money;
         var _loc3_:int = 0;
         while(_loc3_ < ShipmodelRouter.instance.m_ShipmodelInfoAry[ShipmodelUI.getInstance().m_num].m_PartNum)
         {
            _loc6_ = int(ShipmodelRouter.instance.m_ShipmodelInfoAry[ShipmodelUI.getInstance().m_num].m_PartId[_loc3_]);
            _loc7_ = CShipmodelReader.getInstance().getShipPartInfo(_loc6_);
            this._ShipModelProperty.Metal += _loc7_.Metal;
            this._ShipModelProperty.He3 += _loc7_.He3;
            this._ShipModelProperty.money += _loc7_.Money;
            _loc3_++;
         }
         this._ShipModelProperty.getCost();
         var _loc5_:int = 2000000 - ShipmodelRouter.instance.m_MaxCreateShipNum;
         _loc4_ = StringUitl.toUSFormat(_loc5_);
         TextField(this._mc.getMC().tf_shipNum).text = StringManager.getInstance().getMessageString("ShipText29") + _loc4_;
      }
      
      private function chicktext(param1:Event) : void
      {
         TextField(this._mc.getMC().tf_id).text = "";
         TextField(this._mc.getMC().tf_id).removeEventListener(ActionEvent.ACTION_CLICK,this.chicktext);
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
            ShipmodelRouter.instance.sendmsgCREATESHIP(ShipmodelUI.getInstance().m_shipmodleID,this._num,0);
            ShipmodelRouter.instance.sendmsgCREATESHIPINFO();
            this.Hide();
            ShipmodelUI.getInstance().removeBackMC();
         }
         else if(param1.currentTarget.name == "btn_cancel")
         {
            this.Hide();
            ShipmodelUI.getInstance().removeBackMC();
         }
      }
      
      public function getDiagPopUp() : DisplayObject
      {
         return this._mc;
      }
   }
}

