package logic.ui
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.events.ActionEvent;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import logic.action.ChatAction;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.game.GameKernel;
   import logic.manager.GameInterActiveManager;
   
   public class ChatToolBar
   {
      
      private static var instance:ChatToolBar;
      
      private var ViewBtnMc:HButton;
      
      private var AddBtnMc:HButton;
      
      private var CorpsBtnMc:HButton;
      
      private var CancleBtnMc:HButton;
      
      private var PrivateBtnMc:HButton;
      
      private var mPopWnd:MovieClip;
      
      private var mPlayer:Object;
      
      private var _parent:DisplayObjectContainer;
      
      private var toolBarPlane:Container;
      
      public function ChatToolBar()
      {
         super();
         this.Init();
      }
      
      public static function getInstance() : ChatToolBar
      {
         if(instance == null)
         {
            instance = new ChatToolBar();
         }
         return instance;
      }
      
      private function Init() : void
      {
         if(this.toolBarPlane)
         {
            return;
         }
         this.toolBarPlane = new Container();
         this.mPopWnd = GameKernel.getMovieClipInstance("ChatPop");
         this.ViewBtnMc = new HButton(this.mPopWnd.btn_view);
         this.AddBtnMc = new HButton(this.mPopWnd.btn_add);
         this.PrivateBtnMc = new HButton(this.mPopWnd.btn_private);
         this.CancleBtnMc = new HButton(this.mPopWnd.btn_cancel);
         this.toolBarPlane.addChild(this.mPopWnd);
         this.AddEvent();
      }
      
      public function setChatDestPlayer(param1:Object) : void
      {
         if(param1 == null)
         {
            return;
         }
         this.mPlayer = param1;
      }
      
      public function setLocationXY(param1:int, param2:int) : void
      {
         if(this.toolBarPlane)
         {
            this.toolBarPlane.x = param1;
            this.toolBarPlane.y = param2;
         }
      }
      
      public function setToolBar(param1:DisplayObjectContainer) : void
      {
         this._parent = param1;
         if(!param1.contains(this.toolBarPlane))
         {
            param1.addChild(this.toolBarPlane);
         }
         param1.addChild(this.toolBarPlane);
         this.AddEvent();
      }
      
      private function AddEvent() : void
      {
         GameInterActiveManager.InstallInterActiveEvent(this.ViewBtnMc.m_movie,ActionEvent.ACTION_CLICK,this.onChatToolBarHandler);
         GameInterActiveManager.InstallInterActiveEvent(this.AddBtnMc.m_movie,ActionEvent.ACTION_CLICK,this.onChatToolBarHandler);
         GameInterActiveManager.InstallInterActiveEvent(this.CancleBtnMc.m_movie,ActionEvent.ACTION_CLICK,this.onChatToolBarHandler);
         GameInterActiveManager.InstallInterActiveEvent(this.PrivateBtnMc.m_movie,ActionEvent.ACTION_CLICK,this.onChatToolBarHandler);
      }
      
      public function getToolBar() : Container
      {
         return this.toolBarPlane;
      }
      
      public function HideToolBar() : void
      {
         if(this._parent)
         {
            if(this._parent.contains(this.toolBarPlane))
            {
               this._parent.removeChild(this.toolBarPlane);
            }
            this.Destory();
         }
      }
      
      public function isShow() : Boolean
      {
         return this.toolBarPlane.parent != null;
      }
      
      public function Destory() : void
      {
         GameInterActiveManager.unInstallnterActiveEvent(this.ViewBtnMc.m_movie,ActionEvent.ACTION_CLICK,this.onChatToolBarHandler);
         GameInterActiveManager.unInstallnterActiveEvent(this.AddBtnMc.m_movie,ActionEvent.ACTION_CLICK,this.onChatToolBarHandler);
         GameInterActiveManager.unInstallnterActiveEvent(this.CancleBtnMc.m_movie,ActionEvent.ACTION_CLICK,this.onChatToolBarHandler);
         GameInterActiveManager.unInstallnterActiveEvent(this.PrivateBtnMc.m_movie,ActionEvent.ACTION_CLICK,this.onChatToolBarHandler);
      }
      
      private function onChatToolBarHandler(param1:MouseEvent) : void
      {
         switch(param1.target.name)
         {
            case "btn_view":
               ChatAction.getInstance().sendChatUserInfoMessage(0,ChatAction.currentPlayer.objGuid,1);
               break;
            case "btn_add":
               if(GamePlayer.getInstance().Guid == ChatAction.currentPlayer.objGuid)
               {
                  return;
               }
               ChatAction.getInstance().sendAddFriendRequest(ChatAction.currentPlayer.objGuid);
               break;
            case "btn_cancel":
               break;
            case "btn_private":
               ChatAction.prexChatPlayer.objGuid = this.mPlayer.Guid;
               ChatAction.prexChatPlayer.userName = this.mPlayer.Name;
               ChatAction.getInstance().toPrivateChannel(GamePlayer.getInstance().Guid,ChatAction.prexChatPlayer.userName);
         }
         this.HideToolBar();
         this.Destory();
      }
   }
}

