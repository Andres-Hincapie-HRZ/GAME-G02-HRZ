package logic.event
{
   import flash.events.Event;
   
   public class ModuleActionEvent extends Event
   {
      
      public static const Module_INIT:String = "module_init";
      
      public var moduleName:String;
      
      public function ModuleActionEvent(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false)
      {
         super(param2,param3,param4);
         this.moduleName = param1;
      }
      
      override public function clone() : Event
      {
         return new ModuleActionEvent(this.moduleName,type,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return "ModuleActionEvent";
      }
   }
}

