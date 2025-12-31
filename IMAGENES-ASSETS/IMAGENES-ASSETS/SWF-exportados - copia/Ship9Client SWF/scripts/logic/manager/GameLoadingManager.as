package logic.manager
{
   import com.star.frameworks.display.loader.BatchLoader;
   import com.star.frameworks.display.loader.SWFLoader;
   import com.star.frameworks.events.LoaderEvent;
   import com.star.frameworks.utils.HashSet;
   import com.star.frameworks.utils.ObjectUtil;
   import flash.display.LoaderInfo;
   import logic.game.GameKernel;
   import logic.ui.GameLoadingUI;
   
   public class GameLoadingManager
   {
      
      private static var instance:GameLoadingManager;
      
      public static const STATE_NONE:int = 0;
      
      public static const STATE_INIT:int = 1;
      
      public static const STATE_PROGRESS:int = 2;
      
      public static const STATE_COMPLETED:int = 3;
      
      private var loadState:int;
      
      private var loadList:HashSet;
      
      private var swfNum:int = 0;
      
      private var callBack:Function;
      
      private var isCall:Boolean;
      
      private var batchLoader:BatchLoader;
      
      private var count:int;
      
      private var loadLIb:Array;
      
      private var needLoadNum:int;
      
      public function GameLoadingManager()
      {
         super();
         this.loadLIb = new Array();
         this.count = 0;
      }
      
      public static function getInstance() : GameLoadingManager
      {
         if(instance == null)
         {
            instance = new GameLoadingManager();
         }
         return instance;
      }
      
      public function get LoadState() : int
      {
         return this.loadState;
      }
      
      public function set LoadState(param1:int) : void
      {
         this.loadState = param1;
      }
      
      public function IsHadLoad(param1:String) : Boolean
      {
         if(GameKernel.resManager.IsExists(param1))
         {
            return true;
         }
         return false;
      }
      
      public function setCallBack(param1:Function) : void
      {
         this.callBack = param1;
      }
      
      public function DoCallBack() : void
      {
         if(this.callBack != null)
         {
            this.callBack();
         }
      }
      
      public function Load(param1:HashSet, param2:Function = null) : void
      {
         if(param1 == null || param1.Length() == 0)
         {
            return;
         }
         this.callBack = param2;
         this.loadList = param1;
         if(!this.IsNeedLoad())
         {
            this.DoCallBack();
            this.HideLoadingUI();
            return;
         }
         var _loc3_:Array = this.loadList.Keys();
         var _loc4_:Array = this.loadList.Values();
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.length)
         {
            if(!GameKernel.resManager.IsExists(_loc3_[_loc5_]))
            {
               this.loadSimpleRes(_loc4_[_loc5_]);
            }
            _loc5_++;
         }
         if(this.needLoadNum == 0)
         {
            return;
         }
         GameLoadingUI.getInstance().setLoadinNum(0,this.needLoadNum);
      }
      
      public function ShowLoadingUI() : void
      {
         if(this.LoadState == GameLoadingManager.STATE_COMPLETED)
         {
            return;
         }
         GameLoadingUI.getInstance().Show();
      }
      
      public function HideLoadingUI() : void
      {
         GameLoadingUI.getInstance().Hide();
      }
      
      public function IsNeedLoad() : Boolean
      {
         this.needLoadNum = 0;
         var _loc1_:Array = this.loadList.Keys();
         var _loc2_:Array = this.loadList.Values();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(!GameKernel.resManager.IsExists(_loc1_[_loc3_]))
            {
               ++this.needLoadNum;
            }
            _loc3_++;
         }
         return this.needLoadNum != 0;
      }
      
      public function getKeys(param1:String) : String
      {
         if(this.loadList.Length() == 0)
         {
            return null;
         }
         var _loc2_:Array = this.loadList.Keys();
         var _loc3_:Array = this.loadList.Values();
         var _loc4_:int = this.loadList.Length();
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            if(String(_loc3_[_loc5_]) == param1)
            {
               return String(_loc2_[_loc5_]);
            }
            _loc5_++;
         }
         return null;
      }
      
      private function loadSimpleRes(param1:String) : void
      {
         var _loc2_:SWFLoader = new SWFLoader();
         _loc2_.Load(param1);
         _loc2_.addEventListener(LoaderEvent.INIT,this.onResInit);
         _loc2_.addEventListener(LoaderEvent.PROGRESS,this.onResProgress);
         _loc2_.addEventListener(LoaderEvent.COMPLETE,this.onResComplete);
         _loc2_.addEventListener(LoaderEvent.ERROR,this.onResError);
         this.loadLIb.push(_loc2_);
         ++this.count;
      }
      
      private function Release() : void
      {
         var _loc1_:SWFLoader = null;
         while(this.loadLIb.length)
         {
            _loc1_ = this.loadLIb.pop() as SWFLoader;
            _loc1_.removeEventListener(LoaderEvent.INIT,this.onResInit);
            _loc1_.removeEventListener(LoaderEvent.PROGRESS,this.onResProgress);
            _loc1_.removeEventListener(LoaderEvent.COMPLETE,this.onResComplete);
            _loc1_.removeEventListener(LoaderEvent.ERROR,this.onResError);
         }
         ObjectUtil.ClearArray(this.loadLIb);
      }
      
      private function onResInit(param1:LoaderEvent) : void
      {
         this.LoadState = GameLoadingManager.STATE_INIT;
      }
      
      private function onResProgress(param1:LoaderEvent) : void
      {
         this.loadState = GameLoadingManager.STATE_PROGRESS;
         GameLoadingUI.getInstance().Update(param1.percentStr);
      }
      
      private function onResError(param1:LoaderEvent) : void
      {
      }
      
      private function onResComplete(param1:LoaderEvent) : void
      {
         var _loc2_:String = this.getKeys(param1.path);
         if(_loc2_ != null)
         {
            GameKernel.resManager.registerRes(_loc2_,LoaderInfo(param1.info));
         }
         --this.count;
         this.Check();
      }
      
      private function Check() : void
      {
         GameLoadingUI.getInstance().setLoadinNum(this.needLoadNum - this.count,this.needLoadNum);
         if(this.count == 0)
         {
            this.loadState = GameLoadingManager.STATE_COMPLETED;
            this.Release();
            this.DoCallBack();
         }
      }
      
      public function getLoaderList() : HashSet
      {
         return this.loadList;
      }
   }
}

