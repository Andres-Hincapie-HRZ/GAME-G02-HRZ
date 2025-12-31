package logic.reader
{
   import com.star.frameworks.managers.ResManager;
   import logic.game.GameKernel;
   
   public class CcorpsReader
   {
      
      private static var instance:CcorpsReader;
      
      public function CcorpsReader()
      {
         super();
      }
      
      public static function getInstance() : CcorpsReader
      {
         if(instance == null)
         {
            instance = new CcorpsReader();
         }
         return instance;
      }
      
      public function GetCorpsUpgradeInfo(param1:int) : XML
      {
         return this.GetUpgradeInfo(0,param1);
      }
      
      public function GetStorageUpgradeInfo(param1:int) : XML
      {
         return this.GetUpgradeInfo(1,param1);
      }
      
      public function GetComposeUpgradeInfo(param1:int) : XML
      {
         return this.GetUpgradeInfo(2,param1);
      }
      
      public function GetShopUpgradeInfo(param1:int) : XML
      {
         return this.GetUpgradeInfo(3,param1);
      }
      
      private function GetUpgradeInfo(param1:int, param2:int) : XML
      {
         if(param2 < 0)
         {
            return null;
         }
         var _loc3_:XML = GameKernel.resManager.getXml(ResManager.GAMERES,"Corps");
         var _loc4_:XML = _loc3_.List[param1];
         var _loc5_:XMLList = _loc4_.children();
         if(param2 >= _loc5_.length())
         {
            return null;
         }
         return _loc5_[param2];
      }
   }
}

