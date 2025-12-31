package logic.ui
{
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.HashSet;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.Timer;
   import logic.action.ConstructionAction;
   import logic.entry.GShip;
   import logic.entry.GShipTeam;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.HButtonType;
   import logic.entry.MObject;
   import logic.entry.ScienceSystem;
   import logic.entry.commander.CommanderInfo;
   import logic.entry.fleet.ShipTeamInfo;
   import logic.entry.shipmodel.ShipbodyInfo;
   import logic.entry.shipmodel.ShipmodelInfo;
   import logic.entry.shipmodel.ShippartInfo;
   import logic.game.GameKernel;
   import logic.manager.GalaxyShipManager;
   import logic.reader.CShipmodelReader;
   import logic.ui.tip.CaptionTip;
   import logic.ui.tip.CommanderInfoTip;
   import logic.ui.tip.CustomTip;
   import logic.ui.tip.ShipModelInfoTip;
   import logic.widget.ConstructionOperationWidget;
   import logic.widget.DataWidget;
   import logic.widget.OperationEnum;
   import net.base.NetManager;
   import net.common.MsgTypes;
   import net.msg.LoadHe3.MSG_REQUEST_UNLOADSHIPTEAM;
   import net.msg.commanderMsg.MSG_REQUEST_COMMANDEREDITSHIPTEAM;
   import net.msg.commanderMsg.MSG_SHIPTEAM_NUM;
   import net.msg.fleetMsg.MSG_REQUEST_ARRANGESHIPTEAM;
   import net.msg.fleetMsg.MSG_REQUEST_COMMANDERINFOARRANGE;
   import net.msg.fleetMsg.MSG_REQUEST_CREATESHIPTEAM;
   import net.msg.fleetMsg.MSG_REQUEST_CREATETEAMMODEL;
   import net.msg.fleetMsg.MSG_REQUEST_EDITSHIPTEAM;
   import net.msg.fleetMsg.MSG_RESP_ARRANGESHIPTEAM;
   import net.msg.fleetMsg.MSG_RESP_COMMANDERINFOARRANGE;
   import net.msg.fleetMsg.MSG_RESP_TEAMMODELINFO;
   import net.msg.fleetMsg.MSG_SHIPTEAM_NUM;
   import net.msg.fleetMsg.TeamModel;
   import net.router.CommanderRouter;
   import net.router.FleetRouter;
   import net.router.ShipmodelRouter;
   
   public class FleetEditUI extends AbstractPopUp
   {
      
      private static var instance:FleetEditUI;
      
      private const ComanderPageSize:int = 6;
      
      private var MsgArrangShipTeam:HashSet = new HashSet();
      
      private var MsgArrangShipTeamArr:Array = new Array();
      
      private var LeftBtn:HButton;
      
      private var RightBtn:HButton;
      
      private var btn_up:HButton;
      
      private var btn_down:HButton;
      
      private var ShipPageTextField:TextField;
      
      private var ArrangeShipPageIndex:int;
      
      private var ArrangeShipImg:Array = new Array();
      
      private var ArrangeShipNum:Array = new Array();
      
      private var _FleetInfo:ShipTeamInfo = new ShipTeamInfo();
      
      private var TeamShipDisplay:Array = new Array();
      
      private var TeamShipImg:Array = new Array();
      
      private var TeamShipNum:Array = new Array();
      
      private var FleetNameTextField:XTextField;
      
      private var SelectedImg:MovieClip;
      
      private var SelectedIndex:int;
      
      private var SelectedModelInfo:ShipmodelInfo;
      
      private var SelectedBodyInfo:ShipbodyInfo;
      
      private var SelectedCellId:int;
      
      private var ReplaceCellId:int;
      
      private var SelectedShipIndex:int;
      
      private var SelectedModelId:int;
      
      private var Locomotivity:int;
      
      private var Storage:int;
      
      private var SkeepCount:int;
      
      private var Endure:int;
      
      private var MinAssault:int;
      
      private var MaxAssault:int;
      
      private var ShipCount:int;
      
      private var Supply:Number;
      
      private var tfLocomotivity:TextField;
      
      private var tfStorage:TextField;
      
      private var tfSkeepCount:TextField;
      
      private var tfEndure:TextField;
      
      private var tfAssault:TextField;
      
      private var tfShipCount:TextField;
      
      private var tfCommanderPage:TextField;
      
      private var CommanderPageId:int;
      
      private var IsUpdate:Boolean = false;
      
      private var UpdateFleetId:int;
      
      private var UpdateFleetCommanderId:int;
      
      private var TeamModelInfo:MSG_RESP_TEAMMODELINFO;
      
      private var BtnLoading:MovieClip;
      
      private var CancelBtn:MovieClip;
      
      private var DeleteBtn:MovieClip;
      
      private var CreateTeamBtn:MovieClip;
      
      private var SelectedModelIndex:int;
      
      private var CurCommanderPage:int;
      
      private var SelectedCommanderMc:MovieClip;
      
      private var SelectedCommanderId:int;
      
      private var CommanderPgaeCount:int;
      
      private var CommanderList:Array = new Array();
      
      private var startDrag:Boolean = false;
      
      private var SelectedArrangeShipMc:MovieClip;
      
      private var ArrangeShipList:MovieClip;
      
      private var _AtHome:Boolean = true;
      
      private var m_time:Timer;
      
      private var _hireadmiral:MovieClip;
      
      private var _cdtime:HButton;
      
      private var IsCooling:Boolean;
      
      private var m_hireadmiralAry:Array;
      
      private var backMc:MovieClip = new MovieClip();
      
      private var McHelp:MovieClip;
      
      private var mc_combox0:MovieClip;
      
      private var mc_combox1:MovieClip;
      
      private var _Target:int;
      
      private var _TargetInterval:int;
      
      public function FleetEditUI()
      {
         super();
         setPopUpName("FleetEditUI");
      }
      
      public static function getInstance() : FleetEditUI
      {
         if(instance == null)
         {
            instance = new FleetEditUI();
         }
         return instance;
      }
      
      override public function Init() : void
      {
         this.SelectedImg = new MovieClip();
         this.IsUpdate = false;
         if(!GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            this._mc = new MObject("FoundfleetScene",363,305);
            this.initMcElement();
            GameKernel.popUpDisplayManager.Regisger(instance);
         }
         this.Clear();
         if(this._AtHome)
         {
            this.RequestArrangeShipTeam();
            this.RequestCommanderInfo();
            this.SetEditControlsVisible(true);
         }
         else
         {
            this.SetEditControlsVisible(false);
         }
         if(CommanderRouter.instance.NextInviteTime > 0)
         {
            this._cdtime.m_movie.visible = true;
            this._hireadmiral.gotoAndStop(4);
            this.IsCooling = true;
            TextField(this._cdtime.m_movie.tf_remaintime).text = this.changetime(CommanderRouter.instance.NextInviteTime);
            this.m_time.start();
         }
         else
         {
            this._cdtime.m_movie.visible = false;
            this._hireadmiral.gotoAndStop(1);
            this.IsCooling = false;
         }
      }
      
      private function SetEditControlsVisible(param1:Boolean) : void
      {
         DisplayObject(this._mc.getMC().mc_airshiplist).visible = param1;
         DisplayObject(this._mc.getMC().mc_bg).visible = param1;
         DisplayObject(this._mc.getMC().mc_fleetlist).visible = param1;
         this._cdtime.setVisible(param1);
         DisplayObject(this._mc.getMC().mc_shade).visible = param1;
         DisplayObject(this._mc.getMC().btn_read0).visible = param1;
         DisplayObject(this._mc.getMC().btn_read1).visible = param1;
         DisplayObject(this._mc.getMC().btn_read2).visible = param1;
         DisplayObject(this._mc.getMC().btn_save0).visible = param1;
         DisplayObject(this._mc.getMC().btn_save1).visible = param1;
         DisplayObject(this._mc.getMC().btn_save2).visible = param1;
         DisplayObject(this._mc.getMC().btn_help).visible = param1;
      }
      
      public function Clear() : void
      {
         this.ClearCombox();
         this.ClearShipTeam();
      }
      
      private function ClearCombox() : void
      {
         this._Target = 0;
         this._TargetInterval = 0;
         TextField(this._mc.getMC().mc_combox0.tf_txt).text = StringManager.getInstance().getMessageString("FormationText6");
         TextField(this._mc.getMC().mc_combox1.tf_txt).text = StringManager.getInstance().getMessageString("FormationText8");
      }
      
      private function ClearShipTeam() : void
      {
         var _loc5_:TextField = null;
         var _loc6_:MovieClip = null;
         this.UpdateFleetCommanderId = -1;
         this.SelectedCommanderId = -1;
         this.Locomotivity = 0;
         this.Storage = 0;
         this.SkeepCount = 0;
         this.Endure = 0;
         this.MinAssault = 0;
         this.MaxAssault = 0;
         this.ShipCount = 0;
         this.Supply = 0;
         this.FleetNameTextField.text = "";
         this.tfLocomotivity.text = "";
         this.tfStorage.text = "";
         this.tfSkeepCount.text = "";
         this.tfEndure.text = "";
         this.tfAssault.text = "";
         this.tfShipCount.text = "";
         var _loc1_:int = 0;
         while(_loc1_ < 9)
         {
            _loc5_ = this.TeamShipNum[_loc1_];
            _loc5_.text = "";
            _loc6_ = this.TeamShipImg[_loc1_];
            if(_loc6_.numChildren > 0)
            {
               _loc6_.removeChildAt(0);
            }
            _loc6_.alpha = 1;
            this._FleetInfo.Num[_loc1_] = 0;
            this._FleetInfo.ShipModelId[_loc1_] = -1;
            _loc1_++;
         }
         this.MsgArrangShipTeam.Clear();
         this.MsgArrangShipTeamArr.length = 0;
         this.ArrangeShipPageIndex = 0;
         this.ShowArrangeShip();
         this.BtnLoading.visible = false;
         this.CancelBtn.visible = false;
         this.DeleteBtn.visible = false;
         this.CreateTeamBtn.visible = true;
         if(this.SelectedArrangeShipMc != null)
         {
            this.SelectedArrangeShipMc.gotoAndStop("up");
            this.SelectedArrangeShipMc = null;
         }
         var _loc2_:TextField = this._mc.getMC().getChildByName("tf_commandername") as TextField;
         _loc2_.text = "";
         var _loc3_:TextField = this._mc.getMC().getChildByName("tf_lv") as TextField;
         _loc3_.text = "";
         var _loc4_:MovieClip = this._mc.getMC().getChildByName("mc_base") as MovieClip;
         if(_loc4_.numChildren > 0)
         {
            _loc4_.removeChildAt(0);
         }
         this.FleetNameTextField.ResetDefaultText();
      }
      
      override public function initMcElement() : void
      {
         var _loc1_:HButton = null;
         var _loc2_:MovieClip = null;
         _loc2_ = this._mc.getMC().getChildByName("btn_close") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.CloseClick);
         this.CreateTeamBtn = this._mc.getMC().getChildByName("btn_ensure") as MovieClip;
         _loc1_ = new HButton(this.CreateTeamBtn);
         this.CreateTeamBtn.addEventListener(MouseEvent.CLICK,this.BuildFleetOk);
         var _loc3_:TextField = this._mc.getMC().getChildByName("tf_fleetname") as TextField;
         _loc3_.maxChars = GamePlayer.getInstance().language == 0 ? 8 : 16;
         this.FleetNameTextField = new XTextField(_loc3_,StringManager.getInstance().getMessageString("FormationText0"));
         _loc3_.addEventListener(Event.CHANGE,this.tf_fleetnameChange);
         this._cdtime = new HButton(this._mc.getMC().btn_cdtime);
         this._cdtime.m_movie.visible = false;
         this._cdtime.m_movie.addEventListener(ActionEvent.ACTION_MOUSE_OVER,this.overButton);
         this._cdtime.m_movie.addEventListener(ActionEvent.ACTION_MOUSE_OUT,this.outButton);
         this._hireadmiral = this._mc.getMC().btn_hireadmiral as MovieClip;
         this._hireadmiral.gotoAndStop("up");
         this._hireadmiral.addEventListener(ActionEvent.ACTION_CLICK,this.clickButton);
         this._hireadmiral.addEventListener(ActionEvent.ACTION_MOUSE_OVER,this.overButton);
         this._hireadmiral.addEventListener(ActionEvent.ACTION_MOUSE_OUT,this.outButton);
         this._mc.getMC().btn_cdtime.tf_remaintime.text = "";
         this.m_time = new Timer(1000);
         this.m_time.addEventListener(TimerEvent.TIMER,this.onTick,false,0,true);
         this.m_hireadmiralAry = new Array(StringManager.getInstance().getMessageString("CommanderText4"),"","","","");
         _loc1_ = new HButton(this._mc.getMC().btn_help,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("IconText39"));
         this._mc.getMC().btn_help.addEventListener(MouseEvent.CLICK,this.btn_helpClick);
         this.McHelp = GameKernel.getMovieClipInstance("HelpMc2",_mc.getMC().x,_mc.getMC().y);
         this.McHelp.addEventListener(MouseEvent.CLICK,this.McHelpClick);
         this.tfLocomotivity = this._mc.getMC().getChildByName("tf_yidongli") as TextField;
         this.tfStorage = this._mc.getMC().getChildByName("tf_cunchu") as TextField;
         this.tfSkeepCount = this._mc.getMC().getChildByName("tf_huihe") as TextField;
         this.tfEndure = this._mc.getMC().getChildByName("tf_xueliang") as TextField;
         this.tfAssault = this._mc.getMC().getChildByName("tf_gongjili") as TextField;
         this.tfShipCount = this._mc.getMC().getChildByName("tf_jianchuan") as TextField;
         this.IniCommander();
         this.IniArrangeShip();
         this.IniFleetShip();
         this.IniComboBox();
         this.IniTeamTemp();
         this.InitCaption();
      }
      
      private function InitCaption() : void
      {
         var _loc1_:CaptionTip = null;
         _loc1_ = new CaptionTip(this._mc.getMC().btn_yidongli,StringManager.getInstance().getMessageString("IconText0"));
         _loc1_ = new CaptionTip(this._mc.getMC().btn_cunchu,StringManager.getInstance().getMessageString("IconText1"));
         _loc1_ = new CaptionTip(this._mc.getMC().btn_huihe,StringManager.getInstance().getMessageString("IconText2"));
         _loc1_ = new CaptionTip(this._mc.getMC().btn_xueliang,StringManager.getInstance().getMessageString("IconText3"));
         _loc1_ = new CaptionTip(this._mc.getMC().btn_gongjili,StringManager.getInstance().getMessageString("IconText4"));
         _loc1_ = new CaptionTip(this._mc.getMC().btn_jianchuan,StringManager.getInstance().getMessageString("IconText5"));
         MovieClip(this._mc.getMC().btn_yidongli).doubleClickEnabled = true;
         MovieClip(this._mc.getMC().btn_yidongli).addEventListener(MouseEvent.DOUBLE_CLICK,this.ShowTempButton);
      }
      
      private function ShowTempButton(param1:Event) : void
      {
         DisplayObject(this._mc.getMC().mc_shade).visible = true;
         DisplayObject(this._mc.getMC().btn_read0).visible = true;
         DisplayObject(this._mc.getMC().btn_read1).visible = true;
         DisplayObject(this._mc.getMC().btn_read2).visible = true;
         DisplayObject(this._mc.getMC().btn_save0).visible = true;
         DisplayObject(this._mc.getMC().btn_save1).visible = true;
         DisplayObject(this._mc.getMC().btn_save2).visible = true;
      }
      
      private function IniCommander() : void
      {
         var _loc1_:HButton = null;
         var _loc2_:MovieClip = null;
         var _loc3_:MovieClip = this._mc.getMC().getChildByName("mc_airshiplist") as MovieClip;
         _loc2_ = _loc3_.btn_up;
         this.btn_up = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.BtnUpClick);
         _loc2_ = _loc3_.btn_down;
         this.btn_down = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.BtnDownClick);
         var _loc4_:int = 0;
         while(_loc4_ < this.ComanderPageSize)
         {
            _loc2_ = _loc3_.getChildByName("mc_list" + _loc4_) as MovieClip;
            _loc2_.visible = false;
            _loc2_.stop();
            _loc2_.buttonMode = true;
            _loc2_.mouseChildren = false;
            _loc2_.addEventListener(MouseEvent.CLICK,this.CommanderClick);
            _loc2_.addEventListener(MouseEvent.MOUSE_OVER,this.CommanderMouseOver);
            _loc2_.addEventListener(MouseEvent.MOUSE_OUT,this.CommanderMouseOut);
            _loc4_++;
         }
      }
      
      private function IniTeamTemp() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:MovieClip = null;
         var _loc3_:HButton = null;
         var _loc4_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < 3)
         {
            _loc1_ = this._mc.getMC().getChildByName("btn_save" + _loc4_) as MovieClip;
            _loc3_ = new HButton(_loc1_);
            _loc1_.addEventListener(MouseEvent.CLICK,this.SaveClick);
            _loc1_.addEventListener(MouseEvent.MOUSE_OVER,this.McSaveMouseOver);
            _loc1_.addEventListener(MouseEvent.MOUSE_OUT,this.McSaveMouseOut);
            _loc2_ = this._mc.getMC().getChildByName("btn_read" + _loc4_) as MovieClip;
            _loc3_ = new HButton(_loc2_);
            _loc2_.addEventListener(MouseEvent.CLICK,this.ReadClick);
            _loc2_.addEventListener(MouseEvent.MOUSE_OVER,this.McReadMouseOver);
            _loc2_.addEventListener(MouseEvent.MOUSE_OUT,this.McReadMouseOut);
            if(_loc4_ < FleetRouter.instance.TeamModelInfo.DataLen)
            {
               _loc1_.visible = false;
               _loc2_.visible = true;
            }
            else
            {
               _loc1_.visible = true;
               _loc2_.visible = false;
            }
            _loc4_++;
         }
         this.BtnLoading = GameKernel.getMovieClipInstance("LoadingBtnMc",0,0,false);
         this.BtnLoading.addEventListener(MouseEvent.CLICK,this.BtnLoadingClick);
         this._mc.getMC().addChild(this.BtnLoading);
         _loc3_ = new HButton(this.BtnLoading);
         this.BtnLoading.visible = false;
         this.CancelBtn = GameKernel.getMovieClipInstance("CancelBtnMc",0,0,false);
         this.CancelBtn.addEventListener(MouseEvent.CLICK,this.CancelBtnClick);
         this._mc.getMC().addChild(this.CancelBtn);
         _loc3_ = new HButton(this.CancelBtn);
         this.CancelBtn.visible = false;
         this.DeleteBtn = GameKernel.getMovieClipInstance("DeleteBtnMc",0,0,false);
         this.DeleteBtn.addEventListener(MouseEvent.CLICK,this.DeleteBtnClick);
         this._mc.getMC().addChild(this.DeleteBtn);
         _loc3_ = new HButton(this.DeleteBtn);
         this.DeleteBtn.visible = false;
      }
      
      private function McSaveMouseOver(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         var _loc3_:Point = _loc2_.localToGlobal(new Point(20,10));
         CustomTip.GetInstance().Show(StringManager.getInstance().getMessageString("FormationBtn1"),_loc3_);
      }
      
      private function McSaveMouseOut(param1:MouseEvent) : void
      {
         CustomTip.GetInstance().Hide();
      }
      
      private function McReadMouseOver(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         var _loc3_:Point = _loc2_.localToGlobal(new Point(20,10));
         CustomTip.GetInstance().Show(StringManager.getInstance().getMessageString("FormationBtn2"),_loc3_);
      }
      
      private function McReadMouseOut(param1:MouseEvent) : void
      {
         CustomTip.GetInstance().Hide();
      }
      
      private function IniComboBox() : void
      {
         var _loc2_:XButton = null;
         var _loc1_:MovieClip = this._mc.getMC().mc_combox0 as MovieClip;
         this.mc_combox0 = _loc1_;
         this.mc_combox0.buttonMode = true;
         TextField(this._mc.getMC().mc_combox0.tf_txt).mouseEnabled = false;
         _loc1_.stop();
         _loc1_.addEventListener(MouseEvent.CLICK,this.mc_combox0Click);
         _loc1_ = this._mc.getMC().mc_output0 as MovieClip;
         _loc1_.visible = false;
         _loc2_ = new XButton(_loc1_.btn_0);
         _loc2_.Data = 0;
         _loc2_.OnClick = this.ComboBoxRangeClick;
         TextField(_loc1_.btn_0.tf_txt).text = StringManager.getInstance().getMessageString("FormationText6");
         _loc2_ = new XButton(_loc1_.btn_1);
         _loc2_.Data = 1;
         _loc2_.OnClick = this.ComboBoxRangeClick;
         TextField(_loc1_.btn_1.tf_txt).text = StringManager.getInstance().getMessageString("FormationText7");
         _loc1_.visible = false;
         _loc1_ = this._mc.getMC().mc_combox1 as MovieClip;
         this.mc_combox1 = _loc1_;
         this.mc_combox1.buttonMode = true;
         TextField(this._mc.getMC().mc_combox1.tf_txt).mouseEnabled = false;
         _loc1_.stop();
         _loc1_.addEventListener(MouseEvent.CLICK,this.mc_combox1Click);
         _loc1_ = this._mc.getMC().mc_output1 as MovieClip;
         _loc1_.visible = false;
         _loc2_ = new XButton(_loc1_.btn_0);
         _loc2_.Data = 0;
         _loc2_.OnClick = this.ComboBoxLockClick;
         TextField(_loc1_.btn_0.tf_txt).text = StringManager.getInstance().getMessageString("FormationText8");
         _loc2_ = new XButton(_loc1_.btn_1);
         _loc2_.Data = 6;
         _loc2_.OnClick = this.ComboBoxLockClick;
         TextField(_loc1_.btn_1.tf_txt).text = StringManager.getInstance().getMessageString("FormationText14");
         _loc2_ = new XButton(_loc1_.btn_2);
         _loc2_.Data = 2;
         _loc2_.OnClick = this.ComboBoxLockClick;
         TextField(_loc1_.btn_2.tf_txt).text = StringManager.getInstance().getMessageString("FormationText10");
         _loc2_ = new XButton(_loc1_.btn_3);
         _loc2_.Data = 3;
         _loc2_.OnClick = this.ComboBoxLockClick;
         TextField(_loc1_.btn_3.tf_txt).text = StringManager.getInstance().getMessageString("FormationText11");
         _loc2_ = new XButton(_loc1_.btn_4);
         _loc2_.Data = 4;
         _loc2_.OnClick = this.ComboBoxLockClick;
         TextField(_loc1_.btn_4.tf_txt).text = StringManager.getInstance().getMessageString("FormationText12");
         _loc2_ = new XButton(_loc1_.btn_5);
         _loc2_.Data = 5;
         _loc2_.OnClick = this.ComboBoxLockClick;
         TextField(_loc1_.btn_5.tf_txt).text = StringManager.getInstance().getMessageString("FormationText13");
         _loc2_ = new XButton(_loc1_.btn_6);
         _loc2_.Data = 1;
         _loc2_.OnClick = this.ComboBoxLockClick;
         TextField(_loc1_.btn_6.tf_txt).text = StringManager.getInstance().getMessageString("FormationText9");
      }
      
      private function mc_combox0Click(param1:MouseEvent) : void
      {
         if((this._mc.getMC().mc_output0 as MovieClip).visible)
         {
            (this._mc.getMC().mc_output0 as MovieClip).visible = false;
            this.mc_combox0.gotoAndStop("up");
         }
         else
         {
            (this._mc.getMC().mc_output0 as MovieClip).visible = true;
            this.mc_combox0.gotoAndStop("selected");
         }
         (this._mc.getMC().mc_output1 as MovieClip).visible = false;
         this.mc_combox1.gotoAndStop("up");
      }
      
      private function ComboBoxRangeClick(param1:MouseEvent, param2:XButton) : void
      {
         (this._mc.getMC().mc_output0 as MovieClip).visible = false;
         this.mc_combox0.gotoAndStop("up");
         TextField(this._mc.getMC().mc_combox0.tf_txt).text = TextField(param2.m_movie.tf_txt).text;
         this._TargetInterval = param2.Data;
      }
      
      private function mc_combox1Click(param1:MouseEvent) : void
      {
         if((this._mc.getMC().mc_output1 as MovieClip).visible)
         {
            (this._mc.getMC().mc_output1 as MovieClip).visible = false;
            this.mc_combox1.gotoAndStop("up");
         }
         else
         {
            (this._mc.getMC().mc_output1 as MovieClip).visible = true;
            this.mc_combox1.gotoAndStop("selected");
         }
         (this._mc.getMC().mc_output0 as MovieClip).visible = false;
         this.mc_combox0.gotoAndStop("up");
      }
      
      private function ComboBoxLockClick(param1:MouseEvent, param2:XButton) : void
      {
         (this._mc.getMC().mc_output1 as MovieClip).visible = false;
         this.mc_combox1.gotoAndStop("up");
         TextField(this._mc.getMC().mc_combox1.tf_txt).text = TextField(param2.m_movie.tf_txt).text;
         this._Target = param2.Data;
      }
      
      private function IniArrangeShip() : void
      {
         var _loc1_:MovieClip = null;
         this.ArrangeShipList = this._mc.getMC().getChildByName("mc_fleetlist") as MovieClip;
         _loc1_ = this.ArrangeShipList.getChildByName("btn_left") as MovieClip;
         _loc1_.addEventListener(MouseEvent.CLICK,this.ArrangeShipPrePage);
         this.LeftBtn = new HButton(_loc1_);
         this.LeftBtn.setBtnDisabled(true);
         _loc1_ = this.ArrangeShipList.getChildByName("btn_right") as MovieClip;
         _loc1_.addEventListener(MouseEvent.CLICK,this.ArrangeShipNextPage);
         this.RightBtn = new HButton(_loc1_);
         this.RightBtn.setBtnDisabled(true);
         var _loc2_:int = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = this.ArrangeShipList.getChildByName("mc_list" + _loc2_) as MovieClip;
            _loc1_.stop();
            _loc1_.mouseChildren = false;
            _loc1_.addEventListener(MouseEvent.MOUSE_DOWN,this.ShipMouseDown);
            _loc1_.addEventListener(MouseEvent.MOUSE_OVER,this.ShipMouseOver);
            _loc1_.addEventListener(MouseEvent.MOUSE_OUT,this.ArrangeShipMouseOut);
            this.ArrangeShipImg.push(_loc1_.getChildByName("mc_base"));
            this.ArrangeShipNum.push(_loc1_.getChildByName("tf_airshipnum"));
            _loc2_++;
         }
      }
      
      private function IniFleetShip() : void
      {
         var _loc1_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:TextField = null;
         var _loc2_:MovieClip = this._mc.getMC().getChildByName("mc_fleetgrid") as MovieClip;
         var _loc3_:int = 0;
         while(_loc3_ < 9)
         {
            _loc1_ = _loc2_.getChildByName("mc_base" + _loc3_) as MovieClip;
            this.TeamShipDisplay.push(_loc1_);
            _loc1_.addEventListener(MouseEvent.MOUSE_DOWN,this.TeamShipMouseDown);
            _loc1_.addEventListener(MouseEvent.MOUSE_OVER,this.TeamShipMouseOver);
            _loc1_.addEventListener(MouseEvent.MOUSE_OUT,this.ShipMouseOut);
            _loc4_ = _loc1_.getChildByName("mc_base") as MovieClip;
            _loc4_.mouseEnabled = false;
            _loc4_.mouseChildren = false;
            this.TeamShipImg.push(_loc4_);
            _loc5_ = _loc1_.getChildByName("tf_num") as TextField;
            _loc5_.text = "";
            _loc5_.mouseEnabled = false;
            this.TeamShipNum.push(_loc5_);
            _loc1_.mouseChildren = false;
            _loc3_++;
         }
      }
      
      private function CloseClick(param1:MouseEvent) : void
      {
         if(this.IsUpdate)
         {
            this.Clear();
            this.IsUpdate = false;
         }
         GameKernel.popUpDisplayManager.Hide(this);
         this.UpdateFleetId = 0;
         CommanderInfoTip.GetInstance().Hide();
         this._AtHome = true;
         this.m_time.stop();
      }
      
      private function RequestCommanderInfo() : void
      {
         var _loc1_:MSG_REQUEST_COMMANDERINFOARRANGE = new MSG_REQUEST_COMMANDERINFOARRANGE();
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc1_);
      }
      
      private function DeleteTeamShip() : void
      {
         if(this.SelectedCellId >= 0)
         {
            this.DeleteTeamShip2(this._FleetInfo.Num[this.SelectedCellId]);
         }
      }
      
      private function DeleteTeamShip2(param1:int) : void
      {
         var _loc2_:TextField = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         if(this.SelectedCellId >= 0)
         {
            if(!this.RemoveShip(this.SelectedCellId,param1))
            {
               return;
            }
            this._FleetInfo.Num[this.SelectedCellId] -= param1;
            _loc2_ = this.TeamShipNum[this.SelectedCellId] as TextField;
            _loc3_ = int(this._FleetInfo.ShipModelId[this.SelectedCellId]);
            if(this._FleetInfo.Num[this.SelectedCellId] <= 0)
            {
               _loc5_ = this.TeamShipImg[this.SelectedCellId] as MovieClip;
               if(_loc5_.numChildren > 0)
               {
                  _loc5_.removeChildAt(0);
               }
               _loc2_.text = "";
               this._FleetInfo.ShipModelId[this.SelectedCellId] = -1;
               this._FleetInfo.Num[this.SelectedCellId] = 0;
            }
            else
            {
               _loc2_.text = this._FleetInfo.Num[this.SelectedCellId].toString();
            }
            _loc4_ = 0;
            if(this.MsgArrangShipTeam.ContainsKey(_loc3_))
            {
               _loc4_ = this.MsgArrangShipTeam.Get(_loc3_);
            }
            else
            {
               this.MsgArrangShipTeamArr.push(_loc3_);
            }
            _loc4_ += param1;
            this.MsgArrangShipTeam.Put(_loc3_,_loc4_);
         }
      }
      
      private function DeleteTeamShip3(param1:int) : void
      {
         this.DeleteTeamShip2(param1);
         this.ShowArrangeShip();
      }
      
      private function TeamShipMouseDown(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Point = null;
         if(this.CreateTeamBtn.visible == false)
         {
            return;
         }
         var _loc2_:MovieClip = param1.target as MovieClip;
         this.SelectedCellId = int(_loc2_.name.substring(7));
         if(this.SelectedCellId >= 0)
         {
            if(this._FleetInfo.Num[this.SelectedCellId] <= 0)
            {
               return;
            }
            _loc3_ = int(this._FleetInfo.ShipModelId[this.SelectedCellId]);
            this.SelectedModelInfo = ShipmodelRouter.instance.ShipModeList.Get(_loc3_);
            this.SelectedBodyInfo = CShipmodelReader.getInstance().getShipBodyInfo(this.SelectedModelInfo.m_BodyId);
            _loc4_ = _loc2_.localToGlobal(new Point(25,25));
            _loc4_ = this._mc.getMC().globalToLocal(_loc4_);
            this.SelectedImg = this.GetShipImage(this.SelectedBodyInfo.SmallIcon,_loc4_.x,_loc4_.y);
            this._mc.getMC().addChild(this.SelectedImg);
            this.SelectedImg.addEventListener(MouseEvent.MOUSE_UP,this.SelectedTeamShipMouseUp);
            this.SelectedImg.startDrag(true);
            this.startDrag = true;
         }
      }
      
      public function GetShipImage(param1:String, param2:int = 0, param3:int = 0) : MovieClip
      {
         var _loc4_:MovieClip = GameKernel.getMovieClipInstance("moban",param2,param3);
         var _loc5_:Bitmap = new Bitmap(GameKernel.getTextureInstance(param1));
         _loc5_.x = -22;
         _loc5_.y = -15;
         _loc5_.smoothing = true;
         _loc4_.addChild(_loc5_);
         _loc4_.width = 50;
         _loc4_.height = 50;
         return _loc4_;
      }
      
      private function SelectedTeamShipMouseUp(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         this.SelectedImg.stopDrag();
         this.startDrag = false;
         this.ReplaceCellId = this.GetSelectedIndex(param1);
         this._mc.getMC().removeChild(this.SelectedImg);
         if(this.ReplaceCellId == this.SelectedCellId)
         {
            return;
         }
         var _loc2_:int = int(this._FleetInfo.Num[this.SelectedCellId]);
         if(this.ReplaceCellId == -1)
         {
            if(!this._AtHome)
            {
               return;
            }
            this.ShowEnterShipNumForm(this.DeleteTeamShip3,_loc2_);
         }
         else
         {
            _loc3_ = int(this._FleetInfo.ShipModelId[this.SelectedCellId]);
            if(this._FleetInfo.Num[this.ReplaceCellId] <= 0 || this._FleetInfo.ShipModelId[this.ReplaceCellId] == _loc3_)
            {
               if(this.SelectedBodyInfo.KindId == 5)
               {
                  this.ReplaceSelectedShip();
               }
               else
               {
                  _loc4_ = int(this._FleetInfo.Num[this.ReplaceCellId]);
                  _loc2_ = Math.min(MsgTypes.MAX_MATRIXSHIP - _loc4_,_loc2_);
                  if(_loc2_ > 0)
                  {
                     this.ShowEnterShipNumForm(this.RemoveSelectedShip,_loc2_);
                  }
               }
            }
            else
            {
               this.ReplaceSelectedShip();
            }
         }
      }
      
      private function RemoveSelectedShip(param1:int) : void
      {
         var _loc3_:TextField = null;
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         if(this.ReplaceCellId < 0)
         {
            return;
         }
         if(this._FleetInfo.Num[this.ReplaceCellId] <= 0)
         {
            this._FleetInfo.ShipModelId[this.ReplaceCellId] = this._FleetInfo.ShipModelId[this.SelectedCellId];
            this._FleetInfo.Num[this.ReplaceCellId] = 0;
         }
         this._FleetInfo.Num[this.ReplaceCellId] += param1;
         _loc3_ = this.TeamShipNum[this.ReplaceCellId] as TextField;
         _loc3_.text = this._FleetInfo.Num[this.ReplaceCellId];
         var _loc2_:MovieClip = this.TeamShipImg[this.ReplaceCellId];
         if(_loc2_.numChildren == 0)
         {
            this.SelectedModelInfo = ShipmodelRouter.instance.ShipModeList.Get(this._FleetInfo.ShipModelId[this.ReplaceCellId]);
            this.SelectedBodyInfo = CShipmodelReader.getInstance().getShipBodyInfo(this.SelectedModelInfo.m_BodyId);
            _loc4_ = this.GetShipImage(this.SelectedBodyInfo.SmallIcon,20,20);
            _loc2_.addChild(_loc4_);
         }
         this._FleetInfo.Num[this.SelectedCellId] -= param1;
         if(this._FleetInfo.Num[this.SelectedCellId] <= 0)
         {
            this._FleetInfo.Num[this.SelectedCellId] = 0;
            _loc5_ = this.TeamShipImg[this.SelectedCellId] as MovieClip;
            if(_loc5_.numChildren > 0)
            {
               _loc5_.removeChildAt(0);
            }
            _loc3_ = this.TeamShipNum[this.SelectedCellId] as TextField;
            _loc3_.text = "";
            this._FleetInfo.ShipModelId[this.SelectedCellId] = -1;
         }
         else
         {
            _loc3_ = this.TeamShipNum[this.SelectedCellId] as TextField;
            _loc3_.text = this._FleetInfo.Num[this.SelectedCellId].toString();
         }
      }
      
      private function ReplaceSelectedShip() : void
      {
         var _loc4_:MovieClip = null;
         var _loc6_:MovieClip = null;
         var _loc7_:TextField = null;
         var _loc1_:int = int(this._FleetInfo.ShipModelId[this.ReplaceCellId]);
         var _loc2_:int = int(this._FleetInfo.Num[this.ReplaceCellId]);
         this._FleetInfo.ShipModelId[this.ReplaceCellId] = this._FleetInfo.ShipModelId[this.SelectedCellId];
         this._FleetInfo.Num[this.ReplaceCellId] = this._FleetInfo.Num[this.SelectedCellId];
         this._FleetInfo.ShipModelId[this.SelectedCellId] = _loc1_;
         this._FleetInfo.Num[this.SelectedCellId] = _loc2_;
         var _loc3_:MovieClip = this.TeamShipImg[this.ReplaceCellId];
         if(_loc3_.numChildren > 0)
         {
            _loc4_ = _loc3_.getChildAt(0) as MovieClip;
            _loc3_.removeChildAt(0);
         }
         var _loc5_:MovieClip = this.TeamShipImg[this.SelectedCellId];
         if(_loc5_.numChildren > 0)
         {
            _loc6_ = _loc5_.getChildAt(0) as MovieClip;
            _loc5_.removeChildAt(0);
         }
         if(_loc6_)
         {
            _loc3_.addChild(_loc6_);
         }
         if(_loc4_)
         {
            _loc5_.addChild(_loc4_);
         }
         _loc7_ = this.TeamShipNum[this.SelectedCellId] as TextField;
         if(this._FleetInfo.Num[this.SelectedCellId] > 0)
         {
            _loc7_.text = this._FleetInfo.Num[this.SelectedCellId];
         }
         else
         {
            _loc7_.text = "";
         }
         _loc7_ = this.TeamShipNum[this.ReplaceCellId] as TextField;
         _loc7_.text = this._FleetInfo.Num[this.ReplaceCellId];
      }
      
      private function GetArrangShipIndex(param1:MovieClip) : int
      {
         this.SelectedShipIndex = int(param1.name.substring(7));
         var _loc2_:int = this.ArrangeShipPageIndex * 6 + this.SelectedShipIndex;
         if(_loc2_ >= this.MsgArrangShipTeam.Keys().length)
         {
            return -1;
         }
         return _loc2_;
      }
      
      private function ShipMouseDown(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:Point = null;
         if(this.CreateTeamBtn.visible == false)
         {
            return;
         }
         if(param1.target is MovieClip)
         {
            _loc2_ = param1.target as MovieClip;
            this.SelectedIndex = this.GetArrangShipIndex(_loc2_);
            if(this.SelectedIndex < 0)
            {
               return;
            }
            this.SelectedModelId = this.MsgArrangShipTeamArr[this.SelectedIndex];
            if(this.MsgArrangShipTeam.Get(this.SelectedModelId) <= 0)
            {
               return;
            }
            this.SelectedModelInfo = ShipmodelRouter.instance.ShipModeList.Get(this.SelectedModelId);
            this.SelectedBodyInfo = CShipmodelReader.getInstance().getShipBodyInfo(this.SelectedModelInfo.m_BodyId);
            _loc3_ = _loc2_.localToGlobal(new Point(25,25));
            _loc3_ = this._mc.getMC().globalToLocal(_loc3_);
            this.SelectedImg = this.GetShipImage(this.SelectedBodyInfo.SmallIcon,_loc3_.x,_loc3_.y);
            this._mc.getMC().addChild(this.SelectedImg);
            this.SelectedImg.addEventListener(MouseEvent.MOUSE_UP,this.SelectedImgMouseUp);
            this.SelectedImg.startDrag(true);
            this.startDrag = true;
         }
      }
      
      private function TeamShipMouseOver(param1:MouseEvent) : void
      {
         var _loc4_:int = 0;
         var _loc5_:Point = null;
         if(this.startDrag)
         {
            return;
         }
         var _loc2_:MovieClip = param1.target as MovieClip;
         var _loc3_:int = int(_loc2_.name.substring(7));
         if(_loc3_ >= 0)
         {
            if(this._FleetInfo.Num[_loc3_] <= 0)
            {
               return;
            }
            _loc4_ = int(this._FleetInfo.ShipModelId[_loc3_]);
            _loc5_ = _loc2_.localToGlobal(new Point(25,45));
            ShipModelInfoTip.GetInstance().Show(_loc4_,_loc5_,false);
         }
      }
      
      private function ShipMouseOver(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Point = null;
         var _loc6_:ShipmodelInfo = null;
         if(this.startDrag)
         {
            return;
         }
         if(param1.target is MovieClip)
         {
            _loc2_ = param1.target as MovieClip;
            if(this.SelectedArrangeShipMc != null)
            {
               this.SelectedArrangeShipMc.gotoAndStop("up");
            }
            this.SelectedArrangeShipMc = _loc2_;
            this.SelectedArrangeShipMc.gotoAndStop("selected");
            _loc3_ = this.GetArrangShipIndex(_loc2_);
            if(_loc3_ < 0)
            {
               return;
            }
            _loc4_ = int(this.MsgArrangShipTeamArr[_loc3_]);
            _loc5_ = _loc2_.localToGlobal(new Point(0,-36));
            _loc6_ = ShipmodelRouter.instance.ShipModeList.Get(_loc4_);
            CustomTip.GetInstance().Show(_loc6_.m_ShipName,_loc5_);
         }
      }
      
      private function ArrangeShipMouseOut(param1:MouseEvent) : void
      {
         CustomTip.GetInstance().Hide();
      }
      
      private function ShipMouseOut(param1:MouseEvent) : void
      {
         ShipModelInfoTip.GetInstance().Hide();
      }
      
      private function SelectedImgMouseUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         this.SelectedImg.stopDrag();
         this.startDrag = false;
         this.SelectedCellId = this.GetSelectedIndex(param1);
         this._mc.getMC().removeChild(this.SelectedImg);
         if(this.SelectedCellId >= 0)
         {
            if(this.SelectedBodyInfo.KindId == 5 && this.HasFlagShip())
            {
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss59"),0);
               return;
            }
            _loc2_ = Math.min(MsgTypes.MAX_MATRIXSHIP,this.MsgArrangShipTeam.Get(this.SelectedModelId));
            if(this._FleetInfo.ShipModelId[this.SelectedCellId] == this.SelectedModelId)
            {
               _loc2_ = Math.min(MsgTypes.MAX_MATRIXSHIP - this._FleetInfo.Num[this.SelectedCellId],_loc2_);
            }
            if(_loc2_ > 0)
            {
               this.ShowEnterShipNumForm(this.AddSelectedShip,_loc2_);
            }
         }
      }
      
      private function HasFlagShip() : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:ShipmodelInfo = null;
         var _loc4_:ShipbodyInfo = null;
         var _loc1_:int = 0;
         while(_loc1_ < 9)
         {
            if(this._FleetInfo.Num[_loc1_] > 0)
            {
               _loc2_ = int(this._FleetInfo.ShipModelId[_loc1_]);
               _loc3_ = ShipmodelRouter.instance.ShipModeList.Get(_loc2_);
               if(_loc3_ != null)
               {
                  _loc4_ = CShipmodelReader.getInstance().getShipBodyInfo(_loc3_.m_BodyId);
                  if(_loc4_.KindId == 5 && _loc1_ != this.SelectedCellId)
                  {
                     return true;
                  }
               }
            }
            _loc1_++;
         }
         return false;
      }
      
      private function GetSelectedIndex(param1:MouseEvent) : int
      {
         var _loc6_:MovieClip = null;
         var _loc2_:MovieClip = param1.target as MovieClip;
         var _loc3_:Point = _loc2_.localToGlobal(new Point(param1.localX,param1.localX));
         var _loc4_:MovieClip = this._mc.getMC().getChildByName("mc_fleetgrid") as MovieClip;
         _loc3_ = _loc4_.globalToLocal(_loc3_);
         var _loc5_:int = 0;
         for each(_loc6_ in this.TeamShipDisplay)
         {
            if(_loc3_.x >= _loc6_.x && _loc3_.x <= _loc6_.x + 45 && _loc3_.y >= _loc6_.y && _loc3_.y <= _loc6_.y + 45)
            {
               return _loc5_;
            }
            _loc5_++;
         }
         return -1;
      }
      
      private function ShowEnterShipNumForm(param1:Function, param2:int) : void
      {
         if(param2 > MsgTypes.MAX_MATRIXSHIP)
         {
            param2 = MsgTypes.MAX_MATRIXSHIP;
         }
         FleetNumUI.getInstance().Show(this._mc.getMC(),param2,param1,StringManager.getInstance().getMessageString("FormationText3"));
      }
      
      public function AddSelectedShip(param1:int) : void
      {
         var _loc2_:int = 0;
         if(this.SelectedCellId < 0)
         {
            return;
         }
         if(this._FleetInfo.Num[this.SelectedCellId] > 0 && this._FleetInfo.ShipModelId[this.SelectedCellId] != this.MsgArrangShipTeamArr[this.SelectedIndex])
         {
            this.DeleteTeamShip();
            this.ShowArrangeShip();
         }
         if(this._FleetInfo.Num[this.SelectedCellId] <= 0)
         {
            this._FleetInfo.Num[this.SelectedCellId] = param1;
         }
         else
         {
            this._FleetInfo.Num[this.SelectedCellId] += param1;
         }
         this._FleetInfo.ShipModelId[this.SelectedCellId] = this.MsgArrangShipTeamArr[this.SelectedIndex];
         var _loc3_:int = this.MsgArrangShipTeam.Get(this._FleetInfo.ShipModelId[this.SelectedCellId]);
         _loc3_ -= param1;
         var _loc4_:TextField = this.ArrangeShipNum[this.SelectedShipIndex] as TextField;
         if(_loc3_ > 0)
         {
            if(!this.MsgArrangShipTeam.ContainsKey(this._FleetInfo.ShipModelId[this.SelectedCellId]))
            {
               this.MsgArrangShipTeamArr.push(this._FleetInfo.ShipModelId[this.SelectedCellId]);
            }
            this.MsgArrangShipTeam.Put(this._FleetInfo.ShipModelId[this.SelectedCellId],_loc3_);
            _loc4_.text = this.MsgArrangShipTeam.Get(this._FleetInfo.ShipModelId[this.SelectedCellId]);
         }
         else
         {
            this.MsgArrangShipTeam.Remove(this._FleetInfo.ShipModelId[this.SelectedCellId]);
            this.DeleteMsgArrangShipTeamArr(this._FleetInfo.ShipModelId[this.SelectedCellId]);
            this.ShowArrangeShip();
         }
         var _loc5_:TextField = this.TeamShipNum[this.SelectedCellId];
         _loc5_.text = this._FleetInfo.Num[this.SelectedCellId].toString();
         var _loc6_:MovieClip = this.TeamShipImg[this.SelectedCellId];
         this.SelectedImg.x = 25;
         this.SelectedImg.y = 25;
         if(_loc6_.numChildren > 0)
         {
            _loc6_.removeChildAt(0);
         }
         _loc6_.addChild(this.SelectedImg);
         this.SelectedImg.removeEventListener(MouseEvent.MOUSE_UP,this.SelectedImgMouseUp);
         this.SelectedImg.mouseEnabled = false;
         this.AddShip(this.SelectedCellId,param1);
      }
      
      private function ArrangeShipPrePage(param1:Event) : void
      {
         if(this.ArrangeShipPageIndex > 0)
         {
            --this.ArrangeShipPageIndex;
            this.ShowArrangeShip();
         }
      }
      
      private function ArrangeShipNextPage(param1:Event) : void
      {
         if((this.ArrangeShipPageIndex + 1) * 6 < this.MsgArrangShipTeam.Keys().length)
         {
            ++this.ArrangeShipPageIndex;
            this.ShowArrangeShip();
         }
      }
      
      private function RequestArrangeShipTeam() : void
      {
         var _loc1_:MSG_REQUEST_ARRANGESHIPTEAM = new MSG_REQUEST_ARRANGESHIPTEAM();
         _loc1_.Type = 0;
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc1_);
      }
      
      public function RespArrangeShipTeam(param1:MSG_RESP_ARRANGESHIPTEAM) : void
      {
         var _loc3_:net.msg.fleetMsg.MSG_SHIPTEAM_NUM = null;
         var _loc2_:int = 0;
         while(_loc2_ < param1.DataLen)
         {
            _loc3_ = param1.TeamBody[_loc2_];
            this.MsgArrangShipTeam.Put(_loc3_.ShipModelId,_loc3_.Num);
            this.MsgArrangShipTeamArr.push(_loc3_.ShipModelId);
            _loc2_++;
         }
         this.ArrangeShipPageIndex = 0;
         this.ShowArrangeShip();
      }
      
      private function ShowArrangeShip() : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:TextField = null;
         var _loc6_:int = 0;
         var _loc7_:ShipmodelInfo = null;
         var _loc8_:ShipbodyInfo = null;
         var _loc9_:MovieClip = null;
         var _loc1_:int = this.ArrangeShipPageIndex * 6;
         var _loc2_:int = 0;
         for each(_loc3_ in this.ArrangeShipImg)
         {
            _loc4_ = this.ArrangeShipList.getChildByName("mc_list" + _loc2_) as MovieClip;
            _loc5_ = this.ArrangeShipNum[_loc2_] as TextField;
            if(_loc1_ >= this.MsgArrangShipTeam.Keys().length)
            {
               (++_loc4_).visible = true;
               if(_loc3_.numChildren > 0)
               {
                  _loc3_.removeChildAt(0);
               }
               _loc3_.mouseEnabled = false;
               _loc3_.mouseChildren = false;
               _loc5_.text = "";
            }
            else
            {
               _loc4_.visible = true;
               _loc3_.mouseEnabled = true;
               _loc3_.mouseChildren = true;
               if(_loc3_.numChildren > 0)
               {
                  _loc3_.removeChildAt(0);
               }
               _loc2_++;
               _loc6_ = int(this.MsgArrangShipTeamArr[_loc1_]);
               _loc7_ = ShipmodelRouter.instance.ShipModeList.Get(_loc6_);
               _loc8_ = CShipmodelReader.getInstance().getShipBodyInfo(_loc7_.m_BodyId);
               _loc9_ = this.GetShipImage(_loc8_.SmallIcon,20,20);
               _loc3_.addChild(_loc9_);
               _loc5_.text = this.MsgArrangShipTeam.Get(_loc6_).toString();
               _loc1_++;
            }
         }
         if(this.ArrangeShipPageIndex == 0)
         {
            this.LeftBtn.setBtnDisabled(true);
         }
         else
         {
            this.LeftBtn.setBtnDisabled(false);
         }
         if((this.ArrangeShipPageIndex + 1) * 6 < this.MsgArrangShipTeam.Keys().length)
         {
            this.RightBtn.setBtnDisabled(false);
         }
         else
         {
            this.RightBtn.setBtnDisabled(true);
         }
      }
      
      private function AddShip(param1:int, param2:int = -1) : void
      {
         var _loc3_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:ShippartInfo = null;
         if(param2 > 0)
         {
            _loc3_ = param2;
         }
         else
         {
            _loc3_ = int(this._FleetInfo.Num[param1]);
         }
         if(_loc3_ <= 0)
         {
            return;
         }
         var _loc4_:int = int(this._FleetInfo.ShipModelId[param1]);
         this.SelectedModelInfo = ShipmodelRouter.instance.ShipModeList.Get(_loc4_);
         this.SelectedBodyInfo = CShipmodelReader.getInstance().getShipBodyInfo(this.SelectedModelInfo.m_BodyId);
         var _loc5_:int = this.SelectedBodyInfo.Locomotivity;
         this.Storage += this.SelectedBodyInfo.Storage * _loc3_;
         this.Endure += (this.SelectedBodyInfo.Endure + this.SelectedBodyInfo.Shield) * _loc3_;
         this.ShipCount += _loc3_;
         var _loc6_:int = 0;
         while(_loc6_ < this.SelectedModelInfo.m_PartNum)
         {
            _loc7_ = int(this.SelectedModelInfo.m_PartId[_loc6_]);
            _loc8_ = CShipmodelReader.getInstance().getShipPartInfo(_loc7_);
            _loc5_ += _loc8_.Locomotivity;
            this.Storage += _loc8_.Storage * _loc3_;
            this.Endure += (_loc8_.Endure + _loc8_.Shield) * _loc3_;
            this.MinAssault += _loc8_.MinAssault * _loc3_;
            this.MaxAssault += _loc8_.MaxAssault * _loc3_;
            this.Supply += _loc8_.Supply * _loc3_;
            _loc6_++;
         }
         this._FleetInfo.Locomotivity[param1] = _loc5_;
         if(_loc5_ > 0 && (this.Locomotivity == 0 || this.Locomotivity > _loc5_))
         {
            this.Locomotivity = _loc5_;
         }
         this.SkeepCount = Number(this.Storage) / this.Supply;
         this.ShowTeamValue();
      }
      
      private function RemoveShip(param1:int, param2:int) : Boolean
      {
         var _loc6_:int = 0;
         var _loc7_:ShippartInfo = null;
         var _loc8_:int = 0;
         var _loc3_:int = int(this._FleetInfo.Num[param1]);
         if(_loc3_ <= 0 || param2 > _loc3_)
         {
            return false;
         }
         var _loc4_:int = int(this._FleetInfo.ShipModelId[param1]);
         this.SelectedModelInfo = ShipmodelRouter.instance.ShipModeList.Get(_loc4_);
         this.SelectedBodyInfo = CShipmodelReader.getInstance().getShipBodyInfo(this.SelectedModelInfo.m_BodyId);
         this.Storage -= this.SelectedBodyInfo.Storage * param2;
         this.Endure -= (this.SelectedBodyInfo.Endure + this.SelectedBodyInfo.Shield) * param2;
         this.ShipCount -= param2;
         var _loc5_:int = 0;
         while(_loc5_ < this.SelectedModelInfo.m_PartNum)
         {
            _loc6_ = int(this.SelectedModelInfo.m_PartId[_loc5_]);
            _loc7_ = CShipmodelReader.getInstance().getShipPartInfo(_loc6_);
            this.Storage -= _loc7_.Storage * param2;
            this.Endure -= (_loc7_.Endure + _loc7_.Shield) * param2;
            this.MinAssault -= _loc7_.MinAssault * param2;
            this.MaxAssault -= _loc7_.MaxAssault * param2;
            this.Supply -= _loc7_.Supply * param2;
            _loc5_++;
         }
         this.SkeepCount = this.Storage / this.Supply;
         if(_loc3_ <= param2 && this.Locomotivity == this._FleetInfo.Locomotivity[param1])
         {
            this.Locomotivity = 0;
            _loc8_ = 0;
            while(_loc8_ < 9)
            {
               if(_loc8_ != param1 && this._FleetInfo.Num[_loc8_] > 0)
               {
                  if(this._FleetInfo.Locomotivity[_loc8_] > 0)
                  {
                     if(this.Locomotivity == 0 || this.Locomotivity > this._FleetInfo.Locomotivity[_loc8_])
                     {
                        this.Locomotivity = this._FleetInfo.Locomotivity[_loc8_];
                     }
                  }
               }
               _loc8_++;
            }
         }
         this.ShowTeamValue();
         return true;
      }
      
      private function ShowTeamValue() : void
      {
         this.tfLocomotivity.text = this.Locomotivity.toString();
         this.tfStorage.text = this.Storage.toString();
         this.tfSkeepCount.text = this.SkeepCount.toString();
         this.tfEndure.text = this.Endure.toString();
         this.tfAssault.text = this.MinAssault.toString();
         this.tfShipCount.text = this.ShipCount.toString();
      }
      
      public function changetime(param1:int) : String
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         _loc2_ = param1 / (60 * 60);
         _loc3_ = _loc2_ + ":";
         _loc2_ = param1 % (60 * 60) / 60;
         _loc3_ = _loc3_ + _loc2_ + ":";
         _loc2_ = param1 % 60;
         return _loc3_ + _loc2_;
      }
      
      private function onTick(param1:TimerEvent) : void
      {
         if(CommanderRouter.instance.NextInviteTime > 0)
         {
            TextField(this._mc.getMC().btn_cdtime.tf_remaintime).text = DataWidget.GetTimeString(CommanderRouter.instance.NextInviteTime);
         }
         else
         {
            this._mc.getMC().btn_cdtime.visible = false;
            this._hireadmiral.gotoAndStop(1);
            this.IsCooling = false;
            this.m_time.stop();
         }
      }
      
      public function startTime() : void
      {
         this._cdtime.m_movie.visible = true;
         this.IsCooling = true;
         this._hireadmiral.gotoAndStop(4);
         this.m_time.start();
         this.RequestCommanderInfo();
      }
      
      private function clickButton(param1:Event) : void
      {
         if(param1.currentTarget.name == "btn_hireadmiral")
         {
            if(ConstructionAction.getInstance().getCommanderCenterNumber() == -1)
            {
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("BuildingText12"),0);
               return;
            }
            if(CommanderRouter.instance.m_commandInfoAry.length < GamePlayer.getInstance().commandernum && GamePlayer.getInstance().PropsPack - ScienceSystem.getinstance().Packarr.length > 0)
            {
               CommanderRouter.instance.m_IsCommanderUISend = false;
               CommanderRouter.instance.onSendMsgCreateCommander(0);
            }
            else if(CommanderRouter.instance.m_commandInfoAry.length >= GamePlayer.getInstance().commandernum)
            {
               this.addBackMC();
               ConstructionOperationWidget.currenCmd = OperationEnum.OPERATION_TYPE_NOINTOCOMMANDER;
               MallBuyModulesPopup.getInstance().Init();
               MallBuyModulesPopup.getInstance().Show();
               MallBuyModulesPopup.getInstance().setparent("FleetEditUI");
            }
            else
            {
               StoragepopupTip.getInstance().Init();
               StoragepopupTip.getInstance().Show();
               if(GamePlayer.getInstance().PropsPack == PackUi.getInstance().maxNum)
               {
                  StoragepopupTip.getInstance().ppd(2);
               }
               else
               {
                  StoragepopupTip.getInstance().ppd(1);
               }
            }
         }
      }
      
      private function overButton(param1:Event) : void
      {
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc2_:TextField = new TextField();
         var _loc3_:MovieClip = param1.currentTarget as MovieClip;
         var _loc4_:Point = _loc3_.localToGlobal(new Point(0,0));
         if(param1.currentTarget.name == "btn_hireadmiral" || param1.currentTarget.name == "btn_cdtime")
         {
            if(this.IsCooling == false)
            {
               this._hireadmiral.gotoAndStop(2);
            }
            _loc2_.htmlText = StringManager.getInstance().getMessageString("CommanderText6");
            Suspension.getInstance();
            Suspension.getInstance().Init(_loc2_.textWidth + 5,60,1);
            Suspension.getInstance().setLocationXY(this._hireadmiral.x,this._hireadmiral.y + this._hireadmiral.height);
            _loc5_ = StringManager.getInstance().getMessageString("CommanderText5") + ConstructionAction.getInstance().getCommanderCenterTime();
            this.m_hireadmiralAry[1] = _loc5_;
            this.m_hireadmiralAry[2] = StringManager.getInstance().getMessageString("CommanderText6");
            this.m_hireadmiralAry[3] = StringManager.getInstance().getMessageString("CommanderText17") + String(CommanderRouter.instance.m_commandInfoAry.length);
            this.m_hireadmiralAry[4] = StringManager.getInstance().getMessageString("CommanderText18") + String(GamePlayer.getInstance().commandernum);
            _loc6_ = 0;
            while(_loc6_ < 3)
            {
               Suspension.getInstance().putRectOnlyOne(_loc6_,this.m_hireadmiralAry[_loc6_],_loc2_.textWidth + 5);
               _loc6_++;
            }
            this._mc.getMC().addChild(Suspension.getInstance());
         }
      }
      
      private function outButton(param1:Event) : void
      {
         if(param1.currentTarget.name == "btn_hireadmiral" || param1.currentTarget.name == "btn_cdtime")
         {
            if(this.IsCooling == false)
            {
               this._hireadmiral.gotoAndStop(1);
            }
            this._mc.getMC().removeChild(Suspension.getInstance());
            Suspension.getInstance().delinstance();
         }
      }
      
      private function BuildFleetOk(param1:Event) : void
      {
         if(GamePlayer.getInstance().galaxyStar.FightFlag == 1)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("FormationText4"),0);
            return;
         }
         this.FleetNameTextField.text = this.FleetNameTextField.text.replace(/^\s*/g,"");
         this.FleetNameTextField.text = this.FleetNameTextField.text.replace(/\s*$/g,"");
         if(this.FleetNameTextField.text == "")
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("FormationText0"),0);
            return;
         }
         if(this.SelectedCommanderId < 0)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("FormationText1"),0);
            return;
         }
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         while(_loc3_ < 9)
         {
            if(this._FleetInfo.Num[_loc3_] > 0)
            {
               _loc2_ = true;
               break;
            }
            _loc3_++;
         }
         if(_loc2_ == false)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("FormationText2"),0);
            return;
         }
         if(this.IsUpdate)
         {
            this.RequestUpdateFleet();
         }
         else
         {
            this.RequestAddFleet();
         }
         if(DisplayObject(this._mc.getMC().mc_shade).visible == false || this.IsUpdate)
         {
            GameKernel.popUpDisplayManager.Hide(this);
         }
         else
         {
            this.ClearShipTeam();
            this.RequestArrangeShipTeam();
            this.RequestCommanderInfo();
         }
         this.UpdateFleetId = 0;
      }
      
      private function RequestAddFleet() : void
      {
         var _loc3_:net.msg.fleetMsg.MSG_SHIPTEAM_NUM = null;
         var _loc1_:MSG_REQUEST_CREATESHIPTEAM = new MSG_REQUEST_CREATESHIPTEAM();
         var _loc2_:int = 0;
         while(_loc2_ < 9)
         {
            _loc3_ = _loc1_.TeamBody[_loc2_];
            if(this._FleetInfo.Num[_loc2_] <= 0)
            {
               _loc3_.Num = 0;
            }
            else
            {
               _loc3_.ShipModelId = this._FleetInfo.ShipModelId[_loc2_];
               _loc3_.Num = this._FleetInfo.Num[_loc2_];
            }
            _loc2_++;
         }
         _loc1_.CommanderId = this.SelectedCommanderId;
         _loc1_.Target = this._Target;
         _loc1_.TargetInterval = this._TargetInterval;
         _loc1_.TeamName = this.FleetNameTextField.text;
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc1_);
      }
      
      private function RequestUpdateFleetForOtherStar() : void
      {
         var _loc4_:net.msg.commanderMsg.MSG_SHIPTEAM_NUM = null;
         var _loc1_:MSG_REQUEST_COMMANDEREDITSHIPTEAM = new MSG_REQUEST_COMMANDEREDITSHIPTEAM();
         _loc1_.Type = 1;
         var _loc2_:int = 0;
         while(_loc2_ < 9)
         {
            _loc4_ = _loc1_.TeamBody[_loc2_];
            if(this._FleetInfo.Num[_loc2_] <= 0)
            {
               _loc4_.ShipModelId = -1;
               _loc4_.Num = 0;
            }
            else
            {
               _loc4_.ShipModelId = this._FleetInfo.ShipModelId[_loc2_];
               _loc4_.Num = this._FleetInfo.Num[_loc2_];
            }
            _loc2_++;
         }
         _loc1_.ShipTeamId = this.UpdateFleetId;
         _loc1_.Target = this._Target;
         _loc1_.TargetInterval = this._TargetInterval;
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc1_);
         var _loc3_:GShipTeam = GalaxyShipManager.instance.getShipDatas(this.UpdateFleetId);
         _loc3_.UserId = -1;
      }
      
      private function RequestUpdateFleet() : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:net.msg.fleetMsg.MSG_SHIPTEAM_NUM = null;
         var _loc6_:GShip = null;
         if(!this._AtHome)
         {
            this.RequestUpdateFleetForOtherStar();
            return;
         }
         var _loc1_:MSG_REQUEST_EDITSHIPTEAM = new MSG_REQUEST_EDITSHIPTEAM();
         _loc1_.EditType = 0;
         var _loc3_:GShipTeam = GalaxyShipManager.instance.getShipDatas(this.UpdateFleetId);
         this.UnloadHe3(_loc3_);
         _loc2_ = 0;
         while(_loc2_ < 9)
         {
            _loc5_ = _loc1_.TeamBody[_loc2_];
            _loc6_ = _loc3_.TeamBody[_loc2_];
            if(_loc6_ == null || _loc6_.Num <= 0)
            {
               if(this._FleetInfo.Num[_loc2_] > 0)
               {
                  _loc1_.EditType = 1;
               }
            }
            else if(_loc6_.ShipModelId != this._FleetInfo.ShipModelId[_loc2_] || _loc6_.Num != this._FleetInfo.Num[_loc2_])
            {
               _loc1_.EditType = 1;
            }
            if(this._FleetInfo.Num[_loc2_] <= 0)
            {
               _loc5_.ShipModelId = -1;
               _loc5_.Num = 0;
            }
            else
            {
               _loc5_.ShipModelId = this._FleetInfo.ShipModelId[_loc2_];
               _loc5_.Num = this._FleetInfo.Num[_loc2_];
            }
            _loc4_ += _loc5_.Num;
            _loc2_++;
         }
         _loc1_.ShipTeamId = this.UpdateFleetId;
         _loc1_.CommanderId = this.SelectedCommanderId;
         _loc1_.Target = this._Target;
         _loc1_.TargetInterval = this._TargetInterval;
         _loc1_.TeamName = this.FleetNameTextField.text;
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc1_);
      }
      
      private function UnloadHe3(param1:GShipTeam) : void
      {
         var _loc2_:MSG_REQUEST_UNLOADSHIPTEAM = null;
         if(param1.Gas > this.Storage)
         {
            _loc2_ = new MSG_REQUEST_UNLOADSHIPTEAM();
            _loc2_.ShipTeamId = param1.ShipTeamId;
            _loc2_.Gas = param1.Gas - this.Storage;
            _loc2_.SeqId = GamePlayer.getInstance().seqID++;
            _loc2_.Guid = GamePlayer.getInstance().Guid;
            NetManager.Instance().sendObject(_loc2_);
            param1.Gas = this.Storage;
         }
      }
      
      public function Show(param1:int) : void
      {
         if(this.UpdateFleetId == param1)
         {
            this.UpdateFleet(this.UpdateFleetId);
         }
      }
      
      public function UpdateFleet(param1:int) : void
      {
         var _loc6_:CommanderInfo = null;
         var _loc7_:MovieClip = null;
         var _loc9_:GShip = null;
         this.UpdateFleetId = param1;
         var _loc2_:GShipTeam = GalaxyShipManager.instance.getShipDatas(param1);
         if(_loc2_.UserId == -1)
         {
            FleetInfoUI_Router.ShowFleetInfoFunction = this.Show;
            return;
         }
         this._AtHome = _loc2_.GalaxyMapId == GamePlayer.getInstance().galaxyMapID && _loc2_.GalaxyId == GamePlayer.getInstance().galaxyID;
         this.Init();
         var _loc3_:int = 0;
         while(_loc3_ < 9)
         {
            _loc9_ = _loc2_.TeamBody[_loc3_];
            if(_loc9_ == null || _loc9_.Num == 0)
            {
               this._FleetInfo.ShipModelId[_loc3_] = -1;
               this._FleetInfo.Num[_loc3_] = 0;
            }
            else
            {
               this._FleetInfo.ShipModelId[_loc3_] = _loc9_.ShipModelId;
               this._FleetInfo.Num[_loc3_] = _loc9_.Num;
            }
            _loc3_++;
         }
         this.UpdateFleetCommanderId = _loc2_.CommanderID;
         var _loc4_:TextField = this._mc.getMC().getChildByName("tf_commandername") as TextField;
         var _loc5_:TextField = this._mc.getMC().getChildByName("tf_lv") as TextField;
         for each(_loc6_ in CommanderRouter.instance.m_commandInfoAry)
         {
            if(_loc6_.commander_commanderId == _loc2_.CommanderID)
            {
               _loc4_.text = _loc6_.commander_name;
               _loc5_.text = (_loc6_.commander_level + 1).toString();
               break;
            }
         }
         _loc7_ = this._mc.getMC().getChildByName("mc_base") as MovieClip;
         if(_loc7_.numChildren > 0)
         {
            _loc7_.removeChildAt(0);
         }
         var _loc8_:Bitmap = CommanderSceneUI.getInstance().CommanderImg(_loc2_.CommanderID);
         _loc8_.width = 50;
         _loc8_.height = 50;
         _loc7_.addChild(_loc8_);
         this.SelectedCommanderId = _loc2_.CommanderID;
         this.FleetNameTextField.text = _loc2_.TeamName;
         this._Target = _loc2_.AttackObjType;
         this._TargetInterval = _loc2_.AttackObjInterval;
         TextField(this._mc.getMC().mc_combox0.tf_txt).text = StringManager.getInstance().getMessageString("FormationText" + (6 + this._TargetInterval));
         TextField(this._mc.getMC().mc_combox1.tf_txt).text = StringManager.getInstance().getMessageString("FormationText" + (8 + this._Target));
         this.ShowFleetInfo();
         this.IsUpdate = true;
         GameKernel.popUpDisplayManager.Show(instance);
      }
      
      public function ShowFleetInfo() : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:TextField = null;
         var _loc6_:MovieClip = null;
         var _loc7_:TextField = null;
         var _loc1_:int = 0;
         while(_loc1_ < 9)
         {
            if(this._FleetInfo.Num[_loc1_] > 0)
            {
               _loc2_ = int(this._FleetInfo.ShipModelId[_loc1_]);
               this.SelectedModelInfo = ShipmodelRouter.instance.ShipModeList.Get(_loc2_);
               if(this.SelectedModelInfo != null)
               {
                  this.SelectedBodyInfo = CShipmodelReader.getInstance().getShipBodyInfo(this.SelectedModelInfo.m_BodyId);
                  _loc3_ = this.GetShipImage(this.SelectedBodyInfo.SmallIcon,25,25);
                  _loc4_ = this.TeamShipImg[_loc1_];
                  _loc4_.addChild(_loc3_);
                  _loc5_ = this.TeamShipNum[_loc1_] as TextField;
                  _loc5_.text = this._FleetInfo.Num[_loc1_];
                  this.AddShip(_loc1_);
               }
            }
            else
            {
               _loc6_ = this.TeamShipImg[_loc1_];
               if(_loc6_.numChildren > 0)
               {
                  _loc6_.removeChildAt(0);
               }
               _loc7_ = this.TeamShipNum[_loc1_] as TextField;
               _loc7_.text = "";
            }
            _loc1_++;
         }
      }
      
      private function SaveClick(param1:MouseEvent) : void
      {
         CustomTip.GetInstance().Hide();
         var _loc2_:MovieClip = param1.target as MovieClip;
         var _loc3_:MSG_REQUEST_CREATETEAMMODEL = new MSG_REQUEST_CREATETEAMMODEL();
         var _loc4_:int = 0;
         while(_loc4_ < 9)
         {
            _loc3_.teamModel.model[_loc4_].ShipModelId = this._FleetInfo.ShipModelId[_loc4_];
            _loc3_.teamModel.model[_loc4_].Num = this._FleetInfo.Num[_loc4_];
            _loc4_++;
         }
         _loc3_.DelFlag = 0;
         _loc3_.IndexId = int(_loc2_.name.substr(8));
         _loc3_.SeqId = GamePlayer.getInstance().seqID++;
         _loc3_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc3_);
         var _loc5_:TeamModel = FleetRouter.instance.TeamModelInfo.teamModel[_loc3_.IndexId];
         var _loc6_:int = 0;
         while(_loc6_ < 9)
         {
            _loc5_.model[_loc6_].ShipModelId = this._FleetInfo.ShipModelId[_loc6_];
            _loc5_.model[_loc6_].Num = this._FleetInfo.Num[_loc6_];
            _loc6_++;
         }
      }
      
      private function SetShipImageAlpha(param1:Number) : void
      {
         var _loc3_:MovieClip = null;
         var _loc2_:int = 0;
         while(_loc2_ < 9)
         {
            _loc3_ = this.TeamShipImg[_loc2_];
            _loc3_.alpha = param1;
            _loc2_++;
         }
      }
      
      private function ReadClick(param1:MouseEvent) : void
      {
         CustomTip.GetInstance().Hide();
         var _loc2_:MovieClip = param1.target as MovieClip;
         this.BtnLoading.x = _loc2_.x + _loc2_.width - 20;
         this.BtnLoading.y = _loc2_.y;
         this.CancelBtn.x = this.BtnLoading.x;
         this.CancelBtn.y = this.BtnLoading.y + this.BtnLoading.height;
         this.DeleteBtn.x = this.CancelBtn.x;
         this.DeleteBtn.y = this.CancelBtn.y + this.CancelBtn.height;
         this.BtnLoading.visible = true;
         this.CancelBtn.visible = true;
         this.DeleteBtn.visible = true;
         this.SelectedModelIndex = int(_loc2_.name.substr(8));
         this.ReadTeamModel(this.SelectedModelIndex);
         this.SetShipImageAlpha(0.5);
      }
      
      private function ReadTeamModel(param1:int) : void
      {
         var _loc2_:MovieClip = null;
         this.ResetTeamShip();
         this.CreateTeamBtn.visible = false;
         var _loc3_:TeamModel = FleetRouter.instance.TeamModelInfo.teamModel[param1];
         var _loc4_:int = 0;
         while(_loc4_ < 9)
         {
            this._FleetInfo.ShipModelId[_loc4_] = _loc3_.model[_loc4_].ShipModelId;
            this._FleetInfo.Num[_loc4_] = _loc3_.model[_loc4_].Num;
            _loc4_++;
         }
         this.ShowFleetInfo();
      }
      
      private function BtnLoadingClick(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         this.BtnLoading.visible = false;
         this.CancelBtn.visible = false;
         this.DeleteBtn.visible = false;
         var _loc2_:HashSet = new HashSet();
         _loc3_ = 0;
         while(_loc3_ < 9)
         {
            if(this._FleetInfo.Num[_loc3_] > 0)
            {
               if(_loc2_.ContainsKey(this._FleetInfo.ShipModelId[_loc3_]))
               {
                  _loc4_ = _loc2_.Get(this._FleetInfo.ShipModelId[_loc3_]);
                  _loc2_.Put(this._FleetInfo.ShipModelId[_loc3_],this._FleetInfo.Num[_loc3_] + _loc4_);
               }
               else
               {
                  _loc2_.Put(this._FleetInfo.ShipModelId[_loc3_],this._FleetInfo.Num[_loc3_]);
               }
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc2_.Length())
         {
            _loc5_ = int(_loc2_.Keys()[_loc3_]);
            if(!this.MsgArrangShipTeam.ContainsKey(_loc5_) || this.MsgArrangShipTeam.Get(_loc5_) < _loc2_.Get(_loc5_))
            {
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("FormationText15"),0);
               this.CancelBtnClick(null);
               return;
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < 9)
         {
            if(this._FleetInfo.Num[_loc3_] > 0)
            {
               _loc6_ = this.MsgArrangShipTeam.Get(this._FleetInfo.ShipModelId[_loc3_]);
               _loc6_ = _loc6_ - this._FleetInfo.Num[_loc3_];
               if(_loc6_ > 0)
               {
                  this.MsgArrangShipTeam.Put(this._FleetInfo.ShipModelId[_loc3_],_loc6_);
               }
               else
               {
                  this.MsgArrangShipTeam.Remove(this._FleetInfo.ShipModelId[_loc3_]);
                  this.DeleteMsgArrangShipTeamArr(this._FleetInfo.ShipModelId[_loc3_]);
               }
            }
            _loc3_++;
         }
         this.ShowArrangeShip();
         this.CreateTeamBtn.visible = true;
         this.SetShipImageAlpha(1);
      }
      
      private function DeleteMsgArrangShipTeamArr(param1:int) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.MsgArrangShipTeamArr.length)
         {
            if(this.MsgArrangShipTeamArr[_loc2_] == param1)
            {
               this.MsgArrangShipTeamArr.splice(_loc2_,1);
               break;
            }
            _loc2_++;
         }
      }
      
      private function CancelBtnClick(param1:MouseEvent) : void
      {
         this.BtnLoading.visible = false;
         this.CancelBtn.visible = false;
         this.DeleteBtn.visible = false;
         this.ResetTeamShip();
         this.CreateTeamBtn.visible = true;
         this.SetShipImageAlpha(1);
      }
      
      private function ResetTeamShip() : void
      {
         var _loc1_:int = 0;
         if(this.CreateTeamBtn.visible)
         {
            _loc1_ = 0;
            while(_loc1_ < 9)
            {
               this.SelectedCellId = _loc1_;
               this.DeleteTeamShip();
               _loc1_++;
            }
            this.ShowArrangeShip();
         }
         else
         {
            _loc1_ = 0;
            while(_loc1_ < 9)
            {
               this._FleetInfo.ShipModelId[_loc1_] = -1;
               this._FleetInfo.Num[_loc1_] = 0;
               _loc1_++;
            }
            this.Locomotivity = 0;
            this.Storage = 0;
            this.SkeepCount = 0;
            this.Endure = 0;
            this.MinAssault = 0;
            this.MaxAssault = 0;
            this.ShipCount = 0;
            this.Supply = 0;
            this.ShowTeamValue();
         }
         this.ShowFleetInfo();
      }
      
      private function DeleteBtnClick(param1:MouseEvent) : void
      {
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         this.BtnLoading.visible = false;
         this.CancelBtn.visible = false;
         this.DeleteBtn.visible = false;
         this.ResetTeamShip();
         var _loc2_:MovieClip = param1.target as MovieClip;
         var _loc3_:MSG_REQUEST_CREATETEAMMODEL = new MSG_REQUEST_CREATETEAMMODEL();
         _loc3_.DelFlag = 1;
         _loc3_.IndexId = this.SelectedModelIndex;
         _loc3_.SeqId = GamePlayer.getInstance().seqID++;
         _loc3_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc3_);
         this.CreateTeamBtn.visible = true;
         this.SetShipImageAlpha(1);
      }
      
      public function IniCommanderList(param1:MSG_RESP_COMMANDERINFOARRANGE) : void
      {
         var _loc3_:CommanderInfo = null;
         var _loc4_:CommanderInfo = null;
         var _loc5_:int = 0;
         var _loc6_:MovieClip = null;
         var _loc2_:int = -1;
         this.CommanderList.splice(0);
         if(this.IsUpdate)
         {
            for each(_loc4_ in CommanderRouter.instance.m_commandInfoAry)
            {
               if(_loc4_.commander_commanderId == this.SelectedCommanderId)
               {
                  _loc2_ = int(this.CommanderList.length);
                  this.CommanderList.push(_loc4_);
               }
            }
         }
         for each(_loc3_ in CommanderRouter.instance.m_commandInfoAry)
         {
            _loc5_ = 0;
            while(_loc5_ < param1.DataLen)
            {
               if(_loc3_.commander_commanderId == param1.Data[_loc5_])
               {
                  this.CommanderList.push(_loc3_);
               }
               _loc5_++;
            }
         }
         this.CommanderPgaeCount = this.CommanderList.length / this.ComanderPageSize;
         this.CommanderPgaeCount += this.CommanderList.length % this.ComanderPageSize > 0 ? 1 : 0;
         if(this.SelectedCommanderMc != null)
         {
            this.SelectedCommanderMc.gotoAndStop("up");
         }
         if(this.IsUpdate)
         {
            this.CurCommanderPage = _loc2_ / this.ComanderPageSize;
            _loc6_ = this._mc.getMC().getChildByName("mc_airshiplist") as MovieClip;
            this.SelectedCommanderMc = _loc6_.getChildByName("mc_list" + _loc2_ % this.ComanderPageSize) as MovieClip;
            if(this.SelectedCommanderMc != null)
            {
               this.SelectedCommanderMc.gotoAndStop("special");
            }
         }
         else
         {
            this.CurCommanderPage = 0;
            this.SelectedCommanderMc = null;
         }
         this.ShowCommanderCurPage();
      }
      
      private function ShowCommanderCurPage() : void
      {
         var _loc1_:MovieClip = null;
         var _loc5_:CommanderInfo = null;
         var _loc6_:MovieClip = null;
         var _loc7_:Bitmap = null;
         var _loc8_:MovieClip = null;
         this.ShowCommanderPageButton();
         if(this.SelectedCommanderMc != null)
         {
            this.SelectedCommanderMc.gotoAndStop("up");
         }
         var _loc2_:int = this.CurCommanderPage * this.ComanderPageSize;
         var _loc3_:MovieClip = this._mc.getMC().getChildByName("mc_airshiplist") as MovieClip;
         var _loc4_:int = 0;
         while(_loc4_ < this.ComanderPageSize)
         {
            _loc1_ = _loc3_.getChildByName("mc_list" + _loc4_) as MovieClip;
            _loc1_.gotoAndStop("up");
            if(_loc2_ < this.CommanderList.length)
            {
               _loc5_ = this.CommanderList[_loc2_];
               _loc1_.visible = true;
               if(_loc5_.commander_commanderId == this.SelectedCommanderId && this.SelectedCommanderMc != null)
               {
                  this.SelectedCommanderMc.gotoAndStop("selected");
               }
               if(this.IsUpdate && _loc5_.commander_commanderId == this.UpdateFleetCommanderId)
               {
                  _loc1_.gotoAndStop("special");
               }
               _loc6_ = _loc1_.mc_base as MovieClip;
               if(_loc6_.numChildren > 0)
               {
                  _loc6_.removeChildAt(0);
               }
               _loc1_.mouseEnabled = true;
               _loc1_.mouseChildren = true;
               _loc7_ = CommanderSceneUI.getInstance().CommanderAvararImg(_loc5_.commander_skill);
               _loc7_.width = 50;
               _loc7_.height = 50;
               _loc6_.addChild(_loc7_);
            }
            else
            {
               _loc1_.visible = true;
               _loc8_ = _loc1_.mc_base as MovieClip;
               if(_loc8_.numChildren > 0)
               {
                  _loc8_.removeChildAt(0);
               }
               _loc1_.mouseEnabled = false;
               _loc1_.mouseChildren = false;
            }
            _loc2_++;
            _loc4_++;
         }
      }
      
      private function ShowCommanderPageButton() : void
      {
         if(this.CurCommanderPage == 0)
         {
            this.btn_up.setBtnDisabled(true);
         }
         else
         {
            this.btn_up.setBtnDisabled(false);
         }
         if((this.CurCommanderPage + 1) * this.ComanderPageSize < this.CommanderList.length)
         {
            this.btn_down.setBtnDisabled(false);
         }
         else
         {
            this.btn_down.setBtnDisabled(true);
         }
      }
      
      private function BtnUpClick(param1:Event) : void
      {
         if(this.CurCommanderPage > 0)
         {
            --this.CurCommanderPage;
            this.ShowCommanderCurPage();
         }
      }
      
      private function BtnDownClick(param1:Event) : void
      {
         if((this.CurCommanderPage + 1) * this.ComanderPageSize < this.CommanderList.length)
         {
            ++this.CurCommanderPage;
            this.ShowCommanderCurPage();
         }
      }
      
      private function CommanderClick(param1:Event) : void
      {
         if(this.SelectedCommanderMc != null)
         {
            this.SelectedCommanderMc.gotoAndStop("up");
            if(this.IsUpdate && this.SelectedCommanderId == this.UpdateFleetCommanderId)
            {
               this.SelectedCommanderMc.gotoAndStop("special");
            }
         }
         this.SelectedCommanderMc = param1.target as MovieClip;
         if(this.SelectedCommanderMc.name == "mc_base")
         {
            this.SelectedCommanderMc = this.SelectedCommanderMc.parent as MovieClip;
         }
         this.SelectedCommanderMc.gotoAndStop("selected");
         var _loc2_:int = int(this.SelectedCommanderMc.name.substr(7));
         _loc2_ = this.CurCommanderPage * this.ComanderPageSize + _loc2_;
         var _loc3_:CommanderInfo = this.CommanderList[_loc2_];
         this.SelectedCommanderId = _loc3_.commander_commanderId;
         if(this.IsUpdate && this.SelectedCommanderId == this.UpdateFleetCommanderId)
         {
            this.SelectedCommanderMc.gotoAndStop("special");
         }
         var _loc4_:TextField = this._mc.getMC().getChildByName("tf_commandername") as TextField;
         _loc4_.text = _loc3_.commander_name;
         var _loc5_:TextField = this._mc.getMC().getChildByName("tf_lv") as TextField;
         _loc5_.text = (_loc3_.commander_level + 1).toString();
         var _loc6_:MovieClip = this._mc.getMC().getChildByName("mc_base") as MovieClip;
         if(_loc6_.numChildren > 0)
         {
            _loc6_.removeChildAt(0);
         }
         var _loc7_:Bitmap = CommanderSceneUI.getInstance().CommanderAvararImg(_loc3_.commander_skill);
         _loc7_.width = 50;
         _loc7_.height = 50;
         _loc6_.addChild(_loc7_);
      }
      
      private function CommanderMouseOver(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         if(_loc2_.name == "mc_base")
         {
            _loc2_ = _loc2_.parent as MovieClip;
         }
         var _loc3_:int = int(_loc2_.name.substr(7));
         _loc3_ = this.CurCommanderPage * this.ComanderPageSize + _loc3_;
         var _loc4_:CommanderInfo = this.CommanderList[_loc3_];
         var _loc5_:Point = _loc2_.localToGlobal(new Point(0,_loc2_.height));
         CommanderInfoTip.GetInstance().ShowCommanderInfo(_loc4_.commander_commanderId,_loc4_.commander_skill,_loc5_);
      }
      
      private function CommanderMouseOut(param1:MouseEvent) : void
      {
         CommanderInfoTip.GetInstance().Hide();
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
         this._mc.removeChild(this.McHelp);
         this.Invalid(true);
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
      
      private function tf_fleetnameChange(param1:Event) : void
      {
         this.FleetNameTextField.text = this.FleetNameTextField.text.replace(" ","");
      }
   }
}

