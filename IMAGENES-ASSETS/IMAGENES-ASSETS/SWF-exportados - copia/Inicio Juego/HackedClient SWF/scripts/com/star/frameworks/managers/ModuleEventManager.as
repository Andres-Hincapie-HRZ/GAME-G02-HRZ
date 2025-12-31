package com.star.frameworks.managers
{
   import flash.events.EventDispatcher;
   
   public class ModuleEventManager extends EventDispatcher
   {
      
      private static var instance:ModuleEventManager = null;
      
      public var isCompleted:Boolean = false;
      
      public function ModuleEventManager()
      {
         super();
      }
      
      public static function getInstance() : ModuleEventManager
      {
         if(instance == null)
         {
            instance = new ModuleEventManager();
         }
         return instance;
      }
   }
}

