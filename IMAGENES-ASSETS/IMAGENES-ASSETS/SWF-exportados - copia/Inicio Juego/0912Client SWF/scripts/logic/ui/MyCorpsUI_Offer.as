package logic.ui
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.facebook.FacebookUserInfo;
   import com.star.frameworks.managers.StringManager;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.StyleSheet;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import logic.action.ChatAction;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.game.GameKernel;
   import net.base.NetManager;
   import net.msg.corpsMsg.MSG_REQUEST_CONSORTIATHROWRANK;
   import net.msg.corpsMsg.MSG_REQUEST_CONSORTIATHROWVALUE;
   import net.msg.corpsMsg.MSG_RESP_CONSORTIATHROWRANK;
   import net.msg.corpsMsg.MSG_RESP_CONSORTIATHROWRANK_TEMP;
   
   public class MyCorpsUI_Offer
   {
      
      private static var instance:MyCorpsUI_Offer;
      
      private var ParentLock:Container;
      
      private var OfferMc:MovieClip;
      
      private var btn_left:HButton;
      
      private var btn_right:HButton;
      
      private var tf_page:TextField;
      
      private var PageIndex:int;
      
      private var PageCount:int;
      
      private var FirstOpenFlag:int;
      
      private var UserIdList:Array;
      
      private var UserNameList:Array;
      
      private var ListMsg:MSG_RESP_CONSORTIATHROWRANK;
      
      private var SelectedRow:XButton;
      
      public function MyCorpsUI_Offer()
      {
         var _loc1_:MovieClip = null;
         var _loc2_:HButton = null;
         var _loc3_:TextField = null;
         super();
         this.UserIdList = new Array();
         this.UserNameList = new Array();
         this.OfferMc = GameKernel.getMovieClipInstance("CorpsofferScene",GameKernel.fullRect.width / 2 + GameKernel.fullRect.x,300,false);
         _loc1_ = this.OfferMc.getChildByName("btn_close") as MovieClip;
         _loc2_ = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_closeClick);
         _loc1_ = this.OfferMc.getChildByName("btn_offer0") as MovieClip;
         _loc2_ = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_offer0Click);
         _loc1_ = this.OfferMc.getChildByName("btn_offer1") as MovieClip;
         _loc2_ = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_offer1Click);
         _loc1_ = this.OfferMc.getChildByName("btn_offer2") as MovieClip;
         _loc2_ = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_offer2Click);
         _loc1_ = this.OfferMc.getChildByName("btn_offer3") as MovieClip;
         _loc2_ = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_offer3Click);
         _loc1_ = this.OfferMc.getChildByName("btn_left") as MovieClip;
         this.btn_left = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_leftClick);
         _loc1_ = this.OfferMc.getChildByName("btn_right") as MovieClip;
         this.btn_right = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_rightClick);
         this.tf_page = this.OfferMc.getChildByName("tf_page") as TextField;
         this.ParentLock = new Container("MyCorpsUI_OfferSceneLock");
         this.ParentLock.mouseEnabled = true;
         this.ParentLock.mouseChildren = true;
         this.ParentLock.fillRectangleWithoutBorder(GameKernel.fullRect.x,GameKernel.fullRect.y,GameKernel.fullRect.width,GameKernel.fullRect.height,0,0.5);
         _loc3_ = this.OfferMc.getChildByName("tf_jingti") as TextField;
         _loc3_.wordWrap = false;
         _loc3_.autoSize = TextFieldAutoSize.LEFT;
         _loc3_ = this.OfferMc.getChildByName("tf_he3") as TextField;
         _loc3_.autoSize = TextFieldAutoSize.LEFT;
         _loc3_.wordWrap = false;
         _loc3_ = this.OfferMc.getChildByName("tf_gold") as TextField;
         _loc3_.autoSize = TextFieldAutoSize.LEFT;
         _loc3_.wordWrap = false;
         _loc3_ = this.OfferMc.getChildByName("tf_cash") as TextField;
         _loc3_.autoSize = TextFieldAutoSize.LEFT;
         _loc3_.wordWrap = false;
         _loc3_ = this.OfferMc.getChildByName("tf_jingtiinput") as TextField;
         _loc3_.restrict = "0-9";
         _loc3_.maxChars = 9;
         _loc3_ = this.OfferMc.getChildByName("tf_he3input") as TextField;
         _loc3_.restrict = "0-9";
         _loc3_.maxChars = 9;
         _loc3_ = this.OfferMc.getChildByName("tf_goldinput") as TextField;
         _loc3_.restrict = "0-9";
         _loc3_.maxChars = 9;
         _loc3_ = this.OfferMc.getChildByName("tf_cashinput") as TextField;
         _loc3_.restrict = "0-9";
         _loc3_.maxChars = 9;
         this.IniList();
      }
      
      public static function getInstance() : MyCorpsUI_Offer
      {
         if(instance == null)
         {
            instance = new MyCorpsUI_Offer();
         }
         return instance;
      }
      
      private function IniList() : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:MovieClip = null;
         var _loc4_:XTextField = null;
         var _loc5_:String = null;
         var _loc6_:StyleSheet = null;
         var _loc1_:int = 0;
         while(_loc1_ < 10)
         {
            _loc2_ = this.OfferMc.getChildByName("mc_list" + _loc1_) as MovieClip;
            _loc3_ = GameKernel.getMovieClipInstance("OfferPlan");
            _loc3_.mouseChildren = true;
            _loc3_.name = "Row" + _loc1_;
            _loc2_.addChild(_loc3_);
            _loc2_.mouseChildren = true;
            _loc2_.visible = false;
            _loc4_ = new XTextField(_loc3_.tf_id);
            _loc4_.Data = _loc1_;
            _loc4_.OnClick = this.tf_idClick;
            _loc5_ = "a:link{text-decoration: underline;} a:hover{color:#ff0000;text-decoration: underline;} a:active{text-decoration: underline;}";
            _loc6_ = new StyleSheet();
            _loc6_.parseCSS(_loc5_);
            _loc3_.tf_id.styleSheet = _loc6_;
            _loc1_++;
         }
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
      
      private function tf_idClick(param1:MouseEvent, param2:XTextField) : void
      {
         if(this.ListMsg == null)
         {
            return;
         }
         var _loc3_:MSG_RESP_CONSORTIATHROWRANK_TEMP = this.ListMsg.Data[param2.Data];
         ChatAction.getInstance().sendChatUserInfoMessage(-1,_loc3_.Guid,3);
      }
      
      public function Clear() : void
      {
         var _loc1_:TextField = null;
         _loc1_ = this.OfferMc.getChildByName("tf_jingtiinput") as TextField;
         _loc1_.text = "";
         _loc1_ = this.OfferMc.getChildByName("tf_jingti") as TextField;
         _loc1_.text = StringManager.getInstance().getMessageString("ShipText8") + "：" + GamePlayer.getInstance().UserMetal;
         _loc1_ = this.OfferMc.getChildByName("tf_he3input") as TextField;
         _loc1_.text = "";
         _loc1_ = this.OfferMc.getChildByName("tf_he3") as TextField;
         _loc1_.text = StringManager.getInstance().getMessageString("ShipText9") + "：" + GamePlayer.getInstance().UserHe3;
         _loc1_ = this.OfferMc.getChildByName("tf_goldinput") as TextField;
         _loc1_.text = "";
         _loc1_ = this.OfferMc.getChildByName("tf_gold") as TextField;
         _loc1_.text = StringManager.getInstance().getMessageString("ShipText10") + "：" + GamePlayer.getInstance().UserMoney;
         _loc1_ = this.OfferMc.getChildByName("tf_cashinput") as TextField;
         _loc1_.text = "";
         _loc1_ = this.OfferMc.getChildByName("tf_cash") as TextField;
         _loc1_.text = StringManager.getInstance().getMessageString("AuctionText8") + "：" + GamePlayer.getInstance().cash;
         this.ClearList();
         this.PageIndex = 0;
         this.PageCount = 0;
         this.FirstOpenFlag = 1;
      }
      
      private function ClearList() : void
      {
         var _loc2_:MovieClip = null;
         this.tf_page.text = "";
         this.UserIdList.splice(0);
         this.UserNameList.splice(0);
         var _loc1_:int = 0;
         while(_loc1_ < 10)
         {
            _loc2_ = this.OfferMc.getChildByName("mc_list" + _loc1_) as MovieClip;
            _loc2_.visible = false;
            _loc1_++;
         }
      }
      
      public function Show() : void
      {
         this.Clear();
         this.RequestList();
         this.ParentLock.fillRectangleWithoutBorder(GameKernel.fullRect.left,GameKernel.fullRect.top,GameKernel.fullRect.width,GameKernel.fullRect.height + 130,0,0.5);
         GameKernel.renderManager.getUI().addComponent(this.ParentLock);
         this.ParentLock.addChild(this.OfferMc);
      }
      
      private function RequestList() : void
      {
         var _loc1_:MSG_REQUEST_CONSORTIATHROWRANK = new MSG_REQUEST_CONSORTIATHROWRANK();
         _loc1_.FirstOpenFlag = this.FirstOpenFlag;
         _loc1_.PageId = this.PageIndex;
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc1_);
         if(this.FirstOpenFlag == 1)
         {
            this.FirstOpenFlag = 0;
         }
      }
      
      public function RespOfferList(param1:MSG_RESP_CONSORTIATHROWRANK) : void
      {
         var _loc4_:MovieClip = null;
         var _loc5_:MSG_RESP_CONSORTIATHROWRANK_TEMP = null;
         var _loc6_:MovieClip = null;
         var _loc7_:TextField = null;
         var _loc2_:TextField = this.OfferMc.getChildByName("tf_corpsoffer") as TextField;
         _loc2_.text = StringManager.getInstance().getMessageString("CorpsText85") + param1.MyWealth;
         GamePlayer.getInstance().ConsortiaThrowValue = param1.MyWealth;
         this.PageCount = param1.MemberCount / 10;
         if(this.PageCount * 10 < param1.MemberCount)
         {
            ++this.PageCount;
         }
         this.ShowPageButton();
         this.ListMsg = param1;
         this.UserIdList.splice(0);
         this.UserNameList.splice(0);
         var _loc3_:int = 0;
         while(_loc3_ < 10)
         {
            _loc4_ = this.OfferMc.getChildByName("mc_list" + _loc3_) as MovieClip;
            if(_loc3_ < param1.DataLen)
            {
               _loc5_ = param1.Data[_loc3_];
               _loc4_.visible = true;
               _loc6_ = _loc4_.getChildByName("Row" + _loc3_) as MovieClip;
               _loc7_ = _loc6_.getChildByName("tf_grade") as TextField;
               _loc7_.text = (_loc5_.RankId + 1).toString();
               _loc7_ = _loc6_.getChildByName("tf_id") as TextField;
               _loc7_.htmlText = "<a href=\'event:\'>" + _loc5_.Name + "(" + _loc5_.Guid + ")" + "</a>";
               _loc7_ = _loc6_.getChildByName("tf_offerres") as TextField;
               _loc7_.text = _loc5_.ThrowRes.toString();
               _loc7_ = _loc6_.getChildByName("tf_offercash") as TextField;
               _loc7_.text = _loc5_.ThrowCredit.toString();
               this.UserIdList.push(_loc5_.UserId);
               this.UserNameList.push(_loc5_.Name);
            }
            else
            {
               _loc4_.visible = false;
            }
            _loc3_++;
         }
         GameKernel.getPlayerFacebookInfoArray(this.UserIdList,this.getPlayerFacebookInfoArrayCallback,this.UserNameList);
      }
      
      private function getPlayerFacebookInfoArrayCallback(param1:Array) : void
      {
         var _loc2_:FacebookUserInfo = null;
         var _loc3_:int = 0;
         var _loc4_:MSG_RESP_CONSORTIATHROWRANK_TEMP = null;
         var _loc5_:MovieClip = null;
         var _loc6_:MovieClip = null;
         var _loc7_:TextField = null;
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
                  _loc4_ = this.ListMsg.Data[_loc3_];
                  _loc5_ = this.OfferMc.getChildByName("mc_list" + _loc3_) as MovieClip;
                  _loc6_ = _loc5_.getChildByName("Row" + _loc3_) as MovieClip;
                  _loc7_ = _loc6_.getChildByName("tf_id") as TextField;
                  _loc7_.htmlText = "<a href=\'event:\'>" + _loc2_.first_name + "(" + _loc4_.Guid + ")" + "</a>";
                  break;
               }
               _loc3_++;
            }
         }
      }
      
      private function btn_closeClick(param1:Event) : void
      {
         this.ParentLock.removeChild(this.OfferMc);
         GameKernel.renderManager.getUI().removeComponent(this.ParentLock);
         GameKernel.popUpDisplayManager.HideAllPopup();
         MyCorpsUI.getInstance().Show();
      }
      
      private function btn_offerrankingClick(param1:Event) : void
      {
      }
      
      private function btn_offer0Click(param1:Event) : void
      {
         this.RequestOffer(2,"tf_jingtiinput",GamePlayer.getInstance().UserMetal);
      }
      
      private function btn_offer1Click(param1:Event) : void
      {
         this.RequestOffer(3,"tf_he3input",GamePlayer.getInstance().UserHe3);
      }
      
      private function btn_offer2Click(param1:Event) : void
      {
         this.RequestOffer(1,"tf_goldinput",GamePlayer.getInstance().UserMoney);
      }
      
      private function btn_offer3Click(param1:Event) : void
      {
         this.RequestOffer(0,"tf_cashinput",GamePlayer.getInstance().cash);
      }
      
      private function btn_leftClick(param1:Event) : void
      {
         --this.PageIndex;
         this.ClearList();
         this.RequestList();
      }
      
      private function btn_rightClick(param1:Event) : void
      {
         ++this.PageIndex;
         this.ClearList();
         this.RequestList();
      }
      
      private function ShowPageButton() : void
      {
         if(this.PageIndex > 0)
         {
            this.btn_left.setBtnDisabled(false);
         }
         else
         {
            this.btn_left.setBtnDisabled(true);
         }
         if(this.PageIndex + 1 < this.PageCount)
         {
            this.btn_right.setBtnDisabled(false);
         }
         else
         {
            this.btn_right.setBtnDisabled(true);
         }
         this.tf_page.text = this.PageIndex + 1 + "/" + this.PageCount;
      }
      
      private function RequestOffer(param1:int, param2:String, param3:Number) : void
      {
         var _loc4_:TextField = this.OfferMc.getChildByName(param2) as TextField;
         if(_loc4_.text == "")
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CorpsText19"),0);
            return;
         }
         var _loc5_:Number = Number(_loc4_.text);
         var _loc6_:Number = param3;
         if(param1 != 0)
         {
            _loc6_ /= 10000;
         }
         if(_loc5_ <= 0)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CorpsText20"),0);
            return;
         }
         if(_loc5_ > _loc6_)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CorpsText21"),0);
            return;
         }
         var _loc7_:MSG_REQUEST_CONSORTIATHROWVALUE = new MSG_REQUEST_CONSORTIATHROWVALUE();
         _loc7_.Type = param1;
         _loc7_.Value = _loc5_;
         _loc7_.SeqId = GamePlayer.getInstance().seqID++;
         _loc7_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc7_);
      }
      
      public function RespOffer() : void
      {
         MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CorpsText72"),0);
         this.Clear();
         this.RequestList();
      }
   }
}

