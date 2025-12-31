package logic.game
{
   import com.star.frameworks.utils.HashSet;
   import logic.action.ConstructionAction;
   import logic.entry.Equiment;
   import logic.entry.EquimentTypeEnum;
   
   public class GameStatisticsManager
   {
      
      private static var instance:GameStatisticsManager;
      
      private var record:HashSet;
      
      public function GameStatisticsManager()
      {
         super();
         this.record = new HashSet();
      }
      
      public static function getInstance() : GameStatisticsManager
      {
         if(instance == null)
         {
            instance = new GameStatisticsManager();
         }
         return instance;
      }
      
      public function UnBuildAbleRecord(param1:String, param2:Object) : void
      {
         this.record.Put(param1,param2);
      }
      
      public function getMetalResourceOutCount() : int
      {
         var _loc2_:int = 0;
         var _loc3_:Equiment = null;
         var _loc1_:Array = ConstructionAction.constuctionList.Values();
         if(_loc1_.length == 0)
         {
            return 0;
         }
         for each(_loc3_ in _loc1_)
         {
            if(_loc3_.EquimentInfoData.BuildID == EquimentTypeEnum.EQUIMENT_TYPE_METAL)
            {
               _loc2_ += _loc3_.BlurPrint.equimentLevel.OutMetal;
            }
         }
         return _loc2_;
      }
      
      public function getMoneyResourceOutCount() : int
      {
         var _loc2_:int = 0;
         var _loc3_:Equiment = null;
         var _loc1_:Array = ConstructionAction.constuctionList.Values();
         if(_loc1_.length == 0)
         {
            return 0;
         }
         for each(_loc3_ in _loc1_)
         {
            if(_loc3_.EquimentInfoData.BuildID == EquimentTypeEnum.EQUIMENT_TYPE_HOMEREGION)
            {
               _loc2_ += _loc3_.BlurPrint.equimentLevel.OutMoney;
            }
         }
         return _loc2_;
      }
      
      public function getHe3ResourceOutCount() : int
      {
         var _loc2_:int = 0;
         var _loc3_:Equiment = null;
         var _loc1_:Array = ConstructionAction.constuctionList.Values();
         if(_loc1_.length == 0)
         {
            return 0;
         }
         for each(_loc3_ in _loc1_)
         {
            if(_loc3_.EquimentInfoData.BuildID == EquimentTypeEnum.EQUIMENT_TYPE_HELIUM_3)
            {
               _loc2_ += _loc3_.BlurPrint.equimentLevel.OutHelium_3;
            }
         }
         return _loc2_;
      }
      
      public function get Record() : HashSet
      {
         return this.record;
      }
   }
}

