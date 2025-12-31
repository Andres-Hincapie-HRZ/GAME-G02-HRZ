package logic.widget
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.utils.HashSet;
   import com.star.frameworks.utils.ObjectUtil;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import logic.action.ConstructionAction;
   import logic.action.OutSideGalaxiasAction;
   import logic.action.StarSurfaceAction;
   import logic.entry.ConstructionState;
   import logic.entry.Equiment;
   import logic.entry.GameStageEnum;
   import logic.entry.HButton;
   import logic.game.GameKernel;
   import logic.manager.GameInterActiveManager;
   import logic.ui.UpgradeModulesPopUp;
   import logic.ui.info.CTipModule;
   import logic.ui.info.ConstructionInfoDecorate;
   import logic.ui.info.ConstructionTipFactory;
   import logic.ui.info.IInfoDecorate;
   
   public class OperationWidget
   {
      
      private static var instance:OperationWidget;
      
      private var _operationContainer:Container;
      
      private var _btnPool:HashSet;
      
      private var _currentBtnArr:Array;
      
      private var _infoDecorate:IInfoDecorate;
      
      private var _updateBtn:HButton;
      
      private var _speedBtn:HButton;
      
      private var _pickBtn:HButton;
      
      private var _moveBtn:HButton;
      
      private var _destoryBtn:HButton;
      
      private var _cancelBtn:HButton;
      
      private var _closeBtn:HButton;
      
      private var _enterBtn:HButton;
      
      private var _improveBtn:HButton;
      
      private var _buildNameTF:TextField;
      
      public function OperationWidget()
      {
         super();
         this._btnPool = new HashSet();
         this._operationContainer = new Container("OperationContainer");
         this._operationContainer.graphics.beginFill(13421772,0.5);
         this._operationContainer.graphics.drawCircle(80,0,50);
         this._operationContainer.graphics.endFill();
         this._buildNameTF = new TextField();
         this._buildNameTF.name = "buildTF";
         this._buildNameTF.text = "213123";
         this._buildNameTF.border = true;
         this._buildNameTF.borderColor = 16777215;
         this._buildNameTF.textColor = 16711680;
         this._buildNameTF.wordWrap = true;
         this._buildNameTF.autoSize = "center";
         this._buildNameTF.width = 60;
         this._buildNameTF.x = 55;
         this._buildNameTF.y = -20;
         this._operationContainer.addChild(this._buildNameTF);
         this.initBtnElemetn();
      }
      
      public static function getInstance() : OperationWidget
      {
         if(instance == null)
         {
            instance = new OperationWidget();
         }
         return instance;
      }
      
      private function initBtnElemetn() : void
      {
         this._updateBtn = new HButton(GameKernel.getMovieClipInstance("UpgradeBtnMc"));
         this._speedBtn = new HButton(GameKernel.getMovieClipInstance("SpeedBtnMc"));
         this._pickBtn = new HButton(GameKernel.getMovieClipInstance("PickBtnMc"));
         this._moveBtn = new HButton(GameKernel.getMovieClipInstance("MoveBtnMc"));
         this._destoryBtn = new HButton(GameKernel.getMovieClipInstance("BackoutBtnMc"));
         this._cancelBtn = new HButton(GameKernel.getMovieClipInstance("BuildcancelBtnMc"));
         this._closeBtn = new HButton(GameKernel.getMovieClipInstance("CloseBtnMc"));
         this._enterBtn = new HButton(GameKernel.getMovieClipInstance("EnterBtnMc"));
         this._improveBtn = new HButton(GameKernel.getMovieClipInstance("EnterBtnMc"));
         this._btnPool.Put(OperationEnum.OPERATION_TYPE_UPGRADE,this._updateBtn);
         this._btnPool.Put(OperationEnum.OPERATION_TYPE_SPEED,this._speedBtn);
         this._btnPool.Put(OperationEnum.OPERATION_TYPE_PICK,this._pickBtn);
         this._btnPool.Put(OperationEnum.OPERATION_TYPE_MOVE,this._moveBtn);
         this._btnPool.Put(OperationEnum.OPERATION_TYPE_DESTORY,this._destoryBtn);
         this._btnPool.Put(OperationEnum.OPERATION_TYPE_CANCEL,this._cancelBtn);
         this._btnPool.Put(OperationEnum.OPERATION_TYPE_VIEW,this._closeBtn);
         this._btnPool.Put(OperationEnum.OPERATION_TYPE_ENTER,this._enterBtn);
         this._btnPool.Put(OperationEnum.OPERATION_TYPE_IMPROVE,this._improveBtn);
      }
      
      public function setLocation(param1:int, param2:int) : void
      {
         if(this._operationContainer == null)
         {
            this.initBtnElemetn();
         }
         this._operationContainer.x = param1;
         this._operationContainer.y = param2;
         GameKernel.renderManager.getUI().addComponent(this._operationContainer);
      }
      
      public function get Operation() : Container
      {
         return this._operationContainer;
      }
      
      public function Hide() : void
      {
         if(this._operationContainer == null || this._operationContainer.parent == null)
         {
            return;
         }
         this._operationContainer.parent.removeChild(this._operationContainer);
         this.destoryCurrentBtnEvent();
      }
      
      private function SortBtn(param1:Array) : void
      {
         var _loc2_:HButton = null;
         var _loc3_:HButton = null;
         var _loc4_:HButton = null;
         var _loc5_:HButton = null;
         var _loc6_:HButton = null;
         if(Boolean(param1.length) && param1 != null)
         {
            if(param1.length == 5)
            {
               _loc2_ = HButton(this._btnPool.Get(param1[0]));
               _loc2_.m_movie.x = 60;
               _loc2_.m_movie.y = -70;
               _loc3_ = HButton(this._btnPool.Get(param1[1]));
               _loc3_.m_movie.x = 90;
               _loc3_.m_movie.y = 10;
               _loc4_ = HButton(this._btnPool.Get(param1[2]));
               _loc4_.m_movie.x = 30;
               _loc4_.m_movie.y = 10;
               _loc5_ = HButton(this._btnPool.Get(param1[3]));
               _loc5_.m_movie.x = 10;
               _loc5_.m_movie.y = -30;
               _loc6_ = HButton(this._btnPool.Get(param1[4]));
               _loc6_.m_movie.x = 110;
               _loc6_.m_movie.y = -30;
               this._operationContainer.addChild(_loc2_.m_movie);
               this._operationContainer.addChild(_loc3_.m_movie);
               this._operationContainer.addChild(_loc4_.m_movie);
               this._operationContainer.addChild(_loc5_.m_movie);
               this._operationContainer.addChild(_loc6_.m_movie);
            }
            else if(param1.length == 4)
            {
               _loc2_ = HButton(this._btnPool.Get(param1[0]));
               _loc2_.m_movie.x = 60;
               _loc2_.m_movie.y = -70;
               _loc3_ = HButton(this._btnPool.Get(param1[1]));
               _loc3_.m_movie.x = 110;
               _loc3_.m_movie.y = -30;
               _loc4_ = HButton(this._btnPool.Get(param1[2]));
               _loc4_.m_movie.x = 60;
               _loc4_.m_movie.y = 20;
               _loc5_ = HButton(this._btnPool.Get(param1[3]));
               _loc5_.m_movie.x = 10;
               _loc5_.m_movie.y = -30;
               this._operationContainer.addChild(_loc2_.m_movie);
               this._operationContainer.addChild(_loc3_.m_movie);
               this._operationContainer.addChild(_loc4_.m_movie);
               this._operationContainer.addChild(_loc5_.m_movie);
            }
            else if(param1.length == 3)
            {
               _loc2_ = HButton(this._btnPool.Get(param1[0]));
               _loc2_.m_movie.x = 60;
               _loc2_.m_movie.y = -70;
               _loc3_ = HButton(this._btnPool.Get(param1[1]));
               _loc3_.m_movie.x = 90;
               _loc3_.m_movie.y = 10;
               _loc4_ = HButton(this._btnPool.Get(param1[2]));
               _loc4_.m_movie.x = 30;
               _loc4_.m_movie.y = 10;
               this._operationContainer.addChild(_loc2_.m_movie);
               this._operationContainer.addChild(_loc3_.m_movie);
               this._operationContainer.addChild(_loc4_.m_movie);
            }
         }
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
            this._currentBtnArr.push(this._btnPool.Get(_loc3_));
            this.registerEvent(this._btnPool.Get(_loc3_));
         }
         this.SortBtn(_loc2_);
         this.Validate();
      }
      
      private function Validate() : void
      {
         if(ConstructionAction.currentTarget == null)
         {
            return;
         }
         if(!ConstructionUtil.HaveNextLevel(ConstructionAction.currentTarget.EquimentInfoData.BuildID))
         {
            return;
         }
         if(!ConstructionAction.getInstance().checkCanBuild(ConstructionAction.currentTarget.EquimentInfoData.BuildID,ConstructionAction.currentTarget.EquimentInfoData.LevelId + 1))
         {
            this._updateBtn.setBtnDisabled(true);
            this._updateBtn.m_movie.mouseEnabled = true;
         }
         else
         {
            this._updateBtn.setBtnDisabled(false);
         }
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
            this._operationContainer.removeChild(_loc1_.m_movie);
         }
      }
      
      private function Sort() : void
      {
         var _loc2_:HButton = null;
         if(this._currentBtnArr == null || this._currentBtnArr.length == 0)
         {
            return;
         }
         this.reSet();
         var _loc1_:int = 0;
         for each(_loc2_ in this._currentBtnArr)
         {
            _loc2_.m_movie.y -= _loc1_ * _loc2_.m_movie.height;
            _loc1_++;
         }
      }
      
      private function reSet() : void
      {
         var _loc1_:HButton = null;
         for each(_loc1_ in this._currentBtnArr)
         {
            _loc1_.m_movie.y = 0;
         }
      }
      
      public function setConstructionName(param1:String) : void
      {
         this._buildNameTF.text = param1;
      }
      
      private function onConstructionPanelHandler(param1:MouseEvent) : void
      {
         var _loc2_:Equiment = null;
         if(ConstructionAction.currentTarget == null)
         {
            return;
         }
         switch(param1.target.name)
         {
            case "UpgradeBtnMc":
               if(this._infoDecorate)
               {
                  ConstructionInfoDecorate.getInstance().Hide();
               }
               if(ConstructionAction.getInstance().CheckConstructionProgreeIsFull())
               {
                  UpgradeModulesPopUp.getInstance().Init();
                  UpgradeModulesPopUp.getInstance().Show();
                  this.Hide();
                  return;
               }
               _loc2_ = ConstructionAction.currentTarget;
               if(ConstructionAction.getInstance().checkCanBuild(_loc2_.EquimentInfoData.BuildID,_loc2_.EquimentInfoData.LevelId + 1))
               {
                  _loc2_.State = ConstructionState.STATE_UPDATE;
                  ConstructionAction.getInstance().createBuildRequest(_loc2_);
                  ConstructionAction.BuildingList.push(_loc2_);
               }
               break;
            case "SpeedBtnMc":
               break;
            case "PickBtnMc":
               this._infoDecorate = ConstructionTipFactory.setInfoDecorate("CapacityInfo");
               this._infoDecorate.setInfoValue(ConstructionAction.currentTarget.EquimentInfoData.BuildID,ConstructionAction.currentTarget.EquimentInfoData.LevelId,CTipModule.MODULE_CAPACITY);
               this._infoDecorate.Show(param1.stageX,param1.stageY);
               ConstructionAction.getInstance().sendGetStorageResource();
               break;
            case "MoveBtnMc":
               if(ConstructionAction.currentTarget.State == ConstructionState.STATE_BUILING || ConstructionAction.currentTarget.State == ConstructionState.STATE_UPDATE)
               {
                  return;
               }
               switch(GameKernel.currentGameStage)
               {
                  case GameStageEnum.GAME_STAGE_OUTSIDE:
                     OutSideGalaxiasAction.getInstance().changeConstuctionModel(true);
                     OutSideGalaxiasAction.getInstance().addActionEvent();
                     break;
                  case GameStageEnum.GAME_STAGE_STARSURFACE:
                     StarSurfaceAction.getInstance().changeConstructionModel(true);
                     StarSurfaceAction.getInstance().IsMigrate = true;
                     StarSurfaceAction.getInstance().addActionEvent();
               }
               ConstructionAction.currentTarget.State = ConstructionState.STATE_MIRGRATE;
               ConstructionAction.currentTarget.stop();
               break;
            case "BackoutBtnMc":
               if(GameKernel.currentMapModelIndex & 1)
               {
                  ConstructionAction.currentTarget.HideEquimentInfluence();
               }
               ConstructionAction.getInstance().deleteBuildRequest(ConstructionAction.currentTarget.EquimentInfoData.IndexId);
               break;
            case "BuildcancelBtnMc":
               if(ConstructionAction.currentTarget.State == ConstructionState.STATE_UPDATE || ConstructionAction.currentTarget.State == ConstructionState.STATE_BUILING)
               {
                  ConstructionAction.getInstance().cancelBuildRequest(ConstructionAction.currentTarget.EquimentInfoData.IndexId);
                  ProgressListToolBarWidget.getInstance().Destory(ConstructionAction.currentTarget);
                  ConstructionAction.currentTarget = null;
               }
               break;
            case "EnterBtnMc":
               break;
            case "CloseBtnMc":
               this.destoryCurrentBtnEvent();
         }
         this.Hide();
      }
      
      private function onPopInfoOverHandler(param1:MouseEvent) : void
      {
         switch(param1.target.name)
         {
            case "buildTF":
               break;
            case "EnterBtnMc":
               this._infoDecorate = ConstructionTipFactory.setInfoDecorate("BaseInfo");
               this._infoDecorate.setInfoValue(ConstructionAction.currentTarget.EquimentInfoData.BuildID,ConstructionAction.currentTarget.EquimentInfoData.LevelId,CTipModule.MODULE_BASEINFO);
               this._infoDecorate.Show(param1.stageX,param1.stageY);
               break;
            case "UpgradeBtnMc":
               this._infoDecorate = ConstructionTipFactory.setInfoDecorate("Info");
               ConstructionAction.getInstance().checkCanBuild(ConstructionAction.currentTarget.EquimentInfoData.BuildID,ConstructionAction.currentTarget.EquimentInfoData.LevelId + 1);
               this._infoDecorate.setInfoValue(ConstructionAction.currentTarget.EquimentInfoData.BuildID,ConstructionAction.currentTarget.EquimentInfoData.LevelId + 1,CTipModule.MODULE_UPGRADE);
               this._infoDecorate.Show(param1.stageX,param1.stageY);
               break;
            case "PickBtnMc":
               this._infoDecorate = ConstructionTipFactory.setInfoDecorate("CapacityInfo");
               this._infoDecorate.setInfoValue(ConstructionAction.currentTarget.EquimentInfoData.BuildID,ConstructionAction.currentTarget.EquimentInfoData.LevelId,CTipModule.MODULE_CAPACITY);
               this._infoDecorate.Show(param1.stageX,param1.stageY);
         }
      }
      
      private function onPopInfoOutHandler(param1:MouseEvent) : void
      {
         if(this._infoDecorate)
         {
            this._infoDecorate.Hide();
         }
      }
   }
}

