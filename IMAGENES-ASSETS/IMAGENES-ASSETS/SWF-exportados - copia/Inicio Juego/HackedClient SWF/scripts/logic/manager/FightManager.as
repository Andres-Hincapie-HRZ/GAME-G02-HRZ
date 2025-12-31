package logic.manager
{
   import logic.action.ConstructionAction;
   import logic.action.OutSideGalaxiasAction;
   
   public class FightManager
   {
      
      private static var _instance:FightManager = null;
      
      public function FightManager(param1:HHH)
      {
         super();
      }
      
      public static function get instance() : FightManager
      {
         if(_instance == null)
         {
            _instance = new FightManager(new HHH());
         }
         return _instance;
      }
      
      public function CleanFight() : void
      {
         FightSectionManager.instance.releaseFightSection();
         GalaxyShipManager.instance.releaseShipTeam();
         ConstructionBloodPlaneManager.hideBloodPlaneAll();
         ConstructionAction.getInstance().clearGalaxyMapConstructionList();
         if(OutSideGalaxiasAction.getInstance().BoutVisible)
         {
            OutSideGalaxiasAction.getInstance().BoutVisible = false;
         }
      }
   }
}

class HHH
{
   
   public function HHH()
   {
      super();
   }
}
