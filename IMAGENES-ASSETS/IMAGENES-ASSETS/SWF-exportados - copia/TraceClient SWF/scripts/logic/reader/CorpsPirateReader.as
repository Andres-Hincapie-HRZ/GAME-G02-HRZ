package logic.reader
{
   import com.star.frameworks.managers.ResManager;
   import logic.game.GameKernel;
   
   public class CorpsPirateReader
   {
      
      public function CorpsPirateReader()
      {
         super();
      }
      
      public static function GetPirateInfo(param1:int) : XML
      {
         var _loc2_:XML = GameKernel.resManager.getXml(ResManager.GAMERES,"CorpsPirate");
         var _loc3_:XMLList = _loc2_.* as XMLList;
         return _loc3_[param1] as XML;
      }
   }
}

