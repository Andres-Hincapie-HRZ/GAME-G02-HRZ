package logic.entry
{
   import logic.game.GameSetting;
   
   public class ConstructionDataCache
   {
      
      private static var instance:ConstructionDataCache;
      
      public var CachePool:Array;
      
      public function ConstructionDataCache()
      {
         super();
         this.CachePool = new Array();
         var _loc1_:int = 0;
         while(_loc1_ < GameSetting.CONSTRUCTION_TYPE)
         {
            this.CachePool[_loc1_] = new Array();
            _loc1_++;
         }
      }
      
      public static function getInstance() : ConstructionDataCache
      {
         if(instance == null)
         {
            instance = new ConstructionDataCache();
         }
         return instance;
      }
   }
}

