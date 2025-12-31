package logic.entry
{
   import com.star.frameworks.basic.Point3D;
   import com.star.frameworks.display.Container;
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.geom.PointKit;
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.ObjectUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.system.SecurityDomain;
   import gs.TweenLite;
   import logic.action.ConstructionAction;
   import logic.action.GalaxyMapAction;
   import logic.action.OutSideGalaxiasAction;
   import logic.action.StarSurfaceAction;
   import logic.entry.blurprint.EquimentBlueprint;
   import logic.game.CDN;
   import logic.game.GameKernel;
   import logic.game.GameSetting;
   import logic.game.GameStateManager;
   import logic.manager.FightSectionManager;
   import logic.manager.GalaxyManager;
   import logic.manager.GalaxyShipManager;
   import logic.manager.GameInterActiveManager;
   import logic.ui.ConstructionInfoManagerUI;
   import logic.ui.tip.CustomTip;
   import logic.widget.AttackRangeUtil;
   import logic.widget.ConstructionOperationWidget;
   import logic.widget.ConstructionUtil;
   import logic.widget.LoadItem;
   
   public class Equiment extends MObject
   {
      
      private var _equimentData:EquimentData;
      
      private var _equimentUpdateTime:int;
      
      private var _equimentInfluenceBase:Container;
      
      private var _influenceArr:Array;
      
      private var _zIndex:int;
      
      private var _position:Point3D;
      
      private var _bluePrint:EquimentBlueprint;
      
      private var _state:int;
      
      private var _isEffect:Boolean;
      
      private var _posXY:PointKit;
      
      private var _isShowInfluence:Boolean;
      
      private var _equimentZone:ConstructionSenseZone;
      
      private var _imageName:String;
      
      private var _starLvEntry:StarLevelEntry;
      
      private var _fortificationStar:FortificationStar;
      
      public var UrlItem:LoadItem;
      
      public var IsOkay:Boolean = false;
      
      public function Equiment(param1:EquimentBlueprint)
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:String = "BuildingBase0";
         this._bluePrint = param1;
         if(this._bluePrint)
         {
            if(ConstructionAction.ConstructionResCache.ContainsKey(this._bluePrint.BuildingID))
            {
               this.IsOkay = true;
               if(this._bluePrint.BuildingClass & 1)
               {
                  this._imageName = this._bluePrint.defendLevel.ImageName;
               }
               else
               {
                  this._imageName = this._bluePrint.equimentLevel.ImageName;
               }
               _loc2_ = this._imageName;
            }
            else if(this._bluePrint.BuildingClass & 1)
            {
               _loc2_ = "BuildingBase";
               this._imageName = this._bluePrint.defendLevel.ImageName;
            }
            else
            {
               _loc2_ = "BuildingBase0";
               _loc3_ = this._bluePrint.Center1.x;
               _loc4_ = this._bluePrint.Center1.y;
               this._imageName = this._bluePrint.equimentLevel.ImageName;
            }
            this.UrlItem = new LoadItem();
            this.UrlItem.Id = this._bluePrint.BuildingID;
            this.UrlItem.Context = new LoaderContext(false,ApplicationDomain.currentDomain,GamePlayer.getInstance().sessionKey == null ? null : SecurityDomain.currentDomain);
            this.UrlItem.Type = this._bluePrint.BuildingType;
            this.UrlItem.Image = this._imageName;
            this.UrlItem.Url = new URLRequest(CDN.CDN_PATH + CDN.res + "res/" + ConstructionUtil.GetConstructionLoadName(this._bluePrint.BuildingID,this._imageName) + GameSetting.GAME_FILE_PRIX);
            if(this._bluePrint.BuildingClass & 1)
            {
               mouseChildren = false;
            }
         }
         super(_loc2_,_loc3_,_loc4_);
         getMC().stop();
         this._isEffect = false;
         setEnable(false);
         this._state = ConstructionState.STATE_PREBUIDING;
         if(this._equimentData == null)
         {
            this._equimentData = new EquimentData();
         }
      }
      
      public function get IsEffect() : Boolean
      {
         return this._isEffect;
      }
      
      public function set IsEffect(param1:Boolean) : void
      {
         this._isEffect = param1;
      }
      
      public function get InfluenceArray() : Array
      {
         return this._influenceArr;
      }
      
      public function set InfluenceArray(param1:Array) : void
      {
         this._influenceArr = param1;
      }
      
      public function get PosXY() : PointKit
      {
         return this._posXY;
      }
      
      public function set PosXY(param1:PointKit) : void
      {
         this._posXY = param1;
      }
      
      public function get State() : int
      {
         return this._state;
      }
      
      public function set State(param1:int) : void
      {
         this._state = param1;
      }
      
      public function get EquimentInfoData() : EquimentData
      {
         return this._equimentData;
      }
      
      public function get zIndex() : int
      {
         return this._zIndex;
      }
      
      public function set zIndex(param1:int) : void
      {
         this._zIndex = param1;
      }
      
      public function get Position() : Point3D
      {
         return this._position;
      }
      
      public function get BlurPrint() : EquimentBlueprint
      {
         return this._bluePrint;
      }
      
      public function set BlurPrint(param1:EquimentBlueprint) : void
      {
         this._bluePrint = param1;
      }
      
      public function get EquimentInfluenceBase() : Container
      {
         return this._equimentInfluenceBase;
      }
      
      public function set EquimentInfluenceBase(param1:Container) : void
      {
         this._equimentInfluenceBase = param1;
      }
      
      public function get IsShowInfluence() : Boolean
      {
         return this._isShowInfluence;
      }
      
      public function set IsShowInfluence(param1:Boolean) : void
      {
         this._isShowInfluence = param1;
      }
      
      public function get EquimentSenseZone() : ConstructionSenseZone
      {
         return this._equimentZone;
      }
      
      public function set StarLvEntry(param1:StarLevelEntry) : void
      {
         this._starLvEntry = param1;
         if(this._starLvEntry)
         {
            this.UrlItem = new LoadItem();
            this.UrlItem.Id = EquimentTypeEnum.EQUIMENT_TYPE_SPACESTATION;
            this.UrlItem.Image = this._starLvEntry.imageName;
            this.UrlItem.Context = new LoaderContext(false,ApplicationDomain.currentDomain,GamePlayer.getInstance().sessionKey == null ? null : SecurityDomain.currentDomain);
            this.UrlItem.Url = new URLRequest(CDN.CDN_PATH + CDN.res + "res/" + ConstructionUtil.GetConstructionLoadName(this.UrlItem.Id,this.UrlItem.Image) + GameSetting.GAME_FILE_PRIX);
         }
      }
      
      public function set FortificationStarEntry(param1:FortificationStar) : void
      {
         this._fortificationStar = param1;
         if(this._fortificationStar && param1.BuildingName != null && param1.ImageName != null)
         {
            this.UrlItem = new LoadItem();
            this.UrlItem.Id = this._fortificationStar.BuildingID;
            this.UrlItem.Context = new LoaderContext(false,ApplicationDomain.currentDomain,GamePlayer.getInstance().sessionKey == null ? null : SecurityDomain.currentDomain);
            this.UrlItem.Image = this._fortificationStar.ImageName;
            this.UrlItem.Url = new URLRequest(CDN.CDN_PATH + CDN.res + "res/" + ConstructionUtil.GetConstructionLoadName(this.UrlItem.Id,this.UrlItem.Image) + GameSetting.GAME_FILE_PRIX);
         }
      }
      
      public function get StarLvEntry() : StarLevelEntry
      {
         return this._starLvEntry;
      }
      
      public function get FortificationStarEntry() : FortificationStar
      {
         return this._fortificationStar;
      }
      
      public function set Position(param1:Point3D) : void
      {
         this._position = param1;
         this.x = this._position.x;
         this.y = this._position.y;
         this._zIndex = this._position.y * 0.707;
      }
      
      public function setLocation(param1:int, param2:int) : void
      {
         this.Position = new Point3D(param1,param2);
         this.EquimentInfoData.PosX = param1;
         this.EquimentInfoData.PosY = param2;
      }
      
      public function CloneEquimentData(param1:Equiment) : void
      {
         this.EquimentInfoData.BuildName = param1.EquimentInfoData.BuildName;
         this.EquimentInfoData.BuildID = param1.EquimentInfoData.BuildID;
         this.EquimentInfoData.GalaxyId = param1.EquimentInfoData.GalaxyId;
         this.EquimentInfoData.LevelId = param1.EquimentInfoData.LevelId;
         this.EquimentInfoData.needTime = param1.EquimentInfoData.needTime;
         this.EquimentInfoData.PosX = param1.EquimentInfoData.PosX;
         this.EquimentInfoData.PosY = param1.EquimentInfoData.PosY;
         this.PosXY = param1.PosXY;
      }
      
      public function registerActionEvent() : void
      {
         if(getMC() == null)
         {
            return;
         }
         GameInterActiveManager.InstallInterActiveEvent(getMC().mc_mask,ActionEvent.ACTION_CLICK,this.onPopToolBar);
         if(this.BlurPrint != null)
         {
            if(!(this.BlurPrint.BuildingClass & 1))
            {
               GameInterActiveManager.InstallInterActiveEvent(getMC().mc_mask,ActionEvent.ACTION_MOUSE_OVER,this.onOverHandler);
               GameInterActiveManager.InstallInterActiveEvent(getMC().mc_mask,ActionEvent.ACTION_MOUSE_OUT,this.onOutHandler);
            }
         }
      }
      
      public function unRegisterActionEvent() : void
      {
         if(getMC() == null)
         {
            return;
         }
         GameInterActiveManager.unInstallnterActiveEvent(getMC().mc_mask,ActionEvent.ACTION_CLICK,this.onPopToolBar);
         if(this.BlurPrint != null)
         {
            if(!(this.BlurPrint.BuildingClass & 1))
            {
               GameInterActiveManager.unInstallnterActiveEvent(getMC().mc_mask,ActionEvent.ACTION_MOUSE_OVER,this.onOverHandler);
               GameInterActiveManager.unInstallnterActiveEvent(getMC().mc_mask,ActionEvent.ACTION_MOUSE_OUT,this.onOutHandler);
            }
         }
      }
      
      private function onOverHandler(param1:MouseEvent) : void
      {
         this.setConstructionModule();
         var _loc2_:Point = getMC().localToGlobal(new Point());
         CustomTip.GetInstance().ShowTip(StringManager.getInstance().getMessageString("BuildingText21") + (this.EquimentInfoData.LevelId + 1) + " " + this.EquimentInfoData.BuildName,_loc2_);
      }
      
      private function onOutHandler(param1:MouseEvent) : void
      {
         this.setConstructionModule(false);
         CustomTip.GetInstance().Hide();
      }
      
      public function onPopToolBar(param1:MouseEvent) : void
      {
         var _loc2_:Point = null;
         if(GalaxyShipManager.instance.getShipByPos(this.EquimentInfoData.PosX,this.EquimentInfoData.PosY))
         {
            return;
         }
         ConstructionInfoManagerUI.getInstance().Hide();
         ConstructionAction.currentTarget = this;
         ConstructionAction.preConstructionPosX = this.EquimentInfoData.PosX;
         ConstructionAction.preConstructionPosY = this.EquimentInfoData.PosY;
         if(GameKernel.currentGameStage == GameStageEnum.GAME_STAGE_OUTSIDE)
         {
            this.HideEquimentInfluence();
            if(this.EquimentInfoData.BuildID != EquimentTypeEnum.EQUIMENT_TYPE_SPACESTATION)
            {
               this.showEquimentInfluence(this.EquimentInfoData.PosX,this.EquimentInfoData.PosY);
            }
            if(Boolean(GalaxyMapAction.instance.curStar) && GalaxyMapAction.instance.curStar.Type == GalaxyType.GT_3)
            {
               _loc2_ = localToGlobal(new Point());
               if(this.EquimentInfoData.ConsortiaLeader)
               {
                  ConstructionOperationWidget.getInstance().Assemble(8);
               }
               else
               {
                  ConstructionOperationWidget.getInstance().Assemble(9);
               }
               ConstructionOperationWidget.getInstance().setLocation(_loc2_.x + (getMC().width >> 1) + 50,_loc2_.y);
               return;
            }
            if(!GalaxyManager.instance.isMineHome())
            {
               return;
            }
         }
         else if(GameKernel.currentGameStage == GameStageEnum.GAME_STAGE_STARSURFACE)
         {
            if(this.EquimentInfoData.BuildID == EquimentTypeEnum.EQUIMENT_TYPE_RESSTORECENTER)
            {
               if(GameStateManager.playerPlace == GamePlaceType.PLACE_HOME)
               {
                  ConstructionAction.getInstance().sendStorageResource();
               }
            }
            if(param1.target is MovieClip && !StarSurfaceAction.getInstance().BuildingModel)
            {
               ConstructionAction.getInstance().removeOtherSenseZone(this);
               this.setConstructionModule();
            }
         }
         if(GameKernel.currentGameStage == GameStageEnum.GAME_STAGE_STARSURFACE)
         {
            StarSurfaceAction.getInstance().removeActionEvent();
         }
         if(GameStateManager.playerPlace == GamePlaceType.PLACE_HOME)
         {
            this.showConstructionToolBarInfo();
         }
      }
      
      public function setConstructionModule(param1:Boolean = true) : void
      {
         if(param1)
         {
            if(this.State == ConstructionState.STATE_COMPLETE)
            {
               getMC().filters = [new GlowFilter(16774661)];
               getMC().alpha = 0.7;
            }
         }
         else if(this.State == ConstructionState.STATE_COMPLETE)
         {
            getMC().filters = null;
            getMC().alpha = 1;
         }
      }
      
      public function showConstructionToolBarInfo() : void
      {
         var _loc1_:Point = null;
         if(FightSectionManager.fightingFlag)
         {
            return;
         }
         ConstructionAction.currentTarget = this;
         if(GalaxyManager.instance.enterStar.Type == GalaxyType.GT_3)
         {
            _loc1_ = localToGlobal(new Point());
         }
         else
         {
            _loc1_ = this.BlurPrint.BuildingClass & 1 == 1 ? getMC().localToGlobal(new Point()) : localToGlobal(new Point(this.EquimentSenseZone.x,this.EquimentSenseZone.y));
         }
         if(this.State == ConstructionState.STATE_BUILING)
         {
            ConstructionOperationWidget.getInstance().Assemble(4);
         }
         else if(this.State == ConstructionState.STATE_UPDATE)
         {
            if(this.EquimentInfoData.BuildID == EquimentTypeEnum.EQUIMENT_TYPE_SHIPBUILDING || this.EquimentInfoData.BuildID == EquimentTypeEnum.EQUIMENT_TYPE_WEAPONRESEARCHCENTER || this.EquimentInfoData.BuildID == EquimentTypeEnum.EQUIMENT_TYPE_TECHRESEARCHCENTER || this.EquimentInfoData.BuildID == EquimentTypeEnum.EQUIMENT_TYPE_COMMANDERCENTER || this.EquimentInfoData.BuildID == EquimentTypeEnum.EQUIMENT_TYPE_UNION || this.EquimentInfoData.BuildID == EquimentTypeEnum.EQUIMENT_TYPE_SHIPRECAIM || this.EquimentInfoData.BuildID == EquimentTypeEnum.EQUIMENT_TYPE_SHIPREPAIR)
            {
               ConstructionOperationWidget.getInstance().Assemble(11);
            }
            else if(this.EquimentInfoData.BuildID == EquimentTypeEnum.EQUIMENT_TYPE_RESSTORECENTER)
            {
               ConstructionOperationWidget.getInstance().Assemble(10);
            }
            else if(this.EquimentInfoData.BuildID == EquimentTypeEnum.EQUIMENT_TYPE_SPACESTATION)
            {
               ConstructionOperationWidget.getInstance().Assemble(12);
            }
            else if(this.EquimentInfoData.BuildID == EquimentTypeEnum.EQUIMENT_TYPE_TRADEPORT)
            {
               ConstructionOperationWidget.getInstance().Assemble(14);
            }
            else
            {
               ConstructionOperationWidget.getInstance().Assemble(4);
            }
         }
         else if(this.State == ConstructionState.STATE_COMPLETE)
         {
            ConstructionOperationWidget.getInstance().Assemble(this.BlurPrint.InteractiveBoxType);
         }
         else if(this.State == ConstructionState.STATE_REPAIR)
         {
            ConstructionOperationWidget.getInstance().Assemble(9);
         }
         if(this.BlurPrint.BuildingClass & 1)
         {
            ConstructionOperationWidget.getInstance().setLocation(_loc1_.x,_loc1_.y - 30);
         }
         else
         {
            ConstructionOperationWidget.getInstance().setLocation(_loc1_.x + (getMC().width >> 1) + 50,_loc1_.y);
         }
      }
      
      public function addEquimentSenseZone() : void
      {
         if(Boolean(this._equimentZone) && !contains(this._equimentZone))
         {
            this._equimentZone.Draw();
            addChildAt(this._equimentZone,0);
         }
      }
      
      public function removeEquimentSenseZone() : void
      {
         if(Boolean(this._equimentZone) && contains(this._equimentZone))
         {
            this._equimentZone.removeZoneListeners();
            removeChild(this._equimentZone);
         }
      }
      
      public function addEquimentInfluenceBase() : void
      {
         if(!this.EquimentInfluenceBase)
         {
            this.showEquimentInfluence(this.EquimentInfoData.PosX,this.EquimentInfoData.PosY);
         }
         this.addChildAt(this.EquimentInfluenceBase,0);
      }
      
      public function removeEquimentInfluenceBase() : void
      {
         if(this.EquimentInfluenceBase.parent)
         {
            this.EquimentInfluenceBase.parent.removeChild(this.EquimentInfluenceBase);
         }
      }
      
      public function setEquimentSenseZone() : void
      {
         this._equimentZone = new ConstructionSenseZone(this);
      }
      
      public function showEquimentInfluence(param1:int, param2:int) : void
      {
         var _loc3_:Object = null;
         OutSideGalaxiasAction.getInstance().rePaintRegion();
         if(Boolean(GalaxyManager.instance.enterStar) && GalaxyManager.instance.enterStar.Type == GalaxyType.GT_3)
         {
            AttackRangeUtil.getInstance().Find(new PointKit(param1,param2),this.FortificationStarEntry.Range);
         }
         else
         {
            AttackRangeUtil.getInstance().Find(new PointKit(param1,param2),ConstructionUtil.getAttackRangle(this._equimentData.BuildID,this.BlurPrint.defendLevel.AttackRange));
         }
         this.InfluenceArray = AttackRangeUtil.getInstance().cloneResult();
         for each(_loc3_ in this.InfluenceArray)
         {
            OutSideGalaxiasAction.getInstance().FillGraphics(_loc3_.px,_loc3_.py);
         }
         ObjectUtil.ClearArray(this.InfluenceArray);
         this._isShowInfluence = true;
      }
      
      public function reLoadMc(param1:String, param2:int = 0, param3:int = 0, param4:Boolean = false) : void
      {
         var _loc5_:MovieClip = null;
         var _loc6_:MovieClip = null;
         if(this.IsOkay && this._imageName == param1)
         {
            return;
         }
         this.IsOkay = true;
         removeMc();
         this._imageName = param1;
         _Mc = GameKernel.getMovieClipInstance(this._imageName,param2,param3,param4);
         setEnable(false);
         if(Boolean(this._bluePrint) && Boolean(this._bluePrint.BuildingClass & 1))
         {
            getMC().mouseChildren = false;
            mouseChildren = false;
            getMC().stop();
            if(_Mc.mc_anim)
            {
               MovieClip(getMC().mc_anim).stop();
            }
         }
         else if(this.FortificationStarEntry != null && this.FortificationStarEntry.LevelID != -1)
         {
            if(getMC() == null)
            {
               return;
            }
            getMC().mouseChildren = false;
            mouseChildren = false;
            getMC().stop();
            if(getMC().mc_anim)
            {
               MovieClip(getMC().mc_anim).stop();
            }
         }
         this.registerActionEvent();
         if(this._bluePrint != null && this._bluePrint.BuildingClass == 0)
         {
            if(this._bluePrint.BuildingID == EquimentTypeEnum.EQUIMENT_TYPE_RESSTORECENTER)
            {
               if(getMC())
               {
                  _loc5_ = getMC().mc_anim as MovieClip;
                  _loc6_ = getMC().fetctMc as MovieClip;
                  if(_loc5_)
                  {
                     _loc5_.gotoAndStop(1);
                  }
                  if(_loc6_)
                  {
                     _loc6_.gotoAndStop(1);
                  }
               }
            }
            else
            {
               this.PlayAnimation();
            }
         }
         _Mc.alpha = 0.1;
         addChild(_Mc);
         TweenLite.to(_Mc,2,{"alpha":1});
      }
      
      public function HideEquimentInfluence() : void
      {
         OutSideGalaxiasAction.getInstance().rePaintRegion();
         this._isShowInfluence = false;
      }
      
      public function Release() : void
      {
         stop();
         if(GameKernel.currentGameStage == GameStageEnum.GAME_STAGE_STARSURFACE)
         {
            this.removeEquimentSenseZone();
         }
         this.unRegisterActionEvent();
         setEnable(false);
      }
      
      public function PlayAnimation(param1:Boolean = false) : void
      {
         if(getMC() == null)
         {
            return;
         }
         var _loc2_:MovieClip = getMC().mc_anim as MovieClip;
         if(_loc2_ == null)
         {
            return;
         }
         if(param1)
         {
            _loc2_.gotoAndPlay(2);
         }
         else
         {
            _loc2_.gotoAndStop(1);
            _loc2_.stop();
         }
      }
   }
}

