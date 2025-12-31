package logic.ui
{
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.geom.RectangleKit;
   import com.star.frameworks.managers.FontManager;
   import com.star.frameworks.module.IModule;
   import com.star.frameworks.net.NetEvent;
   import com.star.frameworks.utils.StringUitl;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import logic.entry.EffectShake2;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.game.GameKernel;
   import logic.manager.GameInterActiveManager;
   import logic.widget.DataWidget;
   import net.base.NetManager;
   
   public class LoginUI implements IModule
   {
      
      private static var instance:LoginUI = null;
      
      private var loginWnd:MObject = null;
      
      private var loginBtn:HButton = null;
      
      private var accText:TextField = null;
      
      private var pwdText:TextField = null;
      
      private var m_RepeatSendAuth:int;
      
      private var mm:MovieClip = new MovieClip();
      
      private var count:int = 0;
      
      private var shake:EffectShake2;
      
      public function LoginUI()
      {
         super();
      }
      
      public static function getInstance() : LoginUI
      {
         if(instance == null)
         {
            instance = new LoginUI();
         }
         return instance;
      }
      
      public function Init() : void
      {
         if(GameKernel.platform == 2)
         {
            GameKernel.gameLayout.InstallUI("LoginScene",new RectangleKit(300,200));
         }
         else
         {
            GameKernel.gameLayout.InstallUI("LoginScene",new RectangleKit(200,200));
         }
         this.loginWnd = GameKernel.gameLayout.getInstallUI("LoginScene") as MObject;
         this.accText = this.loginWnd.getMC().tf_name as TextField;
         this.accText.multiline = false;
         this.accText.text = "147";
         FontManager.applyTextFormat(this.accText,14);
         this.pwdText = this.loginWnd.getMC().tf_code as TextField;
         this.loginBtn = new HButton(this.loginWnd.getMC().mc_ok);
         GameKernel.renderManager.getUI().addComponent(this.loginWnd);
         GameInterActiveManager.InstallInterActiveEvent(this.loginBtn.m_movie,ActionEvent.ACTION_CLICK,this.__onLogin);
         var _loc1_:String = DataWidget.secondFormatToTime(3600 * 25 + 1231);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         this.mm.addEventListener(Event.ENTER_FRAME,this.onFrame);
         this.mm.addEventListener(Event.EXIT_FRAME,this.onExit);
      }
      
      private function onFrame(param1:Event) : void
      {
         if(this.count == 10)
         {
            this.mm.removeEventListener(Event.ENTER_FRAME,this.onFrame);
            this.count = 0;
            return;
         }
         ++this.count;
      }
      
      private function onExit(param1:Event) : void
      {
         this.mm.removeEventListener(Event.EXIT_FRAME,this.onExit);
      }
      
      public function onOver(param1:MouseEvent) : void
      {
         this.shake.start(param1.currentTarget.name);
      }
      
      public function onOut(param1:MouseEvent) : void
      {
         this.shake.stop();
      }
      
      public function getUI() : MObject
      {
         return this.loginWnd;
      }
      
      private function mmDown(param1:Event) : void
      {
         this.mm.startDrag();
      }
      
      private function mmUp(param1:Event) : void
      {
         this.mm.stopDrag();
      }
      
      public function SetVisible(param1:Boolean) : void
      {
         GameKernel.renderManager.Show(this,param1);
      }
      
      public function Release() : void
      {
         if(this.loginWnd == null)
         {
            return;
         }
         this.loginWnd.removeMc();
         this.loginWnd = null;
      }
      
      private function __onLogin(param1:MouseEvent) : void
      {
         if(this.accText.text == "" && this.pwdText.text == "")
         {
            return;
         }
         GamePlayer.getInstance().userID = Number(StringUitl.Trim(this.accText.text));
         NetManager.Instance().OnLogin(Number(StringUitl.Trim(this.accText.text)),StringUitl.Trim(this.pwdText.text));
         this.Release();
         GameKernel.renderManager.showLoadingMc(true);
      }
      
      private function onLogin() : void
      {
         NetManager.Instance().OnLogin(GamePlayer.getInstance().userID,GamePlayer.getInstance().sessionKey);
      }
      
      private function __onConnect(param1:NetEvent) : void
      {
      }
      
      public function Resp_MSG_GAMESERVER_LOGINRESP(param1:ByteArray) : void
      {
         var _loc2_:int = param1.readByte();
         if(!_loc2_)
         {
            MainUI.getInstance().Init();
            GameKernel.getInstance().initFaceBook();
         }
      }
      
      private function __onClose(param1:NetEvent) : void
      {
      }
   }
}

