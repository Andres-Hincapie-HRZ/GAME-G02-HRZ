package logic.ui
{
   import com.star.frameworks.managers.StringManager;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.Timer;
   import logic.action.OutSideGalaxiasAction;
   import logic.entry.GameStageEnum;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.entry.test.MovieClipDataBox;
   import logic.game.GameKernel;
   import logic.manager.FightManager;
   import logic.manager.GameLayOutManager;
   import logic.manager.GameScreenManager;
   import logic.manager.InstanceManager;
   import logic.ui.tip.CustomTip;
   
   public class InstanceMenuUI
   {
      
      public static const MAX_COUNT:int = 2;
      
      private static var _instance:InstanceMenuUI = null;
      
      private var _movie:MovieClip;
      
      private var _mcData:MovieClipDataBox;
      
      private var _nextBtn:HButton;
      
      private var _endBtn:HButton;
      
      private var _tfTime:TextField;
      
      private var _timer:Timer;
      
      public function InstanceMenuUI(param1:HHH)
      {
         super();
         this._movie = GameKernel.getMovieClipInstance("MinibtnMc2");
         this._mcData = new MovieClipDataBox(this._movie,true);
         this.UpdateLoaction();
         AlignManager.GetInstance().SetAlign(this._movie,"right");
         this.Init();
      }
      
      public static function get instance() : InstanceMenuUI
      {
         if(!_instance)
         {
            _instance = new InstanceMenuUI(new HHH());
         }
         return _instance;
      }
      
      private function UpdateLoaction() : void
      {
         var _loc2_:DisplayObject = null;
         if(this._movie == null)
         {
            return;
         }
         var _loc1_:MObject = GameKernel.gameLayout.getInstallUI("BtngatherMc") as MObject;
         this._movie.x = 360;
         if(GameKernel.ForFB == 1)
         {
            this._movie.y = GameKernel.fullRect.height - GameSystemUI.systemUIHeight + 15;
         }
         else
         {
            _loc2_ = GameKernel.gameLayout.getInstallUI("FacebookUiScene");
            this._movie.y = GameKernel.fullRect.height - GameSystemUI.systemUIHeight - _loc2_.height + 15;
         }
      }
      
      public function get showNext() : Boolean
      {
         return this._mcData.getMC("btn_next").visible;
      }
      
      public function set showNext(param1:Boolean) : void
      {
         this._mcData.getMC("btn_next").visible = param1;
      }
      
      private function Init() : void
      {
         var _loc1_:MovieClip = this._mcData.getMC("btn_next");
         _loc1_.buttonMode = true;
         _loc1_.useHandCursor = true;
         _loc1_.visible = false;
         this._nextBtn = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.onClick);
         _loc1_.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         _loc1_.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         this._tfTime = this._mcData.getTF("tf_time");
         this._tfTime.mouseEnabled = false;
         this._tfTime.visible = false;
         _loc1_ = this._mcData.getMC("btn_stop");
         _loc1_.buttonMode = true;
         _loc1_.useHandCursor = true;
         this._endBtn = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.onClick);
         _loc1_.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         _loc1_.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
      }
      
      public function setFullLocation(param1:Boolean) : void
      {
         var _loc3_:DisplayObject = null;
         var _loc2_:MObject = GameKernel.gameLayout.getInstallUI("BtngatherMc") as MObject;
         if(param1)
         {
            this._movie.y = GameKernel.fullRect.height - GameSystemUI.systemUIHeight + 15;
         }
         else if(GameKernel.ForFB == 1)
         {
            this._movie.y = GameKernel.fullRect.height - GameSystemUI.systemUIHeight + 15;
         }
         else
         {
            _loc3_ = GameKernel.gameLayout.getInstallUI("FacebookUiScene");
            this._movie.y = GameKernel.fullRect.height - GameSystemUI.systemUIHeight - _loc3_.height + 15;
         }
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var _loc2_:Point = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         if(InstanceManager.instance.curEctype == 1000)
         {
            return;
         }
         if(InstanceManager.instance.curEctype == 1001)
         {
            WrestleUI.getInstance().StopWrestle();
            return;
         }
         switch(param1.target.name)
         {
            case "btn_stop":
               FightManager.instance.CleanFight();
               InstanceManager.instance.exitInstance();
               InstanceMenuUI.instance.hiden();
               break;
            case "btn_next":
               GameScreenManager.getInstance().ShowScreen(OutSideGalaxiasAction.getInstance());
               GameKernel.currentGameStage = GameStageEnum.GAME_STAGE_OUTSIDE;
               InstanceManager.instance.request_MSG_REQUEST_ECTYPEINFO(3);
               _loc2_ = new Point(this._mcData.getMC("btn_next").x,this._mcData.getMC("btn_next").y);
               _loc2_ = this._mcData.getMC("btn_next").globalToLocal(_loc2_);
               _loc3_ = GameKernel.getInstance().stage.stageWidth;
               _loc4_ = GameKernel.getInstance().stage.stageHeight - 200;
               _loc5_ = _loc3_ * 0.3 * Math.random();
               _loc6_ = _loc4_ * 0.3 * Math.random();
               _loc7_ = Math.random() > 0.5 ? 1 : -1;
               _loc8_ = Math.random() > 0.5 ? 1 : -1;
               _loc5_ = _loc7_ * _loc5_;
               if(_loc2_.x + _loc5_ < _loc3_ && _loc2_.x + _loc5_ > 0)
               {
                  this._mcData.getMC("btn_next").x = this._mcData.getMC("btn_next").x + _loc5_;
               }
               else
               {
                  this._mcData.getMC("btn_next").x = this._mcData.getMC("btn_next").x - _loc5_;
               }
               _loc6_ = _loc8_ * _loc6_;
               if(_loc2_.y + _loc6_ < _loc4_ && _loc2_.y + _loc6_ > 0)
               {
                  this._mcData.getMC("btn_next").y = this._mcData.getMC("btn_next").y + _loc6_;
               }
               else
               {
                  this._mcData.getMC("btn_next").y = this._mcData.getMC("btn_next").y - _loc6_;
               }
               this._mcData.getMC("btn_next").x = this._mcData.getMC("btn_next").x < -360 ? -360 : this._mcData.getMC("btn_next").x;
               this._mcData.getMC("btn_next").x = this._mcData.getMC("btn_next").x > 270 ? 270 : this._mcData.getMC("btn_next").x;
               this._mcData.getMC("btn_next").y = this._mcData.getMC("btn_next").y < -600 ? -600 : this._mcData.getMC("btn_next").y;
               this._mcData.getMC("btn_next").y = this._mcData.getMC("btn_next").y > 30 ? 30 : this._mcData.getMC("btn_next").y;
               this.initTimer();
         }
      }
      
      private function onMouseOver(param1:Event) : void
      {
         param1.target.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         var _loc2_:Point = param1.target.localToGlobal(new Point());
         _loc2_.y -= param1.target.height * 1.5;
         var _loc3_:String = "";
         switch(param1.target.name)
         {
            case "btn_stop":
               if(InstanceManager.instance.curEctype == 1001)
               {
                  _loc3_ = StringManager.getInstance().getMessageString("Boss119");
                  break;
               }
               _loc3_ = StringManager.getInstance().getMessageString("BattleTXT04");
               break;
            case "btn_next":
               _loc3_ = StringManager.getInstance().getMessageString("BattleTXT05");
         }
         CustomTip.GetInstance().Show(_loc3_,_loc2_);
      }
      
      private function onMouseOut(param1:Event) : void
      {
         param1.target.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         CustomTip.GetInstance().Hide();
      }
      
      private function initTimer() : void
      {
         this._nextBtn.setBtnDisabled(true);
         this._endBtn.setBtnDisabled(true);
         this._tfTime.visible = true;
         this._timer = new Timer(1000,MAX_COUNT);
         this._timer.addEventListener(TimerEvent.TIMER,this.onCount);
         this._timer.addEventListener(TimerEvent.TIMER_COMPLETE,this.releaseTimer);
         this._timer.start();
      }
      
      private function onCount(param1:TimerEvent) : void
      {
         var _loc2_:int = MAX_COUNT - this._timer.currentCount;
         var _loc3_:String = _loc2_ < 10 ? "0" + _loc2_ : _loc2_ + "";
         (this._nextBtn.m_movie.tf_time as TextField).text = _loc3_;
      }
      
      private function releaseTimer(param1:TimerEvent = null) : void
      {
         if(this._timer)
         {
            if(this._timer.hasEventListener(TimerEvent.TIMER))
            {
               this._timer.removeEventListener(TimerEvent.TIMER,this.onCount);
            }
            if(this._timer.hasEventListener(TimerEvent.TIMER_COMPLETE))
            {
               this._timer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.releaseTimer);
            }
            this._timer.stop();
            this._timer = null;
         }
         this._nextBtn.setBtnDisabled(false);
         this._endBtn.setBtnDisabled(false);
         this._tfTime.visible = false;
         var _loc2_:int = MAX_COUNT;
         var _loc3_:String = _loc2_ < 10 ? "0" + _loc2_ : _loc2_ + "";
         this._tfTime.text = _loc3_;
      }
      
      public function show() : void
      {
         GameLayOutManager.getInstance().installComponent("InstanceMenuUI",this._movie);
      }
      
      public function hiden() : void
      {
         this.releaseTimer();
         GameLayOutManager.getInstance().unInstallUI("InstanceMenuUI");
      }
      
      public function getUI() : DisplayObject
      {
         return this._movie;
      }
   }
}

class HHH
{
   
   public function HHH()
   {
      super();
   }
}
