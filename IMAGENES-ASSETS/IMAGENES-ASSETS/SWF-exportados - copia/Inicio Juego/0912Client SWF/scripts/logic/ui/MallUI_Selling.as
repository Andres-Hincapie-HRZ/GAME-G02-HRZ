package logic.ui
{
   import com.star.frameworks.managers.StringManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.HButtonType;
   import logic.entry.props.propsInfo;
   import logic.entry.shipmodel.ShipbodyInfo;
   import logic.entry.shipmodel.ShipmodelInfo;
   import logic.game.GameKernel;
   import logic.reader.CPropsReader;
   import logic.reader.CShipmodelReader;
   import logic.widget.DataWidget;
   import net.base.NetManager;
   import net.msg.mall.MSG_REQUEST_DELETETRADEGOODS;
   import net.msg.mall.MSG_REQUEST_MYTRADEINFO;
   import net.msg.mall.MSG_RESP_MYTRADEINFO;
   import net.msg.mall.MSG_RESP_TRADEINFO_TEMP;
   import net.router.ShipmodelRouter;
   
   public class MallUI_Selling
   {
      
      private static var instance:MallUI_Selling;
      
      private var SellingMc:MovieClip;
      
      private var btn_left:HButton;
      
      private var btn_right:HButton;
      
      private var tf_page:TextField;
      
      private var PageIndex:int;
      
      private var PageCount:int;
      
      private var SelectedItem:MovieClip;
      
      private var MyTradeInfo:MSG_RESP_MYTRADEINFO;
      
      private var DeleteItemIndex:int;
      
      public function MallUI_Selling()
      {
         super();
         this.SellingMc = GameKernel.getMovieClipInstance("SellingMc",0,0,false);
         this.Init();
      }
      
      public static function getInstance() : MallUI_Selling
      {
         if(instance == null)
         {
            instance = new MallUI_Selling();
         }
         return instance;
      }
      
      public function GetMc() : MovieClip
      {
         this.Clear();
         this.RequestSellingList();
         return this.SellingMc;
      }
      
      private function Clear() : void
      {
         var _loc2_:MovieClip = null;
         this.ClearSelectedItem();
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            _loc2_ = this.SellingMc.getChildByName("mc_list" + _loc1_) as MovieClip;
            _loc2_.visible = false;
            _loc1_++;
         }
         this.PageIndex = 0;
         this.PageCount = 0;
         this.ShowPageButton();
      }
      
      private function ClearSelectedItem() : void
      {
         if(this.SelectedItem != null)
         {
            this.SelectedItem.gotoAndStop("up");
            this.SelectedItem = null;
         }
      }
      
      private function Init() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:HButton = null;
         _loc1_ = this.SellingMc.getChildByName("btn_left") as MovieClip;
         this.btn_left = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_leftClick);
         _loc1_ = this.SellingMc.getChildByName("btn_right") as MovieClip;
         this.btn_right = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_rightClick);
         this.tf_page = this.SellingMc.getChildByName("tf_page") as TextField;
         _loc1_ = this.SellingMc.getChildByName("btn_homepage") as MovieClip;
         _loc1_.visible = false;
         _loc1_ = this.SellingMc.getChildByName("btn_lastpage") as MovieClip;
         _loc1_.visible = false;
         this.InitList();
      }
      
      private function InitList() : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:HButton = null;
         var _loc6_:MovieClip = null;
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            _loc2_ = this.SellingMc.getChildByName("mc_list" + _loc1_) as MovieClip;
            _loc3_ = GameKernel.getMovieClipInstance("SellinglistMc",0,0,false);
            _loc3_.name = "Item" + _loc1_;
            _loc3_.stop();
            _loc3_.addEventListener(MouseEvent.CLICK,this.ItemClick);
            _loc4_ = _loc3_.getChildByName("btn_delete") as MovieClip;
            _loc5_ = new HButton(_loc4_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("AuctionText41"));
            _loc4_.addEventListener(MouseEvent.CLICK,this.btn_deleteClick);
            _loc6_ = _loc3_.getChildByName("mc_base") as MovieClip;
            _loc6_.buttonMode = true;
            _loc6_.mouseChildren = false;
            _loc2_.addChild(_loc3_);
            _loc2_.visible = false;
            _loc1_++;
         }
      }
      
      private function ItemClick(param1:MouseEvent) : void
      {
         var _loc2_:int = this.GetShipItemIndex(param1);
      }
      
      private function btn_deleteClick(param1:MouseEvent) : void
      {
         var _loc2_:int = this.GetShipItemIndex(param1);
         var _loc3_:MovieClip = this.SellingMc.getChildByName("mc_list" + _loc2_) as MovieClip;
         _loc2_ = this.PageIndex * 5 + _loc2_;
         if(_loc2_ >= this.MyTradeInfo.DataLen)
         {
            return;
         }
         this.DeleteItemIndex = _loc2_;
         MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("AuctionText40"),2,this.DeleteTrade);
      }
      
      private function DeleteTrade() : void
      {
         var _loc1_:MSG_RESP_TRADEINFO_TEMP = this.MyTradeInfo.Data[this.DeleteItemIndex];
         var _loc2_:MSG_REQUEST_DELETETRADEGOODS = new MSG_REQUEST_DELETETRADEGOODS();
         _loc2_.IndexId = _loc1_.IndexId;
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc2_);
         this.MyTradeInfo.Data.splice(this.DeleteItemIndex,1);
         --this.MyTradeInfo.DataLen;
         this.ShowTradeInfo();
      }
      
      private function GetShipItemIndex(param1:MouseEvent) : int
      {
         var _loc2_:DisplayObject = param1.target as DisplayObject;
         if(_loc2_.name.indexOf("Item") < 0)
         {
            _loc2_ = _loc2_.parent as DisplayObject;
         }
         var _loc3_:int = int(_loc2_.name.substr(4));
         if(this.SelectedItem != null)
         {
            this.SelectedItem.gotoAndStop("up");
         }
         this.SelectedItem = _loc2_ as MovieClip;
         this.SelectedItem.gotoAndStop("selected");
         return _loc3_;
      }
      
      private function btn_leftClick(param1:MouseEvent) : void
      {
         --this.PageIndex;
         this.ShowTradeInfo();
      }
      
      private function btn_rightClick(param1:MouseEvent) : void
      {
         ++this.PageIndex;
         this.ShowTradeInfo();
      }
      
      private function btn_blackmarketClick(param1:MouseEvent) : void
      {
      }
      
      private function RequestSellingList() : void
      {
         var _loc1_:MSG_REQUEST_MYTRADEINFO = new MSG_REQUEST_MYTRADEINFO();
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc1_);
      }
      
      public function RespMyTradeInfo(param1:MSG_RESP_MYTRADEINFO) : void
      {
         this.MyTradeInfo = param1;
         this.PageIndex = 0;
         this.PageCount = param1.DataLen / 5;
         if(this.PageCount * 5 < param1.DataLen)
         {
            ++this.PageCount;
         }
         this.ShowTradeInfo();
      }
      
      private function ShowTradeInfo() : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:MSG_RESP_TRADEINFO_TEMP = null;
         var _loc6_:MovieClip = null;
         var _loc7_:String = null;
         var _loc8_:TextField = null;
         var _loc9_:Number = NaN;
         var _loc10_:MovieClip = null;
         var _loc11_:MovieClip = null;
         var _loc12_:Bitmap = null;
         var _loc13_:Bitmap = null;
         var _loc14_:ShipmodelInfo = null;
         var _loc15_:ShipbodyInfo = null;
         var _loc16_:Bitmap = null;
         var _loc17_:propsInfo = null;
         var _loc18_:Bitmap = null;
         this.ClearSelectedItem();
         var _loc1_:int = this.PageIndex * 5;
         var _loc2_:int = 0;
         while(_loc2_ < 5)
         {
            _loc3_ = this.SellingMc.getChildByName("mc_list" + _loc2_) as MovieClip;
            if(_loc1_ < this.MyTradeInfo.DataLen)
            {
               _loc4_ = _loc3_.getChildByName("Item" + _loc2_) as MovieClip;
               _loc5_ = this.MyTradeInfo.Data[_loc1_];
               _loc6_ = _loc4_.getChildByName("mc_base") as MovieClip;
               if(_loc6_.numChildren > 0)
               {
                  _loc6_.removeChildAt(0);
               }
               if(_loc5_.TradeType == 0)
               {
                  _loc14_ = ShipmodelRouter.instance.ShipModeList.Get(_loc5_.Id);
                  _loc15_ = CShipmodelReader.getInstance().getShipBodyInfo(_loc14_.m_BodyId);
                  _loc16_ = new Bitmap(GameKernel.getTextureInstance(_loc15_.SmallIcon));
                  _loc7_ = _loc14_.m_ShipName;
                  _loc16_.x = -7;
                  _loc6_.addChild(_loc16_);
               }
               else
               {
                  _loc17_ = CPropsReader.getInstance().GetPropsInfo(_loc5_.Id);
                  _loc18_ = new Bitmap(GameKernel.getTextureInstance(_loc17_.ImageFileName));
                  _loc7_ = _loc17_.Name;
                  _loc6_.addChild(_loc18_);
               }
               _loc8_ = _loc4_.getChildByName("tf_name") as TextField;
               _loc8_.text = _loc7_;
               _loc8_ = _loc4_.getChildByName("tf_num") as TextField;
               _loc8_.text = _loc5_.Num.toString();
               _loc8_ = _loc4_.getChildByName("tf_remaintime") as TextField;
               _loc8_.text = DataWidget.GetTimeString2(_loc5_.SpareTime);
               _loc8_ = _loc4_.getChildByName("tf_allprice") as TextField;
               _loc8_.text = _loc5_.Price.toString();
               _loc9_ = Math.round(_loc5_.Price / _loc5_.Num * 100);
               _loc9_ = _loc9_ / 100;
               _loc8_ = _loc4_.getChildByName("tf_price") as TextField;
               _loc8_.text = _loc9_.toString();
               _loc10_ = _loc4_.getChildByName("mc_resbase0") as MovieClip;
               if(_loc10_.numChildren > 0)
               {
                  _loc10_.removeChildAt(0);
               }
               _loc11_ = _loc4_.getChildByName("mc_resbase1") as MovieClip;
               if(_loc11_.numChildren > 0)
               {
                  _loc11_.removeChildAt(0);
               }
               if(_loc5_.PriceType == 0)
               {
                  _loc12_ = new Bitmap(GameKernel.getTextureInstance("Gold"));
                  _loc13_ = new Bitmap(GameKernel.getTextureInstance("Gold"));
               }
               else
               {
                  _loc12_ = new Bitmap(GameKernel.getTextureInstance("Fund"));
                  _loc13_ = new Bitmap(GameKernel.getTextureInstance("Fund"));
               }
               _loc12_.x = -10;
               _loc12_.y = -10;
               _loc10_.addChild(_loc12_);
               _loc13_.x = -10;
               _loc13_.y = -10;
               _loc11_.addChild(_loc13_);
               _loc3_.visible = true;
               _loc1_++;
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc2_++;
         }
         this.ShowPageButton();
      }
      
      private function ShowPageButton() : void
      {
         if(this.PageCount <= 0)
         {
            this.tf_page.text = "1/1";
            this.btn_left.setBtnDisabled(true);
            this.btn_right.setBtnDisabled(true);
            return;
         }
         this.tf_page.text = this.PageIndex + 1 + "/" + this.PageCount;
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
   }
}

