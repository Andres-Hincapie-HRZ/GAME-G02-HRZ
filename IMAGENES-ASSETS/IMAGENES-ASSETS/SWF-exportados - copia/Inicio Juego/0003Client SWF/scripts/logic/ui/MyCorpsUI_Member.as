package logic.ui
{
   import com.star.frameworks.facebook.FacebookUserInfo;
   import com.star.frameworks.managers.StringManager;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.StyleSheet;
   import flash.text.TextField;
   import logic.action.ChatAction;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.game.GameKernel;
   import net.base.NetManager;
   import net.msg.corpsMsg.MSG_REQUEST_CONSORTIADELMEMBER;
   import net.msg.corpsMsg.MSG_REQUEST_CONSORTIASETOFFICIAL;
   import net.msg.corpsMsg.MSG_RESP_CONSORTIAMEMBER;
   import net.msg.corpsMsg.MSG_RESP_CONSORTIAMEMBER_TEMP;
   
   public class MyCorpsUI_Member implements MyCorpsUI_Base
   {
      
      public var MemberMcList:Array;
      
      private var CorpsMemberList:Array;
      
      public var PageIndex:int;
      
      public var PageCount:int;
      
      private var _PageRows:int;
      
      private var SelectedRow:XButton;
      
      private var UserIdList:Array;
      
      private var UserNameList:Array;
      
      private var SelectedId:int;
      
      private var UpdateGuid:int = -1;
      
      private var UpdateJob:int;
      
      private var DeleteId:int;
      
      public function MyCorpsUI_Member(param1:int)
      {
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:HButton = null;
         var _loc6_:XTextField = null;
         var _loc7_:String = null;
         var _loc8_:StyleSheet = null;
         var _loc9_:XButton = null;
         super();
         this._PageRows = param1;
         this.MemberMcList = new Array();
         this.CorpsMemberList = new Array();
         this.UserIdList = new Array();
         this.UserNameList = new Array();
         var _loc2_:int = 0;
         while(_loc2_ < this._PageRows)
         {
            _loc3_ = GameKernel.getMovieClipInstance("MemberlistPlan",0,0,false);
            _loc4_ = _loc3_.getChildByName("btn_delete") as MovieClip;
            _loc5_ = new HButton(_loc4_);
            _loc4_.addEventListener(MouseEvent.CLICK,this.btn_deleteClick);
            _loc4_ = _loc3_.getChildByName("btn_left") as MovieClip;
            _loc5_ = new HButton(_loc4_);
            _loc4_.addEventListener(MouseEvent.CLICK,this.btn_leftClick);
            _loc4_ = _loc3_.getChildByName("btn_right") as MovieClip;
            _loc5_ = new HButton(_loc4_);
            _loc4_.addEventListener(MouseEvent.CLICK,this.btn_rightClick);
            _loc6_ = new XTextField(_loc3_.tf_name);
            _loc6_.Data = _loc2_;
            _loc6_.OnClick = this.tf_nameClick;
            _loc7_ = "a:link{text-decoration: underline;} a:hover{color:#ff0000;text-decoration: underline;} a:active{text-decoration: underline;}";
            _loc8_ = new StyleSheet();
            _loc8_.parseCSS(_loc7_);
            _loc3_.tf_name.styleSheet = _loc8_;
            _loc9_ = new XButton(_loc3_);
            _loc9_.OnMouseOver = this.RowClick;
            this.MemberMcList.push(_loc3_);
            _loc3_.mouseChildren = true;
            _loc3_.visible = false;
            _loc2_++;
         }
      }
      
      public function GetList(param1:int = -1) : Array
      {
         if(param1 >= 0 && param1 < this.PageCount)
         {
            this.PageIndex = param1;
            this.ShowCurPage();
         }
         return this.MemberMcList;
      }
      
      public function GetPageIndex() : int
      {
         return this.PageIndex;
      }
      
      public function GetPageCount() : int
      {
         return this.PageCount;
      }
      
      public function NextPage() : Array
      {
         if(this.PageIndex + 1 < this.PageCount)
         {
            ++this.PageIndex;
         }
         this.ShowCurPage();
         return this.MemberMcList;
      }
      
      public function PrePage() : Array
      {
         if(this.PageIndex > 0)
         {
            --this.PageIndex;
         }
         this.ShowCurPage();
         return this.MemberMcList;
      }
      
      public function GetHeadString() : String
      {
         return StringManager.getInstance().getMessageString("CorpsText11");
      }
      
      private function GetSelectedGuid(param1:MouseEvent) : int
      {
         var _loc4_:MSG_RESP_CONSORTIAMEMBER_TEMP = null;
         var _loc2_:MovieClip = param1.target as MovieClip;
         _loc2_ = _loc2_.parent as MovieClip;
         if(_loc2_ == null)
         {
            return -1;
         }
         this.SelectedId = -1;
         var _loc3_:int = 0;
         while(_loc3_ < this._PageRows)
         {
            if(_loc2_ == this.MemberMcList[_loc3_])
            {
               this.SelectedId = _loc3_;
               break;
            }
            _loc3_++;
         }
         if(this.SelectedId == -1)
         {
            return -1;
         }
         this.SelectedId = this.PageIndex * this._PageRows + this.SelectedId;
         if(this.SelectedId < this.CorpsMemberList.length)
         {
            _loc4_ = this.CorpsMemberList[this.SelectedId];
            return _loc4_.Guid;
         }
         return -1;
      }
      
      private function btn_deleteClick(param1:MouseEvent) : void
      {
         var _loc2_:int = this.GetSelectedGuid(param1);
         if(_loc2_ == -1)
         {
            return;
         }
         this.DeleteId = _loc2_;
         MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CorpsText82"),2,this.DeleteMember);
      }
      
      private function DeleteMember() : void
      {
         var _loc1_:MSG_REQUEST_CONSORTIADELMEMBER = new MSG_REQUEST_CONSORTIADELMEMBER();
         _loc1_.DelGuid = this.DeleteId;
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc1_);
         this.CorpsMemberList.splice(this.SelectedId,1);
         this.ShowCurPage();
         MyCorpsUI.getInstance().DeleteMember();
      }
      
      private function btn_leftClick(param1:MouseEvent) : void
      {
         this.UpdateSelectedJob(true,param1);
      }
      
      private function btn_rightClick(param1:MouseEvent) : void
      {
         this.UpdateSelectedJob(false,param1);
      }
      
      private function UpdateSelectedJob(param1:Boolean, param2:MouseEvent) : void
      {
         var _loc3_:int = this.GetSelectedGuid(param2);
         if(_loc3_ == -1)
         {
            return;
         }
         var _loc4_:MovieClip = this.MemberMcList[this.SelectedId % this._PageRows];
         var _loc5_:TextField = _loc4_.getChildByName("tf_job") as TextField;
         var _loc6_:MSG_RESP_CONSORTIAMEMBER_TEMP = this.CorpsMemberList[this.SelectedId];
         if(param1)
         {
            if(_loc6_.Job > 0)
            {
               --_loc6_.Job;
            }
            else
            {
               _loc6_.Job = 4;
            }
         }
         else if(_loc6_.Job == 4)
         {
            _loc6_.Job = 0;
         }
         else
         {
            ++_loc6_.Job;
         }
         _loc5_.text = this.GetJob(_loc6_.Job);
         this.SetJobButton(_loc4_,_loc6_.Job);
         this.UpdateGuid = _loc3_;
         this.UpdateJob = _loc6_.Job;
         this.RequestUpdateJob();
      }
      
      private function RequestUpdateJob() : void
      {
         if(this.UpdateGuid == -1)
         {
            return;
         }
         var _loc1_:MSG_REQUEST_CONSORTIASETOFFICIAL = new MSG_REQUEST_CONSORTIASETOFFICIAL();
         _loc1_.ObjGuid = this.UpdateGuid;
         _loc1_.Job = this.UpdateJob;
         _loc1_.Type = this.UpdateJob == 0 ? 1 : 0;
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc1_);
         this.UpdateGuid = -1;
      }
      
      private function RowClick(param1:MouseEvent, param2:XButton) : void
      {
         if(this.SelectedRow != null)
         {
            this.SelectedRow.setSelect(false);
         }
         this.SelectedRow = param2;
         this.SelectedRow.setSelect(true);
      }
      
      public function AppendMyCorpsMemberList(param1:MSG_RESP_CONSORTIAMEMBER) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.DataLen)
         {
            MSG_RESP_CONSORTIAMEMBER_TEMP(param1.Data[_loc2_])._Status = (MSG_RESP_CONSORTIAMEMBER_TEMP(param1.Data[_loc2_]).Status + 1) % 2;
            MSG_RESP_CONSORTIAMEMBER_TEMP(param1.Data[_loc2_])._Job = (MSG_RESP_CONSORTIAMEMBER_TEMP(param1.Data[_loc2_]).Job + 4) % 5;
            this.CorpsMemberList.push(param1.Data[_loc2_]);
            _loc2_++;
         }
         this.CorpsMemberList.sortOn(["_Status","_Job","ThrowValue"],[Array.NUMERIC,Array.NUMERIC,18]);
         this.PageCount = this.CorpsMemberList.length / this._PageRows;
         if(this.PageCount * this._PageRows < this.CorpsMemberList.length)
         {
            ++this.PageCount;
         }
         MyCorpsUI.getInstance().ShowPageButton();
      }
      
      public function ClearMyCorpsMemberList() : void
      {
         this.CorpsMemberList.splice(0);
      }
      
      public function ShowCurPage() : void
      {
         var _loc2_:TextField = null;
         var _loc4_:MovieClip = null;
         var _loc5_:MSG_RESP_CONSORTIAMEMBER_TEMP = null;
         var _loc6_:MovieClip = null;
         var _loc7_:MovieClip = null;
         var _loc1_:int = this.PageIndex * this._PageRows;
         this.UserIdList.splice(0);
         this.UserNameList.splice(0);
         var _loc3_:int = 0;
         while(_loc3_ < this._PageRows)
         {
            _loc4_ = this.MemberMcList[_loc3_] as MovieClip;
            if(_loc1_ < this.CorpsMemberList.length)
            {
               _loc4_.visible = true;
               _loc2_ = _loc4_.getChildByName("tf_grade") as TextField;
               _loc2_.text = (_loc1_ + 1).toString();
               _loc5_ = this.CorpsMemberList[_loc1_];
               _loc6_ = _loc4_.getChildByName("mc_base") as MovieClip;
               if(_loc6_.numChildren > 0)
               {
                  _loc6_.removeChildAt(0);
               }
               _loc2_ = _loc4_.getChildByName("tf_name") as TextField;
               _loc2_.htmlText = "<a href=\'event:\'>" + _loc5_.Name + "</a>";
               _loc2_ = _loc4_.getChildByName("tf_id") as TextField;
               _loc2_.text = "(ID:" + _loc5_.Guid + ")";
               _loc2_ = _loc4_.getChildByName("tf_Lv") as TextField;
               _loc2_.text = (_loc5_.Level + 1).toString();
               _loc2_ = _loc4_.getChildByName("tf_job") as TextField;
               _loc2_.text = this.GetJob(_loc5_.Job);
               _loc2_ = _loc4_.getChildByName("tf_contribute") as TextField;
               _loc2_.text = _loc5_.ThrowValue.toString();
               _loc2_ = _loc4_.getChildByName("tf_online") as TextField;
               _loc2_.text = _loc5_.Status == 0 ? StringManager.getInstance().getMessageString("CorpsText12") : StringManager.getInstance().getMessageString("CorpsText13");
               this.UserIdList.push(_loc5_.UserId);
               this.UserNameList.push(_loc5_.Name);
               if(GamePlayer.getInstance().ConsortiaJob == 1 || GamePlayer.getInstance().ConsortiaJob == 2)
               {
                  this.SetJobButton(_loc4_,_loc5_.Job);
               }
               else
               {
                  _loc7_ = _loc4_.getChildByName("btn_delete") as MovieClip;
                  _loc7_.visible = false;
                  _loc7_ = _loc4_.getChildByName("btn_left") as MovieClip;
                  _loc7_.visible = false;
                  _loc7_ = _loc4_.getChildByName("btn_right") as MovieClip;
                  _loc7_.visible = false;
               }
            }
            else
            {
               _loc4_.visible = false;
            }
            _loc1_++;
            _loc3_++;
         }
         GameKernel.getPlayerFacebookInfoArray(this.UserIdList,this.getPlayerFacebookInfoArrayCallback,this.UserNameList);
      }
      
      private function SetJobButton(param1:MovieClip, param2:int) : void
      {
         var _loc3_:MovieClip = param1.getChildByName("btn_delete") as MovieClip;
         var _loc4_:MovieClip = param1.getChildByName("btn_left") as MovieClip;
         var _loc5_:MovieClip = param1.getChildByName("btn_right") as MovieClip;
         if(param2 == 1)
         {
            _loc4_.visible = false;
            _loc5_.visible = false;
            _loc3_.visible = false;
         }
         else if(param2 == 2)
         {
            if(GamePlayer.getInstance().ConsortiaJob == 1)
            {
               _loc4_.visible = false;
               _loc5_.visible = true;
               _loc3_.visible = true;
            }
            else
            {
               _loc4_.visible = false;
               _loc5_.visible = false;
               _loc3_.visible = false;
            }
         }
         else if(param2 == 3)
         {
            if(GamePlayer.getInstance().ConsortiaJob == 1)
            {
               _loc4_.visible = true;
               _loc5_.visible = true;
               _loc3_.visible = true;
            }
            else if(GamePlayer.getInstance().ConsortiaJob == 2)
            {
               _loc4_.visible = false;
               _loc5_.visible = true;
               _loc3_.visible = true;
            }
            else
            {
               _loc4_.visible = false;
               _loc5_.visible = false;
               _loc3_.visible = false;
            }
         }
         else if(param2 == 4)
         {
            _loc4_.visible = true;
            _loc5_.visible = true;
            _loc3_.visible = true;
         }
         else
         {
            _loc4_.visible = true;
            _loc5_.visible = false;
            _loc3_.visible = true;
         }
      }
      
      private function getPlayerFacebookInfoArrayCallback(param1:Array) : void
      {
         var _loc2_:FacebookUserInfo = null;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TextField = null;
         for each(_loc2_ in param1)
         {
            _loc3_ = 0;
            while(_loc3_ < this.UserIdList.length)
            {
               if(_loc2_.uid == this.UserIdList[_loc3_])
               {
                  _loc4_ = this.MemberMcList[_loc3_] as MovieClip;
                  _loc5_ = _loc4_.getChildByName("tf_name") as TextField;
                  _loc5_.htmlText = "<a href=\'event:\'>" + _loc2_.first_name + "</a>";
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
         var _loc3_:int = 0;
         while(_loc3_ < this.UserIdList.length)
         {
            if(param1 == this.UserIdList[_loc3_])
            {
               _loc4_ = this.MemberMcList[_loc3_] as MovieClip;
               _loc4_ = _loc4_.getChildByName("mc_base") as MovieClip;
               if(_loc4_.numChildren > 0)
               {
                  _loc4_.removeChildAt(0);
               }
               if(param2 != null)
               {
                  param2.width = 38;
                  param2.height = 38;
                  param2.x = -19;
                  param2.y = -19;
                  _loc4_.addChild(param2);
               }
               return;
            }
            _loc3_++;
         }
      }
      
      private function GetJob(param1:int) : String
      {
         return MyCorpsUI.getInstance()._ConsortiaJobName[param1];
      }
      
      private function tf_nameClick(param1:MouseEvent, param2:XTextField) : void
      {
         var _loc4_:MSG_RESP_CONSORTIAMEMBER_TEMP = null;
         if(this.CorpsMemberList == null)
         {
            return;
         }
         var _loc3_:int = this.PageIndex * this._PageRows + param2.Data;
         if(_loc3_ < this.CorpsMemberList.length)
         {
            _loc4_ = this.CorpsMemberList[_loc3_];
            ChatAction.getInstance().sendChatUserInfoMessage(-1,_loc4_.Guid,3);
         }
      }
   }
}

