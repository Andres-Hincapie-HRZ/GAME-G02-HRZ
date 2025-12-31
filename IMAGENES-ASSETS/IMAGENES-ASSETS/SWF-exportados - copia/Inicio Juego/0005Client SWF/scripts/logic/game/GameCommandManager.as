package logic.game
{
   import logic.ui.TaskSceneUI;
   
   public class GameCommandManager
   {
      
      private static var instance:GameCommandManager;
      
      private static var index:int = 0;
      
      public static const CMD_CONSTRUCTION:int = index++;
      
      public static const CMD_BUILDING:int = index++;
      
      public static const CMD_OTHER:int = index++;
      
      public static const CMD_PACKAGE:int = index++;
      
      public static const CMD_MILITARY:int = index++;
      
      public static const CMD_DESIGNBLURPRINT:int = index++;
      
      public static const CMD_BUILDSHIP:int = index++;
      
      public static const CMD_COMMANDER:int = index++;
      
      public static const CMD_CREATESHIPTEAM:int = index++;
      
      public static const CMD_SPACESTATION:int = index++;
      
      public static const CMD_ALTERNATION:int = index++;
      
      public static const CMD_RANK:int = index++;
      
      public function GameCommandManager()
      {
         super();
      }
      
      public static function getInstance() : GameCommandManager
      {
         if(instance == null)
         {
            instance = new GameCommandManager();
         }
         return instance;
      }
      
      private function closeTaskUI() : void
      {
         TaskSceneUI.getInstance().IsShow = false;
         GameKernel.popUpDisplayManager.Hide(TaskSceneUI.getInstance());
      }
      
      public function Execute(param1:int = 1) : void
      {
         this.closeTaskUI();
         switch(param1)
         {
            case 1:
               GameMouseZoneManager.NagivateToolBarByName("mc_construct",false);
               break;
            case 2:
               GameMouseZoneManager.NagivateToolBarByName("btn_build",false);
               break;
            case 3:
               GameMouseZoneManager.NagivateToolBarByName("mc_mall",false);
               break;
            case 4:
               GameMouseZoneManager.NagivateToolBarByName("btn_storage",false);
               break;
            case 5:
               GameMouseZoneManager.NagivateToolBarByName("mc_military",false);
               break;
            case 6:
               GameMouseZoneManager.NagivateToolBarByName("btn_printdesign",false);
               break;
            case 7:
               GameMouseZoneManager.NagivateToolBarByName("btn_boatyard",false);
               break;
            case 8:
               GameMouseZoneManager.NagivateToolBarByName("btn_commander",false);
               break;
            case 9:
               GameMouseZoneManager.NagivateToolBarByName("btn_foundfleet",false);
               break;
            case 10:
               GameMouseZoneManager.NagivateToolBarByName("btn_galaxy",false);
               break;
            case 11:
               GameMouseZoneManager.NagivateToolBarByName("mc_alternation",false);
               break;
            case 12:
               this.closeTaskUI();
               GameMouseZoneManager.NagivateToolBarByName("btn_ranking",false);
               break;
            case 13:
               this.closeTaskUI();
               GameMouseZoneManager.NagivateToolBarByName("btn_unload",false);
         }
      }
   }
}

