package logic.ui
{
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.CEffectText;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFieldType;
   import flash.utils.Timer;
   import logic.action.ChatAction;
   import logic.action.ConstructionAction;
   import logic.entry.DiamondInfo;
   import logic.entry.GamePlayer;
   import logic.entry.GemInfo;
   import logic.entry.HButton;
   import logic.entry.HButtonType;
   import logic.entry.MObject;
   import logic.entry.ScienceSystem;
   import logic.entry.commander.CommanderInfo;
   import logic.entry.props.propsInfo;
   import logic.entry.shipmodel.FleetPropertyInfo;
   import logic.entry.shipmodel.ShipbodyInfo;
   import logic.entry.shipmodel.ShipmodelInfo;
   import logic.game.GameKernel;
   import logic.manager.GameInterActiveManager;
   import logic.reader.CCommanderReader;
   import logic.reader.CPropsReader;
   import logic.reader.CShipmodelReader;
   import logic.ui.info.BleakingLineForThai;
   import logic.utils.Commander;
   import logic.utils.UpdateResource;
   import logic.widget.ConstructionOperationWidget;
   import logic.widget.OperationEnum;
   import logic.widget.textarea.CChatInputBar;
   import net.common.MsgTypes;
   import net.router.CommanderRouter;
   import net.router.ShipmodelRouter;
   
   public class CommanderSceneUI extends AbstractPopUp
   {
      
      private static var instance:CommanderSceneUI;
      
      public static const SHOWCOMMANDERNUM:int = 14;
      
      private var mcairshiplistAry:Array = new Array();
      
      public var MAXCOMMANDER:int;
      
      private var m_statusAry:Array;
      
      private var m_hireadmiralAry:Array;
      
      private var m_speedhireAry:Array;
      
      private var m_voucherAry:Array;
      
      private var m_time:Timer;
      
      private var m_stateTime:Timer;
      
      public var m_pagenum:int;
      
      public var m_choosenum:int;
      
      private var m_choosePartNum:int;
      
      private var StatePopup:MObject;
      
      private var ArmySceneUI:MObject;
      
      private var Commandercard:MObject;
      
      private var GemSceneUI:MObject;
      
      private var m_teamshipbody:Array = new Array();
      
      private var m_SelectedCellId:int;
      
      private var m_ReplaceCellId:int;
      
      private var m_SelectedImg:MovieClip;
      
      private var m_ZhanjingAry:Array = new Array();
      
      private var m_ZhanjingmiaoshuAry:Array = new Array();
      
      public var m_Activation:int;
      
      public var m_nowState:int;
      
      private var ImgMC:MovieClip;
      
      private var m_cardUI:Array = new Array();
      
      public var m_commanderInfo:CommanderInfo;
      
      public var backMc:MovieClip = new MovieClip();
      
      private var m_commanderCommanderTypeAry:Array = new Array("");
      
      private var m_commanderTypeAry:Array = new Array("","");
      
      private var m_targetAry:Array = new Array();
      
      private var m_targetIntervalAry:Array = new Array();
      
      private var _Target:int;
      
      private var _TargetInterval:int;
      
      private var IsCooling:Boolean;
      
      private var IsOverState:Boolean = false;
      
      private var IsInCommanderUI:Boolean = true;
      
      private var m_commanderState:Array = new Array();
      
      private var m_havegem:Boolean = false;
      
      private var _headbase:MovieClip;
      
      private var _txtname:TextField;
      
      private var _close:HButton;
      
      private var _hireadmiral:MovieClip;
      
      private var _fire:HButton;
      
      private var _voucher:HButton;
      
      private var _cdtime:HButton;
      
      private var _up:HButton;
      
      private var _down:HButton;
      
      private var _changename:HButton;
      
      private var _headpic:HButton;
      
      private var _treasure:HButton;
      
      private var _cards:HButton;
      
      public var _checkbox:Object;
      
      private var _container:MovieClip;
      
      private var _fleetchange:HButton;
      
      private var mc_combox0:MovieClip;
      
      private var mc_combox1:MovieClip;
      
      private var _batchfire:HButton;
      
      private var _cardgather:HButton;
      
      private var _enterbag:HButton;
      
      private var _commanderintro:MovieClip;
      
      private var _state:HButton;
      
      private var _planbar:HButton;
      
      private var _jingzhun:HButton;
      
      private var _sudu:HButton;
      
      private var _guibi:HButton;
      
      private var _dianzi:HButton;
      
      private var _friend:HButton;
      
      private var _autofire:MovieClip;
      
      private var _scare:HButton;
      
      private var _alive:HButton;
      
      private var _shipbaseAry:Array = new Array();
      
      private var _shipbaseNumAry:Array = new Array();
      
      private var _shipbaseMigAry:Array = new Array();
      
      private var _stateMC:MovieClip = new MovieClip();
      
      private var _stateTxt:TextField = new TextField();
      
      private var ltip:MovieClip;
      
      private var shap:MovieClip;
      
      private var _compose:HButton;
      
      private var _gem:HButton;
      
      private var _army:HButton;
      
      private var ParamList:Array = new Array("Aim","Blench","Electron","Priority","Assault","Endure","Shield","BlastHurt","Blast","DoubleHit","RepairShield","Exp","Ballistic","Directional","Missile","Carrier","Defend","Frigate","Cruiser","BattleShip");
      
      public function CommanderSceneUI()
      {
         super();
         setPopUpName("CommanderSceneUI");
      }
      
      public static function getInstance() : CommanderSceneUI
      {
         if(instance == null)
         {
            instance = new CommanderSceneUI();
         }
         return instance;
      }
      
      override public function Init() : void
      {
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            return;
         }
         this._mc = new MObject("CommanderScene",380,290);
         GameKernel.popUpDisplayManager.Regisger(instance);
         this.initMcElement();
         this.m_time = new Timer(1000);
         this.m_time.addEventListener(TimerEvent.TIMER,this.onTick,false,0,true);
         this.m_stateTime = new Timer(1000);
         this.m_stateTime.addEventListener(TimerEvent.TIMER,this.onStateTick,false,0,true);
         GameKernel.getInstance().isCommanderInit = true;
         this.m_commanderTypeAry.push(StringManager.getInstance().getMessageString("CommanderText47"));
         this.m_commanderTypeAry.push(StringManager.getInstance().getMessageString("CommanderText48"));
         this.m_commanderTypeAry.push(StringManager.getInstance().getMessageString("CommanderText49"));
         this.m_commanderTypeAry.push(StringManager.getInstance().getMessageString("Boss32"));
         this.m_commanderCommanderTypeAry.push(StringManager.getInstance().getMessageString("CommanderText50"));
         this.m_commanderCommanderTypeAry.push(StringManager.getInstance().getMessageString("CommanderText51"));
         this.m_commanderCommanderTypeAry.push(StringManager.getInstance().getMessageString("CommanderText52"));
         this.m_commanderCommanderTypeAry.push(StringManager.getInstance().getMessageString("CommanderText52"));
         this.m_commanderCommanderTypeAry.push(StringManager.getInstance().getMessageString("Boss33"));
      }
      
      override public function initMcElement() : void
      {
         var _loc7_:XButton = null;
         var _loc10_:MovieClip = null;
         var _loc11_:MovieClip = null;
         var _loc12_:MovieClip = null;
         var _loc13_:MovieClip = null;
         var _loc14_:TextField = null;
         var _loc15_:MovieClip = null;
         var _loc16_:MovieClip = null;
         this.MAXCOMMANDER = GamePlayer.getInstance().commandernum;
         this.m_statusAry = new Array(StringManager.getInstance().getMessageString("CommanderText20"),StringManager.getInstance().getMessageString("CommanderText1"),StringManager.getInstance().getMessageString("CommanderText2"),StringManager.getInstance().getMessageString("CommanderText3"),StringManager.getInstance().getMessageString("CommanderText100"),StringManager.getInstance().getMessageString("CommanderText101"));
         this.m_hireadmiralAry = new Array(StringManager.getInstance().getMessageString("CommanderText4"),"","","","");
         this.m_speedhireAry = new Array(StringManager.getInstance().getMessageString("CommanderText7"),StringManager.getInstance().getMessageString("CommanderText8"),"","");
         this.m_voucherAry = new Array(StringManager.getInstance().getMessageString("CommanderText9"),"","","");
         this._close = new HButton(_mc.getMC().btn_close);
         GameInterActiveManager.InstallInterActiveEvent(this._close.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         this._alive = new HButton(_mc.getMC().btn_alive);
         GameInterActiveManager.InstallInterActiveEvent(this._alive.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         GameInterActiveManager.InstallInterActiveEvent(this._alive.m_movie,ActionEvent.ACTION_MOUSE_OVER,this.overBtn);
         GameInterActiveManager.InstallInterActiveEvent(this._alive.m_movie,ActionEvent.ACTION_MOUSE_OUT,this.outBtn);
         this._alive.setVisible(false);
         this._scare = new HButton(_mc.getMC().btn_cure);
         GameInterActiveManager.InstallInterActiveEvent(this._scare.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         GameInterActiveManager.InstallInterActiveEvent(this._scare.m_movie,ActionEvent.ACTION_MOUSE_OVER,this.overBtn);
         GameInterActiveManager.InstallInterActiveEvent(this._scare.m_movie,ActionEvent.ACTION_MOUSE_OUT,this.outBtn);
         this._scare.setVisible(false);
         this._hireadmiral = _mc.getMC().btn_hireadmiral;
         this._hireadmiral.gotoAndStop(1);
         GameInterActiveManager.InstallInterActiveEvent(this._hireadmiral,ActionEvent.ACTION_CLICK,this.chickButton);
         GameInterActiveManager.InstallInterActiveEvent(this._hireadmiral,ActionEvent.ACTION_MOUSE_OVER,this.overBtn);
         GameInterActiveManager.InstallInterActiveEvent(this._hireadmiral,ActionEvent.ACTION_MOUSE_OUT,this.outBtn);
         this._fire = new HButton(_mc.getMC().btn_fire);
         GameInterActiveManager.InstallInterActiveEvent(this._fire.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         GameInterActiveManager.InstallInterActiveEvent(this._fire.m_movie,ActionEvent.ACTION_MOUSE_OVER,this.overBtn);
         GameInterActiveManager.InstallInterActiveEvent(this._fire.m_movie,ActionEvent.ACTION_MOUSE_OUT,this.outBtn);
         this._voucher = new HButton(_mc.getMC().btn_speedhire);
         GameInterActiveManager.InstallInterActiveEvent(this._voucher.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         GameInterActiveManager.InstallInterActiveEvent(this._voucher.m_movie,ActionEvent.ACTION_MOUSE_OVER,this.overBtn);
         GameInterActiveManager.InstallInterActiveEvent(this._voucher.m_movie,ActionEvent.ACTION_MOUSE_OUT,this.outBtn);
         this._cards = new HButton(_mc.getMC().btn_voucher);
         GameInterActiveManager.InstallInterActiveEvent(this._cards.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         GameInterActiveManager.InstallInterActiveEvent(this._cards.m_movie,ActionEvent.ACTION_MOUSE_OVER,this.overBtn);
         GameInterActiveManager.InstallInterActiveEvent(this._cards.m_movie,ActionEvent.ACTION_MOUSE_OUT,this.outBtn);
         this._cdtime = new HButton(_mc.getMC().btn_cdtime);
         GameInterActiveManager.InstallInterActiveEvent(this._cdtime.m_movie,ActionEvent.ACTION_MOUSE_OVER,this.overBtn);
         GameInterActiveManager.InstallInterActiveEvent(this._cdtime.m_movie,ActionEvent.ACTION_MOUSE_OUT,this.outBtn);
         _mc.getMC().mc_grade.addEventListener(ActionEvent.ACTION_MOUSE_OVER,this.overBtn);
         _mc.getMC().mc_grade.addEventListener(ActionEvent.ACTION_MOUSE_OUT,this.outBtn);
         this._headpic = new HButton(_mc.getMC().mc_headbase);
         GameInterActiveManager.InstallInterActiveEvent(this._headpic.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         this._headpic.m_movie.addEventListener(ActionEvent.ACTION_MOUSE_OVER,this.overtext);
         this._headpic.m_movie.addEventListener(ActionEvent.ACTION_MOUSE_OUT,this.outtext);
         this._autofire = _mc.getMC().btn_autofire as MovieClip;
         this._autofire.addEventListener(ActionEvent.ACTION_CLICK,this.chickButton);
         this._autofire.addEventListener(ActionEvent.ACTION_MOUSE_OVER,this.overBtn);
         this._autofire.addEventListener(ActionEvent.ACTION_MOUSE_OUT,this.outBtn);
         this.m_Activation = 0;
         this._autofire.gotoAndStop("disabled");
         this._batchfire = new HButton(_mc.getMC().btn_batchfire);
         GameInterActiveManager.InstallInterActiveEvent(this._batchfire.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         GameInterActiveManager.InstallInterActiveEvent(this._batchfire.m_movie,ActionEvent.ACTION_MOUSE_OVER,this.overBtn);
         GameInterActiveManager.InstallInterActiveEvent(this._batchfire.m_movie,ActionEvent.ACTION_MOUSE_OUT,this.outBtn);
         this._enterbag = new HButton(this._mc.getMC().btn_enterbag,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("MainUITXT20"));
         GameInterActiveManager.InstallInterActiveEvent(this._enterbag.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         this._txtname = TextField(this._mc.getMC().tf_name);
         this._txtname.type = TextFieldType.DYNAMIC;
         this._compose = new HButton(this._mc.getMC().btn_compose,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("CommanderText112"));
         GameInterActiveManager.InstallInterActiveEvent(this._compose.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         this._gem = new HButton(this._mc.getMC().btn_gem,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("CommanderText129"));
         GameInterActiveManager.InstallInterActiveEvent(this._gem.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         this._army = new HButton(this._mc.getMC().btn_army,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("CommanderText128"));
         GameInterActiveManager.InstallInterActiveEvent(this._army.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         var _loc1_:MovieClip = this._mc.getMC().mc_airshiplist;
         var _loc2_:int = 0;
         while(_loc2_ < SHOWCOMMANDERNUM)
         {
            this.mcairshiplistAry[_loc2_] = _loc1_.getChildByName("mc_list" + _loc2_) as MovieClip;
            _loc10_ = this.mcairshiplistAry[_loc2_] as MovieClip;
            TextField(this.mcairshiplistAry[_loc2_].tf_admiralname).selectable = false;
            _loc10_.mouseEnabled = true;
            _loc10_.mouseChildren = false;
            _loc10_.buttonMode = true;
            this.mcairshiplistAry[_loc2_].gotoAndStop("up");
            GameInterActiveManager.InstallInterActiveEvent(_loc10_,ActionEvent.ACTION_CLICK,this.choose);
            _loc2_++;
         }
         this.mcairshiplistAry[0].gotoAndStop("selected");
         var _loc3_:HButton = new HButton(_loc1_.btn_xidian);
         GameInterActiveManager.InstallInterActiveEvent(_loc3_.m_movie,ActionEvent.ACTION_MOUSE_OVER,this.overBtn);
         GameInterActiveManager.InstallInterActiveEvent(_loc3_.m_movie,ActionEvent.ACTION_MOUSE_OUT,this.outBtn);
         TextField(_loc1_.tf_page).text = "";
         this._up = new HButton(_loc1_.btn_up);
         GameInterActiveManager.InstallInterActiveEvent(this._up.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         this._down = new HButton(_loc1_.btn_down);
         GameInterActiveManager.InstallInterActiveEvent(this._down.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         this._checkbox = this._mc.getMC().checkbox0;
         this._container = this._mc.getMC().mc_container;
         this._friend = new HButton(this._mc.getMC().btn_friend);
         GameInterActiveManager.InstallInterActiveEvent(this._friend.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         GameInterActiveManager.InstallInterActiveEvent(this._friend.m_movie,ActionEvent.ACTION_MOUSE_OVER,this.overBtn);
         GameInterActiveManager.InstallInterActiveEvent(this._friend.m_movie,ActionEvent.ACTION_MOUSE_OUT,this.outBtn);
         this._planbar = new HButton(this._mc.getMC().btn_planbar);
         GameInterActiveManager.InstallInterActiveEvent(this._planbar.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         GameInterActiveManager.InstallInterActiveEvent(this._planbar.m_movie,ActionEvent.ACTION_MOUSE_OVER,this.overBtn);
         GameInterActiveManager.InstallInterActiveEvent(this._planbar.m_movie,ActionEvent.ACTION_MOUSE_OUT,this.outBtn);
         this.GemSceneUI = new MObject("GemScene",0,0);
         var _loc4_:int = 0;
         while(_loc4_ < 12)
         {
            _loc11_ = this.GemSceneUI.getMC().getChildByName("mc_list" + _loc4_) as MovieClip;
            _loc11_.gotoAndStop(1);
            _loc12_ = this.GemSceneUI.getMC().getChildByName("pic_" + _loc4_) as MovieClip;
            _loc12_.mouseChildren = false;
            _loc4_++;
         }
         this.GemSceneUI.getMC().addEventListener(MouseEvent.MOUSE_OVER,this.overGemPic);
         this.ArmySceneUI = new MObject("ArmyScene",0,0);
         this._fleetchange = new HButton(this.ArmySceneUI.getMC().btn_fleetchange);
         GameInterActiveManager.InstallInterActiveEvent(this._fleetchange.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         this._container.addChild(this.ArmySceneUI.getMC());
         var _loc5_:MovieClip = this.ArmySceneUI.getMC().pic_yidongli as MovieClip;
         _loc5_.addEventListener(ActionEvent.ACTION_MOUSE_OVER,this.overPic);
         _loc5_.addEventListener(ActionEvent.ACTION_MOUSE_OUT,this.outPic);
         _loc5_ = this.ArmySceneUI.getMC().pic_xueliang as MovieClip;
         _loc5_.addEventListener(ActionEvent.ACTION_MOUSE_OVER,this.overPic);
         _loc5_.addEventListener(ActionEvent.ACTION_MOUSE_OUT,this.outPic);
         _loc5_ = this.ArmySceneUI.getMC().pic_cunchu as MovieClip;
         _loc5_.addEventListener(ActionEvent.ACTION_MOUSE_OVER,this.overPic);
         _loc5_.addEventListener(ActionEvent.ACTION_MOUSE_OUT,this.outPic);
         _loc5_ = this.ArmySceneUI.getMC().pic_gongjili as MovieClip;
         _loc5_.addEventListener(ActionEvent.ACTION_MOUSE_OVER,this.overPic);
         _loc5_.addEventListener(ActionEvent.ACTION_MOUSE_OUT,this.outPic);
         _loc5_ = this.ArmySceneUI.getMC().pic_huihe as MovieClip;
         _loc5_.addEventListener(ActionEvent.ACTION_MOUSE_OVER,this.overPic);
         _loc5_.addEventListener(ActionEvent.ACTION_MOUSE_OUT,this.outPic);
         _loc5_ = this.ArmySceneUI.getMC().pic_jianchuan as MovieClip;
         _loc5_.addEventListener(ActionEvent.ACTION_MOUSE_OVER,this.overPic);
         _loc5_.addEventListener(ActionEvent.ACTION_MOUSE_OUT,this.outPic);
         _loc5_ = this._mc.getMC().mc_jingzhun as MovieClip;
         _loc5_.addEventListener(ActionEvent.ACTION_MOUSE_OVER,this.overMc);
         _loc5_.addEventListener(ActionEvent.ACTION_MOUSE_OUT,this.outPic);
         _loc5_ = this._mc.getMC().mc_sudu as MovieClip;
         _loc5_.addEventListener(ActionEvent.ACTION_MOUSE_OVER,this.overMc);
         _loc5_.addEventListener(ActionEvent.ACTION_MOUSE_OUT,this.outPic);
         _loc5_ = this._mc.getMC().mc_guibi as MovieClip;
         _loc5_.addEventListener(ActionEvent.ACTION_MOUSE_OVER,this.overMc);
         _loc5_.addEventListener(ActionEvent.ACTION_MOUSE_OUT,this.outPic);
         _loc5_ = this._mc.getMC().mc_dianzi as MovieClip;
         _loc5_.addEventListener(ActionEvent.ACTION_MOUSE_OVER,this.overMc);
         _loc5_.addEventListener(ActionEvent.ACTION_MOUSE_OUT,this.outPic);
         this.m_targetAry.push(StringManager.getInstance().getMessageString("FormationText6"));
         this.m_targetAry.push(StringManager.getInstance().getMessageString("FormationText7"));
         this.m_targetIntervalAry.push(StringManager.getInstance().getMessageString("FormationText8"));
         this.m_targetIntervalAry.push(StringManager.getInstance().getMessageString("FormationText9"));
         this.m_targetIntervalAry.push(StringManager.getInstance().getMessageString("FormationText10"));
         this.m_targetIntervalAry.push(StringManager.getInstance().getMessageString("FormationText11"));
         this.m_targetIntervalAry.push(StringManager.getInstance().getMessageString("FormationText12"));
         this.m_targetIntervalAry.push(StringManager.getInstance().getMessageString("FormationText13"));
         this.m_targetIntervalAry.push(StringManager.getInstance().getMessageString("FormationText14"));
         var _loc6_:MovieClip = this.ArmySceneUI.getMC().mc_combox0 as MovieClip;
         this.mc_combox0 = _loc6_;
         this.mc_combox0.buttonMode = true;
         TextField(this.ArmySceneUI.getMC().mc_combox0.tf_txt).mouseEnabled = false;
         _loc6_.stop();
         _loc6_.addEventListener(MouseEvent.CLICK,this.mc_combox0Click);
         _loc6_ = this.ArmySceneUI.getMC().mc_output0 as MovieClip;
         _loc6_.visible = false;
         _loc7_ = new XButton(_loc6_.btn_0);
         _loc7_.Data = 0;
         _loc7_.OnClick = this.ComboBoxRangeClick;
         TextField(_loc6_.btn_0.tf_txt).text = StringManager.getInstance().getMessageString("FormationText6");
         _loc7_ = new XButton(_loc6_.btn_1);
         _loc7_.Data = 1;
         _loc7_.OnClick = this.ComboBoxRangeClick;
         TextField(_loc6_.btn_1.tf_txt).text = StringManager.getInstance().getMessageString("FormationText7");
         _loc6_.visible = false;
         _loc6_ = this.ArmySceneUI.getMC().mc_combox1 as MovieClip;
         this.mc_combox1 = _loc6_;
         this.mc_combox1.buttonMode = true;
         TextField(this.ArmySceneUI.getMC().mc_combox1.tf_txt).mouseEnabled = false;
         _loc6_.stop();
         _loc6_.addEventListener(MouseEvent.CLICK,this.mc_combox1Click);
         _loc6_ = this.ArmySceneUI.getMC().mc_output1 as MovieClip;
         _loc6_.visible = false;
         _loc7_ = new XButton(_loc6_.btn_0);
         _loc7_.Data = 0;
         _loc7_.OnClick = this.ComboBoxLockClick;
         TextField(_loc6_.btn_0.tf_txt).text = StringManager.getInstance().getMessageString("FormationText8");
         _loc7_ = new XButton(_loc6_.btn_1);
         _loc7_.Data = 6;
         _loc7_.OnClick = this.ComboBoxLockClick;
         TextField(_loc6_.btn_1.tf_txt).text = StringManager.getInstance().getMessageString("FormationText14");
         _loc7_ = new XButton(_loc6_.btn_2);
         _loc7_.Data = 2;
         _loc7_.OnClick = this.ComboBoxLockClick;
         TextField(_loc6_.btn_2.tf_txt).text = StringManager.getInstance().getMessageString("FormationText10");
         _loc7_ = new XButton(_loc6_.btn_3);
         _loc7_.Data = 3;
         _loc7_.OnClick = this.ComboBoxLockClick;
         TextField(_loc6_.btn_3.tf_txt).text = StringManager.getInstance().getMessageString("FormationText11");
         _loc7_ = new XButton(_loc6_.btn_4);
         _loc7_.Data = 4;
         _loc7_.OnClick = this.ComboBoxLockClick;
         TextField(_loc6_.btn_4.tf_txt).text = StringManager.getInstance().getMessageString("FormationText12");
         _loc7_ = new XButton(_loc6_.btn_5);
         _loc7_.Data = 5;
         _loc7_.OnClick = this.ComboBoxLockClick;
         TextField(_loc6_.btn_5.tf_txt).text = StringManager.getInstance().getMessageString("FormationText13");
         _loc7_ = new XButton(_loc6_.btn_6);
         _loc7_.Data = 1;
         _loc7_.OnClick = this.ComboBoxLockClick;
         TextField(_loc6_.btn_6.tf_txt).text = StringManager.getInstance().getMessageString("FormationText9");
         var _loc8_:int = 0;
         while(_loc8_ < 9)
         {
            _loc13_ = this.ArmySceneUI.getMC().mc_grid.getChildByName("mc_base" + _loc8_) as MovieClip;
            this._shipbaseAry[_loc8_] = _loc13_;
            this._shipbaseAry[_loc8_].addEventListener(MouseEvent.MOUSE_DOWN,this.TeamShipMouseDown);
            _loc14_ = _loc13_.getChildByName("tf_num") as TextField;
            _loc14_.text = "";
            _loc14_.mouseEnabled = false;
            this._shipbaseNumAry[_loc8_] = _loc14_;
            _loc15_ = _loc13_.mc_base as MovieClip;
            this._shipbaseMigAry[_loc8_] = _loc15_;
            _loc8_++;
         }
         this._headbase = this._mc.getMC().mc_headbase as MovieClip;
         this._headbase.addEventListener(ActionEvent.ACTION_CLICK,this.chickHead);
         this.m_cardUI[1] = new MObject("BluecardMc",-170,-120);
         this.m_cardUI[2] = new MObject("GreencardMc",-170,-120);
         this.m_cardUI[3] = new MObject("YellowcardMc",-170,-120);
         this.m_cardUI[5] = new MObject("GoldencardMc",-170,-120);
         this.Commandercard = new MObject("CommandercardScene",0,0);
         this.m_ZhanjingAry.push(StringManager.getInstance().getMessageString("CommanderText36"));
         this.m_ZhanjingAry.push(StringManager.getInstance().getMessageString("CommanderText37"));
         this.m_ZhanjingAry.push(StringManager.getInstance().getMessageString("CommanderText38"));
         this.m_ZhanjingAry.push(StringManager.getInstance().getMessageString("CommanderText39"));
         this.m_ZhanjingAry.push(StringManager.getInstance().getMessageString("CommanderText40"));
         this.m_ZhanjingAry.push(StringManager.getInstance().getMessageString("CommanderText41"));
         this.m_ZhanjingAry.push(StringManager.getInstance().getMessageString("CommanderText42"));
         this.m_ZhanjingAry.push(StringManager.getInstance().getMessageString("CommanderText43"));
         this.m_ZhanjingmiaoshuAry.push(StringManager.getInstance().getMessageString("CommanderText54"));
         this.m_ZhanjingmiaoshuAry.push(StringManager.getInstance().getMessageString("CommanderText55"));
         this.m_ZhanjingmiaoshuAry.push(StringManager.getInstance().getMessageString("CommanderText56"));
         this.m_ZhanjingmiaoshuAry.push(StringManager.getInstance().getMessageString("CommanderText57"));
         this.m_ZhanjingmiaoshuAry.push(StringManager.getInstance().getMessageString("CommanderText58"));
         this.m_ZhanjingmiaoshuAry.push(StringManager.getInstance().getMessageString("CommanderText59"));
         this.m_ZhanjingmiaoshuAry.push(StringManager.getInstance().getMessageString("CommanderText60"));
         this.m_ZhanjingmiaoshuAry.push(StringManager.getInstance().getMessageString("CommanderText61"));
         var _loc9_:int = 0;
         while(_loc9_ < 8)
         {
            _loc16_ = this._mc.getMC().getChildByName("mc_skill" + _loc9_) as MovieClip;
            _loc16_.addEventListener(MouseEvent.MOUSE_MOVE,this.overSkill);
            _loc16_.addEventListener(ActionEvent.ACTION_MOUSE_OUT,this.outSkill);
            _loc9_++;
         }
         this._mc.getMC().tf_state.addEventListener(ActionEvent.ACTION_MOUSE_OVER,this.overState);
         this._mc.getMC().tf_state.addEventListener(ActionEvent.ACTION_MOUSE_OUT,this.outState);
      }
      
      public function Cursor() : void
      {
      }
      
      private function ComboBoxRangeClick(param1:MouseEvent, param2:XButton) : void
      {
         (this.ArmySceneUI.getMC().mc_output0 as MovieClip).visible = false;
         this.mc_combox0.gotoAndStop("up");
         TextField(this.ArmySceneUI.getMC().mc_combox0.tf_txt).text = TextField(param2.m_movie.tf_txt).text;
         this._Target = param2.Data;
      }
      
      private function ComboBoxLockClick(param1:MouseEvent, param2:XButton) : void
      {
         (this.ArmySceneUI.getMC().mc_output1 as MovieClip).visible = false;
         this.mc_combox1.gotoAndStop("up");
         TextField(this.ArmySceneUI.getMC().mc_combox1.tf_txt).text = TextField(param2.m_movie.tf_txt).text;
         this._TargetInterval = param2.Data;
      }
      
      private function mc_combox0Click(param1:MouseEvent) : void
      {
         if((this.ArmySceneUI.getMC().mc_output0 as MovieClip).visible)
         {
            (this.ArmySceneUI.getMC().mc_output0 as MovieClip).visible = false;
            this.mc_combox0.gotoAndStop("up");
         }
         else
         {
            (this.ArmySceneUI.getMC().mc_output0 as MovieClip).visible = true;
            this.mc_combox0.gotoAndStop("selected");
         }
      }
      
      private function mc_combox1Click(param1:MouseEvent) : void
      {
         if((this.ArmySceneUI.getMC().mc_output1 as MovieClip).visible)
         {
            (this.ArmySceneUI.getMC().mc_output1 as MovieClip).visible = false;
            this.mc_combox1.gotoAndStop("up");
         }
         else
         {
            (this.ArmySceneUI.getMC().mc_output1 as MovieClip).visible = true;
            this.mc_combox1.gotoAndStop("selected");
         }
      }
      
      private function onTick(param1:TimerEvent) : void
      {
         if(CommanderRouter.instance.NextInviteTime > 0)
         {
            if(this.IsInCommanderUI == true)
            {
               TextField(this._cdtime.m_movie.tf_remaintime).text = this.changetime(CommanderRouter.instance.NextInviteTime);
            }
         }
         else
         {
            this._cdtime.m_movie.visible = false;
            this._hireadmiral.gotoAndStop("up");
            this.IsCooling = false;
            this.m_time.stop();
         }
      }
      
      private function onStateTick(param1:TimerEvent) : void
      {
         if(--this.m_commanderInfo.commander_restTime > 0)
         {
            this._stateTxt.htmlText = this.changetime(this.m_commanderInfo.commander_restTime);
         }
         else
         {
            this.m_stateTime.stop();
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
      
      private function InitCommandeList() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < SHOWCOMMANDERNUM)
         {
            if(_loc1_ < 10 && this.m_pagenum == 0)
            {
               TextField(this.mcairshiplistAry[_loc1_].tf_admiralname).text = "";
               MovieClip(this.mcairshiplistAry[_loc1_]).gotoAndStop(1);
            }
            else
            {
               TextField(this.mcairshiplistAry[_loc1_].tf_admiralname).text = "";
               MovieClip(this.mcairshiplistAry[_loc1_]).gotoAndStop(1);
            }
            _loc1_++;
         }
      }
      
      public function InitPopUp() : void
      {
         this.MAXCOMMANDER = GamePlayer.getInstance().commandernum;
         this.m_pagenum = 0;
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
         this.showCommanderList();
      }
      
      public function showCommanderList() : void
      {
         this.InitCommandeList();
         TextField(this._mc.getMC().mc_airshiplist.tf_page).text = String(CommanderRouter.instance.m_commandInfoAry.length) + "/" + String(this.MAXCOMMANDER);
         var _loc1_:int = this.m_pagenum * SHOWCOMMANDERNUM;
         var _loc2_:int = 0;
         while(_loc1_ < CommanderRouter.instance.m_commandInfoAry.length && _loc2_ < SHOWCOMMANDERNUM)
         {
            if(CommanderRouter.instance.m_commanderStateAry[_loc1_] == 1)
            {
               MovieClip(this.mcairshiplistAry[_loc2_]).gotoAndStop(2);
            }
            else if(CommanderRouter.instance.m_commanderStateAry[_loc1_] == 2)
            {
               MovieClip(this.mcairshiplistAry[_loc2_]).gotoAndStop(3);
            }
            else
            {
               MovieClip(this.mcairshiplistAry[_loc2_]).gotoAndStop(1);
            }
            TextField(this.mcairshiplistAry[_loc2_].tf_admiralname).textColor = this.textColorCommander(CommanderRouter.instance.m_commandInfoAry[_loc1_].commander_type);
            TextField(this.mcairshiplistAry[_loc2_].tf_admiralname).text = CommanderRouter.instance.m_commandInfoAry[_loc1_].commander_name;
            _loc2_++;
            _loc1_++;
         }
         if(CommanderRouter.instance.m_commanderStateAry[this.m_choosenum] == 1)
         {
            this.mcairshiplistAry[this.m_choosenum % SHOWCOMMANDERNUM].gotoAndStop(5);
         }
         else if(CommanderRouter.instance.m_commanderStateAry[this.m_choosenum] == 2)
         {
            this.mcairshiplistAry[this.m_choosenum % SHOWCOMMANDERNUM].gotoAndStop(6);
         }
         else
         {
            this.mcairshiplistAry[this.m_choosenum % SHOWCOMMANDERNUM].gotoAndStop("selected");
         }
      }
      
      private function textColorCommander(param1:int) : uint
      {
         if(param1 == 2)
         {
            return 51200;
         }
         if(param1 == 3)
         {
            return 37112;
         }
         if(param1 == 4)
         {
            return 16253176;
         }
         if(param1 == 5)
         {
            return 16776960;
         }
         return 16777215;
      }
      
      public function InitCommanderinfo() : void
      {
         TextField(this._mc.getMC().mc_airshiplist.tf_page).text = String(CommanderRouter.instance.m_commandInfoAry.length) + "/" + String(this.MAXCOMMANDER);
         TextField(this._mc.getMC().tf_name).text = "";
         TextField(this._mc.getMC().tf_state).text = "";
         TextField(this._mc.getMC().tf_skill).text = "";
         TextField(this._mc.getMC().tf_LV).text = "";
         TextField(this._mc.getMC().tf_num).text = "";
         _mc.getMC().mc_planbar.width = 0;
         TextField(this._mc.getMC().tf_jingzhun).text = "";
         TextField(this._mc.getMC().tf_sudu).text = "";
         TextField(this._mc.getMC().tf_guibi).text = "";
         TextField(this._mc.getMC().tf_dianzi).text = "";
         this.setfriendButton(true);
         if(this._mc.getMC().mc_headbase.numChildren > 1)
         {
            this._mc.getMC().mc_headbase.removeChildAt(1);
         }
         TextField(this.ArmySceneUI.getMC().tf_yidongli).text = "";
         TextField(this.ArmySceneUI.getMC().tf_xueliang).text = "";
         TextField(this.ArmySceneUI.getMC().tf_cunchu).text = "";
         TextField(this.ArmySceneUI.getMC().tf_gongjili).text = "";
         TextField(this.ArmySceneUI.getMC().tf_jianchuan).text = "";
         TextField(this.ArmySceneUI.getMC().tf_huihe).text = "";
         var _loc1_:int = 0;
         while(_loc1_ < 8)
         {
            if(_loc1_ == 0)
            {
               this._mc.getMC().mc_txt0.gotoAndStop("empty");
            }
            else if(_loc1_ == 1)
            {
               this._mc.getMC().mc_txt1.gotoAndStop("empty");
            }
            else if(_loc1_ == 2)
            {
               this._mc.getMC().mc_txt2.gotoAndStop("empty");
            }
            else if(_loc1_ == 3)
            {
               this._mc.getMC().mc_txt3.gotoAndStop("empty");
            }
            else if(_loc1_ == 4)
            {
               this._mc.getMC().mc_txt4.gotoAndStop("empty");
            }
            else if(_loc1_ == 5)
            {
               this._mc.getMC().mc_txt5.gotoAndStop("empty");
            }
            else if(_loc1_ == 6)
            {
               this._mc.getMC().mc_txt6.gotoAndStop("empty");
            }
            else if(_loc1_ == 7)
            {
               this._mc.getMC().mc_txt7.gotoAndStop("empty");
            }
            _loc1_++;
         }
         this._alive.setVisible(false);
         this._scare.setVisible(false);
         this.ArmySceneUI.getMC().btn_fleetchange.visible = false;
      }
      
      private function textColorZJ(param1:String) : uint
      {
         if(param1 == "S")
         {
            return 16252928;
         }
         if(param1 == "A")
         {
            return 16253176;
         }
         if(param1 == "B")
         {
            return 37112;
         }
         if(param1 == "C")
         {
            return 51200;
         }
         return 16316664;
      }
      
      public function showCommanderinfo(param1:CommanderInfo) : void
      {
         var _loc4_:Bitmap = null;
         var _loc8_:int = 0;
         var _loc9_:MovieClip = null;
         var _loc10_:MovieClip = null;
         var _loc11_:int = 0;
         var _loc12_:DiamondInfo = null;
         var _loc13_:String = null;
         var _loc14_:Bitmap = null;
         var _loc15_:int = 0;
         var _loc16_:String = null;
         this.InitCommanderinfo();
         this.IsInCommanderUI = true;
         if(param1 == null)
         {
            return;
         }
         this.setfriendButton(false);
         TextField(this._mc.getMC().mc_airshiplist.tf_page).text = String(CommanderRouter.instance.m_commandInfoAry.length) + "/" + String(this.MAXCOMMANDER);
         this.m_commanderInfo = param1;
         if(this.m_commanderInfo.commander_restTime > 0)
         {
            this.m_stateTime.start();
         }
         else
         {
            this.m_stateTime.stop();
         }
         TextField(this._mc.getMC().tf_name).text = param1.commander_name;
         this.m_nowState = param1.commander_state;
         TextField(this._mc.getMC().tf_state).text = this.m_statusAry[param1.commander_state];
         if(param1.commander_state == 1)
         {
            this._scare.setVisible(true);
         }
         else if(param1.commander_state == 2)
         {
            this._alive.setVisible(true);
         }
         else
         {
            this._scare.setVisible(false);
            this._alive.setVisible(false);
         }
         CCommanderReader.getInstance().getcommander(param1.commander_skill);
         var _loc2_:MovieClip = this._mc.getMC().mc_headbase as MovieClip;
         var _loc3_:String = CCommanderReader.getInstance().m_ImageFileName;
         if(_loc3_ == "")
         {
            _loc4_ = new Bitmap(GameKernel.getTextureInstance("SmallCommand0"));
         }
         else
         {
            _loc4_ = new Bitmap(GameKernel.getTextureInstance(_loc3_));
         }
         _loc4_.height = _loc2_.height + 20;
         _loc4_.width = _loc2_.width + 20;
         _loc2_.addChild(_loc4_);
         TextField(this._mc.getMC().tf_skill).text = CCommanderReader.getInstance().m_skillName;
         TextField(this._mc.getMC().tf_LV).text = String(param1.commander_level + 1);
         var _loc5_:int = CCommanderReader.getInstance().GetCommanderExp(param1.commander_level);
         if(_loc5_ == 0)
         {
            TextField(this._mc.getMC().tf_num).text = "0/0";
            _mc.getMC().mc_planbar.width = 0;
         }
         else
         {
            TextField(this._mc.getMC().tf_num).text = String(param1.commander_exp) + "/" + String(_loc5_);
            _mc.getMC().mc_planbar.width = int(param1.commander_exp * 104 / _loc5_);
         }
         TextField(this._mc.getMC().tf_jingzhun).text = String(param1.commander_aim);
         TextField(this._mc.getMC().tf_dianzi).text = String(param1.commander_electron);
         TextField(this._mc.getMC().tf_sudu).text = String(param1.commander_priority);
         TextField(this._mc.getMC().tf_guibi).text = String(param1.commander_blench);
         if(param1.commander_level == 0)
         {
            TextField(this._mc.getMC().tf_jingzhun1).htmlText = this.GetPerStr(param1.commander_AimPer);
            TextField(this._mc.getMC().tf_dianzi1).htmlText = this.GetPerStr(param1.commander_ElectronPer);
            TextField(this._mc.getMC().tf_sudu1).htmlText = this.GetPerStr(param1.commander_PriorityPer);
            TextField(this._mc.getMC().tf_guibi1).htmlText = this.GetPerStr(param1.commander_BlenchPer);
         }
         else
         {
            TextField(this._mc.getMC().tf_jingzhun1).text = "";
            TextField(this._mc.getMC().tf_dianzi1).text = "";
            TextField(this._mc.getMC().tf_sudu1).text = "";
            TextField(this._mc.getMC().tf_guibi1).text = "";
         }
         if(param1.commander_type > 1)
         {
            this._mc.getMC().mc_grade.gotoAndStop(param1.commander_cardLevel + 2);
         }
         else
         {
            this._mc.getMC().mc_grade.gotoAndStop(1);
         }
         var _loc6_:int = 0;
         while(_loc6_ < 8)
         {
            if(_loc6_ == 0)
            {
               this._mc.getMC().mc_txt0.gotoAndStop(param1.commander_commanderZJ.charAt(_loc6_));
            }
            else if(_loc6_ == 1)
            {
               this._mc.getMC().mc_txt1.gotoAndStop(param1.commander_commanderZJ.charAt(_loc6_));
            }
            else if(_loc6_ == 2)
            {
               this._mc.getMC().mc_txt2.gotoAndStop(param1.commander_commanderZJ.charAt(_loc6_));
            }
            else if(_loc6_ == 3)
            {
               this._mc.getMC().mc_txt3.gotoAndStop(param1.commander_commanderZJ.charAt(_loc6_));
            }
            else if(_loc6_ == 4)
            {
               this._mc.getMC().mc_txt4.gotoAndStop(param1.commander_commanderZJ.charAt(_loc6_));
            }
            else if(_loc6_ == 5)
            {
               this._mc.getMC().mc_txt5.gotoAndStop(param1.commander_commanderZJ.charAt(_loc6_));
            }
            else if(_loc6_ == 6)
            {
               this._mc.getMC().mc_txt6.gotoAndStop(param1.commander_commanderZJ.charAt(_loc6_));
            }
            else if(_loc6_ == 7)
            {
               this._mc.getMC().mc_txt7.gotoAndStop(param1.commander_commanderZJ.charAt(_loc6_));
            }
            _loc6_++;
         }
         if(param1.commander_Target < 7 && param1.commander_TargetInterval < 2)
         {
            TextField(this.ArmySceneUI.getMC().mc_combox1.tf_txt).text = this.m_targetIntervalAry[param1.commander_Target];
            TextField(this.ArmySceneUI.getMC().mc_combox0.tf_txt).text = this.m_targetAry[param1.commander_TargetInterval];
         }
         this.initGemScene();
         var _loc7_:GemInfo = new GemInfo();
         this.m_havegem = false;
         while(_loc8_ < param1.commander_StoneHole)
         {
            _loc9_ = this.GemSceneUI.getMC().getChildByName("mc_list" + _loc8_) as MovieClip;
            _loc9_.gotoAndStop(2);
            _loc9_.mouseChildren = false;
            _loc10_ = _loc9_.mc_base as MovieClip;
            if(param1.commander_Stone[_loc8_] != -1)
            {
               _loc9_.gotoAndStop(3);
               _loc9_.mouseChildren = false;
               this.m_havegem = true;
               _loc11_ = int(param1.commander_Stone[_loc8_]);
               _loc12_ = CPropsReader.getInstance().GetDiamond(_loc11_);
               _loc13_ = _loc12_.PropsInfo.ImageFileName;
               _loc14_ = new Bitmap(GameKernel.getTextureInstance(_loc13_));
               _loc10_.addChild(_loc14_);
               if(_loc12_.PropsInfo.List < 40)
               {
                  _loc7_ = this.inputText(_loc12_.GemKindID,_loc12_.GemValue,_loc7_);
               }
               else
               {
                  _loc15_ = 0;
                  while(_loc15_ < this.ParamList.length)
                  {
                     _loc16_ = this.ParamList[_loc15_];
                     if(Boolean(_loc12_.GemaValueList[_loc16_]) && _loc12_.GemaValueList[_loc16_] > 0)
                     {
                        _loc7_ = this.inputText(_loc15_ + 1,_loc12_.GemaValueList[_loc16_],_loc7_);
                     }
                     _loc15_++;
                  }
               }
            }
            _loc8_++;
         }
         if(CommanderRouter.instance.m_reSet == true)
         {
            CommanderRouter.instance.m_reSet = false;
            return;
         }
         this.initArmyShip();
         if(param1.commander_shipTeamId != -1)
         {
            if(this.m_commanderInfo.commander_state == 4)
            {
               this._fleetchange.setVisible(false);
            }
            else
            {
               this._fleetchange.setVisible(true);
            }
            this.showArmyShip(param1.commander_TeamBody);
         }
         else
         {
            this._fleetchange.setVisible(false);
         }
      }
      
      private function GetPerStr(param1:int) : String
      {
         return "<FONT COLOR=\'" + this.selectColor(param1) + "\'>" + String(param1 / 10) + "</FONT> ";
      }
      
      private function initGemScene() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         while(_loc1_ < 12)
         {
            _loc2_ = this.GemSceneUI.getMC().getChildByName("mc_list" + _loc1_) as MovieClip;
            _loc2_.gotoAndStop(1);
            _loc2_ = _loc2_.mc_base as MovieClip;
            if(_loc2_.numChildren > 0)
            {
               _loc2_.removeChildAt(0);
            }
            _loc1_++;
         }
         this._mc.getMC().tf_jingzhun0.text = "";
         this._mc.getMC().tf_guibi0.text = "";
         this._mc.getMC().tf_dianzi0.text = "";
         this._mc.getMC().tf_sudu0.text = "";
         this.GemSceneUI.getMC().tf_0.text = "";
         this.GemSceneUI.getMC().tf_1.text = "";
         this.GemSceneUI.getMC().tf_2.text = "";
         this.GemSceneUI.getMC().tf_3.text = "";
         this.GemSceneUI.getMC().tf_4.text = "";
         this.GemSceneUI.getMC().tf_5.text = "";
         this.GemSceneUI.getMC().tf_6.text = "";
         this.GemSceneUI.getMC().tf_7.text = "";
         this.GemSceneUI.getMC().tf_8.text = "";
         this.GemSceneUI.getMC().tf_9.text = "";
         this.GemSceneUI.getMC().tf_10.text = "";
         this.GemSceneUI.getMC().tf_11.text = "";
      }
      
      private function inputText(param1:int, param2:String, param3:GemInfo) : GemInfo
      {
         var _loc4_:int = 0;
         var _loc5_:Number = 0;
         switch(param1)
         {
            case 0:
               break;
            case 1:
               param3.Aim += int(param2);
               this.GemSceneUI.getMC().tf_0.text = "+" + String(param3.Aim);
               this._mc.getMC().tf_jingzhun0.text = "+" + String(param3.Aim);
               break;
            case 2:
               param3.Blench += int(param2);
               this.GemSceneUI.getMC().tf_1.text = "+" + String(param3.Blench);
               this._mc.getMC().tf_guibi0.text = "+" + String(param3.Blench);
               break;
            case 3:
               param3.Electron += int(param2);
               this.GemSceneUI.getMC().tf_2.text = "+" + String(param3.Electron);
               this._mc.getMC().tf_dianzi0.text = "+" + String(param3.Electron);
               break;
            case 4:
               param3.Priority += int(param2);
               this.GemSceneUI.getMC().tf_3.text = "+" + String(param3.Priority);
               this._mc.getMC().tf_sudu0.text = "+" + String(param3.Priority);
               break;
            case 5:
               param3.Assault += Number(param2);
               _loc5_ = param3.Assault * 1000 * 0.1;
               this.GemSceneUI.getMC().tf_4.text = "+" + _loc5_.toFixed(1) + "%";
               break;
            case 6:
               param3.Endure += Number(param2);
               _loc5_ = param3.Endure * 1000 * 0.1;
               this.GemSceneUI.getMC().tf_5.text = "+" + _loc5_.toFixed(1) + "%";
               break;
            case 7:
               param3.Shield += Number(param2);
               _loc5_ = param3.Shield * 1000 * 0.1;
               this.GemSceneUI.getMC().tf_6.text = "+" + _loc5_.toFixed(1) + "%";
               break;
            case 8:
               param3.BlastHurt += Number(param2);
               _loc5_ = param3.BlastHurt * 100;
               this.GemSceneUI.getMC().tf_7.text = "+" + _loc5_.toFixed(1) + "%";
               break;
            case 9:
               param3.Blast += Number(param2);
               _loc5_ = param3.Blast * 1000 * 0.1;
               this.GemSceneUI.getMC().tf_8.text = "+" + _loc5_.toFixed(1) + "%";
               break;
            case 10:
               param3.DoubleHit += Number(param2);
               _loc5_ = param3.DoubleHit * 1000 * 0.1;
               this.GemSceneUI.getMC().tf_9.text = "+" + _loc5_.toFixed(1) + "%";
               break;
            case 11:
               param3.RepairShield += Number(param2);
               _loc5_ = param3.RepairShield * 1000 * 0.1;
               this.GemSceneUI.getMC().tf_10.text = "+" + _loc5_.toFixed(1) + "%";
               break;
            case 12:
               param3.Exp += Number(param2);
               _loc5_ = param3.Exp * 1000 * 0.1;
               this.GemSceneUI.getMC().tf_11.text = "+" + _loc5_.toFixed(1) + "%";
               break;
            case 13:
               param3.Ballistic = param2;
               _loc4_ = int(this._mc.getMC().mc_txt0.currentFrame);
               if(this.getFrame(param3.Ballistic) > _loc4_)
               {
                  this._mc.getMC().mc_txt0.gotoAndStop(param3.Ballistic);
               }
               break;
            case 14:
               param3.Directional = param2;
               _loc4_ = int(this._mc.getMC().mc_txt1.currentFrame);
               if(this.getFrame(param3.Directional) > _loc4_)
               {
                  this._mc.getMC().mc_txt1.gotoAndStop(param3.Directional);
               }
               break;
            case 15:
               param3.Missile = param2;
               _loc4_ = int(this._mc.getMC().mc_txt2.currentFrame);
               if(this.getFrame(param3.Missile) > _loc4_)
               {
                  this._mc.getMC().mc_txt2.gotoAndStop(param3.Missile);
               }
               break;
            case 16:
               param3.Carrier = param2;
               _loc4_ = int(this._mc.getMC().mc_txt3.currentFrame);
               if(this.getFrame(param3.Carrier) > _loc4_)
               {
                  this._mc.getMC().mc_txt3.gotoAndStop(param3.Carrier);
               }
               break;
            case 17:
               param3.Defend = param2;
               _loc4_ = int(this._mc.getMC().mc_txt4.currentFrame);
               if(this.getFrame(param3.Defend) > _loc4_)
               {
                  this._mc.getMC().mc_txt4.gotoAndStop(param3.Defend);
               }
               break;
            case 18:
               param3.Frigate = param2;
               _loc4_ = int(this._mc.getMC().mc_txt5.currentFrame);
               if(this.getFrame(param3.Frigate) > _loc4_)
               {
                  this._mc.getMC().mc_txt5.gotoAndStop(param3.Frigate);
               }
               break;
            case 19:
               param3.Cruiser = param2;
               _loc4_ = int(this._mc.getMC().mc_txt6.currentFrame);
               if(this.getFrame(param3.Cruiser) > _loc4_)
               {
                  this._mc.getMC().mc_txt6.gotoAndStop(param3.Cruiser);
               }
               break;
            case 20:
               param3.BattleShip = param2;
               _loc4_ = int(this._mc.getMC().mc_txt7.currentFrame);
               if(this.getFrame(param3.BattleShip) > _loc4_)
               {
                  this._mc.getMC().mc_txt7.gotoAndStop(param3.BattleShip);
               }
         }
         return param3;
      }
      
      private function getFrame(param1:String) : int
      {
         switch(param1)
         {
            case "S":
               return 5;
            case "A":
               return 4;
            case "B":
               return 3;
            case "C":
               return 2;
            case "D":
               return 1;
            default:
               return 0;
         }
      }
      
      private function initArmyShip() : void
      {
         var _loc2_:MovieClip = null;
         var _loc1_:int = 0;
         while(_loc1_ < 9)
         {
            TextField(this._shipbaseAry[_loc1_].tf_num).text = "";
            _loc2_ = this._shipbaseAry[_loc1_].mc_base as MovieClip;
            this.m_teamshipbody.length = 0;
            if(_loc2_.numChildren > 0)
            {
               _loc2_.removeChildAt(0);
            }
            _loc1_++;
         }
      }
      
      private function showArmyShip(param1:Array) : void
      {
         var _loc4_:MovieClip = null;
         var _loc5_:ShipmodelInfo = null;
         var _loc6_:String = null;
         this.m_teamshipbody = param1;
         var _loc2_:FleetPropertyInfo = new FleetPropertyInfo();
         var _loc3_:int = 0;
         while(_loc3_ < 9)
         {
            if(param1[_loc3_].ShipModelId != -1 && param1[_loc3_].Num != 0)
            {
               _loc4_ = this._shipbaseAry[_loc3_].mc_base as MovieClip;
               _loc5_ = ShipmodelRouter.instance.ShipModeList.Get(param1[_loc3_].ShipModelId);
               _loc2_ = FleetProperty.getInstance().ShipProperty(_loc5_,param1[_loc3_].Num,_loc2_);
               _loc6_ = CShipmodelReader.getInstance().getShipBodyInfo(_loc5_.m_BodyId).SmallIcon;
               this.m_SelectedImg = FleetEditUI.getInstance().GetShipImage(_loc6_,25,25);
               TextField(this._shipbaseAry[_loc3_].tf_num).text = param1[_loc3_].Num;
               _loc4_.addChild(this.m_SelectedImg);
            }
            _loc3_++;
         }
         TextField(this.ArmySceneUI.getMC().tf_yidongli).text = String(_loc2_.Locomotivity);
         TextField(this.ArmySceneUI.getMC().tf_xueliang).text = String(_loc2_.Endure);
         TextField(this.ArmySceneUI.getMC().tf_cunchu).text = String(_loc2_.Storage);
         TextField(this.ArmySceneUI.getMC().tf_gongjili).text = String(_loc2_.MinAssault);
         TextField(this.ArmySceneUI.getMC().tf_jianchuan).text = String(_loc2_.ShipCount);
         _loc2_.SkeepCount = _loc2_.Storage / _loc2_.Supply;
         TextField(this.ArmySceneUI.getMC().tf_huihe).text = String(_loc2_.SkeepCount);
      }
      
      private function TeamShipMouseDown(param1:Event) : void
      {
         var _loc3_:Point = null;
         var _loc4_:ShipmodelInfo = null;
         var _loc5_:String = null;
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         this.m_SelectedCellId = int(_loc2_.name.substring(7));
         if(this.m_SelectedCellId >= 0)
         {
            if(this.m_teamshipbody.length == 0)
            {
               return;
            }
            if(this.m_teamshipbody[this.m_SelectedCellId].ShipModelId == -1)
            {
               return;
            }
            if(this.m_commanderInfo.commander_state == 4)
            {
            }
            _loc3_ = _loc2_.localToGlobal(new Point(19,19));
            _loc3_ = this._mc.getMC().globalToLocal(_loc3_);
            _loc4_ = ShipmodelRouter.instance.ShipModeList.Get(this.m_teamshipbody[this.m_SelectedCellId].ShipModelId);
            _loc5_ = CShipmodelReader.getInstance().getShipBodyInfo(_loc4_.m_BodyId).SmallIcon;
            this.m_SelectedImg = FleetEditUI.getInstance().GetShipImage(_loc5_);
            this._mc.getMC().addChild(this.m_SelectedImg);
            this.m_SelectedImg.addEventListener(MouseEvent.MOUSE_UP,this.SelectedTeamShipMouseUp);
            this.m_SelectedImg.startDrag(true);
         }
      }
      
      private function RemoveSelectedShip(param1:int) : void
      {
         var _loc2_:TextField = null;
         var _loc4_:ShipmodelInfo = null;
         var _loc5_:String = null;
         var _loc6_:MovieClip = null;
         if(this.m_ReplaceCellId < 0)
         {
            return;
         }
         if(this.m_teamshipbody[this.m_ReplaceCellId].ShipModelId == -1)
         {
            this.m_teamshipbody[this.m_ReplaceCellId].ShipModelId = this.m_teamshipbody[this.m_SelectedCellId].ShipModelId;
            this.m_teamshipbody[this.m_ReplaceCellId].Num = 0;
         }
         this.m_teamshipbody[this.m_ReplaceCellId].Num += param1;
         _loc2_ = this._shipbaseNumAry[this.m_ReplaceCellId] as TextField;
         _loc2_.text = this.m_teamshipbody[this.m_ReplaceCellId].Num;
         var _loc3_:MovieClip = this._shipbaseMigAry[this.m_ReplaceCellId];
         if(_loc3_.numChildren == 0)
         {
            _loc4_ = ShipmodelRouter.instance.ShipModeList.Get(this.m_teamshipbody[this.m_ReplaceCellId].ShipModelId);
            _loc5_ = CShipmodelReader.getInstance().getShipBodyInfo(_loc4_.m_BodyId).SmallIcon;
            this.m_SelectedImg = FleetEditUI.getInstance().GetShipImage(_loc5_,25,25);
            _loc3_.addChild(this.m_SelectedImg);
         }
         this.m_teamshipbody[this.m_SelectedCellId].Num -= param1;
         if(this.m_teamshipbody[this.m_SelectedCellId].Num <= 0)
         {
            this.m_teamshipbody[this.m_SelectedCellId].Num = 0;
            _loc6_ = this._shipbaseMigAry[this.m_SelectedCellId] as MovieClip;
            if(_loc6_.numChildren > 0)
            {
               _loc6_.removeChildAt(0);
            }
            _loc2_ = this._shipbaseNumAry[this.m_SelectedCellId] as TextField;
            _loc2_.text = "";
            this.m_teamshipbody[this.m_SelectedCellId].ShipModelId = -1;
         }
         else
         {
            _loc2_ = this._shipbaseNumAry[this.m_SelectedCellId] as TextField;
            _loc2_.text = this.m_teamshipbody[this.m_SelectedCellId].Num.toString();
         }
      }
      
      private function ReplaceSelectedShip() : void
      {
         var _loc7_:TextField = null;
         var _loc1_:int = int(this.m_teamshipbody[this.m_ReplaceCellId].ShipModelId);
         var _loc2_:int = int(this.m_teamshipbody[this.m_ReplaceCellId].Num);
         this.m_teamshipbody[this.m_ReplaceCellId].ShipModelId = this.m_teamshipbody[this.m_SelectedCellId].ShipModelId;
         this.m_teamshipbody[this.m_ReplaceCellId].Num = this.m_teamshipbody[this.m_SelectedCellId].Num;
         this.m_teamshipbody[this.m_SelectedCellId].ShipModelId = _loc1_;
         this.m_teamshipbody[this.m_SelectedCellId].Num = _loc2_;
         var _loc3_:MovieClip = this._shipbaseMigAry[this.m_ReplaceCellId];
         var _loc4_:MovieClip = _loc3_.getChildAt(0) as MovieClip;
         _loc3_.removeChildAt(0);
         var _loc5_:MovieClip = this._shipbaseMigAry[this.m_SelectedCellId];
         var _loc6_:MovieClip = _loc5_.getChildAt(0) as MovieClip;
         _loc5_.removeChildAt(0);
         _loc3_.addChild(_loc6_);
         _loc5_.addChild(_loc4_);
         _loc7_ = this._shipbaseNumAry[this.m_SelectedCellId] as TextField;
         _loc7_.text = this.m_teamshipbody[this.m_SelectedCellId].Num;
         _loc7_ = this._shipbaseNumAry[this.m_ReplaceCellId] as TextField;
         _loc7_.text = this.m_teamshipbody[this.m_ReplaceCellId].Num;
      }
      
      private function SelectedTeamShipMouseUp(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:ShipmodelInfo = null;
         var _loc6_:ShipbodyInfo = null;
         this.m_SelectedImg.stopDrag();
         this.m_ReplaceCellId = this.GetSelectedIndex(param1);
         this._mc.getMC().removeChild(this.m_SelectedImg);
         if(this.m_ReplaceCellId == this.m_SelectedCellId)
         {
            return;
         }
         var _loc2_:int = int(this.m_teamshipbody[this.m_SelectedCellId].Num);
         if(this.m_ReplaceCellId != -1)
         {
            _loc3_ = int(this.m_teamshipbody[this.m_ReplaceCellId].Num);
            _loc4_ = int(this.m_teamshipbody[this.m_SelectedCellId].ShipModelId);
            if(this.m_teamshipbody[this.m_ReplaceCellId].ShipModelId == -1 || this.m_teamshipbody[this.m_ReplaceCellId].ShipModelId == _loc4_)
            {
               _loc4_ = int(this.m_teamshipbody[this.m_SelectedCellId].ShipModelId);
               _loc5_ = ShipmodelRouter.instance.ShipModeList.Get(_loc4_);
               if(_loc5_ != null)
               {
                  _loc6_ = CShipmodelReader.getInstance().getShipBodyInfo(_loc5_.m_BodyId);
                  if(_loc6_.KindId == 5)
                  {
                     MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss59"),0);
                     return;
                  }
               }
               if(_loc2_ > MsgTypes.MAX_MATRIXSHIP - _loc3_)
               {
                  _loc2_ = MsgTypes.MAX_MATRIXSHIP - _loc3_;
                  if(_loc2_ == 0)
                  {
                     return;
                  }
               }
               this.ShowEnterShipNumForm(this.RemoveSelectedShip,_loc2_);
            }
            else
            {
               this.ReplaceSelectedShip();
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
            if(this.m_teamshipbody[_loc1_].ShipModelId != -1)
            {
               _loc2_ = int(this.m_teamshipbody[_loc1_].ShipModelId);
               _loc3_ = ShipmodelRouter.instance.ShipModeList.Get(_loc2_);
               if(_loc3_ != null)
               {
                  _loc4_ = CShipmodelReader.getInstance().getShipBodyInfo(_loc3_.m_BodyId);
                  if(_loc4_.KindId == 5 && _loc1_ != this.m_SelectedCellId)
                  {
                     return true;
                  }
               }
            }
            _loc1_++;
         }
         return false;
      }
      
      private function ShowEnterShipNumForm(param1:Function, param2:int) : void
      {
         FleetNumUI.getInstance().Show(this._mc.getMC(),param2,param1);
      }
      
      private function GetSelectedIndex(param1:MouseEvent) : int
      {
         var _loc6_:MovieClip = null;
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         var _loc3_:Point = _loc2_.localToGlobal(new Point(param1.localX,param1.localX));
         var _loc4_:MovieClip = this.ArmySceneUI.getMC().getChildByName("mc_grid") as MovieClip;
         _loc3_ = _loc4_.globalToLocal(_loc3_);
         var _loc5_:int = 0;
         for each(_loc6_ in this._shipbaseAry)
         {
            if(_loc3_.x >= _loc6_.x && _loc3_.x <= _loc6_.x + 40 && _loc3_.y >= _loc6_.y && _loc3_.y <= _loc6_.y + 40)
            {
               return _loc5_;
            }
            _loc5_++;
         }
         return -1;
      }
      
      private function chickButton(param1:Event) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = false;
         if(param1.currentTarget.name == "btn_close")
         {
            this.IsInCommanderUI = false;
            GameKernel.popUpDisplayManager.Hide(instance);
         }
         else if(param1.currentTarget.name == "btn_hireadmiral")
         {
            if(CommanderRouter.instance.m_commandInfoAry.length < this.MAXCOMMANDER && GamePlayer.getInstance().PropsPack - ScienceSystem.getinstance().Packarr.length > 0)
            {
               if(CommanderRouter.instance.NextInviteTime < 0)
               {
                  return;
               }
               CommanderRouter.instance.m_AnimationCard = true;
               CommanderRouter.instance.onSendMsgCreateCommander(0);
            }
            else if(CommanderRouter.instance.m_commandInfoAry.length >= this.MAXCOMMANDER)
            {
               this.addBackMC();
               ConstructionOperationWidget.currenCmd = OperationEnum.OPERATION_TYPE_NOINTOCOMMANDER;
               MallBuyModulesPopup.getInstance().Init();
               MallBuyModulesPopup.getInstance().Show();
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
         else if(param1.currentTarget.name == "btn_fire")
         {
            if(CommanderRouter.instance.m_commandInfoAry.length == 0)
            {
               return;
            }
            _loc2_ = CommanderRouter.instance.m_commandInfoAry[this.m_choosenum].ChipList;
            if(_loc2_ != null && _loc2_.length > 0)
            {
               _loc3_ = 0;
               while(_loc3_ < _loc2_.length)
               {
                  if(_loc2_[_loc3_] > 0)
                  {
                     MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss84"),0);
                     return;
                  }
                  _loc3_++;
               }
            }
            if(CommanderRouter.instance.m_commandInfoAry[this.m_choosenum].commander_shipTeamId == -1 && CommanderRouter.instance.m_commandInfoAry[this.m_choosenum].commander_type != 0 && CommanderRouter.instance.m_commandInfoAry[this.m_choosenum].commander_state != 3)
            {
               if(this.m_havegem == true)
               {
                  CEffectText.getInstance().showEffectText(GameKernel.renderManager.getUI().getContainer(),StringManager.getInstance().getMessageString("CommanderText93"));
                  return;
               }
               this.addBackMC();
               ConstructionOperationWidget.currenCmd = OperationEnum.OPERATION_TYPE_FIRECOMMANDER;
               UpgradeModulesPopUp.getInstance().getCommanderName(CommanderRouter.instance.m_commandInfoAry[this.m_choosenum].commander_name);
               UpgradeModulesPopUp.getInstance().Init();
               UpgradeModulesPopUp.getInstance().Show();
            }
            else
            {
               CEffectText.getInstance().showEffectText(GameKernel.renderManager.getUI().getContainer(),StringManager.getInstance().getMessageString("CommanderText103"));
            }
         }
         else if(param1.currentTarget.name == "btn_speedhire")
         {
            if(GamePlayer.getInstance().cash >= GamePlayer.getInstance().Commander_Credit && GamePlayer.getInstance().PropsPack - ScienceSystem.getinstance().Packarr.length > 0)
            {
               if(CommanderRouter.instance.m_commandInfoAry.length < this.MAXCOMMANDER)
               {
                  ConstructionAction.getInstance().costResource(0,0,0,GamePlayer.getInstance().Commander_Credit);
                  CommanderRouter.instance.m_AnimationCard = true;
                  CommanderRouter.instance.onSendMsgCreateCommander(1);
               }
               else
               {
                  this.addBackMC();
                  ConstructionOperationWidget.currenCmd = OperationEnum.OPERATION_TYPE_NOINTOCOMMANDER;
                  MallBuyModulesPopup.getInstance().Init();
                  MallBuyModulesPopup.getInstance().Show();
               }
            }
            else if(GamePlayer.getInstance().cash < GamePlayer.getInstance().Commander_Credit)
            {
               ConstructionOperationWidget.currenCmd = OperationEnum.OPERATION_TYPE_NOCASH;
               PrepaidModulePopup.getInstance().setString("commandercard");
               PrepaidModulePopup.getInstance().Init();
               PrepaidModulePopup.getInstance().setParent(this);
               PrepaidModulePopup.getInstance().Show();
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
         else if(param1.currentTarget.name == "btn_voucher")
         {
            this.m_time.stop();
            GameKernel.popUpDisplayManager.Hide(instance);
            CommandercardSceneUI.getinstance().Init();
            CommandercardSceneUI.getinstance()._CardNum = 0;
            CommandercardSceneUI.getinstance().InitPopUp();
            GameKernel.popUpDisplayManager.Show(CommandercardSceneUI.getinstance());
         }
         else if(param1.currentTarget.name == "btn_up")
         {
            if(this.m_pagenum > 0)
            {
               --this.m_pagenum;
               this.showCommanderList();
               this.Highlight(0);
               CommanderRouter.instance.onSendMsgCommander(CommanderRouter.instance.m_commandInfoAry[this.m_pagenum * SHOWCOMMANDERNUM].commander_commanderId);
            }
         }
         else if(param1.currentTarget.name == "btn_down")
         {
            if((this.m_pagenum + 1) * SHOWCOMMANDERNUM < CommanderRouter.instance.m_commandInfoAry.length)
            {
               ++this.m_pagenum;
               this.Highlight(0);
               this.showCommanderList();
               CommanderRouter.instance.onSendMsgCommander(CommanderRouter.instance.m_commandInfoAry[this.m_pagenum * SHOWCOMMANDERNUM].commander_commanderId);
            }
         }
         else if(param1.currentTarget.name == "btn_friend")
         {
            if(this.m_commanderInfo == null)
            {
               return;
            }
            _loc2_ = this.m_commanderInfo.ChipList;
            if(_loc2_ != null && _loc2_.length > 0)
            {
               _loc3_ = 0;
               while(_loc3_ < _loc2_.length)
               {
                  if(_loc2_[_loc3_] > 0)
                  {
                     MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss85"),0);
                     return;
                  }
                  _loc3_++;
               }
            }
            if(this.m_commanderInfo.commander_skill == -1)
            {
               this.addBackMC();
               ConstructionOperationWidget.currenCmd = OperationEnum.OPERATION_TYPE_CANNOTCARD;
               MallBuyModulesPopup.getInstance().Init();
               MallBuyModulesPopup.getInstance().Show();
               return;
            }
            if(this.m_commanderInfo.commander_shipTeamId != -1 || this.m_havegem == true)
            {
               this.addBackMC();
               ConstructionOperationWidget.currenCmd = OperationEnum.OPERATION_TYPE_CONDITIONSCHANGECARD;
               MallBuyModulesPopup.getInstance().Init();
               MallBuyModulesPopup.getInstance().Show();
               return;
            }
            if(GamePlayer.getInstance().PropsPack - ScienceSystem.getinstance().Packarr.length <= 0)
            {
               this.addBackMC();
               ConstructionOperationWidget.currenCmd = OperationEnum.OPERATION_TYPE_BAGNOINTO;
               MallBuyModulesPopup.getInstance().Init();
               MallBuyModulesPopup.getInstance().Show();
               return;
            }
            this.addBackMC();
            ConstructionOperationWidget.currenCmd = OperationEnum.OPERATION_TYPE_CHANGECARD;
            UpgradeModulesPopUp.getInstance().getCommanderName(this.m_commanderInfo.commander_name);
            UpgradeModulesPopUp.getInstance().Init();
            UpgradeModulesPopUp.getInstance().Show();
         }
         else if(param1.currentTarget.name != "btn_headpic")
         {
            if(param1.currentTarget.name == "btn_treasure")
            {
               if(this._container.contains(this.ArmySceneUI.getMC()) != false)
               {
                  this._container.removeChild(this.ArmySceneUI.getMC());
               }
               this._container.addChild(this.Commandercard.getMC());
               _loc4_ = this.Commandercard.getMC().mc_grade;
               _loc4_.gotoAndStop(3);
            }
            else if(param1.currentTarget.name == "btn_batchfire")
            {
               this.addBackMC();
               ConstructionOperationWidget.currenCmd = OperationEnum.OPERATION_TYPE_BATCHFIRE;
               UpgradeModulesPopUp.getInstance().Init();
               UpgradeModulesPopUp.getInstance().Show();
            }
            else if(param1.currentTarget.name == "btn_fleetchange")
            {
               if(this.m_teamshipbody.length > 0)
               {
                  CommanderRouter.instance.onSendMsgShipTeam(CommanderRouter.instance.m_commandInfoAry[this.m_choosenum].commander_shipTeamId,this._TargetInterval,this._Target,this.m_teamshipbody);
               }
            }
            else if(param1.currentTarget.name == "btn_alive")
            {
               _loc5_ = false;
               _loc5_ = UpdateResource.getInstance().pdHd(903);
               if(_loc5_ == true)
               {
                  CommanderRouter.instance.onSendMsgRELIVECOMMANDER(CommanderRouter.instance.m_commandInfoAry[this.m_choosenum].commander_commanderId);
               }
               else
               {
                  this.addBackMC();
                  StateHandlingUI.getInstance().Init();
                  StateHandlingUI.getInstance().setParent("CommanderSceneUI");
                  StateHandlingUI.getInstance().getstate(903);
                  StateHandlingUI.getInstance().InitPopUp();
                  GameKernel.popUpDisplayManager.Show(StateHandlingUI.getInstance());
               }
            }
            else if(param1.currentTarget.name == "btn_cure")
            {
               _loc6_ = false;
               _loc6_ = UpdateResource.getInstance().pdHd(904);
               if(_loc6_ == true)
               {
                  CommanderRouter.instance.onSendMsgRESUMECOMMANDER(CommanderRouter.instance.m_commandInfoAry[this.m_choosenum].commander_commanderId);
               }
               else
               {
                  this.addBackMC();
                  StateHandlingUI.getInstance().Init();
                  StateHandlingUI.getInstance().setParent("CommanderSceneUI");
                  StateHandlingUI.getInstance().getstate(904);
                  StateHandlingUI.getInstance().InitPopUp();
                  GameKernel.popUpDisplayManager.Show(StateHandlingUI.getInstance());
               }
            }
            else if(param1.currentTarget.name == "btn_autofire")
            {
               if(this.m_Activation == 0)
               {
                  this.m_Activation = 1;
                  this._autofire.gotoAndStop("up");
               }
               else
               {
                  this.m_Activation = 0;
                  this._autofire.gotoAndStop("disabled");
               }
               this._mc.getMC().removeChild(Suspension.getInstance());
               Suspension.getInstance().delinstance();
               Suspension.getInstance();
               Suspension.getInstance().Init(100,40,1);
               Suspension.getInstance().setLocationXY(param1.target.x,param1.target.y + param1.target.height);
               Suspension.getInstance().putRectOnlyOne(0,StringManager.getInstance().getMessageString("CommanderText14"));
               if(this.m_Activation == 0)
               {
                  Suspension.getInstance().putRectOnlyOne(1,StringManager.getInstance().getMessageString("CommanderText15"));
               }
               else
               {
                  Suspension.getInstance().putRectOnlyOne(1,StringManager.getInstance().getMessageString("CommanderText16"));
               }
               this._mc.getMC().addChild(Suspension.getInstance());
            }
            else if(param1.currentTarget.name == "btn_enterbag")
            {
               this.m_time.stop();
               GameKernel.popUpDisplayManager.Hide(instance);
               PackUi.getInstance().Init();
               GameKernel.popUpDisplayManager.Show(PackUi.getInstance());
            }
            else if(param1.currentTarget.name == "btn_compose")
            {
               if(ConstructionAction.getInstance().getCompositionCenter() == -1)
               {
                  this.addBackMC();
                  ConstructionOperationWidget.currenCmd = OperationEnum.OPERATION_TYPE_CARDNOINTO;
                  MallBuyModulesPopup.getInstance().Init();
                  MallBuyModulesPopup.getInstance().Show();
                  return;
               }
               this.m_time.stop();
               GameKernel.popUpDisplayManager.Hide(instance);
               ComposeUI.getInstance().Init();
               GameKernel.popUpDisplayManager.Show(ComposeUI.getInstance());
            }
            else if(param1.currentTarget.name == "btn_planbar")
            {
               if(this.m_commanderInfo.commander_state == 0 && this.m_havegem == false)
               {
                  this.addBackMC();
                  ConstructionOperationWidget.currenCmd = OperationEnum.OPERATION_TYPE_XIDIAN;
                  UpgradeModulesPopUp.getInstance().Init();
                  UpgradeModulesPopUp.getInstance().Show();
               }
               else
               {
                  this.addBackMC();
                  ConstructionOperationWidget.currenCmd = OperationEnum.OPERATION_TYPE_NOXIDIAN;
                  MallBuyModulesPopup.getInstance().Init();
                  MallBuyModulesPopup.getInstance().Show();
               }
            }
            else if(param1.currentTarget.name == "btn_gem")
            {
               if(this._container.contains(this.ArmySceneUI.getMC()) == true)
               {
                  this._container.removeChild(this.ArmySceneUI.getMC());
                  this._container.addChild(this.GemSceneUI.getMC());
               }
            }
            else if(param1.currentTarget.name == "btn_army")
            {
               if(this._container.contains(this.GemSceneUI.getMC()) == true)
               {
                  this._container.removeChild(this.GemSceneUI.getMC());
                  this._container.addChild(this.ArmySceneUI.getMC());
               }
            }
         }
      }
      
      public function Clickbatchfire() : void
      {
         var _loc4_:CommanderInfo = null;
         var _loc1_:Array = new Array();
         var _loc2_:int = 0;
         while(_loc2_ < CommanderRouter.instance.m_commandInfoAry.length)
         {
            _loc4_ = CommanderRouter.instance.m_commandInfoAry[_loc2_] as CommanderInfo;
            if(_loc4_.commander_shipTeamId == -1 && _loc4_.commander_type == 1 && _loc4_.commander_level == 0)
            {
               _loc1_.push(_loc4_);
            }
            _loc2_++;
         }
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.length)
         {
            CommanderRouter.instance.onSendMsgDeleteCommander(_loc1_[_loc3_].commander_commanderId);
            _loc3_++;
         }
      }
      
      public function deleteCommaner(param1:int) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < CommanderRouter.instance.m_commandInfoAry.length)
         {
            if(param1 == CommanderRouter.instance.m_commandInfoAry[_loc2_].commander_commanderId)
            {
               CommanderRouter.instance.m_commandInfoAry.splice(_loc2_,1);
               CommanderRouter.instance.m_commanderStateAry.splice(_loc2_,1);
               this.m_pagenum = 0;
               this.showCommanderList();
               if(CommanderRouter.instance.m_commandInfoAry.length > 0)
               {
                  CommanderRouter.instance.onSendMsgCommander(CommanderRouter.instance.m_commandInfoAry[0].commander_commanderId);
                  this.Highlight(0);
               }
               else
               {
                  this.InitCommanderinfo();
               }
               return;
            }
            _loc2_++;
         }
      }
      
      public function ChangeCard() : void
      {
         this.addBackMC();
         StateHandlingUI.getInstance().Init();
         StateHandlingUI.getInstance().setParent("CommanderSceneUI");
         StateHandlingUI.getInstance().getstate(926);
         StateHandlingUI.getInstance().InitPopUp();
         GameKernel.popUpDisplayManager.Show(StateHandlingUI.getInstance());
      }
      
      public function SubCommander() : void
      {
      }
      
      public function callback() : void
      {
         CommanderRouter.instance.onSendMsgDeleteCommander(CommanderRouter.instance.m_commandInfoAry[this.m_choosenum].commander_commanderId);
         CommanderRouter.instance.m_commandInfoAry.splice(this.m_choosenum,1);
         CommanderRouter.instance.m_commanderStateAry.splice(this.m_choosenum,1);
         this.m_commanderInfo = null;
         this.m_pagenum = 0;
         this.showCommanderList();
         if(CommanderRouter.instance.m_commandInfoAry.length > 0)
         {
            CommanderRouter.instance.onSendMsgCommander(CommanderRouter.instance.m_commandInfoAry[0].commander_commanderId);
            this.Highlight(0);
         }
         else
         {
            this.InitCommanderinfo();
         }
      }
      
      public function showtext(param1:String) : void
      {
         RadioUI.getInstance().Show(this._mc.getMC(),param1);
      }
      
      private function choose(param1:Event) : void
      {
         var _loc2_:String = param1.currentTarget.name;
         _loc2_ = _loc2_.substring(7);
         var _loc3_:int = int(_loc2_);
         this.Highlight(_loc3_);
      }
      
      public function Highlight(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(this.m_choosenum != param1)
         {
            _loc2_ = 0;
            while(_loc2_ < SHOWCOMMANDERNUM)
            {
               this.mcairshiplistAry[_loc2_].gotoAndStop("up");
               _loc2_++;
            }
            _loc3_ = this.m_pagenum * SHOWCOMMANDERNUM;
            _loc4_ = 0;
            while(_loc3_ < CommanderRouter.instance.m_commandInfoAry.length && _loc4_ < SHOWCOMMANDERNUM)
            {
               if(CommanderRouter.instance.m_commanderStateAry[_loc3_] == 1)
               {
                  MovieClip(this.mcairshiplistAry[_loc4_]).gotoAndStop(2);
               }
               else if(CommanderRouter.instance.m_commanderStateAry[_loc3_] == 2)
               {
                  MovieClip(this.mcairshiplistAry[_loc4_]).gotoAndStop(3);
               }
               else
               {
                  MovieClip(this.mcairshiplistAry[_loc4_]).gotoAndStop(1);
               }
               _loc4_++;
               _loc3_++;
            }
            if(this.m_pagenum * SHOWCOMMANDERNUM + param1 >= CommanderRouter.instance.m_commandInfoAry.length)
            {
               if(CommanderRouter.instance.m_commanderStateAry[this.m_choosenum] == 1)
               {
                  this.mcairshiplistAry[this.m_choosenum % SHOWCOMMANDERNUM].gotoAndStop(5);
               }
               else if(CommanderRouter.instance.m_commanderStateAry[this.m_choosenum] == 2)
               {
                  this.mcairshiplistAry[this.m_choosenum % SHOWCOMMANDERNUM].gotoAndStop(6);
               }
               else
               {
                  this.mcairshiplistAry[this.m_choosenum % SHOWCOMMANDERNUM].gotoAndStop("selected");
               }
            }
         }
         this.InitCommanderinfo();
         if(this.m_pagenum * SHOWCOMMANDERNUM + param1 < CommanderRouter.instance.m_commandInfoAry.length)
         {
            if(param1 < 0)
            {
               param1 = 0;
            }
            if(CommanderRouter.instance.m_commanderStateAry[this.m_pagenum * SHOWCOMMANDERNUM + param1] == 1)
            {
               this.mcairshiplistAry[param1].gotoAndStop(5);
            }
            else if(CommanderRouter.instance.m_commanderStateAry[this.m_pagenum * SHOWCOMMANDERNUM + param1] == 2)
            {
               this.mcairshiplistAry[param1].gotoAndStop(6);
            }
            else
            {
               this.mcairshiplistAry[param1].gotoAndStop("selected");
            }
            param1 = this.m_pagenum * SHOWCOMMANDERNUM + param1;
            this.m_choosenum = param1;
            if(CommanderRouter.instance.m_commandInfoAry[param1] != null)
            {
               this.m_choosePartNum = param1;
               this.initArmyShip();
               CommanderRouter.instance.onSendMsgCommander(CommanderRouter.instance.m_commandInfoAry[param1].commander_commanderId);
            }
         }
      }
      
      private function overtext(param1:Event) : void
      {
         var _loc4_:MovieClip = null;
         var _loc5_:Point = null;
         var _loc6_:int = 0;
         var _loc7_:TextField = null;
         var _loc8_:MovieClip = null;
         var _loc9_:Point = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:String = null;
         var _loc14_:String = null;
         var _loc2_:TextField = new TextField();
         if(CommanderRouter.instance.m_commandInfoAry.length == 0)
         {
            return;
         }
         var _loc3_:String = CCommanderReader.getInstance().getCommanderDescription(this.m_commanderInfo.commander_skill);
         if(_loc3_ == "")
         {
            _loc3_ = "    " + StringManager.getInstance().getMessageString("CommanderText44");
            _loc2_.text = _loc3_;
            _loc2_.width = _loc2_.textWidth;
            Suspension.getInstance();
            Suspension.getInstance().Init(_loc2_.width + 10,20,1);
            _loc4_ = param1.currentTarget as MovieClip;
            _loc5_ = _loc4_.localToGlobal(new Point(0,0));
            _loc5_ = this._mc.getMC().globalToLocal(_loc5_);
            Suspension.getInstance().setLocationXY(_loc5_.x + 30,_loc5_.y + 30);
            Suspension.getInstance().putRectOnlyOne(0,_loc2_.text,_loc2_.width + 10);
         }
         else
         {
            _loc2_.text = _loc3_;
            _loc2_.wordWrap = true;
            _loc2_.autoSize = TextFieldAutoSize.LEFT;
            _loc6_ = _loc2_.width;
            _loc2_.multiline = true;
            _loc2_.width = 230;
            _loc7_ = new TextField();
            _loc7_.multiline = true;
            _loc7_.wordWrap = true;
            _loc7_.autoSize = TextFieldAutoSize.LEFT;
            _loc7_.htmlText = StringManager.getInstance().getMessageString("CommanderText126");
            _loc7_.width = _loc2_.width;
            Suspension.getInstance();
            Suspension.getInstance().Init(_loc2_.width,_loc2_.height + 40 + _loc7_.height,1);
            _loc8_ = param1.currentTarget as MovieClip;
            _loc9_ = _loc8_.localToGlobal(new Point(0,0));
            _loc9_ = this._mc.getMC().globalToLocal(_loc9_);
            Suspension.getInstance().setLocationXY(_loc9_.x + 30,_loc9_.y + 25);
            _loc10_ = int(CommanderRouter.instance.m_commandInfoAry[this.m_choosePartNum].commander_type);
            _loc11_ = CCommanderReader.getInstance().getCommanderCommanderType(CommanderRouter.instance.m_commandInfoAry[this.m_choosePartNum].commander_skill);
            _loc12_ = 80 + this.m_commanderInfo.commander_cardLevel + 1;
            _loc13_ = String("CommanderText" + _loc12_);
            _loc14_ = "    " + StringManager.getInstance().getMessageString(_loc13_);
            Suspension.getInstance().putRect(0,"    " + this.m_commanderTypeAry[_loc10_],this.m_commanderCommanderTypeAry[_loc11_],16777215,16777215,110,120);
            Suspension.getInstance().putRectOnlyOne(1,_loc14_,115,20);
            Suspension.getInstance().putRectOnlyOne(2,"    " + _loc2_.text,_loc2_.width,_loc2_.height);
            Suspension.getInstance().putRectOnlyOne2(_loc2_.height + 40,StringManager.getInstance().getMessageString("CommanderText126"),_loc2_.width,_loc7_.height);
         }
         BleakingLineForThai.GetInstance().BleakThaiLanguage(_loc2_);
         this._mc.getMC().addChild(Suspension.getInstance());
      }
      
      private function outtext(param1:Event) : void
      {
         if(CommanderRouter.instance.m_commandInfoAry.length == 0)
         {
            return;
         }
         this._mc.getMC().removeChild(Suspension.getInstance());
         Suspension.getInstance().delinstance();
      }
      
      private function overGemPic(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc4_:MovieClip = null;
         var _loc5_:int = 0;
         _loc2_ = param1.target.name;
         var _loc3_:int = int(_loc2_.search("_"));
         _loc2_ = _loc2_.slice(0,_loc3_);
         switch(_loc2_)
         {
            case "mc":
               _loc4_ = param1.target as MovieClip;
               _loc2_ = param1.target.name.substring(7);
               _loc4_.addEventListener(MouseEvent.MOUSE_OUT,this.outGemPic,false,1,true);
               if(int(_loc2_) >= this.m_commanderInfo.commander_StoneHole)
               {
                  this.showgemKuangtext(int(_loc2_),_loc4_);
                  return;
               }
               _loc5_ = int(this.m_commanderInfo.commander_Stone[int(_loc2_)]);
               if(_loc5_ == -1)
               {
                  this.showgemCKuangtext(int(_loc2_),_loc4_);
                  return;
               }
               this.showgemtext(_loc5_,_loc4_);
               break;
            case "pic":
               _loc4_ = param1.target as MovieClip;
               _loc4_.addEventListener(MouseEvent.MOUSE_OUT,this.outGemPic,false,1,true);
               _loc2_ = param1.target.name.substring(4);
               this.showpictext(int(_loc2_),_loc4_);
               break;
            case "tf":
         }
      }
      
      private function outGemPic(param1:Event) : void
      {
         this._mc.getMC().removeChild(Suspension.getInstance());
         Suspension.getInstance().delinstance();
         param1.target.removeEventListener(MouseEvent.MOUSE_OUT,this.outGemPic);
      }
      
      private function showgemKuangtext(param1:int, param2:MovieClip) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         _loc5_ = 148 + param1;
         _loc3_ = "CorpsText" + String(_loc5_);
         _loc3_ = StringManager.getInstance().getMessageString(_loc3_);
         var _loc6_:TextField = new TextField();
         _loc6_.textColor = 16777215;
         _loc6_.htmlText = _loc3_;
         _loc6_.autoSize = TextFieldAutoSize.LEFT;
         Suspension.getInstance();
         Suspension.getInstance().Init(_loc6_.width + 5,_loc6_.height,1);
         var _loc7_:Point = param2.localToGlobal(new Point(0,0));
         _loc7_ = this._mc.getMC().globalToLocal(_loc7_);
         Suspension.getInstance().setLocationXY(_loc7_.x + 25,_loc7_.y + 25);
         Suspension.getInstance().putRectOnlyOne(0,_loc3_,_loc6_.width + 5,20);
         this._mc.getMC().addChild(Suspension.getInstance());
      }
      
      private function showgemCKuangtext(param1:int, param2:MovieClip) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         _loc5_ = param1 % 4;
         _loc5_ = 160 + _loc5_;
         _loc3_ = "CorpsText" + String(_loc5_);
         _loc3_ = StringManager.getInstance().getMessageString(_loc3_);
         var _loc6_:TextField = new TextField();
         _loc6_.textColor = 16777215;
         _loc6_.htmlText = _loc3_;
         _loc6_.wordWrap = true;
         _loc6_.autoSize = TextFieldAutoSize.LEFT;
         _loc6_.multiline = true;
         Suspension.getInstance();
         if(_loc6_.textWidth + 5 > 100)
         {
            _loc6_.width = 100;
         }
         else
         {
            _loc6_.width = _loc6_.textWidth + 5;
         }
         Suspension.getInstance().Init(_loc6_.width + 5,_loc6_.height,1);
         var _loc7_:Point = param2.localToGlobal(new Point(0,0));
         _loc7_ = this._mc.getMC().globalToLocal(_loc7_);
         Suspension.getInstance().setLocationXY(_loc7_.x + 25,_loc7_.y + 25);
         Suspension.getInstance().putRectOnlyOne(0,_loc3_,_loc6_.width + 5,_loc6_.height);
         this._mc.getMC().addChild(Suspension.getInstance());
      }
      
      private function showgemtext(param1:int, param2:MovieClip) : void
      {
         var _loc3_:TextField = new TextField();
         var _loc4_:propsInfo = CPropsReader.getInstance().GetPropsInfo(param1);
         _loc3_.textColor = 16777215;
         _loc3_.htmlText = _loc4_.Comment;
         _loc3_.wordWrap = true;
         _loc3_.autoSize = TextFieldAutoSize.LEFT;
         _loc3_.multiline = true;
         Suspension.getInstance();
         if(_loc3_.textWidth + 5 > 100)
         {
            _loc3_.width = 100;
         }
         else
         {
            _loc3_.width = _loc3_.textWidth + 5;
         }
         Suspension.getInstance().Init(_loc3_.width + 5,_loc3_.height + 20,1);
         var _loc5_:Point = param2.localToGlobal(new Point(0,0));
         _loc5_ = this._mc.getMC().globalToLocal(_loc5_);
         Suspension.getInstance().setLocationXY(_loc5_.x + 25,_loc5_.y + 25);
         Suspension.getInstance().putRectOnlyOne(0,_loc4_.Name,_loc3_.width + 5,20);
         Suspension.getInstance().putRectOnlyOne(1,_loc3_.htmlText,_loc3_.width + 5,_loc3_.height);
         this._mc.getMC().addChild(Suspension.getInstance());
      }
      
      private function showpictext(param1:int, param2:MovieClip) : void
      {
         var _loc3_:TextField = new TextField();
         param1 = 134 + param1;
         var _loc4_:String = "CorpsText" + String(param1);
         _loc3_.text = StringManager.getInstance().getMessageString(_loc4_);
         _loc3_.wordWrap = true;
         _loc3_.autoSize = TextFieldAutoSize.LEFT;
         _loc3_.multiline = true;
         Suspension.getInstance();
         if(_loc3_.textWidth + 5 > 100)
         {
            _loc3_.width = 100;
         }
         else
         {
            _loc3_.width = _loc3_.textWidth + 5;
         }
         Suspension.getInstance().Init(_loc3_.width + 5,_loc3_.height,1);
         var _loc5_:Point = param2.localToGlobal(new Point(0,0));
         _loc5_ = this._mc.getMC().globalToLocal(_loc5_);
         Suspension.getInstance().setLocationXY(_loc5_.x,_loc5_.y + 20);
         var _loc6_:int = 0;
         while(_loc6_ < 1)
         {
            Suspension.getInstance().putRectOnlyOne(_loc6_,_loc3_.text,_loc3_.width + 5,_loc3_.height);
            _loc6_++;
         }
         this._mc.getMC().addChild(Suspension.getInstance());
      }
      
      private function overMc(param1:Event) : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:int = 0;
         if(this.m_commanderInfo == null)
         {
            return;
         }
         var _loc2_:TextField = new TextField();
         var _loc3_:TextField = new TextField();
         var _loc4_:TextField = new TextField();
         _loc2_.textColor = 16777215;
         _loc4_.textColor = 16777215;
         if(param1.currentTarget.name == "mc_jingzhun")
         {
            _loc2_.htmlText = StringManager.getInstance().getMessageString("IconText35");
            _loc6_ = this.m_commanderInfo.commander_AimPer;
         }
         else if(param1.currentTarget.name == "mc_sudu")
         {
            _loc2_.htmlText = StringManager.getInstance().getMessageString("IconText36");
            _loc6_ = this.m_commanderInfo.commander_PriorityPer;
         }
         else if(param1.currentTarget.name == "mc_guibi")
         {
            _loc2_.htmlText = StringManager.getInstance().getMessageString("IconText37");
            _loc6_ = this.m_commanderInfo.commander_BlenchPer;
         }
         else if(param1.currentTarget.name == "mc_dianzi")
         {
            _loc2_.htmlText = StringManager.getInstance().getMessageString("IconText38");
            _loc6_ = this.m_commanderInfo.commander_ElectronPer;
         }
         _loc3_.text = "(" + StringManager.getInstance().getMessageString("CommanderText134") + ")";
         _loc5_ = _loc6_ / 10;
         _loc4_.htmlText = StringManager.getInstance().getMessageString("CommanderText133") + "<FONT COLOR=\'" + this.selectColor(_loc6_) + "\'>" + _loc5_ + "</FONT> ";
         _loc2_.wordWrap = true;
         _loc2_.autoSize = TextFieldAutoSize.LEFT;
         _loc3_.width = _loc2_.width + 5;
         _loc3_.multiline = true;
         _loc3_.wordWrap = true;
         _loc3_.autoSize = TextFieldAutoSize.LEFT;
         _loc3_.multiline = true;
         _loc4_.wordWrap = true;
         _loc4_.autoSize = TextFieldAutoSize.LEFT;
         _loc4_.multiline = true;
         Suspension.getInstance();
         var _loc7_:MovieClip = param1.currentTarget as MovieClip;
         var _loc8_:Point = _loc7_.localToGlobal(new Point(0,0));
         _loc8_ = this._mc.getMC().globalToLocal(_loc8_);
         if(param1.currentTarget.name == "mc_jingzhun")
         {
            Suspension.getInstance().Init(_loc2_.width + 5,_loc2_.height + _loc3_.textHeight + _loc4_.height - 7,1);
            Suspension.getInstance().setLocationXY(_loc8_.x,_loc8_.y + 20);
            Suspension.getInstance().putRectOnlyOne(0,_loc2_.htmlText,_loc2_.width + 5,_loc2_.height);
            Suspension.getInstance().putRectOnlyOne2(_loc2_.height - 3,_loc4_.htmlText,_loc2_.width + 5,_loc4_.height);
            Suspension.getInstance().putRectOnlyOne2(_loc2_.height + _loc4_.height - 9,_loc3_.text,_loc2_.width + 5,_loc3_.height);
         }
         else
         {
            Suspension.getInstance().Init(_loc2_.width + 5,_loc2_.height + _loc4_.height - 3,1);
            Suspension.getInstance().setLocationXY(_loc8_.x,_loc8_.y + 20);
            Suspension.getInstance().putRectOnlyOne(0,_loc2_.htmlText,_loc2_.width + 5,_loc2_.height);
            Suspension.getInstance().putRectOnlyOne2(_loc2_.height - 3,_loc4_.htmlText,_loc2_.width + 5,_loc4_.height);
         }
         this._mc.getMC().addChild(Suspension.getInstance());
      }
      
      private function selectColor(param1:int) : String
      {
         if(param1 >= 0 && param1 < 30)
         {
            return "#FFFFFF";
         }
         if(param1 >= 30 && param1 < 40)
         {
            return "#00FF1F";
         }
         if(param1 >= 40 && param1 < 47)
         {
            return "#0090F8";
         }
         if(param1 >= 47 && param1 < 50)
         {
            return "#A66BD3";
         }
         if(param1 == 50)
         {
            return "#FF0000";
         }
         return "";
      }
      
      private function overPic(param1:Event) : void
      {
         var _loc2_:TextField = new TextField();
         _loc2_.textColor = 16777215;
         if(param1.currentTarget.name == "pic_yidongli")
         {
            _loc2_.htmlText = StringManager.getInstance().getMessageString("IconText0");
         }
         else if(param1.currentTarget.name == "pic_xueliang")
         {
            _loc2_.htmlText = StringManager.getInstance().getMessageString("IconText3");
         }
         else if(param1.currentTarget.name == "pic_cunchu")
         {
            _loc2_.htmlText = StringManager.getInstance().getMessageString("IconText1");
         }
         else if(param1.currentTarget.name == "pic_gongjili")
         {
            _loc2_.htmlText = StringManager.getInstance().getMessageString("IconText4");
         }
         else if(param1.currentTarget.name == "pic_huihe")
         {
            _loc2_.htmlText = StringManager.getInstance().getMessageString("IconText2");
         }
         else if(param1.currentTarget.name == "pic_jianchuan")
         {
            _loc2_.htmlText = StringManager.getInstance().getMessageString("IconText5");
         }
         _loc2_.wordWrap = true;
         _loc2_.autoSize = TextFieldAutoSize.LEFT;
         _loc2_.multiline = true;
         Suspension.getInstance();
         if(_loc2_.textWidth + 5 > 100)
         {
            _loc2_.width = 100;
         }
         else
         {
            _loc2_.width = _loc2_.textWidth + 5;
         }
         Suspension.getInstance().Init(_loc2_.width + 5,_loc2_.height,1);
         var _loc3_:MovieClip = param1.currentTarget as MovieClip;
         var _loc4_:Point = _loc3_.localToGlobal(new Point(0,0));
         _loc4_ = this._mc.getMC().globalToLocal(_loc4_);
         Suspension.getInstance().setLocationXY(_loc4_.x,_loc4_.y + 20);
         var _loc5_:int = 0;
         while(_loc5_ < 1)
         {
            Suspension.getInstance().putRectOnlyOne(_loc5_,_loc2_.htmlText,_loc2_.width + 5,_loc2_.height);
            _loc5_++;
         }
         this._mc.getMC().addChild(Suspension.getInstance());
      }
      
      private function outPic(param1:Event) : void
      {
         this._mc.getMC().removeChild(Suspension.getInstance());
         Suspension.getInstance().delinstance();
      }
      
      private function overBtn(param1:Event) : void
      {
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:Object = null;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
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
            this.m_hireadmiralAry[4] = StringManager.getInstance().getMessageString("CommanderText18") + String(this.MAXCOMMANDER);
            _loc6_ = 0;
            while(_loc6_ < 3)
            {
               Suspension.getInstance().putRectOnlyOne(_loc6_,this.m_hireadmiralAry[_loc6_],_loc2_.textWidth + 5);
               _loc6_++;
            }
            this._mc.getMC().addChild(Suspension.getInstance());
         }
         else if(param1.currentTarget.name == "btn_speedhire")
         {
            _loc2_.htmlText = this.m_speedhireAry[0];
            Suspension.getInstance();
            Suspension.getInstance().Init(_loc2_.textWidth + 5,40,1);
            Suspension.getInstance().setLocationXY(param1.target.x,param1.target.y + param1.target.height);
            this.m_speedhireAry[3] = StringManager.getInstance().getMessageString("CommanderText17") + String(CommanderRouter.instance.m_commandInfoAry.length);
            this.m_speedhireAry[4] = StringManager.getInstance().getMessageString("CommanderText18") + String(this.MAXCOMMANDER);
            Suspension.getInstance().putRectOnlyOne(0,_loc2_.htmlText,_loc2_.textWidth + 5);
            Suspension.getInstance().putRectOnlyOne(1,this.m_speedhireAry[1],_loc2_.textWidth + 5);
            this._mc.getMC().addChild(Suspension.getInstance());
         }
         else if(param1.currentTarget.name == "btn_voucher")
         {
            _loc2_.htmlText = this.m_voucherAry[0];
            Suspension.getInstance();
            Suspension.getInstance().Init(_loc2_.textWidth + 8,20,1);
            Suspension.getInstance().setLocationXY(param1.target.x,param1.target.y + param1.target.height);
            this.m_voucherAry[3] = StringManager.getInstance().getMessageString("CommanderText17") + String(CommanderRouter.instance.m_commandInfoAry.length);
            this.m_voucherAry[4] = StringManager.getInstance().getMessageString("CommanderText18") + String(this.MAXCOMMANDER);
            _loc7_ = 0;
            while(_loc7_ < 1)
            {
               Suspension.getInstance().putRectOnlyOne(_loc7_,this.m_voucherAry[_loc7_],_loc2_.textWidth + 8);
               _loc7_++;
            }
            this._mc.getMC().addChild(Suspension.getInstance());
         }
         else if(param1.currentTarget.name == "btn_batchfire")
         {
            _loc2_.htmlText = StringManager.getInstance().getMessageString("CommanderText19");
            Suspension.getInstance();
            Suspension.getInstance().Init(_loc2_.textWidth + 8,20,1);
            Suspension.getInstance().setLocationXY(param1.target.x,param1.target.y + param1.target.height);
            _loc8_ = 0;
            while(_loc8_ < 1)
            {
               Suspension.getInstance().putRectOnlyOne(_loc8_,StringManager.getInstance().getMessageString("CommanderText19"),_loc2_.textWidth + 8);
               _loc8_++;
            }
            this._mc.getMC().addChild(Suspension.getInstance());
         }
         else if(param1.currentTarget.name == "btn_autofire")
         {
            _loc2_.htmlText = StringManager.getInstance().getMessageString("CommanderText14");
            Suspension.getInstance();
            Suspension.getInstance().Init(_loc2_.textWidth + 5,40,1);
            Suspension.getInstance().setLocationXY(this._autofire.x,this._autofire.y + this._autofire.height);
            Suspension.getInstance().putRectOnlyOne(0,StringManager.getInstance().getMessageString("CommanderText14"),_loc2_.textWidth + 5);
            if(this.m_Activation == 0)
            {
               Suspension.getInstance().putRectOnlyOne(1,StringManager.getInstance().getMessageString("CommanderText15"),_loc2_.textWidth + 5);
            }
            else
            {
               Suspension.getInstance().putRectOnlyOne(1,StringManager.getInstance().getMessageString("CommanderText16"),_loc2_.textWidth + 5);
            }
            this._mc.getMC().addChild(Suspension.getInstance());
         }
         else if(param1.currentTarget.name == "btn_xidian")
         {
            _loc2_.text = StringManager.getInstance().getMessageString("CommanderText94");
            Suspension.getInstance();
            Suspension.getInstance().Init(_loc2_.textWidth + 5,20,1);
            _loc4_ = this._mc.getMC().globalToLocal(_loc4_);
            Suspension.getInstance().setLocationXY(_loc4_.x,_loc4_.y - 20);
            _loc9_ = 0;
            while(_loc9_ < 1)
            {
               Suspension.getInstance().putRectOnlyOne(_loc9_,StringManager.getInstance().getMessageString("CommanderText94"),_loc2_.textWidth + 5);
               _loc9_++;
            }
            this._mc.getMC().addChild(Suspension.getInstance());
         }
         else if(param1.currentTarget.name == "btn_alive")
         {
            _loc2_.text = StringManager.getInstance().getMessageString("CommanderText73");
            Suspension.getInstance();
            Suspension.getInstance().Init(_loc2_.textWidth + 5,20,1);
            _loc4_ = this._mc.getMC().globalToLocal(_loc4_);
            Suspension.getInstance().setLocationXY(_loc4_.x,_loc4_.y - 20);
            _loc10_ = 0;
            while(_loc10_ < 1)
            {
               Suspension.getInstance().putRectOnlyOne(_loc10_,StringManager.getInstance().getMessageString("CommanderText73"),_loc2_.textWidth + 5);
               _loc10_++;
            }
            this._mc.getMC().addChild(Suspension.getInstance());
         }
         else if(param1.currentTarget.name == "btn_cure")
         {
            _loc2_.text = StringManager.getInstance().getMessageString("CommanderText74");
            Suspension.getInstance();
            Suspension.getInstance().Init(_loc2_.textWidth + 5,20,1);
            _loc4_ = this._mc.getMC().globalToLocal(_loc4_);
            Suspension.getInstance().setLocationXY(_loc4_.x,_loc4_.y - 20);
            _loc11_ = 0;
            while(_loc11_ < 1)
            {
               Suspension.getInstance().putRectOnlyOne(_loc11_,StringManager.getInstance().getMessageString("CommanderText74"),_loc2_.textWidth + 5);
               _loc11_++;
            }
            this._mc.getMC().addChild(Suspension.getInstance());
         }
         else if(param1.currentTarget.name == "btn_planbar")
         {
            _loc2_.text = StringManager.getInstance().getMessageString("CommanderText75");
            Suspension.getInstance();
            Suspension.getInstance().Init(_loc2_.textWidth + 5,20,1);
            _loc4_ = this._mc.getMC().globalToLocal(_loc4_);
            Suspension.getInstance().setLocationXY(_loc4_.x,_loc4_.y - 20);
            _loc12_ = 0;
            while(_loc12_ < 1)
            {
               Suspension.getInstance().putRectOnlyOne(_loc12_,StringManager.getInstance().getMessageString("CommanderText75"),_loc2_.textWidth + 5);
               _loc12_++;
            }
            this._mc.getMC().addChild(Suspension.getInstance());
         }
         else if(param1.currentTarget.name == "mc_grade")
         {
            _loc2_.htmlText = "   " + StringManager.getInstance().getMessageString("CommanderText104");
            _loc2_.autoSize = TextFieldAutoSize.LEFT;
            _loc13_ = _loc2_.width;
            _loc2_.multiline = true;
            _loc2_.wordWrap = true;
            if(GamePlayer.getInstance().language == 1)
            {
               _loc2_.width = 190;
            }
            else
            {
               _loc2_.width = 140;
            }
            Suspension.getInstance();
            Suspension.getInstance().Init(_loc2_.width + 5,_loc2_.height + 60,1);
            _loc4_ = this._mc.getMC().globalToLocal(_loc4_);
            Suspension.getInstance().setLocationXY(_loc4_.x + 5,_loc4_.y + 15);
            _loc14_ = new Object();
            _loc14_.Frigate = 0;
            _loc14_.Cruiser = 0;
            _loc14_.Warship = 0;
            if(this.m_commanderInfo != null)
            {
               _loc14_ = CCommanderReader.getInstance().GetCommandPullulate(this.m_commanderInfo.commander_type,this.m_commanderInfo.commander_cardLevel,_loc14_);
            }
            _loc13_ = _loc2_.textHeight;
            Suspension.getInstance().putRectOnlyOne(0,"   " + StringManager.getInstance().getMessageString("CommanderText104"),_loc2_.width,_loc2_.height);
            Suspension.getInstance().putRectOnlyOne2(_loc13_ + 0 * 15,"   " + StringManager.getInstance().getMessageString("CommanderText122"),_loc2_.width,17);
            Suspension.getInstance().putRectOnlyOne2(_loc13_ + 1 * 15,"   " + StringManager.getInstance().getMessageString("CommanderText123") + "   " + "<font color=\'#00ff00\'>" + "+ " + String(_loc14_.Frigate) + "</font>",_loc2_.width,17);
            Suspension.getInstance().putRectOnlyOne2(_loc13_ + 2 * 15,"   " + StringManager.getInstance().getMessageString("CommanderText124") + "   " + "<font color=\'#00ff00\'>" + "+ " + String(_loc14_.Cruiser) + "</font>",_loc2_.width,17);
            Suspension.getInstance().putRectOnlyOne2(_loc13_ + 3 * 15,"   " + StringManager.getInstance().getMessageString("CommanderText125") + "   " + "<font color=\'#00ff00\'>" + "+ " + String(_loc14_.Warship) + "</font>",_loc2_.width,17);
            this._mc.getMC().addChild(Suspension.getInstance());
         }
         else if(param1.currentTarget.name == "btn_fire")
         {
            _loc2_.text = "   " + StringManager.getInstance().getMessageString("CommanderText106");
            _loc2_.autoSize = TextFieldAutoSize.LEFT;
            _loc2_.multiline = true;
            _loc2_.wordWrap = true;
            Suspension.getInstance();
            Suspension.getInstance().Init(_loc2_.width + 5,_loc2_.height,1);
            _loc4_ = this._mc.getMC().globalToLocal(_loc4_);
            Suspension.getInstance().setLocationXY(_loc4_.x + 5,_loc4_.y + 15);
            _loc15_ = 0;
            while(_loc15_ < 1)
            {
               Suspension.getInstance().putRectOnlyOne(_loc15_,"   " + StringManager.getInstance().getMessageString("CommanderText106"),_loc2_.width,_loc2_.height);
               _loc15_++;
            }
            this._mc.getMC().addChild(Suspension.getInstance());
         }
         else if(param1.currentTarget.name == "btn_friend")
         {
            _loc2_.text = "   " + StringManager.getInstance().getMessageString("CommanderText105");
            _loc2_.autoSize = TextFieldAutoSize.LEFT;
            _loc2_.multiline = true;
            _loc2_.wordWrap = true;
            Suspension.getInstance();
            Suspension.getInstance().Init(_loc2_.width + 5,_loc2_.height,1);
            _loc4_ = this._mc.getMC().globalToLocal(_loc4_);
            Suspension.getInstance().setLocationXY(_loc4_.x + 5,_loc4_.y + 15);
            _loc16_ = 0;
            while(_loc16_ < 1)
            {
               Suspension.getInstance().putRectOnlyOne(_loc16_,"   " + StringManager.getInstance().getMessageString("CommanderText105"),_loc2_.width,_loc2_.height);
               _loc16_++;
            }
            this._mc.getMC().addChild(Suspension.getInstance());
         }
      }
      
      private function outBtn(param1:Event) : void
      {
         if(param1.currentTarget.name == "btn_speedhire")
         {
            this._mc.getMC().removeChild(Suspension.getInstance());
            Suspension.getInstance().delinstance();
         }
         else if(param1.currentTarget.name == "btn_hireadmiral" || param1.currentTarget.name == "btn_cdtime")
         {
            if(this.IsCooling == false)
            {
               this._hireadmiral.gotoAndStop(1);
            }
            this._mc.getMC().removeChild(Suspension.getInstance());
            Suspension.getInstance().delinstance();
         }
         else if(param1.currentTarget.name == "btn_voucher")
         {
            this._mc.getMC().removeChild(Suspension.getInstance());
            Suspension.getInstance().delinstance();
         }
         else if(param1.currentTarget.name == "btn_batchfire")
         {
            this._mc.getMC().removeChild(Suspension.getInstance());
            Suspension.getInstance().delinstance();
         }
         else if(param1.currentTarget.name == "btn_autofire")
         {
            this._mc.getMC().removeChild(Suspension.getInstance());
            Suspension.getInstance().delinstance();
         }
         else if(param1.currentTarget.name == "btn_xidian")
         {
            this._mc.getMC().removeChild(Suspension.getInstance());
            Suspension.getInstance().delinstance();
         }
         else if(param1.currentTarget.name == "btn_alive")
         {
            this._mc.getMC().removeChild(Suspension.getInstance());
            Suspension.getInstance().delinstance();
         }
         else if(param1.currentTarget.name == "btn_cure")
         {
            this._mc.getMC().removeChild(Suspension.getInstance());
            Suspension.getInstance().delinstance();
         }
         else if(param1.currentTarget.name == "btn_planbar")
         {
            this._mc.getMC().removeChild(Suspension.getInstance());
            Suspension.getInstance().delinstance();
         }
         else if(param1.currentTarget.name == "mc_grade")
         {
            this._mc.getMC().removeChild(Suspension.getInstance());
            Suspension.getInstance().delinstance();
         }
         else if(param1.currentTarget.name == "btn_fire" || param1.currentTarget.name == "btn_friend")
         {
            this._mc.getMC().removeChild(Suspension.getInstance());
            Suspension.getInstance().delinstance();
         }
      }
      
      private function overState(param1:Event) : void
      {
         if(this.m_commanderInfo == null)
         {
            return;
         }
         if(this.m_commanderInfo.commander_state != 1)
         {
            return;
         }
         this._stateMC.graphics.clear();
         this._stateMC.graphics.lineStyle(1,479858);
         this._stateMC.graphics.beginFill(0,0.8);
         this._stateMC.graphics.drawRoundRect(-103,-86,50,20,5,10);
         this._stateMC.graphics.endFill();
         this._mc.getMC().addChild(this._stateMC);
         this._stateTxt.x = -103;
         this._stateTxt.y = -86;
         this._stateTxt.width = 50;
         this._stateTxt.height = 20;
         this._stateTxt.selectable = true;
         this._stateTxt.mouseEnabled = false;
         this._stateTxt.textColor = 16777215;
         this._stateTxt.wordWrap = true;
         this._stateMC.addChild(this._stateTxt);
      }
      
      private function outState(param1:Event) : void
      {
         if(this.m_commanderInfo == null)
         {
            return;
         }
         if(this.m_commanderInfo.commander_state != 1)
         {
            return;
         }
         if(this._mc.getMC().contains(this._stateMC) == false)
         {
            return;
         }
         this._mc.getMC().removeChild(this._stateMC);
      }
      
      private function overSkill(param1:MouseEvent) : void
      {
         var _loc2_:String = param1.currentTarget.name;
         _loc2_ = _loc2_.substring(8);
         var _loc3_:int = int(_loc2_);
         var _loc4_:TextField = new TextField();
         _loc4_.text = this.m_ZhanjingAry[_loc3_];
         _loc4_.width = _loc4_.textWidth + 5;
         var _loc5_:TextField = new TextField();
         _loc2_ = this.m_ZhanjingmiaoshuAry[_loc3_];
         _loc5_.text = _loc2_;
         _loc5_.wordWrap = true;
         _loc5_.autoSize = TextFieldAutoSize.LEFT;
         _loc5_.multiline = true;
         _loc5_.width = _loc4_.width;
         Suspension.getInstance().Init(_loc5_.textWidth,_loc5_.height + 20,1);
         Suspension.getInstance().setLocationXY(param1.target.x - 5,param1.target.y + 50);
         Suspension.getInstance().putRectOnlyOne(0,this.m_ZhanjingAry[_loc3_],_loc5_.textWidth + 5,20);
         Suspension.getInstance().putRectOnlyOne(1,"      " + this.m_ZhanjingmiaoshuAry[_loc3_],_loc5_.textWidth + 5,_loc5_.height);
         this._mc.getMC().addChild(Suspension.getInstance());
         this._mc.dispatchEvent(param1);
      }
      
      private function outSkill(param1:Event) : void
      {
         if(Suspension.instance == null)
         {
            return;
         }
         this._mc.getMC().removeChild(Suspension.getInstance());
         Suspension.getInstance().delinstance();
      }
      
      public function Resume() : void
      {
         TextField(this._mc.getMC().tf_state).text = this.m_statusAry[0];
         this.m_commanderInfo.commander_state = 0;
         CommanderRouter.instance.m_commanderStateAry[this.m_choosenum] = 0;
         this._alive.setVisible(false);
         this._scare.setVisible(false);
      }
      
      public function Judge(param1:int) : Boolean
      {
         var _loc2_:int = 0;
         if(CommanderRouter.instance.m_commandInfoAry.length < GamePlayer.getInstance().commandernum)
         {
            _loc2_ = 0;
            while(_loc2_ < CommanderRouter.instance.m_commandInfoAry.length)
            {
               if(CommanderRouter.instance.m_commandInfoAry[_loc2_].commander_skill == param1)
               {
                  return false;
               }
               _loc2_++;
            }
            return true;
         }
         return false;
      }
      
      public function CommanderImg(param1:int) : Bitmap
      {
         var _loc2_:int = 0;
         while(_loc2_ < CommanderRouter.instance.m_commandInfoAry.length)
         {
            if(CommanderRouter.instance.m_commandInfoAry[_loc2_].commander_commanderId == param1)
            {
               return this.CommanderAvararImg(CommanderRouter.instance.m_commandInfoAry[_loc2_].commander_skill);
            }
            _loc2_++;
         }
         return null;
      }
      
      public function CommanderAvararImg(param1:int) : Bitmap
      {
         var _loc3_:Bitmap = null;
         var _loc2_:String = "";
         _loc2_ = CCommanderReader.getInstance().getCommanderAvatar(param1);
         if(_loc2_ == null || _loc2_ == "")
         {
            _loc3_ = new Bitmap(GameKernel.getTextureInstance("SmallCommand0"));
         }
         else
         {
            _loc3_ = new Bitmap(GameKernel.getTextureInstance(_loc2_));
         }
         return _loc3_;
      }
      
      public function CommanderHeadImg(param1:int) : BitmapData
      {
         if(param1 == -1)
         {
            return GameKernel.getTextureInstance("SmallCommand0");
         }
         var _loc2_:String = "";
         _loc2_ = CCommanderReader.getInstance().getCommanderAvatar(param1);
         if(_loc2_.length > 0)
         {
            return GameKernel.getTextureInstance(_loc2_);
         }
         return GameKernel.getTextureInstance("SmallCommand0");
      }
      
      public function chickHead(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:CChatInputBar = null;
         var _loc5_:int = 0;
         var _loc6_:HButton = null;
         var _loc7_:MovieClip = null;
         var _loc8_:String = null;
         var _loc9_:Bitmap = null;
         var _loc10_:HButton = null;
         var _loc11_:HButton = null;
         if(this._mc.getMC().tf_skill.text == "")
         {
            return;
         }
         if(MainUI.shirtKeyDown)
         {
            ChatAction.specialType = ChatAction.COMMAND_CARD;
            _loc2_ = String(CPropsReader.getInstance().GetCommanderProID(this.m_commanderInfo.commander_skill) + this.m_commanderInfo.commander_cardLevel);
            _loc3_ = ChatAction.specialType.toString() + "," + _loc2_ + "," + this.m_commanderInfo.commander_name;
            ChatUI.toolObj.Type = ChatAction.specialType;
            ChatUI.toolObj.Proid = this.m_commanderInfo.commander_commanderId;
            ChatUI.toolObj.Name = this.m_commanderInfo.commander_name;
            _loc4_ = CChatInputBar(ChatUI.getInstance().TextArea.ComponentList.Get("CChatInputBar"));
            _loc4_.Send("[" + this.m_commanderInfo.commander_name + "]/");
            return;
         }
         if(CCommanderReader.getInstance().m_skillName != "")
         {
            if(CCommanderReader.getInstance().m_CommanderType == null)
            {
               return;
            }
            this.backMc.graphics.clear();
            this.backMc.graphics.beginFill(16711935,0);
            this.backMc.graphics.drawRect(-380,-340,760,850);
            this.backMc.graphics.endFill();
            this._mc.getMC().addChild(this.backMc);
            _loc5_ = int(CCommanderReader.getInstance().m_CommanderType);
            _loc6_ = new HButton(this.m_cardUI[_loc5_].getMC().btn_enter);
            _loc7_ = this.m_cardUI[_loc5_].getMC().mc_grade as MovieClip;
            _loc7_.gotoAndStop(this.m_commanderInfo.commander_cardLevel + 2);
            MovieClip(this.m_cardUI[_loc5_].getMC().mc_herostar).gotoAndStop(CCommanderReader.getInstance().m_type - 1);
            this.m_cardUI[_loc5_].getMC().tf_content.wordWrap = true;
            this.m_cardUI[_loc5_].getMC().btn_enter.addEventListener(ActionEvent.ACTION_MOUSE_OVER,this.overEnter);
            this.m_cardUI[_loc5_].getMC().btn_enter.addEventListener(ActionEvent.ACTION_MOUSE_OUT,this.outEnter);
            TextField(this.m_cardUI[_loc5_].getMC().tf_commandername).text = this.m_commanderInfo.commander_name;
            _loc8_ = CCommanderReader.getInstance().getCommanderImage(this.m_commanderInfo.commander_skill);
            _loc9_ = new Bitmap(GameKernel.getTextureInstance(_loc8_));
            this.m_cardUI[_loc5_].getMC().mc_commanderbase.addChild(_loc9_);
            this.m_cardUI[_loc5_].getMC().tf_content.htmlText = "<font size=\'12px\' color=\'#ffffff\'>" + CCommanderReader.getInstance().m_Comment + "</font>";
            BleakingLineForThai.GetInstance().BleakThaiLanguage(this.m_cardUI[_loc5_].getMC().tf_content);
            this._mc.getMC().addChild(this.m_cardUI[_loc5_]);
            _loc10_ = new HButton(this.m_cardUI[_loc5_].getMC().btn_up);
            _loc11_ = new HButton(this.m_cardUI[_loc5_].getMC().btn_down);
            if(this.m_cardUI[_loc5_].getMC().tf_content.maxScrollV == 1)
            {
               _loc11_.m_movie.visible = false;
               _loc10_.m_movie.visible = false;
               this.m_cardUI[_loc5_].getMC().mc_drag.visible = false;
               this.m_cardUI[_loc5_].getMC().tf_content.width = 155;
            }
            else
            {
               _loc11_.m_movie.visible = true;
               _loc10_.m_movie.visible = true;
               this.m_cardUI[_loc5_].getMC().mc_drag.visible = true;
               this.m_cardUI[_loc5_].getMC().tf_content.width = 148;
               this.m_cardUI[_loc5_].getMC().tf_content.scrollV = 1;
            }
            this.m_cardUI[_loc5_].getMC().btn_down.addEventListener(MouseEvent.MOUSE_DOWN,this.chickButtonCard);
            this.m_cardUI[_loc5_].getMC().btn_up.addEventListener(MouseEvent.MOUSE_DOWN,this.chickButtonCard);
            this.m_cardUI[_loc5_].getMC().mc_commanderbase.addEventListener(MouseEvent.MOUSE_DOWN,this.chickBitmp);
            this.backMc.addEventListener(ActionEvent.ACTION_CLICK,this.mouseChick);
         }
      }
      
      private function overEnter(param1:Event) : void
      {
         this.shap = new MovieClip();
         this.shap = Commander.getInstance().littelTip(CCommanderReader.getInstance().getCommanderDescription(this.m_commanderInfo.commander_skill));
         param1.currentTarget.parent.addChild(this.shap);
         this.shap.x = param1.currentTarget.x + 30;
         if(this.shap.height > 170)
         {
            this.shap.y = param1.currentTarget.y - 170;
         }
         else
         {
            this.shap.y = param1.currentTarget.y - this.shap.height;
         }
      }
      
      private function outEnter(param1:Event) : void
      {
         if(this.shap != null && Boolean(param1.currentTarget.parent.contains(this.shap)))
         {
            Commander.getInstance().CloselittelTip(this.shap);
            param1.currentTarget.parent.removeChild(this.shap);
            this.shap = null;
         }
      }
      
      private function chickGemBitmp(param1:MouseEvent) : void
      {
         if(MainUI.shirtKeyDown)
         {
         }
      }
      
      private function chickBitmp(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(MainUI.shirtKeyDown)
         {
            ChatAction.specialType = ChatAction.TOOL_TYPE;
            _loc2_ = String(CPropsReader.getInstance().GetCommanderProID(this.m_commanderInfo.commander_skill) + this.m_commanderInfo.commander_cardLevel);
            _loc3_ = ChatAction.specialType.toString() + "," + _loc2_ + "," + this.m_commanderInfo.commander_name;
            ChatUI.toolObj.Type = ChatAction.specialType;
            ChatUI.toolObj.Proid = _loc2_;
            ChatUI.toolObj.Name = this.m_commanderInfo.commander_name;
            ChatUI.getInstance().copySysteNotice("[" + this.m_commanderInfo.commander_name + "]/");
            return;
         }
      }
      
      private function chickButtonCard(param1:MouseEvent) : void
      {
         var _loc2_:int = int(CCommanderReader.getInstance().m_CommanderType);
         if(param1.currentTarget.name == "btn_up")
         {
            --this.m_cardUI[_loc2_].getMC().tf_content.scrollV;
         }
         else if(param1.currentTarget.name == "btn_down")
         {
            ++this.m_cardUI[_loc2_].getMC().tf_content.scrollV;
         }
      }
      
      public function mouseChick(param1:Event) : void
      {
         var _loc2_:int = int(CCommanderReader.getInstance().m_CommanderType);
         this.m_cardUI[_loc2_].getMC().btn_down.removeEventListener(MouseEvent.MOUSE_DOWN,this.chickButtonCard);
         this.m_cardUI[_loc2_].getMC().btn_up.removeEventListener(MouseEvent.MOUSE_DOWN,this.chickButtonCard);
         this.m_cardUI[_loc2_].getMC().mc_commanderbase.removeEventListener(MouseEvent.MOUSE_DOWN,this.chickBitmp);
         this.m_cardUI[_loc2_].getMC().btn_enter.removeEventListener(ActionEvent.ACTION_MOUSE_OVER,this.overEnter);
         this.m_cardUI[_loc2_].getMC().btn_enter.removeEventListener(ActionEvent.ACTION_MOUSE_OUT,this.outEnter);
         if(this.m_cardUI[_loc2_].parent == null)
         {
            return;
         }
         this._mc.getMC().removeChild(this.m_cardUI[_loc2_]);
         this._mc.getMC().removeChild(this.backMc);
      }
      
      public function addBackMC() : void
      {
         this.backMc.graphics.clear();
         this.backMc.graphics.beginFill(16711935,0);
         this.backMc.graphics.drawRect(-380,-340,760,850);
         this.backMc.graphics.endFill();
         this._mc.getMC().addChild(this.backMc);
      }
      
      public function showTeamChangeTxt() : void
      {
         ConstructionOperationWidget.currenCmd = OperationEnum.OPERATION_TYPE_SHIPTEAM;
         MallBuyModulesPopup.getInstance().Init();
         MallBuyModulesPopup.getInstance().Show();
      }
      
      public function removeBackMC() : void
      {
         if(this.backMc == null)
         {
            return;
         }
         if(this.backMc.parent == null)
         {
            return;
         }
         this._mc.getMC().removeChild(this.backMc);
      }
      
      public function AnimationCard() : void
      {
         MovieClip(this._mc.getMC().mc_shrink).gotoAndPlay(1);
      }
      
      public function setfriendButton(param1:Boolean) : void
      {
         this._friend.setBtnDisabled(param1);
      }
   }
}

