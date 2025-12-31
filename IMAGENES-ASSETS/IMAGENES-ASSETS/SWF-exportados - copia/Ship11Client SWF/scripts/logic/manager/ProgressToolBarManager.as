package logic.manager
{
   import com.star.frameworks.utils.HashSet;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import logic.action.ConstructionAction;
   import logic.entry.Equiment;
   import logic.entry.GamePlaceType;
   import logic.game.GameStateManager;
   import logic.widget.ConprogressToolBar;
   import logic.widget.ProgressInFriendToolBarWidget;
   import logic.widget.ProgressListToolBarWidget;
   
   public class ProgressToolBarManager
   {
      
      private static var instance:ProgressToolBarManager;
      
      private var _currentNum:int;
      
      private var mTimer:Timer;
      
      public var toolBarList:HashSet;
      
      public function ProgressToolBarManager()
      {
         super();
         if(instance != null)
         {
            throw new Error("SingleTon");
         }
         this.toolBarList = new HashSet();
         this._currentNum = 0;
         this.mTimer = new Timer(1000);
         this.mTimer.addEventListener(TimerEvent.TIMER,this.onTick,false,0,true);
      }
      
      public static function getInstance() : ProgressToolBarManager
      {
         if(instance == null)
         {
            instance = new ProgressToolBarManager();
         }
         return instance;
      }
      
      public function startProgress() : void
      {
         this.mTimer.start();
      }
      
      public function stopProgress() : void
      {
         this.mTimer.stop();
      }
      
      public function get CurrentNum() : int
      {
         return this._currentNum;
      }
      
      public function set CurrentNum(param1:int) : void
      {
         this._currentNum = param1;
      }
      
      private function onTick(param1:TimerEvent) : void
      {
         this.DecreaseByOnBackStage();
         this.syncTime();
         if(ConstructionAction.BuildingList.length)
         {
            ProgressListToolBarWidget.getInstance().syncProgressItem();
         }
         if(ConstructionAction.repairBuildingList.length)
         {
            RepairProgressToolBarManager.getInstance().syncRepairProgressTime();
         }
         if(GameStateManager.playerPlace == GamePlaceType.PLACE_FRIENDHOME)
         {
            ProgressInFriendToolBarWidget.getInstance().syncProgressItem();
         }
      }
      
      private function DecreaseByOnBackStage() : void
      {
         var _loc1_:Equiment = null;
         if(ConstructionAction.BuildingList.length == 0)
         {
            return;
         }
         for each(_loc1_ in ConstructionAction.BuildingList)
         {
            --_loc1_.EquimentInfoData.needTime;
         }
      }
      
      public function clearProgress(param1:Equiment) : void
      {
         this.removeToolBar(this.toolBarList.Get(param1.EquimentInfoData.IndexId));
      }
      
      private function syncTime() : void
      {
         if(0 == ConstructionAction.BuildingList.length && 0 == ConstructionAction.repairBuildingList.length)
         {
            this.stopProgress();
         }
         this.syncConstructionTime();
      }
      
      public function SyncTime() : void
      {
         if(0 == ConstructionAction.BuildingList.length && 0 == ConstructionAction.repairBuildingList.length)
         {
            return;
         }
         if(!this.mTimer.running)
         {
            this.startProgress();
         }
      }
      
      public function getProgressIndex(param1:Equiment) : int
      {
         var _loc3_:Equiment = null;
         var _loc2_:int = 0;
         for each(_loc3_ in ConstructionAction.BuildingList)
         {
            if(param1 == _loc3_)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      public function pushUpgrate(param1:Equiment) : void
      {
         if(this.toolBarList.ContainsKey(param1.EquimentInfoData.IndexId))
         {
            return;
         }
         var _loc2_:ConprogressToolBar = new ConprogressToolBar(param1,param1.EquimentInfoData.needTime);
         this.toolBarList.Put(param1.EquimentInfoData.IndexId,_loc2_);
      }
      
      public function updateConstructionCostTime(param1:int) : void
      {
         if(this.toolBarList.ContainsKey(param1))
         {
            ConprogressToolBar(this.toolBarList.Get(param1)).setProgressState();
         }
      }
      
      private function syncConstructionTime() : void
      {
         var _loc2_:ConprogressToolBar = null;
         var _loc1_:Array = this.toolBarList.Values();
         for each(_loc2_ in _loc1_)
         {
            if(_loc2_.IsCompleted)
            {
               this.clearProgress(_loc2_.Parent);
            }
            else
            {
               _loc2_.setProcess();
            }
         }
      }
      
      private function removeToolBar(param1:ConprogressToolBar) : void
      {
         if(Boolean(param1) && Boolean(param1.Parent))
         {
            param1.setCompleteState();
            if(GameStateManager.playerPlace)
            {
               param1.Parent.getMC().filters = null;
            }
            this.toolBarList.Remove(param1.Parent.EquimentInfoData.IndexId);
            param1.Release();
            param1 = null;
            if(GameStateManager.playerPlace == GamePlaceType.PLACE_FRIENDHOME && Boolean(ConstructionAction.currentProgressIso))
            {
               ConstructionAction.currentProgressIso.Destory();
            }
         }
      }
   }
}

