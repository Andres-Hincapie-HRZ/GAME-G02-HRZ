package logic.widget
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.utils.ObjectUtil;
   import logic.entry.Equiment;
   import logic.entry.GameStageEnum;
   import logic.game.GameKernel;
   import logic.ui.AlignManager;
   
   public class ProgressListToolBarWidget
   {
      
      private static var instance:ProgressListToolBarWidget;
      
      private static const INTERVAL:int = 5;
      
      private var _progressList:Array;
      
      private var _wrapper:Container;
      
      public function ProgressListToolBarWidget()
      {
         super();
         this._progressList = new Array();
         this._wrapper = new Container();
         AlignManager.GetInstance().SetAlign(this._wrapper,"right");
         this._wrapper.y = 470;
         GameKernel.renderManager.getUI().addComponent(this._wrapper);
      }
      
      public static function getInstance() : ProgressListToolBarWidget
      {
         if(instance == null)
         {
            instance = new ProgressListToolBarWidget();
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
      
      public function PushProgress(param1:Equiment) : void
      {
         var _loc2_:ProgressEntryIso = new ProgressEntryIso(param1);
         this._progressList.push(_loc2_);
         this.Show(_loc2_);
      }
      
      public function HideProgressList() : void
      {
         if(this._wrapper.parent)
         {
            this._wrapper.parent.removeChild(this._wrapper);
         }
      }
      
      public function showProgressList() : void
      {
         if(this._wrapper.parent == null)
         {
            if(GameKernel.currentGameStage != GameStageEnum.GAME_STAGE_GALAXY)
            {
               GameKernel.renderManager.getUI().addComponent(this._wrapper);
            }
         }
      }
      
      public function syncProgressItem() : void
      {
         var _loc1_:ProgressEntryIso = null;
         if(this._progressList == null || this._progressList.length == 0)
         {
            return;
         }
         for each(_loc1_ in this._progressList)
         {
            if(!_loc1_.IsCompleted)
            {
               _loc1_.setProgressCostTime();
            }
            else
            {
               this.destoryProgressEntry(_loc1_);
            }
         }
      }
      
      internal function Show(param1:ProgressEntryIso) : void
      {
         if(this._progressList == null || this._progressList.length == 0)
         {
            return;
         }
         var _loc2_:int = int(this._progressList.length);
         param1.Iso.y -= _loc2_ * (param1.Iso.height + ProgressListToolBarWidget.INTERVAL);
         this._wrapper.x = GameKernel.getInstance().stage.stageWidth - param1.Iso.width + GameKernel.fullRect.x;
         AlignManager.GetInstance().ResetRightAlignWidth(this._wrapper);
         this._wrapper.addChild(param1.Iso);
         this.showProgressList();
      }
      
      public function Sort() : void
      {
         var _loc2_:ProgressEntryIso = null;
         if(this._progressList == null || this._progressList.length == 0)
         {
            return;
         }
         this.reSet();
         var _loc1_:int = 0;
         while(_loc1_ < this._progressList.length)
         {
            _loc2_ = this._progressList[_loc1_] as ProgressEntryIso;
            _loc2_.Iso.y -= (_loc1_ + 1) * (_loc2_.Iso.height + ProgressListToolBarWidget.INTERVAL);
            _loc1_++;
         }
      }
      
      internal function reSet() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._progressList.length)
         {
            ProgressEntryIso(this._progressList[_loc1_]).Iso.y = 0;
            _loc1_++;
         }
      }
      
      internal function getProgressIndex(param1:ProgressEntryIso) : int
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
      
      public function getProgressIsoByEquiment(param1:Equiment) : ProgressEntryIso
      {
         if(this._progressList == null || this._progressList.length == 0)
         {
            return null;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this._progressList.length)
         {
            if(ProgressEntryIso(this._progressList[_loc2_]).Construction.EquimentInfoData.IndexId == param1.EquimentInfoData.IndexId)
            {
               return this._progressList[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      private function destoryProgressEntry(param1:ProgressEntryIso) : void
      {
         var _loc2_:int = 0;
         if(this._progressList.length)
         {
            _loc2_ = this.getProgressIndex(param1);
            param1 = this._progressList[_loc2_];
            param1.Clear();
            this.Sort();
         }
      }
      
      public function Destory(param1:Equiment) : void
      {
         var _loc2_:ProgressEntryIso = null;
         var _loc3_:int = 0;
         if(this._progressList.length)
         {
            _loc2_ = this.getProgressIsoByEquiment(param1);
            _loc3_ = this.getProgressIndex(_loc2_);
            if(_loc3_ == -1)
            {
               return;
            }
            if(_loc2_)
            {
               _loc2_.Clear();
            }
            if(Boolean(_loc2_.Iso) && Boolean(_loc2_.Iso.parent))
            {
               this._wrapper.removeChild(_loc2_.Iso);
            }
            this._progressList.splice(_loc3_,1);
            this.Sort();
         }
      }
      
      public function ClearAllProgressIso() : void
      {
         var _loc1_:ProgressEntryIso = null;
         if(this._progressList.length == 0)
         {
            this.HideProgressList();
            return;
         }
         for each(_loc1_ in this._progressList)
         {
            this.destoryProgressEntry(_loc1_);
         }
         ObjectUtil.ClearArray(this._progressList);
         this.HideProgressList();
      }
   }
}

