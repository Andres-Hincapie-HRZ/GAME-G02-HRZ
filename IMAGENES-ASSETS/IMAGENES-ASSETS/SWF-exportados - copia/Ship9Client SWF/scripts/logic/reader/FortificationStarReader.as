package logic.reader
{
   import com.star.frameworks.managers.ResManager;
   import logic.entry.FortificationStar;
   import logic.game.GameKernel;
   
   public class FortificationStarReader
   {
      
      private static var instance:FortificationStarReader;
      
      private var _startID:int;
      
      private var _starName:String;
      
      private var _xmlList:XMLList;
      
      public function FortificationStarReader()
      {
         super();
         var _loc1_:XML = GameKernel.resManager.getXml(ResManager.GAMERES,"FortificationStar");
         this._starName = _loc1_.@Name;
         this._startID = _loc1_.@Start;
         this._xmlList = _loc1_.* as XMLList;
      }
      
      public static function getInstance() : FortificationStarReader
      {
         if(instance == null)
         {
            instance = new FortificationStarReader();
         }
         return instance;
      }
      
      public function Read(param1:int = 0, param2:int = 0) : FortificationStar
      {
         var _loc4_:FortificationStar = null;
         var _loc3_:XML = this._xmlList[param1 - this._startID] as XML;
         if(_loc3_ == null)
         {
            return new FortificationStar();
         }
         _loc4_ = new FortificationStar();
         _loc4_.BuildingID = _loc3_.@BuildingID;
         _loc4_.BuildingName = _loc3_.@BuildingName;
         _loc4_.Comment1 = _loc3_.@Comment1;
         _loc4_.MaxLevel = _loc3_.@MaxLevel;
         var _loc5_:int = Math.max(0,param2);
         var _loc6_:XML = _loc3_.*[_loc5_] as XML;
         if(_loc5_ >= _loc4_.MaxLevel)
         {
            return _loc4_;
         }
         _loc4_.LevelID = _loc6_.@LevelID;
         _loc4_.Defend = _loc6_.@Defend;
         _loc4_.DefendType = _loc6_.@DefendType;
         _loc4_.Endure = _loc6_.@Endure;
         _loc4_.Range = _loc6_.@Range;
         _loc4_.BackFill = _loc6_.@BackFill;
         _loc4_.Fly = _loc6_.@Fly;
         _loc4_.ImageName = _loc6_.@ImageName;
         _loc4_.LevelComment = _loc6_.@LevelComment;
         _loc4_.Wealth = _loc6_.@Wealth;
         _loc4_.InteractiveBoxType = _loc6_.@InteractiveBoxType;
         return _loc4_;
      }
   }
}

