package logic.ui
{
   import com.star.frameworks.facebook.FacebookUserInfo;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.HButtonType;
   import logic.game.GameKernel;
   import net.base.NetManager;
   import net.msg.friend.FriendChatUserInfo;
   import net.msg.friend.MSG_REQUEST_FRIENDLIST;
   import net.msg.friend.MSG_RESP_FRIENDLIST;
   
   public class MailUI_Friends
   {
      
      private static var instance:MailUI_Friends;
      
      private var FriendsListMc:MovieClip;
      
      private var btn_left:HButton;
      
      private var btn_right:HButton;
      
      private var SelectedTypeBtn:HButton;
      
      private var btn_allbox:HButton;
      
      private var btn_online:HButton;
      
      private var tf_page:TextField;
      
      private var FriendMsg:MSG_RESP_FRIENDLIST;
      
      private var UserIdList:Array;
      
      private var UserNameList:Array;
      
      private var PageId:int;
      
      private var PageCount:int;
      
      private var SelectedMc:MovieClip;
      
      private var SelectedItemId:int = -1;
      
      private var _Online:int;
      
      public function MailUI_Friends()
      {
         super();
         this.UserIdList = new Array();
         this.UserNameList = new Array();
         this.FriendsListMc = GameKernel.getMovieClipInstance("FriendlistMc",0,0,false);
         this.init();
      }
      
      public static function getInstance() : MailUI_Friends
      {
         if(instance == null)
         {
            instance = new MailUI_Friends();
         }
         return instance;
      }
      
      public function GetMc() : MovieClip
      {
         this.Clear();
         this.RequestFriends();
         return this.FriendsListMc;
      }
      
      private function init() : void
      {
         var _loc1_:HButton = null;
         var _loc2_:MovieClip = null;
         var _loc4_:MovieClip = null;
         _loc2_ = this.FriendsListMc.getChildByName("btn_left") as MovieClip;
         this.btn_left = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_leftClick);
         _loc2_ = this.FriendsListMc.getChildByName("btn_right") as MovieClip;
         this.btn_right = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_rightClick);
         this.tf_page = this.FriendsListMc.getChildByName("tf_page") as TextField;
         _loc2_ = this.FriendsListMc.getChildByName("btn_send") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_sendClick);
         _loc2_ = this.FriendsListMc.getChildByName("btn_allbox") as MovieClip;
         this.btn_allbox = new HButton(_loc2_,HButtonType.SELECT);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_allboxClick);
         _loc2_ = this.FriendsListMc.getChildByName("btn_online") as MovieClip;
         this.btn_online = new HButton(_loc2_,HButtonType.SELECT);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_onlineClick);
         var _loc3_:int = 0;
         while(_loc3_ < 9)
         {
            _loc2_ = this.FriendsListMc.getChildByName("mc_list" + _loc3_) as MovieClip;
            _loc4_ = GameKernel.getMovieClipInstance("FreindPlanMc",0,0,false);
            _loc4_.name = "Item" + _loc3_;
            _loc4_.stop();
            _loc4_.buttonMode = true;
            _loc2_.addChild(_loc4_);
            _loc4_.addEventListener(MouseEvent.CLICK,this.ItemClick);
            _loc4_ = _loc4_.getChildByName("mc_base") as MovieClip;
            _loc4_.buttonMode = true;
            _loc2_.visible = false;
            _loc3_++;
         }
      }
      
      private function Clear() : void
      {
         var _loc2_:MovieClip = null;
         this.ResetSelectedTypeBtn(this.btn_allbox);
         this._Online = 0;
         this.SelectedItemId = -1;
         var _loc1_:int = 0;
         while(_loc1_ < 9)
         {
            _loc2_ = this.FriendsListMc.getChildByName("mc_list" + _loc1_) as MovieClip;
            _loc2_.visible = false;
            _loc1_++;
         }
         this.btn_left.setBtnDisabled(false);
         this.btn_right.setBtnDisabled(false);
         this.tf_page.text = "";
         if(this.SelectedMc != null)
         {
            this.SelectedMc.gotoAndStop("up");
         }
      }
      
      private function RequestFriends() : void
      {
         var _loc1_:MSG_REQUEST_FRIENDLIST = new MSG_REQUEST_FRIENDLIST();
         _loc1_.PageId = this.PageId;
         _loc1_.Type = 1;
         _loc1_.Online = this._Online;
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc1_);
      }
      
      public function RespFriends(param1:MSG_RESP_FRIENDLIST) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:FriendChatUserInfo = null;
         var _loc5_:MovieClip = null;
         var _loc6_:TextField = null;
         var _loc7_:TextField = null;
         var _loc8_:MovieClip = null;
         this.PageCount = param1.FriendCount / 9;
         if(this.PageCount * 9 < param1.FriendCount)
         {
            ++this.PageCount;
         }
         this.ShowPageButton();
         this.FriendMsg = param1;
         this.UserIdList.splice(0);
         this.UserNameList.splice(0);
         var _loc2_:int = 0;
         while(_loc2_ < 9)
         {
            _loc3_ = this.FriendsListMc.getChildByName("mc_list" + _loc2_) as MovieClip;
            if(_loc2_ < param1.DataLen)
            {
               _loc4_ = param1.Data[_loc2_];
               _loc5_ = _loc3_.getChildByName("Item" + _loc2_) as MovieClip;
               _loc6_ = _loc5_.getChildByName("tf_id") as TextField;
               _loc6_.text = _loc4_.Guid.toString();
               this.UserIdList.push(_loc4_.UserId);
               this.UserNameList.push(_loc4_.Name);
               _loc7_ = _loc5_.getChildByName("tf_name") as TextField;
               _loc7_.text = _loc4_.Name;
               _loc8_ = _loc5_.getChildByName("mc_base") as MovieClip;
               if(_loc8_.numChildren > 0)
               {
                  _loc8_.removeChildAt(0);
               }
               _loc3_.visible = true;
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc2_++;
         }
         GameKernel.getPlayerFacebookInfoArray(this.UserIdList,this.getPlayerFacebookInfoArrayCallback,this.UserNameList);
      }
      
      private function getPlayerFacebookInfoArrayCallback(param1:Array) : void
      {
         var _loc2_:FacebookUserInfo = null;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         var _loc6_:TextField = null;
         if(param1 == null)
         {
            return;
         }
         for each(_loc2_ in param1)
         {
            _loc3_ = 0;
            while(_loc3_ < this.UserIdList.length)
            {
               if(this.UserIdList[_loc3_] == _loc2_.uid)
               {
                  _loc4_ = this.FriendsListMc.getChildByName("mc_list" + _loc3_) as MovieClip;
                  _loc5_ = _loc4_.getChildByName("Item" + _loc3_) as MovieClip;
                  _loc6_ = _loc5_.getChildByName("tf_name") as TextField;
                  _loc6_.text = _loc2_.first_name;
                  FleetInfoUI_Res.GetInstance().GetFacebookUserImg(_loc2_.uid,_loc2_.pic_square,this.GetFacebookUserImgCallback);
                  break;
               }
               _loc3_++;
            }
         }
      }
      
      private function GetFacebookUserImgCallback(param1:Number, param2:Bitmap) : void
      {
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         var _loc6_:MovieClip = null;
         if(param2 == null)
         {
            return;
         }
         var _loc3_:int = 0;
         while(_loc3_ < this.UserIdList.length)
         {
            if(this.UserIdList[_loc3_] == param1)
            {
               _loc4_ = this.FriendsListMc.getChildByName("mc_list" + _loc3_) as MovieClip;
               _loc5_ = _loc4_.getChildByName("Item" + _loc3_) as MovieClip;
               _loc6_ = _loc5_.getChildByName("mc_base") as MovieClip;
               _loc6_.addChild(param2);
            }
            _loc3_++;
         }
      }
      
      private function ShowPageButton() : void
      {
         if(this.PageCount == 0)
         {
            this.tf_page.text = "";
            this.btn_right.setBtnDisabled(true);
            this.btn_left.setBtnDisabled(true);
            return;
         }
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
      
      private function btn_leftClick(param1:MouseEvent) : void
      {
         this.btn_left.setBtnDisabled(true);
         this.btn_right.setBtnDisabled(true);
         --this.PageId;
         this.RequestFriends();
      }
      
      private function btn_rightClick(param1:MouseEvent) : void
      {
         this.btn_left.setBtnDisabled(true);
         this.btn_right.setBtnDisabled(true);
         ++this.PageId;
         this.RequestFriends();
      }
      
      private function btn_sendClick(param1:MouseEvent) : void
      {
         if(this.SelectedItemId < 0 || this.SelectedItemId >= this.FriendMsg.DataLen)
         {
            return;
         }
         var _loc2_:FriendChatUserInfo = this.FriendMsg.Data[this.SelectedItemId];
         MailUI.getInstance().WriteMail(_loc2_.Guid,false);
      }
      
      private function ItemClick(param1:MouseEvent) : void
      {
         var _loc2_:DisplayObject = param1.target as DisplayObject;
         if(_loc2_.name.indexOf("Item") < 0)
         {
            _loc2_ = _loc2_.parent as DisplayObject;
         }
         this.SelectedItemId = int(_loc2_.name.substr(4));
         if(this.SelectedMc != null)
         {
            this.SelectedMc.gotoAndStop("up");
         }
         this.SelectedMc = _loc2_ as MovieClip;
         this.SelectedMc.gotoAndStop("selected");
      }
      
      private function btn_allboxClick(param1:MouseEvent) : void
      {
         this.ResetSelectedTypeBtn(this.btn_allbox);
         this._Online = 0;
         this.RequestFriends();
      }
      
      private function btn_onlineClick(param1:MouseEvent) : void
      {
         this.ResetSelectedTypeBtn(this.btn_online);
         this._Online = 1;
         this.RequestFriends();
      }
      
      private function ResetSelectedTypeBtn(param1:HButton) : void
      {
         if(this.SelectedTypeBtn != null)
         {
            this.SelectedTypeBtn.setSelect(false);
         }
         this.SelectedTypeBtn = param1;
         this.SelectedTypeBtn.setSelect(true);
      }
   }
}

