package logic.ui
{
   import com.star.frameworks.managers.StringManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import logic.action.ConstructionAction;
   import logic.entry.EquimentTypeEnum;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.ScienceSystem;
   import logic.entry.props.PackPropsInfo;
   import logic.entry.shipmodel.ShipbodyInfo;
   import logic.entry.shipmodel.ShipmodelInfo;
   import logic.game.GameKernel;
   import logic.reader.CPropsReader;
   import logic.reader.CShipmodelReader;
   import logic.ui.tip.CustomTip;
   import net.base.NetManager;
   import net.msg.fleetMsg.MSG_REQUEST_ARRANGESHIPTEAM;
   import net.msg.fleetMsg.MSG_RESP_ARRANGESHIPTEAM;
   import net.msg.fleetMsg.MSG_SHIPTEAM_NUM;
   import net.msg.mall.MSG_REQUEST_TRADEGOODS;
   import net.msg.mall.MSG_RESP_TRADEGOODS;
   import net.router.ShipmodelRouter;
   
   public class MallUI_Sell
   {
      
      private static var instance:MallUI_Sell;
      
      private var SellMc:MovieClip;
      
      private var btn_airship:HButton;
      
      private var btn_goods:HButton;
      
      private var SelectedTypeBtn:HButton;
      
      private var btn_left:HButton;
      
      private var btn_right:HButton;
      
      private var tf_page:TextField;
      
      private var mc_shipbase:MovieClip;
      
      private var tf_shipname:TextField;
      
      private var tf_shipnum:TextField;
      
      private var radiogold:HButton;
      
      private var radiocash:HButton;
      
      private var tf_oneprice:TextField;
      
      private var radiotime1:HButton;
      
      private var radiotime2:HButton;
      
      private var radiotime3:HButton;
      
      private var tf_price:TextField;
      
      private var tf_charge:TextField;
      
      private var McList:MovieClip;
      
      private var McShipList:MovieClip;
      
      private var McGoodsList:MovieClip;
      
      private var btn_all:HButton;
      
      private var btn_res:HButton;
      
      private var btn_equip:HButton;
      
      private var btn_card:HButton;
      
      private var btn_paper:HButton;
      
      private var btn_sellout:HButton;
      
      private var GoodsListSelectedBtn:HButton;
      
      private var SelectedShipItem:MovieClip;
      
      private var SelectedGoodsItem:MovieClip;
      
      private var PageIndex:int;
      
      private var PageCount:int;
      
      private var ShipPageCount:int;
      
      private var MsgShipList:MSG_RESP_ARRANGESHIPTEAM;
      
      private var PackAll:Array = new Array();
      
      private var PackRes:Array = new Array();
      
      private var PackEquip:Array = new Array();
      
      private var PackCard:Array = new Array();
      
      private var PackPaper:Array = new Array();
      
      private var SelectedPack:Array;
      
      private var SelectedItemId:int;
      
      private var SelectedType:int = -1;
      
      private var SelectedNum:int;
      
      private var Price:Number;
      
      private var DecreaseTax:Number;
      
      private var charge:int;
      
      private var TextFormat1:TextFormat;
      
      private var TextFormat2:TextFormat;
      
      private var _PropsTip:MovieClip;
      
      private var xtf_oneprice:XTextField;
      
      private var xtf_shipnum:XTextField;
      
      public function MallUI_Sell()
      {
         super();
         this.SellMc = GameKernel.getMovieClipInstance("SellMc",0,0,false);
         this.Init();
      }
      
      public static function getInstance() : MallUI_Sell
      {
         if(instance == null)
         {
            instance = new MallUI_Sell();
         }
         return instance;
      }
      
      private function ShowMoney() : void
      {
         TextField(this.SellMc.tf_gold).text = GamePlayer.getInstance().UserMoney.toString();
         TextField(this.SellMc.tf_cash).text = GamePlayer.getInstance().cash.toString();
      }
      
      public function GetMc() : MovieClip
      {
         this.ShowMoney();
         if(this.MsgShipList == null)
         {
            this.btn_airshipClick(null);
         }
         return this.SellMc;
      }
      
      public function Clear() : void
      {
         this.btn_sellout.setBtnDisabled(true);
         this.DecreaseTax = ConstructionAction.getInstance().getOwnConstructionByBuilidID(EquimentTypeEnum.EQUIMENT_TYPE_TRADEPORT).equimentLevel.DecreaseTax / 100;
         this.SelectedItemId = -1;
         this.SelectedPack = null;
         this.MsgShipList = null;
         this.PageIndex = 0;
         this.PageCount = 0;
         this.radiotime1.setSelect(true);
         this.radiotime2.setSelect(false);
         this.radiotime3.setSelect(false);
         this.radiogold.setSelect(true);
         this.radiocash.setSelect(false);
         if(this.McList.numChildren > 0)
         {
            this.McList.removeChildAt(0);
         }
         this.ShowPageButton();
         this.InitPackArray();
         this.ClearSelectedShipItem();
         this.ClearSelectedGoodsItem();
      }
      
      private function ClearSelectedItem() : void
      {
         if(this.mc_shipbase.numChildren > 0)
         {
            this.mc_shipbase.removeChildAt(0);
         }
         this.xtf_oneprice.ResetDefaultText();
         this.xtf_shipnum.ResetDefaultText();
         this.ClearSelectedGoodsItem();
         this.ClearSelectedShipItem();
         this.xtf_shipnum.ResetDefaultText();
         this.xtf_oneprice.ResetDefaultText();
         this.tf_price.text = "";
         this.tf_charge.text = "";
      }
      
      private function ClearSelectedShipItem() : void
      {
         if(this.SelectedShipItem != null)
         {
            this.SelectedShipItem.gotoAndStop("up");
            this.SelectedShipItem = null;
         }
      }
      
      private function ClearSelectedGoodsItem() : void
      {
         if(this.SelectedGoodsItem != null)
         {
            this.SelectedGoodsItem.gotoAndStop("up");
            this.SelectedGoodsItem = null;
         }
      }
      
      private function InitPackArray() : void
      {
         var _loc2_:PackPropsInfo = null;
         var _loc3_:int = 0;
         this.PackAll.length = 0;
         this.PackRes.length = 0;
         this.PackEquip.length = 0;
         this.PackCard.length = 0;
         this.PackPaper.length = 0;
         var _loc1_:int = 0;
         while(_loc1_ < ScienceSystem.getinstance().Packarr.length)
         {
            if(ScienceSystem.getinstance().Packarr[_loc1_].LockFlag != 1 && ScienceSystem.getinstance().Packarr[_loc1_].StorageType == 0)
            {
               _loc2_ = new PackPropsInfo();
               _loc2_.Num = ScienceSystem.getinstance().Packarr[_loc1_].PropsNum;
               _loc3_ = int(ScienceSystem.getinstance().Packarr[_loc1_].PropsId);
               _loc2_._PropsInfo = CPropsReader.getInstance().GetPropsInfo(_loc3_);
               if(_loc2_._PropsInfo != null)
               {
                  _loc2_.Id = _loc3_;
                  this.PackAll.push(_loc2_);
                  if(_loc2_._PropsInfo.PackID == 0)
                  {
                     this.PackPaper.push(_loc2_);
                  }
                  else if(_loc2_._PropsInfo.PackID == 1)
                  {
                     this.PackCard.push(_loc2_);
                  }
                  else if(_loc2_._PropsInfo.PackID == 2)
                  {
                     this.PackRes.push(_loc2_);
                  }
                  else if(_loc2_._PropsInfo.PackID == 3)
                  {
                     this.PackEquip.push(_loc2_);
                  }
               }
            }
            _loc1_++;
         }
      }
      
      private function RequestShipList() : void
      {
         var _loc1_:MSG_REQUEST_ARRANGESHIPTEAM = new MSG_REQUEST_ARRANGESHIPTEAM();
         _loc1_.Type = 1;
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc1_);
      }
      
      public function RespShipList(param1:MSG_RESP_ARRANGESHIPTEAM) : void
      {
         this.MsgShipList = param1;
         this.ShipPageCount = this.MsgShipList.DataLen / 4;
         if(this.ShipPageCount * 4 < this.MsgShipList.DataLen)
         {
            ++this.ShipPageCount;
         }
         if(this.SelectedTypeBtn == this.btn_airship)
         {
            this.PageIndex = 0;
            this.PageCount = this.ShipPageCount;
            this.ShowShip();
         }
      }
      
      private function Init() : void
      {
         var _loc1_:MovieClip = this.SellMc.getChildByName("btn_sellout") as MovieClip;
         this.btn_sellout = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_selloutClick);
         this.btn_sellout.setBtnDisabled(true);
         _loc1_ = this.SellMc.getChildByName("btn_airship") as MovieClip;
         this.btn_airship = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_airshipClick);
         _loc1_ = this.SellMc.getChildByName("btn_left") as MovieClip;
         this.btn_left = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_leftClick);
         _loc1_ = this.SellMc.getChildByName("btn_right") as MovieClip;
         this.btn_right = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_rightClick);
         this.tf_page = this.SellMc.getChildByName("tf_page") as TextField;
         this.tf_page.text = "";
         _loc1_ = this.SellMc.getChildByName("btn_homepage") as MovieClip;
         _loc1_.visible = false;
         _loc1_ = this.SellMc.getChildByName("btn_lastpage") as MovieClip;
         _loc1_.visible = false;
         this.mc_shipbase = this.SellMc.getChildByName("mc_shipbase") as MovieClip;
         this.mc_shipbase.addEventListener(MouseEvent.MOUSE_OVER,this.mc_shipbaseMouseOver);
         this.mc_shipbase.addEventListener(MouseEvent.MOUSE_OUT,this.mc_shipbaseMouseOut);
         this.tf_shipnum = this.SellMc.getChildByName("tf_shipnum") as TextField;
         this.tf_shipnum.addEventListener(Event.CHANGE,this.tf_onepriceChange);
         this.tf_shipnum.restrict = "0-9";
         this.xtf_shipnum = new XTextField(this.tf_shipnum,StringManager.getInstance().getMessageString("AuctionText37"));
         _loc1_ = this.SellMc.getChildByName("radiogold") as MovieClip;
         this.radiogold = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.radiogoldClick);
         _loc1_ = this.SellMc.getChildByName("radiocash") as MovieClip;
         this.radiocash = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.radiocashClick);
         this.tf_oneprice = this.SellMc.getChildByName("tf_oneprice") as TextField;
         this.tf_oneprice.addEventListener(Event.CHANGE,this.tf_onepriceChange);
         this.tf_oneprice.restrict = "0-9";
         this.tf_oneprice.maxChars = 8;
         this.xtf_oneprice = new XTextField(this.tf_oneprice,StringManager.getInstance().getMessageString("AuctionText38"));
         this.tf_price = this.SellMc.getChildByName("tf_price") as TextField;
         this.tf_price.text = "";
         this.tf_charge = this.SellMc.getChildByName("tf_charge") as TextField;
         this.tf_charge.text = "";
         this.McList = this.SellMc.getChildByName("mc_base") as MovieClip;
         this.TextFormat1 = this.tf_charge.getTextFormat();
         this.TextFormat2 = this.tf_charge.getTextFormat();
         this.TextFormat2.color = 16711680;
         this.InitCombox();
         this.InitShipList();
         this.InitGoodsList();
      }
      
      private function InitCombox() : void
      {
         var _loc1_:MovieClip = null;
         _loc1_ = this.SellMc.getChildByName("radiotime1") as MovieClip;
         this.radiotime1 = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.radiotime1Click);
         _loc1_ = this.SellMc.getChildByName("radiotime2") as MovieClip;
         this.radiotime2 = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.radiotime2Click);
         _loc1_ = this.SellMc.getChildByName("radiotime3") as MovieClip;
         this.radiotime3 = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.radiotime3Click);
      }
      
      private function InitShipList() : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         this.McShipList = GameKernel.getMovieClipInstance("AirshipsellMc",0,0,false);
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            _loc2_ = this.McShipList.getChildByName("mc_list" + _loc1_) as MovieClip;
            _loc3_ = GameKernel.getMovieClipInstance("AirshipsellplanMc",0,0,false);
            _loc3_.name = "Item" + _loc1_;
            _loc3_.stop();
            _loc3_.buttonMode = true;
            _loc3_.addEventListener(MouseEvent.CLICK,this.ShipItemClick);
            _loc4_ = _loc3_.getChildByName("mc_shipbase") as MovieClip;
            _loc4_.mouseChildren = false;
            _loc4_.buttonMode = true;
            _loc2_.addChild(_loc3_);
            _loc2_.visible = false;
            _loc1_++;
         }
      }
      
      private function InitGoodsList() : void
      {
         var _loc1_:MovieClip = null;
         var _loc3_:MovieClip = null;
         var _loc4_:TextField = null;
         var _loc5_:MovieClip = null;
         this.McGoodsList = GameKernel.getMovieClipInstance("GoodssellMc",0,0,false);
         _loc1_ = this.SellMc.getChildByName("btn_props") as MovieClip;
         this.btn_res = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_resClick);
         _loc1_ = this.SellMc.getChildByName("btn_goods") as MovieClip;
         this.btn_equip = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_equipClick);
         _loc1_ = this.SellMc.getChildByName("btn_card") as MovieClip;
         this.btn_card = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_cardClick);
         _loc1_ = this.SellMc.getChildByName("btn_paper") as MovieClip;
         this.btn_paper = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_paperClick);
         var _loc2_:int = 0;
         while(_loc2_ < 25)
         {
            _loc3_ = this.McGoodsList.getChildByName("mc_list" + _loc2_) as MovieClip;
            _loc3_.stop();
            _loc3_.addEventListener(MouseEvent.CLICK,this.GoodsItemClick);
            _loc3_.addEventListener(MouseEvent.MOUSE_OVER,this.GoodsItemMouseOver);
            _loc3_.addEventListener(MouseEvent.MOUSE_OUT,this.GoodsItemMouseOut);
            _loc3_.buttonMode = true;
            _loc3_.visible = false;
            _loc4_ = _loc3_.getChildByName("tf_num") as TextField;
            _loc5_ = _loc3_.getChildByName("mc_base") as MovieClip;
            _loc5_.mouseChildren = false;
            _loc2_++;
         }
      }
      
      private function btn_selloutClick(param1:MouseEvent) : void
      {
         if(this.SelectedItemId == -1)
         {
            return;
         }
         if(this.tf_oneprice.text == "")
         {
            return;
         }
         if(this.tf_shipnum.text == "")
         {
            return;
         }
         var _loc2_:int = int(this.tf_shipnum.text);
         if(_loc2_ > this.SelectedNum)
         {
            return;
         }
         var _loc3_:MSG_REQUEST_TRADEGOODS = new MSG_REQUEST_TRADEGOODS();
         _loc3_.TradeType = this.SelectedType;
         _loc3_.Id = this.SelectedItemId;
         _loc3_.PriceType = this.radiogold.selsected ? 0 : 1;
         if(this.radiotime1.selsected)
         {
            _loc3_.TimeType = 0;
         }
         else if(this.radiotime2.selsected)
         {
            _loc3_.TimeType = 1;
         }
         else
         {
            _loc3_.TimeType = 2;
         }
         _loc3_.Price = int(this.tf_oneprice.text);
         _loc3_.Num = int(this.tf_shipnum.text);
         _loc3_.SeqId = GamePlayer.getInstance().seqID++;
         _loc3_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc3_);
         if(_loc2_ == this.SelectedNum)
         {
            if(this.SelectedType == 1)
            {
               this.ClearSelectedGoodsItem();
            }
            else
            {
               this.ClearSelectedShipItem();
            }
            this.btn_sellout.setBtnDisabled(true);
         }
         this.ClearSellInfo();
      }
      
      public function RespTrade(param1:MSG_RESP_TRADEGOODS) : void
      {
         if(param1.ErrorCode != 0)
         {
            return;
         }
         if(param1.TradeType == 0)
         {
            this.RemoveShip(param1.Id,param1.Num);
         }
         else
         {
            this.RemoveGoods(param1.Id,param1.Num);
         }
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey("MallUI"))
         {
            this.ShowMoney();
         }
      }
      
      private function RemoveShip(param1:int, param2:int) : void
      {
         var _loc4_:MSG_SHIPTEAM_NUM = null;
         if(this.MsgShipList == null)
         {
            return;
         }
         var _loc3_:int = 0;
         while(_loc3_ < this.MsgShipList.DataLen)
         {
            _loc4_ = this.MsgShipList.TeamBody[_loc3_];
            if(_loc4_.ShipModelId == param1)
            {
               _loc4_.Num -= param2;
               if(_loc4_.Num <= 0)
               {
                  --this.MsgShipList.DataLen;
                  this.MsgShipList.TeamBody.splice(_loc3_,1);
               }
               break;
            }
            _loc3_++;
         }
         if(this.SelectedTypeBtn == this.btn_airship)
         {
            this.ShowShip();
         }
      }
      
      private function RemoveGoods(param1:int, param2:int) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < ScienceSystem.getinstance().Packarr.length)
         {
            _loc4_ = int(ScienceSystem.getinstance().Packarr[_loc3_].PropsId);
            if(_loc4_ == param1 && ScienceSystem.getinstance().Packarr[_loc3_].LockFlag == 0)
            {
               ScienceSystem.getinstance().Packarr[_loc3_].PropsNum = ScienceSystem.getinstance().Packarr[_loc3_].PropsNum - param2;
               if(ScienceSystem.getinstance().Packarr[_loc3_].PropsNum <= 0)
               {
                  ScienceSystem.getinstance().Packarr.splice(_loc3_,1);
               }
               break;
            }
            _loc3_++;
         }
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey("MallUI"))
         {
            this.InitPackArray();
            this.ShowGoods();
         }
      }
      
      private function btn_airshipClick(param1:MouseEvent) : void
      {
         this.ResetSelectedTypeBtn(this.btn_airship);
         this.ShowListMc(this.McShipList);
         if(this.MsgShipList == null)
         {
            this.RequestShipList();
            return;
         }
         this.PageIndex = 0;
         this.PageCount = this.ShipPageCount;
         this.ShowPageButton();
         this.ClearSelectedItem();
      }
      
      private function ShowListMc(param1:MovieClip) : void
      {
         if(this.McList.numChildren > 0)
         {
            this.McList.removeChildAt(0);
         }
         this.McList.addChild(param1);
      }
      
      private function ResetSelectedTypeBtn(param1:HButton) : void
      {
         if(param1 == this.SelectedTypeBtn)
         {
            return;
         }
         if(this.SelectedTypeBtn != null)
         {
            this.SelectedTypeBtn.setSelect(false);
         }
         this.SelectedTypeBtn = param1;
         this.SelectedTypeBtn.setSelect(true);
      }
      
      private function btn_leftClick(param1:MouseEvent) : void
      {
         --this.PageIndex;
         if(this.SelectedTypeBtn == this.btn_airship)
         {
            this.ShowShip();
            this.ClearSelectedShipItem();
         }
         else
         {
            this.ShowGoods();
            this.ClearSelectedGoodsItem();
         }
      }
      
      private function btn_rightClick(param1:MouseEvent) : void
      {
         ++this.PageIndex;
         if(this.SelectedTypeBtn == this.btn_airship)
         {
            this.ShowShip();
            this.ClearSelectedShipItem();
         }
         else
         {
            this.ShowGoods();
            this.ClearSelectedGoodsItem();
         }
      }
      
      private function radiogoldClick(param1:MouseEvent) : void
      {
         this.radiogold.setSelect(true);
         this.radiocash.setSelect(false);
         this.UpdateCharge();
      }
      
      private function radiocashClick(param1:MouseEvent) : void
      {
         this.radiogold.setSelect(false);
         this.radiocash.setSelect(true);
         this.UpdateCharge();
      }
      
      private function radiotime1Click(param1:MouseEvent) : void
      {
         this.radiotime1.setSelect(true);
         this.radiotime2.setSelect(false);
         this.radiotime3.setSelect(false);
         this.UpdateCharge();
      }
      
      private function radiotime2Click(param1:MouseEvent) : void
      {
         this.radiotime1.setSelect(false);
         this.radiotime2.setSelect(true);
         this.radiotime3.setSelect(false);
         this.UpdateCharge();
      }
      
      private function radiotime3Click(param1:MouseEvent) : void
      {
         this.radiotime1.setSelect(false);
         this.radiotime2.setSelect(false);
         this.radiotime3.setSelect(true);
         this.UpdateCharge();
      }
      
      private function btn_allClick(param1:MouseEvent) : void
      {
         this.PageIndex = 0;
         this.ResetSelectedTypeBtn(this.btn_all);
         this.SelectedPack = this.PackAll;
         this.ClearSelectedGoodsItem();
         this.ShowGoods();
         this.ClearSelectedItem();
      }
      
      private function btn_resClick(param1:MouseEvent) : void
      {
         this.PageIndex = 0;
         this.ResetSelectedTypeBtn(this.btn_res);
         this.SelectedPack = this.PackRes;
         this.ClearSelectedGoodsItem();
         this.ShowGoods();
         this.ClearSelectedItem();
      }
      
      private function btn_equipClick(param1:MouseEvent) : void
      {
         this.PageIndex = 0;
         this.ResetSelectedTypeBtn(this.btn_equip);
         this.SelectedPack = this.PackEquip;
         this.ClearSelectedGoodsItem();
         this.ShowGoods();
         this.ClearSelectedItem();
      }
      
      private function btn_cardClick(param1:MouseEvent) : void
      {
         this.PageIndex = 0;
         this.ResetSelectedTypeBtn(this.btn_card);
         this.SelectedPack = this.PackCard;
         this.ClearSelectedGoodsItem();
         this.ShowGoods();
         this.ClearSelectedItem();
      }
      
      private function btn_paperClick(param1:MouseEvent) : void
      {
         this.PageIndex = 0;
         this.ResetSelectedTypeBtn(this.btn_paper);
         this.SelectedPack = this.PackPaper;
         this.ClearSelectedGoodsItem();
         this.ShowGoods();
         this.ClearSelectedItem();
      }
      
      private function ShipItemClick(param1:MouseEvent) : void
      {
         var _loc4_:MSG_SHIPTEAM_NUM = null;
         var _loc5_:ShipmodelInfo = null;
         var _loc6_:ShipbodyInfo = null;
         var _loc7_:Bitmap = null;
         var _loc2_:int = this.GetShipItemIndex(param1);
         var _loc3_:int = this.PageIndex * 4 + _loc2_;
         if(_loc3_ < this.MsgShipList.DataLen)
         {
            _loc4_ = this.MsgShipList.TeamBody[_loc3_];
            _loc5_ = ShipmodelRouter.instance.ShipModeList.Get(_loc4_.ShipModelId);
            _loc6_ = CShipmodelReader.getInstance().getShipBodyInfo(_loc5_.m_BodyId);
            _loc7_ = new Bitmap(GameKernel.getTextureInstance(_loc6_.SmallIcon));
            _loc7_.x = -5;
            if(this.mc_shipbase.numChildren > 0)
            {
               this.mc_shipbase.removeChildAt(0);
            }
            this.mc_shipbase.addChild(_loc7_);
            this.SelectedType = 0;
            this.SelectedItemId = _loc4_.ShipModelId;
            this.SelectedNum = _loc4_.Num;
            this.xtf_shipnum.ResetDefaultText();
            this.xtf_oneprice.ResetDefaultText();
            this.tf_price.text = "";
            this.tf_charge.text = "";
            this.btn_sellout.setBtnDisabled(true);
         }
      }
      
      private function ClearSellInfo() : void
      {
         if(this.mc_shipbase.numChildren > 0)
         {
            this.mc_shipbase.removeChildAt(0);
         }
         this.tf_shipnum.text = "";
         this.tf_oneprice.text = "";
         this.tf_price.text = "";
         this.tf_charge.text = "";
      }
      
      private function tf_onepriceChange(param1:Event) : void
      {
         var _loc3_:int = 0;
         this.tf_price.text = "";
         var _loc2_:int = 0;
         if(this.tf_shipnum.text != "")
         {
            _loc2_ = int(this.tf_shipnum.text);
            if(this.SelectedNum < _loc2_)
            {
               _loc2_ = this.SelectedNum;
               this.tf_shipnum.text = _loc2_.toString();
            }
         }
         if(this.tf_oneprice.text != "" && _loc2_ > 0)
         {
            _loc3_ = int(this.tf_oneprice.text);
            this.Price = int(Math.round(_loc3_ / _loc2_ * 100) / 100);
            this.tf_price.text = this.Price.toString();
            this.UpdateCharge();
         }
      }
      
      private function UpdateCharge() : void
      {
         var _loc1_:Number = NaN;
         if(this.radiotime1.selsected)
         {
            _loc1_ = 0;
         }
         else if(this.radiotime2.selsected)
         {
            _loc1_ = 0.2;
         }
         else
         {
            _loc1_ = 0.3;
         }
         var _loc2_:int = int(this.tf_oneprice.text);
         this.charge = Math.round(_loc2_ * this.DecreaseTax * (1 + _loc1_));
         if(this.charge <= 0)
         {
            this.charge = 1;
         }
         this.tf_charge.text = this.charge.toString();
         if(_loc2_ == 0)
         {
            this.btn_sellout.setBtnDisabled(true);
            return;
         }
         if(this.radiogold.selsected)
         {
            if(GamePlayer.getInstance().UserMoney < this.charge)
            {
               this.tf_charge.setTextFormat(this.TextFormat2);
               this.btn_sellout.setBtnDisabled(true);
            }
            else
            {
               this.tf_charge.setTextFormat(this.TextFormat1);
               this.btn_sellout.setBtnDisabled(false);
            }
         }
         else if(GamePlayer.getInstance().cash < this.charge)
         {
            this.tf_charge.setTextFormat(this.TextFormat2);
            this.btn_sellout.setBtnDisabled(true);
         }
         else
         {
            this.tf_charge.setTextFormat(this.TextFormat1);
            this.btn_sellout.setBtnDisabled(false);
         }
      }
      
      private function GetShipItemIndex(param1:MouseEvent) : int
      {
         var _loc2_:DisplayObject = param1.target as DisplayObject;
         if(_loc2_.name.indexOf("Item") < 0)
         {
            _loc2_ = _loc2_.parent as DisplayObject;
         }
         var _loc3_:int = int(_loc2_.name.substr(4));
         if(this.SelectedShipItem != null)
         {
            this.SelectedShipItem.gotoAndStop("up");
         }
         this.SelectedShipItem = _loc2_ as MovieClip;
         this.SelectedShipItem.gotoAndStop("selected");
         return _loc3_;
      }
      
      private function mc_shipbaseMouseOver(param1:MouseEvent) : void
      {
         var _loc3_:ShipmodelInfo = null;
         if(this.SelectedItemId == -1)
         {
            return;
         }
         var _loc2_:Point = this.mc_shipbase.localToGlobal(new Point(0,50));
         if(this.SelectedType == 1)
         {
            _loc2_ = this.SellMc.globalToLocal(_loc2_);
            this._PropsTip = PackUi.getInstance().TipHd(_loc2_.x,_loc2_.y,this.SelectedItemId,true);
            this._PropsTip.x = _loc2_.x;
            this._PropsTip.y = _loc2_.y - 20;
            this.SellMc.addChild(this._PropsTip);
         }
         else
         {
            _loc3_ = ShipmodelRouter.instance.ShipModeList.Get(this.SelectedItemId);
            CustomTip.GetInstance().Show(_loc3_.m_ShipName,_loc2_);
         }
      }
      
      private function mc_shipbaseMouseOut(param1:MouseEvent) : void
      {
         if(this.SelectedItemId == -1)
         {
            return;
         }
         if(this.SelectedType == 1)
         {
            if(this._PropsTip != null && this.SellMc.contains(this._PropsTip))
            {
               this.SellMc.removeChild(this._PropsTip);
            }
         }
         else
         {
            CustomTip.GetInstance().Hide();
         }
      }
      
      private function GoodsItemMouseOver(param1:MouseEvent) : void
      {
         var _loc4_:MovieClip = null;
         var _loc5_:Point = null;
         var _loc6_:PackPropsInfo = null;
         var _loc2_:int = this.GetGoodsItemIndex(param1,false);
         var _loc3_:int = this.PageIndex * 25 + _loc2_;
         if(_loc3_ < this.SelectedPack.length)
         {
            _loc4_ = this.McGoodsList.getChildByName("mc_list" + _loc2_) as MovieClip;
            _loc5_ = _loc4_.localToGlobal(new Point(0,45));
            _loc6_ = this.SelectedPack[_loc3_];
            _loc5_ = this.SellMc.globalToLocal(_loc5_);
            this._PropsTip = PackUi.getInstance().TipHd(_loc5_.x,_loc5_.y,_loc6_.Id,true);
            this._PropsTip.x = _loc5_.x;
            this._PropsTip.y = _loc5_.y - 20;
            this.SellMc.addChild(this._PropsTip);
         }
      }
      
      private function GoodsItemMouseOut(param1:MouseEvent) : void
      {
         if(this._PropsTip != null && this.SellMc.contains(this._PropsTip))
         {
            this.SellMc.removeChild(this._PropsTip);
         }
      }
      
      private function GoodsItemClick(param1:MouseEvent) : void
      {
         var _loc4_:PackPropsInfo = null;
         var _loc5_:Bitmap = null;
         var _loc2_:int = this.GetGoodsItemIndex(param1);
         var _loc3_:int = this.PageIndex * 25 + _loc2_;
         if(_loc3_ < this.SelectedPack.length)
         {
            _loc4_ = this.SelectedPack[_loc3_];
            if(this.mc_shipbase.numChildren > 0)
            {
               this.mc_shipbase.removeChildAt(0);
            }
            _loc5_ = new Bitmap(GameKernel.getTextureInstance(_loc4_._PropsInfo.ImageFileName));
            _loc5_.x = 2;
            _loc5_.y = 2;
            this.mc_shipbase.addChild(_loc5_);
            this.SelectedType = 1;
            this.SelectedItemId = _loc4_.Id;
            this.SelectedNum = _loc4_.Num;
            this.tf_shipnum.text = _loc4_.Num.toString();
            this.tf_oneprice.text = "";
            this.tf_price.text = "";
            this.btn_sellout.setBtnDisabled(false);
         }
      }
      
      private function GetGoodsItemIndex(param1:MouseEvent, param2:Boolean = true) : int
      {
         var _loc3_:DisplayObject = param1.target as DisplayObject;
         if(_loc3_.name.indexOf("mc_list") < 0)
         {
            _loc3_ = _loc3_.parent as DisplayObject;
         }
         var _loc4_:int = int(_loc3_.name.substr(7));
         if(param2)
         {
            if(this.SelectedGoodsItem != null)
            {
               this.SelectedGoodsItem.gotoAndStop("up");
            }
            this.SelectedGoodsItem = _loc3_ as MovieClip;
            this.SelectedGoodsItem.gotoAndStop("selected");
         }
         return _loc4_;
      }
      
      private function ShowShip() : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:MSG_SHIPTEAM_NUM = null;
         var _loc5_:ShipmodelInfo = null;
         var _loc6_:ShipbodyInfo = null;
         var _loc7_:Bitmap = null;
         var _loc8_:MovieClip = null;
         var _loc9_:MovieClip = null;
         var _loc10_:TextField = null;
         var _loc11_:TextField = null;
         var _loc1_:int = this.PageIndex * 4;
         var _loc2_:int = 0;
         while(_loc2_ < 4)
         {
            _loc3_ = this.McShipList.getChildByName("mc_list" + _loc2_) as MovieClip;
            if(_loc1_ < this.MsgShipList.DataLen)
            {
               _loc4_ = this.MsgShipList.TeamBody[_loc1_];
               _loc5_ = ShipmodelRouter.instance.ShipModeList.Get(_loc4_.ShipModelId);
               _loc6_ = CShipmodelReader.getInstance().getShipBodyInfo(_loc5_.m_BodyId);
               _loc7_ = new Bitmap(GameKernel.getTextureInstance(_loc6_.SmallIcon));
               _loc7_.x = 5;
               _loc7_.y = 15;
               _loc7_.width = 50;
               _loc7_.height = 35;
               _loc8_ = _loc3_.getChildByName("Item" + _loc2_) as MovieClip;
               _loc9_ = _loc8_.getChildByName("mc_shipbase") as MovieClip;
               if(_loc9_.numChildren > 0)
               {
                  _loc9_.removeChildAt(0);
               }
               _loc9_.addChild(_loc7_);
               _loc10_ = _loc8_.getChildByName("f_name") as TextField;
               _loc10_.text = _loc5_.m_ShipName;
               _loc11_ = _loc8_.getChildByName("tf_num") as TextField;
               _loc11_.text = _loc4_.Num.toString();
               _loc3_.visible = true;
               _loc1_++;
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc2_++;
         }
         this.ShowListMc(this.McShipList);
         this.ShowPageButton();
      }
      
      private function ShowGoods() : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:PackPropsInfo = null;
         var _loc5_:MovieClip = null;
         var _loc6_:Bitmap = null;
         var _loc7_:TextField = null;
         if(this.SelectedPack == null)
         {
            return;
         }
         this.ShowListMc(this.McGoodsList);
         this.PageCount = this.SelectedPack.length / 25;
         if(this.PageCount * 25 < this.SelectedPack.length)
         {
            ++this.PageCount;
         }
         this.ShowPageButton();
         var _loc1_:int = this.PageIndex * 25;
         var _loc2_:int = 0;
         while(_loc2_ < 25)
         {
            _loc3_ = this.McGoodsList.getChildByName("mc_list" + _loc2_) as MovieClip;
            if(_loc1_ < this.SelectedPack.length)
            {
               _loc4_ = this.SelectedPack[_loc1_];
               _loc5_ = _loc3_.getChildByName("mc_base") as MovieClip;
               if(_loc5_.numChildren > 0)
               {
                  _loc5_.removeChildAt(0);
               }
               _loc6_ = new Bitmap(GameKernel.getTextureInstance(_loc4_._PropsInfo.ImageFileName));
               _loc5_.addChild(_loc6_);
               _loc7_ = _loc3_.getChildByName("tf_num") as TextField;
               _loc7_.text = _loc4_.Num.toString();
               _loc3_.visible = true;
               _loc1_++;
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc2_++;
         }
      }
      
      private function ShowPageButton() : void
      {
         if(this.PageIndex < this.PageCount)
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
      }
      
      private function btn_blackmarketClick(param1:MouseEvent) : void
      {
      }
   }
}

