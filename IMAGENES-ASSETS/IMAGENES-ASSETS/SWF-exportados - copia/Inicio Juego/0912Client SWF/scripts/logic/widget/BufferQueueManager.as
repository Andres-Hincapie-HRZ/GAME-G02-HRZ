package logic.widget
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.utils.ObjectUtil;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import logic.action.ConstructionAction;
   import logic.entry.GStar;
   import logic.entry.GamePlayer;
   import logic.game.GameKernel;
   import logic.manager.GalaxyManager;
   import logic.ui.AlignManager;
   import net.msg.constructionMsg.MSG_RESP_TIMEQUEUE_TEMP;
   
   public class BufferQueueManager
   {
      
      private static var instance:BufferQueueManager;
      
      public static var toolList:Array = [900,902,905,906,907,930,937,943,0,0,939,940,941,942];
      
      public static var curSelectTargetType:int = -1;
      
      private var _wrapper:Container;
      
      private var mBuffList:Array;
      
      private var mTime:Timer;
      
      public function BufferQueueManager()
      {
         super();
         this._wrapper = new Container();
         this._wrapper.x = 230;
         this._wrapper.y = 10;
         AlignManager.GetInstance().SetAlign(this._wrapper,"left");
         this.mBuffList = new Array();
         this.initTime();
         GameKernel.renderManager.getUI().addComponent(this._wrapper);
      }
      
      public static function getInstance() : BufferQueueManager
      {
         if(instance == null)
         {
            instance = new BufferQueueManager();
         }
         return instance;
      }
      
      public function get Wrapper() : Container
      {
         return this._wrapper;
      }
      
      public function Hide() : void
      {
         if(Boolean(this._wrapper) && this._wrapper.parent != null)
         {
            this._wrapper.parent.removeChild(this._wrapper);
         }
      }
      
      public function Show() : void
      {
         if(Boolean(this._wrapper) && this._wrapper.parent == null)
         {
            if(this.mBuffList.length == 0)
            {
               return;
            }
            GameKernel.renderManager.getUI().addComponent(this._wrapper);
         }
      }
      
      private function initTime() : void
      {
         this.mTime = new Timer(1000);
         this.mTime.addEventListener(TimerEvent.TIMER,this.onTick);
      }
      
      private function onTick(param1:TimerEvent) : void
      {
         this.syncProgress();
      }
      
      public function syncTime() : void
      {
         if(0 == this.mBuffList.length)
         {
            if(Boolean(this.mTime) && this.mTime.running)
            {
               this.mTime.stop();
            }
            return;
         }
         if(this.mTime == null)
         {
            this.initTime();
         }
         if(!this.mTime.running)
         {
            this.mTime.start();
         }
      }
      
      public function pushQueue(param1:MSG_RESP_TIMEQUEUE_TEMP) : void
      {
         var _loc3_:GStar = null;
         var _loc2_:TimeQueueBar = new TimeQueueBar(param1);
         if(!this.isExists(param1.Type))
         {
            if(param1.Type >= 10)
            {
               _loc3_ = GalaxyManager.instance.getData(GamePlayer.getInstance().galaxyID);
               if(_loc3_)
               {
                  _loc3_.StarFace = param1.Type;
                  GalaxyManager.instance.RefreshStarInfo(GamePlayer.getInstance().galaxyID);
               }
            }
            this.mBuffList.push(_loc2_);
            this.showQueue(_loc2_);
         }
      }
      
      public function isExists(param1:int) : Boolean
      {
         var _loc2_:TimeQueueBar = null;
         if(this.mBuffList == null || this.mBuffList.length == 0)
         {
            return false;
         }
         for each(_loc2_ in this.mBuffList)
         {
            if(_loc2_.Type == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getTimeQueueSpareTime(param1:int) : int
      {
         var _loc2_:TimeQueueBar = null;
         if(Boolean(this.mBuffList) && this.mBuffList.length == 0)
         {
            return 0;
         }
         for each(_loc2_ in this.mBuffList)
         {
            if(_loc2_.TimeQueue.Type == param1)
            {
               return _loc2_.TimeQueue.SpareTime;
            }
         }
         return 0;
      }
      
      private function syncProgress() : void
      {
         var _loc1_:TimeQueueBar = null;
         if(this.mBuffList.length == 0)
         {
            this.mTime.stop();
            this.mTime.removeEventListener(TimerEvent.TIMER,this.onTick);
            this.mTime = null;
            return;
         }
         for each(_loc1_ in this.mBuffList)
         {
            if(_loc1_.IsCompleted)
            {
               if(this.mBuffList.length == 1)
               {
                  this.ClearAll();
               }
               ConstructionAction.getInstance().sendTimeQueueRequest();
               this.destoryBar(_loc1_);
            }
            else
            {
               _loc1_.setProgress();
            }
         }
      }
      
      public function showQueue(param1:TimeQueueBar) : void
      {
         if(this.mBuffList == null || this.mBuffList.length == 0)
         {
            return;
         }
         var _loc2_:int = int(this.mBuffList.length);
         if(param1 == null)
         {
            return;
         }
         param1.getDisplay().x = param1.getDisplay().x + _loc2_ * (param1.getDisplay().width + 10);
         this._wrapper.addChild(param1.getDisplay());
      }
      
      public function hideQueue(param1:TimeQueueBar) : void
      {
         if(Boolean(param1) && Boolean(param1.getDisplay().parent))
         {
            this._wrapper.removeChild(param1.getDisplay());
         }
      }
      
      public function Sort() : void
      {
         var _loc2_:TimeQueueBar = null;
         if(this.mBuffList == null || this.mBuffList.length == 0)
         {
            return;
         }
         this.reSet();
         var _loc1_:int = 0;
         while(_loc1_ < this.mBuffList.length)
         {
            _loc2_ = this.mBuffList[_loc1_] as TimeQueueBar;
            _loc2_.getDisplay().x = _loc2_.getDisplay().x - (_loc1_ + 1) * (_loc2_.getDisplay().width + 10);
            _loc1_++;
         }
      }
      
      internal function reSet() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.mBuffList.length)
         {
            TimeQueueBar(this.mBuffList[_loc1_]).getDisplay().x = 0;
            _loc1_++;
         }
      }
      
      internal function getQueueBarindex(param1:TimeQueueBar) : int
      {
         if(this.mBuffList == null || this.mBuffList.length == 0)
         {
            return -1;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this.mBuffList.length)
         {
            if(param1 == this.mBuffList[_loc2_])
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      public function destoryBar(param1:TimeQueueBar) : void
      {
         var _loc2_:int = 0;
         if(this.mBuffList.length)
         {
            _loc2_ = this.getQueueBarindex(param1);
            if(_loc2_ != -1)
            {
               if(Boolean(param1.getDisplay()) && Boolean(param1.getDisplay().parent))
               {
                  param1.getDisplay().parent.removeChild(param1.getDisplay());
                  param1.Destory();
               }
            }
         }
      }
      
      public function GC() : void
      {
         var _loc1_:TimeQueueBar = null;
         if(this.mBuffList.length)
         {
            for each(_loc1_ in this.mBuffList)
            {
               if(_loc1_.IsCompleted)
               {
                  this.destoryBar(_loc1_);
               }
            }
         }
      }
      
      public function ClearAll() : void
      {
         var _loc2_:TimeQueueBar = null;
         if(this.mBuffList.length)
         {
            for each(_loc2_ in this.mBuffList)
            {
               this.destoryBar(_loc2_);
            }
         }
         var _loc1_:int = 0;
         while(_loc1_ < this._wrapper.numChildren)
         {
            this._wrapper.removeChildAt(_loc1_);
            _loc1_++;
         }
         ObjectUtil.ClearArray(this.mBuffList);
      }
   }
}

