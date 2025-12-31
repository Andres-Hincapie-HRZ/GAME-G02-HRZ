package logic.manager
{
   import com.star.frameworks.geom.CFilter;
   import com.star.frameworks.utils.HashSet;
   import logic.entry.ConstructionState;
   import logic.entry.Equiment;
   
   public class ConstructionRepairManager
   {
      
      public static var repairList:HashSet = new HashSet();
      
      public function ConstructionRepairManager()
      {
         super();
      }
      
      public static function showRepairBar(param1:Equiment) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.State = ConstructionState.STATE_REPAIR;
         if(FightSectionManager.fightingFlag)
         {
            setRepairState(param1,true);
         }
         else
         {
            setRepairState(param1,false);
         }
      }
      
      public static function hideRepairBar(param1:Equiment) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.State = ConstructionState.STATE_COMPLETE;
         setRepairState(param1,false);
      }
      
      public static function setRepairState(param1:Equiment, param2:Boolean = true) : void
      {
         var _loc3_:CFilter = null;
         if(param2)
         {
            if(param1.filters.length == 0)
            {
               _loc3_ = new CFilter();
               _loc3_.generate_colorMatrix_filter();
               param1.filters = _loc3_.getFilter(true);
            }
            return;
         }
         param1.filters = null;
      }
   }
}

