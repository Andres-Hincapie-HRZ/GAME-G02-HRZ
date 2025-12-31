package logic.ui
{
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.geom.CFilter;
   import com.star.frameworks.utils.HashSet;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.text.TextField;
   import logic.action.ConstructionAction;
   import logic.action.OutSideGalaxiasAction;
   import logic.action.StarSurfaceAction;
   import logic.entry.Equiment;
   import logic.entry.EquimentFactory;
   import logic.entry.GameStageEnum;
   import logic.entry.MObject;
   import logic.entry.blurprint.EquimentBlueprint;
   import logic.game.ConstructionAnimationManager;
   import logic.game.GameKernel;
   import logic.game.GameSetting;
   import logic.game.GameStatisticsManager;
   import logic.manager.GalaxyManager;
   import logic.manager.GameInterActiveManager;
   import logic.manager.GamePopUpDisplayManager;
   import logic.reader.CConstructionReader;
   import logic.ui.info.CTipModule;
   import logic.ui.info.ConstructionTipFactory;
   import logic.ui.info.IInfoDecorate;
   import logic.widget.ConstructionOperationWidget;
   import logic.widget.OperationEnum;
   import logic.widget.SingleLoader;
   
   public class ConstructionCellUI extends MObject
   {
      
      private var _index:int;
      
      private var _curPageIndex:int;
      
      private var _curNum:int;
      
      private var _maxNum:int;
      
      private var _buildId:int;
      
      private var _isAllowUse:Boolean;
      
      private var _buildNameTxt:TextField;
      
      private var _numTxt:TextField;
      
      private var _baseMc:MovieClip;
      
      private var _imageName:String;
      
      private var _constuctionMc:Bitmap;
      
      private var _infoDecorate:IInfoDecorate;
      
      private var _dependCondition:HashSet;
      
      private var _filter:CFilter;
      
      public function ConstructionCellUI(param1:int, param2:int, param3:int)
      {
         super("BuildlistMc");
         this._index = param1;
         this._buildId = param2;
         this._curPageIndex = param3;
         this.init();
      }
      
      public function get Index() : int
      {
         return this._index;
      }
      
      public function get BuildID() : int
      {
         return this._buildId;
      }
      
      public function get DependCondition() : HashSet
      {
         return this._dependCondition;
      }
      
      private function init() : void
      {
         this._numTxt = TextField(getMC().tf_page);
         this._buildNameTxt = TextField(getMC().tf_name);
         this._baseMc = getMC().mc_base as MovieClip;
         this._filter = new CFilter();
         this._filter.generate_colorMatrix_filter();
         GameInterActiveManager.InstallInterActiveEvent(this._baseMc,ActionEvent.ACTION_CLICK,this.onCellItemClick);
         GameInterActiveManager.InstallInterActiveEvent(this._baseMc,ActionEvent.ACTION_MOUSE_OVER,this.onCellOver);
         GameInterActiveManager.InstallInterActiveEvent(this._baseMc,ActionEvent.ACTION_MOUSE_OUT,this.onCellOut);
      }
      
      public function isOverLimit() : Boolean
      {
         if(this._maxNum == 0)
         {
            return true;
         }
         return this._curNum >= this._maxNum;
      }
      
      private function isAllowUseState() : Boolean
      {
         switch(GameKernel.currentGameStage)
         {
            case GameStageEnum.GAME_STAGE_STARSURFACE:
               if(this._curPageIndex < GameSetting.CONSTRUCTION_TYPE_DEFENSE)
               {
                  this._isAllowUse = true;
                  gotoAndStopFrame(1);
                  this._baseMc.mouseEnabled = true;
                  break;
               }
               this._isAllowUse = false;
               gotoAndStopFrame(2);
               this._baseMc.mouseEnabled = true;
               break;
            case GameStageEnum.GAME_STAGE_OUTSIDE:
               if(this._curPageIndex < GameSetting.CONSTRUCTION_TYPE_DEFENSE)
               {
                  this._isAllowUse = false;
                  gotoAndStopFrame(2);
                  break;
               }
               if(GalaxyManager.instance.enterStar.FightFlag & 1)
               {
                  this._isAllowUse = false;
                  gotoAndStopFrame(2);
                  break;
               }
               this._isAllowUse = true;
               gotoAndStopFrame(1);
         }
         return this._isAllowUse;
      }
      
      public function setConstructionNum(param1:int, param2:int) : void
      {
         this._curNum = param1;
         this._maxNum = param2;
         this._numTxt.text = this._curNum.toString() + "/" + this._maxNum.toString();
      }
      
      public function setCreateBtnState() : void
      {
         if(!this.isAllowUseState())
         {
            this._isAllowUse = false;
            gotoAndStopFrame(2);
            this._baseMc.mouseEnabled = true;
            return;
         }
         if(this.isOverLimit())
         {
            this._isAllowUse = false;
            gotoAndStopFrame(2);
            this._baseMc.mouseEnabled = true;
            return;
         }
         if(!this.isResourceFill())
         {
            this._isAllowUse = false;
            gotoAndStopFrame(2);
            this._baseMc.mouseEnabled = true;
            return;
         }
         this._isAllowUse = true;
         gotoAndStopFrame(1);
         this._baseMc.mouseEnabled = true;
      }
      
      public function setConstructionName(param1:String) : void
      {
         this._buildNameTxt.text = param1;
      }
      
      public function setConstructionImage(param1:String) : void
      {
         this._constuctionMc = new Bitmap(GameKernel.getTextureInstance(param1));
         this._baseMc.addChild(this._constuctionMc);
      }
      
      private function onCellItemClick(param1:MouseEvent) : void
      {
         if(ConstructionAction.getInstance().CheckConstructionProgreeIsFull())
         {
            GamePopUpDisplayManager.getInstance().Hide(ConstructionUI.getInstance());
            ConstructionOperationWidget.currenCmd = OperationEnum.OPERATION_TYPE_UPGRADE;
            MallBuyModulesPopup.getInstance().Init();
            MallBuyModulesPopup.getInstance().Show();
            return;
         }
         if(!this._isAllowUse)
         {
            return;
         }
         var _loc2_:Equiment = EquimentFactory.createEquiment(this._buildId);
         if(!_loc2_.IsOkay)
         {
            SingleLoader.GetInstance().Init(_loc2_,ConstructionAction.getInstance().RenderConstruction);
            SingleLoader.GetInstance().Load();
         }
         ConstructionAnimationManager.StopConstructionDestined(_loc2_);
         _loc2_.setEquimentSenseZone();
         if(GameKernel.currentGameStage == GameStageEnum.GAME_STAGE_OUTSIDE)
         {
            ConstructionAction.currentTarget = _loc2_;
            _loc2_.unRegisterActionEvent();
            _loc2_.mouseChildren = false;
            _loc2_.mouseEnabled = false;
            OutSideGalaxiasAction.getInstance().changeConstuctionModel(true);
            OutSideGalaxiasAction.getInstance().checkLocation(param1);
            OutSideGalaxiasAction.getInstance().addActionEvent();
            OutSideGalaxiasAction.getInstance().unRegisterShipEvent();
            OutSideGalaxiasAction.getInstance().OutSideDefendContainer.addChild(_loc2_);
         }
         else if(GameKernel.currentGameStage == GameStageEnum.GAME_STAGE_STARSURFACE)
         {
            StarSurfaceAction.getInstance().changeConstructionModel(true);
            ConstructionAction.currentTarget = _loc2_;
            ConstructionAction.currentTarget.getMC().filters = [new GlowFilter(16774661)];
            ConstructionAction.currentTarget.addEquimentSenseZone();
            ConstructionAction.senseZoneList.push(_loc2_.EquimentSenseZone);
            StarSurfaceAction.getInstance().addActionEvent();
            StarSurfaceAction.getInstance().checkLocation(param1);
            StarSurfaceAction.getInstance().LayOut.addChild(ConstructionAction.currentTarget);
         }
         ConstructionAction.currentTarget.EquimentInfoData.BuildID = _loc2_.BlurPrint.BuildingID;
         ConstructionAction.currentTarget.EquimentInfoData.BuildName = _loc2_.BlurPrint.BuildingName;
         ConstructionAction.currentTarget.EquimentInfoData.LevelId = 0;
         ConstructionUI.getInstance().onCloseWnd(param1);
      }
      
      private function onCellOver(param1:MouseEvent) : void
      {
         ConstructionUI.getInstance().CurrentConstructionCell = this;
         var _loc2_:EquimentBlueprint = CConstructionReader.getInstance().Read(this._buildId);
         var _loc3_:Equiment = EquimentFactory.createEquiment(this._buildId,0);
         this._infoDecorate = ConstructionTipFactory.setInfoDecorate("Info");
         this._infoDecorate.setInfoValue(this._buildId,-1,0,CTipModule.MODULE_UPGRADE);
         var _loc4_:Point = this._baseMc.localToGlobal(new Point());
         this._infoDecorate.Show(_loc4_.x + this._baseMc.width * 0.5,_loc4_.y + this._baseMc.height * 0.5);
      }
      
      private function isResourceFill() : Boolean
      {
         var _loc1_:Boolean = ConstructionAction.getInstance().checkCanBuild(this._buildId,0);
         if(this._dependCondition == null)
         {
            this._dependCondition = GameStatisticsManager.getInstance().Record.Clone();
         }
         return _loc1_;
      }
      
      private function onCellOut(param1:MouseEvent) : void
      {
         this._infoDecorate.Hide();
      }
      
      public function Clear() : void
      {
         GameInterActiveManager.unInstallnterActiveEvent(this._baseMc,ActionEvent.ACTION_CLICK,this.onCellItemClick);
         GameInterActiveManager.unInstallnterActiveEvent(this._baseMc,ActionEvent.ACTION_MOUSE_OVER,this.onCellOver);
         GameInterActiveManager.unInstallnterActiveEvent(this._baseMc,ActionEvent.ACTION_MOUSE_OUT,this.onCellOut);
         this._baseMc.removeChild(this._constuctionMc);
         this._constuctionMc = null;
      }
   }
}

