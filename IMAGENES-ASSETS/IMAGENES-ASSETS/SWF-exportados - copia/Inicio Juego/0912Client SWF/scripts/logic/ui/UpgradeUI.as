package logic.ui
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.geom.CFilter;
   import com.star.frameworks.managers.ResManager;
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.HashSet;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.Timer;
   import logic.action.ConstructionAction;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.HButtonType;
   import logic.entry.MObject;
   import logic.entry.ScienceSystem;
   import logic.entry.props.PackPropsInfo;
   import logic.entry.props.propsInfo;
   import logic.entry.shipmodel.ShipbodyInfo;
   import logic.entry.shipmodel.ShippartInfo;
   import logic.entry.upgrade.UpgradeInfo;
   import logic.entry.upgrade.Upgrade_Body;
   import logic.entry.upgrade.Upgrade_Part;
   import logic.game.GameKernel;
   import logic.game.GameMouseZoneManager;
   import logic.reader.CPropsReader;
   import logic.reader.CShipmodelReader;
   import logic.reader.ConstructionSpeedReader;
   import logic.ui.tip.CaptionTip;
   import logic.ui.tip.CustomTip;
   import logic.utils.UpdateResource;
   import logic.widget.ConstructionOperationWidget;
   import logic.widget.DataWidget;
   import logic.widget.OperationEnum;
   import net.base.NetManager;
   import net.msg.FlagShip.MSG_REQUEST_UPGRADEFLAGSHIP;
   import net.msg.FlagShip.MSG_RESP_UPGRADEFLAGSHIP;
   import net.msg.upgrade.MSG_REQUEST_SHIPBODYUPGRADE;
   import net.msg.upgrade.MSG_REQUEST_SHIPBODYUPGRADEINFO;
   import net.msg.upgrade.MSG_REQUEST_SPEEDSHIPBODYUPGRADE;
   import net.msg.upgrade.MSG_RESP_SHIPBODYUPGRADE;
   import net.router.ShipmodelRouter;
   import net.router.UpgradeRouter;
   
   public class UpgradeUI extends AbstractPopUp
   {
      
      private static var instance:UpgradeUI;
      
      private var BodyInfoList:MovieClip;
      
      private var PartInfoList:MovieClip;
      
      private var UpgradeItemList:MovieClip;
      
      private var _BodyInfo:Upgrade_Body = new Upgrade_Body();
      
      private var _PartInfo:Upgrade_Part = new Upgrade_Part();
      
      private var BodyArray:Array = new Array();
      
      private var PartArray:Array = new Array();
      
      private var NextBodyArray:Array = new Array();
      
      private var NextPartArray:Array = new Array();
      
      private var PageIndex:int;
      
      private var CurSelectedType:int;
      
      private var CurSelectedChildType:int;
      
      private var BodyButton:HButton;
      
      private var PartButton:HButton;
      
      private var SelectedItem:MovieClip;
      
      private var SelectedIndex:int;
      
      private var SelectedPage:int;
      
      private var SelectedType:int;
      
      private var _UpgradeInfo:UpgradeInfo = new UpgradeInfo();
      
      private var UpgradeTimer:Timer = new Timer(1000);
      
      private var SelectedTypeBtn:HButton;
      
      private var SelectedChildBtn:HButton;
      
      private var btn_attack:HButton;
      
      private var btn_defense:HButton;
      
      private var btn_assistant:HButton;
      
      private var btn_frigate:HButton;
      
      private var btn_warship:HButton;
      
      private var btn_cruiser:HButton;
      
      private var btn_others:HButton;
      
      private var tf_page:TextField;
      
      private var LastY1:int;
      
      private var LastY2:int;
      
      private var LastY3:int;
      
      private var LastY4:int;
      
      private var btn_up:HButton;
      
      private var btn_down:HButton;
      
      private var ParentLock:Container;
      
      private var mc_airshipbasePoint:Point;
      
      private var mc_changeairshipbasePoint:Point;
      
      private var NormalFormat:TextFormat;
      
      private var DiffFormat:TextFormat;
      
      private var filter:CFilter;
      
      private var CanUpdate:Boolean;
      
      private var mc_ligth:MovieClip;
      
      private var btn_qijian:HButton;
      
      private var mc_module:MovieClip;
      
      private var FirstLevelBodyArray:Array = new Array();
      
      private var SecondLevelBodyArray:Array = new Array();
      
      private var FirstLevelPartArray:Array = new Array();
      
      private var SecondLevelPartArray:Array = new Array();
      
      private var FlagChipInfo:PackPropsInfo;
      
      public function UpgradeUI()
      {
         super();
         this.filter = ShipModeEditUI.getInstance().filter;
         this.CurSelectedType = -1;
         setPopUpName("UpgradeUI");
      }
      
      public static function getInstance() : UpgradeUI
      {
         if(instance == null)
         {
            instance = new UpgradeUI();
         }
         return instance;
      }
      
      override public function Init() : void
      {
         GameMouseZoneManager.isEnterSearch = true;
         this.SelectedIndex = -1;
         this.RequestUpgradeInfo();
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            this.Invalid(true);
            if(this.mc_ligth)
            {
               this.mc_ligth.play();
            }
            this.CurSelectedType = -1;
            this.BodyBtnClick(null);
            this.UpgradeTimer.start();
            return;
         }
         this._mc = new MObject("ResearchcenterScene",387,320);
         this.initMcElement();
         this.BodyBtnClick(null);
         this.UpgradeTimer.addEventListener(TimerEvent.TIMER,this.OnUpgradeTimer);
         this.UpgradeTimer.start();
         GameKernel.popUpDisplayManager.Regisger(instance);
         if(this.mc_ligth)
         {
            this.mc_ligth.play();
         }
      }
      
      override public function Remove() : void
      {
         this.UpgradeTimer.stop();
      }
      
      override public function initMcElement() : void
      {
         var _loc1_:HButton = null;
         var _loc2_:MovieClip = null;
         var _loc4_:XMovieClip = null;
         var _loc6_:TextField = null;
         var _loc7_:DisplayObject = null;
         var _loc8_:MovieClip = null;
         _loc2_ = this._mc.getMC().btn_close as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.Close);
         _loc1_ = new HButton(_loc2_);
         _loc2_ = this._mc.getMC().btn_ship as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.BodyBtnClick);
         this.BodyButton = new HButton(_loc2_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("IconText20"));
         _loc2_ = this._mc.getMC().btn_module as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.PartBtnClick);
         this.PartButton = new HButton(_loc2_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("IconText21"));
         var _loc3_:* = this._mc.getMC().getChildByName("btn_qijian");
         if(_loc3_)
         {
            _loc2_ = _loc3_ as MovieClip;
            _loc2_.addEventListener(MouseEvent.CLICK,this.btn_qijianClick);
            this.btn_qijian = new HButton(_loc2_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("Boss79"));
            this.mc_ligth = this._mc.getMC().mc_ligth as MovieClip;
            this.mc_ligth.stop();
            this.mc_module = this._mc.getMC().mc_module as MovieClip;
         }
         _loc2_ = this._mc.getMC().btn_attack as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.AttackBtnClick);
         this.btn_attack = new HButton(_loc2_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("IconText17"));
         _loc2_ = this._mc.getMC().btn_defense as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.DefenseBtnClick);
         this.btn_defense = new HButton(_loc2_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("IconText18"));
         _loc2_ = this._mc.getMC().btn_assistant as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.AssistantBtnClick);
         this.btn_assistant = new HButton(_loc2_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("IconText19"));
         _loc2_ = this._mc.getMC().btn_frigate as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.FrigateBtnClick);
         this.btn_frigate = new HButton(_loc2_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("IconText13"));
         _loc2_ = this._mc.getMC().btn_warship as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.WarshipBtnClick);
         this.btn_warship = new HButton(_loc2_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("IconText15"));
         _loc2_ = this._mc.getMC().btn_cruiser as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.CruiserBtnClick);
         this.btn_cruiser = new HButton(_loc2_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("IconText14"));
         _loc2_ = this._mc.getMC().btn_others as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.OthersBtnClick);
         this.btn_others = new HButton(_loc2_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("IconText16"));
         _loc2_ = this._mc.getMC().btn_change as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.UpgradeClick);
         _loc1_ = new HButton(_loc2_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("UpgradeText6"));
         _loc2_ = this._mc.getMC().btn_cancel as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.CancelClick);
         _loc1_ = new HButton(_loc2_);
         _loc2_ = this._mc.getMC().btn_speed as MovieClip;
         _loc1_ = new HButton(_loc2_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("UpgradeText0"));
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_speedClick);
         this.UpgradeItemList = this._mc.getMC().mc_airshiplist as MovieClip;
         _loc2_ = this.UpgradeItemList.getChildByName("btn_up") as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.LeftBtnClick);
         this.btn_up = new HButton(_loc2_);
         _loc2_ = this.UpgradeItemList.getChildByName("btn_down") as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.RightBtnClick);
         this.btn_down = new HButton(_loc2_);
         this.tf_page = this.UpgradeItemList.getChildByName("tf_page") as TextField;
         this.tf_page.text = "";
         var _loc5_:int = 0;
         while(_loc5_ < 5)
         {
            _loc8_ = this.UpgradeItemList.getChildByName("mc_list" + _loc5_) as MovieClip;
            _loc4_ = new XMovieClip(_loc8_);
            _loc4_.Data = _loc5_;
            _loc4_.OnClick = this.ItemClick;
            _loc8_.stop();
            _loc8_.buttonMode = true;
            _loc8_.mouseChildren = false;
            _loc4_.OnMouseOver = this.McItemMouseOver;
            _loc8_.addEventListener(MouseEvent.MOUSE_OUT,this.McItemMouseOut);
            _loc8_ = this.UpgradeItemList.getChildByName("mc_plan" + _loc5_) as MovieClip;
            _loc4_ = new XMovieClip(_loc8_);
            _loc4_.Data = _loc5_;
            _loc4_.OnClick = this.ItemClick;
            _loc8_.stop();
            _loc8_.buttonMode = true;
            _loc8_.mouseChildren = false;
            _loc4_.OnMouseOver = this.McItemMouseOver;
            _loc8_.addEventListener(MouseEvent.MOUSE_OUT,this.McItemMouseOut);
            _loc8_ = this.UpgradeItemList.getChildByName("btn_cancel" + _loc5_) as MovieClip;
            _loc8_.stop();
            _loc8_.visible = false;
            _loc5_++;
         }
         this.BodyInfoList = this._mc.getMC().mc_shipchange as MovieClip;
         _loc6_ = this.BodyInfoList.mc_hudun0.tf_planbar as TextField;
         this.DiffFormat = _loc6_.getTextFormat();
         this.DiffFormat.color = 12747274;
         this.NormalFormat = _loc6_.getTextFormat();
         this.ClearBodyInfo();
         this.PartInfoList = this._mc.getMC().mc_modulechange as MovieClip;
         this.ClearPartInfo();
         _loc7_ = this.PartInfoList.mc_gongjili0 as DisplayObject;
         this.LastY1 = _loc7_.y;
         _loc7_ = this.PartInfoList.mc_shecheng0 as DisplayObject;
         this.LastY2 = _loc7_.y;
         _loc7_ = this.PartInfoList.mc_huihe0 as DisplayObject;
         this.LastY3 = _loc7_.y;
         _loc7_ = this.PartInfoList.mc_tiji0 as DisplayObject;
         this.LastY4 = _loc7_.y;
         this.ClearUpgradeInfo();
         this.ParentLock = new Container("UpgradeUISceneLock");
         this.ParentLock.mouseEnabled = true;
         this.ParentLock.mouseChildren = false;
         this.ParentLock.fillRectangleWithoutBorder(GameKernel.fullRect.x,GameKernel.fullRect.y,GameKernel.fullRect.width,GameKernel.fullRect.height,0,0);
         _loc2_ = this._mc.getMC().mc_airshipbase as MovieClip;
         this.mc_airshipbasePoint = _loc2_.localToGlobal(new Point(0,50));
         _loc2_.addEventListener(MouseEvent.MOUSE_OVER,this.mc_airshipbaseMouseOver);
         _loc2_.addEventListener(MouseEvent.MOUSE_OUT,this.mc_airshipbaseMouseOut);
         _loc2_ = this._mc.getMC().mc_changeairshipbase as MovieClip;
         this.mc_changeairshipbasePoint = _loc2_.localToGlobal(new Point(0,50));
         _loc2_.addEventListener(MouseEvent.MOUSE_OVER,this.mc_changeairshipbaseMouseOver);
         _loc2_.addEventListener(MouseEvent.MOUSE_OUT,this.mc_changeairshipbaseMouseOut);
         this.InitCaption();
      }
      
      private function InitCaption() : void
      {
         var _loc1_:CaptionTip = null;
         _loc1_ = new CaptionTip(this.PartInfoList.pic_gongjili0,StringManager.getInstance().getMessageString("IconText4"));
         _loc1_ = new CaptionTip(this.PartInfoList.pic_shecheng0,StringManager.getInstance().getMessageString("IconText7"));
         _loc1_ = new CaptionTip(this.PartInfoList.pic_huihe0,StringManager.getInstance().getMessageString("IconText11"));
         _loc1_ = new CaptionTip(this.PartInfoList.pic_tiji0,StringManager.getInstance().getMessageString("IconText12"));
         _loc1_ = new CaptionTip(this.PartInfoList.pic_gongjili1,StringManager.getInstance().getMessageString("IconText4"));
         _loc1_ = new CaptionTip(this.PartInfoList.pic_shecheng1,StringManager.getInstance().getMessageString("IconText7"));
         _loc1_ = new CaptionTip(this.PartInfoList.pic_huihe1,StringManager.getInstance().getMessageString("IconText11"));
         _loc1_ = new CaptionTip(this.PartInfoList.pic_tiji1,StringManager.getInstance().getMessageString("IconText12"));
         _loc1_ = new CaptionTip(this.BodyInfoList.pic_hudun0,StringManager.getInstance().getMessageString("IconText6"));
         _loc1_ = new CaptionTip(this.BodyInfoList.pic_jiegou0,StringManager.getInstance().getMessageString("IconText41"));
         _loc1_ = new CaptionTip(this.BodyInfoList.pic_yidongli0,StringManager.getInstance().getMessageString("IconText0"));
         _loc1_ = new CaptionTip(this.BodyInfoList.pic_cunchu0,StringManager.getInstance().getMessageString("IconText1"));
         _loc1_ = new CaptionTip(this.BodyInfoList.pic_anzhuang0,StringManager.getInstance().getMessageString("IconText10"));
         _loc1_ = new CaptionTip(this.BodyInfoList.pic_yueqian0,StringManager.getInstance().getMessageString("IconText9"));
         _loc1_ = new CaptionTip(this.BodyInfoList.pic_jianzao0,StringManager.getInstance().getMessageString("IconText8"));
         _loc1_ = new CaptionTip(this.BodyInfoList.pic_hudun1,StringManager.getInstance().getMessageString("IconText6"));
         _loc1_ = new CaptionTip(this.BodyInfoList.pic_jiegou1,StringManager.getInstance().getMessageString("IconText41"));
         _loc1_ = new CaptionTip(this.BodyInfoList.pic_yidongli1,StringManager.getInstance().getMessageString("IconText0"));
         _loc1_ = new CaptionTip(this.BodyInfoList.pic_cunchu1,StringManager.getInstance().getMessageString("IconText1"));
         _loc1_ = new CaptionTip(this.BodyInfoList.pic_anzhuang1,StringManager.getInstance().getMessageString("IconText10"));
         _loc1_ = new CaptionTip(this.BodyInfoList.pic_yueqian1,StringManager.getInstance().getMessageString("IconText9"));
         _loc1_ = new CaptionTip(this.BodyInfoList.pic_jianzao1,StringManager.getInstance().getMessageString("IconText8"));
      }
      
      private function ClearBodyInfo() : void
      {
         this._BodyInfo.CreateTime1 = 0;
         this._BodyInfo.Shield1 = 0;
         this._BodyInfo.Endure1 = 0;
         this._BodyInfo.Locomotivity1 = 0;
         this._BodyInfo.Storage1 = 0;
         this._BodyInfo.Cubage1 = 0;
         this._BodyInfo.TransitionTime1 = 0;
         this._BodyInfo.CreateTime1 = 0;
         this._BodyInfo.Shield2 = 0;
         this._BodyInfo.Endure2 = 0;
         this._BodyInfo.Locomotivity2 = 0;
         this._BodyInfo.Storage2 = 0;
         this._BodyInfo.Cubage2 = 0;
         this._BodyInfo.TransitionTime2 = 0;
         this._BodyInfo.CreateTime2 = 0;
         this._BodyInfo.metal1 = 0;
         this._BodyInfo.cash1 = 0;
         this._BodyInfo.he31 = 0;
         this._BodyInfo.metal2 = 0;
         this._BodyInfo.cash2 = 0;
         this._BodyInfo.he32 = 0;
         if(this.SelectedItem != null)
         {
            this.SelectedItem.gotoAndStop("up");
            this.SelectedItem = null;
         }
         this.ClearUpgradeInfo();
         this.ShowBodyInfo();
      }
      
      private function ClearPartInfo() : void
      {
         this._PartInfo.PartAssault1 = 0;
         this._PartInfo.PartRange1 = 0;
         this._PartInfo.Backfill1 = 0;
         this._PartInfo.PartCubage1 = 0;
         this._PartInfo.PartSupply1 = 0;
         this._PartInfo.PartAssault2 = 0;
         this._PartInfo.PartRange2 = 0;
         this._PartInfo.Backfill2 = 0;
         this._PartInfo.PartCubage2 = 0;
         this._PartInfo.PartSupply2 = 0;
         this._PartInfo.metal1 = 0;
         this._PartInfo.cash1 = 0;
         this._PartInfo.he31 = 0;
         this._PartInfo.metal2 = 0;
         this._PartInfo.cash2 = 0;
         this._PartInfo.he32 = 0;
         if(this.SelectedItem != null)
         {
            this.SelectedItem.gotoAndStop("up");
            this.SelectedItem = null;
         }
         this.ClearUpgradeInfo();
         this.ShowPartInfo();
      }
      
      private function GetMaxValue(param1:int) : int
      {
         var _loc2_:XML = GameKernel.resManager.getXml(ResManager.GAMERES,"Others");
         _loc2_ = _loc2_.List[4] as XML;
         var _loc3_:XMLList = _loc2_.children();
         var _loc4_:XML = _loc3_[param1];
         return _loc4_.@Max;
      }
      
      private function ShowBodyInfo() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:TextField = null;
         _loc1_ = this.BodyInfoList.mc_hudun0 as MovieClip;
         this.SetProcessValue(_loc1_,this._BodyInfo.Shield1,this._BodyInfo.Shield1.toString(),this.GetMaxValue(0));
         _loc1_ = this.BodyInfoList.mc_jiegou0 as MovieClip;
         this.SetProcessValue(_loc1_,this._BodyInfo.Endure1,this._BodyInfo.Endure1.toString(),this.GetMaxValue(1));
         _loc1_ = this.BodyInfoList.mc_yidongli0 as MovieClip;
         this.SetProcessValue(_loc1_,this._BodyInfo.Locomotivity1,this._BodyInfo.Locomotivity1.toString(),this.GetMaxValue(2));
         _loc1_ = this.BodyInfoList.mc_cunchu0 as MovieClip;
         this.SetProcessValue(_loc1_,this._BodyInfo.Storage1,this._BodyInfo.Storage1.toString(),this.GetMaxValue(6));
         _loc1_ = this.BodyInfoList.mc_anzhuang0 as MovieClip;
         this.SetProcessValue(_loc1_,this._BodyInfo.Cubage1,this._BodyInfo.Cubage1.toString(),this.GetMaxValue(7));
         _loc2_ = this.BodyInfoList.tf_yueqian0 as TextField;
         _loc2_.text = DataWidget.GetTimeString(this._BodyInfo.TransitionTime1);
         _loc2_ = this.BodyInfoList.tf_jianzao0 as TextField;
         _loc2_.text = DataWidget.GetTimeString(this._BodyInfo.CreateTime1);
         _loc1_ = this.BodyInfoList.mc_hudun1 as MovieClip;
         this.SetProcessValue(_loc1_,this._BodyInfo.Shield2,this._BodyInfo.Shield2.toString(),this.GetMaxValue(0),this._BodyInfo.Shield1);
         _loc1_ = this.BodyInfoList.mc_jiegou1 as MovieClip;
         this.SetProcessValue(_loc1_,this._BodyInfo.Endure2,this._BodyInfo.Endure2.toString(),this.GetMaxValue(1),this._BodyInfo.Endure1);
         _loc1_ = this.BodyInfoList.mc_yidongli1 as MovieClip;
         this.SetProcessValue(_loc1_,this._BodyInfo.Locomotivity2,this._BodyInfo.Locomotivity2.toString(),this.GetMaxValue(2),this._BodyInfo.Locomotivity1);
         _loc1_ = this.BodyInfoList.mc_cunchu1 as MovieClip;
         this.SetProcessValue(_loc1_,this._BodyInfo.Storage2,this._BodyInfo.Storage2.toString(),this.GetMaxValue(6),this._BodyInfo.Storage1);
         _loc1_ = this.BodyInfoList.mc_anzhuang1 as MovieClip;
         this.SetProcessValue(_loc1_,this._BodyInfo.Cubage2,this._BodyInfo.Cubage2.toString(),this.GetMaxValue(7),this._BodyInfo.Cubage1);
         _loc2_ = this.BodyInfoList.tf_yueqian1 as TextField;
         _loc2_.text = DataWidget.GetTimeString(this._BodyInfo.TransitionTime2);
         if(this._BodyInfo.TransitionTime2 != this._BodyInfo.TransitionTime1)
         {
            _loc2_.setTextFormat(this.DiffFormat);
         }
         else
         {
            _loc2_.setTextFormat(this.NormalFormat);
         }
         _loc2_ = this.BodyInfoList.tf_jianzao1 as TextField;
         _loc2_.text = DataWidget.GetTimeString(this._BodyInfo.CreateTime2);
         if(this._BodyInfo.CreateTime2 != this._BodyInfo.CreateTime1)
         {
            _loc2_.setTextFormat(this.DiffFormat);
         }
         else
         {
            _loc2_.setTextFormat(this.NormalFormat);
         }
         _loc2_ = this.BodyInfoList.tf_metal as TextField;
         _loc2_.text = this._BodyInfo.metal1.toString();
         _loc2_ = this.BodyInfoList.tf_He3 as TextField;
         _loc2_.text = this._BodyInfo.he31.toString();
         _loc2_ = this.BodyInfoList.tf_cash as TextField;
         _loc2_.text = this._BodyInfo.cash1.toString();
         _loc2_ = this.BodyInfoList.tf_metaled as TextField;
         _loc2_.text = this._BodyInfo.metal2.toString();
         _loc2_ = this.BodyInfoList.tf_He3ed as TextField;
         _loc2_.text = this._BodyInfo.he32.toString();
         _loc2_ = this.BodyInfoList.tf_cashed as TextField;
         _loc2_.text = this._BodyInfo.cash2.toString();
      }
      
      private function ShowPartInfo() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:TextField = null;
         _loc1_ = this.PartInfoList.mc_gongjili0 as MovieClip;
         this.SetProcessValue(_loc1_,this._PartInfo.PartAssault1,this._PartInfo.PartAssault1.toString(),this.GetMaxValue(10));
         _loc1_ = this.PartInfoList.mc_shecheng0 as MovieClip;
         this.SetProcessValue(_loc1_,this._PartInfo.PartRange1,this._PartInfo.PartRange1.toString(),this.GetMaxValue(11));
         _loc1_ = this.PartInfoList.mc_huihe0 as MovieClip;
         this.SetProcessValue(_loc1_,this._PartInfo.Backfill1,this._PartInfo.Backfill1.toString(),this.GetMaxValue(12));
         _loc1_ = this.PartInfoList.mc_tiji0 as MovieClip;
         this.SetProcessValue(_loc1_,this._PartInfo.PartCubage1,this._PartInfo.PartCubage1.toString(),this.GetMaxValue(13));
         _loc1_ = this.PartInfoList.mc_gongjili1 as MovieClip;
         this.SetProcessValue(_loc1_,this._PartInfo.PartAssault2,this._PartInfo.PartAssault2.toString(),this.GetMaxValue(10),this._PartInfo.PartAssault1);
         _loc1_ = this.PartInfoList.mc_shecheng1 as MovieClip;
         this.SetProcessValue(_loc1_,this._PartInfo.PartRange2,this._PartInfo.PartRange2.toString(),this.GetMaxValue(11),this._PartInfo.PartRange1);
         _loc1_ = this.PartInfoList.mc_huihe1 as MovieClip;
         this.SetProcessValue(_loc1_,this._PartInfo.Backfill2,this._PartInfo.Backfill2.toString(),this.GetMaxValue(12),this._PartInfo.Backfill1);
         _loc1_ = this.PartInfoList.mc_tiji1 as MovieClip;
         this.SetProcessValue(_loc1_,this._PartInfo.PartCubage2,this._PartInfo.PartCubage2.toString(),this.GetMaxValue(13),this._PartInfo.PartCubage1);
         _loc2_ = this.PartInfoList.tf_metal as TextField;
         _loc2_.text = this._PartInfo.metal1.toString();
         _loc2_ = this.PartInfoList.tf_He3 as TextField;
         _loc2_.text = this._PartInfo.he31.toString();
         _loc2_ = this.PartInfoList.tf_cash as TextField;
         _loc2_.text = this._PartInfo.cash1.toString();
         _loc2_ = this.PartInfoList.tf_metaled as TextField;
         _loc2_.text = this._PartInfo.metal2.toString();
         _loc2_ = this.PartInfoList.tf_He3ed as TextField;
         _loc2_.text = this._PartInfo.he32.toString();
         _loc2_ = this.PartInfoList.tf_cashed as TextField;
         _loc2_.text = this._PartInfo.cash2.toString();
      }
      
      private function SetProcessValue(param1:MovieClip, param2:int, param3:String, param4:int = -1, param5:int = -1) : void
      {
         var _loc8_:int = 0;
         var _loc6_:DisplayObject = param1.getChildByName("mc_planbar");
         _loc6_.scaleX = 1;
         if(param4 > 0)
         {
            _loc8_ = (param1.width - 2) * (param2 / param4);
            if(_loc8_ > param1.width - 2)
            {
               _loc8_ = param1.width - 2;
            }
            _loc6_.width = _loc8_;
         }
         var _loc7_:TextField = param1.getChildByName("tf_planbar") as TextField;
         _loc7_.text = param3;
         if(param5 != -1 && param5 != param2)
         {
            _loc7_.setTextFormat(this.DiffFormat);
         }
         else
         {
            _loc7_.setTextFormat(this.NormalFormat);
         }
      }
      
      private function HideBodyInfo() : void
      {
         this.PartInfoList.visible = true;
         this.BodyInfoList.visible = false;
         this._mc.getMC().btn_attack.visible = true;
         this._mc.getMC().btn_defense.visible = true;
         this._mc.getMC().btn_assistant.visible = true;
         this._mc.getMC().btn_frigate.visible = false;
         this._mc.getMC().btn_warship.visible = false;
         this._mc.getMC().btn_cruiser.visible = false;
         this._mc.getMC().btn_others.visible = false;
      }
      
      private function HidePartInfo() : void
      {
         this.PartInfoList.visible = false;
         this.BodyInfoList.visible = true;
         this._mc.getMC().btn_attack.visible = false;
         this._mc.getMC().btn_defense.visible = false;
         this._mc.getMC().btn_assistant.visible = false;
         this._mc.getMC().btn_frigate.visible = true;
         this._mc.getMC().btn_warship.visible = true;
         this._mc.getMC().btn_cruiser.visible = true;
         this._mc.getMC().btn_others.visible = true;
      }
      
      private function ShowBodyList(param1:int, param2:Boolean = true) : void
      {
         var _loc4_:ShipbodyInfo = null;
         var _loc6_:ShipbodyInfo = null;
         var _loc7_:int = 0;
         var _loc8_:ShipbodyInfo = null;
         var _loc9_:ShipbodyInfo = null;
         var _loc3_:HashSet = CShipmodelReader.getInstance().GetFirstLevelBody(param1);
         this.CurSelectedChildType = param1;
         this.BodyArray.splice(0);
         this.NextBodyArray.splice(0);
         var _loc5_:int = 0;
         while(_loc5_ < ShipmodelRouter.instance.ShipBodyIds.length)
         {
            _loc7_ = int(ShipmodelRouter.instance.ShipBodyIds[_loc5_]);
            _loc4_ = CShipmodelReader.getInstance().getShipBodyInfo(_loc7_);
            if(_loc4_.KindId == param1)
            {
               _loc8_ = CShipmodelReader.getInstance().GetNextLevelBody(_loc4_);
               if(_loc8_ != null)
               {
                  this.BodyArray.push(_loc4_);
                  this.NextBodyArray.push(_loc8_);
               }
               _loc3_.Remove(_loc4_.GroupID);
            }
            _loc5_++;
         }
         this.FirstLevelBodyArray.splice(0);
         this.SecondLevelBodyArray.splice(0);
         for each(_loc6_ in _loc3_.Values())
         {
            _loc9_ = CShipmodelReader.getInstance().GetNextLevelBody(_loc6_);
            if(_loc9_ != null)
            {
               this.FirstLevelBodyArray.push(_loc6_);
               this.SecondLevelBodyArray.push(_loc9_);
            }
         }
         this.FirstLevelBodyArray.sortOn("Id",Array.NUMERIC);
         this.SecondLevelBodyArray.sortOn("Id",Array.NUMERIC);
         this.BodyArray.sortOn("Id",Array.NUMERIC);
         this.NextBodyArray.sortOn("Id",Array.NUMERIC);
         if(param2)
         {
            this.PageIndex = 0;
         }
         this.ShowBodyListCurPage();
         this.ClearBodyInfo();
      }
      
      private function ShowBodyListCurPage() : void
      {
         var _loc2_:ShipbodyInfo = null;
         var _loc4_:MovieClip = null;
         var _loc5_:int = 0;
         this.tf_page.text = this.PageIndex + 1 + "";
         var _loc1_:int = this.PageIndex * 5;
         var _loc3_:int = 0;
         while(_loc3_ < 5)
         {
            _loc4_ = this.UpgradeItemList.getChildByName("mc_plan" + _loc3_) as MovieClip;
            _loc4_.visible = false;
            _loc4_ = this.UpgradeItemList.getChildByName("mc_list" + _loc3_) as MovieClip;
            _loc4_.visible = true;
            if(_loc1_ < this.BodyArray.length)
            {
               _loc2_ = this.BodyArray[_loc1_];
               this.ShowBody(_loc2_,_loc4_);
            }
            else
            {
               _loc5_ = _loc1_ - this.BodyArray.length;
               if(_loc5_ < this.FirstLevelBodyArray.length)
               {
                  _loc2_ = this.FirstLevelBodyArray[_loc5_];
                  this.ShowBody(_loc2_,_loc4_,true);
               }
               else
               {
                  _loc4_.visible = false;
               }
            }
            _loc1_++;
            _loc3_++;
         }
         this.ResetSelectedItem();
         this.ResetPageButton();
      }
      
      private function ShowBody(param1:ShipbodyInfo, param2:MovieClip, param3:Boolean = false) : void
      {
         param2.visible = true;
         var _loc4_:MovieClip = param2.mc_base;
         if(_loc4_.numChildren > 0)
         {
            _loc4_.removeChildAt(0);
         }
         var _loc5_:Bitmap = new Bitmap(GameKernel.getTextureInstance(param1.SmallIcon));
         _loc5_.x = -5;
         _loc5_.y = 0;
         _loc5_.filters = this.filter.getFilter(param3);
         if(param3)
         {
            _loc5_.alpha = 0.5;
         }
         else
         {
            _loc5_.alpha = 1;
         }
         _loc4_.addChild(_loc5_);
      }
      
      private function ShowPartList(param1:int, param2:Boolean = true) : void
      {
         var _loc4_:Array = null;
         var _loc5_:ShippartInfo = null;
         var _loc7_:ShippartInfo = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:ShippartInfo = null;
         var _loc11_:String = null;
         var _loc12_:ShippartInfo = null;
         var _loc3_:HashSet = CShipmodelReader.getInstance().GetFirstLevelPart(param1);
         this.ResetPartShow(param1);
         this.CurSelectedChildType = param1;
         if(!CShipmodelReader.getInstance()._PartFuncTypeList.ContainsKey(param1))
         {
            return;
         }
         _loc4_ = CShipmodelReader.getInstance()._PartFuncTypeList.Get(param1);
         this.PartArray.splice(0);
         this.NextPartArray.splice(0);
         var _loc6_:int = 0;
         while(_loc6_ < ShipmodelRouter.instance.ShipPartIds.length)
         {
            _loc8_ = int(ShipmodelRouter.instance.ShipPartIds[_loc6_]);
            _loc5_ = CShipmodelReader.getInstance().getShipPartInfo(_loc8_);
            for each(_loc9_ in _loc4_)
            {
               if(_loc5_.KindId == _loc9_)
               {
                  _loc10_ = CShipmodelReader.getInstance().GetNextLevelPart(_loc5_);
                  if(_loc10_ != null)
                  {
                     this.PartArray.push(_loc5_);
                     this.NextPartArray.push(_loc10_);
                  }
                  _loc11_ = _loc5_.KindId + "," + _loc5_.GroupID;
                  _loc3_.Remove(_loc11_);
                  break;
               }
            }
            _loc6_++;
         }
         this.FirstLevelPartArray.splice(0);
         this.SecondLevelPartArray.splice(0);
         for each(_loc7_ in _loc3_.Values())
         {
            _loc12_ = CShipmodelReader.getInstance().GetNextLevelPart(_loc7_);
            if(_loc12_ != null)
            {
               this.FirstLevelPartArray.push(_loc7_);
               this.SecondLevelPartArray.push(_loc12_);
            }
         }
         this.FirstLevelPartArray.sortOn("Id",Array.NUMERIC);
         this.SecondLevelPartArray.sortOn("Id",Array.NUMERIC);
         this.PartArray.sortOn("Id",Array.NUMERIC);
         this.NextPartArray.sortOn("Id",Array.NUMERIC);
         if(param2)
         {
            this.PageIndex = 0;
         }
         this.ShowPartListCurPage();
         this.ClearPartInfo();
      }
      
      private function ResetPartShow(param1:int) : void
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:DisplayObject = null;
         if(param1 == 0)
         {
            _loc2_ = this.PartInfoList.mc_gongjili0 as DisplayObject;
            _loc2_.visible = true;
            _loc2_.y = this.LastY1;
            _loc2_ = this.PartInfoList.mc_shecheng0 as DisplayObject;
            _loc2_.visible = true;
            _loc2_.y = this.LastY2;
            _loc2_ = this.PartInfoList.mc_gongjili1 as DisplayObject;
            _loc2_.visible = true;
            _loc2_.y = this.LastY1;
            _loc2_ = this.PartInfoList.mc_shecheng1 as DisplayObject;
            _loc2_.visible = true;
            _loc2_.y = this.LastY2;
            _loc2_ = this.PartInfoList.pic_gongjili0 as DisplayObject;
            _loc2_.visible = true;
            _loc2_.y = this.LastY1 - 2;
            _loc2_ = this.PartInfoList.pic_shecheng0 as DisplayObject;
            _loc2_.visible = true;
            _loc2_.y = this.LastY2 - 2;
            _loc2_ = this.PartInfoList.pic_gongjili1 as DisplayObject;
            _loc2_.visible = true;
            _loc2_.y = this.LastY1 - 2;
            _loc2_ = this.PartInfoList.pic_shecheng1 as DisplayObject;
            _loc2_.visible = true;
            _loc2_.y = this.LastY2 - 2;
            _loc2_ = this.PartInfoList.mc_huihe0 as DisplayObject;
            _loc2_.y = this.LastY3;
            _loc2_ = this.PartInfoList.mc_tiji0 as DisplayObject;
            _loc2_.y = this.LastY4;
            _loc2_ = this.PartInfoList.mc_huihe1 as DisplayObject;
            _loc2_.y = this.LastY3;
            _loc2_ = this.PartInfoList.mc_tiji1 as DisplayObject;
            _loc2_.y = this.LastY4;
            _loc2_ = this.PartInfoList.pic_huihe0 as DisplayObject;
            _loc2_.y = this.LastY3 - 2;
            _loc2_ = this.PartInfoList.pic_tiji0 as DisplayObject;
            _loc2_.y = this.LastY4 - 2;
            _loc2_ = this.PartInfoList.pic_huihe1 as DisplayObject;
            _loc2_.y = this.LastY3 - 2;
            _loc2_ = this.PartInfoList.pic_tiji1 as DisplayObject;
            _loc2_.y = this.LastY4 - 2;
         }
         else
         {
            _loc3_ = this.PartInfoList.mc_gongjili0 as DisplayObject;
            _loc3_.visible = false;
            _loc3_ = this.PartInfoList.mc_shecheng0 as DisplayObject;
            _loc3_.visible = false;
            _loc3_ = this.PartInfoList.mc_gongjili1 as DisplayObject;
            _loc3_.visible = false;
            _loc3_ = this.PartInfoList.mc_shecheng1 as DisplayObject;
            _loc3_.visible = false;
            _loc3_ = this.PartInfoList.pic_gongjili0 as DisplayObject;
            _loc3_.visible = false;
            _loc3_ = this.PartInfoList.pic_shecheng0 as DisplayObject;
            _loc3_.visible = false;
            _loc3_ = this.PartInfoList.pic_gongjili1 as DisplayObject;
            _loc3_.visible = false;
            _loc3_ = this.PartInfoList.pic_shecheng1 as DisplayObject;
            _loc3_.visible = false;
            _loc3_ = this.PartInfoList.mc_huihe0 as DisplayObject;
            _loc3_.y = this.LastY1;
            _loc3_ = this.PartInfoList.mc_tiji0 as DisplayObject;
            _loc3_.y = this.LastY2;
            _loc3_ = this.PartInfoList.mc_huihe1 as DisplayObject;
            _loc3_.y = this.LastY1;
            _loc3_ = this.PartInfoList.mc_tiji1 as DisplayObject;
            _loc3_.y = this.LastY2;
            _loc3_ = this.PartInfoList.pic_huihe0 as DisplayObject;
            _loc3_.y = this.LastY1 - 2;
            _loc3_ = this.PartInfoList.pic_tiji0 as DisplayObject;
            _loc3_.y = this.LastY2 - 2;
            _loc3_ = this.PartInfoList.pic_huihe1 as DisplayObject;
            _loc3_.y = this.LastY1 - 2;
            _loc3_ = this.PartInfoList.pic_tiji1 as DisplayObject;
            _loc3_.y = this.LastY2 - 2;
         }
      }
      
      private function ShowPartListCurPage() : void
      {
         var _loc2_:ShippartInfo = null;
         var _loc4_:MovieClip = null;
         var _loc5_:int = 0;
         this.tf_page.text = this.PageIndex + 1 + "";
         var _loc1_:int = this.PageIndex * 5;
         var _loc3_:int = 0;
         while(_loc3_ < 5)
         {
            _loc4_ = this.UpgradeItemList.getChildByName("mc_list" + _loc3_) as MovieClip;
            _loc4_.visible = false;
            _loc4_ = this.UpgradeItemList.getChildByName("mc_plan" + _loc3_) as MovieClip;
            _loc4_.visible = true;
            if(_loc1_ < this.PartArray.length)
            {
               _loc2_ = this.PartArray[_loc1_];
               this.ShowPart(_loc2_,_loc4_);
            }
            else
            {
               _loc5_ = _loc1_ - this.PartArray.length;
               if(_loc5_ < this.FirstLevelPartArray.length)
               {
                  _loc2_ = this.FirstLevelPartArray[_loc5_];
                  this.ShowPart(_loc2_,_loc4_,true);
               }
               else
               {
                  _loc4_.visible = false;
               }
            }
            _loc1_++;
            _loc3_++;
         }
         this.ResetSelectedItem();
         this.ResetPageButton();
      }
      
      private function ShowPart(param1:ShippartInfo, param2:MovieClip, param3:Boolean = false) : void
      {
         var _loc5_:Bitmap = null;
         param2.visible = true;
         var _loc4_:MovieClip = param2.mc_base;
         if(_loc4_.numChildren > 0)
         {
            _loc4_.removeChildAt(0);
         }
         _loc5_ = new Bitmap(GameKernel.getTextureInstance(param1.ImageFileName));
         _loc5_.filters = this.filter.getFilter(param3);
         if(param3)
         {
            _loc5_.alpha = 0.5;
         }
         else
         {
            _loc5_.alpha = 1;
         }
         _loc4_.addChild(_loc5_);
      }
      
      private function Close(param1:Event) : void
      {
         if(this.mc_ligth)
         {
            this.mc_ligth.stop();
         }
         this.UpgradeTimer.stop();
         GameKernel.popUpDisplayManager.Hide(this);
      }
      
      private function BodyBtnClick(param1:Event) : void
      {
         if(this.mc_module)
         {
            this.mc_module.visible = false;
         }
         this.ResetSelectedTypeBtn(this.BodyButton);
         if(this.CurSelectedType == 0)
         {
            return;
         }
         if(this.SelectedItem != null)
         {
            this.SelectedItem.gotoAndStop("up");
         }
         this.SelectedItem = null;
         this.CurSelectedType = 0;
         this.HidePartInfo();
         this.GotoCurUpgradeBody();
      }
      
      private function btn_qijianClick(param1:MouseEvent) : void
      {
         if(this.mc_module)
         {
            this.mc_module.visible = true;
         }
         this.ResetSelectedTypeBtn(this.btn_qijian);
         if(this.SelectedItem != null)
         {
            this.SelectedItem.gotoAndStop("up");
         }
         this.SelectedItem = null;
         this.CurSelectedType = 2;
         this.HidePartAndBody();
         this.InitChip();
         this.ShowBodyList(5);
      }
      
      private function InitChip() : void
      {
         var _loc4_:propsInfo = null;
         this.FlagChipInfo = null;
         var _loc1_:Array = ScienceSystem.getinstance().Packarr;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc4_ = CPropsReader.getInstance().GetPropsInfo(_loc1_[_loc2_].PropsId);
            if(_loc4_.List == 36)
            {
               this.FlagChipInfo = new PackPropsInfo();
               this.FlagChipInfo._PropsInfo = _loc4_;
               this.FlagChipInfo.Num = _loc1_[_loc2_].PropsNum;
               this.FlagChipInfo.LockFlag = _loc1_[_loc2_].LockFlag;
               break;
            }
            _loc2_++;
         }
         if(this.FlagChipInfo == null)
         {
            this.FlagChipInfo = new PackPropsInfo();
            this.FlagChipInfo.Num = 0;
         }
         var _loc3_:Sprite = Sprite(this._mc.getMC().mc_module.mc_base);
         if(_loc3_.numChildren > 0)
         {
            _loc3_.removeChildAt(0);
         }
         _loc3_.addChildAt(new Bitmap(GameKernel.getTextureInstance("Props3006")),0);
         TextField(this._mc.getMC().mc_module.txt_num).text = this.FlagChipInfo.Num.toString();
      }
      
      private function HidePartAndBody() : void
      {
         this.PartInfoList.visible = false;
         this.BodyInfoList.visible = true;
         this._mc.getMC().btn_attack.visible = false;
         this._mc.getMC().btn_defense.visible = false;
         this._mc.getMC().btn_assistant.visible = false;
         this._mc.getMC().btn_frigate.visible = false;
         this._mc.getMC().btn_warship.visible = false;
         this._mc.getMC().btn_cruiser.visible = false;
         this._mc.getMC().btn_others.visible = false;
      }
      
      private function GotoCurUpgradeBody() : void
      {
         var _loc1_:ShipbodyInfo = null;
         if(UpgradeRouter.instance.CurUpgradeBodyId < 0)
         {
            this.FrigateBtnClick(null);
         }
         else
         {
            _loc1_ = CShipmodelReader.getInstance().getShipBodyInfo(UpgradeRouter.instance.CurUpgradeBodyId);
            if(_loc1_.KindId == 0)
            {
               this.FrigateBtnClick(null);
            }
            else if(_loc1_.KindId == 2)
            {
               this.WarshipBtnClick(null);
            }
            else if(_loc1_.KindId == 1)
            {
               this.CruiserBtnClick(null);
            }
            else
            {
               this.OthersBtnClick(null);
            }
            this.LocationToUpgradeBody();
         }
      }
      
      private function LocationToUpgradeBody() : void
      {
         var _loc1_:int = 0;
         var _loc3_:ShipbodyInfo = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.BodyArray.length)
         {
            _loc3_ = this.BodyArray[_loc2_];
            if(_loc3_.Id == UpgradeRouter.instance.CurUpgradeBodyId)
            {
               this.CanUpdate = true;
               this.SelectItem(_loc2_);
            }
            _loc2_++;
         }
      }
      
      private function LocationBody(param1:int) : void
      {
         if(UpgradeRouter.instance.CurUpgradeBodyId < 0)
         {
            return;
         }
         var _loc2_:ShipbodyInfo = CShipmodelReader.getInstance().getShipBodyInfo(UpgradeRouter.instance.CurUpgradeBodyId);
         if(_loc2_.KindId == param1)
         {
            this.LocationToUpgradeBody();
         }
      }
      
      private function GotoCurUpgradePart() : void
      {
         var _loc1_:ShippartInfo = null;
         if(UpgradeRouter.instance.CurUpgradePartId < 0)
         {
            this.AttackBtnClick(null);
         }
         else
         {
            _loc1_ = CShipmodelReader.getInstance().getShipPartInfo(UpgradeRouter.instance.CurUpgradePartId);
            if(_loc1_.FuncTypeId == 0)
            {
               this.AttackBtnClick(null);
            }
            else if(_loc1_.FuncTypeId == 1)
            {
               this.DefenseBtnClick(null);
            }
            else
            {
               this.AssistantBtnClick(null);
            }
            this.LocationToUpgradePart();
         }
      }
      
      private function LocationToUpgradePart() : void
      {
         var _loc1_:int = 0;
         var _loc3_:ShippartInfo = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.PartArray.length)
         {
            _loc3_ = this.PartArray[_loc2_];
            if(_loc3_.Id == UpgradeRouter.instance.CurUpgradePartId)
            {
               this.CanUpdate = true;
               this.SelectItem(_loc2_);
            }
            _loc2_++;
         }
      }
      
      private function LocationPart(param1:int) : void
      {
         if(UpgradeRouter.instance.CurUpgradePartId < 0)
         {
            return;
         }
         var _loc2_:ShippartInfo = CShipmodelReader.getInstance().getShipPartInfo(UpgradeRouter.instance.CurUpgradePartId);
         if(_loc2_.FuncTypeId == param1)
         {
            this.LocationToUpgradePart();
         }
      }
      
      private function SelectItem(param1:int) : void
      {
         this.PageIndex = param1 / 5;
         var _loc2_:int = param1 % 5;
         if(this.SelectedItem != null)
         {
            this.SelectedItem.gotoAndStop("up");
         }
         if(this.CurSelectedType == 0 || this.CurSelectedType == 2)
         {
            this.ShowBodyListCurPage();
            this.SelectedItem = this.UpgradeItemList.getChildByName("mc_list" + _loc2_) as MovieClip;
            this.SelectedItem.gotoAndStop("selected");
         }
         else
         {
            this.ShowPartListCurPage();
            this.SelectedItem = this.UpgradeItemList.getChildByName("mc_plan" + _loc2_) as MovieClip;
            this.SelectedItem.gotoAndStop("selected");
         }
         this.SelectedIndex = param1;
         this.SelectedPage = this.PageIndex;
         this.SelectedType = this.CurSelectedChildType;
         this.ShowSelectedItem();
      }
      
      private function FrigateBtnClick(param1:Event) : void
      {
         this.ResetSelectedChildBtn(this.btn_frigate);
         this.ShowBodyList(0);
         if(param1 != null)
         {
            this.LocationBody(0);
         }
      }
      
      private function WarshipBtnClick(param1:Event) : void
      {
         this.ResetSelectedChildBtn(this.btn_warship);
         this.ShowBodyList(2);
         if(param1 != null)
         {
            this.LocationBody(2);
         }
      }
      
      private function CruiserBtnClick(param1:Event) : void
      {
         this.ResetSelectedChildBtn(this.btn_cruiser);
         this.ShowBodyList(1);
         if(param1 != null)
         {
            this.LocationBody(1);
         }
      }
      
      private function OthersBtnClick(param1:Event) : void
      {
         this.ResetSelectedChildBtn(this.btn_others);
         this.ShowBodyList(4);
         if(param1 != null)
         {
            this.LocationBody(4);
         }
      }
      
      private function PartBtnClick(param1:Event) : void
      {
         if(this.mc_module)
         {
            this.mc_module.visible = false;
         }
         this.ResetSelectedTypeBtn(this.PartButton);
         if(this.CurSelectedType == 1)
         {
            return;
         }
         if(this.SelectedItem != null)
         {
            this.SelectedItem.gotoAndStop("up");
         }
         this.SelectedItem = null;
         this.CurSelectedType = 1;
         this.HideBodyInfo();
         this.GotoCurUpgradePart();
      }
      
      private function ResetSelectedTypeBtn(param1:HButton) : void
      {
         if(this.SelectedTypeBtn != null)
         {
            this.SelectedTypeBtn.setSelect(false);
         }
         this.SelectedTypeBtn = param1;
         this.SelectedTypeBtn.setSelect(true);
      }
      
      private function ResetSelectedChildBtn(param1:HButton) : void
      {
         if(this.SelectedChildBtn != null)
         {
            this.SelectedChildBtn.setSelect(false);
         }
         this.SelectedChildBtn = param1;
         this.SelectedChildBtn.setSelect(true);
      }
      
      private function AttackBtnClick(param1:Event) : void
      {
         this.ResetSelectedChildBtn(this.btn_attack);
         this.ShowPartList(0);
         if(param1 != null)
         {
            this.LocationPart(0);
         }
      }
      
      private function DefenseBtnClick(param1:Event) : void
      {
         this.ResetSelectedChildBtn(this.btn_defense);
         this.ShowPartList(1);
         if(param1 != null)
         {
            this.LocationPart(1);
         }
      }
      
      private function AssistantBtnClick(param1:Event) : void
      {
         this.ResetSelectedChildBtn(this.btn_assistant);
         this.ShowPartList(2);
         if(param1 != null)
         {
            this.LocationPart(2);
         }
      }
      
      private function LeftBtnClick(param1:Event) : void
      {
         --this.PageIndex;
         if(this.CurSelectedType == 0 || this.CurSelectedType == 2)
         {
            this.ShowBodyListCurPage();
         }
         else
         {
            this.ShowPartListCurPage();
         }
      }
      
      private function RightBtnClick(param1:Event) : void
      {
         if(this.CurSelectedType == 0 || this.CurSelectedType == 2)
         {
            ++this.PageIndex;
            this.ShowBodyListCurPage();
         }
         else
         {
            ++this.PageIndex;
            this.ShowPartListCurPage();
         }
      }
      
      private function ResetPageButton() : void
      {
         var _loc1_:int = 0;
         if(this.CurSelectedType == 0 || this.CurSelectedType == 2)
         {
            _loc1_ = int(this.BodyArray.length + this.FirstLevelBodyArray.length);
         }
         else
         {
            _loc1_ = int(this.PartArray.length + this.FirstLevelPartArray.length);
         }
         if(this.PageIndex > 0)
         {
            this.btn_up.setBtnDisabled(false);
         }
         else
         {
            this.btn_up.setBtnDisabled(true);
         }
         if((this.PageIndex + 1) * 5 < _loc1_)
         {
            this.btn_down.setBtnDisabled(false);
         }
         else
         {
            this.btn_down.setBtnDisabled(true);
         }
      }
      
      private function ResetSelectedItem() : void
      {
         if(this.SelectedItem != null)
         {
            if(this.SelectedPage == this.PageIndex && this.SelectedType == this.CurSelectedChildType)
            {
               this.SelectedItem.gotoAndStop("selected");
            }
            else
            {
               this.SelectedItem.gotoAndStop("up");
            }
         }
      }
      
      private function ItemClick(param1:MouseEvent, param2:XMovieClip) : void
      {
         var _loc3_:int = this.PageIndex * 5 + param2.Data;
         if(this.CurSelectedType == 0 || this.CurSelectedType == 2)
         {
            this.CanUpdate = _loc3_ < this.BodyArray.length;
         }
         else
         {
            this.CanUpdate = _loc3_ < this.PartArray.length;
         }
         if(this.SelectedType == this.CurSelectedChildType && this.PageIndex == this.SelectedPage && this.SelectedItem == param1.target)
         {
            return;
         }
         if(this.SelectedItem != null)
         {
            this.SelectedItem.gotoAndStop("up");
         }
         this.SelectedItem = param2.m_movie;
         param2.m_movie.gotoAndStop("selected");
         this.SelectedIndex = _loc3_;
         this.SelectedPage = this.PageIndex;
         this.SelectedType = this.CurSelectedChildType;
         this.ShowSelectedItem();
      }
      
      private function ShowSelectedItem() : void
      {
         if(this.CurSelectedType == 0 || this.CurSelectedType == 2)
         {
            this.ShowSelectedBody();
         }
         else
         {
            this.ShowSelectedPart();
         }
         this._ShowUpgradeInfo();
      }
      
      private function ShowSelectedBody() : void
      {
         var _loc1_:ShipbodyInfo = null;
         var _loc2_:ShipbodyInfo = null;
         if(this.CanUpdate)
         {
            _loc1_ = this.BodyArray[this.SelectedIndex];
            _loc2_ = this.NextBodyArray[this.SelectedIndex];
         }
         else
         {
            _loc1_ = this.FirstLevelBodyArray[this.SelectedIndex - this.BodyArray.length];
            _loc2_ = this.SecondLevelBodyArray[this.SelectedIndex - this.BodyArray.length];
         }
         this._BodyInfo.Shield1 = _loc1_._Shield;
         this._BodyInfo.Endure1 = _loc1_._Endure;
         this._BodyInfo.Locomotivity1 = _loc1_.Locomotivity;
         this._BodyInfo.Storage1 = _loc1_.Storage;
         this._BodyInfo.Cubage1 = _loc1_.Cubage;
         this._BodyInfo.TransitionTime1 = _loc1_.TransitionTime;
         this._BodyInfo.CreateTime1 = _loc1_.CreateTime;
         this._BodyInfo.cash1 = _loc1_.Money;
         this._BodyInfo.metal1 = _loc1_.Metal;
         this._BodyInfo.he31 = _loc1_.He3;
         this._BodyInfo.Shield2 = _loc2_._Shield;
         this._BodyInfo.Endure2 = _loc2_._Endure;
         this._BodyInfo.Locomotivity2 = _loc2_.Locomotivity;
         this._BodyInfo.Storage2 = _loc2_.Storage;
         this._BodyInfo.Cubage2 = _loc2_.Cubage;
         this._BodyInfo.TransitionTime2 = _loc2_.TransitionTime;
         this._BodyInfo.CreateTime2 = _loc2_.CreateTime;
         this._BodyInfo.cash2 = _loc2_.Money;
         this._BodyInfo.metal2 = _loc2_.Metal;
         this._BodyInfo.he32 = _loc2_.He3;
         this.ShowBodyInfo();
      }
      
      private function ShowSelectedPart() : void
      {
         var _loc1_:ShippartInfo = null;
         var _loc2_:ShippartInfo = null;
         if(this.CanUpdate)
         {
            _loc1_ = this.PartArray[this.SelectedIndex];
            _loc2_ = this.NextPartArray[this.SelectedIndex];
         }
         else
         {
            _loc1_ = this.FirstLevelPartArray[this.SelectedIndex - this.PartArray.length];
            _loc2_ = this.SecondLevelPartArray[this.SelectedIndex - this.PartArray.length];
         }
         this._PartInfo.PartAssault1 = _loc1_._MaxAssault;
         this._PartInfo.PartRange1 = _loc1_._MaxRange;
         this._PartInfo.Backfill1 = _loc1_._Backfill;
         this._PartInfo.PartCubage1 = _loc1_._Cubage;
         this._PartInfo.PartSupply1 = _loc1_._Supply;
         this._PartInfo.cash1 = _loc1_.Money;
         this._PartInfo.metal1 = _loc1_.Metal;
         this._PartInfo.he31 = _loc1_.He3;
         this._PartInfo.PartAssault2 = _loc2_._MaxAssault;
         this._PartInfo.PartRange2 = _loc2_._MaxRange;
         this._PartInfo.Backfill2 = _loc2_._Backfill;
         this._PartInfo.PartCubage2 = _loc2_._Cubage;
         this._PartInfo.PartSupply2 = _loc2_._Supply;
         this._PartInfo.cash2 = _loc2_.Money;
         this._PartInfo.metal2 = _loc2_.Metal;
         this._PartInfo.he32 = _loc2_.He3;
         this.ShowPartInfo();
      }
      
      private function UpgradeClick(param1:Event) : void
      {
         var _loc2_:ShipbodyInfo = null;
         var _loc3_:MSG_REQUEST_UPGRADEFLAGSHIP = null;
         if(this.SelectedIndex == -1)
         {
            return;
         }
         if(this._UpgradeInfo.UpgradeMoney > GamePlayer.getInstance().UserMoney)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("UpgradeText1"),0);
            return;
         }
         if(this.CurSelectedType == 0)
         {
            this.RequestUpgradeBody();
         }
         else if(this.CurSelectedType == 1)
         {
            this.RequestUpgradePart();
         }
         else
         {
            _loc2_ = this.BodyArray[this.SelectedIndex];
            if(_loc2_.UpgradeTime > this.FlagChipInfo.Num)
            {
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss65"),0);
               return;
            }
            if(_loc2_.UpgradeMoney > GamePlayer.getInstance().UserMoney)
            {
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CorpsText165"),0);
               return;
            }
            _loc3_ = new MSG_REQUEST_UPGRADEFLAGSHIP();
            _loc3_.ShipBodyId = _loc2_.Id;
            _loc3_.SeqId = GamePlayer.getInstance().seqID++;
            _loc3_.Guid = GamePlayer.getInstance().Guid;
            NetManager.Instance().sendObject(_loc3_);
            this.Invalid(false);
         }
      }
      
      public function Resp_MSG_RESP_UPGRADEFLAGSHIP(param1:MSG_RESP_UPGRADEFLAGSHIP) : void
      {
         var _loc5_:int = 0;
         this.Invalid(true);
         var _loc2_:ShipbodyInfo = CShipmodelReader.getInstance().getShipBodyInfo(param1.ShipBodyId);
         UpdateResource.getInstance().DeleteProps(this.FlagChipInfo._PropsInfo.Id,1,_loc2_.UpgradeTime);
         GamePlayer.getInstance().UserMoney = GamePlayer.getInstance().UserMoney - _loc2_.UpgradeMoney;
         ResPlaneUI.getInstance().updateResPlane();
         var _loc3_:ShipbodyInfo = CShipmodelReader.getInstance().GetNextLevelBody(_loc2_);
         var _loc4_:int = 0;
         while(_loc4_ < ShipmodelRouter.instance.ShipBodyIds.length)
         {
            _loc5_ = int(ShipmodelRouter.instance.ShipBodyIds[_loc4_]);
            if(_loc5_ == param1.ShipBodyId)
            {
               ShipmodelRouter.instance.ShipBodyIds[_loc4_] = _loc3_.Id;
            }
            _loc4_++;
         }
         this.btn_qijianClick(null);
      }
      
      private function RequestUpgradeBody() : void
      {
         var _loc1_:MSG_REQUEST_SHIPBODYUPGRADE = new MSG_REQUEST_SHIPBODYUPGRADE();
         _loc1_.Type = 0;
         var _loc2_:ShipbodyInfo = this.BodyArray[this.SelectedIndex];
         _loc1_.BodyPartId = _loc2_.Id;
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         _loc1_.CancelFlag = 0;
         NetManager.Instance().sendObject(_loc1_);
      }
      
      private function RequestUpgradePart() : void
      {
         var _loc1_:MSG_REQUEST_SHIPBODYUPGRADE = new MSG_REQUEST_SHIPBODYUPGRADE();
         _loc1_.Type = 1;
         var _loc2_:ShippartInfo = this.PartArray[this.SelectedIndex];
         _loc1_.BodyPartId = _loc2_.Id;
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         _loc1_.CancelFlag = 0;
         NetManager.Instance().sendObject(_loc1_);
      }
      
      private function CancelClick(param1:Event) : void
      {
         MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("UpgradeText5"),2,this.OnCancelUpgrade);
      }
      
      private function OnCancelUpgrade() : void
      {
         if(this.CurSelectedType == 0)
         {
            this.RequestCancelUpgradeBody();
         }
         else
         {
            this.RequestCancelUpgradePart();
         }
      }
      
      private function RequestCancelUpgradeBody() : void
      {
         var _loc1_:MSG_REQUEST_SHIPBODYUPGRADE = new MSG_REQUEST_SHIPBODYUPGRADE();
         _loc1_.Type = 0;
         var _loc2_:ShipbodyInfo = this.BodyArray[this.SelectedIndex];
         _loc1_.BodyPartId = _loc2_.Id;
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         _loc1_.CancelFlag = 1;
         NetManager.Instance().sendObject(_loc1_);
      }
      
      private function RequestCancelUpgradePart() : void
      {
         var _loc1_:MSG_REQUEST_SHIPBODYUPGRADE = new MSG_REQUEST_SHIPBODYUPGRADE();
         _loc1_.Type = 1;
         var _loc2_:ShippartInfo = this.PartArray[this.SelectedIndex];
         _loc1_.BodyPartId = _loc2_.Id;
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         _loc1_.CancelFlag = 1;
         NetManager.Instance().sendObject(_loc1_);
      }
      
      private function RequestSpeedUp(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc5_:MSG_REQUEST_SPEEDSHIPBODYUPGRADE = new MSG_REQUEST_SPEEDSHIPBODYUPGRADE();
         _loc5_.BodyPartId = param1;
         _loc5_.Type = param2;
         _loc5_.SpeedId = param3;
         _loc5_.FeeType = param4;
         _loc5_.SeqId = GamePlayer.getInstance().seqID++;
         _loc5_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc5_);
      }
      
      public function GetUpgradeInfo(param1:Function) : void
      {
         GameMouseZoneManager.isEnterSearch = true;
         UpgradeRouter.instance.GetUpgradeInfoCallback = param1;
         this.RequestUpgradeInfo();
      }
      
      private function RequestUpgradeInfo() : void
      {
         var _loc1_:MSG_REQUEST_SHIPBODYUPGRADEINFO = new MSG_REQUEST_SHIPBODYUPGRADEINFO();
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc1_);
      }
      
      public function ShowUpgradeInfo(param1:MSG_RESP_SHIPBODYUPGRADE) : void
      {
         if(param1 != null)
         {
            ConstructionAction.getInstance().costResource(param1.Gas,param1.Metal,param1.Money);
         }
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            this._ShowUpgradeInfo();
         }
      }
      
      private function ClearUpgradeInfo() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:MovieClip = null;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:TextField = null;
         _loc1_ = this._mc.getMC().btn_change as MovieClip;
         _loc1_.visible = false;
         _loc2_ = this._mc.getMC().btn_cancel as MovieClip;
         _loc2_.visible = false;
         _loc3_ = this._mc.getMC().btn_speed as MovieClip;
         _loc3_.visible = false;
         _loc4_ = this._mc.getMC().mc_airshipbase as MovieClip;
         if(_loc4_.numChildren)
         {
            _loc4_.removeChildAt(0);
         }
         _loc5_ = this._mc.getMC().tf_name as TextField;
         _loc5_.text = "";
         _loc4_ = this._mc.getMC().mc_changeairshipbase as MovieClip;
         if(_loc4_.numChildren)
         {
            _loc4_.removeChildAt(0);
         }
         _loc5_ = this._mc.getMC().tf_changename as TextField;
         _loc5_.text = "";
         _loc5_ = this._mc.getMC().tf_time as TextField;
         _loc5_.text = "";
         _loc4_ = this._mc.getMC().mc_planbar as MovieClip;
         _loc4_.visible = false;
         _loc5_ = this._mc.getMC().tf_changeHe3 as TextField;
         _loc5_.text = "";
      }
      
      private function _ShowUpgradeInfo() : void
      {
         var _loc1_:ShipbodyInfo = null;
         var _loc2_:ShipbodyInfo = null;
         var _loc3_:ShippartInfo = null;
         var _loc4_:ShippartInfo = null;
         var _loc5_:MovieClip = null;
         var _loc6_:MovieClip = null;
         var _loc7_:MovieClip = null;
         var _loc8_:MovieClip = null;
         var _loc9_:TextField = null;
         var _loc10_:Bitmap = null;
         var _loc11_:Bitmap = null;
         var _loc13_:TextField = null;
         var _loc14_:TextField = null;
         var _loc15_:TextField = null;
         var _loc16_:TextField = null;
         _loc5_ = this._mc.getMC().btn_change as MovieClip;
         _loc5_.visible = false;
         _loc6_ = this._mc.getMC().btn_cancel as MovieClip;
         _loc6_.visible = false;
         _loc7_ = this._mc.getMC().btn_speed as MovieClip;
         _loc7_.visible = false;
         if(this.CurSelectedType == 0 && UpgradeRouter.instance.CurUpgradeBodyId == -1 && this.CanUpdate)
         {
            _loc5_.visible = true;
         }
         else if(this.CurSelectedType == 1 && UpgradeRouter.instance.CurUpgradePartId == -1 && this.CanUpdate)
         {
            _loc5_.visible = true;
         }
         else if(this.CurSelectedType == 2 && this.CanUpdate)
         {
            _loc5_.visible = true;
         }
         if(this.SelectedItem == null)
         {
            this.ClearUpgradeInfo();
            return;
         }
         if(this.CurSelectedType != 1 && this.SelectedIndex >= 0)
         {
            if(this.CanUpdate)
            {
               _loc1_ = this.BodyArray[this.SelectedIndex];
            }
            else
            {
               _loc1_ = this.FirstLevelBodyArray[this.SelectedIndex - this.BodyArray.length];
            }
            if(this.CurSelectedType == 0)
            {
               if(UpgradeRouter.instance.CurUpgradeBodyId == _loc1_.Id)
               {
                  this._UpgradeInfo.NeedTime = UpgradeRouter.instance.CurUpgradeBodyNeedTime;
                  _loc6_.visible = true;
                  _loc7_.visible = true;
               }
               else
               {
                  _loc13_ = this._mc.getMC().tf_time as TextField;
                  _loc13_.text = DataWidget.GetTimeString(_loc1_.UpgradeTime / UpgradeRouter.instance.IncUpgradePercent);
               }
            }
            else
            {
               _loc14_ = this._mc.getMC().tf_time as TextField;
               _loc14_.text = "";
            }
            if(this.CanUpdate)
            {
               _loc2_ = this.NextBodyArray[this.SelectedIndex];
            }
            else
            {
               _loc2_ = this.SecondLevelBodyArray[this.SelectedIndex - this.NextBodyArray.length];
            }
            this._UpgradeInfo.GroupLv = _loc2_.GroupLV;
            this._UpgradeInfo.ImageFileName0 = _loc1_.ImageIcon;
            this._UpgradeInfo.ImageFileName = _loc2_.ImageIcon;
            this._UpgradeInfo.ItemName0 = _loc1_.Name;
            this._UpgradeInfo.ItemName = _loc2_.Name;
            this._UpgradeInfo.UpgradeTime = _loc1_.UpgradeTime;
            this._UpgradeInfo.UpgradeMoney = _loc1_.UpgradeMoney;
         }
         else if(this.CurSelectedType == 1 && this.SelectedIndex >= 0)
         {
            if(this.CanUpdate)
            {
               _loc3_ = this.PartArray[this.SelectedIndex];
            }
            else
            {
               _loc3_ = this.FirstLevelPartArray[this.SelectedIndex - this.PartArray.length];
            }
            if(UpgradeRouter.instance.CurUpgradePartId == _loc3_.Id)
            {
               this._UpgradeInfo.NeedTime = UpgradeRouter.instance.CurUpgradePartNeedTime;
               _loc6_.visible = true;
               _loc7_.visible = true;
            }
            else
            {
               _loc15_ = this._mc.getMC().tf_time as TextField;
               _loc15_.text = DataWidget.GetTimeString(_loc3_.UpgradeTime / UpgradeRouter.instance.IncUpgradePercent);
            }
            if(this.CanUpdate)
            {
               _loc4_ = this.NextPartArray[this.SelectedIndex];
            }
            else
            {
               _loc4_ = this.SecondLevelPartArray[this.SelectedIndex - this.NextPartArray.length];
            }
            this._UpgradeInfo.GroupLv = _loc4_.GroupLV;
            this._UpgradeInfo.ImageFileName0 = _loc3_.ImageFileName;
            this._UpgradeInfo.ImageFileName = _loc4_.ImageFileName;
            this._UpgradeInfo.ItemName0 = _loc3_.Name;
            this._UpgradeInfo.ItemName = _loc4_.Name;
            this._UpgradeInfo.UpgradeTime = _loc3_.UpgradeTime;
            this._UpgradeInfo.UpgradeMoney = _loc3_.UpgradeMoney;
         }
         _loc8_ = this._mc.getMC().mc_airshipbase as MovieClip;
         if(_loc8_.numChildren)
         {
            _loc8_.removeChildAt(0);
         }
         if(this.CurSelectedType == 0 || this.CurSelectedType == 2)
         {
            _loc10_ = new Bitmap(GameKernel.getTextureInstance(this._UpgradeInfo.ImageFileName0));
            _loc10_.x = -13;
            _loc10_.y = -7;
            _loc8_.addChild(_loc10_);
         }
         else
         {
            _loc11_ = new Bitmap(GameKernel.getTextureInstance(this._UpgradeInfo.ImageFileName0));
            _loc11_.x = 5;
            _loc11_.y = 5;
            _loc8_.addChild(_loc11_);
         }
         _loc9_ = this._mc.getMC().tf_name as TextField;
         _loc9_.text = this._UpgradeInfo.ItemName0;
         _loc8_ = this._mc.getMC().mc_changeairshipbase as MovieClip;
         if(_loc8_.numChildren)
         {
            _loc8_.removeChildAt(0);
         }
         if(this.CurSelectedType == 0 || this.CurSelectedType == 2)
         {
            _loc10_ = new Bitmap(GameKernel.getTextureInstance(this._UpgradeInfo.ImageFileName));
            _loc10_.x = -13;
            _loc10_.y = -7;
            _loc8_.addChild(_loc10_);
         }
         else
         {
            _loc11_ = new Bitmap(GameKernel.getTextureInstance(this._UpgradeInfo.ImageFileName));
            _loc11_.x = 5;
            _loc11_.y = 5;
            _loc8_.addChild(_loc11_);
         }
         _loc9_ = this._mc.getMC().tf_changename as TextField;
         _loc9_.text = this._UpgradeInfo.ItemName;
         _loc8_ = this._mc.getMC().mc_planbar as MovieClip;
         _loc8_.visible = false;
         _loc9_ = this._mc.getMC().tf_changeHe3 as TextField;
         _loc9_.text = this._UpgradeInfo.UpgradeMoney.toString();
         var _loc12_:TextFormat = _loc9_.getTextFormat();
         if(GamePlayer.getInstance().UserMoney < this._UpgradeInfo.UpgradeMoney)
         {
            _loc12_.color = 16711680;
         }
         else
         {
            _loc12_.color = 65280;
         }
         _loc9_.setTextFormat(_loc12_);
         if(this.CurSelectedType == 2)
         {
            _loc16_ = TextField(this._mc.getMC().mc_module.txt_num);
            if(_loc1_.UpgradeTime > this.FlagChipInfo.Num)
            {
               _loc16_.textColor = 16711680;
            }
            else
            {
               _loc16_.textColor = 65280;
            }
            _loc16_.text = this.FlagChipInfo.Num.toString() + "/" + _loc1_.UpgradeTime;
         }
      }
      
      public function UpgradeOver(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:ShipbodyInfo = null;
         var _loc5_:ShipbodyInfo = null;
         var _loc6_:ShipbodyInfo = null;
         var _loc7_:ShippartInfo = null;
         var _loc8_:ShippartInfo = null;
         var _loc9_:ShippartInfo = null;
         if(param1 == 0)
         {
            if(this.CurSelectedType == 0 && this.SelectedItem != null && this.SelectedIndex < this.BodyArray.length)
            {
               _loc6_ = this.BodyArray[this.SelectedIndex];
               if(_loc6_.Id == param2)
               {
                  this.ClearUpgradeInfo();
                  this.SelectedItem.gotoAndStop("up");
                  this.SelectedItem = null;
               }
            }
            _loc4_ = CShipmodelReader.getInstance().getShipBodyInfo(param2);
            _loc5_ = CShipmodelReader.getInstance().GetNextLevelBody(_loc4_);
            _loc3_ = 0;
            while(_loc3_ < ShipmodelRouter.instance.ShipBodyIds.length)
            {
               if(ShipmodelRouter.instance.ShipBodyIds[_loc3_] == _loc4_.Id)
               {
                  ShipmodelRouter.instance.ShipBodyIds[_loc3_] = _loc5_.Id;
               }
               _loc3_++;
            }
            if(this.CurSelectedType == 0)
            {
               this.ShowBodyList(this.CurSelectedChildType,false);
            }
            MessagePopup.getInstance().Show("\"" + _loc5_.Name + "\"" + StringManager.getInstance().getMessageString("UpgradeText7"),0);
         }
         else
         {
            if(this.CurSelectedType == 1 && this.SelectedItem != null && this.SelectedIndex < this.PartArray.length)
            {
               _loc9_ = this.PartArray[this.SelectedIndex];
               if(_loc9_.Id == param2)
               {
                  this.ClearUpgradeInfo();
                  this.SelectedItem.gotoAndStop("up");
                  this.SelectedItem = null;
               }
            }
            _loc7_ = CShipmodelReader.getInstance().getShipPartInfo(param2);
            _loc8_ = CShipmodelReader.getInstance().GetNextLevelPart(_loc7_);
            _loc3_ = 0;
            while(_loc3_ < ShipmodelRouter.instance.ShipPartIds.length)
            {
               if(ShipmodelRouter.instance.ShipPartIds[_loc3_] == _loc7_.Id)
               {
                  ShipmodelRouter.instance.ShipPartIds[_loc3_] = _loc8_.Id;
               }
               _loc3_++;
            }
            if(this.CurSelectedType == 1)
            {
               this.ShowPartList(this.CurSelectedChildType,false);
            }
            MessagePopup.getInstance().Show("\"" + _loc8_.Name + "\"" + StringManager.getInstance().getMessageString("UpgradeText7"),0);
         }
      }
      
      public function CancelUpgrade(param1:MSG_RESP_SHIPBODYUPGRADE) : void
      {
         ConstructionAction.getInstance().addResource(param1.Gas,param1.Metal,param1.Money);
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            this._ShowUpgradeInfo();
         }
      }
      
      private function OnUpgradeTimer(param1:Event) : void
      {
         var _loc4_:ShipbodyInfo = null;
         var _loc5_:ShippartInfo = null;
         var _loc6_:TextField = null;
         var _loc7_:MovieClip = null;
         var _loc8_:int = 0;
         var _loc2_:int = -1;
         var _loc3_:int = 0;
         if(UpgradeRouter.instance.CurUpgradeBodyId != -1 && UpgradeRouter.instance.CurUpgradeBodyNeedTime > 0)
         {
            --UpgradeRouter.instance.CurUpgradeBodyNeedTime;
            if(this.CurSelectedType == 0 && this.SelectedItem != null && this.SelectedIndex >= 0 && this.SelectedIndex < this.BodyArray.length)
            {
               _loc4_ = this.BodyArray[this.SelectedIndex];
               if(_loc4_ == null)
               {
                  return;
               }
               if(_loc4_.Id == UpgradeRouter.instance.CurUpgradeBodyId)
               {
                  _loc2_ = UpgradeRouter.instance.CurUpgradeBodyNeedTime;
                  _loc4_ = this.BodyArray[this.SelectedIndex];
                  _loc3_ = _loc4_.UpgradeTime;
               }
            }
         }
         if(UpgradeRouter.instance.CurUpgradePartId != -1 && UpgradeRouter.instance.CurUpgradePartNeedTime > 0)
         {
            --UpgradeRouter.instance.CurUpgradePartNeedTime;
            if(this.CurSelectedType == 1 && this.SelectedItem != null && this.SelectedIndex >= 0 && this.SelectedIndex < this.PartArray.length)
            {
               _loc5_ = this.PartArray[this.SelectedIndex];
               if(_loc5_.Id == UpgradeRouter.instance.CurUpgradePartId)
               {
                  _loc2_ = UpgradeRouter.instance.CurUpgradePartNeedTime;
                  _loc5_ = this.PartArray[this.SelectedIndex];
                  _loc3_ = _loc5_.UpgradeTime;
               }
            }
         }
         if(_loc2_ >= 0)
         {
            _loc6_ = this._mc.getMC().tf_time as TextField;
            _loc6_.text = DataWidget.GetTimeString(_loc2_);
            _loc7_ = this._mc.getMC().mc_planbar as MovieClip;
            _loc8_ = 18 * (1 - _loc2_ / _loc3_);
            if(_loc8_ > 0 && _loc8_ <= 18)
            {
               _loc7_.visible = true;
               _loc7_.gotoAndStop(_loc8_);
            }
            else if(_loc8_ == 0)
            {
               _loc7_.visible = false;
            }
         }
      }
      
      private function btn_speedClick(param1:Event) : void
      {
         var _loc2_:int = 0;
         if(this.CurSelectedType == 0)
         {
            _loc2_ = UpgradeRouter.instance.CurUpgradeBodyNeedTime;
         }
         else
         {
            _loc2_ = UpgradeRouter.instance.CurUpgradePartNeedTime;
         }
         var _loc3_:String = DataWidget.localToDataZone(_loc2_);
         ConstructionOperationWidget.currenCmd = OperationEnum.OPERATION_TYPE_BODY_SPEED_UPGRADE;
         ConstructionSpeedPopUp.getInstance().Init();
         ConstructionSpeedPopUp.getInstance().setCredit(ConstructionSpeedReader.SPEED_TYPE_SHIP,_loc2_);
         ConstructionSpeedPopUp.getInstance().setConstructionCostTime(_loc3_);
         GameKernel.renderManager.getUI().addComponent(this.ParentLock);
         GameKernel.popUpDisplayManager.Show(ConstructionSpeedPopUp.getInstance());
      }
      
      public function HideLock() : void
      {
         GameKernel.renderManager.getUI().removeComponent(this.ParentLock);
      }
      
      public function UpgradeSpeed(param1:int, param2:int) : void
      {
         var _loc3_:ShipbodyInfo = null;
         var _loc4_:ShippartInfo = null;
         if(this.CurSelectedType == 0)
         {
            _loc3_ = this.BodyArray[this.SelectedIndex];
            this.RequestSpeedUp(_loc3_.Id,this.CurSelectedType,param2,param1);
         }
         else
         {
            _loc4_ = this.PartArray[this.SelectedIndex];
            this.RequestSpeedUp(_loc4_.Id,this.CurSelectedType,param2,param1);
         }
      }
      
      private function mc_airshipbaseMouseOver(param1:MouseEvent) : void
      {
         var _loc2_:ShipbodyInfo = null;
         var _loc3_:ShippartInfo = null;
         if(this.SelectedIndex < 0)
         {
            return;
         }
         if(this.CurSelectedType == 0 || this.CurSelectedType == 2)
         {
            if(this.CanUpdate)
            {
               _loc2_ = this.BodyArray[this.SelectedIndex];
            }
            else
            {
               _loc2_ = this.FirstLevelBodyArray[this.SelectedIndex - this.BodyArray.length];
            }
            this.ShowBodyTip(_loc2_,this.mc_airshipbasePoint);
         }
         else
         {
            if(this.CanUpdate)
            {
               _loc3_ = this.PartArray[this.SelectedIndex];
            }
            else
            {
               _loc3_ = this.FirstLevelPartArray[this.SelectedIndex - this.PartArray.length];
            }
            this.ShowPartTip(_loc3_,this.mc_airshipbasePoint);
         }
      }
      
      private function mc_airshipbaseMouseOut(param1:MouseEvent) : void
      {
         CustomTip.GetInstance().Hide();
      }
      
      private function mc_changeairshipbaseMouseOver(param1:MouseEvent) : void
      {
         var _loc2_:ShipbodyInfo = null;
         var _loc3_:ShippartInfo = null;
         if(this.SelectedIndex < 0)
         {
            return;
         }
         if(this.CurSelectedType == 0 || this.CurSelectedType == 2)
         {
            if(this.CanUpdate)
            {
               _loc2_ = this.NextBodyArray[this.SelectedIndex];
            }
            else
            {
               _loc2_ = this.SecondLevelBodyArray[this.SelectedIndex - this.NextBodyArray.length];
            }
            this.ShowBodyTip(_loc2_,this.mc_changeairshipbasePoint);
         }
         else
         {
            if(this.CanUpdate)
            {
               _loc3_ = this.NextPartArray[this.SelectedIndex];
            }
            else
            {
               _loc3_ = this.SecondLevelPartArray[this.SelectedIndex - this.NextPartArray.length];
            }
            this.ShowPartTip(_loc3_,this.mc_changeairshipbasePoint);
         }
      }
      
      private function mc_changeairshipbaseMouseOut(param1:MouseEvent) : void
      {
         CustomTip.GetInstance().Hide();
      }
      
      private function ShowBodyTip(param1:ShipbodyInfo, param2:Point) : void
      {
         var _loc3_:String = StringManager.getInstance().getMessageString("Text5");
         var _loc4_:String = StringManager.getInstance().getMessageString("Text" + (6 + param1.DefendType));
         var _loc5_:String = CustomTip.GetInstance().GetStringText(_loc3_,_loc4_);
         CustomTip.GetInstance().Show(_loc5_,param2);
      }
      
      private function ShowPartTip(param1:ShippartInfo, param2:Point) : void
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc3_:* = "";
         if(param1.FuncTypeId == 0 && param1.KindId != 11)
         {
            _loc4_ = StringManager.getInstance().getMessageString("Text6");
            _loc5_ = StringManager.getInstance().getMessageString("Text" + (param1.HurtType + 1));
            _loc3_ = CustomTip.GetInstance().GetStringText(_loc4_,_loc5_) + "\n\n";
         }
         _loc3_ += CustomTip.GetInstance().GetStringText(StringManager.getInstance().getMessageString("UpgradeText4"),param1.Comment);
         CustomTip.GetInstance().Show(_loc3_,param2);
      }
      
      private function McItemMouseOver(param1:MouseEvent, param2:XMovieClip) : void
      {
         var _loc5_:ShipbodyInfo = null;
         var _loc6_:ShippartInfo = null;
         var _loc3_:* = "";
         var _loc4_:int = this.PageIndex * 5 + param2.Data;
         if(this.CurSelectedType == 0 || this.CurSelectedType == 2)
         {
            if(_loc4_ >= this.BodyArray.length)
            {
               _loc4_ -= this.BodyArray.length;
               _loc5_ = this.FirstLevelBodyArray[_loc4_];
               _loc3_ = CustomTip.GetInstance().GetStringText(StringManager.getInstance().getMessageString("MailText17"),_loc5_.Name) + "\n\n<font color=\'#FF0000\'>" + _loc5_.Comment2 + "</font>";
               CustomTip.GetInstance().Show(_loc3_,param2.m_movie.localToGlobal(new Point(65,0)));
            }
         }
         else
         {
            if(_loc4_ < this.PartArray.length)
            {
               _loc6_ = this.PartArray[_loc4_];
               _loc3_ = CustomTip.GetInstance().GetStringText(StringManager.getInstance().getMessageString("MailText17"),_loc6_.Name) + "\n\n" + CustomTip.GetInstance().GetStringText(StringManager.getInstance().getMessageString("UpgradeText8"),_loc6_.KindName);
            }
            else
            {
               _loc4_ -= this.PartArray.length;
               _loc6_ = this.FirstLevelPartArray[_loc4_];
               _loc3_ = CustomTip.GetInstance().GetStringText(StringManager.getInstance().getMessageString("MailText17"),_loc6_.Name) + "\n\n" + CustomTip.GetInstance().GetStringText(StringManager.getInstance().getMessageString("UpgradeText8"),_loc6_.KindName) + "\n\n<font color=\'#FF0000\'>" + _loc6_.Comment2 + "</font>";
            }
            CustomTip.GetInstance().Show(_loc3_,param2.m_movie.localToGlobal(new Point(65,0)));
         }
      }
      
      private function McItemMouseOut(param1:MouseEvent) : void
      {
         CustomTip.GetInstance().Hide();
      }
      
      private function ShowFlaghShipList() : void
      {
      }
   }
}

