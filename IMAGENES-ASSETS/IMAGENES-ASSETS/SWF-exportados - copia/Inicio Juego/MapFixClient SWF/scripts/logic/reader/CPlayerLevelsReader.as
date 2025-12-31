package logic.reader
{
   import com.star.frameworks.managers.ResManager;
   import logic.entry.PlayLevel;
   import logic.game.GameKernel;
   
   public class CPlayerLevelsReader
   {
      
      private static var instance:CPlayerLevelsReader;
      
      private var _xmlList:XMLList;
      
      public function CPlayerLevelsReader()
      {
         super();
         this._xmlList = GameKernel.resManager.getXml(ResManager.GAMERES,"Levels").* as XMLList;
      }
      
      public static function getInstance() : CPlayerLevelsReader
      {
         if(instance == null)
         {
            instance = new CPlayerLevelsReader();
         }
         return instance;
      }
      
      public function Read(param1:int = 0) : PlayLevel
      {
         var _loc2_:Object = new Object();
         var _loc3_:PlayLevel = new PlayLevel();
         _loc3_.level = this._xmlList[param1].@Level;
         _loc3_.Exp = this._xmlList[param1].@Exp;
         _loc3_.Comments = this._xmlList[param1].@Comments;
         _loc3_.CommanderNum = this._xmlList[param1].@commandernum;
         return _loc3_;
      }
   }
}

