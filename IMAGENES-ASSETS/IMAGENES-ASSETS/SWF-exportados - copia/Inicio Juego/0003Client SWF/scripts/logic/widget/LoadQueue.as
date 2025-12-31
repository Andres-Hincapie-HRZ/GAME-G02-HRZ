package logic.widget
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
   
   public class LoadQueue extends EventDispatcher
   {
      
      private var m_Loader:Loader;
      
      private var m_IsLoading:Boolean;
      
      public var m_CurLoadIndex:int;
      
      public var ContentInfo:HashSet;
      
      public var LoadList:HashSet;
      
      public var LoadingList:Array;
      
      public var ErrorLogList:HashSet;
      
      public var MaxConnectionNum:int;
      
      public var m_AllCompleted:Boolean;
      
      public var CallBack:Function;
      
      private var resList:Array;
      
      public function LoadQueue(param1:int = 1)
      {
         super();
         this.m_CurLoadIndex = 0;
         this.m_AllCompleted = false;
         this.MaxConnectionNum = param1;
         this.LoadList = new HashSet();
         this.LoadingList = new Array();
         this.ContentInfo = new HashSet();
         this.ErrorLogList = new HashSet();
         this.m_IsLoading = false;
         addEventListener(LoaderEvent.ITEM_COMPLETED,this.onNext);
      }
      
      public function AddItem(param1:Object) : void
      {
         if(param1 is LoadItem)
         {
            if(LoadItem(param1).Context == null)
            {
               param1.Context = new LoaderContext(false,ApplicationDomain.currentDomain,GamePlayer.getInstance().sessionKey == null ? null : SecurityDomain.currentDomain);
            }
            this.LoadList.Put(param1.Id,param1);
            return;
         }
         var _loc2_:LoadItem = new LoadItem();
         if(param1.id != undefined)
         {
            _loc2_.Id = param1.id;
         }
         if(param1.url != undefined)
         {
            _loc2_.Url = new URLRequest(param1.url);
         }
         if(param1.type != undefined)
         {
            _loc2_.Type = param1.type;
         }
         if(param1.index != undefined)
         {
            _loc2_.Index = param1.index;
         }
         if(param1.context != undefined)
         {
            _loc2_.Context = param1.context;
         }
         this.LoadList.Put(_loc2_.Id,_loc2_);
      }
      
      public function RemoveItem(param1:LoadItem) : void
      {
         if(this.LoadList.isEmpty())
         {
            return;
         }
         if(param1 == null)
         {
            return;
         }
         this.LoadList.Remove(param1.Id);
         param1 = null;
      }
      
      private function SortByIndex() : void
      {
         this.resList = this.LoadList.Values();
         this.resList = this.resList.sortOn("Id",Array.NUMERIC);
      }
      
      public function Start() : void
      {
         var _loc2_:LoadItem = null;
         if(this.LoadList.isEmpty())
         {
            return;
         }
         this.SortByIndex();
         var _loc1_:int = Math.min(this.LoadList.Length(),this.MaxConnectionNum);
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = this.resList[_loc3_];
            this.m_CurLoadIndex = _loc3_;
            this.DispathLoadItem(_loc2_);
            _loc3_++;
         }
      }
      
      public function Stop() : void
      {
         this.LoadList.removeAll();
         this.m_AllCompleted = false;
         this.m_Loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onCompleted);
         this.m_Loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onError);
         this.m_Loader.unload();
      }
      
      private function DispathLoadItem(param1:LoadItem, param2:Boolean = false) : void
      {
         if(param1 == null)
         {
            return;
         }
         this.m_Loader = new Loader();
         this.m_Loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onCompleted);
         this.m_Loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onError);
         this.ContentInfo.Put(param1.Id,this.m_Loader.contentLoaderInfo);
         this.m_Loader.load(param1.Url,param1.Context);
      }
      
      private function RandomItemUrl(param1:LoadItem) : LoadItem
      {
         var _loc2_:String = param1.Url.url;
         param1.Url = new URLRequest(_loc2_ + "?v=reload");
         return param1;
      }
      
      public function GetCompletedAssetNumber() : int
      {
         var _loc3_:LoadItem = null;
         var _loc1_:Array = this.LoadList.Values();
         var _loc2_:int = 0;
         for each(_loc3_ in _loc1_)
         {
            if(_loc3_.IsCompleted)
            {
               _loc2_++;
            }
         }
         return _loc2_;
      }
      
      public function GetLoadingAssetNumber() : int
      {
         var _loc3_:LoadItem = null;
         var _loc1_:Array = this.LoadList.Values();
         var _loc2_:int = 0;
         for each(_loc3_ in _loc1_)
         {
            if(_loc3_.IsLoading)
            {
               _loc2_++;
            }
         }
         return _loc2_;
      }
      
      public function GetContentInfo(param1:LoaderInfo) : LoadItem
      {
         var _loc4_:int = 0;
         var _loc5_:LoaderInfo = null;
         var _loc6_:LoadItem = null;
         var _loc2_:Array = this.ContentInfo.Keys();
         var _loc3_:Array = this.ContentInfo.Values();
         for each(_loc5_ in _loc3_)
         {
            if(_loc5_ == param1)
            {
               return this.LoadList.Get(_loc2_[_loc4_]);
            }
            _loc4_++;
         }
         return null;
      }
      
      private function onCompleted(param1:Event) : void
      {
         var _loc2_:LoadItem = this.GetContentInfo(LoaderInfo(param1.currentTarget));
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.IsCompleted = true;
         _loc2_.IsLoading = false;
         _loc2_.Content = LoaderInfo(param1.currentTarget).content;
         var _loc3_:LoaderEvent = new LoaderEvent(LoaderEvent.ITEM_COMPLETED);
         _loc3_.res = _loc2_;
         dispatchEvent(_loc3_);
         if(this.CallBack != null)
         {
            this.CallBack(_loc2_);
         }
      }
      
      private function onError(param1:IOErrorEvent) : void
      {
         var _loc3_:Object = null;
         var _loc2_:LoadItem = this.GetContentInfo(LoaderInfo(param1.currentTarget));
         if(_loc2_ == null)
         {
            return;
         }
         if(this.ErrorLogList.ContainsKey(_loc2_.Url))
         {
            _loc3_ = this.ErrorLogList.Get(_loc2_.Url);
            if(_loc3_.Count >= 1)
            {
               return;
            }
         }
         else
         {
            _loc3_ = new Object();
            _loc3_.Count = 1;
            _loc2_ = this.RandomItemUrl(_loc2_);
            this.ErrorLogList.Put(_loc2_.Url,_loc3_);
            this.DispathLoadItem(_loc2_,true);
         }
      }
      
      private function onNext(param1:LoaderEvent) : void
      {
         ++this.m_CurLoadIndex;
         this.m_IsLoading = true;
         if(this.GetCompletedAssetNumber() == this.LoadList.Length())
         {
            this.m_AllCompleted = true;
            dispatchEvent(new LoaderEvent(LoaderEvent.COMPLETE_ALL));
            return;
         }
         var _loc2_:LoadItem = param1.res as LoadItem;
         this.DispathLoadItem(this.resList[this.m_CurLoadIndex]);
      }
   }
}

