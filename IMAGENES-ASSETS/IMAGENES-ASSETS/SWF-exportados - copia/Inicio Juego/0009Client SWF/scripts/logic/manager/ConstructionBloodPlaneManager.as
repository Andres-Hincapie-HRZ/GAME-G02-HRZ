package logic.manager
{
   import com.star.frameworks.utils.HashSet;
   import logic.action.ConstructionAction;
   import logic.entry.ConstructionBloodBar;
   import logic.entry.ConstructionState;
   import logic.entry.Equiment;
   
   public class ConstructionBloodPlaneManager
   {
      
      public static var bloodBarList:HashSet = new HashSet();
      
      public function ConstructionBloodPlaneManager()
      {
         super();
      }
      
      public static function showBloodPlaneAll() : void
      {
         var _loc2_:Equiment = null;
         if(0 == ConstructionAction.outSideContuctionList.Length())
         {
            return;
         }
         var _loc1_:Array = ConstructionAction.outSideContuctionList.Values();
         for each(_loc2_ in _loc1_)
         {
            showBloodPlane(_loc2_);
         }
      }
      
      public static function showBloodPlane(param1:Equiment) : void
      {
         var _loc2_:ConstructionBloodBar = null;
         if(param1 == null)
         {
            return;
         }
         if(param1.State == ConstructionState.STATE_BUILING || param1.State == ConstructionState.STATE_UPDATE || param1.State == ConstructionState.STATE_REPAIR)
         {
            return;
         }
         if(!bloodBarList.ContainsKey(param1.EquimentInfoData.IndexId))
         {
            _loc2_ = new ConstructionBloodBar(param1);
            bloodBarList.Put(param1.EquimentInfoData.IndexId,_loc2_);
         }
         else
         {
            _loc2_ = bloodBarList.Get(param1.EquimentInfoData.IndexId);
         }
         if(!param1.contains(_loc2_.BloorBar))
         {
            param1.addChild(_loc2_.BloorBar);
         }
      }
      
      public static function repaint(param1:Equiment, param2:int) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc3_:ConstructionBloodBar = bloodBarList.Get(param1.EquimentInfoData.IndexId);
         if(!_loc3_)
         {
            _loc3_ = new ConstructionBloodBar(param1);
         }
         _loc3_.rePaint(param2);
      }
      
      public static function removeBloodPlane(param1:Equiment) : void
      {
         hideBloodPlane(param1);
         var _loc2_:ConstructionBloodBar = bloodBarList.Get(param1.EquimentInfoData.IndexId);
         _loc2_.Destory();
         bloodBarList.Remove(param1.EquimentInfoData.IndexId);
         _loc2_ = null;
      }
      
      public static function hideBloodPlaneAll() : void
      {
         var _loc2_:Equiment = null;
         if(0 == ConstructionAction.outSideContuctionList.Length())
         {
            return;
         }
         var _loc1_:Array = ConstructionAction.outSideContuctionList.Values();
         for each(_loc2_ in _loc1_)
         {
            hideBloodPlane(_loc2_);
         }
      }
      
      public static function hideBloodPlane(param1:Equiment) : void
      {
         var _loc2_:ConstructionBloodBar = null;
         if(param1 == null)
         {
            return;
         }
         if(0 == bloodBarList.Length())
         {
            return;
         }
         if(bloodBarList.ContainsKey(param1.EquimentInfoData.IndexId))
         {
            _loc2_ = bloodBarList.Get(param1.EquimentInfoData.IndexId) as ConstructionBloodBar;
            if(param1.contains(_loc2_.BloorBar))
            {
               param1.removeChild(_loc2_.BloorBar);
            }
            bloodBarList.Remove(param1.EquimentInfoData.IndexId);
         }
      }
   }
}

