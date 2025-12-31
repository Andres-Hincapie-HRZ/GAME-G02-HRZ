package logic.manager
{
   import com.star.frameworks.geom.CFilter;
   import com.star.frameworks.utils.HashSet;
   import logic.action.ConstructionAction;
   import logic.entry.ConstructionRepairBar;
   import logic.entry.Equiment;
   
   public class RepairProgressToolBarManager
   {
      
      private static var instance:RepairProgressToolBarManager;
      
      public var toolBarList:HashSet;
      
      public function RepairProgressToolBarManager()
      {
         super();
         if(instance != null)
         {
            throw new Error("SingleTon");
         }
         this.toolBarList = new HashSet();
      }
      
      public static function getInstance() : RepairProgressToolBarManager
      {
         if(instance == null)
         {
            instance = new RepairProgressToolBarManager();
         }
         return instance;
      }
      
      public function pushUpgrate(param1:Equiment) : void
      {
         var _loc2_:ConstructionRepairBar = null;
         var _loc3_:CFilter = null;
         if(!this.toolBarList.ContainsKey(param1.EquimentInfoData.IndexId))
         {
            _loc2_ = new ConstructionRepairBar(param1);
            this.toolBarList.Put(param1.EquimentInfoData.IndexId,_loc2_);
         }
         else
         {
            _loc2_ = this.toolBarList.Get(param1.EquimentInfoData.IndexId) as ConstructionRepairBar;
         }
         if(param1.filters.length == 0)
         {
            _loc3_ = new CFilter();
            _loc3_.generate_colorMatrix_filter();
            param1.filters = _loc3_.getFilter(true);
         }
      }
      
      public function syncRepairProgressTime() : void
      {
         var _loc2_:ConstructionRepairBar = null;
         if(0 == this.toolBarList.Length())
         {
            return;
         }
         var _loc1_:Array = this.toolBarList.Values();
         for each(_loc2_ in _loc1_)
         {
            if(!_loc2_.IsCompleted)
            {
               _loc2_.setProcess();
            }
         }
      }
      
      public function getProgressIndex(param1:Equiment) : int
      {
         var _loc3_:Equiment = null;
         var _loc2_:int = 0;
         for each(_loc3_ in ConstructionAction.repairBuildingList)
         {
            if(param1 == _loc3_)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      public function clearProgress(param1:Equiment) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:int = this.getProgressIndex(param1);
         this.removeToolBar(this.toolBarList.Get(param1.EquimentInfoData.IndexId));
      }
      
      private function removeToolBar(param1:ConstructionRepairBar) : void
      {
         if(Boolean(param1) && Boolean(param1.Construction))
         {
            this.toolBarList.Remove(param1.Construction.EquimentInfoData.IndexId);
            param1.Construction = null;
            param1 = null;
         }
      }
      
      public function showRepairBar(param1:ConstructionRepairBar) : void
      {
      }
      
      public function showRepairBarAll() : void
      {
         var _loc2_:ConstructionRepairBar = null;
         if(this.toolBarList.Length() == 0)
         {
            return;
         }
         var _loc1_:Array = this.toolBarList.Values();
         for each(_loc2_ in _loc1_)
         {
            this.showRepairBar(_loc2_);
         }
      }
      
      public function hideRepairBar(param1:ConstructionRepairBar) : void
      {
      }
      
      public function hideRepairBarAll() : void
      {
         var _loc2_:ConstructionRepairBar = null;
      }
   }
}

