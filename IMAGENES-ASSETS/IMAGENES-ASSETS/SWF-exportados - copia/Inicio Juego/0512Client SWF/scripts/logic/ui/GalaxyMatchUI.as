package logic.ui
{
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.CEffectText;
   import flash.display.Bitmap;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   import logic.action.GalaxyMapAction;
   import logic.entry.FBModel;
   import logic.entry.GStar;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.entry.test.MovieClipDataBox;
   import logic.game.GameKernel;
   import logic.manager.GalaxyShipManager;
   import logic.manager.InstanceManager;
   import logic.widget.DataWidget;
   import net.msg.match.MSG_RESP_MATCHINFO;
   import net.msg.match.MSG_RESP_MATCHPAGE;
   import net.msg.match.MSG_RESP_MATCHPAGE_TEMP;
   import net.msg.ship.MSG_RESP_JUMPGALAXYSHIP_TEMP;
   import net.router.GalaxyMatchRouter;
   import net.router.LeaguerangeRouter;
   
   public class GalaxyMatchUI extends AbstractPopUp
   {
      
      private static var _matchTimer:Timer = new Timer(1000);
      
      private static var _instance:GalaxyMatchUI = null;
      
      private var _dataBox:MovieClipDataBox;
      
      private var _listLen:int = 4;
      
      private var _leftPageBtn:HButton;
      
      private var _rightPageBtn:HButton;
      
      private var _firstBtn:HButton;
      
      private var _prveBtn:HButton;
      
      private var _nextBtn:HButton;
      
      private var _lastBtn:HButton;
      
      private var _beginBtn:HButton;
      
      private var _addBtn:HButton;
      
      private var _topBtn:HButton;
      
      private var _descWin:MovieClip;
      
      private var _descCloseBtn:HButton;
      
      private var _galaxyMatch:FBModel;
      
      private var _itemCloseBtnSet:Array = new Array();
      
      private var _selfPageSize:int = 4;
      
      private var _selfCurPage:int = 0;
      
      private var _selfMaxPage:int;
      
      private var _selfFBTeamsArr:Array = new Array();
      
      private var _LevelMoney:int = 30000;
      
      private var _matchTimeCount:int = 0;
      
      private var _matchType:int = 1;
      
      private var _matchLevel:int = 0;
      
      private var _matchCount:int = 0;
      
      private var _curTopPage:int = 0;
      
      private var _lastTopPage:int = 0;
      
      private var _pageSize:int = 10;
      
      public function GalaxyMatchUI(param1:HHH)
      {
         super();
         setPopUpName("GalaxyMatchUI");
         _mc = new MObject("LeagueScene",380,300);
         this.initMcElement();
         this._galaxyMatch = new FBModel();
         this._galaxyMatch.EctypeID = 1000;
         this._galaxyMatch.UserTeam = 4;
      }
      
      public static function get instance() : GalaxyMatchUI
      {
         if(!_instance)
         {
            _instance = new GalaxyMatchUI(new HHH());
         }
         return _instance;
      }
      
      override public function Init() : void
      {
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            GameKernel.popUpDisplayManager.Show(_instance);
            InstanceManager.instance.curSelectFB = this._galaxyMatch;
            GalaxyMatchRouter.request_MSG_REQUEST_MATCHINFO();
            return;
         }
         GameKernel.popUpDisplayManager.Regisger(_instance);
         GameKernel.popUpDisplayManager.Show(_instance);
         InstanceManager.instance.curSelectFB = this._galaxyMatch;
         GalaxyMatchRouter.request_MSG_REQUEST_MATCHINFO();
      }
      
      override public function initMcElement() : void
      {
         var _loc1_:HButton = null;
         var _loc2_:MovieClip = null;
         var _loc3_:MovieClip = null;
         this._dataBox = new MovieClipDataBox(_mc.getMC());
         _loc2_ = this._dataBox.getMC("btn_close") as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.onClick);
         _loc1_ = new HButton(_loc2_);
         _loc2_ = this._dataBox.getMC("btn_begin") as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.onClick);
         this._beginBtn = new HButton(_loc2_);
         _loc2_ = this._dataBox.getMC("btn_addfleet") as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.onClick);
         this._addBtn = new HButton(_loc2_);
         _loc2_ = this._dataBox.getMC("btn_refresh") as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.onClick);
         _loc1_ = new HButton(_loc2_);
         _loc2_ = this._dataBox.getMC("btn_range") as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.onClick);
         this._topBtn = new HButton(_loc2_);
         _loc2_ = this._dataBox.getMC("btn_intro") as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.onClick);
         _loc1_ = new HButton(_loc2_);
         _loc2_ = _mc.getMC().getChildByName("btn_left") as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.SelfFrontPage);
         this._leftPageBtn = new HButton(_loc2_);
         _loc2_ = _mc.getMC().getChildByName("btn_right") as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.SelfNextPage);
         this._rightPageBtn = new HButton(_loc2_);
         _loc2_ = _mc.getMC().getChildByName("btn_first") as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.onTopPageClick);
         this._firstBtn = new HButton(_loc2_);
         this._firstBtn.setBtnDisabled(true);
         _loc2_ = _mc.getMC().getChildByName("btn_prev") as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.onTopPageClick);
         this._prveBtn = new HButton(_loc2_);
         this._prveBtn.setBtnDisabled(true);
         _loc2_ = _mc.getMC().getChildByName("btn_next") as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.onTopPageClick);
         this._nextBtn = new HButton(_loc2_);
         this._nextBtn.setBtnDisabled(true);
         _loc2_ = _mc.getMC().getChildByName("btn_last") as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.onTopPageClick);
         this._lastBtn = new HButton(_loc2_);
         this._lastBtn.setBtnDisabled(true);
         var _loc4_:int = 0;
         while(_loc4_ < this._listLen)
         {
            _loc2_ = this._dataBox.getMC("mc_list" + _loc4_) as MovieClip;
            _loc2_.btn_cancel.addEventListener(MouseEvent.CLICK,this.onItemClose);
            _loc1_ = new HButton(_loc2_.btn_cancel);
            _loc2_.visible = false;
            this._itemCloseBtnSet.push(_loc1_);
            _loc4_++;
         }
         this._descWin = GameKernel.getMovieClipInstance("LeagueinfoMc",0,0,true);
         this._descWin.visible = false;
         this._descWin.y = 50;
         this._descCloseBtn = new HButton(this._descWin.getChildByName("btn_close") as MovieClip);
         this._descCloseBtn.m_movie.addEventListener(MouseEvent.CLICK,this.onDescClose);
         _mc.getMC().addChild(this._descWin);
      }
      
      public function addShipBtnEnable(param1:Boolean) : void
      {
         var _loc3_:HButton = null;
         this._addBtn.setBtnDisabled(param1);
         var _loc2_:int = 0;
         while(_loc2_ < this._itemCloseBtnSet.length)
         {
            _loc3_ = this._itemCloseBtnSet[_loc2_];
            _loc3_.setBtnDisabled(param1);
            _loc2_++;
         }
      }
      
      private function onDescClose(param1:MouseEvent) : void
      {
         this._descWin.visible = false;
      }
      
      public function updateStartBtn(param1:String, param2:Boolean) : void
      {
         this._dataBox.getTF("tf_txt").text = param1;
         this._beginBtn.setBtnDisabled(param2);
      }
      
      public function receiveData(param1:Array) : void
      {
         var _loc3_:* = undefined;
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = param1[_loc2_];
            _loc4_ = false;
            _loc5_ = 0;
            while(_loc5_ < this._selfFBTeamsArr.length)
            {
               if(_loc3_[0] == this._selfFBTeamsArr[_loc5_][0])
               {
                  _loc4_ = true;
                  break;
               }
               _loc5_++;
            }
            if(!_loc4_)
            {
               this._selfFBTeamsArr.push(_loc3_);
            }
            _loc2_++;
         }
         this.InitSelfPage();
      }
      
      private function InitSelfPage() : void
      {
         this._selfCurPage = 0;
         this._selfMaxPage = Math.floor((this._selfFBTeamsArr.length - 1) / this._selfPageSize);
         this.freshSelfTeams();
      }
      
      private function SelfFrontPage(param1:MouseEvent = null) : void
      {
         --this._selfCurPage;
         if(this._selfCurPage < 0)
         {
            this._selfCurPage = 0;
         }
         this.freshSelfTeams();
      }
      
      private function SelfNextPage(param1:MouseEvent = null) : void
      {
         this._selfCurPage += 1;
         if(this._selfCurPage > this._selfMaxPage)
         {
            this._selfCurPage = this._selfMaxPage;
         }
         this.freshSelfTeams();
      }
      
      private function freshSelfTeams() : void
      {
         var _loc1_:HButton = null;
         var _loc2_:MovieClip = null;
         var _loc4_:* = null;
         var _loc5_:MSG_RESP_JUMPGALAXYSHIP_TEMP = null;
         var _loc6_:Bitmap = null;
         var _loc7_:Bitmap = null;
         TextField(_mc.getMC().tf_page).text = "" + (this._selfCurPage + 1) + "/" + (this._selfMaxPage + 1);
         var _loc3_:int = 0;
         while(_loc3_ < this._selfPageSize)
         {
            _loc2_ = _mc.getMC().getChildByName("mc_list" + _loc3_) as MovieClip;
            _loc2_.visible = false;
            TextField(_loc2_.tf_fleetname).text = "";
            TextField(_loc2_.tf_fleetnum).text = "";
            if(_loc2_.mc_commanderbase.getChildByName("CommanderBMP"))
            {
               _loc2_.mc_commanderbase.removeChild(_loc2_.mc_commanderbase.getChildByName("CommanderBMP"));
            }
            if(_loc2_.mc_fleetbase.getChildByName("ShipBMP"))
            {
               _loc2_.mc_fleetbase.removeChild(_loc2_.mc_fleetbase.getChildByName("ShipBMP"));
            }
            _loc4_ = this._selfCurPage * this._selfPageSize + _loc3_ + "";
            if(this._selfFBTeamsArr[_loc4_])
            {
               _loc5_ = this._selfFBTeamsArr[_loc4_][1] as MSG_RESP_JUMPGALAXYSHIP_TEMP;
               if(_loc5_)
               {
                  _loc2_.visible = true;
                  TextField(_loc2_.tf_fleetname).text = "" + _loc5_.TeamName;
                  TextField(_loc2_.tf_fleetnum).text = "" + _loc5_.ShipNum;
                  _loc6_ = CommanderSceneUI.getInstance().CommanderImg(_loc5_.CommanderId);
                  _loc6_.name = "CommanderBMP";
                  _loc2_.mc_commanderbase.addChild(_loc6_);
                  _loc7_ = GalaxyShipManager.instance.getShipImg(_loc5_.BodyId);
                  _loc7_.name = "ShipBMP";
                  _loc2_.mc_fleetbase.addChild(_loc7_);
               }
            }
            _loc3_++;
         }
         _loc2_ = this._dataBox.getMC("btn_purchase");
      }
      
      public function startInstance(param1:MouseEvent = null) : void
      {
         var _loc3_:DisplayObjectContainer = null;
         var _loc2_:String = "";
         if(InstanceManager.instance.curStatus == InstanceManager.FB_NONE)
         {
            if(this._selfFBTeamsArr.length == 0)
            {
               _loc2_ = StringManager.getInstance().getMessageString("BattleTXT07");
               MessagePopup.getInstance().Show(_loc2_,0);
               return;
            }
            if(this._selfFBTeamsArr.length > this._galaxyMatch.UserTeam)
            {
               _loc2_ = StringManager.getInstance().getMessageString("BattleTXT08");
               MessagePopup.getInstance().Show(_loc2_.replace("@@1",this._galaxyMatch.UserTeam),0);
               return;
            }
            if(!InstanceManager.instance.checkShipGas())
            {
               _loc2_ = StringManager.getInstance().getMessageString("BattleTXT10");
               _loc3_ = GameKernel.renderManager.getUI().getContainer();
               CEffectText.getInstance().showEffectText(_loc3_,_loc2_);
               this._selfFBTeamsArr.splice(0);
               this.freshSelfTeams();
               return;
            }
            if(GamePlayer.getInstance().UserMoney < (this._matchLevel + 1) * this._LevelMoney)
            {
               _loc2_ = StringManager.getInstance().getMessageString("BattleTXT18");
               MessageBox.show(_loc2_ + this._LevelMoney + "×" + (this._matchLevel + 1) + "=" + this._LevelMoney * (this._matchLevel + 1));
               return;
            }
            if(this._matchCount <= 0)
            {
               _loc2_ = StringManager.getInstance().getMessageString("BattleTXT24");
               MessageBox.show(_loc2_);
               return;
            }
         }
         if(this._matchType == 1)
         {
            _loc2_ = StringManager.getInstance().getMessageString("BattleTXT25");
            _loc3_ = GameKernel.renderManager.getUI().getContainer();
            CEffectText.getInstance().showEffectText(_loc3_,_loc2_);
            return;
         }
         switch(InstanceManager.instance.curStatus)
         {
            case InstanceManager.FB_NONE:
               InstanceManager.instance.curSelectFB = this._galaxyMatch;
               InstanceManager.instance.requestStartFB(this._selfFBTeamsArr);
               break;
            case InstanceManager.FB_OUT:
               InstanceManager.instance.request_MSG_REQUEST_ECTYPEINFO(1);
               break;
            case InstanceManager.FB_WAITING:
               InstanceManager.instance.request_MSG_REQUEST_ECTYPEINFO(0);
         }
         this.freshTop();
      }
      
      public function Release(param1:MouseEvent = null) : void
      {
         GameKernel.popUpDisplayManager.Hide(_instance);
         InstanceManager.instance.curSelectFB = null;
         this._selfFBTeamsArr.splice(0);
         this.freshSelfTeams();
         this.releaseTimer();
         this.onTopComplete();
         this.clearTop();
      }
      
      public function openTransforUI(param1:MouseEvent = null) : void
      {
         var _loc2_:GStar = GalaxyMapAction.instance.curStar;
         ShipTransferUI.instance.RequestJumpShips(_loc2_.GalaxyId,_loc2_.GalaxyMapId,3);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         switch(param1.target.name)
         {
            case "btn_addfleet":
               this.openTransforUI();
               break;
            case "btn_begin":
               this.startInstance();
               break;
            case "btn_close":
               this.Release();
               break;
            case "btn_refresh":
               this.freshTop();
               break;
            case "btn_range":
               LeaguerangeSceneUI.getInstance().Init();
               LeaguerangeRouter.getInstance().sendMsgRANKMATCH(-1,-1);
               GameKernel.popUpDisplayManager.Show(LeaguerangeSceneUI.getInstance());
               break;
            case "btn_intro":
               this._descWin.visible = !this._descWin.visible;
         }
      }
      
      private function freshTop() : void
      {
         this.clearTop();
         this.onTopComplete();
      }
      
      private function onItemClose(param1:MouseEvent) : void
      {
         var _loc4_:MSG_RESP_JUMPGALAXYSHIP_TEMP = null;
         if(param1.target.name != "btn_cancel")
         {
            return;
         }
         var _loc2_:int = int(String(param1.target.parent.name).split("mc_list")[1]);
         var _loc3_:* = this._selfCurPage * this._selfPageSize + _loc2_ + "";
         if(!this._selfFBTeamsArr[_loc3_])
         {
            return;
         }
         _loc4_ = this._selfFBTeamsArr[_loc3_][1] as MSG_RESP_JUMPGALAXYSHIP_TEMP;
         this._selfFBTeamsArr.splice(_loc3_,1);
         this.freshSelfTeams();
      }
      
      public function InitUI(param1:MSG_RESP_MATCHINFO) : void
      {
         var _loc2_:String = null;
         this._matchType = param1.MatchType;
         this._matchLevel = param1.MatchLevel;
         this._matchCount = param1.MatchCount;
         TextField(_mc.getMC().getChildByName("tf_Lv")).text = param1.MatchLevel + 1 + "";
         TextField(_mc.getMC().getChildByName("tf_victory")).text = param1.MatchWin + "";
         TextField(_mc.getMC().getChildByName("tf_failure")).text = param1.MatchLost + "";
         TextField(_mc.getMC().getChildByName("tf_draw")).text = param1.MatchDogfall + "";
         TextField(_mc.getMC().getChildByName("tf_top")).text = param1.MatchWeekTop + "";
         TextField(_mc.getMC().getChildByName("tf_remainnum")).text = param1.MatchCount + "";
         TextField(_mc.getMC().getChildByName("tf_time")).text = DataWidget.secondFormatToTime(param1.SpareTime);
         if(param1.MatchType == 1)
         {
            _loc2_ = StringManager.getInstance().getMessageString("BattleTXT16");
            TextField(_mc.getMC().getChildByName("tf_counttxt")).text = _loc2_;
            TextField(_mc.getMC().getChildByName("tf_time")).textColor = 16711680;
            this._beginBtn.setBtnDisabled(true);
            TextField(_mc.getMC().getChildByName("tf_time1")).visible = false;
            _loc2_ = StringManager.getInstance().getMessageString("BattleTXT26");
            this.updateStartBtn(_loc2_,true);
         }
         else
         {
            _loc2_ = StringManager.getInstance().getMessageString("BattleTXT17");
            TextField(_mc.getMC().getChildByName("tf_counttxt")).text = _loc2_;
            TextField(_mc.getMC().getChildByName("tf_time")).textColor = 65280;
            this._beginBtn.setBtnDisabled(false);
            TextField(_mc.getMC().getChildByName("tf_time1")).visible = true;
         }
         this._matchTimeCount = param1.SpareTime;
         _matchTimer.repeatCount = this._matchTimeCount;
         _matchTimer.addEventListener(TimerEvent.TIMER,this.onTopTime);
         _matchTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTopComplete);
         _matchTimer.start();
      }
      
      private function onTopTime(param1:TimerEvent) : void
      {
         if(!_matchTimer)
         {
            return;
         }
         --this._matchTimeCount;
         if(this._matchTimeCount >= 0)
         {
            TextField(_mc.getMC().getChildByName("tf_time")).text = DataWidget.secondFormatToTime(this._matchTimeCount);
            TextField(_mc.getMC().getChildByName("tf_time1")).text = DataWidget.secondFormatToTime(this._matchTimeCount % 180);
         }
      }
      
      private function onTopComplete(param1:TimerEvent = null) : void
      {
         this.releaseTimer();
         GalaxyMatchRouter.request_MSG_REQUEST_MATCHINFO();
      }
      
      private function releaseTimer() : void
      {
         if(!_matchTimer)
         {
            return;
         }
         _matchTimer.stop();
         _matchTimer.removeEventListener(TimerEvent.TIMER,this.onTopTime);
         _matchTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTopComplete);
         _matchTimer.reset();
         this._matchTimeCount = 0;
      }
      
      public function InitTop(param1:MSG_RESP_MATCHPAGE) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:MSG_RESP_MATCHPAGE_TEMP = null;
         var _loc5_:MSG_RESP_MATCHPAGE_TEMP = null;
         TextField(_mc.getMC().getChildByName("tf_page")).text = param1.PageId + 1 + "/" + param1.MaxPageId;
         this._curTopPage = param1.PageId;
         this._lastTopPage = param1.MaxPageId - 1;
         _loc2_ = 0;
         while(_loc2_ < this._pageSize)
         {
            _loc4_ = param1.Data[_loc2_] as MSG_RESP_MATCHPAGE_TEMP;
            _loc3_ = _mc.getMC().getChildByName("mc_" + _loc2_) as MovieClip;
            TextField(_loc3_.getChildByName("tf_top")).text = "";
            TextField(_loc3_.getChildByName("tf_name")).text = "";
            TextField(_loc3_.getChildByName("tf_victory")).text = "";
            TextField(_loc3_.getChildByName("tf_failure")).text = "";
            TextField(_loc3_.getChildByName("tf_draw")).text = "";
            TextField(_loc3_.getChildByName("tf_record")).text = "";
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < param1.DataLen)
         {
            _loc5_ = param1.Data[_loc2_] as MSG_RESP_MATCHPAGE_TEMP;
            _loc3_ = _mc.getMC().getChildByName("mc_" + _loc2_) as MovieClip;
            TextField(_loc3_.getChildByName("tf_top")).text = _loc2_ + 1 + this._pageSize * param1.PageId + "";
            TextField(_loc3_.getChildByName("tf_name")).text = "???";
            TextField(_loc3_.getChildByName("tf_victory")).text = _loc5_.MatchWin + "";
            TextField(_loc3_.getChildByName("tf_failure")).text = _loc5_.MatchLost + "";
            TextField(_loc3_.getChildByName("tf_draw")).text = _loc5_.MatchDogfall + "";
            TextField(_loc3_.getChildByName("tf_record")).text = _loc5_.MatchResult + "";
            _loc2_++;
         }
         if(param1.PageId > 0)
         {
            this._prveBtn.setBtnDisabled(false);
         }
         else
         {
            this._prveBtn.setBtnDisabled(true);
         }
         if(param1.PageId + 1 < param1.MaxPageId)
         {
            this._nextBtn.setBtnDisabled(false);
         }
         else
         {
            this._nextBtn.setBtnDisabled(true);
         }
         if(param1.PageId == 0)
         {
            this._firstBtn.setBtnDisabled(true);
         }
         else
         {
            this._firstBtn.setBtnDisabled(false);
         }
         if(param1.PageId + 1 == param1.MaxPageId)
         {
            this._lastBtn.setBtnDisabled(true);
         }
         else
         {
            this._lastBtn.setBtnDisabled(false);
         }
      }
      
      private function clearTop() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:int = 0;
         while(_loc2_ < 10)
         {
            _loc1_ = _mc.getMC().getChildByName("mc_" + _loc2_) as MovieClip;
            TextField(_loc1_.getChildByName("tf_top")).text = "";
            TextField(_loc1_.getChildByName("tf_name")).text = "";
            TextField(_loc1_.getChildByName("tf_victory")).text = "";
            TextField(_loc1_.getChildByName("tf_failure")).text = "";
            TextField(_loc1_.getChildByName("tf_draw")).text = "";
            TextField(_loc1_.getChildByName("tf_record")).text = "";
            _loc2_++;
         }
      }
      
      private function onTopPageClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         switch(param1.target.name)
         {
            case "btn_first":
               _loc2_ = 0;
               break;
            case "btn_prev":
               _loc2_ = this._curTopPage - 1;
               break;
            case "btn_next":
               _loc2_ = this._curTopPage + 1;
               break;
            case "btn_last":
               _loc2_ = this._lastTopPage;
         }
         GalaxyMatchRouter.request_MSG_REQUEST_MATCHPAGE(_loc2_);
      }
      
      public function get matchType() : int
      {
         return this._matchType;
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
