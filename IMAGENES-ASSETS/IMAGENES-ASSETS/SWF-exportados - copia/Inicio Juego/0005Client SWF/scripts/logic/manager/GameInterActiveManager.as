package logic.manager
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import logic.entry.MObject;
   
   public class GameInterActiveManager
   {
      
      public function GameInterActiveManager()
      {
         super();
      }
      
      public static function InstallInterActiveEvent(param1:Object, param2:String, param3:Function) : void
      {
         if(param1)
         {
            if(param1 is MObject)
            {
               MObject(param1).buttonMode = true;
            }
            else if(param1 is MovieClip)
            {
               MovieClip(param1).buttonMode = true;
            }
            param1.addEventListener(param2,param3);
         }
      }
      
      public static function HasInterActiveEvent(param1:DisplayObject, param2:String) : Boolean
      {
         if(param1)
         {
            return param1.hasEventListener(param2);
         }
         return false;
      }
      
      public static function unInstallnterActiveEvent(param1:DisplayObject, param2:String, param3:Function) : void
      {
         if(param1)
         {
            param1.removeEventListener(param2,param3);
         }
      }
   }
}

