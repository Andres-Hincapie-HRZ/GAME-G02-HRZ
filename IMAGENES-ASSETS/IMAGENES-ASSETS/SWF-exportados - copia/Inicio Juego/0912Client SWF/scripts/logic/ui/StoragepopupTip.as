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
   import logic.manager.GameInterActiveManager;
   import logic.utils.MoveEfect;
   import net.base.NetManager;
   import net.msg.sciencesystem.MSG_REQUEST_ADDPACK;
   
   public class StoragepopupTip implements IModulePopUp
   {
      
      private static var instance:StoragepopupTip;
      
      private var content:MovieClip;
      
      private var bo:Boolean = false;
      
      private var mc_build:HButton;
      
      protected var _popWnd:MovieClip;
      
      private var mc_cancel:HButton;
      
      private var heise:MovieClip;
      
      private var oopen:int = 0;
      
      public function StoragepopupTip()
      {
         super();
      }
      
      public static function getInstance() : StoragepopupTip
      {
         if(instance == null)
         {
            instance = new StoragepopupTip();
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
         this._popWnd = GameKernel.getMovieClipInstance("Storagepopup");
         this._popWnd.x = GameKernel.getInstance().stage.stageWidth - this._popWnd.width * 0.5 >> 1;
         this._popWnd.x += this._popWnd.width * 0.25;
         this._popWnd.y = 300;
         this.initMcElement();
      }
      
      public function initMcElement() : void
      {
         this.content = this._popWnd;
         TextField(this.content.tf_title).wordWrap = true;
         this.mc_cancel = new HButton(this.content.btn_close);
         this.mc_build = new HButton(this.content.btn_open);
      }
      
      public function ppd(param1:int = 0) : void
      {
         this.oopen = param1;
         if(param1 == 0)
         {
            if(GamePlayer.getInstance().UserMoney < GamePlayer.getInstance().AddPackMoney)
            {
               TextField(this.content.tf_title).text = StringManager.getInstance().getMessageString("BagTXT01") + GamePlayer.getInstance().AddPackMoney + StringManager.getInstance().getMessageString("BagTXT02");
               this.bo = false;
               this.mc_build.setBtnDisabled(true);
            }
            else
            {
               TextField(this.content.tf_title).text = StringManager.getInstance().getMessageString("BagTXT03") + GamePlayer.getInstance().AddPackMoney + StringManager.getInstance().getMessageString("BagTXT04");
               this.mc_build.setBtnDisabled(false);
               this.bo = true;
            }
         }
         else if(param1 == 1 || param1 == 2)
         {
            TextField(this.content.tf_title).text = StringManager.getInstance().getMessageString("CommanderText12");
            this.bo = true;
            this.mc_build.setBtnDisabled(false);
         }
         if(this.heise != null && this.content.contains(this.heise))
         {
            this.content.removeChild(this.heise);
         }
         this.heise = new MovieClip();
         MoveEfect.getInstance().BlackHd(this.content,this.heise);
         this.content.setChildIndex(this.heise,0);
      }
      
      private function openHd(param1:MouseEvent) : void
      {
         if(!this.bo)
         {
            return;
         }
         if(this.oopen == 2)
         {
            TextField(this.content.tf_title).text = StringManager.getInstance().getMessageString("BagTXT15");
            this.bo = false;
            this.mc_build.setBtnDisabled(true);
            return;
         }
         if(GamePlayer.getInstance().UserMoney < GamePlayer.getInstance().AddPackMoney)
         {
            TextField(this.content.tf_title).text = StringManager.getInstance().getMessageString("BagTXT01") + GamePlayer.getInstance().AddPackMoney + StringManager.getInstance().getMessageString("BagTXT02");
            this.bo = false;
            this.mc_build.setBtnDisabled(true);
            return;
         }
         this.mc_build.setBtnDisabled(true);
         var _loc2_:MSG_REQUEST_ADDPACK = new MSG_REQUEST_ADDPACK();
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc2_);
         this.close();
      }
      
      private function closeHd(param1:MouseEvent) : void
      {
         this.Hide(true);
      }
      
      public function close() : void
      {
         this.Hide(true);
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
         this.mc_build.setBtnDisabled(false);
         switch(param1.target.name)
         {
            case "btn_open":
               this.openHd(param1);
               break;
            case "btn_close":
               this.closeHd(param1);
         }
      }
   }
}

