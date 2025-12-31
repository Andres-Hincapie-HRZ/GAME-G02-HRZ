package logic.ui
{
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.managers.RenderManager;
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.module.IModule;
   import com.star.frameworks.utils.StringUitl;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import logic.entry.GamePlayer;
   import logic.entry.GameServerItem;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.game.GameKernel;
   import logic.game.GameSetting;
   import logic.manager.GameInterActiveManager;
   import net.base.NetManager;
   import net.base.NetRouter;
   import net.msg.MSG_LOGINSERVER_GAMESERVERLISTRESP_TEMP;
   
   public class GameServerListUI implements IModule
   {
      
      private static var m_Instance:GameServerListUI;
      
      private var m_refence:int;
      
      private var m_StatueMc:MovieClip;
      
      private var m_PlayerName:TextField;
      
      private var m_ErrorTip:TextField;
      
      private var m_CurrentServerItem:GameServerItem;
      
      private var m_ServerName:TextField;
      
      private var m_SelectServerId:int;
      
      private var m_newServerID:int;
      
      private var m_OkayBtn:SimpleButton;
      
      private var m_ServerListArray:Array;
      
      private var m_listPlanMc:MObject;
      
      private var m_Wnd:MObject;
      
      private var btn_server:HButton;
      
      private var m_DefaultStr:String;
      
      private var LimitArray:Array = new Array(":","<",">",",",".","&","\'","\"","/","\\");
      
      public function GameServerListUI()
      {
         super();
         this.m_refence = 0;
         this.m_SelectServerId = -1;
      }
      
      public static function GetInstance() : GameServerListUI
      {
         if(m_Instance == null)
         {
            m_Instance = new GameServerListUI();
         }
         return m_Instance;
      }
      
      public function Init() : void
      {
         if(this.m_Wnd != null)
         {
            return;
         }
         RenderManager.getInstance().showLoadingMc(false);
         this.m_Wnd = new MObject("SelectedServerMc") as MObject;
         this.m_Wnd.x = GameSetting.GAME_STAGE_WIDTH * 0.5;
         this.m_Wnd.y = GameKernel.getInstance().stage.stageHeight * 0.5;
         this.m_OkayBtn = this.m_Wnd.getMC().btn_ensure as SimpleButton;
         this.btn_server = new HButton(this.m_Wnd.getMC().btn_server);
         this.m_StatueMc = this.m_Wnd.getMC().mc_state as MovieClip;
         this.m_PlayerName = this.m_Wnd.getMC().tf_input as TextField;
         this.m_ErrorTip = this.m_Wnd.getMC().tf_txt as TextField;
         this.m_ServerName = this.btn_server.m_movie.tf_name as TextField;
         this.m_DefaultStr = StringUitl.Trim(StringManager.getInstance().getMessageString("Server35"));
         if(GamePlayer.getInstance().DefaultName != "" && GamePlayer.getInstance().DefaultName != null)
         {
            this.m_PlayerName.text = GamePlayer.getInstance().DefaultName;
         }
         else
         {
            this.m_PlayerName.text = this.m_DefaultStr;
         }
         GameServerItemUI.GetInstance().SetDefaultState();
         GameInterActiveManager.InstallInterActiveEvent(this.m_PlayerName,ActionEvent.ACTION_CLICK,this.onEnterNewName);
         GameInterActiveManager.InstallInterActiveEvent(this.btn_server.m_movie,ActionEvent.ACTION_CLICK,this.onGameServerHandler);
         GameInterActiveManager.InstallInterActiveEvent(this.m_OkayBtn,ActionEvent.ACTION_CLICK,this.onOkayHandler);
         GameKernel.renderManager.getUI().addComponent(this.m_Wnd);
      }
      
      public function SetCurrentSelectServerStatue() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this.m_SelectServerId == -1)
         {
            _loc1_ = this.SearchServerCountByServerId(GamePlayer.getInstance().DefaultServerId);
         }
         else
         {
            _loc1_ = this.SearchServerCountByServerId(this.m_SelectServerId);
         }
         if(_loc1_ == 0)
         {
            _loc2_ = 1;
         }
         else
         {
            _loc2_ = int(_loc1_ / GameSetting.SERVER_INTERVAL) + 2;
         }
         _loc2_ = Math.min(_loc2_,GameSetting.SERVER_MAX_STATUE);
         if(this.m_StatueMc)
         {
            this.m_StatueMc.gotoAndStop(_loc2_);
         }
      }
      
      private function SearchServerCountByServerId(param1:int) : int
      {
         var _loc2_:MSG_LOGINSERVER_GAMESERVERLISTRESP_TEMP = null;
         if(this.m_ServerListArray == null)
         {
            return 0;
         }
         for each(_loc2_ in this.m_ServerListArray)
         {
            if(_loc2_.ServerId == param1)
            {
               return _loc2_.OnlineCount;
            }
         }
         return 0;
      }
      
      public function set ServerID(param1:int) : void
      {
         this.m_SelectServerId = param1;
      }
      
      public function get ServerID() : int
      {
         return this.m_SelectServerId;
      }
      
      public function get PlayerNewName() : String
      {
         if(this.m_PlayerName.text)
         {
            return StringUitl.Trim(this.m_PlayerName.text);
         }
         return "";
      }
      
      public function set ErrorTip(param1:String) : void
      {
         if(param1 != null)
         {
            this.m_ErrorTip.text = param1;
         }
      }
      
      public function get ErrorTip() : String
      {
         if(this.m_ErrorTip.text)
         {
            return StringUitl.Trim(this.m_ErrorTip.text);
         }
         return "";
      }
      
      private function onEnterNewName(param1:MouseEvent) : void
      {
         if(this.m_PlayerName.text != this.m_DefaultStr && this.m_PlayerName.text != "")
         {
            return;
         }
         this.m_PlayerName.text = "";
      }
      
      public function set CurrentServerItem(param1:GameServerItem) : void
      {
         this.m_CurrentServerItem = param1;
      }
      
      public function get CurrentServerItem() : GameServerItem
      {
         return this.m_CurrentServerItem;
      }
      
      public function SetServerData(param1:Array) : void
      {
         if(param1 == null)
         {
            return;
         }
         this.m_ServerListArray = param1;
      }
      
      public function SetSelectServerName(param1:int) : void
      {
         var _loc2_:String = "ServerName";
         _loc2_ = _loc2_.concat(param1 + 1);
         this.m_ServerName.text = StringManager.getInstance().getMessageString(_loc2_);
      }
      
      private function onOkayHandler(param1:MouseEvent) : void
      {
         if(this.m_PlayerName.text == this.m_DefaultStr || this.m_PlayerName.text == "")
         {
            this.m_ErrorTip.text = StringManager.getInstance().getMessageString("Server36");
            return;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this.LimitArray.length)
         {
            if(this.m_PlayerName.text.indexOf(this.LimitArray[_loc2_]) >= 0)
            {
               this.m_ErrorTip.text = StringManager.getInstance().getMessageString("Server36");
               return;
            }
            _loc2_++;
         }
         NetManager.Instance().ConnectLoginServer();
         NetRouter.ConnCheckServer = true;
      }
      
      public function GetServerData() : Array
      {
         return this.m_ServerListArray;
      }
      
      private function onGameServerHandler(param1:MouseEvent) : void
      {
         GameServerItemUI.GetInstance().Init();
      }
      
      public function Release() : void
      {
         var _loc1_:int = 0;
         GameServerItemUI.GetInstance().Release();
         if(this.m_Wnd)
         {
            this.m_Wnd.getMC().stop();
            if(this.m_Wnd.parent != null)
            {
               this.m_Wnd.parent.removeChild(this.m_Wnd);
            }
            _loc1_ = 0;
            while(_loc1_ < this.m_Wnd.numChildren)
            {
               this.m_Wnd.removeChildAt(_loc1_);
               _loc1_++;
            }
         }
      }
      
      public function getUI() : MObject
      {
         if(this.m_Wnd != null)
         {
            this.Init();
         }
         return this.m_Wnd;
      }
      
      public function SetVisible(param1:Boolean) : void
      {
         GameKernel.renderManager.Show(this,param1);
      }
   }
}

