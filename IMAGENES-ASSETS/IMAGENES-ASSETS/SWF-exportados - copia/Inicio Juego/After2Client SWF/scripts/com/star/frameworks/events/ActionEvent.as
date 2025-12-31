package com.star.frameworks.events
{
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   import flash.events.IOErrorEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.events.TextEvent;
   
   public class ActionEvent extends Event
   {
      
      public static const ACTION_CLICK:String = MouseEvent.CLICK;
      
      public static const ACTION_DOUBLE_CLICK:String = MouseEvent.DOUBLE_CLICK;
      
      public static const ACTION_MOUSE_DOWN:String = MouseEvent.MOUSE_DOWN;
      
      public static const ACTION_MOUSE_MOVE:String = MouseEvent.MOUSE_MOVE;
      
      public static const ACTION_MOUSE_OUT:String = MouseEvent.MOUSE_OUT;
      
      public static const ACTION_MOUSE_OVER:String = MouseEvent.MOUSE_OVER;
      
      public static const ACTION_MOUSE_UP:String = MouseEvent.MOUSE_UP;
      
      public static const ACTION_ROLL_OUT:String = MouseEvent.ROLL_OUT;
      
      public static const ACTION_ROLL_OVER:String = MouseEvent.ROLL_OVER;
      
      public static const ACTION_INIT:String = Event.INIT;
      
      public static const ACTION_ERROR:String = IOErrorEvent.IO_ERROR;
      
      public static const ACTION_OPEN:String = Event.OPEN;
      
      public static const ACTION_PROGRESS:String = ProgressEvent.PROGRESS;
      
      public static const ACTION_COMPLETE:String = Event.COMPLETE;
      
      public static const ACTION_SECURITY_ERROR:String = SecurityErrorEvent.SECURITY_ERROR;
      
      public static const ACTION_HTTP_STATUSEVENT:String = HTTPStatusEvent.HTTP_STATUS;
      
      public static const ACTION_FULLSCREEN:String = Event.FULLSCREEN;
      
      public static const ACTION_CLOSE:String = Event.CLOSE;
      
      public static const ACTION_TEXT_LINK:String = TextEvent.LINK;
      
      public static const ACTION_KEY_DOWN:String = KeyboardEvent.KEY_DOWN;
      
      public static const ACTION_KEY_UP:String = KeyboardEvent.KEY_UP;
      
      public function ActionEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

