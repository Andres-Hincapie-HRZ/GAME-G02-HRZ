package com.star.frameworks.events
{
   import com.star.frameworks.utils.HashSet;
   import flash.events.Event;
   
   public class ModuleEvent extends Event
   {
      
      public static const MODULE_INIT:String = "ModuleInit";
      
      public static const RES_LOADED:String = "ResLoaded";
      
      public static const LOGIN_RELEASE:String = "LoginRelease";
      
      public static const LOGIN_STAGE:String = "LoginStage";
      
      public static const MAIN_STAGE:String = "MainStage";
      
      public static const MAP_STAGE:String = "MapStage";
      
      public var resLib:HashSet;
      
      public var flashVar:Object;
      
      public var pathObj:Object;
      
      public function ModuleEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
      }
      
      override public function clone() : Event
      {
         return new ModuleEvent(type,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return "ModuleEvent";
      }
   }
}

