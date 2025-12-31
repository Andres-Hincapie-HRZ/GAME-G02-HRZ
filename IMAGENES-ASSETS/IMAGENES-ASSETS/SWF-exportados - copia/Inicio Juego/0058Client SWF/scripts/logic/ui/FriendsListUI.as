package logic.ui
{
   import com.star.frameworks.facebook.FacebookUserInfo;
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.HashSet;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import logic.action.ChatAction;
   import logic.action.FaceBookAction;
   import logic.entry.ChannelEnum;
   import logic.entry.GamePlaceType;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.HButtonType;
   import logic.entry.MObject;
   import logic.game.GameKernel;
   import logic.game.GameStateManager;
   import net.base.NetManager;
   import net.msg.DestructionShipMsg.MSG_REQUEST_DESTROYSHIP;
   import net.msg.friend.FriendChatUserInfo;
   import net.msg.friend.MSG_REQUEST_ADDFRIEND;
   import net.msg.friend.MSG_REQUEST_DELFRIEND;
   import net.msg.friend.MSG_REQUEST_FRIENDLIST;
   import net.msg.friend.MSG_RESP_FRIENDLIST;
   import net.msg.friend.MSG_RESP_FRIENDPASSAUTH;
   import net.msg.upgrade.MSG_REQUEST_SHIPBODYUPGRADE;
   
   public class FriendsListUI extends AbstractPopUp
   {
      
      private static var instance:FriendsListUI;
      
      private var btn_left:HButton;
      
      private var btn_right:HButton;
      
      private var tf_page:TextField;
      
      private var PageId:int;
      
      private var PageCount:int;
      
      private var UserIdList:Array;
      
      private var UserNameList:Array;
      
      private var FriendMsg:MSG_RESP_FRIENDLIST;
      
      private var UserInfoList:HashSet;
      
      private var FriendBtnPopup:MovieClip;
      
      private var SelectedItem:MovieClip;
      
      private var tf_nameinput:TextField;
      
      private var xtf_nameinput:XTextField;
      
      private var SelectedIndex:int = -1;
      
      private var btn_prviatetalk:HButton;
      
      private var msg1:MSG_REQUEST_SHIPBODYUPGRADE;
      
      private var msg2:MSG_REQUEST_DESTROYSHIP;
      
      public function FriendsListUI()
      {
         super();
         this.UserIdList = new Array();
         this.UserNameList = new Array();
         this.UserInfoList = new HashSet();
         setPopUpName("FriendsListUI");
      }
      
      public static function getInstance() : FriendsListUI
      {
         if(instance == null)
         {
            instance = new FriendsListUI();
         }
         return instance;
      }
      
      override public function Init() : void
      {
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            this.RequestFriends();
            return;
         }
         this._mc = new MObject("FriendScene",385,300);
         this.initMcElement();
         GameKernel.popUpDisplayManager.Regisger(instance);
         this.Clear();
         this.RequestFriends();
      }
      
      override public function initMcElement() : void
      {
         var _loc1_:HButton = null;
         var _loc2_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         var _loc6_:XMovieClip = null;
         _loc2_ = this._mc.getMC().getChildByName("btn_close") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_closeClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_blacklist") as MovieClip;
         if(_loc2_)
         {
            _loc2_.visible = false;
            _loc2_ = this._mc.getMC().getChildByName("btn_friend") as MovieClip;
            _loc2_.visible = false;
         }
         _loc2_ = this._mc.getMC().getChildByName("btn_addfriend") as MovieClip;
         _loc1_ = new HButton(_loc2_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("FriendText21"));
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_addfriendClick);
         this.FriendBtnPopup = GameKernel.getMovieClipInstance("FriendBtnPopup");
         this.FriendBtnPopup.visible = false;
         this._mc.getMC().addChild(this.FriendBtnPopup);
         _loc2_ = this.FriendBtnPopup.getChildByName("btn_lookover") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_lookoverClick);
         _loc2_ = this.FriendBtnPopup.getChildByName("btn_deletefriend") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_deletefriendClick);
         _loc2_ = this.FriendBtnPopup.getChildByName("btn_team") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_teamClick);
         _loc1_.setBtnDisabled(true);
         _loc2_ = this.FriendBtnPopup.getChildByName("btn_mail") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_mailClick);
         _loc2_ = this.FriendBtnPopup.getChildByName("btn_prviatetalk") as MovieClip;
         this.btn_prviatetalk = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_prviatetalkClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_left") as MovieClip;
         this.btn_left = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_leftClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_right") as MovieClip;
         this.btn_right = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_rightClick);
         this.tf_page = this._mc.getMC().getChildByName("tf_page") as TextField;
         this.tf_nameinput = this._mc.getMC().getChildByName("tf_nameinput") as TextField;
         this.tf_nameinput.restrict = "0-9";
         this.tf_nameinput.maxChars = GamePlayer.getInstance().language == 0 ? 8 : 32;
         this.tf_nameinput.addEventListener(MouseEvent.MOUSE_DOWN,this.tf_nameinputMouseDown);
         this.xtf_nameinput = new XTextField(this.tf_nameinput,StringManager.getInstance().getMessageString("FriendText7"));
         var _loc3_:int = 0;
         while(_loc3_ < 5)
         {
            _loc4_ = this._mc.getMC().getChildByName("mc_list" + _loc3_) as MovieClip;
            _loc5_ = _loc4_.getChildByName("btn_view") as MovieClip;
            _loc5_.stop();
            _loc4_.addEventListener(MouseEvent.CLICK,this.ItemClick);
            _loc4_.buttonMode = true;
            _loc4_.stop();
            _loc6_ = new XMovieClip(_loc4_);
            _loc6_.Data = _loc3_;
            _loc6_.OnMouseOver = this.ItemMouseOver;
            _loc4_.visible = false;
            _loc3_++;
         }
      }
      
      private function Clear() : void
      {
         var _loc2_:MovieClip = null;
         this.RemoveFriendBtnPopup();
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            _loc2_ = this._mc.getMC().getChildByName("mc_list" + _loc1_) as MovieClip;
            _loc2_.visible = false;
            _loc1_++;
         }
         this.btn_left.setBtnDisabled(true);
         this.btn_right.setBtnDisabled(true);
         this.tf_page.text = "";
         this.xtf_nameinput.ResetDefaultText();
      }
      
      private function RequestFriends() : void
      {
         this.Clear();
         var _loc1_:MSG_REQUEST_FRIENDLIST = new MSG_REQUEST_FRIENDLIST();
         _loc1_.PageId = this.PageId;
         _loc1_.Type = 0;
         _loc1_.Online = 0;
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc1_);
      }
      
      public function RespFriends(param1:MSG_RESP_FRIENDLIST) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:FriendChatUserInfo = null;
         var _loc5_:TextField = null;
         var _loc6_:TextField = null;
         var _loc7_:MovieClip = null;
         this.PageCount = param1.FriendCount / 5;
         if(this.PageCount * 5 < param1.FriendCount)
         {
            ++this.PageCount;
         }
         this.ShowPageButton();
         this.FriendMsg = param1;
         this.UserIdList.splice(0);
         this.UserNameList.splice(0);
         var _loc2_:int = 0;
         while(_loc2_ < 5)
         {
            _loc3_ = this._mc.getMC().getChildByName("mc_list" + _loc2_) as MovieClip;
            if(_loc2_ < param1.DataLen)
            {
               _loc4_ = param1.Data[_loc2_];
               _loc5_ = _loc3_.getChildByName("tf_name") as TextField;
               _loc5_.text = _loc4_.Name;
               _loc6_ = _loc3_.getChildByName("tf_state") as TextField;
               if(_loc4_.Status == 0)
               {
                  _loc6_.htmlText = "<font color=\'#265E9E\'>" + StringManager.getInstance().getMessageString("CorpsText12") + "</font>";
               }
               else
               {
                  _loc6_.htmlText = "<font color=\'#00CFFF\'>" + StringManager.getInstance().getMessageString("CorpsText13") + "</font>";
               }
               TextField(_loc3_.tf_id).text = "ID:" + _loc4_.Guid.toString();
               _loc7_ = _loc3_.getChildByName("mc_base") as MovieClip;
               if(_loc7_.numChildren > 0)
               {
                  _loc7_.removeChildAt(0);
               }
               _loc3_.visible = true;
               this.UserIdList.push(_loc4_.UserId);
               this.UserNameList.push(_loc4_.Name);
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc2_++;
         }
         var _loc30_:Number = Number(null);
         var _loc35_:FacebookUserInfo = null;
         var _loc40_:Array = new Array();
         var _loc45_:int = 0;
         for each(_loc30_ in this.UserIdList)
         {
            _loc35_ = new FacebookUserInfo();
            _loc35_.uid = _loc30_;
            _loc35_.first_name = this.UserNameList[_loc45_++];
            _loc35_.pic_square = "";
            _loc40_.push(_loc35_);
         }
         this.getPlayerFacebookInfoArrayCallback(_loc40_);
      }
      
      private function getPlayerFacebookInfoArrayCallback(param1:Array) : void
      {
         var _loc2_:FacebookUserInfo = null;
         var _loc3_:int = 0;
         var _loc4_:FriendChatUserInfo = null;
         var _loc5_:MovieClip = null;
         var _loc6_:TextField = null;
         if(param1 == null)
         {
            return;
         }
         for each(_loc2_ in param1)
         {
            this.UserInfoList.Put(_loc2_.uid,_loc2_);
            _loc3_ = 0;
            while(_loc3_ < this.UserIdList.length)
            {
               if(this.UserIdList[_loc3_] == _loc2_.uid)
               {
                  _loc4_ = this.FriendMsg.Data[_loc3_];
                  _loc4_.Name = _loc2_.first_name;
                  _loc5_ = this._mc.getMC().getChildByName("mc_list" + _loc3_) as MovieClip;
                  _loc6_ = _loc5_.getChildByName("tf_name") as TextField;
                  _loc6_.text = _loc2_.first_name;
                  FleetInfoUI_Res.GetInstance().GetFacebookUserImg(_loc2_.uid,_loc2_.pic_square,this.GetFacebookUserImgCallback);
                  break;
               }
               _loc3_++;
            }
         }
      }
      
      private function GetFacebookUserImgCallback(param1:Number, param2:DisplayObject) : void
      {
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         if(param2 == null)
         {
            return;
         }
         var _loc3_:int = 0;
         while(_loc3_ < this.UserIdList.length)
         {
            if(this.UserIdList[_loc3_] == param1)
            {
               _loc4_ = this._mc.getMC().getChildByName("mc_list" + _loc3_) as MovieClip;
               _loc5_ = _loc4_.getChildByName("mc_base") as MovieClip;
               param2.width = 45;
               param2.height = 45;
               _loc5_.addChild(param2);
            }
            _loc3_++;
         }
      }
      
      public function RespFassAuth(param1:MSG_RESP_FRIENDPASSAUTH) : void
      {
         if(GameKernel.ForFB == 1)
         {
            this.ShowFassAuth(param1.FriendName);
         }
         else
         {
            GameKernel.getPlayerFacebookInfo(param1.UserId,this.RespFassAuthCallback,param1.FriendName);
         }
      }
      
      private function RespFassAuthCallback(param1:FacebookUserInfo) : void
      {
         if(param1 == null || param1.first_name == null)
         {
            MessagePopup.getInstance().Show("** " + StringManager.getInstance().getMessageString("FriendText13"),1);
            return;
         }
         this.ShowFassAuth(param1.first_name);
      }
      
      private function ShowFassAuth(param1:String) : void
      {
         var _loc2_:String = "[" + param1 + "]" + StringManager.getInstance().getMessageString("FriendText13");
         MessagePopup.getInstance().Show(_loc2_,1);
         FriendsListUI.getInstance().Refresh();
      }
      
      private function ShowPageButton() : void
      {
         if(this.PageId == 0)
         {
            this.btn_left.setBtnDisabled(true);
         }
         else
         {
            this.btn_left.setBtnDisabled(false);
         }
         if(this.PageId + 1 < this.PageCount)
         {
            this.btn_right.setBtnDisabled(false);
         }
         else
         {
            this.btn_right.setBtnDisabled(true);
         }
         this.tf_page.text = this.PageId + 1 + "/" + this.PageCount;
      }
      
      private function btn_closeClick(param1:MouseEvent) : void
      {
         GameKernel.popUpDisplayManager.Hide(this);
      }
      
      private function btn_addfriendClick(param1:MouseEvent) : void
      {
         this.RemoveFriendBtnPopup();
         this.tf_nameinput.text = this.tf_nameinput.text.replace(/^\s*/g,"");
         this.tf_nameinput.text = this.tf_nameinput.text.replace(/\s*$/g,"");
         if(this.tf_nameinput.text == "")
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("FriendText7"),0);
            return;
         }
         var _loc2_:int = int(this.tf_nameinput.text);
         this.xtf_nameinput.ResetDefaultText();
         if(_loc2_ == GamePlayer.getInstance().Guid)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("FriendText20"),0);
            return;
         }
         this.InviteFriend(_loc2_);
      }
      
      public function InviteFriend(param1:int) : void
      {
         var _loc2_:MSG_REQUEST_ADDFRIEND = new MSG_REQUEST_ADDFRIEND();
         _loc2_.ObjGuid = param1;
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc2_);
      }
      
      private function tf_nameinputMouseDown(param1:MouseEvent) : void
      {
         this.RemoveFriendBtnPopup();
      }
      
      private function btn_deletefriendClick(param1:MouseEvent) : void
      {
         this.RemoveFriendBtnPopup();
         if(this.SelectedIndex < 0 || this.SelectedIndex >= this.FriendMsg.DataLen)
         {
            return;
         }
         MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("FriendText12"),2,this.DeleteFriend);
      }
      
      private function DeleteFriend() : void
      {
         var _loc1_:FriendChatUserInfo = this.FriendMsg.Data[this.SelectedIndex];
         var _loc2_:MSG_REQUEST_DELFRIEND = new MSG_REQUEST_DELFRIEND();
         _loc2_.FriendGuid = _loc1_.Guid;
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc2_);
         this.RequestFriends();
      }
      
      private function btn_teamClick(param1:MouseEvent) : void
      {
         this.RemoveFriendBtnPopup();
         this.btn_closeClick(null);
      }
      
      private function RemoveFriendBtnPopup() : void
      {
         this.FriendBtnPopup.visible = false;
      }
      
      private function ItemClick(param1:MouseEvent) : void
      {
         this.RemoveFriendBtnPopup();
      }
      
      private function ItemMouseOver(param1:MouseEvent, param2:XMovieClip) : void
      {
         if(this.SelectedItem != null)
         {
            this.SelectedItem.gotoAndStop("up");
         }
         this.SelectedItem = this._mc.getMC().getChildByName("mc_list" + param2.Data) as MovieClip;
         this.SelectedItem.gotoAndStop("selected");
         this.SelectedIndex = param2.Data;
         var _loc3_:FriendChatUserInfo = this.FriendMsg.Data[this.SelectedIndex];
         this.btn_prviatetalk.setBtnDisabled(_loc3_.Status == 0);
         this.FriendBtnPopup.x = this.SelectedItem.x + this.SelectedItem.width + 10;
         this.FriendBtnPopup.y = this.SelectedItem.y;
         this.FriendBtnPopup.visible = true;
      }
      
      private function tf_nameinputClick(param1:Event) : void
      {
         this.RemoveFriendBtnPopup();
         this.tf_nameinput.text = "";
      }
      
      private function btn_mailClick(param1:MouseEvent) : void
      {
         this.RemoveFriendBtnPopup();
         if(this.SelectedIndex < 0 || this.SelectedIndex >= this.FriendMsg.DataLen)
         {
            return;
         }
         var _loc2_:FriendChatUserInfo = this.FriendMsg.Data[this.SelectedIndex];
         MailUI.getInstance().WriteMail(_loc2_.Guid);
         this.btn_closeClick(null);
      }
      
      private function btn_prviatetalkClick(param1:MouseEvent) : void
      {
         this.RemoveFriendBtnPopup();
         if(this.SelectedIndex < 0 || this.SelectedIndex >= this.FriendMsg.DataLen)
         {
            return;
         }
         var _loc2_:FriendChatUserInfo = this.FriendMsg.Data[this.SelectedIndex];
         ChatChannelPopUp.getInstance().setChannel(ChannelEnum.CHANNEL_PRIVATE);
         ChatAction.getInstance().toPrivateChannel(_loc2_.Guid,_loc2_.Name);
         ChatAction.prexChatPlayer.objGuid = _loc2_.Guid;
         ChatAction.prexChatPlayer.userName = _loc2_.Name;
         this.btn_closeClick(null);
      }
      
      private function btn_leftClick(param1:MouseEvent) : void
      {
         --this.PageId;
         this.RequestFriends();
      }
      
      private function btn_rightClick(param1:MouseEvent) : void
      {
         ++this.PageId;
         this.RequestFriends();
      }
      
      private function btn_viewClick(param1:MouseEvent, param2:XButton) : void
      {
         var _loc3_:int = param2.Data;
         if(_loc3_ < 0 || _loc3_ >= this.FriendMsg.DataLen)
         {
            return;
         }
         var _loc4_:FriendChatUserInfo = this.FriendMsg.Data[_loc3_];
         if(this.UserInfoList.ContainsKey(_loc4_.UserId))
         {
            FaceBookUI.getInstance().CurrentFaceBookFriend = this.UserInfoList.Get(_loc4_.UserId);
            GameStateManager.playerPlace = GamePlaceType.PLACE_FRIENDHOME;
            FaceBookAction.getInstance().request_Msg_FaceBookInfo(_loc4_.UserId,_loc4_.Name);
         }
         this.btn_closeClick(null);
      }
      
      private function btn_lookoverClick(param1:MouseEvent) : void
      {
         var _loc3_:FacebookUserInfo = null;
         this.RemoveFriendBtnPopup();
         if(this.SelectedIndex < 0 || this.SelectedIndex >= this.FriendMsg.DataLen)
         {
            return;
         }
         var _loc2_:FriendChatUserInfo = this.FriendMsg.Data[this.SelectedIndex];
         if(this.UserInfoList.ContainsKey(_loc2_.UserId))
         {
            FaceBookUI.getInstance().CurrentFaceBookFriend = this.UserInfoList.Get(_loc2_.UserId);
         }
         else
         {
            _loc3_ = new FacebookUserInfo();
            _loc3_.uid = _loc2_.UserId;
            _loc3_.pic_square = "";
            _loc3_.first_name = _loc2_.Name;
            FaceBookUI.getInstance().CurrentFaceBookFriend = _loc3_;
         }
         if(GameKernel.ForFB != 1)
         {
            GameStateManager.playerPlace = GamePlaceType.PLACE_GAME;
         }
         else
         {
            GameStateManager.playerPlace = GamePlaceType.PLACE_FRIENDHOME;
         }
         FaceBookAction.getInstance().request_Msg_FaceBookInfo(_loc2_.UserId,_loc2_.Name);
         this.btn_closeClick(null);
      }
      
      public function Refresh() : void
      {
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            this.PageId = 0;
            this.RequestFriends();
         }
      }
   }
}

