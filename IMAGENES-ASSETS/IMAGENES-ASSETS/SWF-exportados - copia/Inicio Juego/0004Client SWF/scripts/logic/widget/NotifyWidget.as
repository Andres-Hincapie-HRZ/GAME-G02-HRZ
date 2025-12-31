package logic.widget
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.managers.StringManager;
   import logic.entry.CNotify;
   import logic.game.GameKernel;
   import logic.ui.AlignManager;
   import logic.ui.TaskSceneUI;
   
   public class NotifyWidget
   {
      
      private static var instance:NotifyWidget;
      
      public static const NOTIFY_EMAIL:int = 0;
      
      public static const NOTIFY_TASK:int = 1;
      
      private var container:Container;
      
      private var iconList:Array;
      
      public function NotifyWidget()
      {
         super();
         this.iconList = new Array();
         this.container = new Container();
         this.container.x = 230;
         this.container.y = 50;
         AlignManager.GetInstance().SetAlign(this.container,"left");
      }
      
      public static function getInstance() : NotifyWidget
      {
         if(instance == null)
         {
            instance = new NotifyWidget();
         }
         return instance;
      }
      
      public function get NofityContainer() : Container
      {
         return this.container;
      }
      
      public function Hide() : void
      {
         if(Boolean(this.container) && this.container.parent != null)
         {
            this.container.parent.removeChild(this.container);
         }
      }
      
      public function Show() : void
      {
         if(Boolean(this.container) && this.container.parent == null)
         {
            if(this.iconList.length == 0)
            {
               return;
            }
            GameKernel.renderManager.getUI().addComponent(this.container);
         }
      }
      
      public function addNotify(param1:int) : void
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         if(param1 == 1)
         {
            _loc4_ = GameKernel.gameLayout.getInstallUI("ChatScene").y;
            TaskNotifyWidget.GetInstance().Init();
            TaskNotifyWidget.GetInstance().SetY(_loc4_ - 70);
            _loc3_ = StringManager.getInstance().getMessageString("ChatingTXT15") + "\n\n" + StringManager.getInstance().getMessageString("TaskText9") + TaskSceneUI._TaskName;
            TaskNotifyWidget.GetInstance().SetTaskDesc(_loc3_);
            TaskNotifyWidget.GetInstance().SetParent(GameKernel.renderManager.getUI().getContainer());
            TaskNotifyWidget.GetInstance().Show();
            return;
         }
         var _loc2_:CNotify = new CNotify(param1);
         if(!this.isExists(_loc2_.Type))
         {
            this.iconList.push(_loc2_);
            this.showNotify(_loc2_);
         }
      }
      
      public function removeNotify(param1:int) : void
      {
         var _loc2_:CNotify = null;
         if(this.isExists(param1))
         {
            _loc2_ = this.getNofityByType(param1);
            if(_loc2_ != null)
            {
               this.destoryNotify(_loc2_);
            }
            this.Sort();
         }
      }
      
      private function isExists(param1:int) : Boolean
      {
         var _loc2_:CNotify = null;
         if(this.iconList == null || this.iconList.length == 0)
         {
            return false;
         }
         for each(_loc2_ in this.iconList)
         {
            if(_loc2_.Type == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function showNotify(param1:CNotify) : void
      {
         if(this.iconList == null || this.iconList.length == 0)
         {
            return;
         }
         var _loc2_:int = int(this.iconList.length);
         if(param1 == null)
         {
            return;
         }
         param1.x += _loc2_ * (param1.width + 10);
         this.container.addChild(param1);
         if(!GameKernel.renderManager.getUI().getContainer().contains(this.container))
         {
            GameKernel.renderManager.getUI().getContainer().addChild(this.container);
         }
      }
      
      public function hideQueue(param1:CNotify) : void
      {
         if(Boolean(param1) && Boolean(param1.parent))
         {
            param1.Release();
            this.container.removeChild(param1);
         }
      }
      
      public function Sort() : void
      {
         var _loc2_:CNotify = null;
         if(this.iconList == null || this.iconList.length == 0)
         {
            if(GameKernel.renderManager.getUI().getContainer().contains(this.container))
            {
               GameKernel.renderManager.getUI().getContainer().removeChild(this.container);
            }
            return;
         }
         this.reSet();
         var _loc1_:int = 0;
         while(_loc1_ < this.iconList.length)
         {
            _loc2_ = this.iconList[_loc1_] as CNotify;
            _loc2_.x += (_loc1_ + 1) * (_loc2_.width + 10);
            _loc1_++;
         }
      }
      
      internal function reSet() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.iconList.length)
         {
            CNotify(this.iconList[_loc1_]).x = 0;
            _loc1_++;
         }
      }
      
      internal function getNotifyIndex(param1:CNotify) : int
      {
         if(this.iconList == null || this.iconList.length == 0)
         {
            return -1;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this.iconList.length)
         {
            if(param1 == this.iconList[_loc2_])
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      internal function getNofityByType(param1:int) : CNotify
      {
         var _loc2_:CNotify = null;
         if(this.isExists(param1))
         {
            for each(_loc2_ in this.iconList)
            {
               if(_loc2_.Type == param1)
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      internal function destoryNotify(param1:CNotify) : void
      {
         var _loc2_:int = 0;
         if(this.iconList.length)
         {
            _loc2_ = this.getNotifyIndex(param1);
            if(_loc2_ != -1)
            {
               this.hideQueue(param1);
               this.iconList.splice(_loc2_,1);
            }
         }
      }
   }
}

