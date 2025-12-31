package logic.game
{
   import logic.entry.ScienceSystem;
   
   public class GameLogic
   {
      
      private static var instance:GameLogic;
      
      public function GameLogic()
      {
         super();
      }
      
      public static function getInstance() : GameLogic
      {
         if(instance == null)
         {
            instance = new GameLogic();
         }
         return instance;
      }
      
      public function initGameProfile() : void
      {
         ScienceSystem.getinstance().initXML();
      }
   }
}

