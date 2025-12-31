package com.star.frameworks.display.loader
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.*;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   
   public class ImageLoader
   {
      
      private var _SourceObject:Object;
      
      private var _Callback:Function;
      
      private var _imageData:BitmapData;
      
      private var _loader:Loader;
      
      private var aLoader:Loader = new Loader();
      
      public function ImageLoader()
      {
         super();
         this._loader = new Loader();
      }
      
      public function LoadImage(param1:String, param2:Object, param3:Function, param4:Boolean = false) : void
      {
         this._SourceObject = param2;
         this._Callback = param3;
         if(param1 == null || param1 == "")
         {
            this.DoCallback(null);
            return;
         }
         if(param4)
         {
            this.sendRequest2(param1);
         }
         else
         {
            this.sendRequest(param1);
         }
      }
      
      private function sendRequest(param1:String) : void
      {
         var p_url:String = param1;
         var m_request:URLRequest = new URLRequest(p_url);
         var m_loader:URLLoader = new URLLoader();
         m_loader.dataFormat = URLLoaderDataFormat.BINARY;
         m_loader.addEventListener(Event.COMPLETE,this.onSendComplete);
         m_loader.addEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
         m_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.ioErrorHandler2);
         try
         {
            m_loader.load(m_request);
         }
         catch(error:Error)
         {
            DoCallback(null);
            return;
         }
      }
      
      private function sendRequest2(param1:String) : void
      {
         var _loc2_:URLRequest = new URLRequest(param1);
         var _loc3_:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
         this.aLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoadComplete2);
         this.aLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
         this.aLoader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.ioErrorHandler2);
         this.aLoader.load(_loc2_,_loc3_);
      }
      
      private function onLoadComplete2(param1:Event) : void
      {
         var _loc2_:MovieClip = new MovieClip();
         _loc2_.addChild(this.aLoader);
         this.DoCallback(_loc2_);
      }
      
      private function onSendComplete(param1:Event) : void
      {
         var _loc2_:LoaderContext = new LoaderContext(true);
         var _loc3_:ByteArray = param1.target.data as ByteArray;
         this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoadComplete);
         this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
         this._loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.ioErrorHandler2);
         this._loader.loadBytes(_loc3_);
      }
      
      private function ioErrorHandler(param1:IOErrorEvent) : void
      {
         this.DoCallback(null);
      }
      
      private function ioErrorHandler2(param1:SecurityErrorEvent) : void
      {
         this.DoCallback(null);
      }
      
      private function onLoadComplete(param1:Event) : void
      {
         this.DoCallback(this._loader.content as Bitmap);
      }
      
      private function DoCallback(param1:Object) : void
      {
         if(this._Callback != null)
         {
            this._Callback(this._SourceObject,param1);
         }
         this._Callback = null;
      }
   }
}

