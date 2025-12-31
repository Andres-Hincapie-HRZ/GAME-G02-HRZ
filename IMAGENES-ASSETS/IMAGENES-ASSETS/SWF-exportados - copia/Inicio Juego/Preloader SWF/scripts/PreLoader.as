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
      
      internal var label1:TextField = null;
      
      public function PreLoader()
      {
         super();
         Security.allowDomain("*");
         this.m_ErrorLog = new HashSet();
         this.resLoader = new ResourceHandler("/data/config.xml?v=" + Math.random() * 100);
         this.resLoader.addEventListener(Event.COMPLETE,this.__onResHandlerComplete);
         this.resLoader.addEventListener(IOErrorEvent.IO_ERROR,this.__onResHandlerError);
         this.flashVar = root.loaderInfo.parameters;
      }
      
      private function __onResHandlerComplete(param1:Event) : void
      {
         ExternalInterface.call("console.log","Not working");
         this.resLoader.removeEventListener(Event.COMPLETE,this.__onResHandlerComplete);
         this.resLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.__onResHandlerError);
         this.noteLib = this.resLoader.noteSet.concat();
         this.initPreLoader();
      }
      
      private function __onResHandlerError(param1:IOErrorEvent) : void
      {
         ExternalInterface.call("console.log","ERROR");
      }
      
      public function initPreLoader() : void
      {
         var _loc1_:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain,SecurityDomain.currentDomain);
         var _loc2_:Loader = new Loader();
         _loc2_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.preLoaderAssetCompleted);
         _loc2_.load(new URLRequest(this.resLoader.pathObj.cdn + "asset/preloader_asset.swf"),_loc1_);
      }
      
      private function preLoaderAssetCompleted(param1:Event) : void
      {
         this.scene = LoaderInfo(param1.target).content as MovieClip;
         this.mProgress = this.scene.progressObject;
         this.mPercent = this.scene.tf_num as TextField;
         this.mTxt = this.scene.tf_txt as TextField;
         addChild(this.scene);
         this.loaderAllAsset();
      }
      
      public function loaderAllAsset() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Loader = null;
         var _loc3_:URLRequest = null;
         var _loc4_:LoaderInfo = null;
         var _loc5_:Array = this.resLoader.resSet.Values();
         var _loc6_:Array = this.resLoader.resSet.Keys();
         var _loc7_:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain,SecurityDomain.currentDomain);
         var _loc8_:int = int(_loc5_.length);
         _loc1_ = 0;
         while(_loc1_ < _loc8_)
         {
            _loc2_ = new Loader();
            trace("URL",_loc5_[_loc1_]);
            _loc3_ = new URLRequest(_loc5_[_loc1_]);
            _loc4_ = _loc2_.contentLoaderInfo;
            _loc4_.addEventListener(Event.COMPLETE,this.__onAllAssetCompletd,false,0,true);
            _loc4_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSercurityErrorHandler);
            _loc4_.addEventListener(IOErrorEvent.IO_ERROR,this.__assetError,false,0,true);
            _loc2_.load(_loc3_,_loc7_);
            this.assetLoaderInfo.Put(_loc6_[_loc1_],_loc4_);
            _loc1_++;
         }
         addEventListener(Event.ENTER_FRAME,this.stageInit);
      }
      
      private function __onAllAssetCompletd(param1:Event) : void
      {
         var _loc2_:Loader = null;
         var _loc3_:LoaderContext = null;
         var _loc4_:URLRequest = null;
         ++this.assetIndex;
         ++this.curPosition;
         if(this.assetIndex == this.resLoader.resSet.Length())
         {
            _loc2_ = new Loader();
            _loc3_ = new LoaderContext(false,ApplicationDomain.currentDomain,SecurityDomain.currentDomain);
            _loc4_ = new URLRequest(this.resLoader.pathObj.cdn + this.resLoader.pathObj.client + this.GAME_SWF);
            this.gameLoaderInfo = _loc2_.contentLoaderInfo;
            this.gameLoaderInfo.addEventListener(Event.COMPLETE,this.__assetCompleted,false,0,true);
            this.gameLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.__assetError,false,0,true);
            this.gameLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSercurityErrorHandler,false,0,true);
            _loc2_.load(_loc4_,_loc3_);
            this.assetLoaderInfo.Put("Client",this.gameLoaderInfo);
         }
      }
      
      private function GetLoadInfo(param1:LoaderInfo) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Object = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(param1 == null)
         {
            return;
         }
         var _loc6_:Array = this.assetLoaderInfo.Keys();
         var _loc7_:Array = this.assetLoaderInfo.Values();
         var _loc8_:Array = this.resLoader.resSet.Values();
         var _loc9_:Array = this.resLoader.resSet.Keys();
         _loc2_ = 0;
         while(_loc2_ < _loc7_.length)
         {
            if(param1 == _loc7_[_loc2_])
            {
               _loc5_ = _loc6_[_loc2_];
               _loc4_ = this.resLoader.resSet.Get(_loc5_);
               if(this.m_ErrorLog.Get(_loc5_))
               {
                  _loc3_ = this.m_ErrorLog.Get(_loc5_);
                  if(_loc3_.Count >= 1)
                  {
                     return;
                  }
                  ++_loc3_.Count;
               }
               else
               {
                  _loc3_ = new Object();
                  _loc3_.Count = 1;
                  this.m_ErrorLog.Put(_loc5_,_loc3_);
               }
            }
            _loc2_++;
         }
         this.ReloadRes(_loc4_);
      }
      
      private function ReloadRes(param1:String) : void
      {
         if(param1 == null)
         {
            return;
         }
         this.isError = false;
         this.mTxt.text = this.noteLib[3];
         param1 = this.resLoader.getResourceUrl(param1) + "?reload=1";
         if(this.flashVar["SessionKey"] != undefined)
         {
            ExternalInterface.call("AppendDebugText(\'" + param1 + "\')");
         }
         trace(param1);
         var _loc2_:Loader = new Loader();
         var _loc3_:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
         _loc2_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.__assetCompleted,false,0,true);
         _loc2_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.__assetError,false,0,true);
         _loc2_.load(new URLRequest(param1),_loc3_);
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
      
      private function __assetCompleted(param1:Event) : void
      {
         if(this.gameLoaderInfo.content)
         {
            this.mLoadCompleted = true;
         }
         else
         {
            this.gameLoaderInfo.addEventListener(Event.COMPLETE,this.onGameCompleted);
         }
      }
      
      private function onGameCompleted(param1:Event) : void
      {
         this.mLoadCompleted = true;
         this.gameLoaderInfo.removeEventListener(Event.COMPLETE,this.onGameCompleted);
      }
      
      private function __assetError(param1:IOErrorEvent) : void
      {
         this.isError = true;
         this.GetLoadInfo(LoaderInfo(param1.currentTarget));
      }
      
      private function onSercurityErrorHandler(param1:SecurityErrorEvent) : void
      {
         this.isError = true;
      }
      
      private function stageInit(param1:Event) : void
      {
         ExternalInterface.call("console.log","LAAL");
         var _loc2_:Number = NaN;
         var _loc3_:LoaderInfo = null;
         var _loc4_:LoaderInfo = null;
         var _loc5_:ModuleEvent = null;
         if(!this.state)
         {
            this.state = this.STATE_LOADING;
         }
         if(this.state == this.STATE_LOADING)
         {
            if(this.mLoadCompleted)
            {
               trace("mLoadCompleted");
               if(this.gameLoaderInfo.content)
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
            _loc2_ = 0;
            if(this.gameLoaderInfo != null)
            {
               this.loadedBytes = int(int(int(int(int(int(int(this.gameLoaderInfo.bytesLoaded)))))));
               this.totalBytes = int(int(int(int(int(int(int(this.gameLoaderInfo.bytesTotal)))))));
               this.mTxt.text = this.noteLib[6];
               this.mPercent.text = "";
               _loc2_ = this.nagLen * (this.loadedBytes / this.totalBytes);
               this.mProgress.width = _loc2_;
            }
            else
            {
               this.i = int(int(int(int(int(int(int(this.assetLoaderInfo.Length())))))));
               for each(_loc4_ in this.assetLoaderInfo.Values())
               {
                  if(_loc4_.bytesTotal != 0)
                  {
                     _loc2_ += this.nagLen / this.i * (_loc4_.bytesLoaded / _loc4_.bytesTotal);
                  }
               }
               this.mPercent.text = String(int(Math.floor(_loc2_ / this.nagLen * 100))) + "%";
               this.mProgress.width = _loc2_;
               this.mTxt.text = this.noteLib[3];
            }
            if(this.isError)
            {
               ExternalInterface.call("console.log","is called");
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
               _loc5_ = new ModuleEvent(ModuleEvent.MAIN_STAGE);
               _loc5_.resLib = this.assetLoaderInfo;
               _loc5_.flashVar = this.flashVar;
               _loc5_.pathObj = this.resLoader.pathObj;
               ModuleEventManager.getInstance().dispatchEvent(_loc5_);
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
            if(this.engine.getChildByName("GameKernel").isLogin)
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
            if(this.engine.getChildByName("GameKernel").isGameServer)
            {
               this.mTxt.text = this.noteLib[1];
               this.engine.getChildByName("GameKernel").isGameServer = false;
            }
            if(this.engine.getChildByName("GameKernel").isInit)
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
      
      public function onInitError(param1:IOErrorEvent) : void
      {
         ExternalInterface.call("console.log","FLARE");
         this.state = this.STATE_ERROR;
         this.engine.removeEventListener(Event.COMPLETE,this.onInitComplete);
         this.engine.removeEventListener(IOErrorEvent,this.onInitError);
      }
      
      public function onInitComplete(param1:Event) : void
      {
         ExternalInterface.call("console.log","leel");
         trace("initCompleted");
         this.engine.removeEventListener(Event.COMPLETE,this.onInitComplete);
         this.engine.removeEventListener(IOErrorEvent,this.onInitError);
      }
      
      public function getMovieClip(param1:String) : MovieClip
      {
         var _loc2_:Class = Class(getDefinitionByName(param1));
         return new _loc2_() as MovieClip;
      }
      
      public function show(param1:String) : *
      {
         if(this.label1 != null)
         {
            this.label1.text = param1;
            return;
         }
         this.label1 = this.createCustomTextField(0,20,200,20);
         this.label1.text = param1;
      }
      
      private function createCustomTextField(param1:Number, param2:Number, param3:Number, param4:Number) : TextField
      {
         var _loc5_:TextField = new TextField();
         _loc5_.x = param1;
         _loc5_.y = param2;
         _loc5_.width = param3;
         _loc5_.height = param4;
         addChild(_loc5_);
         return _loc5_;
      }
   }
}

