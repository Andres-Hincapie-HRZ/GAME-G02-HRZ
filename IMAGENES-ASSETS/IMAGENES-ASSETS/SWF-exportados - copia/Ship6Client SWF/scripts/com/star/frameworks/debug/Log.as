package com.star.frameworks.debug
{
   import flash.external.ExternalInterface;
   import flash.system.System;
   
   public class Log
   {
      
      public static var useTrace:Boolean = true;
      
      private static var logStr:String = "";
      
      public static var LogEnable:Boolean = true;
      
      public function Log()
      {
         super();
      }
      
      public static function logOut(param1:String) : void
      {
         logStr += param1;
         logStr += "\n";
         if(useTrace)
         {
         }
         if(logStr.length > 102400)
         {
            return;
         }
      }
      
      public static function logSave(param1:String) : void
      {
         System.setClipboard(logStr);
      }
      
      public static function SaveLog(param1:int) : void
      {
         var LogId:int = param1;
         if(LogEnable == false)
         {
            return;
         }
         try
         {
            ExternalInterface.call("TrackLog.write",LogId,"");
         }
         catch(e:*)
         {
         }
      }
   }
}

