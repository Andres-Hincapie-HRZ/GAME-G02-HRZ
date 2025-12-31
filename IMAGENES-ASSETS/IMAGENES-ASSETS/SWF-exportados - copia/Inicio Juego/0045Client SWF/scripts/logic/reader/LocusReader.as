package logic.reader
{
   import com.star.frameworks.managers.ResManager;
   import logic.game.GameKernel;
   
   public class LocusReader
   {
      
      private static var instance:LocusReader;
      
      public var LocusCount:int;
      
      private var _xmlList:XMLList;
      
      public function LocusReader()
      {
         super();
         var _loc1_:XML = GameKernel.resManager.getXml(ResManager.GAMERES,"StageMode");
         this._xmlList = _loc1_.* as XMLList;
         this.LocusCount = this._xmlList.length();
      }
      
      public static function getInstance() : LocusReader
      {
         if(instance == null)
         {
            instance = new LocusReader();
         }
         return instance;
      }
      
      public function GetLocusInfoById(param1:int) : XML
      {
         var _loc2_:XML = null;
         for each(_loc2_ in this._xmlList)
         {
            if(_loc2_.@EctypeID == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function GetLocusInfo(param1:int) : XML
      {
         return this._xmlList[param1] as XML;
      }
   }
}

