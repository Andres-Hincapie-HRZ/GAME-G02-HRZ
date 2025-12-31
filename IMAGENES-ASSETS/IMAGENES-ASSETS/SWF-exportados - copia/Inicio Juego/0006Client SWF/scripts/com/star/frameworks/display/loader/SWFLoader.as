package com.star.frameworks.display.loader
{
   import com.star.frameworks.debug.Log;
   import com.star.frameworks.events.LoaderEvent;
   import com.star.frameworks.utils.StringUitl;
   import flash.display.*;
   import flash.events.*;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.system.SecurityDomain;
   import logic.entry.GamePlayer;
   
   public class SWFLoader extends EventDispatcher
   {
      
      private var loader:Loader = null;
      
      private var loadContext:LoaderContext = null;
      
      public var path:String = null;
      
      public function SWFLoader()
      {
         super();
      }
      
      public function Load(param1:String) : void
      {
         this.loader = new Loader();
         if(GamePlayer.getInstance().sessionKey != null)
         {
            this.loadContext = new LoaderContext(false,ApplicationDomain.currentDomain,SecurityDomain.currentDomain);
         }
         else
         {
            this.loadContext = new LoaderContext(false,ApplicationDomain.currentDomain);
         }
         this.addListeners();
         this.path = param1;
         this.loader.load(new URLRequest(this.path),this.loadContext);
      }
      
      private function addListeners() : void
      {
         this.loader.contentLoaderInfo.addEventListener(Event.INIT,this.onInit,false,0,true);
         this.loader.contentLoaderInfo.addEventListener(Event.OPEN,this.onOpen,false,0,true);
         this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onError,false,0,true);
         this.loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.onProgress,false,0,true);
         this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onComplete,false,0,true);
         this.loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError,false,0,true);
      }
      
      public function Release() : void
      {
         if(this.loader.contentLoaderInfo.hasEventListener(Event.INIT))
         {
            this.loader.contentLoaderInfo.removeEventListener(Event.INIT,this.onInit);
         }
         if(this.loader.contentLoaderInfo.hasEventListener(Event.INIT))
         {
            this.loader.contentLoaderInfo.removeEventListener(Event.OPEN,this.onOpen);
         }
         if(this.loader.contentLoaderInfo.hasEventListener(IOErrorEvent.IO_ERROR))
         {
            this.loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onError);
         }
         if(this.loader.contentLoaderInfo.hasEventListener(ProgressEvent.PROGRESS))
         {
            this.loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,this.onProgress);
         }
         if(this.loader.contentLoaderInfo.hasEventListener(Event.COMPLETE))
         {
            this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onComplete);
         }
         if(this.loader.contentLoaderInfo.hasEventListener(SecurityErrorEvent.SECURITY_ERROR))
         {
            this.loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError);
         }
         this.loadContext = null;
         this.path = null;
         this.loader = null;
      }
      
      public function getClass(param1:String) : Class
      {
         var name:String = param1;
         try
         {
            return this.loader.contentLoaderInfo.applicationDomain.getDefinition(name) as Class;
         }
         catch(e:ReferenceError)
         {
            throw new ReferenceError("无法找到关联类" + name);
         }
      }
      
      private function onOpen(param1:Event) : void
      {
         Log.logOut("Open " + this.path + " file");
      }
      
      private function onInit(param1:Event) : void
      {
         var _loc2_:LoaderEvent = new LoaderEvent(LoaderEvent.INIT);
         dispatchEvent(_loc2_);
         Log.logOut("SWF " + this.path + " Loaded");
      }
      
      private function onProgress(param1:ProgressEvent) : void
      {
         var _loc2_:LoaderEvent = null;
         _loc2_ = new LoaderEvent(LoaderEvent.PROGRESS);
         var _loc3_:int = 0;
         var _loc4_:String = String(param1.bytesLoaded / param1.bytesTotal * 100);
         var _loc5_:Array = StringUitl.splitStrToArray(_loc4_);
         _loc2_.currentByte = param1.bytesLoaded;
         _loc2_.totalBytes = param1.bytesTotal;
         _loc2_.percentStr = String(_loc5_[0]) + " %";
         dispatchEvent(_loc2_);
      }
      
      private function onComplete(param1:Event) : void
      {
         var _loc2_:LoaderEvent = new LoaderEvent(LoaderEvent.COMPLETE);
         _loc2_.res = this.loader.content;
         _loc2_.path = this.path;
         _loc2_.info = LoaderInfo(param1.target);
         dispatchEvent(_loc2_);
         Log.logOut("SWF " + this.path + " Loaded");
         this.Release();
      }
      
      private function onError(param1:Event) : void
      {
         Log.logOut(param1.toString());
         var _loc2_:LoaderEvent = new LoaderEvent(LoaderEvent.ERROR);
         dispatchEvent(_loc2_);
         this.Release();
      }
      
      private function onSecurityError(param1:SecurityErrorEvent) : void
      {
         Log.logOut(param1.toString());
         var _loc2_:LoaderEvent = new LoaderEvent(LoaderEvent.SECURITY_ERROR);
         dispatchEvent(_loc2_);
         this.Release();
      }
   }
}

