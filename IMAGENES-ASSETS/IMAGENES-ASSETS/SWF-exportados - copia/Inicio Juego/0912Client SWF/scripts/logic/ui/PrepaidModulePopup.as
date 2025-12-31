package logic.ui
{
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.managers.StringManager;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.game.GameKernel;
   import logic.impl.IModulePopUp;
   import logic.impl.IPopUp;
   import logic.manager.GameInterActiveManager;
   import logic.ui.info.BleakingLineForThai;
   import logic.widget.ConstructionOperationWidget;
   import logic.widget.OperationEnum;
   
   public class PrepaidModulePopup implements IModulePopUp
   {
      
      private static var instance:PrepaidModulePopup;
      
      protected var _name:String;
      
      protected var _popWnd:MovieClip;
      
      protected var _content:TextField;
      
      protected var _okayBtn:HButton;
      
      protected var _cancelBtn:HButton;
      
      private var _parent:IPopUp;
      
      private var _String:String;
      
      public function PrepaidModulePopup()
      {
         super();
      }
      
      public static function getInstance() : PrepaidModulePopup
      {
         if(instance == null)
         {
            instance = new PrepaidModulePopup();
         }
         return instance;
      }
      
      public function setParent(param1:IPopUp) : void
      {
         this._parent = param1;
      }
      
      public function setString(param1:String) : void
      {
         this._String = param1;
      }
      
      public function Init() : void
      {
         if(this._popWnd)
         {
            this.setTFState();
            GameInterActiveManager.InstallInterActiveEvent(this._okayBtn.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
            GameInterActiveManager.InstallInterActiveEvent(this._cancelBtn.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
            return;
         }
         this._popWnd = GameKernel.getMovieClipInstance("PrepaidPopup",400,250);
         this._content = this._popWnd.tf_content as TextField;
         this._okayBtn = new HButton(this._popWnd.btn_prepaid);
         this._cancelBtn = new HButton(this._popWnd.btn_cancel);
         this.setTFState();
         GameInterActiveManager.InstallInterActiveEvent(this._okayBtn.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
         GameInterActiveManager.InstallInterActiveEvent(this._cancelBtn.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
      }
      
      private function setTFState() : void
      {
         if(this._content == null)
         {
            return;
         }
         switch(ConstructionOperationWidget.currenCmd)
         {
            case OperationEnum.OPERATION_TYPE_NOCASH:
               if(this._String == "commandercard")
               {
                  this._String = "";
                  this._content.text = "  " + StringManager.getInstance().getMessageString("CommanderText13");
               }
               else
               {
                  this._content.text = "  " + StringManager.getInstance().getMessageString("ShipText20");
               }
               BleakingLineForThai.GetInstance().BleakThaiLanguage(this._content,16711680);
         }
         this._content.textColor = 16711680;
      }
      
      public function Show() : void
      {
         if(this._parent)
         {
            this._parent.Invalid(false);
         }
         if(GameKernel.renderManager.getUI().getContainer().contains(this._popWnd))
         {
            return;
         }
         this.AddEvent();
         GameKernel.renderManager.lockScene(true);
         GameKernel.renderManager.getUI().addComponent(this._popWnd);
      }
      
      public function getModulePopUp() : DisplayObject
      {
         return this._popWnd;
      }
      
      public function AddEvent() : void
      {
         GameInterActiveManager.InstallInterActiveEvent(this._okayBtn.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
         GameInterActiveManager.InstallInterActiveEvent(this._cancelBtn.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
      }
      
      public function Remove() : void
      {
         GameInterActiveManager.unInstallnterActiveEvent(this._okayBtn.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
         GameInterActiveManager.unInstallnterActiveEvent(this._cancelBtn.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
      }
      
      public function Hide(param1:Boolean = false) : void
      {
         if(GameKernel.renderManager.getUI().getContainer().contains(this._popWnd))
         {
            if(this._parent)
            {
               this._parent.Invalid(true);
            }
            GameKernel.renderManager.getUI().removeComponent(this._popWnd);
            GameKernel.renderManager.lockScene(false);
            this.Remove();
         }
      }
      
      private function onHandler(param1:MouseEvent) : void
      {
         this._okayBtn.setBtnDisabled(false);
         switch(param1.target.name)
         {
            case "btn_prepaid":
               GameKernel.navigateURL(GamePlayer.getInstance().MvpUrl);
               break;
            case "btn_cancel":
         }
         this.Hide(true);
      }
   }
}

