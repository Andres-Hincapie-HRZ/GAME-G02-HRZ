package logic.game
{
   import com.star.frameworks.display.loader.BatchLoader;
   import com.star.frameworks.utils.HashSet;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.system.SecurityDomain;
   import flash.text.TextField;
   import logic.entry.GamePlayer;
   import logic.entry.MObject;
   
   public class GameGuiderLoadingManager
   {
      
      private static var instance:GameGuiderLoadingManager;
      
      private var loadedByte:uint;
      
      private var totalByte:uint;
      
      private var loadList:HashSet;
      
      private var tf_percent:TextField;
      
      private var tf_num:TextField;
      
      private var loadinMc:MObject;
      
      private var count:int;
      
      private var infoLib:HashSet;
      
      private var batchLoader:BatchLoader;
      
      private var callBack:Function;
      
      public function GameGuiderLoadingManager()
      {
         super();
         this.infoLib = new HashSet();
         this.count = 0;
         this.loadinMc = new MObject("Nowloading");
         this.tf_percent = this.loadinMc.getMC().tf_percent as TextField;
         this.tf_num = this.loadinMc.getMC().tf_num as TextField;
         var _loc1_:* = GameSetting.GAME_STAGE_WIDTH - this.loadinMc.width >> 1;
         var _loc2_:* = GameSetting.GAME_STAGE_HEIGHT - this.loadinMc.height >> 1;
         this.loadinMc.setLocationXY(_loc1_,_loc2_);
      }
      
      public static function getInstance() : GameGuiderLoadingManager
      {
         if(instance == null)
         {
            instance = new GameGuiderLoadingManager();
         }
         return instance;
      }
      
      public function Load(param1:HashSet, param2:Function = null) : void
      {
         var _loc5_:Loader = null;
         var _loc6_:LoaderInfo = null;
         var _loc7_:URLRequest = null;
         if(param1 == null || param1.Length() == 0)
         {
            this.DoCallBack();
            return;
         }
         this.callBack = param2;
         this.loadList = param1;
         var _loc3_:Array = this.loadList.Keys();
         var _loc4_:Array = this.loadList.Values();
         var _loc8_:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain,GamePlayer.getInstance().sessionKey == null ? null : SecurityDomain.currentDomain);
         var _loc9_:int = 0;
         while(_loc9_ < _loc4_.length)
         {
            _loc5_ = new Loader();
            _loc7_ = new URLRequest(_loc4_[_loc9_]);
            _loc6_ = _loc5_.contentLoaderInfo;
            _loc6_.addEventListener(Event.COMPLETE,this.__assetCompleted,false,0,true);
            _loc6_.addEventListener(IOErrorEvent.IO_ERROR,this.__assetError,false,0,true);
            _loc5_.load(_loc7_,_loc8_);
            this.infoLib.Put(_loc3_[_loc9_],_loc6_);
            ++this.count;
            _loc9_++;
         }
         this.tf_num.text = String(1) + "/" + this.loadList.Length();
         GameKernel.getInstance().addEventListener(Event.ENTER_FRAME,this.onTick);
      }
      
      private function __assetCompleted(param1:Event) : void
      {
         --this.count;
         this.Check();
      }
      
      private function __assetError(param1:IOErrorEvent) : void
      {
         throw new Error(param1.toString());
      }
      
      private function onTick(param1:Event) : void
      {
         var _loc4_:LoaderInfo = null;
         var _loc2_:int = this.infoLib.Length();
         var _loc3_:Number = 0;
         for each(_loc4_ in this.infoLib.Values())
         {
            if(_loc4_.bytesTotal != 0)
            {
               _loc3_ += this.infoLib.Length() / _loc2_ * (_loc4_.bytesLoaded / _loc4_.bytesTotal);
            }
         }
         this.tf_percent.text = String(int(Math.floor(_loc3_ / this.infoLib.Length() * 100))) + "%";
      }
      
      public function showInGuide() : void
      {
         if(this.loadinMc)
         {
            GameKernel.renderManager.getScene().addComponent(this.loadinMc);
         }
      }
      
      public function hideGuide() : void
      {
         if(this.loadinMc)
         {
            GameKernel.renderManager.getScene().removeComponent(this.loadinMc);
            this.loadinMc.stop();
         }
      }
      
      private function Check() : void
      {
         if(this.count == 0)
         {
            this.tf_num.text = String(this.loadList.Length()) + "/" + this.loadList.Length();
            this.registerResList();
            this.Release();
            this.DoCallBack();
         }
         else
         {
            this.tf_num.text = String(this.loadList.Length() - this.count) + "/" + this.loadList.Length();
         }
      }
      
      private function registerResList() : void
      {
         var _loc1_:Array = this.infoLib.Keys();
         var _loc2_:Array = this.infoLib.Values();
         var _loc3_:int = 0;
         while(_loc3_ < this.infoLib.Length())
         {
            GameKernel.resManager.registerRes(_loc1_[_loc3_],LoaderInfo(_loc2_[_loc3_]).content);
            _loc3_++;
         }
      }
      
      private function Release() : void
      {
         GameKernel.getInstance().removeEventListener(Event.ENTER_FRAME,this.onTick);
         this.loadList.removeAll();
         this.infoLib.removeAll();
      }
      
      public function DoCallBack() : void
      {
         if(this.callBack != null)
         {
            this.callBack();
         }
      }
   }
}

