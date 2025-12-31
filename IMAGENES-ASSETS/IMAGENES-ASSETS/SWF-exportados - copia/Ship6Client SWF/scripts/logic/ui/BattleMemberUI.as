package logic.ui
{
   import com.star.frameworks.facebook.FacebookUserInfo;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import logic.action.ChatAction;
   import logic.entry.HButton;
   import logic.game.GameKernel;
   import net.msg.fightMsg.MSG_RESP_WARFIELD_PLAYERLIST;
   import net.msg.fightMsg.MSG_RESP_WARFIELD_PLAYERLIST_TEMP;
   
   public class BattleMemberUI
   {
      
      public var MemberList:MovieClip;
      
      private var btn_left:HButton;
      
      private var btn_right:HButton;
      
      private var tf_page:TextField;
      
      private var ItemCount:int = 6;
      
      private var SelectedItem:XMovieClip;
      
      private var RespMsg:MSG_RESP_WARFIELD_PLAYERLIST;
      
      private var btn_attack:HButton;
      
      private var btn_defence:HButton;
      
      private var PageId:int;
      
      private var PageCount:int;
      
      private var StartId:int;
      
      private var ITemList:Array;
      
      private var UserIdList:Array;
      
      private var ItemMaxId:int;
      
      public function BattleMemberUI()
      {
         super();
      }
      
      public function Init() : *
      {
         var _loc1_:HButton = null;
         var _loc2_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:XMovieClip = null;
         this.MemberList = GameKernel.getMovieClipInstance("BattleLoserPop");
         _loc2_ = this.MemberList.getChildByName("btn_cancel") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_closeClick);
         _loc2_ = this.MemberList.getChildByName("btn_attack") as MovieClip;
         this.btn_attack = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_attackClick);
         _loc2_ = this.MemberList.getChildByName("btn_defence") as MovieClip;
         this.btn_defence = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_defenceClick);
         _loc2_ = this.MemberList.getChildByName("btn_left") as MovieClip;
         this.btn_left = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_leftClick);
         _loc2_ = this.MemberList.getChildByName("btn_right") as MovieClip;
         this.btn_right = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_rightClick);
         this.tf_page = this.MemberList.getChildByName("tf_page") as TextField;
         this.ITemList = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < this.ItemCount)
         {
            _loc4_ = this.MemberList.getChildByName("mc_list" + _loc3_) as MovieClip;
            _loc4_.gotoAndStop(1);
            _loc5_ = new XMovieClip(_loc4_);
            _loc5_.Data = _loc3_;
            _loc5_.OnClick = this.ItemClick;
            _loc5_.OnMouseOver = this.ItemOver;
            _loc4_.addEventListener(MouseEvent.MOUSE_OUT,this.ItemOut);
            this.ITemList.push(_loc4_);
            _loc3_++;
         }
      }
      
      private function ItemOut(param1:MouseEvent) : void
      {
         if(this.SelectedItem)
         {
            this.SelectedItem.m_movie.gotoAndStop(1);
         }
      }
      
      private function ItemOver(param1:MouseEvent, param2:XMovieClip) : void
      {
         if(this.SelectedItem)
         {
            this.SelectedItem.m_movie.gotoAndStop(1);
         }
         this.SelectedItem = param2;
         this.SelectedItem.m_movie.gotoAndStop(2);
      }
      
      private function ItemClick(param1:MouseEvent, param2:XMovieClip) : void
      {
         ChatAction.getInstance().sendChatUserInfoMessage(-1,-1,3,this.UserIdList[param2.Data]);
      }
      
      private function btn_rightClick(param1:MouseEvent) : void
      {
         ++this.PageId;
         this.ShowMemberList();
      }
      
      private function btn_leftClick(param1:MouseEvent) : void
      {
         --this.PageId;
         this.ShowMemberList();
      }
      
      private function btn_attackClick(param1:MouseEvent) : void
      {
         this.btn_attack.setSelect(true);
         this.btn_defence.setSelect(false);
         this.StartId = 0;
         this.PageId = 0;
         this.ItemMaxId = this.RespMsg.AttackerNum;
         this.PageCount = Math.ceil(this.RespMsg.AttackerNum / this.ItemCount);
         this.ShowMemberList();
      }
      
      private function btn_defenceClick(param1:MouseEvent) : void
      {
         this.btn_attack.setSelect(false);
         this.btn_defence.setSelect(true);
         this.StartId = this.RespMsg.AttackerNum;
         this.PageId = 0;
         this.ItemMaxId = this.RespMsg.DataLen;
         this.PageCount = Math.ceil((this.RespMsg.DataLen - this.RespMsg.AttackerNum) / this.ItemCount);
         this.ShowMemberList();
      }
      
      private function btn_closeClick(param1:Event) : void
      {
         if(this.MemberList.parent)
         {
            this.MemberList.parent.removeChild(this.MemberList);
         }
      }
      
      public function RespMemberList(param1:MSG_RESP_WARFIELD_PLAYERLIST) : void
      {
         this.RespMsg = param1;
         this.btn_attackClick(null);
      }
      
      private function ShowMemberList() : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:MSG_RESP_WARFIELD_PLAYERLIST_TEMP = null;
         var _loc5_:MovieClip = null;
         this.UserIdList = new Array();
         var _loc1_:int = this.PageId * this.ItemCount + this.StartId;
         var _loc2_:int = 0;
         while(_loc2_ < this.ItemCount)
         {
            _loc3_ = this.ITemList[_loc2_];
            if(_loc1_ < this.ItemMaxId)
            {
               _loc4_ = this.RespMsg.Data[_loc1_];
               _loc3_.visible = true;
               TextField(_loc3_.tf_ranking).text = (_loc1_ + 1 - this.StartId).toString();
               TextField(_loc3_.tf_name).text = _loc4_.Name;
               TextField(_loc3_.tf_id).text = _loc4_.Guid.toString();
               this.UserIdList.push(_loc4_.UserId);
               _loc5_ = MovieClip(_loc3_.mc_headbase);
               if(_loc5_.numChildren > 2)
               {
                  _loc5_.removeChildAt(1);
               }
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc1_++;
            _loc2_++;
         }
         this.ResetPageButton();
         GameKernel.getPlayerFacebookInfoArray(this.UserIdList,this.getPlayerFacebookInfoArrayCallback,null);
      }
      
      private function ResetPageButton() : void
      {
         this.btn_left.setBtnDisabled(this.PageId == 0);
         this.btn_right.setBtnDisabled(this.PageId + 1 >= this.PageCount);
         this.tf_page.text = this.PageId + 1 + "/" + this.PageCount;
      }
      
      private function getPlayerFacebookInfoArrayCallback(param1:Array) : void
      {
         var _loc2_:FacebookUserInfo = null;
         if(param1 == null)
         {
            return;
         }
         for each(_loc2_ in param1)
         {
            if(this.UserIdList.indexOf(_loc2_.uid) >= 0)
            {
               FleetInfoUI_Res.GetInstance().GetFacebookUserImg(_loc2_.uid,_loc2_.pic_square,this.GetFacebookUserImgCallback);
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
         var _loc3_:int = int(this.UserIdList.indexOf(param1));
         if(_loc3_ >= 0)
         {
            _loc4_ = this.ITemList[_loc3_];
            _loc5_ = MovieClip(_loc4_.mc_headbase);
            param2.width = 40;
            param2.height = 40;
            _loc5_.addChild(param2);
         }
      }
   }
}

