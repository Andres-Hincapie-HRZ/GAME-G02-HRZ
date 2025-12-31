package logic.ui
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.facebook.FacebookUserInfo;
   import com.star.frameworks.managers.StringManager;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import logic.action.ChatAction;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.game.GameKernel;
   import net.base.NetManager;
   import net.msg.friend.MSG_REQUEST_FRIENDPASSAUTH;
   import net.msg.friend.MSG_RESP_ADDFRIENDAUTH;
   
   public class InvitePopupUI
   {
      
      private static var instance:InvitePopupUI;
      
      private var tf_content:TextField;
      
      private var InvitMsg:MSG_RESP_ADDFRIENDAUTH;
      
      private var MsgList:Array;
      
      private var InvitepopupMc:MovieClip;
      
      private var ParentLock:Container;
      
      public function InvitePopupUI()
      {
         super();
         this.MsgList = new Array();
         this.Init();
      }
      
      public static function getInstance() : InvitePopupUI
      {
         if(instance == null)
         {
            instance = new InvitePopupUI();
         }
         return instance;
      }
      
      private function Init() : void
      {
         this.InvitepopupMc = GameKernel.getMovieClipInstance("Invitepopup",GameKernel.fullRect.width / 2 + GameKernel.fullRect.x,300,false);
         this.initMcElement();
      }
      
      private function initMcElement() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:HButton = null;
         _loc1_ = this.InvitepopupMc.getChildByName("btn_detail") as MovieClip;
         _loc2_ = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_detailClick);
         _loc1_ = this.InvitepopupMc.getChildByName("btn_refurse") as MovieClip;
         _loc2_ = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_refurseClick);
         _loc1_ = this.InvitepopupMc.getChildByName("btn_accept") as MovieClip;
         _loc2_ = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_acceptClick);
         this.tf_content = this.InvitepopupMc.getChildByName("tf_content") as TextField;
         this.ParentLock = new Container("MessageSceneLock");
         this.ParentLock.mouseEnabled = true;
         this.ParentLock.mouseChildren = true;
         this.ParentLock.fillRectangleWithoutBorder(GameKernel.fullRect.x,GameKernel.fullRect.y,GameKernel.fullRect.width,GameKernel.fullRect.height,0,0.5);
      }
      
      public function RespIviteMsg(param1:MSG_RESP_ADDFRIENDAUTH, param2:Boolean = false) : void
      {
         if(this.InvitMsg != null)
         {
            this.MsgList.push(param1);
            this.Show();
            return;
         }
         this.InvitMsg = param1;
         this.ShowUI();
      }
      
      private function ShowUI() : void
      {
         if(this.InvitMsg == null)
         {
            this.Hide();
            return;
         }
         this.tf_content.text = "[" + this.InvitMsg.SrcName + "]" + StringManager.getInstance().getMessageString("FriendText11");
         if(GameKernel.ForFB == 1)
         {
            this.Show();
         }
         else
         {
            GameKernel.getPlayerFacebookInfo(this.InvitMsg.SrcUserId,this.getPlayerFacebookInfoCallback,this.InvitMsg.SrcName);
         }
      }
      
      private function getPlayerFacebookInfoCallback(param1:FacebookUserInfo) : void
      {
         if(param1 != null && this.InvitMsg != null && param1.uid == this.InvitMsg.SrcUserId)
         {
            this.tf_content.text = "[" + param1.first_name + "]" + StringManager.getInstance().getMessageString("FriendText11");
         }
         this.Show();
      }
      
      private function btn_detailClick(param1:Event) : void
      {
         ChatAction.getInstance().sendChatUserInfoMessage(-1,this.InvitMsg.SrcGuid,2);
      }
      
      private function btn_refurseClick(param1:Event) : void
      {
         if(this.MsgList.length == 0)
         {
            this.InvitMsg = null;
            this.Hide();
            return;
         }
         this.InvitMsg = this.MsgList.pop();
         this.ShowUI();
      }
      
      public function btn_acceptClick(param1:Event) : void
      {
         if(this.InvitMsg == null)
         {
            this.Hide();
            return;
         }
         var _loc2_:MSG_REQUEST_FRIENDPASSAUTH = new MSG_REQUEST_FRIENDPASSAUTH();
         _loc2_.FriendGuid = this.InvitMsg.SrcGuid;
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc2_);
         FriendsListUI.getInstance().Refresh();
         if(this.MsgList.length <= 0)
         {
            this.InvitMsg = null;
            this.Hide();
            return;
         }
         this.InvitMsg = this.MsgList.pop();
         this.ShowUI();
      }
      
      private function Show() : void
      {
         if(!GameKernel.renderManager.getUI().getContainer().contains(this.ParentLock))
         {
            GameKernel.renderManager.getUI().addComponent(this.ParentLock);
            this.ParentLock.addChild(this.InvitepopupMc);
         }
      }
      
      private function Hide() : void
      {
         if(this.InvitepopupMc.parent != null && this.InvitepopupMc.parent.contains(this.InvitepopupMc))
         {
            this.InvitepopupMc.parent.removeChild(this.InvitepopupMc);
            this.ParentLock.parent.removeChild(this.ParentLock);
         }
      }
   }
}

