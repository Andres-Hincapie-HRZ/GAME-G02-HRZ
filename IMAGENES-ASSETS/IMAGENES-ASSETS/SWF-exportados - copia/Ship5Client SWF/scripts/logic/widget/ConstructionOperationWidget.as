package logic.widget
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.CEffectText;
   import com.star.frameworks.utils.HashSet;
   import com.star.frameworks.utils.ObjectUtil;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import gs.TweenLite;
   import gs.easing.Strong;
   import logic.action.ConstructionAction;
   import logic.action.OutSideGalaxiasAction;
   import logic.action.StarSurfaceAction;
   import logic.entry.ConstructionState;
   import logic.entry.Equiment;
   import logic.entry.EquimentTypeEnum;
   import logic.entry.GStar;
   import logic.entry.GalaxyType;
   import logic.entry.GamePlayer;
   import logic.entry.GameStageEnum;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.game.ConstructionAnimationManager;
   import logic.game.GameKernel;
   import logic.game.GameMouseZoneManager;
   import logic.game.GameSetting;
   import logic.manager.FightManager;
   import logic.manager.GalaxyManager;
   import logic.manager.GameInterActiveManager;
   import logic.manager.GamePopUpDisplayManager;
   import logic.manager.InstanceManager;
   import logic.ui.BattlefieldUI;
   import logic.ui.ChatUI;
   import logic.ui.ComposeUI;
   import logic.ui.ConstructionSpeedPopUp;
   import logic.ui.ConstructionUI;
   import logic.ui.DestructionShipUI;
   import logic.ui.ExchangeUI;
   import logic.ui.FieldUI;
   import logic.ui.GalaxyMatchUI;
   import logic.ui.GymkhanaUI;
   import logic.ui.InstanceUI;
   import logic.ui.MallBuyModulesPopup;
   import logic.ui.MessagePopup;
   import logic.ui.RaidProps;
   import logic.ui.ShipPairUI;
   import logic.ui.UpgradeModulesPopUp;
   import logic.ui.WrestleUI;
   import logic.ui.info.CTipModule;
   import logic.ui.info.ConstructionTipFactory;
   import logic.ui.info.IInfoDecorate;
   import net.router.DestructionShipRouter;
   import net.router.GymkhanaRouter;
   
   public class ConstructionOperationWidget
   {
      
      public static var IsPick:Boolean;
      
      public static var _currenCmd:int;
      
      private static var instance:ConstructionOperationWidget;
      
      private var _visible:Boolean;
      
      private var _operationContainer:MObject;
      
      private var _btnPool:HashSet;
      
      private var _currentBtnArr:Array;
      
      private var _infoDecorate:IInfoDecorate;
      
      private var _sourEquiment:Equiment;
      
      private var _updateBtn:HButton;
      
      private var _speedBtn:HButton;
      
      private var _pickBtn:HButton;
      
      private var _moveBtn:HButton;
      
      private var _destoryBtn:HButton;
      
      private var _cancelBtn:HButton;
      
      private var _viewBtn:HButton;
      
      private var _enterBtn:HButton;
      
      private var _improveBtn:HButton;
      
      private var _copyBtn:HButton;
      
      private var _challengBtn:HButton;
      
      private var _exchangeBtn:HButton;
      
      private var _WrestleBtn:HButton;
      
      private var _RaidPropsBtn:HButton;
      
      private var _BattleBtn:HButton;
      
      private var mBgContainer:Container;
      
      private var topBg:Bitmap;
      
      private var centerBg:Bitmap;
      
      private var bottomBg:Bitmap;
      
      public function ConstructionOperationWidget()
      {
         super();
         this._btnPool = new HashSet();
         this._operationContainer = new MObject();
         this.mBgContainer = new Container();
         this._operationContainer.addChild(this.mBgContainer);
         this._visible = false;
         this.initBtnElemetn();
      }
      
      public static function get currenCmd() : int
      {
         return _currenCmd;
      }
      
      public static function set currenCmd(param1:int) : void
      {
         _currenCmd = param1;
      }
      
      public static function getInstance() : ConstructionOperationWidget
      {
         if(instance == null)
         {
            instance = new ConstructionOperationWidget();
         }
         return instance;
      }
      
      public function get Operation() : Container
      {
         return this._operationContainer;
      }
      
      public function Draw(param1:int) : void
      {
         if(Boolean(this.topBg) && Boolean(this.bottomBg) && Boolean(this.centerBg))
         {
            this.mBgContainer.Gc();
         }
         this.topBg = new Bitmap(GameKernel.getTextureInstance("top"));
         this.bottomBg = new Bitmap(GameKernel.getTextureInstance("bottom"));
         this.centerBg = new Bitmap(GameKernel.getTextureInstance("center"));
         this.centerBg.y = this.topBg.height;
         this.centerBg.height = param1;
         this.bottomBg.y = this.centerBg.y + this.centerBg.height;
         this.mBgContainer.addChild(this.topBg);
         this.mBgContainer.addChild(this.centerBg);
         this.mBgContainer.addChild(this.bottomBg);
      }
      
      public function isPopUp() : Boolean
      {
         return this._visible;
      }
      
      public function setEquiment(param1:Equiment) : void
      {
         this._sourEquiment = param1;
      }
      
      private function initBtnElemetn() : void
      {
         var McTemp:MovieClip = null;
         this._updateBtn = new HButton(GameKernel.getMovieClipInstance("UpgradeBtnMc"));
         this._speedBtn = new HButton(GameKernel.getMovieClipInstance("SpeedBtnMc"));
         this._pickBtn = new HButton(GameKernel.getMovieClipInstance("PickBtnMc"));
         this._moveBtn = new HButton(GameKernel.getMovieClipInstance("MoveBtnMc"));
         this._destoryBtn = new HButton(GameKernel.getMovieClipInstance("BackoutBtnMc"));
         this._cancelBtn = new HButton(GameKernel.getMovieClipInstance("BuildcancelBtnMc"));
         this._viewBtn = new HButton(GameKernel.getMovieClipInstance("CloseBtnMc"));
         this._enterBtn = new HButton(GameKernel.getMovieClipInstance("EnterBtnMc"));
         this._improveBtn = new HButton(GameKernel.getMovieClipInstance("EnterBtnMc"));
         this._copyBtn = new HButton(GameKernel.getMovieClipInstance("CopyBtnMc"));
         this._challengBtn = new HButton(GameKernel.getMovieClipInstance("ChallengeBtnMc"));
         if(GameKernel.getMovieClipInstance("ArenaBtnMc") != null)
         {
            this._WrestleBtn = new HButton(GameKernel.getMovieClipInstance("ArenaBtnMc"));
         }
         if(GameKernel.getMovieClipInstance("LuckyBtnMc") != null)
         {
            this._RaidPropsBtn = new HButton(GameKernel.getMovieClipInstance("LuckyBtnMc"));
            this._btnPool.Put(OperationEnum.OPERATION_TYPE_RAIDPROPS,this._RaidPropsBtn);
         }
         if(GameKernel.getMovieClipInstance("BattleBtn") != null)
         {
            this._BattleBtn = new HButton(GameKernel.getMovieClipInstance("BattleBtn"));
            this._btnPool.Put(OperationEnum.OPERATION_TYPE_BATTLE,this._BattleBtn);
         }
         try
         {
            McTemp = GameKernel.getMovieClipInstance("BlackmarketBtnMc");
            this._exchangeBtn = new HButton(McTemp);
            this._exchangeBtn.m_movie.addEventListener(MouseEvent.CLICK,this._exchangeBtnClick);
         }
         catch(e:*)
         {
            _exchangeBtn = null;
         }
         this._viewBtn.setBtnDisabled(true);
         this._viewBtn.m_movie.mouseEnabled = true;
         this._btnPool.Put(OperationEnum.OPERATION_TYPE_UPGRADE,this._updateBtn);
         this._btnPool.Put(OperationEnum.OPERATION_TYPE_SPEED,this._speedBtn);
         this._btnPool.Put(OperationEnum.OPERATION_TYPE_PICK,this._pickBtn);
         this._btnPool.Put(OperationEnum.OPERATION_TYPE_MOVE,this._moveBtn);
         this._btnPool.Put(OperationEnum.OPERATION_TYPE_DESTORY,this._destoryBtn);
         this._btnPool.Put(OperationEnum.OPERATION_TYPE_CANCEL,this._cancelBtn);
         this._btnPool.Put(OperationEnum.OPERATION_TYPE_VIEW,this._viewBtn);
         this._btnPool.Put(OperationEnum.OPERATION_TYPE_ENTER,this._enterBtn);
         this._btnPool.Put(OperationEnum.OPERATION_TYPE_IMPROVE,this._improveBtn);
         this._btnPool.Put(OperationEnum.OPERATION_TYPE_COPY,this._copyBtn);
         this._btnPool.Put(OperationEnum.OPERATION_TYPE_MATCH,this._challengBtn);
         this._btnPool.Put(OperationEnum.OPERATION_TYPE_EXCHANGE,this._exchangeBtn);
         this._btnPool.Put(OperationEnum.OPERATION_TYPE_WRESTLE,this._WrestleBtn);
      }
      
      private function _exchangeBtnClick(param1:MouseEvent) : void
      {
         ExchangeUI.getInstance().Init();
         GameKernel.popUpDisplayManager.Show(ExchangeUI.getInstance());
      }
      
      public function getOperationButton(param1:int = 0) : HButton
      {
         var _loc3_:HButton = null;
         if(this._currentBtnArr.length == 0)
         {
            return null;
         }
         var _loc2_:HButton = this._btnPool.Get(param1) as HButton;
         for each(_loc3_ in this._currentBtnArr)
         {
            if(_loc3_ == _loc2_)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getButtonIndex(param1:int = 0) : int
      {
         if(this._currentBtnArr.length == 0)
         {
            return -1;
         }
         var _loc2_:HButton = this._btnPool.Get(param1) as HButton;
         var _loc3_:int = 0;
         while(_loc3_ < this._currentBtnArr.length)
         {
            if(_loc2_ == this._currentBtnArr[_loc3_])
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      public function setLocation(param1:int, param2:int, param3:Boolean = false) : void
      {
         if(this._operationContainer == null)
         {
            this.initBtnElemetn();
         }
         if(param1 + this._operationContainer.width > GameSetting.GAME_STAGE_WIDTH && param2 + this._operationContainer.height > GameSetting.GAME_STAGE_HEIGHT)
         {
            this._operationContainer.x = param1 - this._operationContainer.width;
            this._operationContainer.y = param2 - this._operationContainer.height;
         }
         else if(param1 + this._operationContainer.width > GameSetting.GAME_STAGE_WIDTH && param2 + this._operationContainer.height < GameSetting.GAME_STAGE_HEIGHT)
         {
            this._operationContainer.x = param1 - this._operationContainer.width;
            this._operationContainer.y = param2;
         }
         else if(param1 + this._operationContainer.width < GameSetting.GAME_STAGE_WIDTH && param2 + this._operationContainer.height > GameSetting.GAME_STAGE_HEIGHT)
         {
            this._operationContainer.x = param1;
            this._operationContainer.y = param2 - this._operationContainer.height;
         }
         else
         {
            this._operationContainer.x = param1;
            this._operationContainer.y = param2;
         }
         GameKernel.renderManager.getUI().addComponent(this._operationContainer);
         if(param3)
         {
            this._operationContainer.scaleX = 0;
            this._operationContainer.scaleY = 0;
            TweenLite.to(this._operationContainer,0.5,{
               "autoAlpha":1,
               "scaleX":1,
               "scaleY":1,
               "ease":Strong.easeOut
            });
         }
         this._visible = true;
         this.Sort();
      }
      
      public function Hide() : void
      {
         if(this._operationContainer == null || this._operationContainer.parent == null)
         {
            return;
         }
         this._visible = false;
         this._operationContainer.parent.removeChild(this._operationContainer);
         this.destoryCurrentBtnEvent();
         this.onPopInfoOutHandler(null);
      }
      
      public function Assemble(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Array = this.getAssembleByType(param1);
         if(_loc2_ == null || _loc2_.length == 0)
         {
            return;
         }
         this.Clear();
         this._currentBtnArr = new Array();
         for each(_loc3_ in _loc2_)
         {
            if(this._btnPool.Get(_loc3_) != null)
            {
               this._currentBtnArr.push(this._btnPool.Get(_loc3_));
               this.registerEvent(this._btnPool.Get(_loc3_));
               this._operationContainer.addChild(HButton(this._btnPool.Get(_loc3_)).m_movie);
            }
         }
         this.Validate();
         ChatUI.getInstance().HideAllChatModuleUI();
      }
      
      private function Validate() : void
      {
         var _loc1_:int = 0;
         if(ConstructionAction.currentTarget == null)
         {
            return;
         }
         ConstructionUI.getInstance().CurrentConstructionCell = null;
         if(Boolean(GalaxyManager.instance.enterStar) && GalaxyManager.instance.enterStar.Type == GalaxyType.GT_3)
         {
            if(ConstructionAction.currentTarget.EquimentInfoData.ConsortiaLeader)
            {
               if(ConstructionAction.currentTarget.EquimentInfoData.BuildID == EquimentTypeEnum.EQUIMENT_TYPE_SPACESTATION)
               {
                  if(ConstructionUtil.checkIsFullLevel(ConstructionAction.currentTarget.EquimentInfoData.BuildID,ConstructionAction.currentTarget.EquimentInfoData.LevelId + 1))
                  {
                     GameInterActiveManager.unInstallnterActiveEvent(this._updateBtn.m_movie,ActionEvent.ACTION_CLICK,this.onConstructionPanelHandler);
                     this._updateBtn.m_movie.parent.removeChild(this._updateBtn.m_movie);
                     this._updateBtn.m_isShow = false;
                     this.Sort();
                     return;
                  }
                  if(!ConstructionUtil.checkConsortBuildingUpgrate(ConstructionAction.currentTarget.EquimentInfoData.LevelId + 1))
                  {
                     this._updateBtn.setBtnDisabled(true);
                     this._updateBtn.m_movie.mouseEnabled = true;
                     GameInterActiveManager.unInstallnterActiveEvent(this._updateBtn.m_movie,ActionEvent.ACTION_CLICK,this.onConstructionPanelHandler);
                  }
                  else
                  {
                     this._updateBtn.setBtnDisabled(false);
                     GameInterActiveManager.InstallInterActiveEvent(this._updateBtn.m_movie,ActionEvent.ACTION_CLICK,this.onConstructionPanelHandler);
                  }
               }
               else
               {
                  if(ConstructionUtil.checkIsFullLevel(ConstructionAction.currentTarget.EquimentInfoData.BuildID,ConstructionAction.currentTarget.EquimentInfoData.LevelId + 1))
                  {
                     this._updateBtn.setBtnDisabled(true);
                     this._updateBtn.m_movie.mouseEnabled = true;
                     GameInterActiveManager.unInstallnterActiveEvent(this._updateBtn.m_movie,ActionEvent.ACTION_CLICK,this.onConstructionPanelHandler);
                     return;
                  }
                  this._updateBtn.setBtnDisabled(false);
                  GameInterActiveManager.InstallInterActiveEvent(this._updateBtn.m_movie,ActionEvent.ACTION_CLICK,this.onConstructionPanelHandler);
                  if(!ConstructionUtil.checkConsortBuildingUpgrateExpectSpaceStation(ConstructionAction.currentTarget.EquimentInfoData.BuildID,ConstructionAction.currentTarget.EquimentInfoData.LevelId + 1))
                  {
                     this._updateBtn.setBtnDisabled(true);
                     this._updateBtn.m_movie.mouseEnabled = true;
                     GameInterActiveManager.unInstallnterActiveEvent(this._updateBtn.m_movie,ActionEvent.ACTION_CLICK,this.onConstructionPanelHandler);
                  }
                  else
                  {
                     this._updateBtn.setBtnDisabled(false);
                     GameInterActiveManager.InstallInterActiveEvent(this._updateBtn.m_movie,ActionEvent.ACTION_CLICK,this.onConstructionPanelHandler);
                  }
               }
            }
            else if(this._updateBtn.m_movie.parent)
            {
               GameInterActiveManager.unInstallnterActiveEvent(this._updateBtn.m_movie,ActionEvent.ACTION_CLICK,this.onConstructionPanelHandler);
               this._updateBtn.m_movie.parent.removeChild(this._updateBtn.m_movie);
               this._updateBtn.m_isShow = false;
               this.Sort();
            }
            return;
         }
         if(!ConstructionUtil.HaveNextLevel(ConstructionAction.currentTarget.EquimentInfoData.IndexId))
         {
            if(this._updateBtn.m_movie.parent)
            {
               GameInterActiveManager.unInstallnterActiveEvent(this._updateBtn.m_movie,ActionEvent.ACTION_CLICK,this.onConstructionPanelHandler);
               this._updateBtn.m_movie.parent.removeChild(this._updateBtn.m_movie);
               this._updateBtn.m_isShow = false;
               this.Sort();
            }
            return;
         }
         if(!ConstructionAction.getInstance().checkCanBuild(ConstructionAction.currentTarget.EquimentInfoData.BuildID,ConstructionAction.currentTarget.EquimentInfoData.LevelId + 1))
         {
            ConstructionUI.getInstance().CurrentConstructionCell = null;
            this._updateBtn.setBtnDisabled(true);
            this._updateBtn.m_movie.mouseEnabled = true;
            GameInterActiveManager.unInstallnterActiveEvent(this._updateBtn.m_movie,ActionEvent.ACTION_CLICK,this.onConstructionPanelHandler);
         }
         else
         {
            this._updateBtn.setBtnDisabled(false);
            ConstructionUI.getInstance().CurrentConstructionCell = null;
            GameInterActiveManager.InstallInterActiveEvent(this._updateBtn.m_movie,ActionEvent.ACTION_CLICK,this.onConstructionPanelHandler);
         }
         this.Sort();
      }
      
      public function setOperationBtnState(param1:HButton, param2:Boolean) : void
      {
         param1.setBtnDisabled(param2);
      }
      
      private function getAssembleByType(param1:int) : Array
      {
         switch(param1)
         {
            case 0:
               return OperationEnum.OPERATION_0;
            case 1:
               return OperationEnum.OPERATION_1;
            case 2:
               return OperationEnum.OPERATION_2;
            case 3:
               return OperationEnum.OPERATION_3;
            case 4:
               return OperationEnum.OPERATION_4;
            case 5:
               return OperationEnum.OPERATION_5;
            case 6:
               return OperationEnum.OPERATION_6;
            case 7:
               return OperationEnum.OPERATION_7;
            case 8:
               return OperationEnum.OPERATION_8;
            case 9:
               return OperationEnum.OPERATION_9;
            case 10:
               return OperationEnum.OPERATION_10;
            case 11:
               return OperationEnum.OPERATION_11;
            case 12:
               return OperationEnum.OPERATION_12;
            case 13:
               return OperationEnum.OPERATION_13;
            case 14:
               return OperationEnum.OPERATION_14;
            case 15:
               return OperationEnum.OPERATION_15;
            default:
               return null;
         }
      }
      
      private function registerEvent(param1:HButton) : void
      {
         GameInterActiveManager.InstallInterActiveEvent(param1.m_movie,ActionEvent.ACTION_CLICK,this.onConstructionPanelHandler);
         GameInterActiveManager.InstallInterActiveEvent(param1.m_movie,ActionEvent.ACTION_MOUSE_OVER,this.onPopInfoOverHandler);
         GameInterActiveManager.InstallInterActiveEvent(param1.m_movie,ActionEvent.ACTION_MOUSE_OUT,this.onPopInfoOutHandler);
      }
      
      private function unRegisterEvent(param1:HButton) : void
      {
         GameInterActiveManager.unInstallnterActiveEvent(param1.m_movie,ActionEvent.ACTION_CLICK,this.onConstructionPanelHandler);
         GameInterActiveManager.unInstallnterActiveEvent(param1.m_movie,ActionEvent.ACTION_MOUSE_OVER,this.onPopInfoOverHandler);
         GameInterActiveManager.unInstallnterActiveEvent(param1.m_movie,ActionEvent.ACTION_MOUSE_OUT,this.onPopInfoOutHandler);
      }
      
      private function Clear() : void
      {
         if(Boolean(this._currentBtnArr) && Boolean(this._currentBtnArr.length))
         {
            this.destoryCurrentBtnEvent();
            this.removeBtn();
            ObjectUtil.ClearArray(this._currentBtnArr);
            this._currentBtnArr = null;
         }
      }
      
      private function destoryCurrentBtnEvent() : void
      {
         var _loc1_:HButton = null;
         for each(_loc1_ in this._currentBtnArr)
         {
            this.unRegisterEvent(_loc1_);
         }
      }
      
      private function removeBtn() : void
      {
         var _loc1_:HButton = null;
         for each(_loc1_ in this._currentBtnArr)
         {
            if(this._operationContainer.contains(_loc1_.m_movie))
            {
               this._operationContainer.removeChild(_loc1_.m_movie);
            }
         }
      }
      
      private function Sort() : void
      {
         var _loc1_:int = 0;
         var _loc2_:HButton = null;
         if(this._currentBtnArr == null || this._currentBtnArr.length == 0)
         {
            return;
         }
         this.reSet();
         var _loc3_:int = 0;
         while(_loc3_ < this._currentBtnArr.length)
         {
            if(HButton(this._currentBtnArr[_loc3_]).m_isShow)
            {
               if(this._currentBtnArr[Math.max(0,_loc3_ - 1)].m_isShow)
               {
                  _loc2_ = this._currentBtnArr[Math.max(0,_loc3_ - 1)];
               }
               _loc2_.m_movie.x = 10;
               if(_loc3_ == 0)
               {
                  _loc2_.m_movie.y = -10;
               }
               else
               {
                  this._currentBtnArr[_loc3_].m_movie.x = _loc2_.m_movie.x;
                  this._currentBtnArr[_loc3_].m_movie.y = _loc2_.m_movie.y + 22;
                  _loc1_ += 22;
               }
            }
            _loc3_++;
         }
         _loc1_ += 10;
         this.Draw(_loc1_);
      }
      
      private function reSet() : void
      {
         var _loc1_:HButton = null;
         for each(_loc1_ in this._currentBtnArr)
         {
            _loc1_.m_movie.y = 0;
         }
      }
      
      private function onConstructionPanelHandler(param1:MouseEvent) : void
      {
         var _loc3_:Equiment = null;
         var _loc4_:String = null;
         var _loc5_:GStar = null;
         var _loc6_:int = 0;
         if(ConstructionAction.currentTarget == null)
         {
            return;
         }
         var _loc2_:String = "";
         switch(param1.target.name)
         {
            case "UpgradeBtnMc":
               _loc3_ = ConstructionAction.currentTarget;
               currenCmd = OperationEnum.OPERATION_TYPE_UPGRADE;
               _loc3_.removeEquimentSenseZone();
               if(GalaxyManager.instance.enterStar.Type == GalaxyType.GT_3 && Boolean(ConstructionAction.currentTarget.EquimentInfoData.ConsortiaLeader))
               {
                  _loc3_.State = ConstructionState.STATE_UPDATE;
                  if(this._infoDecorate)
                  {
                     ConstructionTipFactory.setInfoDecorate("StarLevelnfo").Hide();
                  }
                  if(ConstructionUtil.checkConsortBuildingUpgrate(_loc3_.EquimentInfoData.LevelId + 1))
                  {
                     ConstructionAction.getInstance().sendConsortBuildingRequest(ConstructionAction.currentTarget);
                     if(_loc3_.EquimentInfoData.BuildID != EquimentTypeEnum.EQUIMENT_TYPE_SPACESTATION)
                     {
                        _loc3_.HideEquimentInfluence();
                     }
                     this.Hide();
                  }
                  return;
               }
               if(this._infoDecorate)
               {
                  ConstructionTipFactory.setInfoDecorate("Info").Hide();
               }
               if(ConstructionAction.getInstance().CheckConstructionProgreeIsFull())
               {
                  MallBuyModulesPopup.getInstance().Init();
                  MallBuyModulesPopup.getInstance().setToolPropID(900);
                  MallBuyModulesPopup.getInstance().Show();
                  this.Hide();
                  return;
               }
               if(ConstructionAction.getInstance().checkCanBuild(_loc3_.EquimentInfoData.BuildID,_loc3_.EquimentInfoData.LevelId + 1))
               {
                  _loc3_.State = ConstructionState.STATE_UPDATE;
                  ConstructionAction.getInstance().createBuildRequest(_loc3_);
                  ConstructionAction.BuildingList.push(_loc3_);
               }
               break;
            case "SpeedBtnMc":
               if(ConstructionAction.currentTarget == null)
               {
                  return;
               }
               currenCmd = OperationEnum.OPERATION_TYPE_SPEED;
               ConstructionSpeedPopUp.getInstance().Init();
               ConstructionSpeedPopUp.getInstance().setProgressEntryIso(ProgressListToolBarWidget.getInstance().getProgressIsoByEquiment(ConstructionAction.currentTarget));
               if(ConstructionAction.currentTarget)
               {
                  ConstructionSpeedPopUp.getInstance().setConstructionCostTime(DataWidget.localToDataZone(ConstructionAction.currentTarget.EquimentInfoData.needTime));
               }
               GamePopUpDisplayManager.getInstance().Show(ConstructionSpeedPopUp.getInstance());
               break;
            case "PickBtnMc":
               currenCmd = OperationEnum.OPERATION_TYPE_PICK;
               this._infoDecorate = ConstructionTipFactory.setInfoDecorate("CapacityInfo");
               this._infoDecorate.Show(param1.stageX,param1.stageY);
               ConstructionAnimationManager.fetchResourceStorageAnimation(ConstructionAction.currentTarget);
               ConstructionAction.getInstance().sendGetStorageResource();
               if(this._infoDecorate)
               {
                  ConstructionTipFactory.setInfoDecorate("CapacityInfo").Hide();
               }
               break;
            case "MoveBtnMc":
               currenCmd = OperationEnum.OPERATION_TYPE_MOVE;
               if(ConstructionAction.currentTarget.State == ConstructionState.STATE_BUILING || ConstructionAction.currentTarget.State == ConstructionState.STATE_UPDATE)
               {
                  return;
               }
               ConstructionAction.preConstructionPosX = ConstructionAction.currentTarget.EquimentInfoData.PosX;
               ConstructionAction.preConstructionPosY = ConstructionAction.currentTarget.EquimentInfoData.PosY;
               switch(GameKernel.currentGameStage)
               {
                  case GameStageEnum.GAME_STAGE_OUTSIDE:
                     OutSideGalaxiasAction.getInstance().setGirdLoad(ConstructionAction.currentTarget.EquimentInfoData.PosX,ConstructionAction.currentTarget.EquimentInfoData.PosY,false);
                     OutSideGalaxiasAction.getInstance().changeConstuctionModel(true);
                     OutSideGalaxiasAction.getInstance().addActionEvent();
                     OutSideGalaxiasAction.getInstance().unRegisterShipEvent();
                     break;
                  case GameStageEnum.GAME_STAGE_STARSURFACE:
                     StarSurfaceAction.getInstance().changeConstructionModel(true);
                     StarSurfaceAction.getInstance().IsMigrate = true;
                     StarSurfaceAction.getInstance().addActionEvent();
                     if(ConstructionAction.currentTarget)
                     {
                        StarSurfaceAction.getInstance().LayOut.setChildIndex(ConstructionAction.currentTarget,StarSurfaceAction.getInstance().LayOut.numChildren - 1);
                     }
               }
               ConstructionAction.currentTarget.State = ConstructionState.STATE_MIRGRATE;
               if(ConstructionAction.currentTarget.BlurPrint.BuildingClass == 0)
               {
                  ConstructionAction.currentTarget.addEquimentSenseZone();
               }
               ConstructionAction.currentTarget.getMC().alpha = 0.7;
               break;
            case "BackoutBtnMc":
               currenCmd = OperationEnum.OPERATION_TYPE_DESTORY;
               UpgradeModulesPopUp.getInstance().Init();
               UpgradeModulesPopUp.getInstance().Show();
               break;
            case "BuildcancelBtnMc":
               currenCmd = OperationEnum.OPERATION_TYPE_CANCEL;
               UpgradeModulesPopUp.getInstance().Init();
               UpgradeModulesPopUp.getInstance().Show();
               break;
            case "EnterBtnMc":
               currenCmd = OperationEnum.OPERATION_TYPE_ENTER;
               if(ConstructionAction.currentTarget.EquimentInfoData.BuildID == EquimentTypeEnum.EQUIMENT_TYPE_SHIPBUILDING)
               {
                  GameMouseZoneManager.NagivateToolBarByName("btn_boatyard",true);
                  break;
               }
               if(ConstructionAction.currentTarget.EquimentInfoData.BuildID == EquimentTypeEnum.EQUIMENT_TYPE_COMMANDERCENTER)
               {
                  GameMouseZoneManager.NagivateToolBarByName("btn_commander",true);
                  break;
               }
               if(ConstructionAction.currentTarget.EquimentInfoData.BuildID == EquimentTypeEnum.EQUIMENT_TYPE_TECHRESEARCHCENTER)
               {
                  GameMouseZoneManager.NagivateToolBarByName("btn_technology",true);
                  break;
               }
               if(ConstructionAction.currentTarget.EquimentInfoData.BuildID == EquimentTypeEnum.EQUIMENT_TYPE_UNION)
               {
                  GameMouseZoneManager.NagivateToolBarByName("btn_corps",true);
                  break;
               }
               if(ConstructionAction.currentTarget.EquimentInfoData.BuildID == EquimentTypeEnum.EQUIMENT_TYPE_WEAPONRESEARCHCENTER)
               {
                  GameMouseZoneManager.NagivateToolBarByName("btn_research",true);
                  break;
               }
               if(ConstructionAction.currentTarget.EquimentInfoData.BuildID == EquimentTypeEnum.EQUIMENT_TYPE_TRADEPORT)
               {
                  GameMouseZoneManager.NagivateToolBarByName("btn_business",true);
                  break;
               }
               if(ConstructionAction.currentTarget.EquimentInfoData.BuildID == EquimentTypeEnum.EQUIMENT_TYPE_SHIPRECAIM)
               {
                  DestructionShipRouter.instance.m_ShipTeamNumAry.length = 0;
                  DestructionShipRouter.instance.sendmsgARRANGESHIPTEAM();
                  DestructionShipUI.getinstance().Init();
                  DestructionShipUI.getinstance().InitPopUp();
                  GameKernel.popUpDisplayManager.Show(DestructionShipUI.getinstance());
                  break;
               }
               if(ConstructionAction.currentTarget.EquimentInfoData.BuildID == EquimentTypeEnum.EQUIMENT_TYPE_COMPOSITIONCENTER)
               {
                  ComposeUI.getInstance().Init();
                  GameKernel.popUpDisplayManager.Show(ComposeUI.getInstance());
                  break;
               }
               if(ConstructionAction.currentTarget.EquimentInfoData.BuildID == EquimentTypeEnum.EQUIMENT_TYPE_SPACESTATION)
               {
                  _loc4_ = GamePlayer.getInstance().Name;
                  FieldUI.getInstance().Show(GamePlayer.getInstance().galaxyMapID,GamePlayer.getInstance().galaxyID,GamePlayer.getInstance().userID,_loc4_,GamePlayer.getInstance().Guid);
                  break;
               }
               if(ConstructionAction.currentTarget.EquimentInfoData.BuildID == EquimentTypeEnum.EQUIMENT_TYPE_SHIPREPAIR)
               {
                  ShipPairUI.getInstance().Init();
                  GameKernel.popUpDisplayManager.Show(ShipPairUI.getInstance());
                  break;
               }
               if(ConstructionAction.currentTarget.EquimentInfoData.BuildID == EquimentTypeEnum.EQUIMENT_TYPE_RACE)
               {
                  _loc5_ = GalaxyManager.instance.enterStar;
                  _loc6_ = _loc5_.FightFlag == 1 ? 1 : 0;
                  if(_loc6_ == 1)
                  {
                     CEffectText.getInstance().showEffectText(GameKernel.renderManager.getUI().getContainer(),StringManager.getInstance().getMessageString("Boss190"));
                     break;
                  }
                  GameMouseZoneManager.NagivateToolBarByName("btn_galaxy",false);
                  GymkhanaUI.getInstance().Init();
                  GymkhanaRouter.getinstance().REQUEST_RACINGINFO(GamePlayer.getInstance().userID);
                  GameKernel.popUpDisplayManager.Show(GymkhanaUI.getInstance());
               }
               break;
            case "CloseBtnMc":
               return;
            case "CopyBtnMc":
               if(InstanceManager.instance.curStatus == InstanceManager.FB_WAITING)
               {
                  if(InstanceManager.instance.curEctype == 1001)
                  {
                     _loc2_ = StringManager.getInstance().getMessageString("Boss117");
                  }
                  else
                  {
                     _loc2_ = StringManager.getInstance().getMessageString("BattleTXT22");
                  }
                  MessagePopup.getInstance().Show(_loc2_,0);
                  break;
               }
               switch(InstanceManager.instance.curStatus)
               {
                  case 0:
                     InstanceUI.instance.Init();
                     break;
                  case 2:
                     InstanceManager.instance.request_MSG_REQUEST_ECTYPEINFO(1);
                     FightManager.instance.CleanFight();
                     break;
                  case 3:
                     InstanceManager.instance.requestNextFB();
               }
               break;
            case "ChallengeBtnMc":
               if(InstanceManager.instance.curStatus != InstanceManager.FB_NONE && InstanceManager.instance.curEctype > -1)
               {
                  if(InstanceManager.instance.curEctype == 1001)
                  {
                     _loc2_ = StringManager.getInstance().getMessageString("Boss117");
                     MessagePopup.getInstance().Show(_loc2_,0);
                     break;
                  }
                  if(InstanceManager.instance.curEctype != 1000)
                  {
                     _loc2_ = StringManager.getInstance().getMessageString("BattleTXT23");
                     MessagePopup.getInstance().Show(_loc2_,0);
                     break;
                  }
               }
               this.openGalaxyMatchUI();
               break;
            case "ArenaBtnMc":
               WrestleUI.getInstance().Show();
               break;
            case "LuckyBtnMc":
               RaidProps.getInstance().Init();
               GameKernel.popUpDisplayManager.Show(RaidProps.getInstance());
               break;
            case "BattleBtn":
               BattlefieldUI.getInstance().Init();
               GameKernel.popUpDisplayManager.Show(BattlefieldUI.getInstance());
         }
         this.Hide();
      }
      
      public function openGalaxyMatchUI() : void
      {
         GameMouseZoneManager.NagivateToolBarByName("btn_galaxy",false);
         GalaxyMatchUI.instance.Init();
      }
      
      private function onPopInfoOverHandler(param1:MouseEvent) : void
      {
         if(ConstructionAction.currentTarget == null)
         {
            return;
         }
         var _loc2_:Equiment = ConstructionAction.currentTarget;
         var _loc3_:Point = MovieClip(param1.currentTarget).localToGlobal(new Point());
         _loc3_.x += MovieClip(param1.currentTarget).width;
         _loc3_.y += MovieClip(param1.currentTarget).height;
         switch(param1.target.name)
         {
            case "UpgradeBtnMc":
               if(GalaxyManager.instance.enterStar && GalaxyManager.instance.enterStar.Type == GalaxyType.GT_3 && Boolean(ConstructionAction.isConsortiaLeader))
               {
                  this._infoDecorate = ConstructionTipFactory.setInfoDecorate("StarLevelnfo");
                  this._infoDecorate.setInfoValue(_loc2_.EquimentInfoData.BuildID,_loc2_.EquimentInfoData.IndexId,_loc2_.EquimentInfoData.LevelId,CTipModule.MODULE_STARLEVEL);
                  this._infoDecorate.Show(_loc3_.x,_loc3_.y);
                  return;
               }
               this._infoDecorate = ConstructionTipFactory.setInfoDecorate("Info");
               if(!ConstructionUtil.HaveNextLevel(_loc2_.EquimentInfoData.IndexId))
               {
                  this._infoDecorate.setInfoValue(_loc2_.EquimentInfoData.BuildID,_loc2_.EquimentInfoData.IndexId,_loc2_.EquimentInfoData.LevelId,CTipModule.MODULE_UPGRADE);
                  this._infoDecorate.Show(_loc3_.x,_loc3_.y);
                  break;
               }
               ConstructionAction.getInstance().checkCanBuild(_loc2_.EquimentInfoData.BuildID,_loc2_.EquimentInfoData.LevelId + 1);
               this._infoDecorate.setInfoValue(_loc2_.EquimentInfoData.BuildID,_loc2_.EquimentInfoData.IndexId,_loc2_.EquimentInfoData.LevelId + 1,CTipModule.MODULE_UPGRADE);
               this._infoDecorate.Show(_loc3_.x,_loc3_.y);
               break;
            case "PickBtnMc":
               this._infoDecorate = ConstructionTipFactory.setInfoDecorate("CapacityInfo");
               this._infoDecorate.setInfoValue(_loc2_.EquimentInfoData.BuildID,_loc2_.EquimentInfoData.IndexId,_loc2_.EquimentInfoData.LevelId,CTipModule.MODULE_CAPACITY);
               this._infoDecorate.Show(_loc3_.x,_loc3_.y);
               break;
            case "CloseBtnMc":
               if(GalaxyManager.instance.enterStar.Type == GalaxyType.GT_3)
               {
                  this._infoDecorate = ConstructionTipFactory.setInfoDecorate("BaseStarLevelInfo");
                  this._infoDecorate.setInfoValue(_loc2_.EquimentInfoData.BuildID,_loc2_.EquimentInfoData.IndexId,_loc2_.EquimentInfoData.LevelId,CTipModule.MODULE_BASESTARLEVEL);
                  this._infoDecorate.Show(_loc3_.x,_loc3_.y);
                  return;
               }
               this._infoDecorate = ConstructionTipFactory.setInfoDecorate("BaseInfo");
               this._infoDecorate.setInfoValue(_loc2_.EquimentInfoData.BuildID,_loc2_.EquimentInfoData.IndexId,_loc2_.EquimentInfoData.LevelId,CTipModule.MODULE_BASEINFO);
               this._infoDecorate.Show(_loc3_.x,_loc3_.y);
         }
      }
      
      public function onPopInfoOutHandler(param1:MouseEvent) : void
      {
         if(this._infoDecorate)
         {
            this._infoDecorate.Hide();
         }
      }
   }
}

