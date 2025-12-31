package logic.ui
{
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.managers.StringManager;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.game.GameKernel;
   import logic.impl.IModulePopUp;
   import logic.manager.GameInterActiveManager;
   import net.base.NetManager;
   import net.msg.sciencesystem.MSG_REQUEST_PROPSMOVE;
   
   public class FriendspeedpopupUI implements IModulePopUp
   {
      
      private static var instance:FriendspeedpopupUI;
      
      private var content:MovieClip;
      
      private var max:int;
      
      private var firs:Boolean = true;
      
      private var proid:int;
      
      private var flog:int;
      
      private var leix:int;
      
      private var mc_build:HButton;
      
      protected var _popWnd:MovieClip;
      
      private var mc_cancel:HButton;
      
      private var jy:int = 1;
      
      public function FriendspeedpopupUI()
      {
         super();
      }
      
      public static function getInstance() : FriendspeedpopupUI
      {
         if(instance == null)
         {
            instance = new FriendspeedpopupUI();
         }
         return instance;
      }
      
      public function Init() : void
      {
         if(this._popWnd)
         {
            GameInterActiveManager.unInstallnterActiveEvent(this.mc_build.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
            GameInterActiveManager.unInstallnterActiveEvent(this.mc_cancel.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
            return;
         }
         this._popWnd = GameKernel.getMovieClipInstance("Addfriendpopup");
         this._popWnd.x = GameKernel.getInstance().stage.stageWidth - this._popWnd.width * 0.5 >> 1;
         this._popWnd.x += this._popWnd.width * 0.25;
         this._popWnd.y = 300;
         this.initMcElement();
      }
      
      public function initMcElement() : void
      {
         this.content = this._popWnd;
         this.mc_cancel = new HButton(this.content.btn_cancel);
         this.mc_build = new HButton(this.content.btn_ensure);
         TextField(this.content.tf_id).restrict = "0-9";
         TextField(this.content.tf_title).text = StringManager.getInstance().getMessageString("ItemText16");
         GameInterActiveManager.unInstallnterActiveEvent(this.mc_build.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
         GameInterActiveManager.unInstallnterActiveEvent(this.mc_cancel.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
      }
      
      public function pdd(param1:int, param2:int, param3:int, param4:int = 0) : void
      {
         this.max = param1;
         this.proid = param2;
         this.flog = param3;
         this.leix = param4;
         this.content.tf_id.text = this.max;
         if(this.firs)
         {
            TextField(this.content.tf_id).addEventListener(Event.CHANGE,this.changeHd);
            this.firs = false;
            return;
         }
      }
      
      private function changeHd(param1:Event) : void
      {
         if(this.content.tf_id.text == "")
         {
            this.content.tf_id.text = this.jy;
         }
         if(this.content.tf_id.text >= this.max)
         {
            this.content.tf_id.text = this.max.toString();
         }
         else if(this.content.tf_id.text <= 0)
         {
            this.content.tf_id.text = 1;
         }
         this.jy = this.content.tf_id.text;
      }
      
      private function clHd(param1:MouseEvent) : void
      {
         if(int(this.content.tf_id.text) == 0)
         {
            this.close();
            return;
         }
         var _loc2_:MSG_REQUEST_PROPSMOVE = new MSG_REQUEST_PROPSMOVE();
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         _loc2_.Type = this.leix;
         _loc2_.PropsId = this.proid;
         _loc2_.PropsNum = int(this.content.tf_id.text);
         _loc2_.LockFlag = this.flog;
         NetManager.Instance().sendObject(_loc2_);
         this.close();
      }
      
      private function closeHd(param1:MouseEvent) : void
      {
         this.close();
      }
      
      public function close() : void
      {
         this.Hide(true);
         PackUi.getInstance().Hider(1);
      }
      
      public function Show() : void
      {
         if(GameKernel.renderManager.getUI().getContainer().contains(this._popWnd))
         {
            return;
         }
         this.AddEvent();
         GameKernel.renderManager.lockScene(true);
         GameKernel.renderManager.getUI().addComponent(this._popWnd);
      }
      
      public function Hide(param1:Boolean = false) : void
      {
         if(GameKernel.renderManager.getUI().getContainer().contains(this._popWnd))
         {
            GameKernel.renderManager.getUI().removeComponent(this._popWnd);
            GameKernel.renderManager.lockScene(false);
            this.Remove();
         }
      }
      
      public function getModulePopUp() : DisplayObject
      {
         return this._popWnd;
      }
      
      public function AddEvent() : void
      {
         GameInterActiveManager.InstallInterActiveEvent(this.mc_build.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
         GameInterActiveManager.InstallInterActiveEvent(this.mc_cancel.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
      }
      
      public function Remove() : void
      {
         GameInterActiveManager.unInstallnterActiveEvent(this.mc_build.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
         GameInterActiveManager.unInstallnterActiveEvent(this.mc_cancel.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
      }
      
      private function onHandler(param1:MouseEvent) : void
      {
         switch(param1.target.name)
         {
            case "btn_ensure":
               this.clHd(param1);
               break;
            case "btn_cancel":
               this.closeHd(param1);
         }
      }
   }
}

