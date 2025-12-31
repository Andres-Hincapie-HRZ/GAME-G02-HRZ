package com.star.frameworks.display.loader
{
   import com.star.frameworks.events.LoaderEvent;
   import com.star.frameworks.utils.HashSet;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.system.SecurityDomain;
   import logic.entry.GamePlayer;
   
   public class BatchLoader extends EventDispatcher
   {
      
      private var swfLoaderContextInfo:HashSet;
      
      public var isCompleted:Boolean;
      
      private var loadList:HashSet;
      
      private var count:int = 0;
      
      public function BatchLoader(param1:HashSet)
      {
         super();
         this.loadList = param1;
      }
      
      public function Load() : void
      {
         var _loc1_:Loader = null;
         var _loc2_:URLRequest = null;
         var _loc3_:LoaderContext = null;
         this.swfLoaderContextInfo = new HashSet();
         if(GamePlayer.getInstance().sessionKey != null)
         {
            _loc3_ = new LoaderContext(false,ApplicationDomain.currentDomain,SecurityDomain.currentDomain);
         }
         else
         {
            _loc3_ = new LoaderContext(false,ApplicationDomain.currentDomain);
         }
         var _loc4_:int = 0;
         while(_loc4_ < this.loadList.Keys().length)
         {
            ++this.count;
            _loc1_ = new Loader();
            _loc2_ = new URLRequest(this.loadList.Values()[_loc4_]);
            _loc1_.load(_loc2_,_loc3_);
            this.swfLoaderContextInfo.Put(this.loadList.Keys()[_loc4_],_loc1_.contentLoaderInfo);
            _loc1_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onComplete);
            _loc1_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.__ioError);
            _loc4_++;
         }
      }
      
      private function onComplete(param1:Event) : void
      {
         --this.count;
         if(this.count == 0)
         {
            dispatchEvent(new LoaderEvent(LoaderEvent.COMPLETE));
            return;
         }
      }
      
      private function __ioError(param1:IOErrorEvent) : void
      {
         var _loc3_:* = undefined;
         LoaderInfo(param1.target).addEventListener(Event.COMPLETE,this.onComplete);
         var _loc2_:LoaderEvent = new LoaderEvent(LoaderEvent.ERROR);
         _loc2_.path = param1.text;
         for each(_loc3_ in this.swfLoaderContextInfo.Values())
         {
            _loc3_.removeEventListener(IOErrorEvent.IO_ERROR,this.__ioError);
         }
         dispatchEvent(_loc2_);
      }
      
      private function __onComplete(param1:Event) : void
      {
         this.isCompleted = true;
         param1.currentTarget.removeEventListener(Event.COMPLETE,this.__onComplete);
         dispatchEvent(param1);
         this.isCompleted = false;
      }
      
      public function get ContextInfoSet() : HashSet
      {
         return this.swfLoaderContextInfo;
      }
      
      public function Release() : void
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in this.swfLoaderContextInfo.Values())
         {
            _loc1_.removeEventListener(Event.COMPLETE,this.onComplete);
            _loc1_.removeEventListener(IOErrorEvent.IO_ERROR,this.__ioError);
         }
         this.swfLoaderContextInfo.removeAll();
         this.swfLoaderContextInfo = null;
      }
   }
}

