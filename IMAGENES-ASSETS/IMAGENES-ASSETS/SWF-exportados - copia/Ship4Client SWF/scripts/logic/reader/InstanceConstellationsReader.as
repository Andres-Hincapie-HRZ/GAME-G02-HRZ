package logic.reader
{
   import com.star.frameworks.managers.ResManager;
   import com.star.frameworks.utils.HashSet;
   import logic.game.GameKernel;
   
   public class InstanceConstellationsReader
   {
      
      private static var instance:InstanceConstellationsReader;
      
      private var ConstellationsList:HashSet;
      
      public function InstanceConstellationsReader()
      {
         var _loc2_:XML = null;
         var _loc3_:int = 0;
         super();
         this.ConstellationsList = new HashSet();
         var _loc1_:XML = GameKernel.resManager.getXml(ResManager.GAMERES,"InstanceConstellations");
         for each(_loc2_ in _loc1_.Constellations)
         {
            _loc3_ = int(_loc2_.@ConstellationsID);
            this.ConstellationsList.Put(_loc3_,_loc2_);
         }
      }
      
      public static function getInstance() : InstanceConstellationsReader
      {
         if(instance == null)
         {
            instance = new InstanceConstellationsReader();
         }
         return instance;
      }
      
      public function GetConstellationsInfo(param1:int) : XML
      {
         return this.ConstellationsList.Get(param1);
      }
      
      public function GetStarInfo(param1:int, param2:int) : XML
      {
         var _loc4_:XML = null;
         var _loc3_:XML = this.ConstellationsList.Get(param1);
         for each(_loc4_ in _loc3_.*)
         {
            if(_loc4_.@ID == param2)
            {
               return _loc4_;
            }
         }
         return null;
      }
      
      public function GetStarInfoByEctypeId(param1:int) : XML
      {
         var _loc3_:XML = null;
         var _loc4_:XML = null;
         var _loc2_:XML = GameKernel.resManager.getXml(ResManager.GAMERES,"InstanceConstellations");
         for each(_loc3_ in _loc2_.Constellations)
         {
            for each(_loc4_ in _loc3_.*)
            {
               if(_loc4_.@EctypeID == param1)
               {
                  return _loc4_;
               }
            }
         }
         return null;
      }
   }
}

