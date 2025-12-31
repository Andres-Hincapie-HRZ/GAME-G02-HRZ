package logic.manager
{
   import com.star.frameworks.display.Container;
   import logic.game.GameKernel;
   import logic.impl.IAbstractAction;
   
   public class GameScreenManager
   {
      
      private static var instance:GameScreenManager;
      
      private var _currentScreen:Container;
      
      public function GameScreenManager()
      {
         super();
      }
      
      public static function getInstance() : GameScreenManager
      {
         if(instance == null)
         {
            instance = new GameScreenManager();
         }
         return instance;
      }
      
      public function get CurrentScreen() : Container
      {
         return this._currentScreen;
      }
      
      public function set CurrentScreen(param1:Container) : void
      {
         this._currentScreen = this._currentScreen;
      }
      
      public function ShowScreen(param1:IAbstractAction) : void
      {
         var _loc2_:int = GameKernel.renderManager.getMap().getContainer().numChildren;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            GameKernel.renderManager.getMap().getContainer().removeChildAt(0);
            _loc3_++;
         }
         var _loc4_:Container = param1.getUI();
         GameKernel.renderManager.getMap().getContainer().addChild(_loc4_);
      }
   }
}

