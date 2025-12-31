package com.star.frameworks.events
{
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   
   public class LoaderEvent extends Event
   {
      
      public static const INIT:String = Event.INIT;
      
      public static const ERROR:String = IOErrorEvent.IO_ERROR;
      
      public static const OPEN:String = Event.OPEN;
      
      public static const PROGRESS:String = ProgressEvent.PROGRESS;
      
      public static const COMPLETE:String = Event.COMPLETE;
      
      public static const COMPLETE_ALL:String = "all_completed";
      
      public static const ITEM_COMPLETED:String = "item_completed";
      
      public static const SECURITY_ERROR:String = SecurityErrorEvent.SECURITY_ERROR;
      
      public static const HTTP_STATUSEVENT:String = HTTPStatusEvent.HTTP_STATUS;
      
      public var res:* = null;
      
      public var path:String = "";
      
      public var percentStr:String = "";
      
      public var currentByte:Number = 0;
      
      public var totalBytes:Number = 0;
      
      public var info:LoaderInfo = null;
      
      public function LoaderEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new LoaderEvent(type,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return "LoaderEvent";
      }
   }
}

