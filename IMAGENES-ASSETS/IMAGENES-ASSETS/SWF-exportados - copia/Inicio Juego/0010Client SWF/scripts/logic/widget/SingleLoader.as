package logic.widget
{
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.TimerEvent;
   import flash.net.URLRequest;
   import flash.utils.Timer;
   import logic.action.ConstructionAction;
   import logic.entry.Equiment;
   
   public class SingleLoader extends EventDispatcher
   {
      
      private static var m_Instance:SingleLoader;
      
      public static var Completed:Boolean = false;
      
      public static var IsLoading:Boolean = false;
      
      private var m_Loadr:Loader;
      
      public var CallBack:Function;
      
      private var m_Url:URLRequest;
      
      private var m_Reload:int;
      
      public var Item:LoadItem;
      
      public var CurEquiment:Equiment;
      
      private var m_Statue:Boolean = false;
      
      private var m_Timer:Timer;
      
      public function SingleLoader()
      {
         super();
         this.m_Statue = false;
         this.m_Timer = new Timer(1000);
         this.m_Timer.addEventListener(TimerEvent.TIMER,this.PaintConstruction);
      }
      
      public static function GetInstance() : SingleLoader
      {
         if(m_Instance == null)
         {
            m_Instance = new SingleLoader();
         }
         return m_Instance;
      }
      
      public function PaintConstruction(param1:TimerEvent) : void
      {
         if(Boolean(this.CurEquiment) && this.CurEquiment.UrlItem.IsCompleted)
         {
            this.CurEquiment.reLoadMc(this.CurEquiment.UrlItem.Image);
            this.m_Timer.stop();
         }
      }
      
      public function Init(param1:Equiment, param2:Function) : void
      {
         if(param1 && this.CurEquiment && this.CurEquiment.UrlItem.Id == param1.UrlItem.Id && !this.CurEquiment.UrlItem.IsCompleted)
         {
            this.m_Statue = true;
         }
         this.CurEquiment = param1;
         this.Item = this.CurEquiment.UrlItem;
         this.CallBack = param2;
         if(this.m_Statue)
         {
            return;
         }
         this.m_Loadr = new Loader();
         this.m_Loadr.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onCompleted);
         this.m_Loadr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onError);
      }
      
      public function Load() : void
      {
         if(ConstructionAction.ConstructionResCache.ContainsKey(this.Item.Id))
         {
            this.DoCallBack();
            this.Release();
            return;
         }
         if(this.m_Loadr)
         {
            if(this.m_Statue)
            {
               if(!this.m_Timer.running)
               {
                  this.m_Timer.start();
               }
               return;
            }
            this.m_Loadr.load(this.Item.Url,this.Item.Context);
         }
      }
      
      public function Release() : void
      {
         if(this.m_Loadr)
         {
            this.m_Loadr.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onCompleted);
            this.m_Loadr.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onError);
            if(this.m_Timer.running)
            {
               this.m_Timer.stop();
            }
            this.CurEquiment = null;
         }
      }
      
      private function DoCallBack() : void
      {
         if(this.CallBack != null)
         {
            this.CallBack(this.CurEquiment);
         }
      }
      
      private function onCompleted(param1:Event) : void
      {
         this.m_Reload = 0;
         SingleLoader.Completed = true;
         SingleLoader.IsLoading = false;
         this.Item.Content = LoaderInfo(param1.currentTarget).content;
         this.Item.IsCompleted = true;
         this.CurEquiment.UrlItem.IsCompleted = true;
         ConstructionAction.ConstructionResCache.Put(this.Item.Id,this.Item.Content);
         this.DoCallBack();
         this.Release();
      }
      
      private function onError(param1:IOErrorEvent) : void
      {
         if(this.m_Reload >= 1)
         {
            return;
         }
         ++this.m_Reload;
         if(this.m_Loadr)
         {
            this.m_Loadr.unload();
            this.m_Loadr.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onCompleted);
            this.m_Loadr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onError);
            this.Load();
         }
      }
   }
}

