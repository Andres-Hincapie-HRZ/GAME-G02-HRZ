package logic.widget
{
   import com.star.frameworks.events.ActionEvent;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import logic.entry.MObject;
   import logic.game.GameKernel;
   import logic.manager.GameInterActiveManager;
   import logic.ui.AlignManager;
   import logic.ui.ChatUI;
   import logic.ui.TaskSceneUI;
   import logic.widget.textarea.CChatController;
   import logic.widget.textarea.CTextArea;
   
   public class TaskNotifyWidget
   {
      
      private static var m_Instance:TaskNotifyWidget = null;
      
      private var m_IsShow:Boolean;
      
      private var m_UI:MObject;
      
      private var m_TaskDesc:TextField;
      
      private var m_Parent:DisplayObjectContainer;
      
      public function TaskNotifyWidget()
      {
         super();
      }
      
      public static function GetInstance() : TaskNotifyWidget
      {
         if(m_Instance == null)
         {
            m_Instance = new TaskNotifyWidget();
         }
         return m_Instance;
      }
      
      public function Init() : void
      {
         if(this.m_UI == null)
         {
            this.m_UI = new MObject("TaskoverMc",65);
            this.m_TaskDesc = this.m_UI.getMC().tf_txt as TextField;
            AlignManager.GetInstance().SetAlign(this.m_UI.getMC(),"left");
         }
      }
      
      public function setFullLocation(param1:Boolean) : void
      {
         if(this.m_UI == null)
         {
            return;
         }
         var _loc2_:MovieClip = this.m_UI.getMC();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:DisplayObject = GameKernel.gameLayout.getInstallUI("ChatScene");
         var _loc4_:CTextArea = ChatUI.getInstance().TextArea;
         if(param1)
         {
            switch(CChatController.State)
            {
               case 0:
                  _loc2_.y = GameKernel.fullRect.height - ChatUI.chatUIHeight - 70;
                  break;
               default:
                  _loc2_.y = GameKernel.fullRect.height - _loc4_.height - 50;
            }
         }
         else
         {
            switch(CChatController.State)
            {
               case 0:
                  _loc2_.y = CChatController.getInstance().firstY - 70;
                  break;
               case 1:
                  _loc2_.y = CChatController.getInstance().firstY - CChatController.DIFF - 70;
                  break;
               case 2:
                  _loc2_.y = CChatController.getInstance().firstY - 2 * CChatController.DIFF - 70;
            }
         }
      }
      
      public function SetParent(param1:DisplayObjectContainer) : void
      {
         this.m_Parent = param1;
      }
      
      public function SetTaskDesc(param1:String) : void
      {
         if(this.m_TaskDesc)
         {
            this.m_TaskDesc.multiline = true;
            this.m_TaskDesc.wordWrap = true;
            this.m_TaskDesc.autoSize = "left";
            this.m_TaskDesc.htmlText = param1;
         }
      }
      
      public function SetLocation(param1:int, param2:int) : void
      {
         if(this.m_UI)
         {
            this.m_UI.getMC().x = param1;
            this.m_UI.getMC().y = param2;
         }
      }
      
      public function SetX(param1:int) : void
      {
         if(this.m_UI)
         {
            this.m_UI.getMC().x = param1;
         }
      }
      
      public function SetY(param1:int) : void
      {
         if(this.m_UI)
         {
            this.m_UI.getMC().y = param1;
         }
      }
      
      public function GetXY() : Point
      {
         var _loc1_:MovieClip = null;
         if(this.m_UI)
         {
            _loc1_ = this.m_UI.getMC();
            return new Point(_loc1_.x,_loc1_.y);
         }
         return new Point();
      }
      
      public function Show() : void
      {
         if(this.m_Parent)
         {
            this.m_Parent.addChild(this.m_UI.getMC());
            GameInterActiveManager.InstallInterActiveEvent(this.m_UI.getMC(),ActionEvent.ACTION_CLICK,this.onHandler);
         }
         this.m_IsShow = true;
      }
      
      public function Hide() : void
      {
         if(Boolean(this.m_Parent) && Boolean(this.m_UI.getMC()))
         {
            this.m_Parent.removeChild(this.m_UI.getMC());
            GameInterActiveManager.unInstallnterActiveEvent(this.m_UI.getMC(),ActionEvent.ACTION_CLICK,this.onHandler);
         }
         this.m_IsShow = false;
      }
      
      public function IsShow() : Boolean
      {
         return this.m_IsShow;
      }
      
      private function onHandler(param1:MouseEvent) : void
      {
         this.Hide();
         TaskSceneUI.getInstance().Init();
         GameKernel.popUpDisplayManager.Show(TaskSceneUI.getInstance());
      }
   }
}

