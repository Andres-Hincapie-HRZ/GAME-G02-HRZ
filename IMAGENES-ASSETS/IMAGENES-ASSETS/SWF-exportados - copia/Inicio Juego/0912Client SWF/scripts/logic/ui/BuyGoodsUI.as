package logic.ui
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.geom.CFilter;
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.HashSet;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFieldType;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.HButtonType;
   import logic.entry.MObject;
   import logic.entry.props.propsInfo;
   import logic.game.GameKernel;
   import logic.game.GameMouseZoneManager;
   import logic.reader.CPropsReader;
   import logic.ui.tip.CaptionTip;
   import logic.ui.tip.CustomTip;
   import logic.utils.UpdateResource;
   import net.base.NetManager;
   import net.msg.mall.MSG_REQUEST_BUYGOODS;
   
   public class BuyGoodsUI extends AbstractPopUp
   {
      
      private static var instance:BuyGoodsUI;
      
      private var btn_left:HButton;
      
      private var btn_right:HButton;
      
      private var PageIndex:int;
      
      private var PageCount:int;
      
      private var tf_page:TextField;
      
      private var radiogold:HButton;
      
      private var radiocash:HButton;
      
      private var ParentLock:Container;
      
      private var MallgoodsPopupMc:MovieClip;
      
      private var SelectedProps:propsInfo;
      
      private var SelectedBtn:HButton;
      
      private var btn_allgoods:HButton;
      
      private var btn_exspend:HButton;
      
      private var btn_battle:HButton;
      
      private var btn_gem:HButton;
      
      private var btn_honor:HButton;
      
      private var btn_medals:HButton;
      
      private var McMallBtnPopup:MovieClip;
      
      private var SelectedArray:Array;
      
      private var mc_cash:MovieClip;
      
      private var mc_cash1:MovieClip;
      
      private var mc_gold:MovieClip;
      
      private var mc_honor:MovieClip;
      
      private var mc_honor0:MovieClip;
      
      private var filter:CFilter;
      
      private var mc_xunzhang:MovieClip;
      
      private var mc_xunzhang0:MovieClip;
      
      private var LimitArray:HashSet = new HashSet();
      
      private var SelectedLimitId:int;
      
      private var MaxNum:int;
      
      private var SelectedItem:MovieClip;
      
      public function BuyGoodsUI()
      {
         super();
         this.filter = ShipModeEditUI.getInstance().filter;
         setPopUpName("BuyGoodsUI");
      }
      
      public static function getInstance() : BuyGoodsUI
      {
         if(instance == null)
         {
            instance = new BuyGoodsUI();
         }
         return instance;
      }
      
      override public function Init() : void
      {
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            this.ShowCash();
            this.Clear();
            return;
         }
         this._mc = new MObject("MallgoodsScene",385,320);
         this.initMcElement();
         GameKernel.popUpDisplayManager.Regisger(instance);
         this.ShowCash();
         this.Clear();
      }
      
      override public function initMcElement() : void
      {
         var _loc3_:CaptionTip = null;
         var _loc1_:MovieClip = this._mc.getMC().getChildByName("btn_close") as MovieClip;
         var _loc2_:HButton = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_closeClick);
         _loc1_ = this._mc.getMC().getChildByName("btn_front") as MovieClip;
         this.btn_left = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_leftClick);
         _loc1_ = this._mc.getMC().getChildByName("btn_next") as MovieClip;
         this.btn_right = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_rightClick);
         this.tf_page = this._mc.getMC().getChildByName("tf_page") as TextField;
         _loc1_ = this._mc.getMC().getChildByName("btn_cash") as MovieClip;
         _loc2_ = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_cashClick);
         _loc1_ = this._mc.getMC().getChildByName("btn_bag") as MovieClip;
         _loc2_ = new HButton(_loc1_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("MainUITXT20"));
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_bagClick);
         _loc1_ = this._mc.getMC().getChildByName("btn_allgoods") as MovieClip;
         this.btn_allgoods = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_allgoodsClick);
         _loc1_ = this._mc.getMC().getChildByName("btn_exspend") as MovieClip;
         this.btn_exspend = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_exspendClick);
         _loc1_ = this._mc.getMC().getChildByName("btn_battle") as MovieClip;
         this.btn_battle = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_battleClick);
         _loc1_ = this._mc.getMC().getChildByName("btn_gem") as MovieClip;
         this.btn_gem = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_gemClick);
         _loc1_ = this._mc.getMC().getChildByName("btn_honor") as MovieClip;
         this.btn_honor = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_honorClick);
         _loc1_ = this._mc.getMC().getChildByName("btn_medals") as MovieClip;
         this.btn_medals = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_medalsClick);
         this.InitMallgoodsPopup();
         this.McMallBtnPopup = GameKernel.getMovieClipInstance("MallBtnPopup");
         _loc1_ = this.McMallBtnPopup.getChildByName("btn_buy") as MovieClip;
         _loc2_ = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_buyClick);
         _loc1_ = this.McMallBtnPopup.getChildByName("btn_gift") as MovieClip;
         _loc2_ = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_giftClick);
         _loc2_.setBtnDisabled(true);
         TextField(this.MallgoodsPopupMc.tf_num).maxChars = 4;
         TextField(this.MallgoodsPopupMc.tf_num).restrict = "0-9";
         TextField(this.MallgoodsPopupMc.tf_num).text = "1";
         TextField(this.MallgoodsPopupMc.tf_num).addEventListener(Event.CHANGE,this.tf_numChange);
         TextField(this.MallgoodsPopupMc.tf_allprice).type = TextFieldType.DYNAMIC;
         _loc3_ = new CaptionTip(this._mc.getMC().mc_cash,StringManager.getInstance().getMessageString("BagTXT25"));
         _loc3_ = new CaptionTip(this._mc.getMC().mc_giftmoney,StringManager.getInstance().getMessageString("BagTXT26"));
         _loc3_ = new CaptionTip(this._mc.getMC().mc_medals,StringManager.getInstance().getMessageString("BagTXT27"));
         _loc3_ = new CaptionTip(this._mc.getMC().mc_honor,StringManager.getInstance().getMessageString("BagTXT28"));
      }
      
      private function tf_numChange(param1:Event) : void
      {
         var _loc3_:int = 0;
         if(TextField(this.MallgoodsPopupMc.tf_num).text == "")
         {
            TextField(this.MallgoodsPopupMc.tf_allprice).text = "";
            return;
         }
         var _loc2_:int = int(TextField(this.MallgoodsPopupMc.tf_num).text);
         if(this.MaxNum > 0 && _loc2_ > this.MaxNum)
         {
            _loc2_ = this.MaxNum;
            TextField(this.MallgoodsPopupMc.tf_num).text = _loc2_.toString();
         }
         if(this.btn_medals.selsected)
         {
            _loc3_ = this.SelectedProps.BuyBadge * _loc2_;
         }
         else if(this.btn_honor.selsected)
         {
            _loc3_ = this.SelectedProps.BuyHonor * _loc2_;
         }
         else
         {
            _loc3_ = this.SelectedProps.Cash * _loc2_;
         }
         TextField(this.MallgoodsPopupMc.tf_allprice).text = _loc3_.toString();
      }
      
      private function CheckNum() : void
      {
      }
      
      private function btn_allgoodsClick(param1:Event) : void
      {
         this.PageIndex = 0;
         this.SetSelectedBtn(this.btn_allgoods);
         this.SelectedArray = CPropsReader.getInstance().MallPropsList;
         this.ShowGoods();
      }
      
      private function btn_exspendClick(param1:Event) : void
      {
         this.PageIndex = 0;
         this.SetSelectedBtn(this.btn_exspend);
         this.SelectedArray = CPropsReader.getInstance().MallPropsList1;
         this.ShowGoods();
      }
      
      private function btn_battleClick(param1:Event) : void
      {
         this.PageIndex = 0;
         this.SetSelectedBtn(this.btn_battle);
         this.SelectedArray = CPropsReader.getInstance().MallPropsList2;
         this.ShowGoods();
      }
      
      private function btn_honorClick(param1:Event) : void
      {
         this.PageIndex = 0;
         this.SetSelectedBtn(this.btn_honor);
         this.SelectedArray = CPropsReader.getInstance().MallPropsList_Honor;
         this.ShowGoods();
      }
      
      private function btn_medalsClick(param1:Event) : void
      {
         this.PageIndex = 0;
         this.SetSelectedBtn(this.btn_medals);
         this.SelectedArray = CPropsReader.getInstance().MallPropsList_Badge;
         this.ShowGoods();
      }
      
      private function btn_gemClick(param1:Event) : void
      {
         this.PageIndex = 0;
         this.SetSelectedBtn(this.btn_gem);
         this.SelectedArray = CPropsReader.getInstance().MallPropsList3;
         this.ShowGoods();
      }
      
      private function SetSelectedBtn(param1:HButton) : void
      {
         if(this.SelectedBtn != null)
         {
            this.SelectedBtn.setSelect(false);
         }
         this.SelectedBtn = param1;
         this.SelectedBtn.setSelect(true);
      }
      
      private function InitMallgoodsPopup() : void
      {
         this.MallgoodsPopupMc = GameKernel.getMovieClipInstance("StorepayPop",GameKernel.fullRect.width / 2 + GameKernel.fullRect.x,293);
         this.ParentLock = new Container("StorepayPopLock");
         this.ParentLock.mouseEnabled = true;
         this.ParentLock.mouseChildren = true;
         var _loc1_:MovieClip = this.MallgoodsPopupMc.getChildByName("btn_cancel") as MovieClip;
         var _loc2_:HButton = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.cancelClick);
         _loc1_ = this.MallgoodsPopupMc.getChildByName("btn_buy") as MovieClip;
         _loc2_ = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.BuyClick);
         _loc1_ = this.MallgoodsPopupMc.getChildByName("radiogold") as MovieClip;
         this.radiogold = new HButton(_loc1_);
         this.radiogold.setSelect(true);
         _loc1_.addEventListener(MouseEvent.CLICK,this.radiogoldClick);
         _loc1_ = this.MallgoodsPopupMc.getChildByName("radiocash") as MovieClip;
         this.radiocash = new HButton(_loc1_);
         this.radiocash.setSelect(false);
         _loc1_.addEventListener(MouseEvent.CLICK,this.radiocashClick);
         this.mc_cash = this.MallgoodsPopupMc.getChildByName("mc_cash") as MovieClip;
         this.mc_cash1 = this.MallgoodsPopupMc.getChildByName("mc_cash1") as MovieClip;
         this.mc_gold = this.MallgoodsPopupMc.getChildByName("mc_gold") as MovieClip;
         this.mc_honor = this.MallgoodsPopupMc.getChildByName("mc_honor") as MovieClip;
         this.mc_honor0 = this.MallgoodsPopupMc.getChildByName("mc_honor0") as MovieClip;
         this.ParentLock.fillRectangleWithoutBorder(GameKernel.fullRect.x,GameKernel.fullRect.y,GameKernel.fullRect.width,GameKernel.fullRect.height,0,0);
         this.mc_xunzhang = this.MallgoodsPopupMc.getChildByName("mc_xunzhang") as MovieClip;
         this.mc_xunzhang0 = this.MallgoodsPopupMc.getChildByName("mc_xunzhang0") as MovieClip;
         this.SelectedCash();
      }
      
      private function ShowMallgoodsPopup(param1:propsInfo) : void
      {
         var _loc2_:TextField = this.MallgoodsPopupMc.getChildByName("tf_num") as TextField;
         _loc2_.text = "1";
         this.tf_numChange(null);
         TextField(this.MallgoodsPopupMc.tf_name).text = param1.Name;
         TextField(this.MallgoodsPopupMc.tf_detail).htmlText = param1.Comment;
         if(param1.Id == 921)
         {
            TextField(this.MallgoodsPopupMc.tf_minnum).text = "10";
         }
         else
         {
            TextField(this.MallgoodsPopupMc.tf_minnum).text = "";
         }
         if(this.btn_medals.selsected)
         {
            this.mc_xunzhang.visible = true;
            this.mc_xunzhang0.visible = true;
            this.mc_cash1.visible = false;
            this.mc_cash.visible = false;
            this.mc_gold.visible = false;
            this.mc_honor.visible = false;
            this.mc_honor0.visible = false;
            this.MallgoodsPopupMc.mc_money.visible = false;
            this.radiogold.m_movie.visible = false;
            this.radiocash.setSelect(true);
         }
         else if(this.btn_honor.selsected)
         {
            this.mc_xunzhang.visible = false;
            this.mc_xunzhang0.visible = false;
            this.mc_cash1.visible = false;
            this.mc_cash.visible = false;
            this.mc_honor.visible = true;
            this.mc_honor0.visible = true;
            this.MallgoodsPopupMc.mc_money.visible = false;
            this.radiogold.m_movie.visible = false;
            this.radiocash.setSelect(true);
         }
         else
         {
            this.mc_xunzhang.visible = false;
            this.mc_xunzhang0.visible = false;
            this.mc_cash1.visible = true;
            this.mc_cash.visible = true;
            this.mc_honor.visible = false;
            this.mc_honor0.visible = false;
            this.MallgoodsPopupMc.mc_money.visible = param1.UseMoney == 1;
            this.radiogold.m_movie.visible = param1.UseMoney == 1;
            this.SelectedCash();
         }
         var _loc3_:Bitmap = new Bitmap(GameKernel.getTextureInstance(param1.ImageFileName));
         var _loc4_:MovieClip = this.MallgoodsPopupMc.mc_base as MovieClip;
         if(_loc4_.numChildren > 0)
         {
            _loc4_.removeChildAt(0);
         }
         _loc4_.addChild(_loc3_);
         GameKernel.renderManager.getUI().addComponent(this.ParentLock);
         this.ParentLock.addChild(this.MallgoodsPopupMc);
      }
      
      private function HideMallgoodsPopup() : void
      {
         this.ParentLock.removeChild(this.MallgoodsPopupMc);
         GameKernel.renderManager.getUI().removeComponent(this.ParentLock);
      }
      
      private function GetItem(param1:int, param2:propsInfo) : MovieClip
      {
         var _loc3_:String = null;
         if(param2.Fettle == 1)
         {
            _loc3_ = "MallgoodslNewPlan";
         }
         else if(param2.Fettle == 2)
         {
            _loc3_ = "MallgoodslHotPlan";
         }
         else if(param2.Fettle == 3)
         {
            _loc3_ = "MallgoodslGouPlan";
         }
         else
         {
            _loc3_ = "MallgoodslPlan";
         }
         var _loc4_:MovieClip = GameKernel.getMovieClipInstance(_loc3_);
         _loc4_.name = "Item";
         _loc4_.mouseChildren = false;
         _loc4_.gotoAndStop("up");
         var _loc5_:XMovieClip = new XMovieClip(_loc4_);
         _loc5_.Data = param1;
         _loc5_.OnMouseOver = this.McItemMouseOver;
         _loc5_.OnClick = this.McItemMouseClick;
         _loc4_.addEventListener(MouseEvent.MOUSE_OUT,this.McItemMouseOut);
         if(param2.Id == 921)
         {
            TextField(_loc4_.tf_minnum).text = "10";
         }
         else
         {
            TextField(_loc4_.tf_minnum).text = "";
         }
         if(this.btn_honor.selsected)
         {
            _loc4_.mc_money.visible = false;
            _loc4_.mc_xunzhang.visible = false;
            _loc4_.mc_honor.visible = true;
         }
         else if(this.btn_medals.selsected)
         {
            _loc4_.mc_money.visible = false;
            _loc4_.mc_xunzhang.visible = true;
            _loc4_.mc_honor.visible = false;
         }
         else
         {
            _loc4_.mc_money.visible = param2.UseMoney == 1;
            _loc4_.mc_xunzhang.visible = false;
            _loc4_.mc_honor.visible = false;
         }
         return _loc4_;
      }
      
      private function Clear() : void
      {
         this.PageIndex = 0;
         this.btn_allgoodsClick(null);
      }
      
      public function ShowCash() : void
      {
         var _loc1_:TextField = null;
         _loc1_ = this._mc.getMC().getChildByName("tf_gold") as TextField;
         _loc1_.multiline = false;
         _loc1_.autoSize = TextFieldAutoSize.LEFT;
         _loc1_.text = GamePlayer.getInstance().cash.toString();
         _loc1_ = this._mc.getMC().getChildByName("tf_cash") as TextField;
         _loc1_.autoSize = TextFieldAutoSize.LEFT;
         _loc1_.multiline = false;
         _loc1_.text = GamePlayer.getInstance().coins.toString();
         _loc1_ = this._mc.getMC().getChildByName("tf_medals") as TextField;
         _loc1_.autoSize = TextFieldAutoSize.LEFT;
         _loc1_.multiline = false;
         _loc1_.text = GamePlayer.getInstance().Badge.toString();
         _loc1_ = this._mc.getMC().getChildByName("tf_honor") as TextField;
         _loc1_.autoSize = TextFieldAutoSize.LEFT;
         _loc1_.multiline = false;
         _loc1_.text = GamePlayer.getInstance().Honor.toString();
      }
      
      private function ShowGoods() : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:propsInfo = null;
         var _loc5_:MovieClip = null;
         var _loc6_:Bitmap = null;
         var _loc7_:MovieClip = null;
         var _loc8_:TextField = null;
         this.LimitArray.Clear();
         this.PageCount = this.SelectedArray.length / 9;
         if(this.PageCount * 9 < this.SelectedArray.length)
         {
            ++this.PageCount;
         }
         var _loc1_:int = this.PageIndex * 9;
         var _loc2_:int = 0;
         while(_loc2_ < 9)
         {
            _loc3_ = this._mc.getMC().getChildByName("mc_base" + _loc2_) as MovieClip;
            if(_loc3_.numChildren > 0)
            {
               _loc3_.removeChildAt(0);
            }
            if(_loc1_ < this.SelectedArray.length)
            {
               _loc3_.visible = true;
               _loc4_ = this.SelectedArray[_loc1_];
               _loc5_ = this.GetItem(_loc2_,_loc4_);
               this.AddLimitNum(_loc2_,_loc4_.Fettle,_loc5_,_loc4_.Id);
               _loc3_.addChild(_loc5_);
               _loc6_ = new Bitmap(GameKernel.getTextureInstance(_loc4_.ImageFileName));
               _loc7_ = _loc5_.getChildByName("mc_base") as MovieClip;
               if(_loc7_.numChildren > 0)
               {
                  _loc7_.removeChildAt(0);
               }
               _loc7_.addChild(_loc6_);
               _loc8_ = _loc5_.getChildByName("f_name") as TextField;
               _loc8_.text = _loc4_.Name;
               _loc8_ = _loc5_.getChildByName("tf_num") as TextField;
               if(this.btn_honor.selsected)
               {
                  _loc8_.text = _loc4_.BuyHonor.toString();
               }
               else if(this.btn_medals.selsected)
               {
                  _loc8_.text = _loc4_.BuyBadge.toString();
               }
               else
               {
                  _loc8_.text = _loc4_.Cash.toString();
               }
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc1_++;
            _loc2_++;
         }
         this.SetPageButton();
         this.HideMcMallBtnPopup();
      }
      
      private function SetPageButton() : void
      {
         if(this.PageIndex > 0)
         {
            this.btn_left.setBtnDisabled(false);
         }
         else
         {
            this.btn_left.setBtnDisabled(true);
         }
         if(this.PageIndex + 1 >= this.PageCount)
         {
            this.btn_right.setBtnDisabled(true);
         }
         else
         {
            this.btn_right.setBtnDisabled(false);
         }
         this.tf_page.text = this.PageIndex + 1 + "/" + this.PageCount;
      }
      
      private function cancelClick(param1:MouseEvent) : void
      {
         this.HideMallgoodsPopup();
      }
      
      private function BuyClick(param1:MouseEvent) : void
      {
         var LockFlag:int;
         var IsHasPackSpace:int;
         var GoodsNum:int = 0;
         var e:MouseEvent = param1;
         try
         {
            GoodsNum = int(TextField(this.MallgoodsPopupMc.tf_num).text);
         }
         catch(e:*)
         {
            return;
         }
         if(GoodsNum <= 0)
         {
            return;
         }
         LockFlag = this.radiogold.selsected ? 1 : (this.btn_honor.selsected ? 1 : 0);
         IsHasPackSpace = UpdateResource.getInstance().HasPackSpace(this.SelectedProps.Id,LockFlag,GoodsNum);
         if(IsHasPackSpace == 1)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CommanderText12"),10);
            return;
         }
         if(IsHasPackSpace == 2)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("BattleTXT11"),0);
            return;
         }
         if(this.btn_medals.selsected)
         {
            if(GamePlayer.getInstance().Badge < this.SelectedProps.BuyBadge * GoodsNum)
            {
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("BagTXT21"),0);
               return;
            }
            this.RequestBuyGoods(2,this.SelectedProps.Id,GoodsNum);
         }
         else if(this.btn_honor.selsected)
         {
            if(GamePlayer.getInstance().Honor < this.SelectedProps.BuyHonor * GoodsNum)
            {
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("BagTXT30"),0);
               return;
            }
            this.RequestBuyGoods(3,this.SelectedProps.Id,GoodsNum);
         }
         else if(this.radiogold.selsected)
         {
            if(GamePlayer.getInstance().coins < this.SelectedProps.Cash * GoodsNum)
            {
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("AuctionText32"),0);
               return;
            }
            this.RequestBuyGoods(1,this.SelectedProps.Id,GoodsNum);
         }
         else if(this.radiocash.selsected)
         {
            if(GamePlayer.getInstance().cash < this.SelectedProps.Cash * GoodsNum)
            {
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("AuctionText31"),0);
               return;
            }
            this.RequestBuyGoods(0,this.SelectedProps.Id,GoodsNum);
         }
         this.HideMallgoodsPopup();
      }
      
      private function GetLimitNum(param1:int) : int
      {
         var _loc2_:int = 99999999;
         this.SelectedLimitId = -1;
         if(this.LimitArray.ContainsKey(param1))
         {
            this.SelectedLimitId = param1;
            _loc2_ = 100 - GamePlayer.getInstance().MoneyBuyNum;
         }
         return _loc2_;
      }
      
      private function AddLimitNum(param1:int, param2:int, param3:MovieClip, param4:int) : void
      {
         if(param2 == 3 || param4 == 918)
         {
            if(GamePlayer.getInstance().MoneyBuyNum >= 100)
            {
               param3.filters = this.filter.getFilter(true);
            }
            this.LimitArray.Put(param1,100 - GamePlayer.getInstance().MoneyBuyNum);
         }
      }
      
      private function radiogoldClick(param1:MouseEvent) : void
      {
         if(this.SelectedProps.BuyBadge <= 0)
         {
            this.mc_xunzhang.visible = false;
            this.radiogold.setSelect(true);
            this.radiocash.setSelect(false);
            this.mc_cash.visible = false;
            this.mc_gold.visible = true;
         }
         else
         {
            this.radiocash.setSelect(true);
         }
      }
      
      private function SelectedCash() : void
      {
         this.mc_xunzhang0.visible = false;
         this.radiogold.setSelect(false);
         this.radiocash.setSelect(true);
         this.mc_cash.visible = true;
         this.mc_gold.visible = false;
         this.mc_xunzhang.visible = false;
      }
      
      private function radiocashClick(param1:MouseEvent) : void
      {
         if(this.radiogold.m_movie.visible == false)
         {
            this.radiocash.setSelect(true);
            return;
         }
         if(this.SelectedProps.BuyBadge <= 0)
         {
            this.mc_xunzhang.visible = false;
            this.radiogold.setSelect(false);
            this.radiocash.setSelect(true);
            this.mc_cash.visible = true;
            this.mc_gold.visible = false;
         }
         else
         {
            this.radiocash.setSelect(true);
         }
      }
      
      private function btn_closeClick(param1:MouseEvent) : void
      {
         GameKernel.popUpDisplayManager.Hide(this);
      }
      
      private function btn_leftClick(param1:MouseEvent) : void
      {
         --this.PageIndex;
         this.ShowGoods();
      }
      
      private function btn_rightClick(param1:MouseEvent) : void
      {
         ++this.PageIndex;
         this.ShowGoods();
      }
      
      private function btn_cashClick(param1:MouseEvent) : void
      {
         GameKernel.navigateURL();
      }
      
      private function btn_bagClick(param1:MouseEvent) : void
      {
         GameKernel.popUpDisplayManager.Hide(this);
         GameMouseZoneManager.NagivateToolBarByName("btn_storage",true);
      }
      
      private function btn_buyClick(param1:MouseEvent) : void
      {
         if(this.SelectedProps == null)
         {
            return;
         }
         this.ShowMallgoodsPopup(this.SelectedProps);
         this.HideMcMallBtnPopup();
      }
      
      private function btn_giftClick(param1:MouseEvent) : void
      {
         this.HideMcMallBtnPopup();
      }
      
      private function RequestBuyGoods(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:MSG_REQUEST_BUYGOODS = new MSG_REQUEST_BUYGOODS();
         _loc4_.PropsId = param2;
         _loc4_.Type = param1;
         _loc4_.Num = param3;
         _loc4_.SeqId = GamePlayer.getInstance().seqID++;
         _loc4_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc4_);
      }
      
      private function GetSelectedGoodInfo(param1:int) : propsInfo
      {
         var _loc2_:propsInfo = null;
         param1 += this.PageIndex * 9;
         if(param1 < this.SelectedArray.length)
         {
            return this.SelectedArray[param1];
         }
         return null;
      }
      
      private function McItemMouseClick(param1:MouseEvent, param2:XMovieClip) : void
      {
         this.MaxNum = this.GetLimitNum(param2.Data);
         if(this.MaxNum <= 0)
         {
            return;
         }
         CustomTip.GetInstance().Hide();
         var _loc3_:DisplayObject = param1.target as DisplayObject;
         var _loc4_:Point = _loc3_.localToGlobal(new Point(param1.localX,param1.localY));
         _loc4_ = this._mc.getMC().globalToLocal(_loc4_);
         this.McMallBtnPopup.x = _loc4_.x;
         this.McMallBtnPopup.y = _loc4_.y;
         this._mc.getMC().addChild(this.McMallBtnPopup);
      }
      
      private function HideMcMallBtnPopup() : void
      {
         if(this._mc.getMC().contains(this.McMallBtnPopup))
         {
            this._mc.getMC().removeChild(this.McMallBtnPopup);
         }
      }
      
      private function McItemMouseOver(param1:MouseEvent, param2:XMovieClip) : void
      {
         this.HideMcMallBtnPopup();
         this.SelectedItem = param2.m_movie;
         this.SelectedItem.gotoAndStop("selected");
         this.SelectedProps = this.GetSelectedGoodInfo(param2.Data);
         var _loc3_:Point = this.SelectedItem.localToGlobal(new Point(0,70));
         CustomTip.GetInstance().Show(this.SelectedProps.Comment,_loc3_);
      }
      
      private function McItemMouseOut(param1:MouseEvent) : void
      {
         this.SelectedItem.gotoAndStop("up");
         CustomTip.GetInstance().Hide();
      }
   }
}

