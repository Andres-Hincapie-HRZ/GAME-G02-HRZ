package logic.ui
{
   import com.star.frameworks.facebook.FacebookUserInfo;
   import com.star.frameworks.managers.StringManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.StyleSheet;
   import flash.text.TextField;
   import logic.action.ChatAction;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.props.propsInfo;
   import logic.entry.shipmodel.ShipbodyInfo;
   import logic.game.GameKernel;
   import logic.reader.CPropsReader;
   import logic.reader.CShipmodelReader;
   import logic.ui.tip.ShipModelInfoTip;
   import logic.utils.UpdateResource;
   import logic.widget.DataWidget;
   import net.base.NetManager;
   import net.msg.mall.MSG_REQUEST_BUYTRADEGOODS;
   import net.msg.mall.MSG_REQUEST_TRADEINFO;
   import net.msg.mall.MSG_RESP_BUYTRADEGOODS;
   import net.msg.mall.MSG_RESP_TRADEINFO;
   import net.msg.mall.MSG_RESP_TRADEINFO_TEMP;
   
   public class MallUI_Buy
   {
      
      private static var instance:MallUI_Buy;
      
      private var BuyMc:MovieClip;
      
      private var MsgBuyInfo:MSG_RESP_TRADEINFO;
      
      private var btn_all:HButton;
      
      private var btn_airship:HButton;
      
      private var btn_paper:HButton;
      
      private var btn_card:HButton;
      
      private var btn_equip:HButton;
      
      private var btn_prop:HButton;
      
      private var SelectedBtn:HButton;
      
      private var btn_left:HButton;
      
      private var btn_right:HButton;
      
      private var btn_homepage:HButton;
      
      private var btn_lastpage:HButton;
      
      private var tf_page:TextField;
      
      private var PageIndex:int;
      
      private var PageCount:int;
      
      private var SelectedType:int;
      
      private var SelectedItem:MovieClip;
      
      private var SelectedItemIndex:int = -1;
      
      private var btn_buy:HButton;
      
      private var UserIdList:Array;
      
      private var UserNameList:Array;
      
      private var tf_input:XTextField;
      
      private var SelectedSearchList:XButton;
      
      private var BuysearchPop:MovieClip;
      
      private var SearchResultArray:Array;
      
      private var SearchTypeId:int;
      
      private var _PropsTip:MovieClip;
      
      private var SearchId:int;
      
      private var ShipBodyLen:int;
      
      public function MallUI_Buy()
      {
         super();
         this.UserIdList = new Array();
         this.UserNameList = new Array();
         this.BuyMc = GameKernel.getMovieClipInstance("BuyMc",0,0,false);
         this.Init();
      }
      
      public static function getInstance() : MallUI_Buy
      {
         if(instance == null)
         {
            instance = new MallUI_Buy();
         }
         return instance;
      }
      
      public function Clear() : void
      {
         this.MsgBuyInfo = null;
      }
      
      public function GetMc() : MovieClip
      {
         this.ShowMoney();
         this.PageIndex = 0;
         this.btn_allClick(null);
         this.tf_input.ResetDefaultText();
         if(this.BuyMc.contains(this.BuysearchPop))
         {
            this.BuyMc.removeChild(this.BuysearchPop);
         }
         this.SearchId = -1;
         return this.BuyMc;
      }
      
      public function ShowMoney() : void
      {
         TextField(this.BuyMc.tf_gold).text = GamePlayer.getInstance().UserMoney.toString();
         TextField(this.BuyMc.tf_cash).text = GamePlayer.getInstance().cash.toString();
      }
      
      private function Init() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:HButton = null;
         _loc1_ = this.BuyMc.getChildByName("btn_search") as MovieClip;
         _loc2_ = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_searchClick);
         _loc1_ = this.BuyMc.getChildByName("btn_all") as MovieClip;
         this.btn_all = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_allClick);
         _loc1_ = this.BuyMc.getChildByName("btn_airship") as MovieClip;
         this.btn_airship = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_airshipClick);
         _loc1_ = this.BuyMc.getChildByName("btn_paper") as MovieClip;
         this.btn_paper = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_paperClick);
         _loc1_ = this.BuyMc.getChildByName("btn_card") as MovieClip;
         this.btn_card = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_cardClick);
         _loc1_ = this.BuyMc.getChildByName("btn_goods") as MovieClip;
         this.btn_equip = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_equipClick);
         _loc1_ = this.BuyMc.getChildByName("btn_props") as MovieClip;
         this.btn_prop = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_propClick);
         _loc1_ = this.BuyMc.getChildByName("btn_left") as MovieClip;
         this.btn_left = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_leftClick);
         _loc1_ = this.BuyMc.getChildByName("btn_right") as MovieClip;
         this.btn_right = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_rightClick);
         _loc1_ = this.BuyMc.getChildByName("btn_homepage") as MovieClip;
         this.btn_homepage = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_homepageClick);
         _loc1_ = this.BuyMc.getChildByName("btn_lastpage") as MovieClip;
         this.btn_lastpage = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_lastpageClick);
         _loc1_ = this.BuyMc.getChildByName("btn_buy") as MovieClip;
         this.btn_buy = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_buyClick);
         this.btn_buy.setBtnDisabled(true);
         this.tf_page = this.BuyMc.getChildByName("tf_page") as TextField;
         this.tf_input = new XTextField(this.BuyMc.getChildByName("tf_input") as TextField,StringManager.getInstance().getMessageString("AuctionText39"));
         (this.BuyMc.getChildByName("tf_input") as TextField).addEventListener(Event.CHANGE,this.tf_inputChange);
         this.InitList();
         this.InitBuysearchPop();
      }
      
      private function InitList() : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:MovieClip = null;
         var _loc4_:XMovieClip = null;
         var _loc5_:MovieClip = null;
         var _loc6_:XButton = null;
         var _loc7_:XTextField = null;
         var _loc8_:String = null;
         var _loc9_:StyleSheet = null;
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            _loc2_ = this.BuyMc.getChildByName("mc_list" + _loc1_) as MovieClip;
            _loc3_ = GameKernel.getMovieClipInstance("BuylistMc",0,0,false);
            _loc3_.stop();
            _loc3_.name = "Item" + _loc1_;
            _loc4_ = new XMovieClip(_loc3_);
            _loc4_.Data = _loc1_;
            _loc4_.OnClick = this.McItemClick;
            _loc5_ = _loc3_.getChildByName("mc_base") as MovieClip;
            _loc6_ = new XButton(_loc5_);
            _loc6_.Data = _loc1_;
            _loc6_.OnMouseOver = this.McItemMouseOver;
            _loc5_.addEventListener(MouseEvent.MOUSE_OUT,this.McItemMouseOut);
            _loc5_.mouseChildren = false;
            _loc7_ = new XTextField(_loc3_.tf_seller);
            _loc7_.Data = _loc1_;
            _loc7_.OnClick = this.tf_sellerClick;
            _loc8_ = "a:link{text-decoration: underline;} a:hover{color:#ff0000;text-decoration: underline;} a:active{text-decoration: underline;}";
            _loc9_ = new StyleSheet();
            _loc9_.parseCSS(_loc8_);
            _loc3_.tf_seller.styleSheet = _loc9_;
            _loc2_.addChild(_loc3_);
            _loc2_.visible = false;
            _loc1_++;
         }
      }
      
      private function InitBuysearchPop() : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:XButton = null;
         this.BuysearchPop = GameKernel.getMovieClipInstance("BuysearchPop",0,0,false);
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            _loc2_ = this.BuysearchPop.getChildByName("mc_list" + _loc1_) as MovieClip;
            _loc3_ = new XButton(_loc2_);
            _loc3_.Data = _loc1_;
            _loc3_.OnClick = this.BuysearchListClick;
            _loc3_.OnMouseOver = this.McListMouseOver;
            _loc2_.addEventListener(MouseEvent.MOUSE_OUT,this.McListMouseOut);
            _loc1_++;
         }
      }
      
      private function McItemClick(param1:MouseEvent, param2:XMovieClip) : void
      {
         if(this.SelectedItem != null)
         {
            this.SelectedItem.gotoAndStop("up");
         }
         this.SelectedItem = param2.m_movie;
         this.SelectedItem.gotoAndStop("selected");
         this.SelectedItemIndex = param2.Data;
         if(this.SelectedItemIndex >= this.MsgBuyInfo.DataLen)
         {
            return;
         }
         this.btn_buy.setBtnDisabled(true);
         var _loc3_:MSG_RESP_TRADEINFO_TEMP = this.MsgBuyInfo.Data[this.SelectedItemIndex];
         if(_loc3_.SellGuid != GamePlayer.getInstance().Guid)
         {
            if(_loc3_.PriceType == 0 && _loc3_.Price <= GamePlayer.getInstance().UserMoney)
            {
               this.btn_buy.setBtnDisabled(false);
            }
            else if(_loc3_.PriceType == 1 && _loc3_.Price <= GamePlayer.getInstance().cash)
            {
               this.btn_buy.setBtnDisabled(false);
            }
         }
      }
      
      private function McItemMouseOver(param1:MouseEvent, param2:XButton) : void
      {
         var _loc5_:Point = null;
         var _loc3_:int = param2.Data;
         if(_loc3_ >= this.MsgBuyInfo.DataLen)
         {
            return;
         }
         var _loc4_:MSG_RESP_TRADEINFO_TEMP = this.MsgBuyInfo.Data[_loc3_];
         if(_loc4_.TradeType == 0)
         {
            ShipModelInfoTip.GetInstance().Show(_loc4_.Id,param2.m_movie.localToGlobal(new Point(50,0)),true);
         }
         else
         {
            _loc5_ = param2.m_movie.localToGlobal(new Point(40,0));
            _loc5_ = this.BuyMc.globalToLocal(_loc5_);
            this._PropsTip = PackUi.getInstance().TipHd(_loc5_.x,_loc5_.y,_loc4_.Id,true);
            this._PropsTip.x = _loc5_.x;
            this._PropsTip.y = _loc5_.y - 20;
            this.BuyMc.addChild(this._PropsTip);
         }
      }
      
      private function McItemMouseOut(param1:MouseEvent) : void
      {
         ShipModelInfoTip.GetInstance().Hide();
         if(this._PropsTip != null && this.BuyMc.contains(this._PropsTip))
         {
            this.BuyMc.removeChild(this._PropsTip);
         }
      }
      
      private function btn_buyClick(param1:Event) : void
      {
         var _loc4_:int = 0;
         if(this.SelectedItemIndex >= this.MsgBuyInfo.DataLen)
         {
            return;
         }
         var _loc2_:MSG_RESP_TRADEINFO_TEMP = this.MsgBuyInfo.Data[this.SelectedItemIndex];
         if(_loc2_.TradeType == 1)
         {
            _loc4_ = UpdateResource.getInstance().HasPackSpace(_loc2_.Id,0,_loc2_.Num);
            if(_loc4_ == 1)
            {
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CommanderText12"),10);
               return;
            }
            if(_loc4_ == 2)
            {
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("BattleTXT11"),0);
               return;
            }
         }
         var _loc3_:MSG_REQUEST_BUYTRADEGOODS = new MSG_REQUEST_BUYTRADEGOODS();
         _loc3_.SellGuid = _loc2_.SellGuid;
         _loc3_.IndexId = _loc2_.IndexId;
         _loc3_.SeqId = GamePlayer.getInstance().seqID++;
         _loc3_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc3_);
         this.ClearSelectedItem();
      }
      
      public function RespBuyResult(param1:MSG_RESP_BUYTRADEGOODS) : void
      {
         this.ShowMoney();
         this.RequestBuyList();
      }
      
      private function AddToPack(param1:int, param2:int) : void
      {
      }
      
      private function btn_allClick(param1:Event) : void
      {
         this.ResetShow();
         this.SelectedType = -1;
         this.RequestBuyList();
         this.ResetSelectedBtn(this.btn_all);
      }
      
      private function btn_airshipClick(param1:Event) : void
      {
         this.ResetShow();
         this.SelectedType = 0;
         this.RequestBuyList();
         this.ResetSelectedBtn(this.btn_airship);
      }
      
      private function btn_paperClick(param1:Event) : void
      {
         this.ResetShow();
         this.SelectedType = 2;
         this.RequestBuyList();
         this.ResetSelectedBtn(this.btn_paper);
      }
      
      private function btn_cardClick(param1:Event) : void
      {
         this.ResetShow();
         this.SelectedType = 3;
         this.RequestBuyList();
         this.ResetSelectedBtn(this.btn_card);
      }
      
      private function btn_equipClick(param1:Event) : void
      {
         this.ResetShow();
         this.SelectedType = 4;
         this.RequestBuyList();
         this.ResetSelectedBtn(this.btn_equip);
      }
      
      private function btn_propClick(param1:Event) : void
      {
         this.ResetShow();
         this.SelectedType = 1;
         this.RequestBuyList();
         this.ResetSelectedBtn(this.btn_prop);
      }
      
      private function ResetShow() : void
      {
         this.SearchId = -1;
         this.PageIndex = 0;
         this.PageCount = 0;
         this.ShowPageButton();
      }
      
      private function ResetSelectedBtn(param1:HButton) : void
      {
         if(this.SelectedBtn != null)
         {
            this.SelectedBtn.setSelect(false);
         }
         this.SelectedBtn = param1;
         this.SelectedBtn.setSelect(true);
         this.RequestBuyList();
      }
      
      private function ClearSelectedItem() : void
      {
         if(this.SelectedItem != null)
         {
            this.SelectedItem.gotoAndStop("up");
            this.SelectedItem = null;
            this.SelectedItemIndex = -1;
            this.btn_buy.setBtnDisabled(true);
         }
      }
      
      private function RequestBuyList() : void
      {
         var _loc3_:MovieClip = null;
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            _loc3_ = this.BuyMc.getChildByName("mc_list" + _loc1_) as MovieClip;
            _loc3_.visible = false;
            _loc1_++;
         }
         var _loc2_:MSG_REQUEST_TRADEINFO = new MSG_REQUEST_TRADEINFO();
         if(this.SearchId >= 0)
         {
            _loc2_.Type = this.SearchTypeId;
         }
         else
         {
            _loc2_.Type = this.SelectedType;
         }
         _loc2_.Id = this.SearchId;
         _loc2_.PageId = this.PageIndex;
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc2_);
      }
      
      public function RespTradeInfo(param1:MSG_RESP_TRADEINFO) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:MSG_RESP_TRADEINFO_TEMP = null;
         var _loc6_:MovieClip = null;
         var _loc7_:String = null;
         var _loc8_:TextField = null;
         var _loc9_:MovieClip = null;
         var _loc10_:MovieClip = null;
         var _loc11_:Bitmap = null;
         var _loc12_:Bitmap = null;
         var _loc13_:Number = NaN;
         var _loc14_:ShipbodyInfo = null;
         var _loc15_:Bitmap = null;
         var _loc16_:propsInfo = null;
         var _loc17_:Bitmap = null;
         this.MsgBuyInfo = param1;
         this.ClearSelectedItem();
         this.PageCount = param1.TradeCount / 5;
         if(this.PageCount * 5 < param1.TradeCount)
         {
            ++this.PageCount;
         }
         this.ShowPageButton();
         this.UserIdList.splice(0);
         this.UserNameList.splice(0);
         var _loc2_:int = 0;
         while(_loc2_ < 5)
         {
            _loc3_ = this.BuyMc.getChildByName("mc_list" + _loc2_) as MovieClip;
            if(_loc2_ < param1.DataLen)
            {
               _loc4_ = _loc3_.getChildByName("Item" + _loc2_) as MovieClip;
               _loc5_ = param1.Data[_loc2_];
               _loc6_ = _loc4_.getChildByName("mc_base") as MovieClip;
               if(_loc6_.numChildren > 0)
               {
                  _loc6_.removeChildAt(0);
               }
               if(_loc5_.TradeType == 0)
               {
                  _loc14_ = CShipmodelReader.getInstance().getShipBodyInfo(_loc5_.BodyId);
                  _loc15_ = new Bitmap(GameKernel.getTextureInstance(_loc14_.SmallIcon));
                  _loc15_.x = -7;
                  _loc7_ = _loc14_.Name;
                  _loc6_.addChild(_loc15_);
               }
               else
               {
                  _loc16_ = CPropsReader.getInstance().GetPropsInfo(_loc5_.Id);
                  _loc17_ = new Bitmap(GameKernel.getTextureInstance(_loc16_.ImageFileName));
                  _loc7_ = _loc16_.Name;
                  _loc6_.addChild(_loc17_);
               }
               _loc8_ = _loc4_.getChildByName("tf_name") as TextField;
               _loc8_.text = _loc7_;
               _loc8_ = _loc4_.getChildByName("tf_num") as TextField;
               _loc8_.text = _loc5_.Num.toString();
               _loc8_ = _loc4_.getChildByName("tf_remaintime") as TextField;
               _loc8_.text = DataWidget.GetTimeString2(_loc5_.SpareTime);
               _loc9_ = _loc4_.getChildByName("mc_resbase0") as MovieClip;
               if(_loc9_.numChildren > 0)
               {
                  _loc9_.removeChildAt(0);
               }
               _loc10_ = _loc4_.getChildByName("mc_resbase1") as MovieClip;
               if(_loc10_.numChildren > 0)
               {
                  _loc10_.removeChildAt(0);
               }
               if(_loc5_.PriceType == 0)
               {
                  _loc11_ = new Bitmap(GameKernel.getTextureInstance("Gold"));
                  _loc12_ = new Bitmap(GameKernel.getTextureInstance("Gold"));
               }
               else
               {
                  _loc11_ = new Bitmap(GameKernel.getTextureInstance("Fund"));
                  _loc12_ = new Bitmap(GameKernel.getTextureInstance("Fund"));
               }
               _loc11_.x = -10;
               _loc11_.y = -10;
               _loc9_.addChild(_loc11_);
               _loc12_.x = -10;
               _loc12_.y = -10;
               _loc10_.addChild(_loc12_);
               _loc8_ = _loc4_.getChildByName("tf_allprice") as TextField;
               _loc8_.text = _loc5_.Price.toString();
               _loc13_ = Math.round(_loc5_.Price / _loc5_.Num * 100);
               _loc13_ = _loc13_ / 100;
               _loc8_ = _loc4_.getChildByName("tf_price") as TextField;
               _loc8_.text = _loc13_.toString();
               TextField(_loc4_.tf_seller).htmlText = "<a href=\'event:\'>" + _loc5_.SellName + "</a>";
               this.UserIdList.push(_loc5_.SellUserId);
               this.UserNameList.push(_loc5_.SellName);
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
      
      private function tf_sellerClick(param1:MouseEvent, param2:XTextField) : void
      {
         if(this.MsgBuyInfo == null)
         {
            return;
         }
         var _loc3_:MSG_RESP_TRADEINFO_TEMP = this.MsgBuyInfo.Data[param2.Data];
         PlayerInfoPopUp.Module = true;
         ChatAction.getInstance().sendChatUserInfoMessage(-1,_loc3_.SellGuid,3);
      }
      
      private function getPlayerFacebookInfoArrayCallback(param1:Array) : void
      {
         var _loc2_:FacebookUserInfo = null;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         if(param1 == null)
         {
            return;
         }
         for each(_loc2_ in param1)
         {
            _loc3_ = 0;
            while(_loc3_ < this.UserIdList.length)
            {
               if(_loc2_.uid == this.UserIdList[_loc3_])
               {
                  _loc4_ = this.BuyMc.getChildByName("mc_list" + _loc3_) as MovieClip;
                  _loc5_ = _loc4_.getChildByName("Item" + _loc3_) as MovieClip;
                  TextField(_loc5_.tf_seller).htmlText = "<a href=\'event:\'>" + _loc2_.first_name + "</a>";
               }
               _loc3_++;
            }
         }
      }
      
      private function btn_leftClick(param1:MouseEvent) : void
      {
         this.btn_left.setBtnDisabled(true);
         this.btn_right.setBtnDisabled(true);
         this.btn_homepage.setBtnDisabled(true);
         this.btn_lastpage.setBtnDisabled(true);
         --this.PageIndex;
         this.RequestBuyList();
      }
      
      private function btn_rightClick(param1:MouseEvent) : void
      {
         this.btn_left.setBtnDisabled(true);
         this.btn_right.setBtnDisabled(true);
         this.btn_homepage.setBtnDisabled(true);
         this.btn_lastpage.setBtnDisabled(true);
         ++this.PageIndex;
         this.RequestBuyList();
      }
      
      private function btn_homepageClick(param1:MouseEvent) : void
      {
         this.btn_left.setBtnDisabled(true);
         this.btn_right.setBtnDisabled(true);
         this.btn_homepage.setBtnDisabled(true);
         this.btn_lastpage.setBtnDisabled(true);
         this.PageIndex = 0;
         this.RequestBuyList();
      }
      
      private function btn_lastpageClick(param1:MouseEvent) : void
      {
         this.btn_left.setBtnDisabled(true);
         this.btn_right.setBtnDisabled(true);
         this.btn_homepage.setBtnDisabled(true);
         this.btn_lastpage.setBtnDisabled(true);
         this.PageIndex = this.PageCount - 1;
         this.RequestBuyList();
      }
      
      private function ShowPageButton() : void
      {
         if(this.PageCount > 0)
         {
            this.tf_page.text = this.PageIndex + 1 + "/" + this.PageCount;
         }
         else
         {
            this.tf_page.text = "1/1";
         }
         if(this.PageIndex == 0)
         {
            this.btn_left.setBtnDisabled(true);
         }
         else
         {
            this.btn_left.setBtnDisabled(false);
         }
         if(this.PageIndex + 1 >= this.PageCount)
         {
            this.btn_right.setBtnDisabled(true);
         }
         else
         {
            this.btn_right.setBtnDisabled(false);
         }
         this.btn_homepage.setBtnDisabled(this.PageIndex == 0);
         this.btn_lastpage.setBtnDisabled(this.PageIndex + 1 >= this.PageCount);
      }
      
      private function McListMouseOver(param1:MouseEvent, param2:XButton) : void
      {
         if(this.SelectedSearchList != null)
         {
            this.SelectedSearchList.setSelect(false);
         }
         this.SelectedSearchList = param2;
         this.SelectedSearchList.setSelect(true);
      }
      
      private function McListMouseOut(param1:MouseEvent) : void
      {
         if(this.SelectedSearchList != null)
         {
            this.SelectedSearchList.setSelect(false);
         }
      }
      
      private function BuysearchListClick(param1:MouseEvent, param2:XButton) : void
      {
         var _loc3_:propsInfo = null;
         this.SearchId = this.SearchResultArray[param2.Data].Id;
         this.BuyMc.removeChild(this.BuysearchPop);
         this.tf_input.text = this.SearchResultArray[param2.Data].Name;
         if(this.ShipBodyLen > 0 && param2.Data < this.ShipBodyLen)
         {
            this.SearchTypeId = 0;
         }
         else
         {
            _loc3_ = CPropsReader.getInstance().GetPropsInfo(this.SearchId);
            if(_loc3_.PackID == 0)
            {
               this.SearchTypeId = 2;
            }
            else if(_loc3_.PackID == 1)
            {
               this.SearchTypeId = 3;
            }
            else if(_loc3_.PackID == 2)
            {
               this.SearchTypeId = 1;
            }
            else
            {
               this.SearchTypeId = -1;
            }
         }
         this.PageIndex = 0;
         this.RequestBuyList();
      }
      
      private function tf_inputChange(param1:Event) : void
      {
         var _loc4_:Array = null;
         var _loc5_:MovieClip = null;
         var _loc6_:TextField = null;
         this.SearchTypeId = -1;
         this.ShipBodyLen = 0;
         var _loc2_:String = this.tf_input.text;
         _loc2_ = _loc2_.toLowerCase();
         _loc2_ = _loc2_.replace(/^\s*/g,"");
         _loc2_ = _loc2_.replace(/\s*$/g,"");
         if(_loc2_ == "")
         {
            if(this.BuyMc.contains(this.BuysearchPop))
            {
               this.BuyMc.removeChild(this.BuysearchPop);
            }
            return;
         }
         if(this.SelectedType == -1)
         {
            this.SearchResultArray = CShipmodelReader.getInstance().SearchShipBody(_loc2_);
            this.ShipBodyLen = this.SearchResultArray.length;
            _loc4_ = CPropsReader.getInstance().SearchProps(0,_loc2_);
            this.SearchResultArray = this.SearchResultArray.concat(_loc4_);
            _loc4_ = CPropsReader.getInstance().SearchProps(1,_loc2_);
            this.SearchResultArray = this.SearchResultArray.concat(_loc4_);
            _loc4_ = CPropsReader.getInstance().SearchProps(2,_loc2_);
            this.SearchResultArray = this.SearchResultArray.concat(_loc4_);
            _loc4_ = CPropsReader.getInstance().SearchProps(3,_loc2_);
            this.SearchResultArray = this.SearchResultArray.concat(_loc4_);
         }
         else if(this.SelectedType == 0)
         {
            this.SearchResultArray = CShipmodelReader.getInstance().SearchShipBody(_loc2_);
            this.ShipBodyLen = this.SearchResultArray.length;
         }
         else if(this.SelectedType == 1)
         {
            this.SearchResultArray = CPropsReader.getInstance().SearchProps(2,_loc2_);
         }
         else if(this.SelectedType == 2)
         {
            this.SearchResultArray = CPropsReader.getInstance().SearchProps(0,_loc2_);
         }
         else if(this.SelectedType == 3)
         {
            this.SearchResultArray = CPropsReader.getInstance().SearchProps(1,_loc2_);
         }
         else if(this.SelectedType == 4)
         {
            this.SearchResultArray = CPropsReader.getInstance().SearchProps(4,_loc2_);
         }
         var _loc3_:int = 0;
         while(_loc3_ < 5)
         {
            _loc5_ = this.BuysearchPop.getChildByName("mc_list" + _loc3_) as MovieClip;
            if(_loc3_ < this.SearchResultArray.length)
            {
               _loc5_.visible = true;
               _loc6_ = _loc5_.tf_content as TextField;
               _loc6_.text = this.SearchResultArray[_loc3_].Name;
            }
            else
            {
               _loc5_.visible = false;
            }
            _loc3_++;
         }
         if(this.SearchResultArray.length > 0)
         {
            if(!this.BuyMc.contains(this.BuysearchPop))
            {
               this.BuysearchPop.x = 6;
               this.BuysearchPop.y = 180;
               this.BuyMc.addChild(this.BuysearchPop);
            }
         }
         else if(this.BuyMc.contains(this.BuysearchPop))
         {
            this.BuyMc.removeChild(this.BuysearchPop);
         }
      }
      
      private function btn_searchClick(param1:Event) : void
      {
         this.tf_inputChange(param1);
      }
   }
}

