package logic.ui
{
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.StringUitl;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextField;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import gs.TweenLite;
   import gs.easing.Linear;
   import logic.action.ConstructionAction;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.HButtonType;
   import logic.entry.MObject;
   import logic.entry.props.propsInfo;
   import logic.game.GameKernel;
   import logic.game.GameMouseZoneManager;
   import logic.manager.GameInterActiveManager;
   import logic.reader.CPropsReader;
   import logic.ui.info.BleakingLineForThai;
   import logic.ui.tip.CustomTip;
   import logic.utils.UpdateResource;
   import logic.widget.ConstructionOperationWidget;
   import logic.widget.DataWidget;
   import net.base.NetManager;
   import net.msg.reward.MSG_REQUEST_GETONLINEAWARD;
   import net.msg.reward.MSG_RESP_GETONLINEAWARD;
   
   public class ResPlaneUI
   {
      
      private static var instance:ResPlaneUI;
      
      private var tf_metal:TextField;
      
      private var tf_He3:TextField;
      
      private var tf_fund:TextField;
      
      private var tf_cash:TextField;
      
      private var downBtn:HButton;
      
      private var mc_metal:HButton;
      
      private var mc_gold:HButton;
      
      private var mc_He3:HButton;
      
      private var mc_cash:HButton;
      
      private var tf_metalhour:TextField;
      
      private var tf_fundlhour:TextField;
      
      private var tf_He3hour:TextField;
      
      private var tf_cashhour:TextField;
      
      private var upBtn:HButton;
      
      private var btn_metal:HButton;
      
      private var btn_gold:HButton;
      
      private var btn_he3:HButton;
      
      private var _mc:MObject;
      
      public var btn_mvp:HButton;
      
      private var _ServerTime:Number;
      
      private var SrverTimer:Timer;
      
      private var LastTime:int;
      
      private var _RewardTime:Number;
      
      private var _RewardLastTime:Number;
      
      private var RewardMc:MovieClip;
      
      private var RewardTipShowing:Boolean;
      
      private var Reward_txt_name:TextField;
      
      private var LastHour:int;
      
      private var RewardPropsImage:Bitmap;
      
      private var LastStageWidth:int;
      
      public function ResPlaneUI()
      {
         super();
      }
      
      public static function getInstance() : ResPlaneUI
      {
         if(instance == null)
         {
            instance = new ResPlaneUI();
         }
         return instance;
      }
      
      public function set ServerTime(param1:Number) : void
      {
         this._ServerTime = param1 * 1000;
         this.LastHour = -1;
         this.LastTime = getTimer();
      }
      
      public function Init(param1:MObject) : void
      {
         this._mc = param1;
         if(this._mc.stage)
         {
            this.LastStageWidth = this._mc.stage.stageWidth;
            this._mc.stage.addEventListener(Event.RESIZE,this.OnResize);
         }
         else
         {
            this._mc.addEventListener(Event.ADDED_TO_STAGE,this.OnAddToStage);
         }
         this.tf_metal = TextField(this._mc.getMC().tf_metal);
         this.tf_He3 = TextField(this._mc.getMC().tf_He3);
         this.tf_fund = TextField(this._mc.getMC().tf_fund);
         this.tf_cash = TextField(this._mc.getMC().tf_cash);
         var _loc2_:HButton = new HButton(this._mc.getMC().btn_down);
         this.mc_metal = new HButton(this._mc.getMC().mc_metal);
         this.mc_gold = new HButton(this._mc.getMC().mc_gold);
         this.mc_He3 = new HButton(this._mc.getMC().mc_He3);
         this.mc_cash = new HButton(this._mc.getMC().mc_cash);
         this.btn_mvp = new HButton(this._mc.getMC().btn_mvp,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("VIP3"));
         GameInterActiveManager.InstallInterActiveEvent(_loc2_.m_movie,ActionEvent.ACTION_CLICK,this.onDropDown);
         GameInterActiveManager.InstallInterActiveEvent(this.mc_metal.m_movie,ActionEvent.ACTION_MOUSE_OVER,GameMouseZoneManager.ShowTip);
         GameInterActiveManager.InstallInterActiveEvent(this.mc_gold.m_movie,ActionEvent.ACTION_MOUSE_OVER,GameMouseZoneManager.ShowTip);
         GameInterActiveManager.InstallInterActiveEvent(this.mc_He3.m_movie,ActionEvent.ACTION_MOUSE_OVER,GameMouseZoneManager.ShowTip);
         GameInterActiveManager.InstallInterActiveEvent(this.mc_cash.m_movie,ActionEvent.ACTION_MOUSE_OVER,GameMouseZoneManager.ShowTip);
         GameInterActiveManager.InstallInterActiveEvent(this.mc_metal.m_movie,ActionEvent.ACTION_CLICK,this.onClickHandler);
         GameInterActiveManager.InstallInterActiveEvent(this.mc_gold.m_movie,ActionEvent.ACTION_CLICK,this.onClickHandler);
         GameInterActiveManager.InstallInterActiveEvent(this.mc_He3.m_movie,ActionEvent.ACTION_CLICK,this.onClickHandler);
         GameInterActiveManager.InstallInterActiveEvent(this.mc_cash.m_movie,ActionEvent.ACTION_CLICK,this.onClickHandler);
         GameInterActiveManager.InstallInterActiveEvent(this.mc_metal.m_movie,ActionEvent.ACTION_MOUSE_OUT,GameMouseZoneManager.HideTip);
         GameInterActiveManager.InstallInterActiveEvent(this.mc_gold.m_movie,ActionEvent.ACTION_MOUSE_OUT,GameMouseZoneManager.HideTip);
         GameInterActiveManager.InstallInterActiveEvent(this.mc_He3.m_movie,ActionEvent.ACTION_MOUSE_OUT,GameMouseZoneManager.HideTip);
         GameInterActiveManager.InstallInterActiveEvent(this.mc_cash.m_movie,ActionEvent.ACTION_MOUSE_OUT,GameMouseZoneManager.HideTip);
         this.btn_mvp.setVisible(false);
         this.btn_mvp.m_movie.addEventListener(MouseEvent.CLICK,this.btn_mvpClick);
         this.SrverTimer = new Timer(1000);
         this.SrverTimer.addEventListener(TimerEvent.TIMER,this.OnTimer);
         this.SrverTimer.start();
         this.RewardMc = PlayerInfoUI.getInstance().RewardMc;
         if(this.RewardMc != null)
         {
            this.RewardMc.visible = false;
            this.RewardMc.addEventListener(MouseEvent.MOUSE_OVER,this.RewardMcOver);
            this.RewardMc.addEventListener(MouseEvent.MOUSE_OUT,this.RewardMcOut);
            this.RewardMc.addEventListener(MouseEvent.CLICK,this.RewardMcClick);
            this.RewardTipShowing = false;
            this.Reward_txt_name = this.RewardMc.getChildByName("txt_name") as TextField;
         }
      }
      
      private function RewardMcClick(param1:MouseEvent) : void
      {
         if(this._RewardTime > 0)
         {
            return;
         }
         var _loc2_:MSG_REQUEST_GETONLINEAWARD = new MSG_REQUEST_GETONLINEAWARD();
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc2_);
         this.HideReward();
      }
      
      public function Resp_MSG_RESP_GETONLINEAWARD(param1:MSG_RESP_GETONLINEAWARD) : void
      {
         if(param1.ErrorCode == 0)
         {
            UpdateResource.getInstance().AddToPack(param1.PropsId,param1.PropsNum,1);
            this.PlayReward(param1.PropsId,this.RewardMc);
         }
         else
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CommanderText12"),1);
            this.RewardMc.visible = true;
         }
      }
      
      public function PlayReward(param1:int, param2:Sprite) : void
      {
         this.RewardCompleted();
         var _loc3_:propsInfo = CPropsReader.getInstance().GetPropsInfo(param1);
         this.RewardPropsImage = new Bitmap(GameKernel.getTextureInstance(_loc3_.ImageFileName));
         var _loc4_:Point = param2.localToGlobal(new Point(0,0));
         this.RewardPropsImage.x = _loc4_.x;
         this.RewardPropsImage.y = _loc4_.y;
         this._mc.stage.addChild(this.RewardPropsImage);
         GameMouseZoneManager.NagivateToolBarByName("mc_mall",false);
         var _loc5_:Point = GameSystemUI.getInstance().GetStorageBtnPoint();
         TweenLite.to(this.RewardPropsImage,1,{
            "x":_loc5_.x,
            "y":_loc5_.y,
            "ease":Linear,
            "onComplete":this.MoveCompleted
         });
      }
      
      private function MoveCompleted(param1:Event = null) : void
      {
         TweenLite.to(this.RewardPropsImage,0.5,{
            "alpha":0,
            "ease":Linear,
            "onComplete":this.RewardCompleted
         });
      }
      
      private function RewardCompleted(param1:Event = null) : void
      {
         if(this.RewardPropsImage == null)
         {
            return;
         }
         if(this._mc.stage.contains(this.RewardPropsImage))
         {
            this._mc.stage.removeChild(this.RewardPropsImage);
         }
         GameMouseZoneManager.CloseSubMenuState();
      }
      
      private function RewardMcOut(param1:MouseEvent) : void
      {
         this.RewardTipShowing = false;
         CustomTip.GetInstance().Hide();
      }
      
      private function RewardMcOver(param1:MouseEvent) : void
      {
         this.ShowRewardTip();
      }
      
      private function ShowRewardTip() : void
      {
         var _loc2_:String = null;
         this.RewardTipShowing = true;
         var _loc1_:Point = this.RewardMc.localToGlobal(new Point(55,0));
         if(this._RewardTime > 0)
         {
            _loc2_ = StringManager.getInstance().getMessageString("Boss23") + DataWidget.localToDataZone(this._RewardTime / 1000);
         }
         else
         {
            _loc2_ = StringManager.getInstance().getMessageString("Boss24");
         }
         CustomTip.GetInstance().Show(_loc2_,_loc1_);
      }
      
      public function ShowReward() : void
      {
         if(this.RewardMc == null)
         {
            return;
         }
         this._RewardTime = GamePlayer.getInstance().RewardMsg.SpareTime * 1000 + 500;
         this.RewardMc.visible = true;
         this._RewardLastTime = getTimer();
         this.ShowRewardImage();
      }
      
      public function HideReward() : void
      {
         this.RewardMc.visible = false;
      }
      
      private function OnAddToStage(param1:Event) : void
      {
         this._mc.removeEventListener(Event.ADDED_TO_STAGE,this.OnAddToStage);
         this.LastStageWidth = this._mc.stage.stageWidth;
         this._mc.stage.addEventListener(Event.RESIZE,this.OnResize);
      }
      
      private function onDropDown(param1:MouseEvent) : void
      {
         ConstructionOperationWidget.getInstance().Hide();
         this.initNextframeMc();
         ConstructionAction.getInstance().sendPlayerResource();
      }
      
      private function initNextframeMc() : void
      {
         this._mc.getMC().gotoAndStop(2);
         this.tf_metalhour = this._mc.getMC().tf_metalhour as TextField;
         this.tf_fundlhour = this._mc.getMC().tf_fundlhour as TextField;
         this.tf_He3hour = this._mc.getMC().tf_He3hour as TextField;
         this.tf_cashhour = this._mc.getMC().tf_cashhour as TextField;
         if(this.upBtn == null)
         {
            this.upBtn = new HButton(this._mc.getMC().btn_up);
         }
         if(this.btn_metal == null)
         {
            this.btn_metal = new HButton(this._mc.getMC().btn_mall0);
         }
         if(this.btn_gold == null)
         {
            this.btn_gold = new HButton(this._mc.getMC().btn_mall1);
         }
         if(this.btn_he3 == null)
         {
            this.btn_he3 = new HButton(this._mc.getMC().btn_mall2);
         }
         GameInterActiveManager.InstallInterActiveEvent(this.upBtn.m_movie,ActionEvent.ACTION_CLICK,this.onZoom);
         GameInterActiveManager.InstallInterActiveEvent(this.btn_metal.m_movie,ActionEvent.ACTION_CLICK,this.onPopup);
         GameInterActiveManager.InstallInterActiveEvent(this.btn_gold.m_movie,ActionEvent.ACTION_CLICK,this.onPopup);
         GameInterActiveManager.InstallInterActiveEvent(this.btn_he3.m_movie,ActionEvent.ACTION_CLICK,this.onPopup);
         GameInterActiveManager.InstallInterActiveEvent(this.btn_metal.m_movie,ActionEvent.ACTION_MOUSE_OVER,GameMouseZoneManager.ShowTip);
         GameInterActiveManager.InstallInterActiveEvent(this.btn_gold.m_movie,ActionEvent.ACTION_MOUSE_OVER,GameMouseZoneManager.ShowTip);
         GameInterActiveManager.InstallInterActiveEvent(this.btn_he3.m_movie,ActionEvent.ACTION_MOUSE_OVER,GameMouseZoneManager.ShowTip);
         GameInterActiveManager.InstallInterActiveEvent(this.btn_metal.m_movie,ActionEvent.ACTION_MOUSE_OUT,GameMouseZoneManager.HideTip);
         GameInterActiveManager.InstallInterActiveEvent(this.btn_gold.m_movie,ActionEvent.ACTION_MOUSE_OUT,GameMouseZoneManager.HideTip);
         GameInterActiveManager.InstallInterActiveEvent(this.btn_he3.m_movie,ActionEvent.ACTION_MOUSE_OUT,GameMouseZoneManager.HideTip);
         if(this.downBtn != null)
         {
            GameInterActiveManager.unInstallnterActiveEvent(this.downBtn.m_movie,ActionEvent.ACTION_CLICK,this.onDropDown);
         }
         this.downBtn = null;
         this.updateDropPlaneResource();
      }
      
      private function updateDropPlaneResource() : void
      {
         if(this.tf_metalhour == null || this.tf_fundlhour == null || this.tf_He3hour == null)
         {
            return;
         }
         this.tf_metalhour.text = StringUitl.toUSFormat(GamePlayer.getInstance().OutMetal);
         this.tf_fundlhour.text = StringUitl.toUSFormat(GamePlayer.getInstance().OutMoney);
         this.tf_He3hour.text = StringUitl.toUSFormat(GamePlayer.getInstance().OutGas);
      }
      
      public function updateResource() : void
      {
         if(this.tf_metalhour == null || this.tf_fundlhour == null || this.tf_He3hour == null)
         {
            return;
         }
         this.tf_metalhour.text = StringUitl.toUSFormat(GamePlayer.getInstance().OutMetal);
         this.tf_fundlhour.text = StringUitl.toUSFormat(GamePlayer.getInstance().OutMoney);
         this.tf_He3hour.text = StringUitl.toUSFormat(GamePlayer.getInstance().OutGas);
      }
      
      private function onZoom(param1:MouseEvent) : void
      {
         this._mc.getMC().gotoAndStop(1);
         this.tf_metal = TextField(this._mc.getMC().tf_metal);
         this.tf_He3 = TextField(this._mc.getMC().tf_He3);
         this.tf_fund = TextField(this._mc.getMC().tf_fund);
         this.tf_cash = TextField(this._mc.getMC().tf_cash);
         if(this.downBtn == null)
         {
            this.downBtn = new HButton(this._mc.getMC().btn_down);
         }
         GameInterActiveManager.InstallInterActiveEvent(this.downBtn.m_movie,ActionEvent.ACTION_CLICK,this.onDropDown);
         if(this.upBtn != null)
         {
            GameInterActiveManager.unInstallnterActiveEvent(this.upBtn.m_movie,ActionEvent.ACTION_CLICK,this.onZoom);
         }
         if(this.btn_metal != null)
         {
            GameInterActiveManager.unInstallnterActiveEvent(this.btn_metal.m_movie,ActionEvent.ACTION_CLICK,this.onZoom);
         }
         if(this.btn_gold != null)
         {
            GameInterActiveManager.unInstallnterActiveEvent(this.btn_gold.m_movie,ActionEvent.ACTION_CLICK,this.onPopup);
         }
         if(this.btn_gold != null)
         {
            GameInterActiveManager.unInstallnterActiveEvent(this.btn_gold.m_movie,ActionEvent.ACTION_CLICK,this.onPopup);
         }
         if(this.btn_he3 != null)
         {
            GameInterActiveManager.unInstallnterActiveEvent(this.btn_he3.m_movie,ActionEvent.ACTION_CLICK,this.onPopup);
         }
         GameInterActiveManager.unInstallnterActiveEvent(this.btn_metal.m_movie,ActionEvent.ACTION_MOUSE_OVER,GameMouseZoneManager.ShowTip);
         GameInterActiveManager.unInstallnterActiveEvent(this.btn_gold.m_movie,ActionEvent.ACTION_MOUSE_OVER,GameMouseZoneManager.ShowTip);
         GameInterActiveManager.unInstallnterActiveEvent(this.btn_he3.m_movie,ActionEvent.ACTION_MOUSE_OVER,GameMouseZoneManager.ShowTip);
         GameInterActiveManager.unInstallnterActiveEvent(this.btn_metal.m_movie,ActionEvent.ACTION_MOUSE_OUT,GameMouseZoneManager.HideTip);
         GameInterActiveManager.unInstallnterActiveEvent(this.btn_gold.m_movie,ActionEvent.ACTION_MOUSE_OUT,GameMouseZoneManager.HideTip);
         GameInterActiveManager.unInstallnterActiveEvent(this.btn_he3.m_movie,ActionEvent.ACTION_MOUSE_OUT,GameMouseZoneManager.HideTip);
         this.upBtn = null;
         this.btn_metal = null;
         this.btn_gold = null;
         this.btn_he3 = null;
      }
      
      public function updateResPlane() : void
      {
         this.tf_metal.text = StringUitl.toUSFormat2(GamePlayer.getInstance().UserMetal);
         this.tf_He3.text = StringUitl.toUSFormat2(GamePlayer.getInstance().UserHe3);
         this.tf_fund.text = StringUitl.toUSFormat2(GamePlayer.getInstance().UserMoney);
         this.tf_cash.text = StringUitl.toUSFormat2(GamePlayer.getInstance().cash);
         this.updateDropPlaneResource();
      }
      
      private function onClickHandler(param1:MouseEvent) : void
      {
         if(param1.target.name == "mc_cash")
         {
            GameKernel.navigateURL();
            return;
         }
         StateHandlingUI.getInstance().Init();
         StateHandlingUI.getInstance().setParent("ResPlaneUI");
         switch(param1.target.name)
         {
            case "mc_metal":
               StateHandlingUI.getInstance().getstate(912,913,914);
               break;
            case "mc_gold":
               StateHandlingUI.getInstance().getstate(918);
               break;
            case "mc_He3":
               StateHandlingUI.getInstance().getstate(915,916,917);
         }
         StateHandlingUI.getInstance().InitPopUp();
         GameKernel.popUpDisplayManager.Show(StateHandlingUI.getInstance());
      }
      
      private function onPopup(param1:MouseEvent) : void
      {
         StateHandlingUI.getInstance().Init();
         StateHandlingUI.getInstance().setParent("_ResPlaneUI");
         switch(param1.target.name)
         {
            case "btn_mall0":
               StateHandlingUI.getInstance().getstate(905);
               break;
            case "btn_mall1":
               StateHandlingUI.getInstance().getstate(907,930);
               break;
            case "btn_mall2":
               StateHandlingUI.getInstance().getstate(906);
         }
         StateHandlingUI.getInstance().InitPopUp();
         GameKernel.popUpDisplayManager.Show(StateHandlingUI.getInstance());
      }
      
      private function btn_mvpClick(param1:Event) : void
      {
         navigateToURL(new URLRequest(GamePlayer.getInstance().MvpUrl),"_blank");
      }
      
      private function OnTimer(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         if(this._ServerTime > 0)
         {
            this._ServerTime = this._ServerTime + getTimer() - this.LastTime;
            this.LastTime = getTimer();
            _loc2_ = this._ServerTime / 1000 % (60 * 60 * 24);
            _loc3_ = _loc2_ / 60 / 60;
            _loc4_ = _loc2_ / 60 % 60;
            _loc5_ = _loc2_ % 60;
            if(this.LastHour > 0 && this.LastHour > _loc3_)
            {
               GamePlayer.getInstance().ServerDate = new Date(GamePlayer.getInstance().ServerDate.getTime() + 1000 * 60 * 60 * 24);
            }
            GamePlayer.getInstance().ServerDate.setSeconds(_loc5_);
            GamePlayer.getInstance().ServerDate.setMinutes(_loc4_);
            GamePlayer.getInstance().ServerDate.setHours(_loc3_);
            this.LastHour = _loc3_;
            if(_loc3_ >= 12)
            {
               TextField(this._mc.getMC().tf_timetable).text = "PM";
               if(_loc3_ > 12)
               {
                  _loc3_ -= 12;
               }
               if(_loc3_ == 0)
               {
                  _loc3_ = 12;
               }
            }
            else
            {
               TextField(this._mc.getMC().tf_timetable).text = "AM";
               if(_loc3_ == 0)
               {
                  _loc3_ = 12;
               }
            }
            TextField(this._mc.getMC().tf_time).text = DataWidget.FormateNumber(_loc3_) + ":" + DataWidget.FormateNumber(_loc4_) + ":" + DataWidget.FormateNumber(_loc5_);
         }
         if(this._RewardTime > 0)
         {
            this._RewardTime -= getTimer() - this._RewardLastTime;
            this._RewardTime = this._RewardTime < 0 ? 0 : this._RewardTime;
            this._RewardLastTime = getTimer();
            this.ShowRewardImage();
         }
      }
      
      private function ShowRewardImage() : void
      {
         if(this._RewardTime <= 0)
         {
            this.RewardMc.gotoAndStop(1);
            this.Reward_txt_name.text = StringManager.getInstance().getMessageString("Boss26");
            BleakingLineForThai.GetInstance().BleakThaiLanguage(this.Reward_txt_name,16777215);
         }
         else
         {
            this.RewardMc.gotoAndStop(2);
            if(this.RewardTipShowing)
            {
               this.ShowRewardTip();
            }
            this.Reward_txt_name.text = DataWidget.localToDataZone(this._RewardTime / 1000);
         }
      }
      
      private function OnResize(param1:Event) : void
      {
         this._mc.x += (this._mc.stage.stageWidth - this.LastStageWidth) / 2;
         this.LastStageWidth = this._mc.stage.stageWidth;
      }
   }
}

