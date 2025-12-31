package logic.ui
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.facebook.FacebookClient;
   import com.star.frameworks.module.IModule;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import logic.entry.GamePlayer;
   import logic.entry.MObject;
   import logic.game.GameKernel;
   import logic.manager.GameInterActiveManager;
   import net.base.NetManager;
   import net.msg.MSG_REQUEST_CREATEROLEINFO;
   
   public class FillGamePlayerInfoUI implements IModule
   {
      
      private static var instance:FillGamePlayerInfoUI;
      
      private var mTipTxt:TextField;
      
      private var mBg:Container;
      
      private var playerNameTXT:TextField;
      
      private var InfoUI:MObject;
      
      private var okayBtn:SimpleButton;
      
      public function FillGamePlayerInfoUI()
      {
         super();
      }
      
      public static function getInstance() : FillGamePlayerInfoUI
      {
         if(instance == null)
         {
            instance = new FillGamePlayerInfoUI();
         }
         return instance;
      }
      
      public function get PlayerNameTxt() : TextField
      {
         return this.playerNameTXT;
      }
      
      public function get Tip() : TextField
      {
         return this.mTipTxt;
      }
      
      public function Init() : void
      {
         if(this.InfoUI != null)
         {
            GameInterActiveManager.InstallInterActiveEvent(this.okayBtn,ActionEvent.ACTION_CLICK,this.onCreate);
            GameKernel.renderManager.getScene().addComponent(this.InfoUI);
            return;
         }
         this.InfoUI = new MObject("ChangenameMc",400,300);
         this.mBg = new Container();
         this.mBg.fillRectangleWithoutBorder(GameKernel.fullRect.x,GameKernel.fullRect.y,GameKernel.fullRect.width,GameKernel.fullRect.height);
         this.playerNameTXT = this.InfoUI.getMC().tf_input as TextField;
         if(GamePlayer.getInstance().DefaultName != "" && GamePlayer.getInstance().DefaultName != null)
         {
            this.playerNameTXT.text = GamePlayer.getInstance().DefaultName;
         }
         else if(FacebookClient.GetSelfInfo() != null)
         {
            this.playerNameTXT.text = FacebookClient.GetSelfInfo().first_name;
         }
         this.okayBtn = this.InfoUI.getMC().btn_ensure as SimpleButton;
         this.mTipTxt = this.InfoUI.getMC().tf_txt as TextField;
         GameInterActiveManager.InstallInterActiveEvent(this.okayBtn,ActionEvent.ACTION_CLICK,this.onCreate);
         GameKernel.renderManager.getScene().addComponent(this.mBg);
         GameKernel.renderManager.getScene().addComponent(this.InfoUI);
      }
      
      public function getUI() : MObject
      {
         return this.InfoUI;
      }
      
      public function SetVisible(param1:Boolean) : void
      {
      }
      
      private function onCreate(param1:MouseEvent) : void
      {
         if(this.playerNameTXT.text == null || this.playerNameTXT.text == "")
         {
            return;
         }
         var _loc2_:MSG_REQUEST_CREATEROLEINFO = new MSG_REQUEST_CREATEROLEINFO();
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         _loc2_.Name = this.playerNameTXT.text;
         _loc2_.roleHeadID = 0;
         NetManager.Instance().sendData(_loc2_);
      }
      
      public function Release() : void
      {
         GameInterActiveManager.unInstallnterActiveEvent(this.okayBtn,ActionEvent.ACTION_CLICK,this.onCreate);
         GameKernel.renderManager.getScene().removeComponent(this.mBg);
         GameKernel.renderManager.getScene().removeComponent(this.InfoUI);
      }
   }
}

