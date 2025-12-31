package logic.manager
{
   import flash.events.EventDispatcher;
   import logic.action.ActionModuleDefined;
   import logic.action.ChatAction;
   import logic.action.ConstructionAction;
   import logic.action.GalaxyMapAction;
   import logic.action.OutSideGalaxiasAction;
   import logic.action.StarMapAction;
   import logic.action.StarSurfaceAction;
   import logic.impl.IAbstractAction;
   
   public final class GameModuleActionManager extends EventDispatcher
   {
      
      private static var _actionImpl:IAbstractAction;
      
      public function GameModuleActionManager()
      {
         super();
      }
      
      public static function getModuleInstance(param1:String) : IAbstractAction
      {
         switch(param1)
         {
            case ActionModuleDefined.StarSurface_action:
               _actionImpl = StarSurfaceAction.getInstance();
               break;
            case ActionModuleDefined.Construction_action:
               _actionImpl = ConstructionAction.getInstance();
               break;
            case ActionModuleDefined.GalaxyMap_action:
               _actionImpl = GalaxyMapAction.instance;
               break;
            case ActionModuleDefined.StarMap_action:
               _actionImpl = StarMapAction.instance;
               break;
            case ActionModuleDefined.OutSideGalaxias_Action:
               _actionImpl = OutSideGalaxiasAction.getInstance();
               break;
            case ActionModuleDefined.Chat_action:
               _actionImpl = ChatAction.getInstance();
         }
         return _actionImpl;
      }
   }
}

