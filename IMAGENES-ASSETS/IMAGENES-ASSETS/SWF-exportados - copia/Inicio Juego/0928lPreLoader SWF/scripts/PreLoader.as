package
{
   import com.star.frameworks.events.ModuleEvent;
   import com.star.frameworks.managers.ModuleEventManager;
   import com.star.frameworks.utils.HashSet;
   import com.star.frameworks.utils.ResourceHandler;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.StageAlign;
   import flash.display.StageDisplayState;
   import flash.display.StageScaleMode;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.external.ExternalInterface;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.system.Security;
   import flash.system.SecurityDomain;
   import flash.text.TextField;
   import flash.utils.getDefinitionByName;
   
   [SWF(width="760",height="820",backgroundColor="0x000000")]
   public class PreLoader extends Sprite
   {
      
      private static const STAGE_HEIGHT:int = 680;
      
      private static const STAGE_WIDTH:int = 760;
      
      public var list:HashSet;
      
      private var errorScene:Sprite;
      
      private var engine:Object;
      
      public var flashVar:Object;
      
      public var mLoadCompleted:Boolean;
      
      private var assetIndex:int = 0;
      
      private var assetLoaderInfo:HashSet = new HashSet();
      
      private var gameLoaderInfo:LoaderInfo;
      
      private var resLoader:ResourceHandler;
      
      public var resLib:Array = new Array();
      
      private var scene:MovieClip;
      
      public var GAME_SWF:String = "Client.swf";
      
      public var version:String = "2.0";
      
      private var mProgress:MovieClip;
      
      private var mPercent:TextField;
      
      private var mObj:MovieClip;
      
      private var mTxt:TextField;
      
      private var isError:Boolean;
      
      private var m_ErrorLog:HashSet;
      
      private var state:int = 0;
      
      public const STATE_NULL:int = -1;
      
      public const STATE_ERROR:int = 4;
      
      public const STATE_LOADING:int = 1;
      
      public const STATE_INIT:int = 2;
      
      public const STATE_START:int = 0;
      
      public const STATE_END:int = 3;
      
      private var loadedBytes:int;
      
      private var totalBytes:int;
      
      private var i:int;
      
      private var curPosition:int = 0;
      
      private var nagLen:int = 295;
      
      private var noteLib:Array = new Array();
      
      public function PreLoader()
      {
         super();
         Security.allowDomain("*");
         this.m_ErrorLog = new HashSet();
         this.resLoader = new ResourceHandler("config.xml?v=" + Math.random() * 100);
         this.resLoader.addEventListener(Event.COMPLETE,this.__onResHandlerComplete);
         this.resLoader.addEventListener(IOErrorEvent.IO_ERROR,this.__onResHandlerError);
         this.flashVar = root.loaderInfo.parameters;
      }
      
      private function __onResHandlerComplete(e:Event) : void
      {
         this.resLoader.removeEventListener(Event.COMPLETE,this.__onResHandlerComplete);
         this.resLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.__onResHandlerError);
         this.noteLib = this.resLoader.noteSet.concat();
         this.initPreLoader();
      }
      
      private function __onResHandlerError(e:IOErrorEvent) : void
      {
      }
      
      public function initPreLoader() : void
      {
         var context:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain,SecurityDomain.currentDomain);
         var loader:Loader = new Loader();
         loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.preLoaderAssetCompleted);
         loader.load(new URLRequest(this.resLoader.pathObj.cdn + "asset/preloader_asset.swf"),context);
      }
      
      private function preLoaderAssetCompleted(e:Event) : void
      {
         this.scene = LoaderInfo(e.target).content as MovieClip;
         this.mProgress = this.scene.progressObject;
         this.mPercent = this.scene.tf_num as TextField;
         this.mTxt = this.scene.tf_txt as TextField;
         addChild(this.scene);
         this.loaderAllAsset();
      }
      
      public function loaderAllAsset() : void
      {
         var loader:Loader = null;
         var request:URLRequest = null;
         var loaderInfo:LoaderInfo = null;
         var arr:Array = this.resLoader.resSet.Values();
         var keys:Array = this.resLoader.resSet.Keys();
         var context:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain,SecurityDomain.currentDomain);
         var len:int = int(arr.length);
         for(var i:int = 0; i < len; i++)
         {
            loader = new Loader();
            trace("URL",arr[i]);
            request = new URLRequest(arr[i]);
            loaderInfo = loader.contentLoaderInfo;
            loaderInfo.addEventListener(Event.COMPLETE,this.__onAllAssetCompletd,false,0,true);
            loaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSercurityErrorHandler);
            loaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.__assetError,false,0,true);
            loader.load(request,context);
            this.assetLoaderInfo.Put(keys[i],loaderInfo);
         }
         addEventListener(Event.ENTER_FRAME,this.stageInit);
      }
      
      private function __onAllAssetCompletd(contentLoaderInfo:Event) : void
      {
         var ldr:Loader = null;
         var context:LoaderContext = null;
         var request:URLRequest = null;
         ++this.assetIndex;
         ++this.curPosition;
         if(this.assetIndex == this.resLoader.resSet.Length())
         {
            ldr = new Loader();
            context = new LoaderContext(false,ApplicationDomain.currentDomain,SecurityDomain.currentDomain);
            request = new URLRequest(this.resLoader.pathObj.cdn + this.resLoader.pathObj.client + this.GAME_SWF);
            this.gameLoaderInfo = ldr.contentLoaderInfo;
            this.gameLoaderInfo.addEventListener(Event.COMPLETE,this.__assetCompleted,false,0,true);
            this.gameLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.__assetError,false,0,true);
            this.gameLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSercurityErrorHandler,false,0,true);
            ldr.load(request,context);
            this.assetLoaderInfo.Put("Client",this.gameLoaderInfo);
         }
      }
      
      private function GetLoadInfo(refInfo:LoaderInfo) : void
      {
         var obj:Object = null;
         var path:String = null;
         var key:String = null;
         if(refInfo == null)
         {
            return;
         }
         var keys:Array = this.assetLoaderInfo.Keys();
         var list:Array = this.assetLoaderInfo.Values();
         var urlPath:Array = this.resLoader.resSet.Values();
         var urlKeys:Array = this.resLoader.resSet.Keys();
         for(var i:int = 0; i < list.length; i++)
         {
            if(refInfo == list[i])
            {
               key = keys[i];
               path = this.resLoader.resSet.Get(key);
               if(this.m_ErrorLog.Get(key))
               {
                  obj = this.m_ErrorLog.Get(key);
                  if(obj.Count >= 1)
                  {
                     return;
                  }
                  ++obj.Count;
               }
               else
               {
                  obj = new Object();
                  obj.Count = 1;
                  this.m_ErrorLog.Put(key,obj);
               }
            }
         }
         this.ReloadRes(path);
      }
      
      private function ReloadRes(path:String) : void
      {
         if(path == null)
         {
            return;
         }
         this.isError = false;
         this.mTxt.text = this.noteLib[3];
         path = this.resLoader.getResourceUrl(path) + "?reload=1";
         if(this.flashVar["SessionKey"] != undefined)
         {
            ExternalInterface.call("AppendDebugText(\'" + path + "\')");
         }
         trace(path);
         var load:Loader = new Loader();
         var context:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
         load.contentLoaderInfo.addEventListener(Event.COMPLETE,this.__assetCompleted,false,0,true);
         load.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.__assetError,false,0,true);
         load.load(new URLRequest(path),context);
      }
      
      public function setStage() : void
      {
         stage.scaleMode = StageScaleMode.SHOW_ALL;
         stage.displayState = StageDisplayState.NORMAL;
         stage.stageWidth = STAGE_WIDTH;
         stage.stageHeight = STAGE_HEIGHT;
         stage.align = StageAlign.TOP;
         stage.showDefaultContextMenu = false;
      }
      
      private function __assetCompleted(e:Event) : void
      {
         if(Boolean(this.gameLoaderInfo.content))
         {
            this.mLoadCompleted = true;
         }
         else
         {
            this.gameLoaderInfo.addEventListener(Event.COMPLETE,this.onGameCompleted);
         }
      }
      
      private function onGameCompleted(e:Event) : void
      {
         this.mLoadCompleted = true;
         this.gameLoaderInfo.removeEventListener(Event.COMPLETE,this.onGameCompleted);
      }
      
      private function __assetError(e:IOErrorEvent) : void
      {
         this.isError = true;
         this.GetLoadInfo(LoaderInfo(e.currentTarget));
      }
      
      private function onSercurityErrorHandler(e:SecurityErrorEvent) : void
      {
         this.isError = true;
      }
      
      private function stageInit(e:Event) : void
      {
         var ss:Number = NaN;
         var curLInfo:LoaderInfo = null;
         var info:LoaderInfo = null;
         var moduleEvent:ModuleEvent = null;
         if(!this.state)
         {
            this.state = this.STATE_LOADING;
         }
         if(this.state == this.STATE_LOADING)
         {
            if(this.mLoadCompleted)
            {
               trace("mLoadCompleted");
               if(Boolean(this.gameLoaderInfo.content))
               {
                  this.assetLoaderInfo.Remove("Client");
                  this.engine = this.gameLoaderInfo.content;
                  this.engine.addEventListener(Event.COMPLETE,this.onInitComplete);
                  this.engine.addEventListener(IOErrorEvent,this.onInitError);
               }
               else
               {
                  this.mPercent.text = "100%";
                  this.mTxt.text = this.noteLib[4];
                  this.mProgress.width = this.nagLen;
               }
               this.gameLoaderInfo.removeEventListener(Event.COMPLETE,this.__assetCompleted);
               this.gameLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.__assetError);
               this.gameLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSercurityErrorHandler);
               this.gameLoaderInfo = null;
               this.state = this.STATE_INIT;
               return;
            }
            ss = 0;
            if(this.gameLoaderInfo != null)
            {
               this.loadedBytes = this.gameLoaderInfo.bytesLoaded;
               this.totalBytes = this.gameLoaderInfo.bytesTotal;
               this.mTxt.text = this.noteLib[6];
               this.mPercent.text = "";
               ss = this.nagLen * (this.loadedBytes / this.totalBytes);
               this.mProgress.width = ss;
            }
            else
            {
               this.i = this.assetLoaderInfo.Length();
               for each(info in this.assetLoaderInfo.Values())
               {
                  if(info.bytesTotal != 0)
                  {
                     ss += this.nagLen / this.i * (info.bytesLoaded / info.bytesTotal);
                  }
               }
               this.mPercent.text = String(int(Math.floor(ss / this.nagLen * 100))) + "%";
               this.mProgress.width = ss;
               this.mTxt.text = this.noteLib[3];
            }
            if(this.isError)
            {
               this.mTxt.text = this.noteLib[4];
               removeEventListener(Event.ENTER_FRAME,this.stageInit);
               this.isError = false;
               return;
            }
         }
         else if(this.state == this.STATE_INIT)
         {
            if(this.loadedBytes == this.totalBytes)
            {
               addChild(DisplayObject(this.engine));
               this.state = this.STATE_END;
               moduleEvent = new ModuleEvent(ModuleEvent.MAIN_STAGE);
               moduleEvent.resLib = this.assetLoaderInfo;
               moduleEvent.flashVar = this.flashVar;
               moduleEvent.pathObj = this.resLoader.pathObj;
               ModuleEventManager.getInstance().dispatchEvent(moduleEvent);
            }
         }
         else if(this.state == this.STATE_END)
         {
            if(this.flashVar["SessionKey"] == undefined)
            {
               removeEventListener(Event.ENTER_FRAME,this.stageInit);
               this.mProgress = null;
               this.mPercent = null;
               this.scene.stop();
               removeChild(this.scene);
               this.scene = null;
               addChild(DisplayObject(this.engine));
               return;
            }
            trace(this.engine);
            trace(this.engine.getChildByName("GameKernel"));
            if(Boolean(this.engine.getChildByName("GameKernel").isLogin))
            {
               this.mTxt.text = this.noteLib[0];
               if(this.engine.getChildByName("GameKernel").ConnectErrorCode > 0)
               {
                  this.mTxt.text = this.mTxt.text + "(" + this.engine.getChildByName("GameKernel").ConnectErrorCode + "-" + this.engine.getChildByName("GameKernel").ConnectLoginServerNum + ")";
                  this.engine.getChildByName("GameKernel").ConnectErrorCode = 0;
               }
               else if(this.engine.getChildByName("GameKernel").ConnectLoginServerNum > 0)
               {
                  this.mTxt.text = this.mTxt.text + "(" + this.engine.getChildByName("GameKernel").ConnectLoginServerNum + ")";
               }
               this.engine.getChildByName("GameKernel").isLogin = false;
            }
            if(Boolean(this.engine.getChildByName("GameKernel").isGameServer))
            {
               this.mTxt.text = this.noteLib[1];
               this.engine.getChildByName("GameKernel").isGameServer = false;
            }
            if(Boolean(this.engine.getChildByName("GameKernel").isInit))
            {
               this.mTxt.text = this.noteLib[2];
               removeEventListener(Event.ENTER_FRAME,this.stageInit);
               this.mProgress = null;
               this.mPercent = null;
               this.mTxt.text = "";
               this.scene.stop();
               removeChild(this.scene);
               this.scene = null;
            }
            return;
         }
      }
      
      public function onInitError(e:IOErrorEvent) : void
      {
         this.state = this.STATE_ERROR;
         this.engine.removeEventListener(Event.COMPLETE,this.onInitComplete);
         this.engine.removeEventListener(IOErrorEvent,this.onInitError);
      }
      
      public function onInitComplete(e:Event) : void
      {
         trace("initCompleted");
         this.engine.removeEventListener(Event.COMPLETE,this.onInitComplete);
         this.engine.removeEventListener(IOErrorEvent,this.onInitError);
      }
      
      public function getMovieClip(args:String) : MovieClip
      {
         var c:Class = Class(getDefinitionByName(args));
         return new c() as MovieClip;
      }
   }
}

