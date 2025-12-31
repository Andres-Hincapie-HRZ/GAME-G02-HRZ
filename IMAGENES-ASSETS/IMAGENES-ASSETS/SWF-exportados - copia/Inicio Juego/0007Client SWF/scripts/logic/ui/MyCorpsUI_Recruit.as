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
   import net.msg.corpsMsg.MSG_REQUEST_CONSORTIAAUTHUSER;
   import net.msg.corpsMsg.MSG_REQUEST_DEALCONSORTIAAUTHUSER;
   import net.msg.corpsMsg.MSG_RESP_CONSORTIAAUTHUSER;
   import net.msg.corpsMsg.MSG_RESP_CONSORTIAAUTHUSER_TEMP;
   
   public class MyCorpsUI_Recruit implements MyCorpsUI_Base
   {
      
      private static var instance:MyCorpsUI_Recruit;
      
      public var McList:Array;
      
      public var PageIndex:int;
      
      public var PageCount:int;
      
      private var _PageRows:int;
      
      private var SelectedRow:XButton;
      
      private var UserIdList:Array;
      
      private var UserNameList:Array;
      
      private var GuidList:Array;
      
      private var SelectedId:int;
      
      private var RecruitMsg:MSG_RESP_CONSORTIAAUTHUSER;
      
      public function MyCorpsUI_Recruit(param1:int)
      {
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:HButton = null;
         var _loc6_:XButton = null;
         var _loc7_:XTextField = null;
         var _loc8_:String = null;
         var _loc9_:StyleSheet = null;
         super();
         if(param1 > 0)
         {
            this._PageRows = param1;
         }
         this.McList = new Array();
         this.UserIdList = new Array();
         this.UserNameList = new Array();
         this.GuidList = new Array();
         var _loc2_:int = 0;
         while(_loc2_ < this._PageRows)
         {
            _loc3_ = GameKernel.getMovieClipInstance("RecruitlistPlan",0,0,false);
            _loc4_ = _loc3_.getChildByName("btn_agree") as MovieClip;
            _loc5_ = new HButton(_loc4_);
            _loc4_.addEventListener(MouseEvent.CLICK,this.btn_agreeClick);
            _loc4_ = _loc3_.getChildByName("btn_refurse") as MovieClip;
            _loc5_ = new HButton(_loc4_);
            _loc4_.addEventListener(MouseEvent.CLICK,this.btn_refurseClick);
            _loc6_ = new XButton(_loc3_);
            _loc6_.OnMouseOver = this.RowClick;
            _loc3_.mouseChildren = true;
            this.McList.push(_loc3_);
            _loc7_ = new XTextField(_loc3_.tf_name);
            _loc7_.Data = _loc2_;
            _loc7_.OnClick = this.tf_nameClick;
            _loc8_ = "a:link{text-decoration: underline;} a:hover{color:#ff0000;text-decoration: underline;} a:active{text-decoration: underline;}";
            _loc9_ = new StyleSheet();
            _loc9_.parseCSS(_loc8_);
            _loc3_.tf_name.styleSheet = _loc9_;
            _loc3_.visible = false;
            _loc2_++;
         }
         this.PageIndex = 0;
      }
      
      public static function getInstance(param1:int = -1) : MyCorpsUI_Recruit
      {
         if(instance == null)
         {
            instance = new MyCorpsUI_Recruit(param1);
         }
         return instance;
      }
      
      public function GetList(param1:int = -1) : Array
      {
         if(param1 >= 0)
         {
            this.PageIndex = param1;
            this.RequestRecruitList();
         }
         return this.McList;
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
            this.RequestRecruitList();
         }
         return this.McList;
      }
      
      public function PrePage() : Array
      {
         if(this.PageIndex > 0)
         {
            --this.PageIndex;
            this.RequestRecruitList();
         }
         return this.McList;
      }
      
      public function GetHeadString() : String
      {
         return StringManager.getInstance().getMessageString("CorpsText22");
      }
      
      private function GetSelectedGuid(param1:MouseEvent) : int
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         _loc2_ = _loc2_.parent as MovieClip;
         this.SelectedId = -1;
         if(_loc2_ == null)
         {
            return -1;
         }
         var _loc3_:int = 0;
         while(_loc3_ < this._PageRows)
         {
            if(_loc2_ == this.McList[_loc3_])
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
         return this.GuidList[this.SelectedId];
      }
      
      private function btn_agreeClick(param1:MouseEvent) : void
      {
         this.AgreeApplay(true,param1);
         this.RequestRecruitList();
      }
      
      private function btn_refurseClick(param1:MouseEvent) : void
      {
         this.AgreeApplay(false,param1);
         this.RequestRecruitList();
      }
      
      private function AgreeApplay(param1:Boolean, param2:MouseEvent) : void
      {
         var _loc3_:int = this.GetSelectedGuid(param2);
         if(_loc3_ == -1)
         {
            return;
         }
         var _loc4_:MSG_REQUEST_DEALCONSORTIAAUTHUSER = new MSG_REQUEST_DEALCONSORTIAAUTHUSER();
         _loc4_.ObjGuid = _loc3_;
         _loc4_.Agree = param1 ? 1 : 0;
         _loc4_.SeqId = GamePlayer.getInstance().seqID++;
         _loc4_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc4_);
         var _loc5_:MovieClip = this.McList[this.SelectedId] as MovieClip;
         _loc5_.visible = false;
         this.GuidList[this.SelectedId] = -1;
         this.RequestRecruitList();
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
      
      private function RequestRecruitList() : void
      {
         var _loc3_:MovieClip = null;
         var _loc1_:MSG_REQUEST_CONSORTIAAUTHUSER = new MSG_REQUEST_CONSORTIAAUTHUSER();
         _loc1_.PageId = this.PageIndex;
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc1_);
         var _loc2_:int = 0;
         while(_loc2_ < this._PageRows)
         {
            _loc3_ = this.McList[_loc2_] as MovieClip;
            _loc3_.visible = false;
            _loc2_++;
         }
      }
      
      public function RespRecruitList(param1:MSG_RESP_CONSORTIAAUTHUSER) : void
      {
         var _loc3_:TextField = null;
         var _loc5_:MovieClip = null;
         var _loc6_:MSG_RESP_CONSORTIAAUTHUSER_TEMP = null;
         var _loc7_:MovieClip = null;
         this.RecruitMsg = param1;
         this.PageCount = param1.PageCount;
         if(this.PageIndex + 1 > this.PageCount)
         {
            this.PageIndex = this.PageCount - 1;
         }
         MyCorpsUI.getInstance().ShowPageButton();
         var _loc2_:int = this.PageIndex * this._PageRows;
         this.UserIdList.splice(0);
         this.UserNameList.splice(0);
         this.GuidList.splice(0);
         var _loc4_:int = 0;
         while(_loc4_ < this._PageRows)
         {
            _loc5_ = this.McList[_loc4_] as MovieClip;
            if(_loc4_ < param1.DataLen)
            {
               _loc5_.visible = true;
               _loc3_ = _loc5_.getChildByName("tf_grade") as TextField;
               _loc3_.text = (_loc2_ + 1).toString();
               _loc6_ = param1.Data[_loc4_];
               _loc3_ = _loc5_.getChildByName("tf_Lv") as TextField;
               _loc3_.text = (_loc6_.Level + 1).toString();
               _loc7_ = _loc5_.getChildByName("btn_agree") as MovieClip;
               _loc7_.visible = true;
               _loc7_ = _loc5_.getChildByName("btn_refurse") as MovieClip;
               _loc7_.visible = true;
               _loc3_ = _loc5_.getChildByName("tf_name") as TextField;
               _loc3_.htmlText = "<a href=\'event:\'>" + _loc6_.Name + "</a>";
               this.UserIdList.push(_loc6_.UserId);
               this.UserNameList.push(_loc6_.Name);
               this.GuidList.push(_loc6_.Guid);
               _loc5_ = _loc5_.getChildByName("mc_base") as MovieClip;
               if(_loc5_.numChildren > 0)
               {
                  _loc5_.removeChildAt(0);
               }
            }
            else
            {
               _loc5_.visible = false;
            }
            _loc2_++;
            _loc4_++;
         }
         GameKernel.getPlayerFacebookInfoArray(this.UserIdList,this.getPlayerFacebookInfoArrayCallback,this.UserNameList);
      }
      
      private function getPlayerFacebookInfoArrayCallback(param1:Array) : void
      {
         var _loc2_:FacebookUserInfo = null;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         var _loc6_:TextField = null;
         if(param1 == null)
         {
            for each(_loc3_ in this.UserIdList)
            {
               FleetInfoUI_Res.GetInstance().GetFacebookUserImg(_loc3_,"http://192.168.21.2/snssc2/CommanderImg/1.png",this.GetFacebookUserImgCallback);
            }
            return;
         }
         for each(_loc2_ in param1)
         {
            FleetInfoUI_Res.GetInstance().GetFacebookUserImg(_loc2_.uid,_loc2_.pic_square,this.GetFacebookUserImgCallback);
            _loc4_ = 0;
            while(_loc4_ < this.UserIdList.length)
            {
               if(_loc2_.uid == this.UserIdList[_loc4_])
               {
                  _loc5_ = this.McList[_loc4_] as MovieClip;
                  _loc6_ = _loc5_.getChildByName("tf_name") as TextField;
                  _loc6_.htmlText = "<a href=\'event:\'>" + _loc2_.first_name + "</a>";
                  break;
               }
               _loc4_++;
            }
         }
      }
      
      private function GetFacebookUserImgCallback(param1:Number, param2:DisplayObject) : void
      {
         var _loc4_:MovieClip = null;
         var _loc3_:int = 0;
         while(_loc3_ < this._PageRows)
         {
            if(this.UserIdList[_loc3_] == -1)
            {
               break;
            }
            if(param1 == this.UserIdList[_loc3_])
            {
               _loc4_ = this.McList[_loc3_] as MovieClip;
               _loc4_ = _loc4_.getChildByName("mc_base") as MovieClip;
               if(_loc4_.numChildren > 0)
               {
                  _loc4_.removeChildAt(0);
               }
               if(param2 != null)
               {
                  param2.width = 38;
                  param2.height = 38;
                  param2.x = 0;
                  param2.y = 0;
                  _loc4_.addChild(param2);
               }
               return;
            }
            _loc3_++;
         }
      }
      
      private function tf_nameClick(param1:MouseEvent, param2:XTextField) : void
      {
         if(this.RecruitMsg == null)
         {
            return;
         }
         var _loc3_:int = param2.Data;
         var _loc4_:MSG_RESP_CONSORTIAAUTHUSER_TEMP = this.RecruitMsg.Data[_loc3_];
         ChatAction.getInstance().sendChatUserInfoMessage(-1,_loc4_.Guid,3);
      }
   }
}

