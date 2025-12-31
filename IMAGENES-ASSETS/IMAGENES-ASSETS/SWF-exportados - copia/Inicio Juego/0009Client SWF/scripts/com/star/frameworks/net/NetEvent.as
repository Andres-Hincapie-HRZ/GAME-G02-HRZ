package com.star.frameworks.net
{
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.utils.ByteArray;
   
   public class NetEvent extends Event
   {
      
      public static const CONNECT:String = Event.CONNECT;
      
      public static const SOCKET_DATA:String = ProgressEvent.SOCKET_DATA;
      
      public static const IO_ERROR:String = IOErrorEvent.IO_ERROR;
      
      public static const SECURITY_ERROR:String = SecurityErrorEvent.SECURITY_ERROR;
      
      public static const CLOSE:String = Event.CLOSE;
      
      public var MSG_TYPE:int;
      
      public var MSG_LEN:int;
      
      public var READ_BUF:ByteArray = new ByteArray();
      
      public function NetEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function toString() : String
      {
         return "NetEvent";
      }
   }
}

