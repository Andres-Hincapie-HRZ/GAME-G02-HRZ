package logic.ui
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.facebook.FacebookUserInfo;
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.CEffectText;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.StyleSheet;
   import flash.text.TextField;
   import flash.utils.Timer;
   import logic.action.ChatAction;
   import logic.action.ConstructionAction;
   import logic.action.GalaxyMapAction;
   import logic.entry.GStar;
   import logic.entry.GamePlaceType;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.game.GameKernel;
   import logic.game.GameMouseZoneManager;
   import logic.game.GameStateManager;
   import logic.manager.FightManager;
   import logic.manager.FightSectionManager;
   import logic.manager.GalaxyManager;
   import logic.manager.GameInterActiveManager;
   import logic.manager.GamePopUpDisplayManager;
   import logic.ui.tip.CaptionTip;
   import logic.ui.tip.CustomTip;
   import logic.widget.DataWidget;
   import logic.widget.ProgressInFriendToolBarWidget;
   import logic.widget.ProgressListToolBarWidget;
   import net.common.MsgTypes;
   import net.router.CustomRouter;
   
   public class PlayerInfoPopUp extends AbstractPopUp
   {
      
      public static var isEnterState:Boolean;
      
      private static var instance:PlayerInfoPopUp;
      
      public static var Module:Boolean;
      
      private var tfName:TextField;
      
      private var tfX:TextField;
      
      private var tfId:TextField;
      
      private var tfLv:TextField;
      
      private var tfCorps:TextField;
      
      private var tfState:TextField;
      
      private var tfRanking:TextField;
      
      private var tfHit:TextField;
      
      private var mc_space:MovieClip;
      
      private var mc_city:MovieClip;
      
      private var mc_galaxy:MovieClip;
      
      private var tf_spaceNum:TextField;
      
      private var tf_cityNum:TextField;
      
      private var tf_galaxyNum:TextField;
      
      private var tf_starlist3Num:TextField;
      
      private var closeBtn:HButton;
      
      private var inviteBtn:HButton;
      
      private var EnterBtn:HButton;
      
      private var SendBtn:HButton;
      
      private var friendBtn:HButton;
      
      private var coordinateBtn:HButton;
      
      private var demesneBtn:HButton;
      
      private var btn_explain:HButton;
      
      private var mc_loser:MovieClip;
      
      private var mc_material:MovieClip;
      
      private var mc_starlist3:MovieClip;
      
      private var mc_base:MovieClip;
      
      private var ParentLock:Container;
      
      private var _Timer:Timer;
      
      private var BaseTipPoint:Point;
      
      private var _UserInfo:FacebookUserInfo;
      
      public function PlayerInfoPopUp()
      {
         super();
         this._Timer = new Timer(1000);
         this._Timer.addEventListener(TimerEvent.TIMER,this.OnTimer);
         setPopUpName("PlayerInfoPopUp");
         this._mc = new MObject("StarlookPop");
         this._mc.x = 380;
         this._mc.y = 300;
         this.initMcElement();
      }
      
      public static function getInstance() : PlayerInfoPopUp
      {
         if(instance == null)
         {
            instance = new PlayerInfoPopUp();
         }
         return instance;
      }
      
      override public function Init() : void
      {
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            this.setPlayerInfo();
            return;
         }
         GameKernel.popUpDisplayManager.Regisger(instance);
         this.setPlayerInfo();
      }
      
      public function Show() : void
      {
         if(Module)
         {
            GameKernel.renderManager.getUI().addComponent(this.ParentLock);
         }
         this.Init();
         GamePopUpDisplayManager.getInstance().Show(this);
         this.setVisible(true);
      }
      
      override public function initMcElement() : void
      {
         this.tfName = this._mc.getMC().tf_name as TextField;
         this.tfLv = this._mc.getMC().tf_grade as TextField;
         this.tfCorps = this._mc.getMC().tf_corp as TextField;
         this.tfRanking = this._mc.getMC().tf_ranking as TextField;
         this.tfX = this._mc.getMC().tf_x as TextField;
         this.tfState = this._mc.getMC().tf_state as TextField;
         this.mc_space = this._mc.getMC().mc_starlist0 as MovieClip;
         this.mc_city = this._mc.getMC().mc_starlist1 as MovieClip;
         this.mc_galaxy = this._mc.getMC().mc_starlist2 as MovieClip;
         this.mc_base = this._mc.getMC().mc_base as MovieClip;
         this.tf_spaceNum = this.mc_space.tf_num as TextField;
         this.tf_cityNum = this.mc_city.tf_num as TextField;
         this.tf_galaxyNum = this.mc_galaxy.tf_num as TextField;
         this.inviteBtn = new HButton(this._mc.getMC().btn_invite);
         this.EnterBtn = new HButton(this._mc.getMC().btn_enter);
         this.SendBtn = new HButton(this._mc.getMC().btn_send);
         this.friendBtn = new HButton(this._mc.getMC().btn_friend);
         this.coordinateBtn = new HButton(this._mc.getMC().btn_coordinate);
         this.demesneBtn = new HButton(this._mc.getMC().btn_demesne);
         this.closeBtn = new HButton(this._mc.getMC().btn_cancel);
         this.btn_explain = new HButton(this._mc.getMC().btn_explain);
         this._mc.getMC().btn_explain.stop();
         this._mc.getMC().btn_explain.addEventListener(MouseEvent.MOUSE_OVER,this.btn_explainOver);
         this._mc.getMC().btn_explain.addEventListener(MouseEvent.MOUSE_OUT,this.btn_explainOut);
         GameInterActiveManager.InstallInterActiveEvent(this.inviteBtn.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
         GameInterActiveManager.InstallInterActiveEvent(this.EnterBtn.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
         GameInterActiveManager.InstallInterActiveEvent(this.SendBtn.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
         GameInterActiveManager.InstallInterActiveEvent(this.friendBtn.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
         GameInterActiveManager.InstallInterActiveEvent(this.coordinateBtn.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
         GameInterActiveManager.InstallInterActiveEvent(this.demesneBtn.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
         GameInterActiveManager.InstallInterActiveEvent(this.closeBtn.m_movie,ActionEvent.ACTION_CLICK,this.onCloseWnd);
         this.mc_starlist3 = this._mc.getMC().mc_starlist3 as MovieClip;
         this.tf_starlist3Num = this.mc_starlist3.tf_num as TextField;
         this.tf_starlist3Num.visible = this.mc_starlist3.visible;
         var _loc1_:CaptionTip = new CaptionTip(this._mc.getMC().mc_protect,StringManager.getInstance().getMessageString("StarBtn6"));
         _loc1_ = new CaptionTip(this._mc.getMC().mc_battle,StringManager.getInstance().getMessageString("StarBtn7"));
         _loc1_ = new CaptionTip(this._mc.getMC().mc_starlist0,StringManager.getInstance().getMessageString("FriendText14"));
         _loc1_ = new CaptionTip(this._mc.getMC().mc_starlist1,StringManager.getInstance().getMessageString("FriendText15"));
         _loc1_ = new CaptionTip(this._mc.getMC().mc_starlist2,StringManager.getInstance().getMessageString("StarBtn9"));
         _loc1_ = new CaptionTip(this._mc.getMC().mc_starlist3,StringManager.getInstance().getMessageString("StarBtn16"));
         this.ParentLock = new Container("PlayerInfoPopUpLock");
         this.ParentLock.mouseEnabled = true;
         this.ParentLock.mouseChildren = true;
         this.ParentLock.fillRectangleWithoutBorder(GameKernel.fullRect.x,GameKernel.fullRect.y,GameKernel.fullRect.width,GameKernel.fullRect.height,0,0);
         this.mc_loser = this._mc.getMC().mc_loser as MovieClip;
         this.mc_loser.addEventListener(MouseEvent.CLICK,this.mc_loserClick);
         this.mc_loser.addEventListener(MouseEvent.MOUSE_OVER,this.mc_loserOver);
         this.mc_loser.addEventListener(MouseEvent.MOUSE_OUT,this.mc_loserOut);
         this.BaseTipPoint = this.mc_loser.localToGlobal(new Point(this.mc_loser.width,0));
         this.mc_material = this._mc.getMC().mc_material as MovieClip;
         this.mc_material.visible = false;
         DisplayObject(this.mc_material.btn_enter).addEventListener(MouseEvent.CLICK,this.btn_enterUserClick);
         var _loc2_:String = "a:link{text-decoration: underline;} a:hover{color:#ff0000;text-decoration: underline;} a:active{text-decoration: underline;}";
         var _loc3_:StyleSheet = new StyleSheet();
         _loc3_.parseCSS(_loc2_);
         this.tfX.styleSheet = _loc3_;
         GameInterActiveManager.InstallInterActiveEvent(this.tfX,TextEvent.LINK,this.onGoforward);
         this.tfCorps.styleSheet = _loc3_;
         this.tfCorps.addEventListener(TextEvent.LINK,this.tfCorpsClick);
      }
      
      private function btn_explainOver(param1:MouseEvent) : void
      {
         var _loc2_:String = "StarBtn8";
         if(GalaxyMapAction.instance.curStar.Type == 2)
         {
            _loc2_ = "Boss67";
         }
         CustomTip.GetInstance().Show(StringManager.getInstance().getMessageString(_loc2_),this._mc.getMC().btn_explain.localToGlobal(new Point(0,30)),false,250);
      }
      
      private function btn_explainOut(param1:MouseEvent) : void
      {
      }
      
      public function setPlayerInfo() : void
      {
         var _loc2_:FacebookUserInfo = null;
         this.tfName.text = ChatAction.currentPlayer.objGuid.toString();
         this.inviteBtn.setBtnDisabled(ChatAction.getInstance()._SenderType != 2 && (ChatAction.currentPlayer.objGuid <= 0 || ChatAction.currentPlayer.objGuid == GamePlayer.getInstance().Guid));
         this.friendBtn.setBtnDisabled(ChatAction.getInstance()._SenderType != 2 && (ChatAction.currentPlayer.objGuid <= 0 || ChatAction.currentPlayer.objGuid == GamePlayer.getInstance().Guid));
         this.demesneBtn.setBtnDisabled(ChatAction.getInstance()._SenderType != 2 && ChatAction.currentPlayer.objGuid <= 0);
         this.coordinateBtn.setBtnDisabled(true);
         this.SendBtn.setBtnDisabled(ChatAction.getInstance()._SenderType == 2);
         this.EnterBtn.setBtnDisabled(ChatAction.getInstance()._SenderType != 0 && ChatAction.currentPlayer.objGuid <= 0);
         if(ChatAction.getInstance()._SenderType == 0)
         {
            this.btn_explain.setVisible(GalaxyMapAction.instance.curStar.Type == 2 || GalaxyMapAction.instance.curStar.Type == 3);
         }
         else
         {
            this.btn_explain.setVisible(ChatAction.currentPlayer.objGuid <= 0);
         }
         this.inviteBtn.setVisible(!this.btn_explain.m_movie.visible);
         this.tfCorps.htmlText = "<a href=\'event:" + ChatAction.currentPlayer.consortiaId + "\'>" + ChatAction.currentPlayer.consortia + "</a>";
         this.tfLv.text = (ChatAction.currentPlayer.levelId + 1).toString();
         var _loc1_:* = "<a href=\'event:" + ChatAction.currentPlayer.x + "," + ChatAction.currentPlayer.y + "\'>" + ChatAction.currentPlayer.x + "," + ChatAction.currentPlayer.y + "</a>";
         this.tfX.htmlText = _loc1_;
         this.tfRanking.text = ChatAction.currentPlayer.rank.toString();
         if(ChatAction.getInstance()._SenderType == 0 && GalaxyMapAction.instance.curStar.Type == 2)
         {
            if(ChatAction.currentPlayer.InsertFlagConsortiaId != -1 && GalaxyMapAction.instance.curStar.LoserFlag != ChatAction.currentPlayer.InsertFlagConsortiaId)
            {
               GalaxyMapAction.instance.curStar.LoserFlag = ChatAction.currentPlayer.InsertFlagConsortiaId;
               GalaxyManager.instance.fresh();
            }
            if(GalaxyMapAction.instance.curStar.LoserFlag == 1)
            {
               this._mc.getMC().mc_protect.visible = false;
               this._mc.getMC().mc_battle.visible = true;
            }
            else
            {
               this._mc.getMC().mc_protect.visible = true;
               this._mc.getMC().mc_battle.visible = false;
            }
         }
         else if(ChatAction.currentPlayer.peaceTime <= 0)
         {
            this._mc.getMC().mc_protect.visible = false;
            this._mc.getMC().mc_battle.visible = true;
         }
         else
         {
            this._mc.getMC().mc_protect.visible = true;
            this._mc.getMC().mc_battle.visible = false;
         }
         this.tfState.text = DataWidget.localToDataZone(Math.abs(ChatAction.currentPlayer.peaceTime));
         this._Timer.start();
         this.tf_spaceNum.text = (ChatAction.currentPlayer.spaceLv + 1).toString();
         this.tf_cityNum.text = (ChatAction.currentPlayer.cityLv + 1).toString();
         this.tf_galaxyNum.text = ChatAction.currentPlayer.PassMaxEctypt.toString();
         MovieClip(this._mc.getMC().mc_starlist2).gotoAndStop(ChatAction.currentPlayer.PassMaxEctypt);
         this.mc_starlist3.gotoAndStop(ChatAction.currentPlayer.MatchLevel + 1);
         this.tf_starlist3Num.text = ChatAction.currentPlayer.MatchLevel + 1 + "";
         if(this.mc_base.numChildren > 0)
         {
            this.mc_base.removeChildAt(0);
         }
         this._UserInfo = null;
         if(ChatAction.currentPlayer.objGuid > 0)
         {
            this._UserInfo = null;
            _loc2_ = new FacebookUserInfo();
            _loc2_.uid = ChatAction.currentPlayer.UserId;
            _loc2_.first_name = ChatAction.currentPlayer.userName;
            if(CustomRouter.instance.otherImages.ContainsKey(_loc2_.uid))
            {
               _loc2_.pic_square = CustomRouter.instance.otherImages.Get(_loc2_.uid);
            }
            this.getPlayerFacebookInfoCallback(_loc2_);
         }
         this.mc_loser.visible = ChatAction.currentPlayer.InsertFlagTime > 0;
      }
      
      private function OnTimer(param1:Event) : void
      {
         if(ChatAction.currentPlayer.peaceTime > 0)
         {
            --ChatAction.currentPlayer.peaceTime;
            this.tfState.text = DataWidget.localToDataZone(ChatAction.currentPlayer.peaceTime);
         }
         else if(ChatAction.currentPlayer.peaceTime < 0)
         {
            ++ChatAction.currentPlayer.peaceTime;
            this.tfState.text = DataWidget.localToDataZone(Math.abs(ChatAction.currentPlayer.peaceTime));
         }
      }
      
      private function onGoforward(param1:TextEvent) : void
      {
         GameMouseZoneManager.NagivateToolBarByName("btn_universe",true);
         GotoGalaxyUI.instance.GotoGalaxy(ChatAction.currentPlayer.galaxyId / MsgTypes.MAP_RANGE,ChatAction.currentPlayer.galaxyId % MsgTypes.MAP_RANGE);
      }
      
      private function tfCorpsClick(param1:TextEvent) : void
      {
         this.Close();
         var _loc2_:int = int(param1.text);
         if(_loc2_ >= 0)
         {
            LoserPopUI.getInstance().ShowConsortia(_loc2_);
         }
      }
      
      private function getPlayerFacebookInfoCallback(param1:FacebookUserInfo) : void
      {
         if(param1 != null && ChatAction.currentPlayer.UserId == param1.uid)
         {
            this._UserInfo = param1;
            FleetInfoUI_Res.GetInstance().GetFacebookUserImg(param1.uid,param1.pic_square,this.GetFacebookUserImgCallback);
         }
      }
      
      private function GetFacebookUserImgCallback(param1:Number, param2:DisplayObject) : void
      {
         if(ChatAction.currentPlayer.UserId == param1 && param2 != null)
         {
            if(GameKernel.ForRenRen != 1)
            {
               Bitmap(param2).smoothing = true;
            }
            param2.width = 44;
            param2.height = 44;
            this.mc_base.addChild(param2);
         }
      }
      
      private function GetLocation(param1:int) : Point
      {
         var _loc2_:int = param1 / GalaxyManager.MAX_MAPAREAGRID;
         var _loc3_:int = param1 % GalaxyManager.MAX_MAPAREAGRID;
         return new Point(_loc2_,_loc3_);
      }
      
      private function onCloseWnd(param1:MouseEvent) : void
      {
         this.Close();
      }
      
      private function Close(param1:Boolean = false) : void
      {
         this._Timer.stop();
         if(Module)
         {
            this.ParentLock.parent.removeChild(this.ParentLock);
            GamePopUpDisplayManager.getInstance().Hide(this);
         }
         else
         {
            GamePopUpDisplayManager.getInstance().Hide(this);
         }
         Module = false;
         if(param1)
         {
            GamePopUpDisplayManager.getInstance().HideAllPopup();
         }
      }
      
      private function onHandler(param1:MouseEvent) : void
      {
         var _loc3_:GStar = null;
         if(ChatAction.getInstance()._SenderType == 2)
         {
            this.onHandler2(param1);
            return;
         }
         if(ChatAction.getInstance()._SenderType == 1)
         {
            this.onHandler1(param1);
            return;
         }
         if(ChatAction.getInstance()._SenderType == 3)
         {
            this.onHandler1(param1);
            return;
         }
         var _loc2_:GStar = GalaxyMapAction.instance.curStar;
         switch(param1.target.name)
         {
            case "btn_invite":
               if(_loc2_.Type < 4)
               {
                  return;
               }
               this.Close(true);
               MailUI.getInstance().WriteMail(ChatAction.currentPlayer.objGuid);
               break;
            case "btn_enter":
               ConstructionAction.isView = 0;
               this.Close(true);
               InstanceMenuUI.instance.hiden();
               if(3 == _loc2_.Type && (_loc2_.FightFlag != 1 && _loc2_.Camp != 1))
               {
                  CEffectText.getInstance().showEffectText(GameKernel.renderManager.getUI().getContainer(),StringManager.getInstance().getMessageString("StarBtn5"));
                  PlayerInfoPopUp.isEnterState = false;
                  GalaxyMapAction.instance.resetCurStar();
                  GameStateManager.preFriendGuid = -1;
                  return;
               }
               if(2 == _loc2_.Type && (_loc2_.FightFlag != 1 && _loc2_.Camp != 1))
               {
                  CEffectText.getInstance().showEffectText(GameKernel.renderManager.getUI().getContainer(),StringManager.getInstance().getMessageString("Boss64"));
                  PlayerInfoPopUp.isEnterState = false;
                  GalaxyMapAction.instance.resetCurStar();
                  GameStateManager.preFriendGuid = -1;
                  return;
               }
               PlayerInfoPopUp.isEnterState = true;
               GalaxyManager.instance.enterStar = _loc2_;
               GameStateManager.getInstance().fetchPlayerPlace(ChatAction.currentPlayer.UserId);
               _loc3_ = GalaxyMapAction.instance.lastTimeStar;
               if(_loc3_ != _loc2_ || _loc2_.FightFlag == 1)
               {
                  FightManager.instance.CleanFight();
                  GalaxyManager.instance.sendRequestGalaxy();
               }
               if(_loc3_ != _loc2_)
               {
                  _loc3_ = _loc3_;
               }
               if(_loc2_.Type == 3 || _loc2_.Type == 2)
               {
                  if(_loc2_.FightFlag == 1 || _loc2_.Camp != -1)
                  {
                     GameSystemUI.getInstance().setViewAdditionGalaxyState(true);
                     GameMouseZoneManager.gotoOutSideMap();
                  }
                  else
                  {
                     CEffectText.getInstance().showEffectText(GameKernel.renderManager.getUI().getContainer(),StringManager.getInstance().getMessageString("StarBtn5"));
                  }
                  GameStateManager.preFriendGuid = -1;
                  PlayerInfoPopUp.isEnterState = false;
                  return;
               }
               GameStateManager.preFriendGuid = _loc2_.UserId;
               PlayerInfoUI.getInstance().bindGalaxyFriendInfo(_loc2_.UserId,ChatAction.currentPlayer.userName);
               GameSystemUI.getInstance().setViewAdditionGalaxyState(false);
               if(_loc2_.FightFlag & 1)
               {
                  GameMouseZoneManager.gotoOutSideMap();
               }
               else
               {
                  GameMouseZoneManager.gotoStarSurfaceMap();
               }
               if(GameStateManager.playerPlace == GamePlaceType.PLACE_FRIENDHOME)
               {
                  ProgressListToolBarWidget.getInstance().showProgressList();
                  ProgressInFriendToolBarWidget.getInstance().showInFriendProgressList();
               }
               break;
            case "btn_send":
               this.Close(true);
               ShipTransferUI.instance.RequestJumpShips(_loc2_.GalaxyId,_loc2_.GalaxyMapId);
               break;
            case "btn_friend":
               if(_loc2_.Type < 4)
               {
                  return;
               }
               this.Close();
               FriendsListUI.getInstance().InviteFriend(ChatAction.currentPlayer.objGuid);
               break;
            case "btn_coordinate":
               break;
            case "btn_demesne":
               if(_loc2_.Type < 4)
               {
                  return;
               }
               this.Close(true);
               FieldUI.getInstance().Show(_loc2_.GalaxyMapId,_loc2_.GalaxyId,ChatAction.currentPlayer.UserId,ChatAction.currentPlayer.userName,ChatAction.currentPlayer.objGuid);
         }
      }
      
      private function onHandler1(param1:MouseEvent) : void
      {
         switch(param1.target.name)
         {
            case "btn_invite":
               if(ChatAction.currentPlayer.objGuid > 0)
               {
                  this.Close(true);
                  MailUI.getInstance().WriteMail(ChatAction.currentPlayer.objGuid);
               }
               break;
            case "btn_enter":
               if(ChatAction.currentPlayer.UserId > 0)
               {
                  ConstructionAction.isView = 0;
                  this.Close(true);
                  GameStateManager.getInstance().fetchPlayerPlace(ChatAction.currentPlayer.UserId);
                  FightSectionManager.instance.releaseFightSection();
                  PlayerInfoUI.getInstance().bindGalaxyFriendInfo(ChatAction.currentPlayer.UserId,ChatAction.currentPlayer.userName);
                  GameSystemUI.getInstance().setViewAdditionGalaxyState(false);
               }
               break;
            case "btn_send":
               this.Close(true);
               ShipTransferUI.instance.RequestJumpShips(ChatAction.currentPlayer.galaxyId,GamePlayer.getInstance().galaxyMapID);
               break;
            case "btn_friend":
               if(ChatAction.currentPlayer.objGuid > 0)
               {
                  this.Close();
                  FriendsListUI.getInstance().InviteFriend(ChatAction.currentPlayer.objGuid);
               }
               break;
            case "btn_coordinate":
               break;
            case "btn_demesne":
               if(ChatAction.currentPlayer.UserId > 0 && ChatAction.currentPlayer.objGuid > 0)
               {
                  this.Close(true);
                  FieldUI.getInstance().Show(GamePlayer.getInstance().galaxyMapID,ChatAction.currentPlayer.galaxyId,ChatAction.currentPlayer.UserId,ChatAction.currentPlayer.userName,ChatAction.currentPlayer.objGuid);
               }
         }
      }
      
      private function onHandler2(param1:MouseEvent) : void
      {
         switch(param1.target.name)
         {
            case "btn_invite":
               if(ChatAction.currentPlayer.objGuid > 0)
               {
                  this.Close(true);
                  MailUI.getInstance().WriteMail(ChatAction.currentPlayer.objGuid);
               }
               break;
            case "btn_enter":
               if(ChatAction.currentPlayer.UserId > 0)
               {
                  this.Close(true);
                  ConstructionAction.isView = 0;
                  GameStateManager.getInstance().fetchPlayerPlace(ChatAction.currentPlayer.UserId);
                  FightSectionManager.instance.releaseFightSection();
                  PlayerInfoUI.getInstance().bindGalaxyFriendInfo(ChatAction.currentPlayer.UserId,ChatAction.currentPlayer.userName);
                  GameSystemUI.getInstance().setViewAdditionGalaxyState(false);
               }
               break;
            case "btn_send":
               this.Close();
               ShipTransferUI.instance.RequestJumpShips(ChatAction.currentPlayer.galaxyId,GamePlayer.getInstance().galaxyMapID);
               break;
            case "btn_friend":
               this.Close();
               InvitePopupUI.getInstance().btn_acceptClick(null);
               break;
            case "btn_coordinate":
               break;
            case "btn_demesne":
               if(ChatAction.currentPlayer.UserId > 0 && ChatAction.currentPlayer.objGuid > 0)
               {
                  this.Close(true);
                  FieldUI.getInstance().Show(GamePlayer.getInstance().galaxyMapID,ChatAction.currentPlayer.galaxyId,ChatAction.currentPlayer.UserId,ChatAction.currentPlayer.userName,ChatAction.currentPlayer.objGuid);
               }
         }
      }
      
      private function btn_explainClick(param1:MouseEvent) : void
      {
      }
      
      private function mc_loserOver(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         if(ChatAction.currentPlayer.InsertFlagTime > 0)
         {
            _loc2_ = StringManager.getInstance().getMessageString("StarBtn11") + ChatAction.currentPlayer.InsertFlagConsortia + "\n\n <font color=\'#00ff00\'>" + StringManager.getInstance().getMessageString("StarBtn13") + "</font>";
            _loc2_ += "\n\n " + StringManager.getInstance().getMessageString("StarBtn10") + DataWidget.GetDateTime(ChatAction.currentPlayer.InsertFlagTime);
            _loc2_ += "\n\n " + StringManager.getInstance().getMessageString("StarBtn12") + DataWidget.GetDateTime(ChatAction.currentPlayer.InsertFlagTime + 72 * 60 * 60 * 1000);
            _loc2_ += "\n\n <font color=\'#00ff00\'>" + StringManager.getInstance().getMessageString("StarBtn14") + "</font>";
            CustomTip.GetInstance().Show(_loc2_,this.BaseTipPoint,false,250);
         }
      }
      
      private function mc_loserOut(param1:MouseEvent) : void
      {
         CustomTip.GetInstance().Hide();
      }
      
      private function mc_loserClick(param1:MouseEvent) : void
      {
         LoserPopUI.getInstance().ShowConsortia(ChatAction.currentPlayer.InsertFlagConsortiaId);
      }
      
      private function mc_materialClick(param1:MouseEvent) : void
      {
         if(this._UserInfo == null)
         {
            return;
         }
         if(this.mc_material.currentFrame == 1)
         {
            this.mc_material.gotoAndStop(2);
            DisplayObject(this.mc_material.btn_enter).visible = true;
            TextField(this.mc_material.tf_name).visible = true;
            TextField(this.mc_material.tf_gender).visible = true;
            TextField(this.mc_material.tf_city).visible = true;
            TextField(this.mc_material.tf_hometown).visible = true;
            TextField(this.mc_material.tf_birth).visible = true;
         }
         else
         {
            this.mc_material.gotoAndStop(1);
            DisplayObject(this.mc_material.btn_enter).visible = false;
            TextField(this.mc_material.tf_name).visible = false;
            TextField(this.mc_material.tf_gender).visible = false;
            TextField(this.mc_material.tf_city).visible = false;
            TextField(this.mc_material.tf_hometown).visible = false;
            TextField(this.mc_material.tf_birth).visible = false;
         }
      }
      
      private function btn_enterUserClick(param1:MouseEvent) : void
      {
         if(this._UserInfo != null)
         {
            navigateToURL(new URLRequest(this._UserInfo.profile_url),"_blank");
         }
      }
   }
}

