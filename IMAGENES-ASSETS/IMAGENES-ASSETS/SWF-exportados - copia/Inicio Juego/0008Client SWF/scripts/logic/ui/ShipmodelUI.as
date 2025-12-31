package logic.ui
{
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.CEffectText;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.utils.Timer;
   import logic.action.ConstructionAction;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.HButtonType;
   import logic.entry.MObject;
   import logic.entry.shipmodel.ShipModelProperty;
   import logic.entry.shipmodel.ShipbodyInfo;
   import logic.entry.shipmodel.ShipmodelInfo;
   import logic.entry.shipmodel.ShippartInfo;
   import logic.game.GameKernel;
   import logic.manager.GameInterActiveManager;
   import logic.reader.CShipmodelReader;
   import logic.ui.info.IInfoDecorate;
   import logic.widget.ConstructionOperationWidget;
   import logic.widget.OperationEnum;
   import net.router.ShipmodelRouter;
   
   public class ShipmodelUI extends AbstractPopUp
   {
      
      private static var instance:ShipmodelUI;
      
      private static const PARTMCMAXNUM:int = 9;
      
      private static const BEINGMCMAXNUM:int = 5;
      
      private static const MAXSHIPNUM:int = 30;
      
      private var m_chooseNum:int = 0;
      
      public var m_beingMcNum:int = 0;
      
      private var mcairshiplistAry:Array = new Array();
      
      private var mcmodulelistAry:Array = new Array();
      
      private var mcconstructlistAry:Array = new Array();
      
      private var m_shipmodelnameAry:Array = new Array();
      
      private var m_partNumberAry:Array = new Array();
      
      private var m_partIDAry:Array = new Array();
      
      private var m_shipStorageAry:Array = new Array();
      
      private var m_partStorageAry:Array = new Array();
      
      private var m_beingStorageAry:Array = new Array();
      
      private var m_partnumStorageAry:Array = new Array();
      
      private var m_partnameStorageAry:Array = new Array();
      
      private var m_pageNumber:int;
      
      private var m_LRpageNumber:int;
      
      public var m_LRbeingPageNumber:int;
      
      public var m_shipmodleID:int;
      
      private var m_time:Timer;
      
      private var m_needTimeAry:Array = new Array();
      
      private var mccancelAry:Array = new Array();
      
      private var m_times:int = 0;
      
      public var m_itemnameAry:Array = new Array();
      
      public var m_KindNameAry:Array = new Array();
      
      public var m_Isopen:int = 0;
      
      public var m_ifopen:int = 0;
      
      private var _infoDecorate:IInfoDecorate;
      
      private var m_x:int;
      
      private var m_y:int;
      
      public var shipinfo:ShipModelProperty = new ShipModelProperty();
      
      public var m_num:int;
      
      private var m_IsChooseAry:Array = new Array(0,0,0,0,0);
      
      private var m_quickenMcAry:Array = new Array();
      
      private var m_timeshapeMcAry:Array = new Array();
      
      private var m_cancelMcAry:Array = new Array();
      
      private var m_shipbodyup:Boolean;
      
      private var m_shipbodydown:Boolean;
      
      private var m_partleft:Boolean;
      
      private var m_partright:Boolean;
      
      private var m_buildleft:Boolean;
      
      private var m_buildright:Boolean;
      
      public var IsSpeedOver:Boolean = false;
      
      private var backMc:MovieClip = new MovieClip();
      
      private var _close:HButton;
      
      private var _list:MovieClip;
      
      private var _modulelist:HButton;
      
      private var _constructlist:HButton;
      
      private var _cancel:HButton;
      
      private var _constructcancel:HButton;
      
      private var _modulecancel:HButton;
      
      private var _shipbodyup:MovieClip;
      
      private var _shipbodydown:MovieClip;
      
      private var _partleft:MovieClip;
      
      private var _partright:MovieClip;
      
      private var _buildleft:MovieClip;
      
      private var _buildright:MovieClip;
      
      private var _build:HButton;
      
      private var _addqueue:HButton;
      
      private var _shipdesign:HButton;
      
      private var _researchcenters:HButton;
      
      private var McHelp:MovieClip;
      
      public function ShipmodelUI()
      {
         super();
         setPopUpName("ShipmodelUI");
      }
      
      public static function getInstance() : ShipmodelUI
      {
         if(instance == null)
         {
            instance = new ShipmodelUI();
         }
         return instance;
      }
      
      override public function Init() : void
      {
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            return;
         }
         this.m_Isopen = 1;
         this._mc = new MObject("BoatyardScene",400,325);
         this.initMcElement();
         this.m_time = new Timer(1000);
         this.m_time.addEventListener(TimerEvent.TIMER,this.onTick,false,0,true);
         GameKernel.popUpDisplayManager.Regisger(instance);
         this.m_itemnameAry.push(StringManager.getInstance().getMessageString("DesignText9"));
         this.m_itemnameAry.push(StringManager.getInstance().getMessageString("DesignText8"));
         this.m_itemnameAry.push(StringManager.getInstance().getMessageString("DesignText13"));
         this.m_itemnameAry.push(StringManager.getInstance().getMessageString("DesignText6"));
         this.m_itemnameAry.push(StringManager.getInstance().getMessageString("FormationText19"));
         this.m_itemnameAry.push(StringManager.getInstance().getMessageString("Text1"));
         this.m_itemnameAry.push(StringManager.getInstance().getMessageString("FormationText20"));
         this.m_itemnameAry.push(StringManager.getInstance().getMessageString("DesignText10"));
         this.m_itemnameAry.push(StringManager.getInstance().getMessageString("FormationText17"));
         this.m_itemnameAry.push(StringManager.getInstance().getMessageString("FormationText21"));
         this.m_itemnameAry.push("Metal");
         this.m_itemnameAry.push("He3");
         this.m_itemnameAry.push("Gold");
         this.m_KindNameAry.push(StringManager.getInstance().getMessageString("IconText13"));
         this.m_KindNameAry.push(StringManager.getInstance().getMessageString("IconText14"));
         this.m_KindNameAry.push(StringManager.getInstance().getMessageString("IconText15"));
      }
      
      override public function initMcElement() : void
      {
         var _loc1_:HButton = null;
         _loc1_ = new HButton(this._mc.getMC().btn_help,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("IconText39"));
         this._mc.getMC().btn_help.addEventListener(MouseEvent.CLICK,this.btn_helpClick);
         this.McHelp = GameKernel.getMovieClipInstance("HelpMc1",_mc.getMC().x,_mc.getMC().y);
         this.McHelp.addEventListener(MouseEvent.CLICK,this.McHelpClick);
         var _loc2_:MovieClip = this._mc.getMC().mc_airshiplist;
         var _loc3_:MovieClip = this._mc.getMC().mc_modulelist;
         var _loc4_:MovieClip = this._mc.getMC().mc_constructlist;
         this._shipbodyup = _loc2_.btn_up as MovieClip;
         this._shipbodyup.buttonMode = true;
         this._shipbodyup.addEventListener(ActionEvent.ACTION_CLICK,this.chickButton);
         this._shipbodyup.addEventListener(ActionEvent.ACTION_MOUSE_DOWN,this.downButton);
         this._shipbodyup.addEventListener(ActionEvent.ACTION_MOUSE_OVER,this.overButton);
         this._shipbodyup.addEventListener(ActionEvent.ACTION_MOUSE_OUT,this.outButton);
         this._shipbodyup.gotoAndStop("disabled");
         this._shipbodydown = _loc2_.btn_down as MovieClip;
         this._shipbodydown.buttonMode = true;
         this._shipbodydown.addEventListener(ActionEvent.ACTION_CLICK,this.chickButton);
         this._shipbodydown.addEventListener(ActionEvent.ACTION_MOUSE_DOWN,this.downButton);
         this._shipbodydown.addEventListener(ActionEvent.ACTION_MOUSE_OVER,this.overButton);
         this._shipbodydown.addEventListener(ActionEvent.ACTION_MOUSE_OUT,this.outButton);
         this._partleft = _loc3_.btn_left as MovieClip;
         this._partleft.buttonMode = true;
         this._partleft.addEventListener(ActionEvent.ACTION_CLICK,this.chickButton);
         this._partleft.addEventListener(ActionEvent.ACTION_MOUSE_DOWN,this.downButton);
         this._partleft.addEventListener(ActionEvent.ACTION_MOUSE_OVER,this.overButton);
         this._partleft.addEventListener(ActionEvent.ACTION_MOUSE_OUT,this.outButton);
         this._partright = _loc3_.btn_right as MovieClip;
         this._partright.buttonMode = true;
         this._partright.addEventListener(ActionEvent.ACTION_CLICK,this.chickButton);
         this._partright.addEventListener(ActionEvent.ACTION_MOUSE_DOWN,this.downButton);
         this._partright.addEventListener(ActionEvent.ACTION_MOUSE_OVER,this.overButton);
         this._partright.addEventListener(ActionEvent.ACTION_MOUSE_OUT,this.outButton);
         this._partleft.gotoAndStop("up");
         this._partright.gotoAndStop("up");
         this._buildleft = _loc4_.btn_left as MovieClip;
         this._buildleft.buttonMode = true;
         this._buildleft.addEventListener(ActionEvent.ACTION_CLICK,this.chickButton);
         this._buildleft.addEventListener(ActionEvent.ACTION_MOUSE_DOWN,this.downButton);
         this._buildleft.addEventListener(ActionEvent.ACTION_MOUSE_OVER,this.overButton);
         this._buildleft.addEventListener(ActionEvent.ACTION_MOUSE_OUT,this.outButton);
         this._buildleft.gotoAndStop("disabled");
         this._buildright = _loc4_.btn_right as MovieClip;
         this._buildright.buttonMode = true;
         this._buildright.addEventListener(ActionEvent.ACTION_CLICK,this.chickButton);
         this._buildright.addEventListener(ActionEvent.ACTION_MOUSE_DOWN,this.downButton);
         this._buildright.addEventListener(ActionEvent.ACTION_MOUSE_OVER,this.overButton);
         this._buildright.addEventListener(ActionEvent.ACTION_MOUSE_OUT,this.outButton);
         this._buildright.gotoAndStop("disabled");
         TextField(this._mc.getMC().tf_airshipname).text = "";
         var _loc5_:int = 0;
         while(_loc5_ < 5)
         {
            this.mcairshiplistAry[_loc5_] = _loc2_.getChildByName("mc_list" + _loc5_) as MovieClip;
            this.mcairshiplistAry[_loc5_].addEventListener(MouseEvent.CLICK,this.choose);
            GameInterActiveManager.InstallInterActiveEvent(this.mcairshiplistAry[_loc5_],ActionEvent.ACTION_MOUSE_OVER,this.mouseover);
            GameInterActiveManager.InstallInterActiveEvent(this.mcairshiplistAry[_loc5_],ActionEvent.ACTION_MOUSE_OUT,this.mouseout);
            this._list = this.mcairshiplistAry[_loc5_] as MovieClip;
            this.mcairshiplistAry[_loc5_].gotoAndStop("up");
            this.mcairshiplistAry[0].gotoAndStop("selected");
            this._cancel = new HButton(_loc2_.getChildByName("btn_cancel" + _loc5_) as MovieClip);
            this.mccancelAry[_loc5_] = this._cancel.m_movie;
            GameInterActiveManager.InstallInterActiveEvent(this._cancel.m_movie,ActionEvent.ACTION_MOUSE_OUT,this.CancelMouseOut);
            GameInterActiveManager.InstallInterActiveEvent(this._cancel.m_movie,ActionEvent.ACTION_MOUSE_OVER,this.CancelMouseOver);
            GameInterActiveManager.InstallInterActiveEvent(this._cancel.m_movie,ActionEvent.ACTION_CLICK,this.delmodel);
            _loc5_++;
         }
         var _loc6_:int = 0;
         while(_loc6_ < PARTMCMAXNUM)
         {
            this.mcmodulelistAry[_loc6_] = _loc3_.getChildByName("mc_list" + _loc6_) as MovieClip;
            GameInterActiveManager.InstallInterActiveEvent(this.mcmodulelistAry[_loc6_],ActionEvent.ACTION_MOUSE_OVER,this.PartMouseOver);
            GameInterActiveManager.InstallInterActiveEvent(this.mcmodulelistAry[_loc6_],ActionEvent.ACTION_MOUSE_OUT,this.PartMouseOut);
            this._modulelist = new HButton(this.mcmodulelistAry[_loc6_]);
            TextField(this.mcmodulelistAry[_loc6_].getChildByName("tf_modulenum")).text = "";
            _loc6_++;
         }
         var _loc7_:int = 0;
         while(_loc7_ < BEINGMCMAXNUM)
         {
            this.mcconstructlistAry[_loc7_] = _loc4_.getChildByName("mc_list" + _loc7_) as MovieClip;
            TextField(this.mcconstructlistAry[_loc7_].getChildByName("tf_remainnum")).text = "";
            TextField(this.mcconstructlistAry[_loc7_].getChildByName("tf_remaintime")).text = "";
            TextField(this.mcconstructlistAry[_loc7_].getChildByName("tf_shipname")).text = "";
            TextField(this.mcconstructlistAry[_loc7_].getChildByName("tf_text0")).text = "";
            this.m_timeshapeMcAry[_loc7_] = this.mcconstructlistAry[_loc7_].mc_timeshape as MovieClip;
            this.m_timeshapeMcAry[_loc7_].visible = false;
            this.m_quickenMcAry[_loc7_] = new HButton(this.mcconstructlistAry[_loc7_].btn_quicken);
            this.m_quickenMcAry[_loc7_].setVisible(false);
            GameInterActiveManager.InstallInterActiveEvent(this.m_quickenMcAry[_loc7_].m_movie,ActionEvent.ACTION_CLICK,this.speedChoose);
            GameInterActiveManager.InstallInterActiveEvent(this.m_quickenMcAry[_loc7_].m_movie,ActionEvent.ACTION_MOUSE_OVER,this.speedMouseOver);
            GameInterActiveManager.InstallInterActiveEvent(this.m_quickenMcAry[_loc7_].m_movie,ActionEvent.ACTION_MOUSE_OUT,this.speedMouseOut);
            this.m_cancelMcAry[_loc7_] = new HButton(this.mcconstructlistAry[_loc7_].btn_cancel);
            this.m_cancelMcAry[_loc7_].setVisible(false);
            this.showInitBeingDate(_loc7_);
            GameInterActiveManager.InstallInterActiveEvent(this.m_cancelMcAry[_loc7_].m_movie,ActionEvent.ACTION_CLICK,this.cancelChoose);
            _loc7_++;
         }
         TextField(this._mc.getMC().mc_constructlist.tf_page).text = String(this.m_LRbeingPageNumber + 1);
         this._close = new HButton(_mc.getMC().btn_close);
         GameInterActiveManager.InstallInterActiveEvent(this._close.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         this._build = new HButton(_mc.getMC().btn_build);
         GameInterActiveManager.InstallInterActiveEvent(this._build.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         GameInterActiveManager.InstallInterActiveEvent(this._build.m_movie,ActionEvent.ACTION_MOUSE_OVER,this.overButton);
         GameInterActiveManager.InstallInterActiveEvent(this._build.m_movie,ActionEvent.ACTION_MOUSE_OUT,this.outButton);
         this._shipdesign = new HButton(_mc.getMC().btn_shipdesign);
         GameInterActiveManager.InstallInterActiveEvent(this._shipdesign.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         GameInterActiveManager.InstallInterActiveEvent(this._shipdesign.m_movie,ActionEvent.ACTION_MOUSE_OVER,this.overButton);
         GameInterActiveManager.InstallInterActiveEvent(this._shipdesign.m_movie,ActionEvent.ACTION_MOUSE_OUT,this.outButton);
         this._researchcenters = new HButton(_mc.getMC().btn_researchcenters);
         GameInterActiveManager.InstallInterActiveEvent(this._researchcenters.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         GameInterActiveManager.InstallInterActiveEvent(this._researchcenters.m_movie,ActionEvent.ACTION_MOUSE_OVER,this.overButton);
         GameInterActiveManager.InstallInterActiveEvent(this._researchcenters.m_movie,ActionEvent.ACTION_MOUSE_OUT,this.outButton);
      }
      
      private function InitBodyDate() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            if(this.mcairshiplistAry[_loc1_].mc_base.numChildren > 1)
            {
               this.mcairshiplistAry[_loc1_].mc_base.removeChildAt(1);
            }
            if(this.mccancelAry[_loc1_].numChildren > 2)
            {
               this.mccancelAry[_loc1_].removeChildAt(2);
            }
            this.mccancelAry[_loc1_].visible = false;
            _loc1_++;
         }
      }
      
      private function InitPartDate() : void
      {
         var _loc2_:MovieClip = null;
         var _loc1_:int = 0;
         while(_loc1_ < PARTMCMAXNUM)
         {
            _loc2_ = this.mcmodulelistAry[_loc1_].mc_base as MovieClip;
            if(_loc2_.numChildren > 1)
            {
               _loc2_.removeChildAt(1);
            }
            TextField(this.mcmodulelistAry[_loc1_].getChildByName("tf_modulenum")).text = "";
            _loc1_++;
         }
         if(this._mc.getMC().mc_airshipbase.numChildren > 0)
         {
            this._mc.getMC().mc_airshipbase.removeChildAt(0);
         }
      }
      
      private function InitBeingDate() : void
      {
         var _loc2_:MovieClip = null;
         var _loc1_:int = 0;
         while(_loc1_ < BEINGMCMAXNUM)
         {
            TextField(this.mcconstructlistAry[_loc1_].getChildByName("tf_shipname")).text = "";
            TextField(this.mcconstructlistAry[_loc1_].getChildByName("tf_remainnum")).text = "";
            TextField(this.mcconstructlistAry[_loc1_].getChildByName("tf_remaintime")).text = "";
            TextField(this.mcconstructlistAry[_loc1_].getChildByName("tf_text0")).text = "";
            this.m_timeshapeMcAry[_loc1_].visible = false;
            this.m_quickenMcAry[_loc1_].setVisible(false);
            this.m_cancelMcAry[_loc1_].setVisible(false);
            this.showInitBeingDate(_loc1_);
            _loc2_ = this._mc.getMC().mc_constructlist;
            if(this.mcconstructlistAry[_loc1_].mc_base.numChildren > 1)
            {
               this.mcconstructlistAry[_loc1_].mc_base.removeChildAt(1);
            }
            _loc1_++;
         }
      }
      
      public function showInitBeingDate(param1:int) : void
      {
         if(GamePlayer.getInstance().m_ParallelCreateShip == 0)
         {
            if(param1 < this.m_beingMcNum)
            {
               TextField(this.mcconstructlistAry[param1].getChildByName("tf_text")).text = StringManager.getInstance().getMessageString("ShipText11");
               this.mcconstructlistAry[param1].mc_empty.visible = false;
            }
            else if(param1 == 1)
            {
               TextField(this.mcconstructlistAry[param1].getChildByName("tf_text")).text = StringManager.getInstance().getMessageString("ShipText12");
               this.mcconstructlistAry[param1].mc_empty.visible = true;
            }
            else if(param1 == 2)
            {
               TextField(this.mcconstructlistAry[param1].getChildByName("tf_text")).text = StringManager.getInstance().getMessageString("ShipText13");
               this.mcconstructlistAry[param1].mc_empty.visible = true;
            }
            else if(param1 == 3)
            {
               TextField(this.mcconstructlistAry[param1].getChildByName("tf_text")).text = StringManager.getInstance().getMessageString("ShipText14");
               this.mcconstructlistAry[param1].mc_empty.visible = true;
            }
            else if(param1 == 4)
            {
               TextField(this.mcconstructlistAry[param1].getChildByName("tf_text")).text = StringManager.getInstance().getMessageString("ShipText15");
               this.mcconstructlistAry[param1].mc_empty.visible = true;
            }
         }
         else if(param1 < this.m_beingMcNum)
         {
            TextField(this.mcconstructlistAry[param1].getChildByName("tf_text")).text = StringManager.getInstance().getMessageString("ShipText11");
            this.mcconstructlistAry[param1].mc_empty.visible = false;
         }
         else if(param1 == 2)
         {
            TextField(this.mcconstructlistAry[param1].getChildByName("tf_text")).text = StringManager.getInstance().getMessageString("ShipText12");
            this.mcconstructlistAry[param1].mc_empty.visible = true;
         }
         else if(param1 == 3)
         {
            TextField(this.mcconstructlistAry[param1].getChildByName("tf_text")).text = StringManager.getInstance().getMessageString("ShipText13");
            this.mcconstructlistAry[param1].mc_empty.visible = true;
         }
         else if(param1 == 4)
         {
            TextField(this.mcconstructlistAry[param1].getChildByName("tf_text")).text = StringManager.getInstance().getMessageString("ShipText14");
            this.mcconstructlistAry[param1].mc_empty.visible = true;
         }
      }
      
      public function InitPopUp() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < ShipmodelRouter.instance.m_ZoonShipmodelInfoAry.length)
         {
            this.m_shipmodelnameAry[_loc1_] = ShipmodelRouter.instance.m_ZoonShipmodelInfoAry[_loc1_];
            _loc1_++;
         }
         this.m_ifopen = 1;
         this.m_pageNumber = 0;
         this.shipstorage();
         this.showShip();
         if(this.m_shipStorageAry.length > 0)
         {
            this.showPart(this.m_shipStorageAry[0].m_ShipModelId);
         }
         ShipmodelRouter.instance.sendmsgCREATESHIPINFO();
      }
      
      private function showShip() : void
      {
         var _loc2_:String = null;
         var _loc3_:Bitmap = null;
         var _loc4_:int = 0;
         this.InitBodyDate();
         TextField(this._mc.getMC().tf_bluepaper).text = String(ShipmodelRouter.instance.m_ShipmodelInfoAry.length) + "/" + String(MAXSHIPNUM);
         TextField(this._mc.getMC().mc_airshiplist.tf_page).text = String(this.m_pageNumber + 1);
         if(this.m_pageNumber == 0)
         {
            this._shipbodyup.gotoAndStop("disabled");
            this.m_shipbodyup = false;
         }
         else
         {
            this._shipbodyup.gotoAndStop("up");
            this.m_shipbodyup = true;
         }
         if((this.m_pageNumber + 1) * 5 >= ShipmodelRouter.instance.m_ShipmodelInfoAry.length)
         {
            this._shipbodydown.gotoAndStop("disabled");
            this.m_shipbodydown = false;
         }
         else
         {
            this._shipbodydown.gotoAndStop("up");
            this.m_shipbodydown = true;
         }
         var _loc1_:int = 0;
         while(_loc1_ < this.m_shipStorageAry.length)
         {
            _loc2_ = CShipmodelReader.getInstance().getShipBodyInfo(this.m_shipStorageAry[_loc1_].m_BodyId).SmallIcon;
            _loc3_ = new Bitmap(GameKernel.getTextureInstance(_loc2_));
            _loc3_.x = -4;
            this.mcairshiplistAry[_loc1_].mc_base.addChild(_loc3_);
            if(this.m_shipStorageAry[_loc1_].m_PubFlag != 1)
            {
               this.mccancelAry[_loc1_].visible = true;
            }
            _loc1_++;
         }
         if(this.m_chooseNum == 0)
         {
            _loc4_ = 0;
            while(_loc4_ < 5)
            {
               this.mcairshiplistAry[_loc4_].gotoAndStop("up");
               _loc4_++;
            }
            this.mcairshiplistAry[0].gotoAndStop("selected");
         }
      }
      
      public function showPart(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc5_:String = null;
         var _loc8_:int = 0;
         this.m_shipmodleID = param1;
         var _loc2_:ShipmodelInfo = new ShipmodelInfo();
         var _loc4_:Array = new Array();
         TextField(this._mc.getMC().tf_airshipname).text = ShipmodelRouter.instance.m_ShipmodelInfoAry[this.m_num].m_ShipName;
         this.m_partIDAry.length = 0;
         this.m_partNumberAry.length = 0;
         var _loc6_:int = 0;
         while(_loc6_ < this.m_shipStorageAry.length)
         {
            if(param1 == this.m_shipStorageAry[_loc6_].m_ShipModelId)
            {
               _loc2_ = this.m_shipStorageAry[_loc6_];
               break;
            }
            _loc6_++;
         }
         var _loc7_:int = 0;
         while(_loc7_ < _loc2_.m_PartNum)
         {
            _loc3_ = 0;
            _loc8_ = 0;
            while(_loc8_ < _loc7_)
            {
               if(this.m_partIDAry[_loc8_] == _loc2_.m_PartId[_loc7_])
               {
                  if(_loc3_ == 0)
                  {
                     _loc3_ = 1;
                  }
                  ++_loc4_[_loc8_];
                  _loc5_ = String(_loc4_[_loc8_]);
                  this.m_partNumberAry[_loc8_] = _loc5_;
               }
               _loc8_++;
            }
            if(_loc3_ == 0)
            {
               _loc3_ = 1;
               _loc4_.push(_loc3_);
               _loc5_ = String(_loc3_);
               this.m_partIDAry.push(_loc2_.m_PartId[_loc7_]);
               this.m_partNumberAry.push(_loc5_);
            }
            _loc7_++;
         }
         this.partstorage();
      }
      
      private function _showpart() : void
      {
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:Bitmap = null;
         this.InitPartDate();
         var _loc1_:String = CShipmodelReader.getInstance().getShipBodyInfo(ShipmodelRouter.instance.m_ShipmodelInfoAry[this.m_num].m_BodyId).ImageIcon;
         var _loc2_:Bitmap = new Bitmap(GameKernel.getTextureInstance(_loc1_));
         _loc2_.x = -13;
         _loc2_.y = -7;
         this._mc.getMC().mc_airshipbase.addChild(_loc2_);
         TextField(this._mc.getMC().mc_modulelist.tf_page).text = String(this.m_LRpageNumber + 1);
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         while(_loc3_ < PARTMCMAXNUM && _loc4_ < this.m_partStorageAry.length)
         {
            _loc5_ = CShipmodelReader.getInstance().getShipPartInfo(this.m_partStorageAry[_loc4_]).Name;
            _loc6_ = CShipmodelReader.getInstance().getShipPartInfo(this.m_partStorageAry[_loc4_]).ImageFileName;
            _loc7_ = new Bitmap(GameKernel.getTextureInstance(_loc6_));
            this.mcmodulelistAry[_loc4_].mc_base.addChild(_loc7_);
            this.m_partnameStorageAry[_loc4_] = _loc5_;
            TextField(this.mcmodulelistAry[_loc4_].getChildByName("tf_modulenum")).text = this.m_partnumStorageAry[_loc4_];
            _loc3_++;
            _loc4_++;
         }
         if(this.m_LRpageNumber == 0)
         {
            this._partleft.gotoAndStop("disabled");
            this.m_partleft = false;
         }
         else
         {
            this._partleft.gotoAndStop("up");
            this.m_partleft = true;
         }
         if((this.m_LRpageNumber + 1) * 9 >= this.m_partIDAry.length)
         {
            this._partright.gotoAndStop("disabled");
            this.m_partright = false;
         }
         else
         {
            this._partright.gotoAndStop("up");
            this.m_partright = true;
         }
      }
      
      private function choose(param1:Event) : void
      {
         this.m_LRpageNumber = 0;
         this.m_partNumberAry.length = 0;
         this.m_partIDAry.length = 0;
         var _loc2_:String = param1.currentTarget.name;
         _loc2_ = _loc2_.substring(7);
         var _loc3_:int = int(_loc2_);
         this.m_chooseNum = _loc3_;
         this.chooseNum(this.m_chooseNum);
      }
      
      public function chooseNum(param1:int) : void
      {
         var _loc2_:int = 0;
         if(this.m_shipStorageAry.length == 0)
         {
            TextField(this._mc.getMC().tf_airshipname).text = "";
         }
         if(param1 < this.m_shipStorageAry.length)
         {
            this.m_partStorageAry.length = 0;
            _loc2_ = 0;
            while(_loc2_ < 5)
            {
               this.mcairshiplistAry[_loc2_].gotoAndStop("up");
               _loc2_++;
            }
            this.mcairshiplistAry[param1].gotoAndStop("selected");
            this.m_num = this.m_pageNumber * 5 + param1;
            this.showPart(this.m_shipStorageAry[param1].m_ShipModelId);
         }
      }
      
      private function partstorage() : void
      {
         this.m_partStorageAry.length = 0;
         this.m_partnumStorageAry.length = 0;
         var _loc1_:int = this.m_LRpageNumber * PARTMCMAXNUM;
         var _loc2_:int = 0;
         while(_loc1_ < PARTMCMAXNUM * (this.m_LRpageNumber + 1) && _loc1_ < this.m_partIDAry.length)
         {
            this.m_partStorageAry[_loc2_] = this.m_partIDAry[_loc1_];
            this.m_partnumStorageAry[_loc2_] = this.m_partNumberAry[_loc1_];
            _loc1_++;
            _loc2_++;
         }
         this._showpart();
      }
      
      public function beingstorage() : void
      {
         this.m_beingStorageAry.length = 0;
         var _loc1_:int = this.m_LRbeingPageNumber * BEINGMCMAXNUM;
         var _loc2_:int = 0;
         while(_loc1_ < BEINGMCMAXNUM * (this.m_LRbeingPageNumber + 1) && _loc1_ < ShipmodelRouter.instance.m_CreateShipAry.length)
         {
            this.m_beingStorageAry[_loc2_] = ShipmodelRouter.instance.m_CreateShipAry[_loc1_];
            _loc1_++;
            _loc2_++;
         }
         this.m_time.start();
         this.showbeing();
      }
      
      private function shipstorage() : void
      {
         this.m_shipStorageAry.splice(0);
         ShipmodelRouter.instance.m_ShipmodelInfoAry.splice(0);
         var _loc1_:int = 0;
         while(_loc1_ < ShipmodelRouter.instance.m_ZoonShipmodelInfoAry.length)
         {
            if(ShipmodelRouter.instance.m_ZoonShipmodelInfoAry[_loc1_].m_IsShow == 1)
            {
               ShipmodelRouter.instance.m_ShipmodelInfoAry.push(ShipmodelRouter.instance.m_ZoonShipmodelInfoAry[_loc1_]);
            }
            _loc1_++;
         }
         if(this.m_pageNumber * 5 >= ShipmodelRouter.instance.m_ShipmodelInfoAry.length && ShipmodelRouter.instance.m_ShipmodelInfoAry.length != 0)
         {
            --this.m_pageNumber;
         }
         var _loc2_:int = this.m_pageNumber * 5;
         var _loc3_:int = 0;
         while(_loc2_ < 5 * (this.m_pageNumber + 1) && _loc2_ < ShipmodelRouter.instance.m_ShipmodelInfoAry.length)
         {
            this.m_shipStorageAry[_loc3_] = ShipmodelRouter.instance.m_ShipmodelInfoAry[_loc2_];
            _loc2_++;
            _loc3_++;
         }
      }
      
      public function showbeing() : void
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         var _loc6_:String = null;
         var _loc7_:Bitmap = null;
         this.InitBeingDate();
         TextField(this._mc.getMC().mc_constructlist.tf_page).text = String(this.m_LRbeingPageNumber + 1);
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc1_ < BEINGMCMAXNUM && _loc2_ < this.m_beingStorageAry.length)
         {
            _loc3_ = this.m_beingStorageAry[_loc2_].ShipModelId;
            _loc4_ = 0;
            while(_loc4_ < this.m_shipmodelnameAry.length)
            {
               if(this.m_beingStorageAry[_loc2_].ShipModelId == this.m_shipmodelnameAry[_loc4_].m_ShipModelId)
               {
                  _loc3_ = this.m_shipmodelnameAry[_loc4_].m_ShipName;
                  if(this.mcconstructlistAry[_loc2_].mc_base.numChildren > 1)
                  {
                     this.mcconstructlistAry[_loc2_].mc_base.removeChildAt(1);
                  }
                  _loc6_ = CShipmodelReader.getInstance().getShipBodyInfo(this.m_shipmodelnameAry[_loc4_].m_BodyId).SmallIcon;
                  _loc7_ = new Bitmap(GameKernel.getTextureInstance(_loc6_));
                  _loc7_.x = -7;
                  _loc7_.y = 0;
                  this.mcconstructlistAry[_loc2_].mc_base.addChild(_loc7_);
               }
               _loc4_++;
            }
            _loc5_ = this._mc.getMC().mc_constructlist;
            _loc5_.addChild(this.mcconstructlistAry[_loc2_]);
            TextField(this.mcconstructlistAry[_loc2_].getChildByName("tf_shipname")).text = _loc3_;
            TextField(this.mcconstructlistAry[_loc2_].getChildByName("tf_remainnum")).text = this.m_beingStorageAry[_loc2_].Num;
            TextField(this.mcconstructlistAry[_loc2_].getChildByName("tf_text")).text = "";
            TextField(this.mcconstructlistAry[_loc2_].getChildByName("tf_text0")).text = StringManager.getInstance().getMessageString("ShipText23");
            this.m_timeshapeMcAry[_loc2_].visible = true;
            this.m_quickenMcAry[_loc2_].setVisible(true);
            this.m_cancelMcAry[_loc2_].setVisible(true);
            this.m_needTimeAry[_loc2_] = int(this.m_beingStorageAry[_loc2_].NeedTime);
            if(this.m_needTimeAry[_loc2_] > 0)
            {
               _loc3_ = this.changetime(this.m_needTimeAry[_loc2_]);
            }
            else
            {
               _loc3_ = "00:00:00";
            }
            TextField(this.mcconstructlistAry[_loc2_].getChildByName("tf_remaintime")).text = _loc3_;
            _loc3_ = this.m_beingStorageAry[_loc2_].NeedTime;
            if(this.m_LRbeingPageNumber == 0)
            {
               this._buildleft.gotoAndStop("disabled");
               this.m_buildleft = false;
            }
            else
            {
               this._buildleft.gotoAndStop("up");
               this.m_buildleft = true;
            }
            if((this.m_LRbeingPageNumber + 1) * 9 >= ShipmodelRouter.instance.m_CreateShipAry.length)
            {
               this._buildright.gotoAndStop("disabled");
               this.m_buildright = false;
            }
            else
            {
               this._buildright.gotoAndStop("up");
               this.m_buildright = true;
            }
            _loc1_++;
            _loc2_++;
         }
      }
      
      public function changetime(param1:int) : String
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         _loc2_ = param1 / (60 * 60);
         if(_loc2_ >= 10)
         {
            _loc3_ = _loc2_ + ":";
         }
         else
         {
            _loc3_ = "0" + _loc2_ + ":";
         }
         _loc2_ = param1 % (60 * 60) / 60;
         if(_loc2_ >= 10)
         {
            _loc3_ = _loc3_ + _loc2_ + ":";
         }
         else
         {
            _loc3_ = _loc3_ + "0" + _loc2_ + ":";
         }
         _loc2_ = param1 % 60;
         if(_loc2_ >= 10)
         {
            _loc3_ += _loc2_;
         }
         else
         {
            _loc3_ = _loc3_ + "0" + _loc2_;
         }
         return _loc3_;
      }
      
      private function speedChoose(param1:Event) : void
      {
         var _loc2_:String = param1.currentTarget.parent.name;
         _loc2_ = _loc2_.substring(7);
         var _loc3_:int = int(_loc2_);
         _loc3_ = this.m_LRbeingPageNumber * BEINGMCMAXNUM + _loc3_;
         if(this.m_beingStorageAry.length > int(_loc2_))
         {
            if(GamePlayer.getInstance().cash < GamePlayer.getInstance().ShipSpeedCredit)
            {
               ConstructionOperationWidget.currenCmd = OperationEnum.OPERATION_TYPE_NOCASH;
               PrepaidModulePopup.getInstance().Init();
               PrepaidModulePopup.getInstance().setParent(this);
               PrepaidModulePopup.getInstance().Show();
            }
            else if(ShipmodelRouter.instance.m_CreateShipAry[_loc3_].NeedTime - ShipmodelRouter.instance.m_CreateShipAry[_loc3_].Num <= 0)
            {
               this.addBackMC();
               ConstructionOperationWidget.currenCmd = OperationEnum.OPERATION_TYPE_NOSPEED;
               MallBuyModulesPopup.getInstance().Init();
               MallBuyModulesPopup.getInstance().Show();
            }
            else
            {
               ShipmodelRouter.instance.sendmsgSPEEDSHIP(_loc3_);
            }
         }
      }
      
      public function addBackMC() : void
      {
         this.backMc.graphics.clear();
         this.backMc.graphics.beginFill(16711935,0);
         this.backMc.graphics.drawRect(-380,-340,760,850);
         this.backMc.graphics.endFill();
         this._mc.getMC().addChild(this.backMc);
      }
      
      public function removeBackMC() : void
      {
         this._mc.getMC().removeChild(this.backMc);
      }
      
      private function cancelChoose(param1:Event) : void
      {
         var _loc2_:String = param1.currentTarget.parent.name;
         _loc2_ = _loc2_.substring(7);
         var _loc3_:int = int(_loc2_);
         _loc3_ = this.m_LRbeingPageNumber * BEINGMCMAXNUM + _loc3_;
         if(this.m_beingStorageAry.length > int(_loc2_))
         {
            this.addBackMC();
            ConstructionOperationWidget.currenCmd = OperationEnum.OPERATION_TYPE_CANCEL_CREATE;
            UpgradeModulesPopUp.getInstance().Init();
            UpgradeModulesPopUp.getInstance().getbeingCreateNum(_loc3_);
            UpgradeModulesPopUp.getInstance().Show();
         }
      }
      
      public function ErrorCancel() : void
      {
         this.addBackMC();
         ConstructionOperationWidget.currenCmd = OperationEnum.OPERATION_TYPE_ERRORCANCEL;
         MallBuyModulesPopup.getInstance().Init();
         MallBuyModulesPopup.getInstance().Show();
      }
      
      private function downButton(param1:Event) : void
      {
         if(param1.currentTarget.name == "btn_down")
         {
            if(this.m_shipbodydown == true)
            {
               this._shipbodydown.gotoAndStop("down");
            }
         }
         else if(param1.currentTarget.name == "btn_up")
         {
            if(this.m_shipbodyup == true)
            {
               this._shipbodyup.gotoAndStop("down");
            }
         }
         else if(param1.currentTarget.name == "btn_right")
         {
            if(param1.currentTarget.parent.name != "mc_constructlist")
            {
               if(this.m_partright == true)
               {
                  this._partright.gotoAndStop("down");
               }
            }
         }
         else if(param1.currentTarget.name == "btn_left")
         {
            if(param1.currentTarget.parent.name != "mc_constructlist")
            {
               if(this.m_partleft == true)
               {
                  this._partleft.gotoAndStop("down");
               }
            }
         }
      }
      
      private function overButton(param1:Event) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:Point = null;
         var _loc5_:int = 0;
         var _loc2_:TextField = new TextField();
         if(param1.currentTarget.name == "btn_down")
         {
            if(this.m_shipbodydown == true)
            {
               this._shipbodydown.gotoAndStop("over");
            }
         }
         else if(param1.currentTarget.name == "btn_up")
         {
            if(this.m_shipbodyup == true)
            {
               this._shipbodyup.gotoAndStop("over");
            }
         }
         else if(param1.currentTarget.name == "btn_right")
         {
            if(param1.currentTarget.parent.name != "mc_constructlist")
            {
               if(this.m_partright == true)
               {
                  this._partright.gotoAndStop("over");
               }
            }
         }
         else if(param1.currentTarget.name == "btn_left")
         {
            if(param1.currentTarget.parent.name != "mc_constructlist")
            {
               if(this.m_partleft == true)
               {
                  this._partleft.gotoAndStop("over");
               }
            }
         }
         else if(param1.currentTarget.name == "btn_shipdesign")
         {
            _loc2_.text = StringManager.getInstance().getMessageString("ShipText4");
         }
         else if(param1.currentTarget.name == "btn_researchcenters")
         {
            _loc2_.text = StringManager.getInstance().getMessageString("ShipText5");
         }
         else if(param1.currentTarget.name == "btn_build")
         {
            _loc2_.text = StringManager.getInstance().getMessageString("ShipText25");
         }
         if(_loc2_.text != "")
         {
            Suspension.getInstance();
            Suspension.getInstance().Init(_loc2_.textWidth + 5,20,1);
            _loc3_ = param1.currentTarget as MovieClip;
            _loc4_ = _loc3_.localToGlobal(new Point(0,0));
            _loc4_ = this._mc.getMC().globalToLocal(_loc4_);
            Suspension.getInstance().setLocationXY(_loc4_.x,_loc4_.y + param1.currentTarget.height);
            _loc5_ = 0;
            while(_loc5_ < 1)
            {
               Suspension.getInstance().putRectOnlyOne(_loc5_,_loc2_.text,_loc2_.textWidth + 5);
               _loc5_++;
            }
            this._mc.getMC().addChild(Suspension.getInstance());
         }
      }
      
      private function outButton(param1:Event) : void
      {
         if(param1.currentTarget.name == "btn_down")
         {
            if(this.m_shipbodydown == true)
            {
               this._shipbodydown.gotoAndStop("up");
            }
         }
         else if(param1.currentTarget.name == "btn_up")
         {
            if(this.m_shipbodyup == true)
            {
               this._shipbodyup.gotoAndStop("up");
            }
         }
         else if(param1.currentTarget.name == "btn_right")
         {
            if(param1.currentTarget.parent.name != "mc_constructlist")
            {
               if(this.m_partright == true)
               {
                  this._partright.gotoAndStop("up");
               }
            }
         }
         else if(param1.currentTarget.name == "btn_left")
         {
            if(param1.currentTarget.parent.name != "mc_constructlist")
            {
               if(this.m_partleft == true)
               {
                  this._partleft.gotoAndStop("up");
               }
            }
         }
         else if(param1.currentTarget.name == "btn_shipdesign" || param1.currentTarget.name == "btn_researchcenters" || param1.currentTarget.name == "btn_build")
         {
            if(this.m_ifopen == 1)
            {
               this._mc.getMC().removeChild(Suspension.getInstance());
               Suspension.getInstance().delinstance();
            }
         }
      }
      
      private function chickButton(param1:Event) : void
      {
         if(param1.currentTarget.name == "btn_down")
         {
            if((this.m_pageNumber + 1) * 5 < ShipmodelRouter.instance.m_ShipmodelInfoAry.length)
            {
               this.m_LRpageNumber = 0;
               this.m_partNumberAry.length = 0;
               this.m_partIDAry.length = 0;
               ++this.m_pageNumber;
               this.shipstorage();
               this.showShip();
               this.chooseNum(0);
               this.showPart(this.m_shipStorageAry[0].m_ShipModelId);
            }
         }
         else if(param1.currentTarget.name == "btn_up")
         {
            if(this.m_pageNumber > 0)
            {
               this.m_LRpageNumber = 0;
               this.m_partNumberAry.length = 0;
               this.m_partIDAry.length = 0;
               --this.m_pageNumber;
               this.shipstorage();
               this.showShip();
               this.chooseNum(0);
               this.showPart(this.m_shipStorageAry[0].m_ShipModelId);
            }
         }
         else if(param1.currentTarget.name == "btn_right")
         {
            if(param1.currentTarget.parent.name == "mc_constructlist")
            {
               if((this.m_LRbeingPageNumber + 1) * BEINGMCMAXNUM < ShipmodelRouter.instance.m_CreateShipAry.length)
               {
                  ++this.m_LRbeingPageNumber;
                  this.beingstorage();
               }
            }
            else if((this.m_LRpageNumber + 1) * PARTMCMAXNUM < this.m_partIDAry.length)
            {
               ++this.m_LRpageNumber;
               this.partstorage();
            }
         }
         else if(param1.currentTarget.name == "btn_left")
         {
            if(param1.currentTarget.parent.name == "mc_constructlist")
            {
               if(this.m_LRbeingPageNumber > 0)
               {
                  --this.m_LRbeingPageNumber;
                  this.beingstorage();
               }
            }
            else if(this.m_LRpageNumber > 0)
            {
               --this.m_LRpageNumber;
               this.partstorage();
            }
         }
         else if(param1.currentTarget.name == "btn_close")
         {
            this.m_ifopen = 0;
            this.m_num = 0;
            this.m_chooseNum = 0;
            this.m_partNumberAry.length = 0;
            this.m_partIDAry.length = 0;
            this.m_shipStorageAry.length = 0;
            this.m_time.stop();
            unstallDiagPopUp(CreateShipUI.getInstance());
            Suspension.getInstance().delinstance();
            GameKernel.popUpDisplayManager.Hide(instance);
         }
         else if(param1.currentTarget.name == "btn_build")
         {
            if(ShipmodelRouter.instance.m_ShipmodelInfoAry.length == 0)
            {
               return;
            }
            if(ShipmodelRouter.instance.m_CreateShipAry.length < this.m_beingMcNum)
            {
               if(this.m_shipmodleID != -1)
               {
                  this.addBackMC();
                  CreateShipUI.getInstance().Init();
                  CreateShipUI.getInstance().setParent(instance);
                  CreateShipUI.getInstance().Show(StringManager.getInstance().getMessageString("ShipText21"));
               }
            }
            else
            {
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("ShipText1"),0);
            }
         }
         else if(param1.currentTarget.name == "btn_shipdesign")
         {
            this._mc.getMC().removeChild(Suspension.getInstance());
            Suspension.getInstance().delinstance();
            this.m_ifopen = 0;
            this.m_time.stop();
            unstallDiagPopUp(CreateShipUI.getInstance());
            Suspension.getInstance().delinstance();
            GameKernel.popUpDisplayManager.Hide(instance);
            ShipModeEditUI.getInstance().Init();
            GameKernel.popUpDisplayManager.Show(ShipModeEditUI.getInstance());
         }
         else if(param1.currentTarget.name == "btn_researchcenters")
         {
            if(ConstructionAction.getInstance().getWeaponResearchNumber() == -1)
            {
               CEffectText.getInstance().showEffectText(GameKernel.renderManager.getUI().getContainer(),StringManager.getInstance().getMessageString("ShipText28"));
               return;
            }
            this._mc.getMC().removeChild(Suspension.getInstance());
            Suspension.getInstance().delinstance();
            this.m_ifopen = 0;
            this.m_time.stop();
            unstallDiagPopUp(CreateShipUI.getInstance());
            Suspension.getInstance().delinstance();
            GameKernel.popUpDisplayManager.Hide(instance);
            UpgradeUI.getInstance().Init();
            GameKernel.popUpDisplayManager.Show(UpgradeUI.getInstance());
         }
      }
      
      private function onTick(param1:TimerEvent) : void
      {
         var _loc2_:String = null;
         if(ShipmodelRouter.instance.m_CreateShipAry.length == 0)
         {
            this.m_time.stop();
         }
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         while(_loc3_ < ShipmodelRouter.instance.m_CreateShipAry.length)
         {
            if(--ShipmodelRouter.instance.m_CreateShipAry[_loc3_].NeedTime > 0)
            {
               if(_loc3_ < (this.m_LRbeingPageNumber + 1) * BEINGMCMAXNUM && _loc3_ >= this.m_LRbeingPageNumber * BEINGMCMAXNUM)
               {
                  _loc2_ = this.changetime(ShipmodelRouter.instance.m_CreateShipAry[_loc3_].NeedTime);
                  TextField(this.mcconstructlistAry[_loc4_].getChildByName("tf_remaintime")).text = _loc2_;
                  _loc4_++;
               }
            }
            _loc3_++;
         }
      }
      
      private function delmodel(param1:MouseEvent) : void
      {
         var _loc2_:String = param1.currentTarget.name;
         _loc2_ = _loc2_.substring(10);
         var _loc3_:int = int(_loc2_);
         if(this.m_shipStorageAry.length > _loc3_ && this.m_shipStorageAry[_loc3_].m_PubFlag != 1)
         {
            ConstructionOperationWidget.currenCmd = OperationEnum.OPERATION_TYPE_DELSHIPMODEL;
            UpgradeModulesPopUp.getInstance().Init();
            UpgradeModulesPopUp.getInstance().getdelShipmodel(_loc3_);
            UpgradeModulesPopUp.getInstance().Show();
         }
      }
      
      public function _delmodel(param1:int) : void
      {
         ShipmodelRouter.instance.sendmsgDELETESHIPMODEL(this.m_shipStorageAry[param1].m_ShipModelId);
         var _loc2_:int = 0;
         while(_loc2_ < ShipmodelRouter.instance.m_ZoonShipmodelInfoAry.length)
         {
            if(this.m_shipStorageAry[param1].m_ShipModelId == ShipmodelRouter.instance.m_ZoonShipmodelInfoAry[_loc2_].m_ShipModelId)
            {
               ShipmodelRouter.instance.m_ZoonShipmodelInfoAry[_loc2_].m_IsShow = 0;
               break;
            }
            _loc2_++;
         }
         this.shipstorage();
         this.showShip();
         this.chooseNum(0);
         if(this.m_shipStorageAry[0] != null)
         {
            this.m_shipmodleID = this.m_shipStorageAry[0].m_ShipModelId;
         }
         else
         {
            this.InitPartDate();
            this.m_shipmodleID = -1;
         }
      }
      
      private function mouseout(param1:MouseEvent) : void
      {
         var _loc2_:String = param1.currentTarget.name;
         _loc2_ = _loc2_.substring(7);
         var _loc3_:int = int(_loc2_);
         if(this.m_shipStorageAry.length > _loc3_)
         {
            this._mc.getMC().removeChild(Suspension.getInstance());
            Suspension.getInstance().delinstance();
         }
      }
      
      private function mouseover(param1:Event) : void
      {
         var _loc4_:ShipbodyInfo = null;
         var _loc5_:int = 0;
         var _loc6_:MovieClip = null;
         var _loc7_:Point = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc2_:String = param1.currentTarget.name;
         _loc2_ = _loc2_.substring(7);
         var _loc3_:int = int(_loc2_);
         if(this.m_shipStorageAry.length > _loc3_)
         {
            _loc4_ = CShipmodelReader.getInstance().getShipBodyInfo(this.m_shipStorageAry[_loc3_].m_BodyId);
            this.shipinfo.KindName = _loc4_.KindName;
            this.shipinfo.Shield = _loc4_.Shield;
            this.shipinfo.Endure = _loc4_.Endure;
            this.shipinfo.Locomotivity = _loc4_.Locomotivity;
            this.shipinfo.Yare = _loc4_.Yare;
            this.shipinfo.Storage = _loc4_.Storage;
            this.shipinfo.Cubage = _loc4_.Cubage;
            this.shipinfo.TransitionTime = _loc4_.TransitionTime;
            this.shipinfo.UnitSupply = _loc4_.UnitSupply;
            this.shipinfo.CreateTime = _loc4_.CreateTime;
            this.shipinfo.Metal = _loc4_.Metal;
            this.shipinfo.He3 = _loc4_.He3;
            this.shipinfo.money = _loc4_.Money;
            this.shipinfo.ValidNum = _loc4_.ValidNum;
            this.m_times = 0;
            _loc5_ = 0;
            while(_loc5_ < this.m_shipStorageAry[_loc3_].m_PartNum)
            {
               _loc10_ = int(this.m_shipStorageAry[_loc3_].m_PartId[_loc5_]);
               this.shipinfo = this.addpart(_loc10_,this.shipinfo);
               _loc5_++;
            }
            this.shipinfo.Yare = int(this.shipinfo.Yare * 100) / 100;
            Suspension.getInstance();
            Suspension.getInstance().Init(200,20 * 13,0);
            _loc6_ = param1.currentTarget as MovieClip;
            _loc7_ = _loc6_.localToGlobal(new Point(0,0));
            _loc7_ = this._mc.getMC().globalToLocal(_loc7_);
            Suspension.getInstance().setLocationXY(_loc7_.x + param1.currentTarget.height + 20,_loc7_.y);
            this._mc.getMC().addChild(Suspension.getInstance());
            this.shipinfo.shipmodelproAry.length = 0;
            this.shipinfo.getshipPro();
            _loc8_ = 0;
            while(_loc8_ < 10)
            {
               Suspension.getInstance().putRect(_loc8_,"    " + this.m_itemnameAry[_loc8_],this.shipinfo.shipmodelproAry[_loc8_],13417082,65280);
               _loc8_++;
            }
            _loc9_ = 10;
            while(_loc9_ < 13)
            {
               Suspension.getInstance().putRectImg(_loc9_,this.m_itemnameAry[_loc9_],this.shipinfo.shipmodelproAry[_loc9_],13417082,65280);
               _loc9_++;
            }
         }
      }
      
      private function speedMouseOver(param1:Event) : void
      {
         var _loc4_:TextField = null;
         var _loc5_:MovieClip = null;
         var _loc6_:Point = null;
         var _loc7_:int = 0;
         var _loc2_:String = param1.currentTarget.parent.name;
         _loc2_ = _loc2_.substring(7);
         var _loc3_:int = int(_loc2_);
         if(_loc3_ < this.m_beingStorageAry.length)
         {
            this.IsSpeedOver = true;
            _loc4_ = new TextField();
            _loc4_.htmlText = StringManager.getInstance().getMessageString("ShipText2");
            _loc4_.wordWrap = true;
            _loc4_.autoSize = TextFieldAutoSize.LEFT;
            _loc4_.multiline = true;
            Suspension.getInstance();
            Suspension.getInstance().Init(100,_loc4_.height,1);
            _loc5_ = param1.currentTarget as MovieClip;
            _loc6_ = _loc5_.localToGlobal(new Point(0,0));
            _loc6_ = this._mc.getMC().globalToLocal(_loc6_);
            Suspension.getInstance().setLocationXY(_loc6_.x - 30,_loc6_.y + 25);
            _loc7_ = 0;
            while(_loc7_ < 1)
            {
               Suspension.getInstance().putRectOnlyOne(_loc7_,StringManager.getInstance().getMessageString("ShipText2"),100,_loc4_.height);
               _loc7_++;
            }
            this._mc.getMC().addChild(Suspension.getInstance());
         }
      }
      
      private function speedMouseOut(param1:Event) : void
      {
         var _loc2_:String = param1.currentTarget.name;
         _loc2_ = _loc2_.substring(7);
         var _loc3_:int = int(_loc2_);
         if(_loc3_ < this.m_beingStorageAry.length)
         {
            if(this.IsSpeedOver == true)
            {
               this.IsSpeedOver = false;
               this._mc.getMC().removeChild(Suspension.getInstance());
               Suspension.getInstance().delinstance();
            }
         }
      }
      
      private function PartMouseOver(param1:Event) : void
      {
         var _loc4_:TextField = null;
         var _loc5_:MovieClip = null;
         var _loc6_:Point = null;
         var _loc7_:int = 0;
         var _loc2_:String = param1.currentTarget.name;
         _loc2_ = _loc2_.substring(7);
         var _loc3_:int = int(_loc2_);
         if(_loc3_ < this.m_partStorageAry.length)
         {
            _loc4_ = new TextField();
            _loc4_.text = this.m_partnameStorageAry[_loc3_];
            Suspension.getInstance();
            Suspension.getInstance().Init(_loc4_.textWidth + 5,20,1);
            _loc5_ = param1.currentTarget as MovieClip;
            _loc6_ = _loc5_.localToGlobal(new Point(0,0));
            _loc6_ = this._mc.getMC().globalToLocal(_loc6_);
            Suspension.getInstance().setLocationXY(_loc6_.x,_loc6_.y + 68);
            _loc7_ = 0;
            while(_loc7_ < 1)
            {
               Suspension.getInstance().putRectOnlyOne(_loc7_,this.m_partnameStorageAry[_loc3_],_loc4_.textWidth + 5);
               _loc7_++;
            }
            this._mc.getMC().addChild(Suspension.getInstance());
         }
      }
      
      private function PartMouseOut(param1:Event) : void
      {
         var _loc2_:String = param1.currentTarget.name;
         _loc2_ = _loc2_.substring(7);
         var _loc3_:int = int(_loc2_);
         if(_loc3_ < this.m_partStorageAry.length)
         {
            this._mc.getMC().removeChild(Suspension.getInstance());
            Suspension.getInstance().delinstance();
         }
      }
      
      private function addpart(param1:int, param2:ShipModelProperty) : ShipModelProperty
      {
         var _loc3_:ShippartInfo = CShipmodelReader.getInstance().getShipPartInfo(param1);
         param2.Shield += _loc3_.Shield;
         param2.Endure += _loc3_.Endure;
         param2.Locomotivity += _loc3_.Locomotivity;
         param2.Yare += _loc3_.Yare;
         var _loc4_:int = _loc3_.MinRange;
         var _loc5_:int = _loc3_.MaxRange;
         var _loc6_:int = _loc3_.MinAssault;
         var _loc7_:int = _loc3_.MaxAssault;
         if(this.m_times == 0)
         {
            param2.MinAssault = _loc6_;
            param2.MaxAssault = _loc7_;
            param2.MinRange = _loc4_;
            param2.MaxRange = _loc5_;
            ++this.m_times;
         }
         else
         {
            param2.MinAssault += _loc3_.MinAssault;
            param2.MaxAssault += _loc3_.MaxAssault;
            if(param2.MinRange > _loc4_ && _loc4_ > 0 || param2.MinRange == 0)
            {
               param2.MinRange = _loc4_;
            }
            if(param2.MaxRange < _loc5_)
            {
               param2.MaxRange = _loc5_;
            }
         }
         param2.Storage += _loc3_.Storage;
         param2.Cubage += _loc3_.Cubage;
         param2.TransitionTime += _loc3_.TransitionTime;
         param2.UnitSupply += _loc3_.UnitSupply;
         param2.CreateTime += _loc3_.CreateTime;
         param2.Metal += _loc3_.Metal;
         param2.He3 += _loc3_.He3;
         param2.money += _loc3_.Money;
         return param2;
      }
      
      private function CancelMouseOver(param1:Event) : void
      {
         var _loc2_:String = param1.currentTarget.name;
         _loc2_ = _loc2_.substring(10);
         var _loc3_:int = int(_loc2_);
         if(_loc3_ < this.m_shipStorageAry.length)
         {
         }
      }
      
      private function CancelMouseOut(param1:Event) : void
      {
         var _loc2_:String = param1.currentTarget.name;
         _loc2_ = _loc2_.substring(10);
         var _loc3_:int = int(_loc2_);
      }
      
      public function reMoverText() : void
      {
         this._mc.getMC().removeChild(Suspension.getInstance());
         Suspension.getInstance().delinstance();
      }
      
      private function btn_helpClick(param1:MouseEvent) : void
      {
         if(this._mc.contains(this.McHelp))
         {
            this._mc.removeChild(this.McHelp);
            this.Invalid(true);
         }
         else
         {
            this.Invalid(false);
            this._mc.addChild(this.McHelp);
         }
      }
      
      private function McHelpClick(param1:MouseEvent) : void
      {
         this.Invalid(true);
         this._mc.removeChild(this.McHelp);
      }
   }
}

