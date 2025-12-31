package logic.reader
{
   import com.star.frameworks.managers.ResManager;
   import logic.entry.StarLevelEntry;
   import logic.game.GameKernel;
   
   public class StarLevelReader
   {
      
      private static var instance:StarLevelReader;
      
      private var _starName:String;
      
      private var _xmlList:XMLList;
      
      public function StarLevelReader()
      {
         super();
         var _loc1_:XML = GameKernel.resManager.getXml(ResManager.GAMERES,"StarLevel");
         this._starName = _loc1_.@Name;
         this._xmlList = _loc1_.* as XMLList;
      }
      
      public static function getInstance() : StarLevelReader
      {
         if(instance == null)
         {
            instance = new StarLevelReader();
         }
         return instance;
      }
      
      public function Read(param1:int = 0) : StarLevelEntry
      {
         var _loc2_:XML = this._xmlList[param1] as XML;
         if(_loc2_ == null)
         {
            return new StarLevelEntry();
         }
         var _loc3_:StarLevelEntry = new StarLevelEntry();
         _loc3_.buildName = this._starName;
         _loc3_.level = _loc2_.@Level;
         _loc3_.shipNum = _loc2_.@ShipNum;
         _loc3_.affect = parseFloat(_loc2_.@Affect);
         _loc3_.needRiches = _loc2_.@NeedRiches;
         _loc3_.imageName = _loc2_.@ImageName;
         return _loc3_;
      }
   }
}

