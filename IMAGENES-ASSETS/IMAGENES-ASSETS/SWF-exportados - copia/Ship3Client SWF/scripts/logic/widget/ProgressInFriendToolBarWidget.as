package logic.widget
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.utils.ObjectUtil;
   import logic.entry.Equiment;
   import logic.game.GameKernel;
   import logic.ui.AlignManager;
   
   public class ProgressInFriendToolBarWidget
   {
      
      private static var instance:ProgressInFriendToolBarWidget;
      
      private static const INTERVAL:int = 5;
      
      private var isShow:Boolean;
      
      private var _progressList:Array;
      
      private var _wrapper:Container;
      
      public function ProgressInFriendToolBarWidget()
      {
         super();
         this._progressList = new Array();
         this._wrapper = new Container();
         this._wrapper.x = GameKernel.fullRect.width;
         this._wrapper.y = 470;
         AlignManager.GetInstance().SetAlign(this._wrapper,"right");
         GameKernel.renderManager.getUI().addComponent(this._wrapper);
      }
      
      public static function getInstance() : ProgressInFriendToolBarWidget
      {
         if(instance == null)
         {
            instance = new ProgressInFriendToolBarWidget();
         }
         return instance;
      }
      
      public function get ProgressQueue() : Array
      {
         return this._progressList;
      }
      
      public function get Wrapper() : Container
      {
         return this._wrapper;
      }
      
      public function get IsShow() : Boolean
      {
         return this.isShow;
      }
      
      public function HideInFriendProgressList(param1:Boolean = true) : void
      {
         if(this._wrapper.parent != null)
         {
            if(param1)
            {
               this._wrapper.Gc();
            }
            this._wrapper.parent.removeChild(this._wrapper);
            this.isShow = false;
         }
      }
      
      public function setInFriendProgressListVisible(param1:Boolean) : void
      {
         if(param1)
         {
            if(this._wrapper)
            {
               this.showInFriendProgressList();
            }
         }
         else if(this._wrapper)
         {
            this.HideInFriendProgressList(false);
         }
         this.isShow = param1;
      }
      
      public function showInFriendProgressList() : void
      {
         if(this._wrapper.parent == null)
         {
            GameKernel.renderManager.getUI().addComponent(this._wrapper);
            this.isShow = true;
         }
      }
      
      public function PushProgress(param1:Equiment) : void
      {
         var _loc2_:ProgressIsoInFriend = new ProgressIsoInFriend(param1);
         this._progressList.push(_loc2_);
         this.Show(_loc2_);
      }
      
      public function syncProgressItem() : void
      {
         var _loc1_:ProgressIsoInFriend = null;
         if(this._progressList == null || this._progressList.length == 0)
         {
            return;
         }
         for each(_loc1_ in this._progressList)
         {
            if(_loc1_.IsCompleted)
            {
               this.destoryProgressEntry(_loc1_);
            }
            else
            {
               _loc1_.setProgressCostTime();
            }
         }
      }
      
      internal function Show(param1:ProgressIsoInFriend) : void
      {
         if(this._progressList == null || this._progressList.length == 0)
         {
            return;
         }
         var _loc2_:int = int(this._progressList.length);
         param1.Iso.y -= _loc2_ * (param1.Iso.height + ProgressInFriendToolBarWidget.INTERVAL);
         this._wrapper.x = GameKernel.getInstance().stage.stageWidth - param1.Iso.width + GameKernel.fullRect.x;
         this._wrapper.addChild(param1.Iso);
         this.showInFriendProgressList();
      }
      
      public function Sort() : void
      {
         var _loc2_:ProgressIsoInFriend = null;
         if(this._progressList == null || this._progressList.length == 0)
         {
            return;
         }
         this.reSet();
         var _loc1_:int = 0;
         while(_loc1_ < this._progressList.length)
         {
            _loc2_ = this._progressList[_loc1_] as ProgressIsoInFriend;
            _loc2_.Iso.y -= (_loc1_ + 1) * (_loc2_.Iso.height + ProgressInFriendToolBarWidget.INTERVAL);
            _loc1_++;
         }
      }
      
      internal function reSet() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._progressList.length)
         {
            if(ProgressIsoInFriend(this._progressList[_loc1_]).Iso != null)
            {
               ProgressIsoInFriend(this._progressList[_loc1_]).Iso.y = 0;
            }
            _loc1_++;
         }
      }
      
      internal function getProgressIndex(param1:ProgressIsoInFriend) : int
      {
         if(this._progressList == null || this._progressList.length == 0)
         {
            return -1;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this._progressList.length)
         {
            if(param1 == this._progressList[_loc2_])
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      private function getProgressIsoByEquiment(param1:Equiment) : ProgressIsoInFriend
      {
         if(this._progressList == null || this._progressList.length == 0)
         {
            return null;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this._progressList.length)
         {
            if(ProgressIsoInFriend(this._progressList[_loc2_]).Construction == param1)
            {
               return this._progressList[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      private function destoryProgressEntry(param1:ProgressIsoInFriend) : void
      {
         var _loc2_:int = 0;
         if(this._progressList.length)
         {
            _loc2_ = this.getProgressIndex(param1);
            if(_loc2_ != -1)
            {
               param1 = this._progressList[_loc2_];
               param1.Destory();
               this._progressList.splice(_loc2_,1);
               this.Sort();
            }
         }
      }
      
      public function Destory(param1:Equiment) : void
      {
         var _loc2_:ProgressIsoInFriend = null;
         var _loc3_:int = 0;
         if(this._progressList.length)
         {
            param1.getMC().filters = null;
            _loc2_ = this.getProgressIsoByEquiment(param1);
            _loc3_ = this.getProgressIndex(_loc2_);
            _loc2_.Destory();
            this._progressList.splice(_loc3_,1);
            this.Sort();
         }
      }
      
      public function RemoveAllIosInFriend() : void
      {
         var _loc1_:ProgressIsoInFriend = null;
         if(this._progressList.length == 0)
         {
            this.HideInFriendProgressList();
            if(this._wrapper.numChildren)
            {
               this._wrapper.Gc();
            }
            return;
         }
         for each(_loc1_ in this._progressList)
         {
            this.destoryProgressEntry(_loc1_);
         }
         ObjectUtil.ClearArray(this._progressList);
         this.HideInFriendProgressList();
         if(this._wrapper.numChildren)
         {
            this._wrapper.Gc();
         }
      }
   }
}

