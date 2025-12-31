package logic.ui
{
   import com.star.frameworks.facebook.FacebookUserInfo;
   import com.star.frameworks.managers.FontManager;
   import com.star.frameworks.managers.StringManager;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.HButtonType;
   import logic.game.GameKernel;
   import logic.widget.DataWidget;
   import net.base.NetManager;
   import net.msg.mail.MSG_REQUEST_DELETEEMAIL;
   import net.msg.mail.MSG_REQUEST_EMAILINFO;
   import net.msg.mail.MSG_RESP_EMAILINFO;
   import net.msg.mail.MSG_RESP_EMAILINFO_TEMP;
   
   public class MailUI_Inbox
   {
      
      private static var instance:MailUI_Inbox;
      
      private const RowCount:int = 9;
      
      private var InboxListMc:MovieClip;
      
      private var PageId:int;
      
      private var PageCount:int;
      
      private var btn_left:HButton;
      
      private var btn_right:HButton;
      
      private var tf_page:TextField;
      
      private var tf_letternum:TextField;
      
      private var CheckboxList:Array = new Array();
      
      private var MarkList:Array = new Array();
      
      private var UserId:Array = new Array();
      
      private var UserDefaultNameList:Array = new Array();
      
      private var UserNameList:Array = new Array();
      
      private var mc_checkbox:HButton;
      
      private var LastSelectedRow:MovieClip;
      
      private var SelectedRowId:int;
      
      private var btn_allbox:HButton;
      
      private var btn_reportbox:HButton;
      
      private var btn_goodsbox:HButton;
      
      private var btn_shipbox:HButton;
      
      private var btn_commonbox:HButton;
      
      private var btn_systembox:HButton;
      
      private var SelectedTypeBtn:HButton;
      
      private var SelectedType:int;
      
      private var MailList:MSG_RESP_EMAILINFO;
      
      private var NewMailOnly:int;
      
      private var DeleteMailId:int;
      
      public function MailUI_Inbox()
      {
         super();
         this.InboxListMc = GameKernel.getMovieClipInstance("InboxlistMc",0,0,false);
         this.init();
      }
      
      public static function getInstance() : MailUI_Inbox
      {
         if(instance == null)
         {
            instance = new MailUI_Inbox();
         }
         return instance;
      }
      
      private function init() : void
      {
         var _loc1_:HButton = null;
         var _loc2_:MovieClip = null;
         _loc2_ = this.InboxListMc.getChildByName("btn_allchoose") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_allchooseClick);
         _loc2_ = this.InboxListMc.getChildByName("btn_delete") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_deleteSelectedClick);
         _loc2_ = this.InboxListMc.getChildByName("btn_deleteread") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_deletereadClick);
         _loc2_ = this.InboxListMc.getChildByName("btn_left") as MovieClip;
         this.btn_left = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_leftClick);
         _loc2_ = this.InboxListMc.getChildByName("btn_right") as MovieClip;
         this.btn_right = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_rightClick);
         _loc2_ = this.InboxListMc.getChildByName("mc_checkbox") as MovieClip;
         this.mc_checkbox = new HButton(_loc2_,HButtonType.SELECT);
         _loc2_.addEventListener(MouseEvent.CLICK,this.mc_checkboxClick);
         this.tf_page = this.InboxListMc.getChildByName("tf_page") as TextField;
         this.tf_letternum = this.InboxListMc.getChildByName("tf_letternum") as TextField;
         _loc2_ = this.InboxListMc.getChildByName("btn_allbox") as MovieClip;
         this.btn_allbox = new HButton(_loc2_,HButtonType.SELECT);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_allboxClick);
         _loc2_ = this.InboxListMc.getChildByName("btn_reportbox") as MovieClip;
         this.btn_reportbox = new HButton(_loc2_,HButtonType.SELECT);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_reportboxClick);
         _loc2_ = this.InboxListMc.getChildByName("btn_goodsbox") as MovieClip;
         this.btn_goodsbox = new HButton(_loc2_,HButtonType.SELECT);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_goodsboxClick);
         _loc2_ = this.InboxListMc.getChildByName("btn_commonbox") as MovieClip;
         this.btn_commonbox = new HButton(_loc2_,HButtonType.SELECT);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_commonboxClick);
         _loc2_ = this.InboxListMc.getChildByName("btn_systembox") as MovieClip;
         this.btn_systembox = new HButton(_loc2_,HButtonType.SELECT);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_systemboxClick);
         this.InitList();
      }
      
      public function FirstShow() : void
      {
         this.mc_checkbox.setSelect(false);
         this.NewMailOnly = -1;
         this.btn_allboxClick(null);
      }
      
      private function btn_allboxClick(param1:Event) : void
      {
         this.Clear();
         this.SelectedType = -1;
         this.ResetSelectedTypeBtn(this.btn_allbox);
         this.ReceiveMail();
      }
      
      private function btn_reportboxClick(param1:Event) : void
      {
         this.Clear();
         this.SelectedType = 1;
         this.ResetSelectedTypeBtn(this.btn_reportbox);
         this.ReceiveMail();
      }
      
      private function btn_goodsboxClick(param1:Event) : void
      {
         this.Clear();
         this.SelectedType = 2;
         this.ResetSelectedTypeBtn(this.btn_goodsbox);
         this.ReceiveMail();
      }
      
      private function btn_commonboxClick(param1:Event) : void
      {
         this.Clear();
         this.SelectedType = 0;
         this.ResetSelectedTypeBtn(this.btn_commonbox);
         this.ReceiveMail();
      }
      
      private function btn_systemboxClick(param1:Event) : void
      {
         this.Clear();
         this.SelectedType = 5;
         this.ResetSelectedTypeBtn(this.btn_systembox);
         this.ReceiveMail();
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
      
      private function btn_allchooseClick(param1:Event) : void
      {
         var _loc2_:HButton = null;
         for each(_loc2_ in this.CheckboxList)
         {
            _loc2_.setSelect(true);
         }
      }
      
      private function btn_deleteSelectedClick(param1:Event) : void
      {
         var _loc4_:HButton = null;
         var _loc5_:MSG_RESP_EMAILINFO_TEMP = null;
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         while(_loc3_ < this.MailList.DataLen)
         {
            _loc4_ = this.CheckboxList[_loc3_];
            if(_loc4_.m_selsected)
            {
               _loc5_ = this.MailList.Data[_loc3_];
               if(_loc5_.GoodFlag == 1)
               {
                  _loc2_ = true;
                  break;
               }
            }
            _loc3_++;
         }
         if(_loc2_)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("MailText12"),2,this.deleteSelectedClickCallback);
         }
         else
         {
            this.deleteSelectedClickCallback(true);
         }
      }
      
      private function deleteSelectedClickCallback(param1:Boolean = true) : void
      {
         var _loc3_:HButton = null;
         var _loc4_:MSG_RESP_EMAILINFO_TEMP = null;
         if(!param1)
         {
            return;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this.MailList.DataLen)
         {
            _loc3_ = this.CheckboxList[_loc2_];
            if(_loc3_.m_selsected)
            {
               _loc4_ = this.MailList.Data[_loc2_];
               this.DeleteMail(_loc4_.AutoId);
            }
            _loc2_++;
         }
         this.ReceiveMail();
      }
      
      private function btn_deletereadClick(param1:Event) : void
      {
         var _loc4_:MSG_RESP_EMAILINFO_TEMP = null;
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         while(_loc3_ < this.MailList.DataLen)
         {
            _loc4_ = this.MailList.Data[_loc3_];
            if(_loc4_.ReadFlag != 0 && _loc4_.GoodFlag == 1)
            {
               _loc2_ = true;
               break;
            }
            _loc3_++;
         }
         if(_loc2_)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("MailText12"),2,this.deletereadClickCallback);
         }
         else
         {
            this.deletereadClickCallback();
         }
      }
      
      private function deletereadClickCallback() : void
      {
         var _loc2_:MSG_RESP_EMAILINFO_TEMP = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.MailList.DataLen)
         {
            _loc2_ = this.MailList.Data[_loc1_];
            if(_loc2_.ReadFlag != 0)
            {
               this.DeleteMail(_loc2_.AutoId);
            }
            _loc1_++;
         }
         this.ReceiveMail();
      }
      
      public function DeleteMail2(param1:int) : void
      {
         var _loc3_:MSG_RESP_EMAILINFO_TEMP = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.MailList.DataLen)
         {
            _loc3_ = this.MailList.Data[_loc2_];
            if(_loc3_.AutoId == param1)
            {
               if(_loc3_.ReadFlag != 0 && _loc3_.GoodFlag == 1)
               {
                  this.DeleteMailId = param1;
                  MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("MailText12"),2,this.DeleteMail2Callback);
               }
               else
               {
                  this.DeleteMail(param1);
               }
            }
            _loc2_++;
         }
         this.ReceiveMail();
      }
      
      private function DeleteMail2Callback() : void
      {
         this.DeleteMail(this.DeleteMailId);
         this.ReceiveMail();
      }
      
      private function DeleteMail(param1:int) : void
      {
         var _loc2_:MSG_REQUEST_DELETEEMAIL = new MSG_REQUEST_DELETEEMAIL();
         _loc2_.AutoId = param1;
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc2_);
      }
      
      private function btn_leftClick(param1:Event) : void
      {
         this.PrePage();
      }
      
      private function btn_rightClick(param1:Event) : void
      {
         this.NextPage();
      }
      
      private function mc_checkboxClick(param1:Event) : void
      {
         this.PageId = 0;
         if(this.mc_checkbox.m_selsected)
         {
            this.NewMailOnly = 0;
         }
         else
         {
            this.NewMailOnly = -1;
         }
         this.ReceiveMail();
      }
      
      private function InitList() : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:MovieClip = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.RowCount)
         {
            _loc2_ = this.InboxListMc.getChildByName("mc_base" + _loc1_) as MovieClip;
            _loc3_ = GameKernel.getMovieClipInstance("InboxPlanMc",0,0,false);
            _loc3_.name = "Row" + _loc1_;
            this.InitRow(_loc3_,_loc1_);
            _loc2_.addChild(_loc3_);
            _loc2_.visible = false;
            _loc1_++;
         }
      }
      
      private function InitRow(param1:MovieClip, param2:int) : void
      {
         var _loc3_:MovieClip = param1.getChildByName("btn_delete") as MovieClip;
         var _loc4_:HButton = new HButton(_loc3_);
         _loc3_.addEventListener(MouseEvent.CLICK,this.btn_deleteRowClick);
         _loc3_ = param1.getChildByName("btn_check") as MovieClip;
         _loc4_ = new HButton(_loc3_,HButtonType.SELECT);
         this.CheckboxList.push(_loc4_);
         _loc3_ = param1.getChildByName("btn_mark") as MovieClip;
         _loc3_.stop();
         this.MarkList.push(_loc3_);
         var _loc5_:XButton = new XButton(param1);
         _loc5_.Data = param2;
         _loc5_.OnMouseOver = this.McRowMouseOver;
         _loc5_.OnClick = this.McRowClick;
         _loc5_.m_movie.mouseChildren = true;
         var _loc6_:TextField = param1.getChildByName("tf_mailstate") as TextField;
         _loc6_.mouseEnabled = false;
         _loc6_ = param1.getChildByName("tf_addresser") as TextField;
         _loc6_.mouseEnabled = false;
         _loc6_ = param1.getChildByName("tf_content") as TextField;
         _loc6_.mouseEnabled = false;
         _loc6_ = param1.getChildByName("tf_time") as TextField;
         _loc6_.mouseEnabled = false;
      }
      
      private function btn_deleteRowClick(param1:MouseEvent) : void
      {
         var _loc2_:MSG_RESP_EMAILINFO_TEMP = null;
         if(this.SelectedRowId == -1)
         {
            return;
         }
         if(this.SelectedRowId < this.MailList.DataLen)
         {
            _loc2_ = this.MailList.Data[this.SelectedRowId];
            this.DeleteMailId = _loc2_.AutoId;
            if(_loc2_.GoodFlag == 1)
            {
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("MailText12"),2,this.DeleteMail2Callback);
            }
            else
            {
               this.deleteRowClickCallback(true);
            }
         }
      }
      
      private function deleteRowClickCallback(param1:Boolean) : void
      {
         var _loc2_:MSG_RESP_EMAILINFO_TEMP = null;
         if(!param1)
         {
            return;
         }
         if(this.SelectedRowId < this.MailList.DataLen)
         {
            _loc2_ = this.MailList.Data[this.SelectedRowId];
            this.DeleteMail(_loc2_.AutoId);
            this.ReceiveMail();
         }
      }
      
      private function McRowMouseOver(param1:MouseEvent, param2:XButton) : void
      {
         var _loc3_:int = param2.Data;
         var _loc4_:MovieClip = this.InboxListMc.getChildByName("mc_base" + _loc3_) as MovieClip;
         _loc4_ = _loc4_.getChildByName("Row" + _loc3_) as MovieClip;
         if(this.LastSelectedRow != null && this.LastSelectedRow != _loc4_)
         {
            this.LastSelectedRow.gotoAndStop("up");
         }
         this.LastSelectedRow = _loc4_;
         this.LastSelectedRow.gotoAndStop("selected");
         this.SelectedRowId = _loc3_;
      }
      
      private function McRowClick(param1:MouseEvent, param2:XButton) : void
      {
         var _loc7_:String = null;
         if(DisplayObject(param1.target).name == "btn_check")
         {
            return;
         }
         if(DisplayObject(param1.target).name == "btn_delete")
         {
            return;
         }
         var _loc3_:int = param2.Data;
         var _loc4_:MovieClip = this.InboxListMc.getChildByName("mc_base" + _loc3_) as MovieClip;
         _loc4_ = _loc4_.getChildByName("Row" + _loc3_) as MovieClip;
         var _loc5_:MSG_RESP_EMAILINFO_TEMP = this.MailList.Data[_loc3_];
         var _loc6_:TextField = _loc4_.getChildByName("tf_addresser") as TextField;
         if(this.UserNameList[_loc3_] == null)
         {
            if(this.UserId[_loc3_] < 0)
            {
               _loc7_ = StringManager.getInstance().getMessageString("StarText5");
               MailUI.getInstance().GetDetail(_loc5_,_loc7_,DataWidget.GetDateTime(_loc5_.DateTime * 1000),_loc6_.text);
            }
            else
            {
               MailUI.getInstance().GetDetail(_loc5_,this.UserId[_loc3_],DataWidget.GetDateTime(_loc5_.DateTime * 1000),_loc6_.text);
            }
         }
         else
         {
            MailUI.getInstance().GetDetail(_loc5_,this.UserNameList[_loc3_],DataWidget.GetDateTime(_loc5_.DateTime * 1000),_loc6_.text);
         }
      }
      
      private function Clear() : void
      {
         var _loc2_:MovieClip = null;
         this.MailList = null;
         this.PageId = 0;
         this.PageCount = 0;
         this.btn_left.setBtnDisabled(true);
         this.btn_right.setBtnDisabled(true);
         this.tf_page.text = "";
         this.ClearSelectedRow();
         var _loc1_:int = 0;
         while(_loc1_ < this.RowCount)
         {
            _loc2_ = this.InboxListMc.getChildByName("mc_base" + _loc1_) as MovieClip;
            _loc2_.visible = false;
            _loc1_++;
         }
      }
      
      private function ClearSelectedRow() : void
      {
         if(this.LastSelectedRow != null)
         {
            this.LastSelectedRow.gotoAndStop("up");
            this.LastSelectedRow = null;
         }
      }
      
      public function GetInboxList() : MovieClip
      {
         if(this.MailList != null)
         {
            this.OnReceiveMail(this.MailList,false);
         }
         return this.InboxListMc;
      }
      
      private function ReceiveMail() : void
      {
         var _loc1_:MSG_REQUEST_EMAILINFO = new MSG_REQUEST_EMAILINFO();
         _loc1_.Type = this.SelectedType;
         _loc1_.PageId = this.PageId;
         _loc1_.ReadFlag = this.NewMailOnly;
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc1_);
         this.UserId.splice(0);
         this.UserDefaultNameList.splice(0);
      }
      
      public function NextPage() : void
      {
         if(this.PageId + 1 < this.PageCount)
         {
            ++this.PageId;
            this.ReceiveMail();
         }
         this.ShowPageButton();
         this.ClearSelectedRow();
      }
      
      public function PrePage() : void
      {
         if(this.PageId > 0)
         {
            --this.PageId;
            this.ReceiveMail();
         }
         this.ShowPageButton();
         this.ClearSelectedRow();
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
         if(this.PageId + 1 >= this.PageCount)
         {
            this.btn_right.setBtnDisabled(true);
         }
         else
         {
            this.btn_right.setBtnDisabled(false);
         }
         if(this.PageCount <= 0)
         {
            this.tf_page.text = "1/1";
         }
         else
         {
            this.tf_page.text = this.PageId + 1 + "/" + this.PageCount;
         }
      }
      
      public function OnReceiveMail(param1:MSG_RESP_EMAILINFO, param2:Boolean = true) : void
      {
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         var _loc6_:HButton = null;
         var _loc7_:MSG_RESP_EMAILINFO_TEMP = null;
         var _loc8_:TextField = null;
         var _loc9_:Boolean = false;
         var _loc10_:MovieClip = null;
         var _loc11_:uint = 0;
         var _loc12_:TextFormat = null;
         this.MailList = param1;
         this.PageCount = param1.EmailCount / this.RowCount;
         if(this.PageCount * this.RowCount < param1.EmailCount)
         {
            ++this.PageCount;
         }
         this.tf_letternum.text = param1.EmailCount.toString();
         var _loc3_:int = 0;
         while(_loc3_ < this.RowCount)
         {
            _loc4_ = this.InboxListMc.getChildByName("mc_base" + _loc3_) as MovieClip;
            if(_loc3_ < param1.DataLen)
            {
               _loc5_ = _loc4_.getChildByName("Row" + _loc3_) as MovieClip;
               _loc6_ = this.CheckboxList[_loc3_] as HButton;
               _loc6_.setSelect(false);
               _loc7_ = param1.Data[_loc3_];
               _loc8_ = _loc5_.getChildByName("tf_mailstate") as TextField;
               if(_loc7_.ReadFlag == 0)
               {
                  _loc8_.text = StringManager.getInstance().getMessageString("MailText39");
                  _loc9_ = true;
               }
               else
               {
                  _loc8_.text = StringManager.getInstance().getMessageString("MailText38");
                  _loc9_ = false;
               }
               _loc10_ = this.MarkList[_loc3_];
               if(_loc7_.Type >= 2 && _loc7_.Type <= 4)
               {
                  _loc10_.visible = true;
                  if(_loc7_.GoodFlag == 0)
                  {
                     _loc10_.gotoAndStop("up");
                  }
                  else
                  {
                     _loc10_.gotoAndStop("selected");
                  }
                  _loc11_ = 65280;
               }
               else
               {
                  _loc10_.visible = false;
                  if(_loc7_.Type == 1)
                  {
                     _loc11_ = 16711680;
                     _loc7_.Title = StringManager.getInstance().getMessageString("MailText1") + "(" + (_loc7_.SrcGuid == 1 ? StringManager.getInstance().getMessageString("MailText27") : StringManager.getInstance().getMessageString("MailText28")) + ")";
                  }
                  else
                  {
                     _loc11_ = 2730959;
                  }
               }
               _loc12_ = FontManager.getInstance().getTextFormat("Tahoma",12,_loc11_,_loc9_);
               _loc8_.setTextFormat(_loc12_);
               _loc8_ = _loc5_.getChildByName("tf_addresser") as TextField;
               if(_loc7_.Type == 1 || _loc7_.Type == 5 || _loc7_.SrcGuid < 0 || _loc7_.TitleType <= 18 && _loc7_.TitleType >= 4 || _loc7_.Type == 4 && _loc7_.TitleType == 0)
               {
                  if(_loc7_.Type == 0 && (_loc7_.Title != "" || _loc7_.TitleType < 12 || _loc7_.TitleType > 18))
                  {
                     _loc8_.text = _loc7_.Name + "(ID:" + _loc7_.SrcGuid + ")";
                  }
                  else
                  {
                     _loc8_.text = StringManager.getInstance().getMessageString("MailText4");
                  }
               }
               else
               {
                  _loc8_.text = _loc7_.Name + "(ID:" + _loc7_.SrcGuid + ")";
               }
               _loc8_.setTextFormat(_loc12_);
               if(_loc7_.Title == "" && param2)
               {
                  switch(_loc7_.TitleType)
                  {
                     case 0:
                        _loc7_.Title = StringManager.getInstance().getMessageString("MailText29");
                        break;
                     case 1:
                        _loc7_.Title = StringManager.getInstance().getMessageString("MailText30");
                        break;
                     case 2:
                        _loc7_.Title = StringManager.getInstance().getMessageString("MailText31");
                        break;
                     case 3:
                        _loc7_.Title = StringManager.getInstance().getMessageString("MailText32");
                        break;
                     case 4:
                        _loc7_.Title = StringManager.getInstance().getMessageString("MailText33");
                        break;
                     case 5:
                        _loc7_.Title = StringManager.getInstance().getMessageString("MailText41");
                        break;
                     case 6:
                        _loc7_.Title = StringManager.getInstance().getMessageString("MailText44");
                        break;
                     case 7:
                        _loc7_.Title = StringManager.getInstance().getMessageString("MailText55");
                        break;
                     case 8:
                        _loc7_.Title = StringManager.getInstance().getMessageString("MailText56");
                        break;
                     case 9:
                        _loc7_.Title = StringManager.getInstance().getMessageString("EmailText2");
                        break;
                     case 10:
                        _loc7_.Title = StringManager.getInstance().getMessageString("MailText57");
                        break;
                     case 11:
                        _loc7_.Title = StringManager.getInstance().getMessageString("MailText58");
                        break;
                     case 12:
                        _loc7_.Title = StringManager.getInstance().getMessageString("MailText60");
                        break;
                     case 13:
                        _loc7_.Title = StringManager.getInstance().getMessageString("VIP1");
                        break;
                     case 14:
                        _loc7_.Title = StringManager.getInstance().getMessageString("MailText62");
                        break;
                     case 15:
                        _loc7_.Title = StringManager.getInstance().getMessageString("Pirate12");
                        break;
                     case 16:
                        _loc7_.Title = StringManager.getInstance().getMessageString("Boss18");
                        break;
                     case 17:
                        _loc7_.Title = StringManager.getInstance().getMessageString("Boss37");
                        break;
                     case 18:
                        _loc7_.Title = StringManager.getInstance().getMessageString("Boss48");
                  }
               }
               else if(param2)
               {
                  _loc7_.TitleType = -1;
               }
               _loc8_ = _loc5_.getChildByName("tf_content") as TextField;
               _loc8_.text = _loc7_.Title;
               _loc8_.setTextFormat(_loc12_);
               _loc8_ = _loc5_.getChildByName("tf_time") as TextField;
               _loc8_.text = DataWidget.GetDateTime(_loc7_.DateTime * 1000);
               _loc8_.setTextFormat(_loc12_);
               this.UserId.push(_loc7_.SrcUserid);
               this.UserDefaultNameList.push(_loc7_.Name);
               this.UserNameList[_loc3_] = null;
               _loc4_.visible = true;
            }
            else
            {
               _loc4_.visible = false;
            }
            _loc3_++;
         }
         GameKernel.getPlayerFacebookInfoArray(this.UserId,this.getPlayerFacebookInfoArrayCallback,this.UserDefaultNameList);
         this.ShowPageButton();
      }
      
      private function getPlayerFacebookInfoArrayCallback(param1:Array) : void
      {
         var _loc2_:FacebookUserInfo = null;
         var _loc3_:int = 0;
         var _loc4_:MSG_RESP_EMAILINFO_TEMP = null;
         var _loc5_:MovieClip = null;
         var _loc6_:MovieClip = null;
         var _loc7_:TextField = null;
         var _loc8_:TextFormat = null;
         if(param1 != null)
         {
            for each(_loc2_ in param1)
            {
               _loc3_ = 0;
               while(_loc3_ < this.MailList.DataLen)
               {
                  _loc4_ = this.MailList.Data[_loc3_];
                  if(_loc2_.uid == _loc4_.SrcUserid)
                  {
                     _loc5_ = this.InboxListMc.getChildByName("mc_base" + _loc3_) as MovieClip;
                     _loc6_ = _loc5_.getChildByName("Row" + _loc3_) as MovieClip;
                     _loc7_ = _loc6_.getChildByName("tf_addresser") as TextField;
                     if(_loc7_.text != StringManager.getInstance().getMessageString("MailText4"))
                     {
                        _loc8_ = _loc7_.getTextFormat();
                        _loc7_.text = _loc2_.first_name + "(ID:" + _loc4_.SrcGuid + ")";
                        _loc7_.setTextFormat(_loc8_);
                     }
                     this.UserNameList[_loc3_] = _loc2_.first_name;
                  }
                  _loc3_++;
               }
            }
         }
      }
   }
}

