package logic.action
{
   import com.star.frameworks.basic.Collision;
   import com.star.frameworks.display.Container;
   import com.star.frameworks.display.loader.ImageLoader;
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.events.LoaderEvent;
   import com.star.frameworks.utils.HashSet;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import logic.entry.AbstraceAction;
   import logic.entry.ConstructionSenseZone;
   import logic.entry.ConstructionState;
   import logic.entry.Equiment;
   import logic.entry.EquimentFactory;
   import logic.entry.EquimentTypeEnum;
   import logic.entry.GamePlaceType;
   import logic.entry.GamePlayer;
   import logic.entry.ScienceSystem;
   import logic.entry.StarSufaceMarkZone;
   import logic.game.CDN;
   import logic.game.ConstructionAnimationManager;
   import logic.game.GameKernel;
   import logic.game.GameSetting;
   import logic.game.GameStateManager;
   import logic.manager.GalaxyManager;
   import logic.manager.GameInterActiveManager;
   import logic.manager.GameModuleActionManager;
   import logic.ui.MallBuyModulesPopup;
   import logic.widget.ConstructionOperationWidget;
   import logic.widget.OperationEnum;
   import logic.widget.SingleLoader;
   import logic.widget.StarSurFaceDragger;
   import net.router.UpgradeRouter;
   
   public class StarSurfaceAction extends AbstraceAction
   {
      
      public static var constructionAction:ConstructionAction;
      
      private static var instance:StarSurfaceAction;
      
      private var _bound:Shape;
      
      private var _sufMapContainer:Container;
      
      private var _floorLayOut:Container;
      
      private var _layout:Container;
      
      private var _floorList:Array;
      
      private var _currentIndex:int;
      
      private var _tmpText:TextField;
      
      private var _buildText:TextField;
      
      private var _isBuildingModule:Boolean;
      
      private var _build:Equiment;
      
      private var _isBuildingDrag:Boolean;
      
      private var _isMigrate:Boolean;
      
      private var isBuildAble:Boolean;
      
      private var collisionList:HashSet;
      
      private var mapSet:HashSet;
      
      private var count:int = 0;
      
      public var loadingMapFinished:Boolean;
      
      private var _dragConstructionSenseZone:ConstructionSenseZone;
      
      public var mapType:int = 0;
      
      private var isDragging:Boolean;
      
      private var dragX:int = 0;
      
      private var dragY:int = 0;
      
      private var startDragX:int = 0;
      
      private var startDragY:int = 0;
      
      public function StarSurfaceAction()
      {
         super();
         if(instance != null)
         {
            throw new Error("SingleTon");
         }
         this.ActionName = "Map_SurfaceManager_Action";
         this._layout = new Container();
         this.LayOut.name = "SurfaceLayout";
         this._floorLayOut = new Container();
         this._floorLayOut.name = "FLoorLayOut";
         this.collisionList = new HashSet();
         this._isBuildingModule = false;
         this.isBuildAble = true;
         this._isBuildingDrag = false;
         this._isMigrate = false;
         constructionAction = GameModuleActionManager.getModuleInstance(ActionModuleDefined.Construction_action) as ConstructionAction;
         constructionAction.SufFaceUI = this._layout;
      }
      
      public static function getInstance() : StarSurfaceAction
      {
         if(instance == null)
         {
            instance = new StarSurfaceAction();
         }
         return instance;
      }
      
      public function get LayOut() : Container
      {
         return this._layout;
      }
      
      public function get SurFaceContainer() : Container
      {
         return this._sufMapContainer;
      }
      
      public function get BuildingModel() : Boolean
      {
         return this._isBuildingModule;
      }
      
      public function set BuildingModel(param1:Boolean) : void
      {
         this._isBuildingModule = param1;
      }
      
      public function get IsBuildDrag() : Boolean
      {
         return this._isBuildingDrag;
      }
      
      public function set IsBuildDrag(param1:Boolean) : void
      {
         this._isBuildingDrag = param1;
      }
      
      public function get IsMigrate() : Boolean
      {
         return this._isMigrate;
      }
      
      public function set IsMigrate(param1:Boolean) : void
      {
         this._isMigrate = param1;
      }
      
      override public function getUI() : Container
      {
         return this._sufMapContainer;
      }
      
      override public function Init() : void
      {
         if(this._sufMapContainer)
         {
            this.sortList();
            return;
         }
         this._sufMapContainer = new Container();
         this.mapSet = new HashSet();
         this._sufMapContainer.name = "SufMapContainer";
         this._sufMapContainer.setEnable(true);
         this.loadingMapFinished = false;
         StarSufaceMarkZone.getInstance().Draw(this._floorLayOut.width - 2000 >> 1,this._floorLayOut.height - 800 >> 1);
         this.SurFaceContainer.addChild(this._floorLayOut);
         this.SurFaceContainer.addChild(this._layout);
         this.SurFaceContainer.setLocationXY(-600,-600);
         StarSurFaceDragger.getInstance().Register(this.SurFaceContainer);
         GameKernel.getInstance().initStageKeyBoard();
      }
      
      public function Release() : void
      {
      }
      
      public function RenderSurFaceFloorLayOut() : void
      {
         var _loc8_:int = 0;
         var _loc9_:Bitmap = null;
         var _loc1_:HashSet = this.mapSet.Get(this.mapType);
         var _loc2_:BitmapData = _loc1_.Get(0);
         var _loc3_:BitmapData = _loc1_.Get(1);
         var _loc4_:BitmapData = _loc1_.Get(2);
         var _loc5_:BitmapData = _loc1_.Get(3);
         var _loc6_:int = 4;
         this._floorList = new Array();
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_)
         {
            this._floorList[_loc7_] = new Array();
            _loc8_ = 0;
            while(_loc8_ < _loc6_)
            {
               if(_loc7_ == 0 && _loc8_ == 0 || _loc7_ == 3 && _loc8_ == 3)
               {
                  _loc9_ = new Bitmap(_loc5_);
               }
               else if(_loc7_ == 0 && _loc8_ == 1 || _loc7_ == 1 && _loc8_ == 2)
               {
                  _loc9_ = new Bitmap(_loc4_);
               }
               else if(_loc7_ == 1 && _loc8_ == 1 || _loc7_ == 1 && _loc8_ == 3 || _loc7_ == 2 && _loc8_ == 0 || _loc7_ == 2 && _loc8_ == 2)
               {
                  _loc9_ = new Bitmap(_loc3_);
               }
               else
               {
                  _loc9_ = new Bitmap(_loc4_);
               }
               _loc9_.x = _loc8_ * 500;
               _loc9_.y = _loc7_ * 449;
               this._floorList[_loc7_][_loc8_] = _loc9_;
               _loc9_.blendMode = BlendMode.NORMAL;
               this._floorLayOut.addChild(_loc9_);
               _loc8_++;
            }
            _loc7_++;
         }
      }
      
      public function paintSurFaceFloorLayOut() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:HashSet = null;
         var _loc4_:HashSet = null;
         var _loc5_:ImageLoader = null;
         var _loc6_:int = 0;
         if(this.mapSet.ContainsKey(this.mapType))
         {
            _loc3_ = this.mapSet.Get(this.mapType);
            if(_loc3_ == null)
            {
               return;
            }
            if(_loc3_.Length() == 0)
            {
               return;
            }
            this.loadingMapFinished = true;
            this.RenderSurFaceFloorLayOut();
         }
         else
         {
            this.loadingMapFinished = false;
            _loc4_ = new HashSet();
            _loc6_ = 0;
            while(_loc6_ < 4)
            {
               _loc1_ = "a_0" + _loc6_;
               _loc5_ = new ImageLoader();
               _loc2_ = CDN.CDN_PATH + CDN.map + this.mapType + "/" + this.SetMapWrap(this.mapType,_loc1_) + GameSetting.GAME_TEXTURE_PRIX;
               _loc5_.LoadImage(_loc2_,_loc6_,this.__onBindImage);
               _loc6_++;
            }
            this.mapSet.Put(this.mapType,_loc4_);
         }
      }
      
      private function SetMapWrap(param1:int, param2:String) : String
      {
         switch(param1)
         {
            case 0:
               param2 = "desert_" + param2;
               break;
            case 1:
               param2 = "snow_" + param2;
               break;
            case 2:
               param2 = "load_" + param2;
         }
         return param2;
      }
      
      private function __onBindImage(param1:int, param2:Bitmap) : void
      {
         var _loc3_:HashSet = null;
         if(param2)
         {
            _loc3_ = this.mapSet.Get(this.mapType);
            _loc3_.Put(param1,param2.bitmapData);
         }
         ++this.count;
         if(this.count == 4)
         {
            this.loadingMapFinished = true;
            this.RenderSurFaceFloorLayOut();
            StarSufaceMarkZone.getInstance().Draw(this._floorLayOut.width - 2000 >> 1,this._floorLayOut.height - 800 >> 1);
            this.count = 0;
            return;
         }
      }
      
      public function loadConstuctionList() : void
      {
         var _loc2_:Equiment = null;
         var _loc1_:Array = ConstructionAction.constuctionList.Values();
         for each(_loc2_ in _loc1_)
         {
            _loc2_.setLocation(_loc2_.EquimentInfoData.PosX,_loc2_.EquimentInfoData.PosY);
            _loc2_.setEquimentSenseZone();
            _loc2_.registerActionEvent();
            ConstructionAction.senseZoneList.push(_loc2_.EquimentSenseZone);
            if(_loc2_.EquimentInfoData.BuildID == EquimentTypeEnum.EQUIMENT_TYPE_RADAR)
            {
               _loc2_.PlayAnimation(true);
            }
            this._layout.addChild(_loc2_);
         }
         if(GameStateManager.playerPlace != GamePlaceType.PLACE_HOME)
         {
            ConstructionAnimationManager.StopConstructionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_SHIPBUILDING);
            ConstructionAnimationManager.StopConstructionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_TECHRESEARCHCENTER);
            ConstructionAnimationManager.StopConstructionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_WEAPONRESEARCHCENTER);
            this.sortList();
            return;
         }
         if(GalaxyManager.instance.isMineHome())
         {
            StarSurfaceAction.getInstance().SetAnimationState();
         }
         this.sortList();
      }
      
      public function onAllCompleted(param1:LoaderEvent) : void
      {
         if(GameStateManager.playerPlace != GamePlaceType.PLACE_HOME)
         {
            ConstructionAnimationManager.StopConstructionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_SHIPBUILDING);
            ConstructionAnimationManager.StopConstructionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_TECHRESEARCHCENTER);
            ConstructionAnimationManager.StopConstructionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_WEAPONRESEARCHCENTER);
            this.sortList();
            return;
         }
         StarSurfaceAction.getInstance().SetAnimationState();
      }
      
      public function SetAnimationState() : void
      {
         if(GamePlayer.getInstance().m_IfbeingCreatShip)
         {
            ConstructionAnimationManager.PlayConstuctionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_SHIPBUILDING);
         }
         else
         {
            ConstructionAnimationManager.StopConstructionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_SHIPBUILDING);
         }
         if(ScienceSystem.getinstance().Online)
         {
            ConstructionAnimationManager.PlayConstuctionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_TECHRESEARCHCENTER);
         }
         else
         {
            ConstructionAnimationManager.StopConstructionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_TECHRESEARCHCENTER);
         }
         if(!UpgradeRouter.instance.IsUpgrading())
         {
            ConstructionAnimationManager.StopConstructionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_WEAPONRESEARCHCENTER);
         }
         ConstructionAction.getInstance().sendStorageResource();
      }
      
      public function checkLocation(param1:MouseEvent) : void
      {
         var _loc2_:int = Math.floor(param1.stageX) - StarSurFaceDragger.getInstance().CurrentPosX;
         var _loc3_:int = Math.floor(param1.stageY) - StarSurFaceDragger.getInstance().CurrentPosY;
         _loc2_ -= ConstructionAction.currentTarget.BlurPrint.Center1.x;
         _loc3_ -= ConstructionAction.currentTarget.BlurPrint.Center1.y;
         ConstructionAction.currentTarget.setLocation(_loc2_,_loc3_);
      }
      
      public function SetConstructionAnimationStatue(param1:Equiment, param2:Boolean = false) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc3_:int = param1.EquimentInfoData.BuildID;
         if(_loc3_ == EquimentTypeEnum.EQUIMENT_TYPE_HELIUM_3 || _loc3_ == EquimentTypeEnum.EQUIMENT_TYPE_METAL || _loc3_ == EquimentTypeEnum.EQUIMENT_TYPE_WEAPONRESEARCHCENTER || _loc3_ == EquimentTypeEnum.EQUIMENT_TYPE_SHIPRECAIM || _loc3_ == EquimentTypeEnum.EQUIMENT_TYPE_CIVICISM || _loc3_ == EquimentTypeEnum.EQUIMENT_TYPE_RADAR || _loc3_ == EquimentTypeEnum.EQUIMENT_TYPE_TECHRESEARCHCENTER || _loc3_ == EquimentTypeEnum.EQUIMENT_TYPE_TRADEPORT || _loc3_ == EquimentTypeEnum.EQUIMENT_TYPE_COMMANDERCENTER || _loc3_ == EquimentTypeEnum.EQUIMENT_TYPE_UNION || _loc3_ == EquimentTypeEnum.EQUIMENT_TYPE_HOMEREGION || _loc3_ == EquimentTypeEnum.EQUIMENT_TYPE_SHIPBUILDING)
         {
            param1.PlayAnimation(param2);
         }
      }
      
      public function addActionEvent() : void
      {
         if(!this._layout.stage.hasEventListener(MouseEvent.MOUSE_MOVE))
         {
            GameInterActiveManager.InstallInterActiveEvent(this._layout.stage,ActionEvent.ACTION_MOUSE_MOVE,this.onMove);
         }
      }
      
      public function removeActionEvent() : void
      {
         if(this._layout.stage.hasEventListener(MouseEvent.MOUSE_MOVE))
         {
            GameInterActiveManager.unInstallnterActiveEvent(this._layout.stage,ActionEvent.ACTION_MOUSE_MOVE,this.onMove);
         }
      }
      
      public function changeConstructionModel(param1:Boolean) : void
      {
         var _loc2_:Equiment = null;
         GameKernel.isBuildModule = param1;
         var _loc3_:Array = ConstructionAction.constuctionList.Values();
         if(param1)
         {
            for each(_loc2_ in _loc3_)
            {
               _loc2_.unRegisterActionEvent();
               _loc2_.addEquimentSenseZone();
               if(_loc2_.EquimentInfoData.BuildID == EquimentTypeEnum.EQUIMENT_TYPE_RESSTORECENTER)
               {
                  ConstructionAnimationManager.StopResourceStorageAnimation(_loc2_);
               }
               else
               {
                  _loc2_.PlayAnimation(false);
               }
            }
         }
         else
         {
            _loc3_ = ConstructionAction.constuctionList.Values();
            for each(_loc2_ in _loc3_)
            {
               if(_loc2_.State == ConstructionState.STATE_COMPLETE)
               {
                  _loc2_.getMC().filters = null;
                  _loc2_.getMC().alpha = 1;
               }
               _loc2_.removeEquimentSenseZone();
               _loc2_.registerActionEvent();
               ConstructionAnimationManager.rePlayConstruction(_loc2_);
            }
         }
      }
      
      private function onMove(param1:MouseEvent) : void
      {
         var _loc2_:Equiment = null;
         if(!ConstructionAction.currentTarget)
         {
            return;
         }
         if(!this._sufMapContainer.hasEventListener(MouseEvent.CLICK))
         {
            GameInterActiveManager.InstallInterActiveEvent(this._sufMapContainer,ActionEvent.ACTION_CLICK,this.onCreate);
         }
         this._isBuildingDrag = true;
         this.checkLocation(param1);
         var _loc3_:Array = ConstructionAction.constuctionList.Values();
         if(Collision.CheckCollistion(StarSufaceMarkZone.getInstance().BorderMarkZone,ConstructionAction.currentTarget.EquimentSenseZone))
         {
            this.checkConstructionHitInfluence();
            this.setConstuctionCollsion();
            ConstructionAction.currentTarget.EquimentSenseZone.setHitState();
            this.isBuildAble = false;
            return;
         }
         StarSufaceMarkZone.getInstance().BorderMarkZone.filters = null;
         this.isBuildAble = true;
         if(!Collision.CheckCollistion(StarSufaceMarkZone.getInstance().CenterMarkZone,ConstructionAction.currentTarget.EquimentSenseZone))
         {
            this.setConstructionAllDefaultState();
            ConstructionAction.currentTarget.EquimentSenseZone.setHitState();
            this.isBuildAble = false;
            return;
         }
         this.checkConstructionHitInfluence();
         this.setConstuctionCollsion();
      }
      
      private function validateBuildAble() : Boolean
      {
         return this.isBuildAble && this.collisionList.Length() == 0;
      }
      
      public function setConstructionAllDefaultState() : void
      {
         var _loc1_:ConstructionSenseZone = null;
         for each(_loc1_ in ConstructionAction.senseZoneList)
         {
            if(_loc1_.IsHit)
            {
               _loc1_.setDefaultState();
            }
         }
      }
      
      private function checkConstructionHitInfluence() : void
      {
         var _loc1_:ConstructionSenseZone = null;
         for each(_loc1_ in ConstructionAction.senseZoneList)
         {
            if(Boolean(_loc1_) && _loc1_ != ConstructionAction.currentTarget.EquimentSenseZone)
            {
               if(Collision.CheckCollistion(_loc1_,ConstructionAction.currentTarget.EquimentSenseZone,5))
               {
                  this.collisionList.Put(_loc1_.EquimentId,_loc1_);
               }
               else
               {
                  _loc1_.setDefaultState();
                  this.collisionList.Remove(_loc1_.EquimentId);
               }
            }
         }
      }
      
      private function setConstuctionCollsion() : void
      {
         var _loc2_:ConstructionSenseZone = null;
         if(this.collisionList.Length() == 0)
         {
            ConstructionAction.currentTarget.EquimentSenseZone.setDefaultState();
            return;
         }
         var _loc1_:Array = this.collisionList.Values();
         for each(_loc2_ in _loc1_)
         {
            _loc2_.setHitState();
            ConstructionAction.currentTarget.EquimentSenseZone.setHitState();
         }
      }
      
      public function Lock() : void
      {
         if(ConstructionAction.currentTarget == null)
         {
            return;
         }
         var _loc1_:MovieClip = ConstructionAction.currentTarget.getMC();
         if(Boolean(_loc1_) && Boolean(_loc1_.mc_mask))
         {
            ConstructionAction.currentTarget.getMC().mouseEnabled = false;
            ConstructionAction.currentTarget.getMC().mc_mask.mouseEnabled = false;
            ConstructionAction.currentTarget.getMC().mc_mask.mouseChildren = false;
         }
      }
      
      public function unLock() : void
      {
         if(ConstructionAction.currentTarget == null)
         {
            return;
         }
         var _loc1_:MovieClip = ConstructionAction.currentTarget.getMC();
         if(Boolean(_loc1_) && Boolean(_loc1_.mc_mask))
         {
            ConstructionAction.currentTarget.getMC().mouseEnabled = true;
            ConstructionAction.currentTarget.getMC().mc_mask.mouseEnabled = true;
            ConstructionAction.currentTarget.getMC().mc_mask.mouseChildren = true;
         }
      }
      
      private function onCreate(param1:MouseEvent) : void
      {
         var _loc2_:Equiment = null;
         if(!GameKernel.isBuildModule)
         {
            this.removeActionEvent();
            return;
         }
         if(ConstructionAction.currentTarget == null)
         {
            return;
         }
         if(!StarSurFaceDragger.getInstance().isStop())
         {
            return;
         }
         switch(ConstructionAction.currentTarget.State)
         {
            case ConstructionState.STATE_PREBUIDING:
               if(this.validateBuildAble() && Boolean(ConstructionAction.currentTarget))
               {
                  if(constructionAction.CheckConstructionProgreeIsFull())
                  {
                     ConstructionOperationWidget.currenCmd = OperationEnum.OPERATION_TYPE_UPGRADE;
                     MallBuyModulesPopup.getInstance().Init();
                     MallBuyModulesPopup.getInstance().setToolPropID(900);
                     MallBuyModulesPopup.getInstance().Show();
                     ConstructionOperationWidget.getInstance().Hide();
                     return;
                  }
                  if(!constructionAction.checkCanBuild(ConstructionAction.currentTarget.EquimentInfoData.BuildID,ConstructionAction.currentTarget.EquimentInfoData.LevelId))
                  {
                     return;
                  }
                  this._isBuildingDrag = false;
                  constructionAction.createBuildRequest(ConstructionAction.currentTarget);
                  this.removeActionEvent();
                  _loc2_ = EquimentFactory.createEquiment(ConstructionAction.currentTarget.EquimentInfoData.BuildID,ConstructionAction.currentTarget.EquimentInfoData.LevelId);
                  if(!_loc2_.IsOkay)
                  {
                     SingleLoader.GetInstance().Init(_loc2_,ConstructionAction.getInstance().RenderConstruction);
                     SingleLoader.GetInstance().Load();
                  }
                  ConstructionAnimationManager.StopConstructionDestined(_loc2_);
                  _loc2_.setEquimentSenseZone();
                  _loc2_.CloneEquimentData(ConstructionAction.currentTarget);
                  _loc2_.registerActionEvent();
                  _loc2_.setLocation(ConstructionAction.currentTarget.EquimentInfoData.PosX,ConstructionAction.currentTarget.EquimentInfoData.PosY);
                  ConstructionAction.BuildingList.push(_loc2_);
                  this._layout.addChild(_loc2_);
                  this.changeConstructionModel(false);
                  this._layout.removeChild(ConstructionAction.currentTarget);
                  ConstructionAction.currentTarget.stop();
                  ConstructionAction.currentTarget.removeMc();
                  ConstructionAction.currentTarget = null;
                  if(ConstructionOperationWidget.getInstance().Operation)
                  {
                     ConstructionOperationWidget.getInstance().Hide();
                  }
                  break;
               }
               if(GameKernel.isBuildModule)
               {
                  ConstructionAction.getInstance().clearConstructionModule();
               }
               break;
            case ConstructionState.STATE_MIRGRATE:
               if(this.validateBuildAble() && Boolean(ConstructionAction.currentTarget))
               {
                  ConstructionAction.currentTarget.State = ConstructionState.STATE_COMPLETE;
                  ConstructionAction.getInstance().moveBuildingRequest(ConstructionAction.currentTarget);
                  this._layout.addChild(ConstructionAction.currentTarget);
                  this.sortList();
                  this.removeActionEvent();
                  this._isBuildingDrag = false;
                  this.changeConstructionModel(false);
               }
         }
         if(this._sufMapContainer.hasEventListener(MouseEvent.CLICK))
         {
            GameInterActiveManager.unInstallnterActiveEvent(this._sufMapContainer,ActionEvent.ACTION_CLICK,this.onCreate);
         }
      }
      
      public function sortList() : void
      {
         var _loc1_:Array = ConstructionAction.constuctionList.Values().sortOn("zIndex",Array.NUMERIC);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            this._layout.setChildIndex(_loc1_[_loc2_],_loc2_ + 2);
            _loc2_++;
         }
      }
   }
}

