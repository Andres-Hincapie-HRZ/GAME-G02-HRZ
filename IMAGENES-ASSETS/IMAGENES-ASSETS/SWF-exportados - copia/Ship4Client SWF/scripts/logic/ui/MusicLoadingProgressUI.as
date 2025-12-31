package logic.ui
{
   import com.star.frameworks.utils.MusicResHandler;
   import com.star.frameworks.utils.ResourceHandler;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.media.Sound;
   import flash.media.SoundLoaderContext;
   import flash.net.URLRequest;
   import logic.entry.MObject;
   import logic.entry.test.MovieClipDataBox;
   import logic.entry.test.iterator.ArrayIterator;
   import logic.game.GameKernel;
   
   public class MusicLoadingProgressUI extends AbstractPopUp
   {
      
      private static var _instance:MusicLoadingProgressUI = null;
      
      private var _mcData:MovieClipDataBox;
      
      private var _show:Boolean = false;
      
      private var sound:Sound;
      
      private var musicContext:SoundLoaderContext = new SoundLoaderContext(5000);
      
      private var request:URLRequest;
      
      private var itor:ArrayIterator;
      
      public function MusicLoadingProgressUI(param1:HHH)
      {
         super();
         setPopUpName("MusicLoadingProgressUI");
         this._mc = new MObject("Nowloading",20,110);
         this._mcData = new MovieClipDataBox(_mc.getMC());
         var _loc2_:MovieClip = this._mcData.getMC("mc_planbar");
         _loc2_.width = 0;
         this.startLoadingMusic();
      }
      
      public static function get instance() : MusicLoadingProgressUI
      {
         if(_instance == null)
         {
            _instance = new MusicLoadingProgressUI(new HHH());
         }
         return _instance;
      }
      
      override public function Init() : void
      {
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            GameKernel.popUpDisplayManager.Show(_instance,false);
            this._show = true;
            return;
         }
         GameKernel.popUpDisplayManager.Regisger(_instance);
         GameKernel.popUpDisplayManager.Show(_instance,false);
      }
      
      private function startLoadingMusic() : void
      {
         var _loc1_:Object = null;
         MusicResHandler.MusicCount = ResourceHandler.musicSet.length;
         this.itor = new ArrayIterator(ResourceHandler.musicSet);
         if(this.itor.hasNext())
         {
            _loc1_ = this.itor.next();
            this.request = new URLRequest(_loc1_[1]);
            this.sound = new Sound();
            this.sound.addEventListener(Event.COMPLETE,this.onComplete,false,0,true);
            this.sound.addEventListener(ProgressEvent.PROGRESS,this.__musicProgress);
            this.sound.addEventListener(IOErrorEvent.IO_ERROR,this.__assetError,false,0,true);
            this.sound.load(this.request,this.musicContext);
            MusicResHandler.PushMusic(_loc1_[0],this.sound);
            this._mcData.getTF("tf_nowload").text = _loc1_[0];
         }
      }
      
      private function onComplete(param1:Event) : void
      {
         var _loc2_:Object = null;
         var _loc3_:MovieClip = null;
         if(this.itor.hasNext())
         {
            _loc2_ = this.itor.next();
            this.request = new URLRequest(_loc2_[1]);
            this.sound = new Sound();
            this.sound.addEventListener(Event.COMPLETE,this.onComplete,false,0,true);
            this.sound.addEventListener(ProgressEvent.PROGRESS,this.__musicProgress);
            this.sound.addEventListener(IOErrorEvent.IO_ERROR,this.__assetError,false,0,true);
            this.sound.load(this.request,this.musicContext);
            MusicResHandler.PushMusic(_loc2_[0],this.sound);
            _loc3_ = this._mcData.getMC("mc_planbar");
            _loc3_.width = 149 * parseFloat(Number(this.itor.index / MusicResHandler.MusicCount).toFixed(2));
            this._mcData.getTF("tf_nowload").text = _loc2_[0];
            this._mcData.getTF("tf_num").text = this.itor.index + "";
         }
         else
         {
            MusicResHandler.LoadFinish = true;
            GameKernel.popUpDisplayManager.Hide(_instance);
            MusicControlUI.instance.Init();
         }
      }
      
      private function __musicProgress(param1:ProgressEvent) : void
      {
         this._mcData.getTF("tf_percent").text = parseFloat(Number(param1.bytesLoaded / param1.bytesTotal).toFixed(2)) * 100 + "%";
      }
      
      private function __assetError(param1:IOErrorEvent) : void
      {
         throw new Error(param1.toString());
      }
   }
}

class HHH
{
   
   public function HHH()
   {
      super();
   }
}
