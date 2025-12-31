package logic.action
{
   import com.star.frameworks.basic.Point3D;
   import com.star.frameworks.display.Container;
   import com.star.frameworks.geom.CFilter;
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.CEffectText;
   import com.star.frameworks.utils.HashSet;
   import com.star.frameworks.utils.ObjectUtil;
   import flash.display.MovieClip;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import logic.entry.AbstraceAction;
   import logic.entry.ConstructionSenseZone;
   import logic.entry.ConstructionState;
   import logic.entry.Equiment;
   import logic.entry.EquimentFactory;
   import logic.entry.EquimentTypeEnum;
   import logic.entry.GStar;
   import logic.entry.GalaxyType;
   import logic.entry.GamePlaceType;
   import logic.entry.GamePlayer;
   import logic.entry.GameStageEnum;
   import logic.entry.StarSufaceMarkZone;
   import logic.entry.blurprint.DefendBuildLevel;
   import logic.entry.blurprint.EquimentBlueprint;
   import logic.entry.blurprint.EquimentLevel;
   import logic.entry.blurprint.Level;
   import logic.game.ConstructionAnimationManager;
   import logic.game.GameKernel;
   import logic.game.GameSetting;
   import logic.game.GameStateManager;
   import logic.game.GameStatisticsManager;
   import logic.manager.ConstructionBloodPlaneManager;
   import logic.manager.ConstructionRepairManager;
   import logic.manager.GalaxyManager;
   import logic.manager.GalaxyShipManager;
   import logic.manager.GamePopUpDisplayManager;
   import logic.manager.ProgressToolBarManager;
   import logic.manager.RepairProgressToolBarManager;
   import logic.reader.CConstructionReader;
   import logic.reader.ConstructionSpeedReader;
   import logic.reader.StarLevelReader;
   import logic.ui.ConstructionInfoManagerUI;
   import logic.ui.ConstructionSpeedPopUp;
   import logic.ui.PlayerInfoUI;
   import logic.ui.ResPlaneUI;
   import logic.ui.tip.CustomTip;
   import logic.widget.BufferQueueManager;
   import logic.widget.ConstructionLoadQueue;
   import logic.widget.ConstructionMeomery;
   import logic.widget.ConstructionOperationWidget;
   import logic.widget.ConstructionUtil;
   import logic.widget.LoadItem;
   import logic.widget.ProgressEntryIso;
   import logic.widget.ProgressInFriendToolBarWidget;
   import logic.widget.ProgressIsoInFriend;
   import logic.widget.ProgressListToolBarWidget;
   import logic.widget.SingleLoader;
   import net.base.NetManager;
   import net.msg.MSG_REQUEST_PLAYERRESOURCE;
   import net.msg.MSG_REQUEST_STORAGERESOURCE;
   import net.msg.MSG_RESP_GETSTORAGERESOURCE;
   import net.msg.constructionMsg.MSG_REQUEST_CANCELBUILD;
   import net.msg.constructionMsg.MSG_REQUEST_CONSORTIABUILDING;
   import net.msg.constructionMsg.MSG_REQUEST_CREATEBUILD;
   import net.msg.constructionMsg.MSG_REQUEST_DELETEBUILD;
   import net.msg.constructionMsg.MSG_REQUEST_GETSTORAGERESOURCE;
   import net.msg.constructionMsg.MSG_REQUEST_MOVEBUILD;
   import net.msg.constructionMsg.MSG_REQUEST_SPEEDBUILDING;
   import net.msg.constructionMsg.MSG_REQUEST_SPEEDFRIENDBUILDING;
   import net.msg.constructionMsg.MSG_REQUEST_TIMEQUEUE;
   import net.msg.constructionMsg.MSG_RESP_BUILDCOMPLETE;
   import net.msg.constructionMsg.MSG_RESP_BUILDINFO;
   import net.msg.constructionMsg.MSG_RESP_BUILDINFOFRIEND;
   import net.msg.constructionMsg.MSG_RESP_BUILDINFO_TEMP;
   import net.msg.constructionMsg.MSG_RESP_BUILDINGDEATHCOMPLETE;
   import net.msg.constructionMsg.MSG_RESP_CANCELBUILD;
   import net.msg.constructionMsg.MSG_RESP_CONSORTIABUILDING;
   import net.msg.constructionMsg.MSG_RESP_CONSORTIAWEALTH;
   import net.msg.constructionMsg.MSG_RESP_CREATEBUILD;
   import net.msg.constructionMsg.MSG_RESP_CREATEBUILDINFO;
   import net.msg.constructionMsg.MSG_RESP_CREATEBUILDINFO_TEMP;
   import net.msg.constructionMsg.MSG_RESP_DELETEBUILD;
   import net.msg.constructionMsg.MSG_RESP_MOVEBUILD;
   import net.msg.constructionMsg.MSG_RESP_SPEEDBUILDING;
   import net.msg.constructionMsg.MSG_RESP_SPEEDFRIENDBUILDING;
   import net.msg.constructionMsg.MSG_RESP_STORAGERESOURCE;
   import net.msg.constructionMsg.MSG_RESP_TIMEQUEUE;
   import net.msg.facebook.MSG_RESP_FRIENDINFO;
   
   public class ConstructionAction extends AbstraceAction
   {
      
      public static var BuildingList:Array;
      
      public static var otherGalaxyConstuctionList:HashSet;
      
      public static var otherGalaxyoutSideContuctionList:HashSet;
      
      public static var senseZoneList:Array;
      
      public static var constuctionList:HashSet;
      
      public static var outSideContuctionList:HashSet;
      
      public static var currentTarget:Equiment;
      
      public static var repairBuildingList:Array;
      
      public static var isView:int;
      
      public static var isConsortiaLeader:int;
      
      public static var preConstructionPosX:int;
      
      public static var preConstructionPosY:int;
      
      public static var bulidTechObj:Object;
      
      public static var defendTechObj:Object;
      
      public static var currentProgressIso:ProgressIsoInFriend;
      
      public static var curProgressIso:ProgressEntryIso;
      
      private static var instance:ConstructionAction;
      
      public static var ownConstructionCopyList:HashSet = new HashSet();
      
      public static var ConstructionResCache:HashSet = new HashSet();
      
      private var activeTime:Timer;
      
      private var surFaceUI:Container;
      
      public function ConstructionAction()
      {
         super();
         if(instance != null)
         {
            throw new Error("SingleTon");
         }
         super.ActionName = "ConstructionAction";
         BuildingList = new Array();
         repairBuildingList = new Array();
         constuctionList = new HashSet();
         outSideContuctionList = new HashSet();
         senseZoneList = new Array();
         this.activeTime = new Timer(120000);
         this.activeTime.addEventListener(TimerEvent.TIMER,this.onTick);
      }
      
      public static function getInstance() : ConstructionAction
      {
         if(instance == null)
         {
            instance = new ConstructionAction();
         }
         return instance;
      }
      
      public static function MoveHome(param1:int, param2:int) : void
      {
         var _loc3_:Equiment = null;
         var _loc4_:Equiment = null;
         for each(_loc3_ in constuctionList.Values())
         {
            _loc3_.EquimentInfoData.GalaxyMapId = param1;
            _loc3_.EquimentInfoData.GalaxyId = param2;
         }
         for each(_loc4_ in outSideContuctionList.Values())
         {
            _loc4_.EquimentInfoData.GalaxyMapId = param1;
            _loc4_.EquimentInfoData.GalaxyId = param2;
         }
      }
      
      public function set SufFaceUI(param1:Container) : void
      {
         this.surFaceUI = param1;
      }
      
      public function get SufFaceUI() : Container
      {
         return this.surFaceUI;
      }
      
      public function getCivisimCenter() : Equiment
      {
         var _loc2_:Equiment = null;
         if(constuctionList == null || constuctionList.Length() == 0)
         {
            return null;
         }
         var _loc1_:Array = constuctionList.Values();
         for each(_loc2_ in _loc1_)
         {
            if(_loc2_.EquimentInfoData.BuildID == EquimentTypeEnum.EQUIMENT_TYPE_CIVICISM)
            {
               return constuctionList.Get(_loc2_.EquimentInfoData.IndexId);
            }
         }
         return null;
      }
      
      public function getSpaceStation() : Equiment
      {
         var _loc2_:Equiment = null;
         if(outSideContuctionList == null || outSideContuctionList.Length() == 0)
         {
            return null;
         }
         var _loc1_:Array = outSideContuctionList.Values();
         for each(_loc2_ in _loc1_)
         {
            if(_loc2_.EquimentInfoData.BuildID == EquimentTypeEnum.EQUIMENT_TYPE_SPACESTATION)
            {
               return outSideContuctionList.Get(_loc2_.EquimentInfoData.IndexId);
            }
         }
         return null;
      }
      
      public function removeConstruction(param1:Equiment) : void
      {
         if(Boolean(param1) && Boolean(param1.parent))
         {
            param1.parent.removeChild(param1);
         }
      }
      
      public function addConstruction(param1:Equiment) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.parent != null && param1.parent.contains(param1))
         {
            return;
         }
         OutSideGalaxiasAction.getInstance().OutSideDefendContainer.addChild(param1);
      }
      
      public function isOnSpace(param1:int, param2:int) : Boolean
      {
         var _loc3_:Equiment = this.getSpaceStation();
         if(_loc3_ == null)
         {
            return false;
         }
         return param1 == _loc3_.EquimentInfoData.PosX && param2 == _loc3_.EquimentInfoData.PosY || param1 == _loc3_.EquimentInfoData.PosX - 1 && param2 == _loc3_.EquimentInfoData.PosY || param1 == _loc3_.EquimentInfoData.PosX - 1 && param2 == _loc3_.EquimentInfoData.PosY - 1 || param1 == _loc3_.EquimentInfoData.PosX && param2 == _loc3_.EquimentInfoData.PosY - 1;
      }
      
      public function getShipBuildingProductNumber() : int
      {
         var _loc1_:Object = null;
         var _loc2_:EquimentBlueprint = null;
         if(ConstructionAction.ownConstructionCopyList.ContainsKey(EquimentTypeEnum.EQUIMENT_TYPE_SHIPBUILDING))
         {
            _loc1_ = ConstructionAction.ownConstructionCopyList.Get(EquimentTypeEnum.EQUIMENT_TYPE_SHIPBUILDING);
            _loc2_ = CConstructionReader.getInstance().Read(_loc1_.BuildID,_loc1_.LevelID);
            return _loc2_.equimentLevel.shipBuild.ShipProductionQueue;
         }
         return -1;
      }
      
      public function getCommanderCenterTime() : String
      {
         var _loc1_:Equiment = this.getConstructionInstance(EquimentTypeEnum.EQUIMENT_TYPE_COMMANDERCENTER);
         if(_loc1_)
         {
            return _loc1_.BlurPrint.equimentLevel.LevelComment;
         }
         return "";
      }
      
      public function getResourceRecyclNum() : int
      {
         var _loc1_:Equiment = this.getConstructionInstance(EquimentTypeEnum.EQUIMENT_TYPE_SHIPRECAIM);
         if(_loc1_)
         {
            return _loc1_.BlurPrint.equimentLevel.ResourceRecycle;
         }
         return 0;
      }
      
      public function getTechSearchNumber() : int
      {
         return this.validateConstruction(EquimentTypeEnum.EQUIMENT_TYPE_TECHRESEARCHCENTER);
      }
      
      public function getOwnConstructionByBuilidID(param1:int) : EquimentBlueprint
      {
         var _loc2_:int = 0;
         if(ConstructionAction.ownConstructionCopyList.Get(param1))
         {
            _loc2_ = int(ConstructionAction.ownConstructionCopyList.Get(param1).LevelID);
            return CConstructionReader.getInstance().Read(param1,_loc2_);
         }
         return null;
      }
      
      public function removeOwnConstructionByBuildID(param1:int) : void
      {
         if(ConstructionAction.ownConstructionCopyList.Get(param1))
         {
            ConstructionAction.ownConstructionCopyList.Remove(param1);
         }
      }
      
      private function validateConstruction(param1:int) : int
      {
         if(ConstructionAction.ownConstructionCopyList.ContainsKey(param1))
         {
            return ConstructionAction.ownConstructionCopyList.Get(param1).LevelID;
         }
         return -1;
      }
      
      public function getWeaponResearchNumber() : int
      {
         return this.validateConstruction(EquimentTypeEnum.EQUIMENT_TYPE_WEAPONRESEARCHCENTER);
      }
      
      public function getCommanderCenterNumber() : int
      {
         return this.validateConstruction(EquimentTypeEnum.EQUIMENT_TYPE_COMMANDERCENTER);
      }
      
      public function getCompositionCenter() : int
      {
         return this.validateConstruction(EquimentTypeEnum.EQUIMENT_TYPE_COMPOSITIONCENTER);
      }
      
      public function getTechResearchCenterNumber() : int
      {
         return this.validateConstruction(EquimentTypeEnum.EQUIMENT_TYPE_TECHRESEARCHCENTER);
      }
      
      public function getUnionCenterNumber() : int
      {
         return this.validateConstruction(EquimentTypeEnum.EQUIMENT_TYPE_UNION);
      }
      
      public function getTradePortNumber() : int
      {
         return this.validateConstruction(EquimentTypeEnum.EQUIMENT_TYPE_TRADEPORT);
      }
      
      public function getShipReclaimNumber() : int
      {
         return this.validateConstruction(EquimentTypeEnum.EQUIMENT_TYPE_SHIPRECAIM);
      }
      
      public function getComposeCenterNumber() : int
      {
         return this.validateConstruction(EquimentTypeEnum.EQUIMENT_TYPE_COMPOSITIONCENTER);
      }
      
      public function getRadarLevel() : int
      {
         return this.validateConstruction(EquimentTypeEnum.EQUIMENT_TYPE_RADAR);
      }
      
      public function RenderConstruction(param1:Equiment) : void
      {
         var _loc2_:LoadItem = null;
         if(Boolean(param1) && Boolean(param1.UrlItem))
         {
            _loc2_ = param1.UrlItem;
            ConstructionAction.ConstructionResCache.Put(_loc2_.Id,_loc2_.Content);
            param1.reLoadMc(_loc2_.Image);
         }
      }
      
      public function getConstructionInstance(param1:int) : Equiment
      {
         var _loc2_:Array = null;
         var _loc3_:Equiment = null;
         _loc2_ = constuctionList.Values();
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_.EquimentInfoData.BuildID == param1)
            {
               return _loc3_;
            }
         }
         _loc2_ = outSideContuctionList.Values();
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_.EquimentInfoData.BuildID == param1)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function Msg_Resp_BuildingInfo(param1:MSG_RESP_BUILDINFO) : void
      {
         var _loc4_:Equiment = null;
         var _loc5_:Equiment = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc11_:MSG_RESP_BUILDINFO_TEMP = null;
         var _loc12_:Equiment = null;
         ConstructionAction.isView = param1.ViewFlag;
         ConstructionAction.isConsortiaLeader = param1.ConsortiaLeader;
         StarSurfaceAction.getInstance().mapType = param1.StarType;
         StarSurfaceAction.getInstance().paintSurFaceFloorLayOut();
         var _loc2_:int = param1.GalaxyMapId;
         var _loc3_:int = param1.GalaxyId;
         var _loc6_:ConstructionLoadQueue = ConstructionLoadQueue.GetInstance();
         _loc6_.Init(4);
         var _loc9_:Boolean = false;
         if(GamePlayer.getInstance().galaxyID == _loc3_)
         {
            GameStateManager.playerPlace = GamePlaceType.PLACE_HOME;
         }
         var _loc10_:int = 0;
         while(_loc10_ < param1.DataLen)
         {
            _loc11_ = param1.Data[_loc10_] as MSG_RESP_BUILDINFO_TEMP;
            _loc12_ = EquimentFactory.createEquiment(_loc11_.BuildingId,_loc11_.LevelId);
            if(_loc12_ != null)
            {
               if(ConstructionAction.ConstructionResCache.ContainsKey(_loc11_.BuildingId))
               {
                  _loc12_.reLoadMc(_loc12_.UrlItem.Image);
               }
               else if(!_loc6_.IsExists(_loc11_.BuildingId))
               {
                  _loc9_ = true;
                  _loc6_.AddFile(_loc12_.UrlItem);
               }
               if(GalaxyMapAction.instance.curStar.Type == GalaxyType.GT_3)
               {
                  if(_loc11_.BuildingId == EquimentTypeEnum.EQUIMENT_TYPE_SPACESTATION)
                  {
                     _loc12_.EquimentInfoData.BuildName = _loc12_.StarLvEntry.buildName;
                  }
                  else
                  {
                     _loc12_.EquimentInfoData.BuildName = _loc12_.FortificationStarEntry.BuildingName;
                  }
               }
               else
               {
                  _loc12_.EquimentInfoData.BuildName = _loc12_.BlurPrint.BuildingName;
               }
               _loc12_.EquimentInfoData.BuildID = _loc11_.BuildingId;
               _loc12_.EquimentInfoData.LevelId = _loc11_.LevelId;
               _loc12_.EquimentInfoData.GalaxyId = param1.GalaxyId;
               _loc12_.EquimentInfoData.GalaxyMapId = param1.GalaxyMapId;
               _loc8_ = Math.max(_loc8_,_loc11_.PosY);
               if(0 == this.getConstructionClass(_loc11_.BuildingId))
               {
                  if(_loc11_.PosX < 300 && _loc11_.PosY < 300 || (_loc11_.PosX > 2000 || _loc11_.PosY > 1450))
                  {
                     if(_loc4_ == null)
                     {
                        _loc4_ = this.getCivisimCenter();
                     }
                     if(_loc4_ != null)
                     {
                        _loc12_.EquimentInfoData.PosX = _loc4_.EquimentInfoData.PosX;
                        _loc12_.EquimentInfoData.PosY = _loc4_.EquimentInfoData.PosY;
                     }
                     else
                     {
                        _loc12_.EquimentInfoData.PosX = 1082;
                        _loc12_.EquimentInfoData.PosY = 802;
                        this.Adjust();
                     }
                  }
                  else
                  {
                     _loc12_.EquimentInfoData.PosX = _loc11_.PosX;
                     _loc12_.EquimentInfoData.PosY = _loc11_.PosY;
                  }
               }
               else if(_loc11_.PosX > GameSetting.MAP_OUTSIDE_GRID_NUMBER - 1 || _loc11_.PosY > GameSetting.MAP_OUTSIDE_GRID_NUMBER - 1)
               {
                  if(_loc5_ == null)
                  {
                     _loc5_ = this.getSpaceStation();
                  }
                  if(_loc5_)
                  {
                     _loc12_.EquimentInfoData.PosX = _loc5_.EquimentInfoData.PosX;
                     _loc12_.EquimentInfoData.PosY = _loc5_.EquimentInfoData.PosY;
                  }
               }
               else
               {
                  _loc12_.EquimentInfoData.PosX = _loc11_.PosX;
                  _loc12_.EquimentInfoData.PosY = _loc11_.PosY;
               }
               _loc12_.EquimentInfoData.IndexId = _loc11_.IndexId;
               _loc12_.EquimentInfoData.needTime = _loc11_.SpareTime;
               _loc12_.State = ConstructionState.STATE_COMPLETE;
               if(_loc11_.SpareTime > 0)
               {
                  if(_loc12_.EquimentInfoData.LevelId != -1)
                  {
                     _loc12_.State = ConstructionState.STATE_UPDATE;
                  }
                  else
                  {
                     _loc12_.State = ConstructionState.STATE_BUILING;
                  }
                  --_loc12_.EquimentInfoData.needTime;
                  BuildingList.push(_loc12_);
                  if(_loc12_.BlurPrint.BuildingClass & 1)
                  {
                     outSideContuctionList.Put(_loc11_.IndexId,_loc12_);
                  }
                  else
                  {
                     constuctionList.Put(_loc11_.IndexId,_loc12_);
                     this.PushMemoryConstruction(_loc12_);
                  }
                  ProgressToolBarManager.getInstance().pushUpgrate(_loc12_);
                  if(GameStateManager.playerPlace == GamePlaceType.PLACE_HOME)
                  {
                     ProgressListToolBarWidget.getInstance().PushProgress(_loc12_);
                  }
                  else if(GameStateManager.playerPlace == GamePlaceType.PLACE_FRIENDHOME)
                  {
                     ProgressInFriendToolBarWidget.getInstance().PushProgress(_loc12_);
                  }
               }
               else if(_loc11_.SpareTime < 0)
               {
                  ++_loc12_.EquimentInfoData.needTime;
                  _loc12_.State = ConstructionState.STATE_REPAIR;
                  if(GalaxyMapAction.instance.curStar.Type == GalaxyType.GT_3)
                  {
                     outSideContuctionList.Put(_loc11_.IndexId,_loc12_);
                  }
                  else if(_loc12_.BlurPrint.BuildingClass & 1)
                  {
                     if(0 == GalaxyMapAction.instance.curStar.FightFlag)
                     {
                        repairBuildingList.push(_loc12_);
                        RepairProgressToolBarManager.getInstance().pushUpgrate(_loc12_);
                     }
                     outSideContuctionList.Put(_loc11_.IndexId,_loc12_);
                  }
                  else
                  {
                     repairBuildingList.push(_loc12_);
                     RepairProgressToolBarManager.getInstance().pushUpgrate(_loc12_);
                     constuctionList.Put(_loc11_.IndexId,_loc12_);
                  }
               }
               else if(GalaxyMapAction.instance.curStar.Type != GalaxyType.GT_3)
               {
                  if(_loc12_.BlurPrint.BuildingClass & 1)
                  {
                     outSideContuctionList.Put(_loc11_.IndexId,_loc12_);
                  }
                  else
                  {
                     constuctionList.Put(_loc11_.IndexId,_loc12_);
                     this.PushMemoryConstruction(_loc12_);
                  }
               }
               else
               {
                  outSideContuctionList.Put(_loc11_.IndexId,_loc12_);
               }
               if(GameStateManager.playerPlace == GamePlaceType.PLACE_HOME)
               {
                  this.cacheOwnSpecialConstruction(_loc12_);
               }
            }
            _loc10_++;
         }
         if(GameStateManager.playerPlace == GamePlaceType.PLACE_HOME)
         {
            PlayerInfoUI.getInstance().addSpEvent();
            ConstructionAction.getInstance().sendPlayerResource();
            ProgressListToolBarWidget.getInstance().showProgressList();
         }
         else
         {
            PlayerInfoUI.getInstance().removeSpEvent();
         }
         this.setConstructionProgressState();
         StarSurfaceAction.getInstance().loadConstuctionList();
         OutSideGalaxiasAction.getInstance().loadOutSideContructionList();
         ProgressToolBarManager.getInstance().SyncTime();
         StarLevelReader.getInstance().Read();
         if(GameStateManager.playerPlace == GamePlaceType.PLACE_FRIENDHOME)
         {
            if(GalaxyManager.instance.enterStar.FightFlag == 1)
            {
               ProgressInFriendToolBarWidget.getInstance().setInFriendProgressListVisible(false);
            }
            else if(GameKernel.currentGameStage == GameStageEnum.GAME_STAGE_GALAXY)
            {
               ProgressInFriendToolBarWidget.getInstance().setInFriendProgressListVisible(false);
            }
         }
         if(_loc9_)
         {
            _loc6_.Load();
         }
      }
      
      private function Adjust() : void
      {
         var _loc3_:Equiment = null;
         var _loc1_:Array = constuctionList.Values();
         var _loc2_:Equiment = this.getSpaceStation();
         for each(_loc3_ in _loc1_)
         {
            if(_loc3_.EquimentInfoData.PosX < 300 && _loc3_.EquimentInfoData.PosY < 300 || (_loc3_.EquimentInfoData.PosX > 1800 || _loc3_.EquimentInfoData.PosY > 1400))
            {
               if(_loc2_)
               {
                  _loc3_.EquimentInfoData.PosX = _loc2_.EquimentInfoData.PosX;
                  _loc3_.EquimentInfoData.PosY = _loc2_.EquimentInfoData.PosY;
               }
               else
               {
                  _loc3_.EquimentInfoData.PosX = 1082;
                  _loc3_.EquimentInfoData.PosY = 802;
               }
            }
         }
      }
      
      public function PushMemoryConstruction(param1:Equiment) : void
      {
         switch(param1.EquimentInfoData.BuildID)
         {
            case EquimentTypeEnum.EQUIMENT_TYPE_HELIUM_3:
               ConstructionMeomery.he3List.push(param1);
               break;
            case EquimentTypeEnum.EQUIMENT_TYPE_METAL:
               ConstructionMeomery.metalList.push(param1);
               break;
            case EquimentTypeEnum.EQUIMENT_TYPE_HOMEREGION:
               ConstructionMeomery.homeRegionList.push(param1);
               break;
            case EquimentTypeEnum.EQUIMENT_TYPE_RESSTORECENTER:
               ConstructionMeomery.resStorecenterList.push(param1);
               break;
            case EquimentTypeEnum.EQUIMENT_TYPE_TECHRESEARCHCENTER:
               ConstructionMeomery.techResearchList.push(param1);
         }
      }
      
      public function RemoveConstructionMemory(param1:Equiment) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         if(param1 == null)
         {
            return;
         }
         switch(param1.EquimentInfoData.BuildID)
         {
            case EquimentTypeEnum.EQUIMENT_TYPE_HELIUM_3:
               _loc2_ = ConstructionMeomery.he3List;
               break;
            case EquimentTypeEnum.EQUIMENT_TYPE_METAL:
               _loc2_ = ConstructionMeomery.metalList;
               break;
            case EquimentTypeEnum.EQUIMENT_TYPE_HOMEREGION:
               _loc2_ = ConstructionMeomery.homeRegionList;
               break;
            case EquimentTypeEnum.EQUIMENT_TYPE_RESSTORECENTER:
               _loc2_ = ConstructionMeomery.resStorecenterList;
               break;
            case EquimentTypeEnum.EQUIMENT_TYPE_TECHRESEARCHCENTER:
               _loc2_ = ConstructionMeomery.techResearchList;
               break;
            default:
               return;
         }
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length)
         {
            if(Equiment(_loc2_[_loc4_]).EquimentInfoData.IndexId == param1.EquimentInfoData.IndexId)
            {
               _loc3_ = _loc4_;
               break;
            }
            _loc4_++;
         }
         _loc2_.splice(_loc3_,1);
      }
      
      public function cacheOwnSpecialConstruction(param1:Equiment) : void
      {
         var _loc2_:Object = null;
         if(param1.EquimentInfoData.BuildID == EquimentTypeEnum.EQUIMENT_TYPE_UNION || param1.EquimentInfoData.BuildID == EquimentTypeEnum.EQUIMENT_TYPE_SHIPBUILDING || param1.EquimentInfoData.BuildID == EquimentTypeEnum.EQUIMENT_TYPE_WEAPONRESEARCHCENTER || param1.EquimentInfoData.BuildID == EquimentTypeEnum.EQUIMENT_TYPE_TRADEPORT || param1.EquimentInfoData.BuildID == EquimentTypeEnum.EQUIMENT_TYPE_COMMANDERCENTER || param1.EquimentInfoData.BuildID == EquimentTypeEnum.EQUIMENT_TYPE_RADAR || param1.EquimentInfoData.BuildID == EquimentTypeEnum.EQUIMENT_TYPE_SHIPRECAIM || param1.EquimentInfoData.BuildID == EquimentTypeEnum.EQUIMENT_TYPE_COMPOSITIONCENTER)
         {
            if(ownConstructionCopyList.ContainsKey(param1.EquimentInfoData.BuildID))
            {
               _loc2_ = ownConstructionCopyList.Get(param1.EquimentInfoData.BuildID);
               _loc2_.LevelID = param1.EquimentInfoData.LevelId;
            }
            else
            {
               _loc2_ = new Object();
               _loc2_.BuildID = param1.EquimentInfoData.BuildID;
               _loc2_.LevelID = param1.EquimentInfoData.LevelId;
               ownConstructionCopyList.Put(_loc2_.BuildID,_loc2_);
            }
         }
      }
      
      public function setConstuctionRepairProgressState(param1:Equiment) : void
      {
         if(repairBuildingList == null)
         {
            repairBuildingList = new Array();
         }
         repairBuildingList.push(param1);
         RepairProgressToolBarManager.getInstance().pushUpgrate(param1);
         ProgressToolBarManager.getInstance().SyncTime();
      }
      
      public function setConstructionDestoryState(param1:Equiment) : void
      {
         if(param1)
         {
            param1.getMC().mouseChildren = false;
            param1.mouseChildren = false;
            param1.getMC().stop();
            if(param1.getMC().mc_anim)
            {
               MovieClip(param1.getMC().mc_anim).stop();
            }
            ConstructionBloodPlaneManager.hideBloodPlane(param1);
            if(param1.State == ConstructionState.STATE_BUILING || param1.State == ConstructionState.STATE_UPDATE)
            {
               ProgressToolBarManager.getInstance().clearProgress(param1);
            }
            this.removeConstruction(param1);
         }
      }
      
      public function freshFightConstruction() : void
      {
         var _loc1_:Equiment = null;
         var _loc2_:int = 0;
         while(_loc2_ < ConstructionAction.outSideContuctionList.Length())
         {
            _loc1_ = ConstructionAction.outSideContuctionList.Values()[_loc2_];
            if(_loc1_.State != ConstructionState.STATE_COMPLETE)
            {
               this.setConstructionDestoryState(_loc1_);
            }
            _loc2_++;
         }
      }
      
      public function showConstruction(param1:Equiment) : void
      {
         if(param1.parent == null)
         {
            if(param1.BlurPrint.BuildingClass & 1)
            {
               OutSideGalaxiasAction.getInstance().OutSideDefendContainer.addChild(param1);
            }
         }
      }
      
      public function createBuildRequest(param1:Equiment) : void
      {
         var _loc2_:MSG_REQUEST_CREATEBUILD = new MSG_REQUEST_CREATEBUILD();
         _loc2_.seqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         _loc2_.BuilingId = param1.EquimentInfoData.BuildID;
         _loc2_.IndexId = param1.EquimentInfoData.IndexId;
         _loc2_.posX = param1.EquimentInfoData.PosX;
         _loc2_.posY = param1.EquimentInfoData.PosY;
         NetManager.Instance().sendData(_loc2_);
      }
      
      public function respCreateBuild(param1:MSG_RESP_CREATEBUILD) : void
      {
         var _loc2_:Equiment = null;
         var _loc3_:HashSet = null;
         if(GameKernel.currentGameStage == GameStageEnum.GAME_STAGE_OUTSIDE)
         {
            _loc3_ = outSideContuctionList;
         }
         else if(GameKernel.currentGameStage == GameStageEnum.GAME_STAGE_STARSURFACE)
         {
            _loc3_ = constuctionList;
         }
         if(_loc3_.Get(param1.IndexId))
         {
            _loc2_ = _loc3_.Get(param1.IndexId) as Equiment;
         }
         else
         {
            _loc2_ = BuildingList[BuildingList.length - 1] as Equiment;
            _loc2_.State = ConstructionState.STATE_BUILING;
         }
         if(Boolean(_loc2_) && Boolean(_loc2_.BlurPrint.BuildingClass & 1))
         {
            OutSideGalaxiasAction.getInstance().setGirdLoad(_loc2_.EquimentInfoData.PosX,_loc2_.EquimentInfoData.PosY);
         }
         _loc2_.PlayAnimation(false);
         _loc2_.EquimentInfoData.IndexId = param1.IndexId;
         _loc2_.EquimentInfoData.LevelId = param1.LevelId;
         _loc2_.EquimentInfoData.needTime = param1.NeedTime;
         this.costResource(param1.Gas,param1.Metal,param1.Money);
         if(_loc2_.BlurPrint.BuildingClass & 1)
         {
            ConstructionAction.outSideContuctionList.Put(param1.IndexId,_loc2_);
         }
         else
         {
            ConstructionAction.constuctionList.Put(param1.IndexId,_loc2_);
            this.PushMemoryConstruction(_loc2_);
         }
         StarSurfaceAction.getInstance().sortList();
         this.setConstructionProgressState();
         ConstructionAction.senseZoneList.push(_loc2_.EquimentSenseZone);
         ProgressToolBarManager.getInstance().pushUpgrate(_loc2_);
         ProgressListToolBarWidget.getInstance().PushProgress(_loc2_);
         if(GameStateManager.playerPlace == GamePlaceType.PLACE_FRIENDHOME)
         {
            ProgressInFriendToolBarWidget.getInstance().PushProgress(_loc2_);
         }
         ProgressToolBarManager.getInstance().SyncTime();
      }
      
      private function setConstructionProgressState() : void
      {
         var _loc2_:Equiment = null;
         if(BuildingList == null || BuildingList.length == 0)
         {
            return;
         }
         var _loc1_:CFilter = new CFilter();
         _loc1_.generate_colorMatrix_filter();
         for each(_loc2_ in BuildingList)
         {
            if(_loc2_.getMC())
            {
               _loc2_.getMC().filters = _loc1_.getFilter(true);
               _loc2_.getMC().alpha = 0.7;
            }
         }
      }
      
      public function getSenseZoneIndex(param1:Equiment) : int
      {
         var _loc3_:ConstructionSenseZone = null;
         if(senseZoneList.length == 0)
         {
            return -1;
         }
         var _loc2_:int = 0;
         for each(_loc3_ in senseZoneList)
         {
            if(_loc3_.Construction.EquimentInfoData.IndexId == param1.EquimentInfoData.IndexId)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      public function respBuildingCompleted(param1:MSG_RESP_BUILDCOMPLETE) : void
      {
         var _loc4_:Equiment = null;
         var _loc5_:EquimentBlueprint = null;
         var _loc6_:GStar = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         for each(_loc4_ in BuildingList)
         {
            if(_loc4_.EquimentInfoData.IndexId == param1.IndexId)
            {
               _loc4_.EquimentInfoData.IndexId = param1.IndexId;
               ++_loc4_.EquimentInfoData.LevelId;
               _loc5_ = CConstructionReader.getInstance().Read(_loc4_.EquimentInfoData.BuildID,_loc4_.EquimentInfoData.LevelId);
               if(_loc5_.BuildingClass & 1)
               {
                  if(ConstructionAction.ConstructionResCache.ContainsKey(_loc4_.EquimentInfoData.BuildID))
                  {
                     _loc4_.reLoadMc(_loc5_.defendLevel.ImageName);
                  }
                  OutSideGalaxiasAction.getInstance().setGirdLoad(_loc4_.EquimentInfoData.PosX,_loc4_.EquimentInfoData.PosY);
               }
               else if(ConstructionAction.ConstructionResCache.ContainsKey(_loc4_.EquimentInfoData.BuildID))
               {
                  _loc4_.reLoadMc(_loc5_.equimentLevel.ImageName);
               }
               _loc4_.EquimentInfoData.GalaxyId = param1.GalaxyId;
               _loc4_.EquimentInfoData.GalaxyMapId = param1.GalaxyMapId;
               _loc4_.EquimentInfoData.needTime = 0;
               _loc4_.State = ConstructionState.STATE_COMPLETE;
               _loc4_.BlurPrint = _loc5_;
               _loc4_.getMC().filters = null;
               _loc4_.getMC().alpha = 1;
               if(_loc4_.EquimentInfoData.BuildID == EquimentTypeEnum.EQUIMENT_TYPE_SPACESTATION)
               {
                  _loc6_ = GalaxyManager.instance.getCacheData(_loc4_.EquimentInfoData.GalaxyId);
                  if(_loc6_ != null)
                  {
                     _loc6_.Level = _loc4_.EquimentInfoData.LevelId;
                  }
                  GalaxyManager.instance.fresh();
               }
               _loc3_ = ProgressToolBarManager.getInstance().getProgressIndex(_loc4_);
               ProgressToolBarManager.getInstance().clearProgress(_loc4_);
               ProgressListToolBarWidget.getInstance().Destory(_loc4_);
               if(GameStateManager.playerPlace == GamePlaceType.PLACE_FRIENDHOME)
               {
                  ProgressInFriendToolBarWidget.getInstance().Destory(_loc4_);
               }
               StarSurfaceAction.getInstance().sortList();
               BuildingList.splice(_loc3_,1);
               this.cacheOwnSpecialConstruction(_loc4_);
               break;
            }
            _loc2_++;
         }
         ConstructionAnimationManager.rePlayConstruction(_loc4_);
         ConstructionOperationWidget.getInstance().Hide();
      }
      
      public function respBuildingConsortiWealth(param1:MSG_RESP_CONSORTIAWEALTH) : void
      {
         GamePlayer.getInstance().currentWealth = param1.Wealth;
      }
      
      public function sendConsortBuildingRequest(param1:Equiment) : void
      {
         var _loc2_:MSG_REQUEST_CONSORTIABUILDING = new MSG_REQUEST_CONSORTIABUILDING();
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.IndexId = param1.EquimentInfoData.IndexId;
         _loc2_.GalaxyId = param1.EquimentInfoData.GalaxyId;
         _loc2_.GalaxyMapId = param1.EquimentInfoData.GalaxyMapId;
         NetManager.Instance().sendObject(_loc2_);
      }
      
      public function respConsortBuilding(param1:MSG_RESP_CONSORTIABUILDING) : void
      {
         var _loc2_:int = param1.GalaxyMapId;
         var _loc3_:int = param1.GalaxyId;
         var _loc4_:int = param1.IndexId;
         GamePlayer.getInstance().currentWealth = param1.Wealth;
         var _loc5_:Equiment = outSideContuctionList.Get(_loc4_);
         if(_loc5_)
         {
            ++_loc5_.EquimentInfoData.LevelId;
            _loc5_.getMC().filters = null;
            _loc5_.getMC().alpha = 1;
            return;
         }
         throw new Error("军团建造错误");
      }
      
      public function respBuildingDeathCompleted(param1:MSG_RESP_BUILDINGDEATHCOMPLETE) : void
      {
         var _loc2_:int = param1.GalaxyId;
         var _loc3_:int = param1.GalaxyMapId;
         var _loc4_:int = param1.IndexId;
         var _loc5_:Equiment = this.getEquiment(_loc4_).Instance as Equiment;
         if(_loc5_)
         {
            _loc5_.State = ConstructionState.STATE_COMPLETE;
         }
         var _loc6_:int = RepairProgressToolBarManager.getInstance().getProgressIndex(_loc5_);
         RepairProgressToolBarManager.getInstance().clearProgress(_loc5_);
         ConstructionRepairManager.hideRepairBar(_loc5_);
         repairBuildingList.splice(_loc6_,1);
         _loc5_.EquimentInfoData.needTime = 0;
         if(Boolean(_loc5_) && _loc5_.parent == null)
         {
            OutSideGalaxiasAction.getInstance().OutSideDefendContainer.addChild(_loc5_);
         }
      }
      
      public function deleteBuildRequest(param1:int) : void
      {
         var _loc2_:MSG_REQUEST_DELETEBUILD = new MSG_REQUEST_DELETEBUILD();
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         _loc2_.IndexId = param1;
         NetManager.Instance().sendObject(_loc2_);
      }
      
      public function respDeleteBuild(param1:MSG_RESP_DELETEBUILD) : void
      {
         var _loc3_:Equiment = null;
         var _loc2_:int = param1.IndexId;
         if(GameKernel.currentGameStage == GameStageEnum.GAME_STAGE_OUTSIDE)
         {
            _loc3_ = ConstructionAction.outSideContuctionList.Get(_loc2_);
            ConstructionAction.outSideContuctionList.Remove(_loc2_);
            OutSideGalaxiasAction.getInstance().setGirdLoad(_loc3_.EquimentInfoData.PosX,_loc3_.EquimentInfoData.PosY,false);
         }
         else if(GameKernel.currentGameStage == GameStageEnum.GAME_STAGE_STARSURFACE)
         {
            _loc3_ = ConstructionAction.constuctionList.Get(_loc2_);
            ConstructionAction.constuctionList.Remove(_loc2_);
         }
         if(_loc3_.State == ConstructionState.STATE_BUILING || _loc3_.State == ConstructionState.STATE_UPDATE)
         {
            ConstructionAction.BuildingList.splice(this.getEquiment(_loc2_).Index,1);
         }
         ConstructionInfoManagerUI.getInstance().clearConstructionList(_loc2_);
         this.removeOwnConstructionByBuildID(_loc3_.EquimentInfoData.BuildID);
         if(_loc3_.BlurPrint.BuildingClass == 0)
         {
            senseZoneList.splice(this.getSenseZoneIndex(_loc3_),1);
         }
         _loc3_.Release();
         if(_loc3_.parent)
         {
            _loc3_.parent.removeChild(_loc3_);
         }
         _loc3_ = null;
      }
      
      public function sendConstructionSpeedRequest(param1:int, param2:int, param3:int = 0) : void
      {
         var _loc4_:MSG_REQUEST_SPEEDBUILDING = new MSG_REQUEST_SPEEDBUILDING();
         _loc4_.SeqId = GamePlayer.getInstance().seqID++;
         _loc4_.Guid = GamePlayer.getInstance().Guid;
         _loc4_.IndexId = param1;
         _loc4_.BuildingSpeedId = param2;
         _loc4_.Type = param3;
         NetManager.Instance().sendObject(_loc4_);
      }
      
      public function respBuildingSpeed(param1:MSG_RESP_SPEEDBUILDING) : void
      {
         var _loc2_:int = param1.IndexId;
         var _loc3_:int = param1.BuildingSpeedId;
         var _loc4_:int = param1.Time;
         var _loc5_:int = param1.Credit;
         var _loc6_:Equiment = this.getEquiment(_loc2_).Instance as Equiment;
         _loc6_.EquimentInfoData.needTime = _loc4_;
         if(_loc6_.EquimentInfoData.needTime <= 0)
         {
            _loc6_.State = ConstructionState.STATE_COMPLETE;
            _loc6_.getMC().filters = null;
            _loc6_.getMC().alpha = 1;
         }
         var _loc7_:Object = ConstructionSpeedReader.getInstance().Read(_loc3_);
         ConstructionSpeedPopUp.getInstance().getProgressEntryIso().setProgressCostTime();
         ProgressToolBarManager.getInstance().updateConstructionCostTime(_loc2_);
         if(ConstructionSpeedPopUp.getInstance()._selectType == 0)
         {
            if(_loc5_ <= GamePlayer.getInstance().cash)
            {
               this.costResource(0,0,0,_loc5_);
            }
         }
         else if(_loc5_ <= GamePlayer.getInstance().coins)
         {
            GamePlayer.getInstance().coins = GamePlayer.getInstance().coins - _loc5_;
         }
      }
      
      public function cancelBuildRequest(param1:int) : void
      {
         var _loc2_:MSG_REQUEST_CANCELBUILD = new MSG_REQUEST_CANCELBUILD();
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         _loc2_.IndexId = param1;
         NetManager.Instance().sendObject(_loc2_);
      }
      
      public function respCancelBuilding(param1:MSG_RESP_CANCELBUILD) : void
      {
         var _loc4_:Equiment = null;
         var _loc5_:EquimentBlueprint = null;
         var _loc6_:int = 0;
         var _loc2_:int = param1.IndexId;
         var _loc3_:int = param1.Status;
         if(_loc3_)
         {
            if(GameKernel.currentGameStage == GameStageEnum.GAME_STAGE_OUTSIDE)
            {
               _loc4_ = outSideContuctionList.Get(_loc2_);
            }
            else
            {
               _loc4_ = constuctionList.Get(_loc2_);
            }
            if(_loc4_ == null)
            {
               return;
            }
            _loc4_.getMC().alpha = 1;
            _loc4_.getMC().filters = null;
            _loc5_ = CConstructionReader.getInstance().Read(_loc4_.EquimentInfoData.BuildID,_loc4_.EquimentInfoData.LevelId + 1);
            _loc6_ = ProgressToolBarManager.getInstance().getProgressIndex(_loc4_);
            if(_loc4_.State == ConstructionState.STATE_UPDATE)
            {
               _loc4_.State = ConstructionState.STATE_COMPLETE;
               ProgressToolBarManager.getInstance().clearProgress(_loc4_);
            }
            else if(_loc4_.State == ConstructionState.STATE_BUILING)
            {
               if(_loc4_.BlurPrint.BuildingClass & 1)
               {
                  OutSideGalaxiasAction.getInstance().setGirdLoad(_loc4_.EquimentInfoData.PosX,_loc4_.EquimentInfoData.PosY,false);
                  outSideContuctionList.Remove(_loc4_.EquimentInfoData.IndexId);
               }
               else
               {
                  constuctionList.Remove(_loc4_.EquimentInfoData.IndexId);
                  this.RemoveConstructionMemory(_loc4_);
               }
               ProgressToolBarManager.getInstance().clearProgress(_loc4_);
               SingleLoader.GetInstance().Release();
               if(_loc4_.parent)
               {
                  _loc4_.parent.removeChild(_loc4_);
               }
               _loc4_.State = ConstructionState.STATE_PREBUIDING;
               if(!(_loc4_.BlurPrint.BuildingClass & 1))
               {
                  senseZoneList.splice(this.getSenseZoneIndex(_loc4_),1);
               }
               _loc4_ = null;
            }
            BuildingList.splice(_loc6_,1);
            this.addResource(param1.Gas,param1.Metal,param1.Money);
            StarSurfaceAction.getInstance().sortList();
            return;
         }
      }
      
      public function moveBuildingRequest(param1:Equiment) : void
      {
         var _loc2_:MSG_REQUEST_MOVEBUILD = new MSG_REQUEST_MOVEBUILD();
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.IndexId = param1.EquimentInfoData.IndexId;
         _loc2_.PosX = param1.EquimentInfoData.PosX;
         _loc2_.PosY = param1.EquimentInfoData.PosY;
         NetManager.Instance().sendObject(_loc2_);
      }
      
      public function respMoveBuilding(param1:MSG_RESP_MOVEBUILD) : void
      {
         var _loc5_:Equiment = null;
         var _loc2_:int = param1.IndexId;
         var _loc3_:int = int(param1.PosX);
         var _loc4_:int = int(param1.PosY);
         if(GameKernel.currentGameStage == GameStageEnum.GAME_STAGE_OUTSIDE)
         {
            _loc5_ = outSideContuctionList.Get(_loc2_) as Equiment;
         }
         else if(GameKernel.currentGameStage == GameStageEnum.GAME_STAGE_STARSURFACE)
         {
            _loc5_ = constuctionList.Get(_loc2_) as Equiment;
         }
         _loc5_.State = ConstructionState.STATE_COMPLETE;
         _loc5_.EquimentInfoData.PosX = _loc3_;
         _loc5_.EquimentInfoData.PosY = _loc4_;
         if(GameKernel.currentGameStage == GameStageEnum.GAME_STAGE_STARSURFACE)
         {
            _loc5_.setLocation(_loc3_,_loc4_);
         }
         else
         {
            OutSideGalaxiasAction.getInstance().setGirdLoad(_loc3_,_loc4_);
         }
      }
      
      public function sendTimeQueueRequest() : void
      {
         var _loc1_:MSG_REQUEST_TIMEQUEUE = new MSG_REQUEST_TIMEQUEUE();
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         NetManager.Instance().sendObject(_loc1_);
      }
      
      public function respTimeQueue(param1:MSG_RESP_TIMEQUEUE) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:Array = param1.Data;
         if(param1.DataLen == 0)
         {
            GamePlayer.getInstance().constructionQueueOpenNum = 0;
            BufferQueueManager.getInstance().ClearAll();
            CustomTip.GetInstance().Hide();
         }
         else
         {
            GamePlayer.getInstance().constructionQueueOpenNum = 0;
            BufferQueueManager.getInstance().ClearAll();
            GamePlayer.getInstance().VipBuffer = false;
            _loc3_ = 0;
            while(_loc3_ < param1.DataLen)
            {
               _loc4_ = int(param1.Data[_loc3_].Type);
               if(_loc4_ == 0)
               {
                  GamePlayer.getInstance().constructionQueueOpenNum = 3;
               }
               else if(_loc4_ != 1)
               {
                  if(_loc4_ != 2)
                  {
                     if(_loc4_ != 3)
                     {
                        if(_loc4_ != 4)
                        {
                           if(_loc4_ != 5)
                           {
                              if(_loc4_ == 7)
                              {
                                 GamePlayer.getInstance().VipBuffer = true;
                              }
                           }
                        }
                     }
                  }
               }
               BufferQueueManager.getInstance().pushQueue(param1.Data[_loc3_]);
               _loc3_++;
            }
            BufferQueueManager.getInstance().syncTime();
         }
      }
      
      public function sendSpeedBuildInFriend(param1:int, param2:int) : void
      {
         var _loc3_:MSG_REQUEST_SPEEDFRIENDBUILDING = new MSG_REQUEST_SPEEDFRIENDBUILDING();
         _loc3_.SeqId = GamePlayer.getInstance().seqID++;
         _loc3_.Guid = GamePlayer.getInstance().Guid;
         _loc3_.ObjGuid = param1;
         _loc3_.IndexId = param2;
         NetManager.Instance().sendObject(_loc3_);
      }
      
      public function respSpeedBuildInFriend(param1:MSG_RESP_SPEEDFRIENDBUILDING) : void
      {
         var _loc6_:Equiment = null;
         var _loc7_:ProgressEntryIso = null;
         var _loc2_:int = param1.ErrorCode;
         var _loc3_:int = param1.IndexId;
         var _loc4_:int = param1.SpareTime;
         var _loc5_:int = param1.Type;
         switch(_loc2_)
         {
            case 0:
               if(_loc5_)
               {
                  _loc6_ = this.getEquiment(_loc3_).Instance as Equiment;
                  if(_loc6_ == null)
                  {
                     return;
                  }
                  _loc6_.EquimentInfoData.needTime = _loc4_;
                  _loc7_ = ProgressListToolBarWidget.getInstance().getProgressIsoByEquiment(_loc6_);
                  if(_loc7_)
                  {
                     _loc7_.setCostTime();
                  }
                  break;
               }
               if(currentProgressIso)
               {
                  currentProgressIso.updateSpeedCostTime(_loc4_);
               }
               CEffectText.getInstance().showEffectText(GameKernel.renderManager.getUI().getContainer(),StringManager.getInstance().getMessageString("FriendText22"));
               break;
            case 1:
               CEffectText.getInstance().showEffectText(GameKernel.renderManager.getUI().getContainer(),StringManager.getInstance().getMessageString("BuildingText8"));
               break;
            case 2:
               CEffectText.getInstance().showEffectText(GameKernel.renderManager.getUI().getContainer(),StringManager.getInstance().getMessageString("BuildingText9"));
               break;
            case 3:
               CEffectText.getInstance().showEffectText(GameKernel.renderManager.getUI().getContainer(),StringManager.getInstance().getMessageString("BuildingText10"));
         }
      }
      
      public function respCreateBuildInfo(param1:MSG_RESP_CREATEBUILDINFO) : void
      {
         var _loc6_:MSG_RESP_CREATEBUILDINFO_TEMP = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Equiment = null;
         var _loc10_:ProgressEntryIso = null;
         var _loc2_:int = param1.GalaxyMapId;
         var _loc3_:int = param1.GalaxyId;
         var _loc4_:int = param1.DataLen;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = param1.Data[_loc5_] as MSG_RESP_CREATEBUILDINFO_TEMP;
            _loc7_ = _loc6_.IndexId;
            _loc8_ = _loc6_.SpareTime;
            _loc9_ = this.getEquiment(_loc7_).Instance as Equiment;
            _loc9_.EquimentInfoData.needTime = _loc8_;
            _loc10_ = ProgressListToolBarWidget.getInstance().getProgressIsoByEquiment(_loc9_);
            _loc10_.setCostTime();
            _loc5_++;
         }
      }
      
      public function sendPlayerResource() : void
      {
         var _loc1_:MSG_REQUEST_PLAYERRESOURCE = new MSG_REQUEST_PLAYERRESOURCE();
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc1_);
      }
      
      public function reInitConstructionList() : void
      {
         var _loc1_:Equiment = null;
         var _loc2_:Array = null;
         if(outSideContuctionList.Length())
         {
            _loc2_ = outSideContuctionList.Values();
            for each(_loc1_ in _loc2_)
            {
               OutSideGalaxiasAction.getInstance().OutSideDefendContainer.removeChild(_loc1_);
               _loc1_.Release();
            }
            outSideContuctionList.removeAll();
         }
         if(constuctionList.Length())
         {
            _loc2_ = outSideContuctionList.Values();
            for each(_loc1_ in _loc2_)
            {
               StarSurfaceAction.getInstance().LayOut.removeChild(_loc1_);
               _loc1_.Release();
            }
            constuctionList.removeAll();
         }
      }
      
      public function removeOtherSenseZone(param1:Equiment) : void
      {
         var _loc3_:Equiment = null;
         var _loc2_:Array = constuctionList.Values();
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_.EquimentInfoData.IndexId != param1.EquimentInfoData.IndexId)
            {
               if(_loc3_.State == ConstructionState.STATE_COMPLETE)
               {
                  if(_loc3_.getMC() == null)
                  {
                     return;
                  }
                  _loc3_.getMC().filters = null;
               }
               _loc3_.getMC().alpha = 1;
               _loc3_.removeEquimentSenseZone();
            }
         }
      }
      
      public function getEquiment(param1:int) : Object
      {
         var _loc2_:Object = new Object();
         var _loc3_:Array = constuctionList.Values();
         var _loc4_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            if(Equiment(_loc3_[_loc4_]).EquimentInfoData.IndexId == param1)
            {
               _loc2_.Index = _loc4_;
               _loc2_.Instance = Equiment(_loc3_[_loc4_]);
               return _loc2_;
            }
            _loc4_++;
         }
         _loc3_ = outSideContuctionList.Values();
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            if(Equiment(_loc3_[_loc4_]).EquimentInfoData.IndexId == param1)
            {
               _loc2_.Index = _loc4_;
               _loc2_.Instance = Equiment(_loc3_[_loc4_]);
               return _loc2_;
            }
            _loc4_++;
         }
         _loc2_.Index = -1;
         _loc2_.Instance = null;
         return _loc2_;
      }
      
      public function forceOnConstructionModuel() : void
      {
         if(GameKernel.isBuildModule && GameKernel.currentGameStage == GameStageEnum.GAME_STAGE_OUTSIDE)
         {
            this.clearConstructionModule();
         }
      }
      
      public function clearConstructionModule() : void
      {
         var _loc1_:Point = null;
         if(ConstructionAction.currentTarget == null)
         {
            return;
         }
         switch(GameKernel.currentGameStage)
         {
            case GameStageEnum.GAME_STAGE_STARSURFACE:
               if(GalaxyMapAction.instance.curStar.FightFlag == 1)
               {
                  return;
               }
               StarSurfaceAction.getInstance().changeConstructionModel(false);
               if(ConstructionAction.currentTarget.State == ConstructionState.STATE_MIRGRATE)
               {
                  StarSurfaceAction.getInstance().IsMigrate = false;
                  ConstructionAction.currentTarget.State = ConstructionState.STATE_COMPLETE;
               }
               StarSurfaceAction.getInstance().removeActionEvent();
               if(StarSufaceMarkZone.getInstance().BorderMarkZone.filters != null)
               {
                  StarSufaceMarkZone.getInstance().BorderMarkZone.filters = null;
               }
               break;
            case GameStageEnum.GAME_STAGE_OUTSIDE:
               if(ConstructionAction.currentTarget.State == ConstructionState.STATE_MIRGRATE)
               {
                  ConstructionAction.currentTarget.State = ConstructionState.STATE_COMPLETE;
               }
               if(Boolean(ConstructionAction.currentTarget) && ConstructionAction.currentTarget.IsShowInfluence)
               {
                  ConstructionAction.currentTarget.HideEquimentInfluence();
               }
               OutSideGalaxiasAction.getInstance().changeConstuctionModel(false);
               OutSideGalaxiasAction.getInstance().IsConstuctionModel = false;
               OutSideGalaxiasAction.getInstance().removeActionEvent();
         }
         GameKernel.isBuildModule = false;
         currentTarget.setEnable(false);
         if(currentTarget.State == ConstructionState.STATE_PREBUIDING && currentTarget.parent != null)
         {
            currentTarget.parent.removeChild(currentTarget);
         }
         else if(currentTarget.BlurPrint.BuildingClass & 1)
         {
            _loc1_ = GalaxyShipManager.getPixel(preConstructionPosX,preConstructionPosY);
            currentTarget.Position = new Point3D(_loc1_.x,_loc1_.y);
            OutSideGalaxiasAction.getInstance().OutSideDefendContainer.addChild(ConstructionAction.currentTarget);
            OutSideGalaxiasAction.getInstance().sortList();
         }
         else
         {
            currentTarget.setLocation(preConstructionPosX,preConstructionPosY);
         }
         preConstructionPosX = preConstructionPosY = 0;
         currentTarget = null;
         GamePopUpDisplayManager.getInstance().HideAllPopup();
      }
      
      public function clearCurrentConstructionModule() : void
      {
         if(ConstructionAction.currentTarget)
         {
            ConstructionAction.currentTarget.getMC().filters = null;
            ConstructionAction.currentTarget.removeEquimentSenseZone();
         }
      }
      
      public function CheckConstructionProgreeIsFull() : Boolean
      {
         return BuildingList.length >= GamePlayer.getInstance().constructionProgressNum + GamePlayer.getInstance().IncreaseBuildQueue + GamePlayer.getInstance().constructionQueueOpenNum;
      }
      
      public function checkCanBuild(param1:int, param2:int) : Boolean
      {
         if(GameStatisticsManager.getInstance().Record.Length() != 0)
         {
            GameStatisticsManager.getInstance().Record.removeAll();
         }
         var _loc3_:EquimentBlueprint = CConstructionReader.getInstance().Read(param1,param2);
         if(_loc3_.BuildingClass == -1)
         {
            return false;
         }
         if(param1 != EquimentTypeEnum.EQUIMENT_TYPE_SPACESTATION)
         {
            if(this.getCivisimCenter() == null)
            {
               GameStatisticsManager.getInstance().UnBuildAbleRecord("have not CivisimCenter",0);
            }
            if(_loc3_.BuildingClass & 1)
            {
               this.isHaveDependBuild(ConstructionUtil.parserDependBuilding(_loc3_.defendLevel.Dependbuilding));
               return this.ValidateResEnough(_loc3_.defendLevel);
            }
            this.isHaveDependBuild(ConstructionUtil.parserDependBuilding(_loc3_.equimentLevel.Dependbuilding));
            return this.ValidateResEnough(_loc3_.equimentLevel);
         }
         if(_loc3_.BuildingClass & 1)
         {
            return this.ValidateResEnough(_loc3_.defendLevel);
         }
         return this.ValidateResEnough(_loc3_.equimentLevel);
      }
      
      private function ValidateCashEnough(param1:EquimentBlueprint) : Boolean
      {
         if(param1.UIType == EquimentFactory.EQUIMENT_UI_DIY)
         {
            if(param1.equimentLevel.LevelID > 2)
            {
               if(param1.equimentLevel.CostCash < GamePlayer.getInstance().cash)
               {
                  GameStatisticsManager.getInstance().UnBuildAbleRecord("Cash",param1.equimentLevel.CostCash.toString());
               }
            }
         }
         return GameStatisticsManager.getInstance().Record.Length() == 0;
      }
      
      private function ValidateResEnough(param1:Level) : Boolean
      {
         if(param1 is DefendBuildLevel)
         {
            if(GamePlayer.getInstance().UserMetal < param1.CostMetal * (1 - ConstructionAction.defendTechObj.DecreaseMetalConsume))
            {
               GameStatisticsManager.getInstance().UnBuildAbleRecord("Metal",param1.CostMetal * (1 - ConstructionAction.defendTechObj.DecreaseMetalConsume));
            }
            if(GamePlayer.getInstance().UserHe3 < param1.CostHelium_3 * (1 - ConstructionAction.defendTechObj.DecreaseHe3Consume))
            {
               GameStatisticsManager.getInstance().UnBuildAbleRecord("Helium_3",param1.CostHelium_3 * (1 - ConstructionAction.defendTechObj.DecreaseHe3Consume));
            }
            if(GamePlayer.getInstance().UserMoney < param1.CostFunds * (1 - ConstructionAction.defendTechObj.DecreaseMoneyConsume))
            {
               GameStatisticsManager.getInstance().UnBuildAbleRecord("Funds",param1.CostFunds * (1 - ConstructionAction.defendTechObj.DecreaseMoneyConsume));
            }
         }
         else if(param1 is EquimentLevel)
         {
            if(GamePlayer.getInstance().UserMetal < int(param1.CostMetal * (1 - ConstructionAction.bulidTechObj.DecreaseMetalConsume)))
            {
               GameStatisticsManager.getInstance().UnBuildAbleRecord("Metal",param1.CostMetal * (1 - ConstructionAction.bulidTechObj.DecreaseMetalConsume));
            }
            if(GamePlayer.getInstance().UserHe3 < int(param1.CostHelium_3 * (1 - ConstructionAction.bulidTechObj.DecreaseHe3Consume)))
            {
               GameStatisticsManager.getInstance().UnBuildAbleRecord("Helium_3",param1.CostHelium_3 * (1 - ConstructionAction.bulidTechObj.DecreaseHe3Consume));
            }
            if(GamePlayer.getInstance().UserMoney < int(param1.CostFunds * (1 - ConstructionAction.bulidTechObj.DecreaseMoneyConsume)))
            {
               GameStatisticsManager.getInstance().UnBuildAbleRecord("Funds",param1.CostFunds * (1 - ConstructionAction.bulidTechObj.DecreaseMoneyConsume));
            }
         }
         return GameStatisticsManager.getInstance().Record.Length() == 0;
      }
      
      private function isHaveDependBuild(param1:Array) : void
      {
         var _loc3_:Object = null;
         var _loc4_:int = 0;
         var _loc2_:Array = new Array();
         for each(_loc3_ in param1)
         {
            if(_loc3_.BuildID == EquimentTypeEnum.EQUIMENT_TYPE_CIVICISM)
            {
               if(this.getCivisimCenter().EquimentInfoData.LevelId < _loc3_.Lv)
               {
                  _loc2_.push(_loc3_);
               }
            }
            else
            {
               _loc4_ = this.getConstructionNumAsCompleted(_loc3_.BuildID);
               if(_loc4_ == 0)
               {
                  _loc2_.push(_loc3_);
               }
               if(this.getConstructionMaxLv(_loc3_.BuildID) < _loc3_.Lv)
               {
                  _loc2_.push(_loc3_);
               }
            }
         }
         if(_loc2_.length)
         {
            GameStatisticsManager.getInstance().UnBuildAbleRecord("Dependbuilding",_loc2_);
         }
      }
      
      private function getConstructionMaxLv(param1:int) : int
      {
         var _loc3_:Array = null;
         var _loc4_:Equiment = null;
         var _loc2_:int = 0;
         _loc3_ = constuctionList.Values();
         for each(_loc4_ in _loc3_)
         {
            if(_loc4_.EquimentInfoData.BuildID == param1)
            {
               if(_loc4_.State != ConstructionState.STATE_BUILING || _loc4_.State != ConstructionState.STATE_UPDATE)
               {
                  _loc2_ = Math.max(_loc2_,_loc4_.EquimentInfoData.LevelId);
               }
            }
         }
         _loc3_ = outSideContuctionList.Values();
         for each(_loc4_ in _loc3_)
         {
            if(_loc4_.EquimentInfoData.BuildID == param1)
            {
               if(_loc4_.State != ConstructionState.STATE_BUILING || _loc4_.State != ConstructionState.STATE_UPDATE)
               {
                  _loc2_ = Math.max(_loc2_,_loc4_.EquimentInfoData.LevelId);
               }
            }
         }
         return _loc2_;
      }
      
      public function getConstructionClass(param1:int) : int
      {
         return CConstructionReader.getInstance().Read(param1,0).BuildingClass;
      }
      
      public function getConstructionNumAsCompleted(param1:int) : int
      {
         var _loc3_:Array = null;
         var _loc4_:Equiment = null;
         var _loc2_:int = 0;
         if(this.getConstructionClass(param1) & 1)
         {
            _loc3_ = outSideContuctionList.Values();
            for each(_loc4_ in _loc3_)
            {
               if(_loc4_.EquimentInfoData.BuildID == param1)
               {
                  if(_loc4_.State != ConstructionState.STATE_BUILING || _loc4_.State != ConstructionState.STATE_UPDATE)
                  {
                     _loc2_++;
                  }
               }
            }
         }
         else
         {
            _loc3_ = constuctionList.Values();
            for each(_loc4_ in _loc3_)
            {
               if(_loc4_.EquimentInfoData.BuildID == param1)
               {
                  if(_loc4_.State != ConstructionState.STATE_BUILING || _loc4_.State != ConstructionState.STATE_UPDATE)
                  {
                     _loc2_++;
                  }
               }
            }
         }
         return _loc2_;
      }
      
      public function getConstructionCurrentNum(param1:int) : int
      {
         var _loc3_:Array = null;
         var _loc4_:Equiment = null;
         var _loc2_:int = 0;
         if(this.getConstructionClass(param1) & 1)
         {
            _loc3_ = outSideContuctionList.Values();
            for each(_loc4_ in _loc3_)
            {
               if(_loc4_.EquimentInfoData.BuildID == param1)
               {
                  _loc2_++;
               }
            }
         }
         else
         {
            _loc3_ = constuctionList.Values();
            for each(_loc4_ in _loc3_)
            {
               if(_loc4_.EquimentInfoData.BuildID == param1)
               {
                  _loc2_++;
               }
            }
         }
         return _loc2_;
      }
      
      public function getConstructionImage(param1:int, param2:int) : String
      {
         var _loc3_:EquimentBlueprint = CConstructionReader.getInstance().Read(param1,param2);
         return _loc3_.BuildingClass & 1 == true ? _loc3_.defendLevel.ImageName : _loc3_.equimentLevel.ImageName;
      }
      
      public function getConstructionMaxNum(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:Equiment = null;
         var _loc4_:EquimentBlueprint = null;
         _loc4_ = CConstructionReader.getInstance().Read(param1);
         if(_loc4_.BuildingClass & 1)
         {
            _loc3_ = this.getSpaceStation();
            if(_loc3_ == null)
            {
               _loc4_ = CConstructionReader.getInstance().Read(EquimentTypeEnum.EQUIMENT_TYPE_SPACESTATION);
            }
            else
            {
               _loc4_ = _loc3_.BlurPrint;
            }
         }
         else
         {
            _loc3_ = this.getCivisimCenter();
            if(_loc3_ == null)
            {
               _loc4_ = CConstructionReader.getInstance().Read();
            }
            else
            {
               _loc4_ = _loc3_.BlurPrint;
            }
         }
         return ConstructionUtil.getConstructionCount(param1,_loc4_);
      }
      
      public function isOverConstructionNum(param1:int) : Boolean
      {
         var _loc2_:int = this.getConstructionCurrentNum(param1);
         var _loc3_:int = this.getConstructionMaxNum(param1);
         return this.getConstructionCurrentNum(param1) >= this.getConstructionMaxNum(param1);
      }
      
      public function costResource(param1:int = 0, param2:int = 0, param3:int = 0, param4:int = 0) : void
      {
         GamePlayer.getInstance().UserHe3 = GamePlayer.getInstance().UserHe3 - param1;
         GamePlayer.getInstance().UserMetal = GamePlayer.getInstance().UserMetal - param2;
         GamePlayer.getInstance().UserMoney = GamePlayer.getInstance().UserMoney - param3;
         GamePlayer.getInstance().cash = GamePlayer.getInstance().cash - param4;
         ResPlaneUI.getInstance().updateResPlane();
      }
      
      public function addResource(param1:int = 0, param2:int = 0, param3:int = 0, param4:int = 0) : void
      {
         GamePlayer.getInstance().UserHe3 = GamePlayer.getInstance().UserHe3 + param1;
         GamePlayer.getInstance().UserMetal = GamePlayer.getInstance().UserMetal + param2;
         GamePlayer.getInstance().UserMoney = GamePlayer.getInstance().UserMoney + param3;
         GamePlayer.getInstance().cash = GamePlayer.getInstance().cash + param4;
         ResPlaneUI.getInstance().updateResPlane();
      }
      
      public function sendStorageResource() : void
      {
         var _loc1_:MSG_REQUEST_STORAGERESOURCE = null;
         if(GameKernel.getInstance().isInit == true)
         {
            _loc1_ = new MSG_REQUEST_STORAGERESOURCE();
            _loc1_.SeqId = GamePlayer.getInstance().seqID++;
            _loc1_.Guid = GamePlayer.getInstance().Guid;
            NetManager.Instance().sendObject(_loc1_);
         }
      }
      
      public function respStorageResource(param1:MSG_RESP_STORAGERESOURCE) : void
      {
         var _loc2_:int = param1.Gas;
         var _loc3_:int = param1.StorageGas;
         var _loc4_:int = param1.Metal;
         var _loc5_:int = param1.StorageMetal;
         var _loc6_:int = param1.Money;
         var _loc7_:int = param1.StorageMoney;
         GamePlayer.getInstance().ResGas = _loc2_;
         GamePlayer.getInstance().ResStorageGas = _loc3_;
         GamePlayer.getInstance().ResMetal = _loc4_;
         GamePlayer.getInstance().ResStorageMetal = _loc5_;
         GamePlayer.getInstance().ResMoney = _loc6_;
         GamePlayer.getInstance().ResStorageMoney = _loc7_;
         this.setStorageActiveState();
      }
      
      public function sendGetStorageResource() : void
      {
         var _loc1_:MSG_REQUEST_GETSTORAGERESOURCE = new MSG_REQUEST_GETSTORAGERESOURCE();
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc1_);
         GamePlayer.getInstance().ResGas = 0;
         GamePlayer.getInstance().ResMetal = 0;
         GamePlayer.getInstance().ResMoney = 0;
      }
      
      public function respGetStorageResource(param1:MSG_RESP_GETSTORAGERESOURCE) : void
      {
         var _loc2_:int = param1.Gas;
         var _loc3_:int = param1.Metal;
         var _loc4_:int = param1.Money;
         this.addResource(_loc2_,_loc3_,_loc4_);
         ResPlaneUI.getInstance().updateResPlane();
         ConstructionAnimationManager.PlayConstuctionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_HELIUM_3);
         ConstructionAnimationManager.PlayConstuctionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_METAL);
         this.startResourceStorageCount();
      }
      
      public function respFaceBookFriendInifo(param1:MSG_RESP_FRIENDINFO) : void
      {
      }
      
      public function respBuildInfoFriend(param1:MSG_RESP_BUILDINFOFRIEND) : void
      {
         var _loc2_:int = param1.GalaxyMapId;
         var _loc3_:int = param1.GalaxyId;
         var _loc4_:int = param1.StorageFlagMetal;
         var _loc5_:int = param1.StorageFlagGas;
         var _loc6_:int = param1.StorageFlagMoney;
         var _loc7_:int = param1.ShipFactoryFlag;
         if(_loc5_)
         {
            ConstructionAnimationManager.StopConstructionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_HELIUM_3);
            ConstructionAnimationManager.PlayConstuctionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_RESSTORECENTER);
         }
         else
         {
            ConstructionAnimationManager.PlayConstuctionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_HELIUM_3);
         }
         if(_loc4_)
         {
            ConstructionAnimationManager.StopConstructionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_METAL);
            ConstructionAnimationManager.PlayConstuctionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_RESSTORECENTER);
         }
         else
         {
            ConstructionAnimationManager.PlayConstuctionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_METAL);
         }
         if(_loc7_)
         {
            ConstructionAnimationManager.PlayConstuctionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_SHIPBUILDING);
         }
      }
      
      private function ClearConstruction(param1:Equiment) : void
      {
         if(param1.State == ConstructionState.STATE_BUILING || param1.State == ConstructionState.STATE_UPDATE)
         {
            ProgressToolBarManager.getInstance().clearProgress(param1);
            ProgressListToolBarWidget.getInstance().Destory(param1);
         }
         if(param1.parent)
         {
            param1.parent.removeChild(param1);
            param1.Release();
         }
      }
      
      public function clearGalaxyMapConstructionList() : void
      {
         var _loc1_:Equiment = null;
         ObjectUtil.ClearArray(ConstructionMeomery.he3List);
         ObjectUtil.ClearArray(ConstructionMeomery.metalList);
         ObjectUtil.ClearArray(ConstructionMeomery.homeRegionList);
         ObjectUtil.ClearArray(ConstructionMeomery.resStorecenterList);
         ObjectUtil.ClearArray(ConstructionMeomery.techResearchList);
         for each(_loc1_ in constuctionList.Values())
         {
            this.ClearConstruction(_loc1_);
         }
         for each(_loc1_ in outSideContuctionList.Values())
         {
            this.ClearConstruction(_loc1_);
         }
         constuctionList.removeAll();
         outSideContuctionList.removeAll();
         ObjectUtil.ClearArray(BuildingList);
         ProgressListToolBarWidget.getInstance().ClearAllProgressIso();
         ProgressInFriendToolBarWidget.getInstance().RemoveAllIosInFriend();
      }
      
      private function onTick(param1:TimerEvent) : void
      {
         if(GamePlayer.getInstance().ResStorageGas == 0 || GamePlayer.getInstance().ResStorageMetal == 0 || GamePlayer.getInstance().ResStorageMoney == 0)
         {
            this.sendStorageResource();
            return;
         }
         if(GamePlayer.getInstance().ResGas >= GamePlayer.getInstance().ResStorageGas || GamePlayer.getInstance().ResMetal >= GamePlayer.getInstance().ResStorageMetal || GamePlayer.getInstance().ResMoney >= GamePlayer.getInstance().ResStorageMoney)
         {
            if(GamePlayer.getInstance().ResGas >= GamePlayer.getInstance().ResStorageGas)
            {
               ConstructionAnimationManager.StopConstructionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_HELIUM_3);
            }
            if(GamePlayer.getInstance().ResMetal >= GamePlayer.getInstance().ResStorageMetal)
            {
               ConstructionAnimationManager.StopConstructionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_METAL);
            }
            ConstructionAnimationManager.PlayConstuctionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_RESSTORECENTER);
            this.stopResourceStorageCount();
         }
         else
         {
            ConstructionAnimationManager.PlayConstuctionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_HELIUM_3);
            ConstructionAnimationManager.PlayConstuctionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_METAL);
            this.sendStorageResource();
         }
      }
      
      public function setStorageActiveState() : void
      {
         if(GamePlayer.getInstance().ResGas >= GamePlayer.getInstance().ResStorageGas || GamePlayer.getInstance().ResMetal >= GamePlayer.getInstance().ResStorageMetal || GamePlayer.getInstance().ResMoney >= GamePlayer.getInstance().ResStorageMoney)
         {
            if(GamePlayer.getInstance().ResGas >= GamePlayer.getInstance().ResStorageGas)
            {
               ConstructionAnimationManager.StopConstructionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_HELIUM_3);
            }
            if(GamePlayer.getInstance().ResMetal >= GamePlayer.getInstance().ResStorageMetal)
            {
               ConstructionAnimationManager.StopConstructionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_METAL);
            }
            ConstructionAnimationManager.PlayConstuctionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_RESSTORECENTER);
            this.stopResourceStorageCount();
         }
         else
         {
            ConstructionAnimationManager.PlayConstuctionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_HELIUM_3);
            ConstructionAnimationManager.PlayConstuctionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_METAL);
            this.startResourceStorageCount();
         }
      }
      
      public function startResourceStorageCount() : void
      {
         if(this.activeTime.running)
         {
            return;
         }
         this.activeTime.start();
      }
      
      public function stopResourceStorageCount() : void
      {
         if(this.activeTime.running)
         {
            this.activeTime.stop();
         }
      }
   }
}

