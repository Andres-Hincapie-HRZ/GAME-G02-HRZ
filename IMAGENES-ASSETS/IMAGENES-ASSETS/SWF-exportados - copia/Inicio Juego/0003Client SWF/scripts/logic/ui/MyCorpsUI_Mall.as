package logic.ui
{
   import com.star.frameworks.geom.CFilter;
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.HashSet;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import logic.entry.CorpsMallItem;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.entry.shipmodel.ShipbodyInfo;
   import logic.entry.shipmodel.ShipmodelInfo;
   import logic.entry.shipmodel.ShippartInfo;
   import logic.game.GameKernel;
   import logic.reader.CShipmodelReader;
   import logic.reader.CorpsMallReader;
   import logic.ui.tip.ShipModelInfoTip;
   import logic.ui.tip.ShipPartInfoTip;
   import net.base.NetManager;
   import net.msg.corpsMsg.MSG_REQUEST_CONSORTIABUYGOODS;
   import net.msg.corpsMsg.MSG_RESP_CONSORTIABUYGOODS;
   
   public class MyCorpsUI_Mall extends AbstractPopUp
   {
      
      private static var instance:MyCorpsUI_Mall;
      
      private const ROW_COUNT:int = 6;
      
      private var btn_left:HButton;
      
      private var btn_right:HButton;
      
      private var tf_page:TextField;
      
      private var PageCount:int;
      
      private var PageId:int;
      
      private var btn_left_part:HButton;
      
      private var btn_right_part:HButton;
      
      private var tf_page_part:TextField;
      
      private var PageCountPart:int;
      
      private var PageIdPart:int;
      
      private var tf_offernum:TextField;
      
      private var tf_nowoffernum:TextField;
      
      private var tf_num:XTextField;
      
      private var btn_buy:HButton;
      
      private var Level0Button:XButton;
      
      private var MallItemArray:Array;
      
      private var SelectedLevelButton:XButton;
      
      private var PartList:HashSet;
      
      private var filter:CFilter;
      
      private var CanBuy:Boolean;
      
      private var SelectedModel:XButton;
      
      private var SelectedModelId:int;
      
      private var SelectedMallItem:CorpsMallItem;
      
      public function MyCorpsUI_Mall()
      {
         super();
         this.filter = ShipModeEditUI.getInstance().filter;
         setPopUpName("MyCorpsUI_Mall");
      }
      
      public static function getInstance() : MyCorpsUI_Mall
      {
         if(instance == null)
         {
            instance = new MyCorpsUI_Mall();
         }
         return instance;
      }
      
      override public function Init() : void
      {
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            this.Clear();
            return;
         }
         this._mc = new MObject("CorpsMallMc",385,300);
         this.initMcElement();
         this.Clear();
         GameKernel.popUpDisplayManager.Regisger(instance);
      }
      
      override public function initMcElement() : void
      {
         var _loc1_:HButton = null;
         var _loc2_:MovieClip = null;
         var _loc4_:XButton = null;
         var _loc6_:XMovieClip = null;
         _loc2_ = this._mc.getMC().getChildByName("btn_close") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.CloseClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_up") as MovieClip;
         this.btn_left = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_leftClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_down") as MovieClip;
         this.btn_right = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_rightClick);
         this.tf_page = this._mc.getMC().getChildByName("tf_page") as TextField;
         _loc2_ = this._mc.getMC().getChildByName("btn_left") as MovieClip;
         this.btn_left_part = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_left_partClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_right") as MovieClip;
         this.btn_right_part = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_right_partClick);
         this.tf_page_part = this._mc.getMC().getChildByName("tf_pagenum") as TextField;
         this.tf_offernum = this._mc.getMC().getChildByName("tf_offernum") as TextField;
         this.tf_nowoffernum = this._mc.getMC().getChildByName("tf_nowoffernum") as TextField;
         var _loc3_:TextField = this._mc.getMC().getChildByName("tf_num") as TextField;
         this.tf_num = new XTextField(_loc3_,StringManager.getInstance().getMessageString("CorpsText83"));
         _loc3_.restrict = "0-9";
         _loc3_.addEventListener(Event.CHANGE,this.tf_numChange);
         _loc2_ = this._mc.getMC().getChildByName("btn_front") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_frontClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_next") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_nextClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_buy") as MovieClip;
         this.btn_buy = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_buyClick);
         var _loc5_:int = 0;
         while(_loc5_ < 10)
         {
            _loc2_ = this._mc.getMC().getChildByName("mc_base" + _loc5_) as MovieClip;
            _loc4_ = new XButton(_loc2_);
            _loc4_.Data = _loc5_;
            _loc4_.OnClick = this.LevelButtonClick;
            if(_loc5_ == 0)
            {
               this.Level0Button = _loc4_;
            }
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < this.ROW_COUNT)
         {
            _loc2_ = this._mc.getMC().getChildByName("mc_plan" + _loc5_) as MovieClip;
            TextField(_loc2_.tf_shipnum).text = "100";
            _loc4_ = new XButton(_loc2_);
            _loc4_.Data = _loc5_;
            _loc4_.OnClick = this.ShipModulClick;
            _loc4_.OnMouseOver = this.ShipModulOver;
            _loc2_.addEventListener(MouseEvent.MOUSE_OUT,this.ShipModulOut);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < 9)
         {
            _loc2_ = this._mc.getMC().getChildByName("mc_list" + _loc5_) as MovieClip;
            _loc6_ = new XMovieClip(_loc2_);
            _loc6_.Data = _loc5_;
            _loc6_.OnMouseOver = this.PartMouseOver;
            _loc2_.addEventListener(MouseEvent.MOUSE_OUT,this.PartMouseOut);
            _loc5_++;
         }
         this.PartList = new HashSet();
      }
      
      private function ClearPartList() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:int = 0;
         while(_loc2_ < 9)
         {
            _loc1_ = this._mc.getMC().getChildByName("mc_list" + _loc2_) as MovieClip;
            _loc1_.gotoAndStop(2);
            _loc2_++;
         }
         this.PartList.Clear();
         this.PageCountPart = 0;
         this.PageIdPart = 0;
      }
      
      private function ClearModel() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.ROW_COUNT)
         {
            _loc1_ = this._mc.getMC().getChildByName("mc_plan" + _loc2_) as MovieClip;
            _loc1_.visible = false;
            _loc2_++;
         }
         this.ClearText();
         this.SelectedMallItem = null;
         this.PageCount = 0;
         this.PageId = 0;
         this.SetPageButton();
      }
      
      private function ClearText() : void
      {
         this.tf_num.text = "";
         this.tf_offernum.text = "";
         this.tf_nowoffernum.text = GamePlayer.getInstance().ConsortiaThrowValue.toString();
         this.tf_num.ResetDefaultText();
      }
      
      private function Clear() : void
      {
         this.ClearPartList();
         this.ClearModel();
      }
      
      public function Show() : void
      {
         this.Init();
         GameKernel.popUpDisplayManager.Show(this);
         if(this.SelectedLevelButton != null)
         {
            this.SelectedLevelButton.setSelect(false);
         }
         this.SelectedLevelButton = this.Level0Button;
         this.Level0Button.setSelect(true);
         this.ShowGoods(0);
      }
      
      private function LevelButtonClick(param1:MouseEvent, param2:XButton) : void
      {
         if(this.SelectedLevelButton != null)
         {
            this.SelectedLevelButton.setSelect(false);
         }
         this.SelectedLevelButton = param2;
         this.SelectedLevelButton.setSelect(true);
         this.ClearModel();
         this.ClearPartList();
         this.ShowGoods(param2.Data);
      }
      
      private function GetCanBuy(param1:int) : Boolean
      {
         var _loc3_:String = null;
         var _loc2_:Boolean = GamePlayer.getInstance().ConsortiaShopLevel >= param1 && GamePlayer.getInstance().ConsortiaThrowValue >= GamePlayer.getInstance().ConsortiaShopValue;
         this.btn_buy.setBtnDisabled(!_loc2_);
         this.btn_buy.m_movie.mouseEnabled = true;
         if(GamePlayer.getInstance().ConsortiaShopLevel < param1)
         {
            _loc3_ = StringManager.getInstance().getMessageString("CorpsText92");
            _loc3_ = _loc3_.replace("@@1",param1 + 1);
            this.btn_buy.SetTip(_loc3_);
         }
         else if(GamePlayer.getInstance().ConsortiaThrowValue < GamePlayer.getInstance().ConsortiaShopValue)
         {
            this.btn_buy.SetTip(StringManager.getInstance().getMessageString("CorpsText91"));
         }
         return _loc2_;
      }
      
      private function ShowGoods(param1:int) : void
      {
         this.CanBuy = this.GetCanBuy(param1);
         this.MallItemArray = CorpsMallReader.getInstance().GetMallItemByLevel(param1);
         if(this.MallItemArray == null)
         {
            return;
         }
         this.PageCount = this.MallItemArray.length / this.ROW_COUNT;
         if(this.MallItemArray.length > this.PageCount * this.ROW_COUNT)
         {
            ++this.PageCount;
         }
         this.ShowGoodsCurPage();
      }
      
      private function ShowGoodsCurPage() : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:CorpsMallItem = null;
         var _loc5_:ShipmodelInfo = null;
         var _loc6_:ShipbodyInfo = null;
         var _loc7_:Bitmap = null;
         var _loc8_:MovieClip = null;
         var _loc1_:int = this.PageId * this.ROW_COUNT;
         var _loc2_:int = 0;
         while(_loc2_ < this.ROW_COUNT)
         {
            _loc3_ = this._mc.getMC().getChildByName("mc_plan" + _loc2_) as MovieClip;
            if(_loc1_ < this.MallItemArray.length)
            {
               _loc3_.visible = true;
               _loc3_.gotoAndStop(1);
               _loc4_ = this.MallItemArray[_loc1_];
               TextField(_loc3_.tf_name).text = _loc4_.Name;
               TextField(_loc3_.tf_num).text = _loc4_.ShipSell.toString();
               _loc5_ = CorpsMallReader.getInstance().GetShipModel(_loc4_.ShipModelId);
               _loc6_ = CShipmodelReader.getInstance().getShipBodyInfo(_loc5_.m_BodyId);
               _loc7_ = new Bitmap(GameKernel.getTextureInstance(_loc6_.SmallIcon));
               _loc8_ = _loc3_.mc_base as MovieClip;
               if(_loc8_.numChildren > 0)
               {
                  _loc8_.removeChildAt(0);
               }
               _loc7_.x = -7;
               _loc7_.y = -3;
               _loc8_.addChild(_loc7_);
               _loc3_.filters = this.filter.getFilter(!this.CanBuy);
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc1_++;
            _loc2_++;
         }
      }
      
      private function ShipModulClick(param1:MouseEvent, param2:XButton) : void
      {
         if(this.SelectedModel != null)
         {
            this.SelectedModel.setSelect(false);
         }
         this.SelectedModel = param2;
         this.SelectedModel.setSelect(true);
         var _loc3_:int = this.PageId * this.ROW_COUNT + param2.Data;
         this.SelectedMallItem = this.MallItemArray[_loc3_];
         this.SelectedModelId = this.SelectedMallItem.Id;
         var _loc4_:ShipmodelInfo = CorpsMallReader.getInstance().GetShipModel(this.SelectedMallItem.ShipModelId);
         this.ClearText();
         this.ShowPartList(_loc4_);
      }
      
      private function ShipModulOver(param1:MouseEvent, param2:XButton) : void
      {
         var _loc3_:int = this.PageId * this.ROW_COUNT + param2.Data;
         var _loc4_:CorpsMallItem = this.MallItemArray[_loc3_];
         var _loc5_:ShipmodelInfo = CorpsMallReader.getInstance().GetShipModel(_loc4_.ShipModelId);
         ShipModelInfoTip.GetInstance().ShowModel(_loc5_,param2.m_movie.localToGlobal(new Point(0,param2.m_movie.height)));
      }
      
      private function ShipModulOut(param1:MouseEvent) : void
      {
         ShipModelInfoTip.GetInstance().Hide();
      }
      
      private function ShowPartList(param1:ShipmodelInfo) : void
      {
         var _loc3_:int = 0;
         this.PartList.Clear();
         var _loc2_:int = 0;
         while(_loc2_ < param1.m_PartId.length)
         {
            _loc3_ = 0;
            if(this.PartList.ContainsKey(param1.m_PartId[_loc2_]))
            {
               _loc3_ = this.PartList.Get(param1.m_PartId[_loc2_]);
            }
            _loc3_++;
            this.PartList.Put(param1.m_PartId[_loc2_],_loc3_);
            _loc2_++;
         }
         this.PageCountPart = this.PartList.Length() / 9;
         if(this.PartList.Length() > this.PageCountPart * 9)
         {
            ++this.PageCountPart;
         }
         this.ShowPartListCurPage();
      }
      
      private function ShowPartListCurPage() : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:MovieClip = null;
         var _loc7_:ShippartInfo = null;
         var _loc8_:Bitmap = null;
         var _loc1_:int = this.PageIdPart * 9;
         var _loc2_:int = 0;
         while(_loc2_ < 9)
         {
            _loc3_ = this._mc.getMC().getChildByName("mc_list" + _loc2_) as MovieClip;
            if(_loc1_ < this.PartList.Length())
            {
               _loc3_.gotoAndStop(1);
               _loc4_ = int(this.PartList.Keys()[_loc1_]);
               _loc5_ = this.PartList.Get(_loc4_);
               _loc6_ = _loc3_.mc_base as MovieClip;
               if(_loc6_.numChildren > 0)
               {
                  _loc6_.removeChildAt(0);
               }
               _loc7_ = CShipmodelReader.getInstance().getShipPartInfo(_loc4_);
               _loc8_ = new Bitmap(GameKernel.getTextureInstance(_loc7_.ImageFileName));
               _loc6_.addChild(_loc8_);
               TextField(_loc3_.tf_modulenum).text = _loc5_.toString();
            }
            else
            {
               _loc3_.gotoAndStop(2);
            }
            _loc1_++;
            _loc2_++;
         }
         this.SetPageButtonPart();
      }
      
      private function PartMouseOver(param1:MouseEvent, param2:XMovieClip) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = this.PageIdPart * 9 + param2.Data;
         if(_loc3_ < this.PartList.Length())
         {
            _loc4_ = int(this.PartList.Keys()[_loc3_]);
            ShipPartInfoTip.GetInstance().Show(_loc4_,param2.m_movie.localToGlobal(new Point(-60,param2.m_movie.height)));
         }
      }
      
      private function PartMouseOut(param1:MouseEvent) : void
      {
         ShipPartInfoTip.GetInstance().Hide();
      }
      
      private function CloseClick(param1:MouseEvent) : void
      {
         GameKernel.popUpDisplayManager.Hide(this);
      }
      
      private function btn_frontClick(param1:MouseEvent) : void
      {
         if(this.SelectedMallItem == null)
         {
            return;
         }
         if(GamePlayer.getInstance().ConsortiaThrowValue > this.SelectedMallItem.ShipSell)
         {
            this.tf_num.text = "1";
         }
         this.ShowCountValue();
      }
      
      private function btn_nextClick(param1:MouseEvent) : void
      {
         if(this.SelectedMallItem == null)
         {
            return;
         }
         var _loc2_:int = GamePlayer.getInstance().ConsortiaThrowValue / this.SelectedMallItem.ShipSell;
         this.tf_num.text = _loc2_.toString();
         this.ShowCountValue();
      }
      
      private function ShowCountValue() : void
      {
         this.tf_offernum.text = "";
         if(this.SelectedMallItem == null)
         {
            this.tf_num.text = "";
            return;
         }
         var _loc1_:int = int(this.tf_num.text);
         var _loc2_:int = _loc1_ * this.SelectedMallItem.ShipSell;
         if(_loc2_ > GamePlayer.getInstance().ConsortiaThrowValue)
         {
            this.btn_nextClick(null);
         }
         else
         {
            this.tf_offernum.text = _loc2_.toString();
         }
      }
      
      private function tf_numChange(param1:Event) : void
      {
         this.ShowCountValue();
      }
      
      private function btn_buyClick(param1:MouseEvent) : void
      {
         if(!this.CanBuy)
         {
            return;
         }
         var _loc2_:int = int(this.tf_num.text);
         if(_loc2_ <= 0)
         {
            return;
         }
         var _loc3_:MSG_REQUEST_CONSORTIABUYGOODS = new MSG_REQUEST_CONSORTIABUYGOODS();
         _loc3_.Num = _loc2_;
         _loc3_.GoodsId = this.SelectedModelId;
         _loc3_.SeqId = GamePlayer.getInstance().seqID++;
         _loc3_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc3_);
      }
      
      public function RespBuyGoods(param1:MSG_RESP_CONSORTIABUYGOODS) : void
      {
         if(param1.ErrorCode == 0)
         {
            GamePlayer.getInstance().ConsortiaThrowValue = GamePlayer.getInstance().ConsortiaThrowValue - param1.Price;
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("MailText30"),1);
            if(this.CanBuy == true && this.GetCanBuy(this.SelectedLevelButton.Data) == false)
            {
               this.CanBuy = this.GetCanBuy(this.SelectedLevelButton.Data);
               this.ShowGoodsCurPage();
            }
         }
         else
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("ShipText27"),1);
         }
         this.ClearText();
      }
      
      private function btn_leftClick(param1:MouseEvent) : void
      {
         --this.PageId;
         this.ShowGoodsCurPage();
      }
      
      private function btn_rightClick(param1:MouseEvent) : void
      {
         ++this.PageId;
         this.ShowGoodsCurPage();
      }
      
      private function SetPageButton() : void
      {
         if(this.PageCount == 0)
         {
            this.tf_page.text = "1/1";
            this.btn_left.setBtnDisabled(true);
            this.btn_right.setBtnDisabled(true);
            return;
         }
         if(this.PageId > 0)
         {
            this.btn_left.setBtnDisabled(false);
         }
         else
         {
            this.btn_left.setBtnDisabled(true);
         }
         if(this.PageId + 1 >= this.PageCount)
         {
            this.btn_right.setBtnDisabled(true);
         }
         else
         {
            this.btn_right.setBtnDisabled(false);
         }
         this.tf_page.text = this.PageId + 1 + "/" + this.PageCount;
      }
      
      private function btn_left_partClick(param1:MouseEvent) : void
      {
         --this.PageIdPart;
         this.ShowPartListCurPage();
      }
      
      private function btn_right_partClick(param1:MouseEvent) : void
      {
         ++this.PageIdPart;
         this.ShowPartListCurPage();
      }
      
      private function SetPageButtonPart() : void
      {
         if(this.PageCountPart == 0)
         {
            this.tf_page_part.text = "1/1";
            this.btn_left_part.setBtnDisabled(true);
            this.btn_right_part.setBtnDisabled(true);
            return;
         }
         if(this.PageIdPart > 0)
         {
            this.btn_left_part.setBtnDisabled(false);
         }
         else
         {
            this.btn_left_part.setBtnDisabled(true);
         }
         if(this.PageIdPart + 1 >= this.PageCountPart)
         {
            this.btn_right_part.setBtnDisabled(true);
         }
         else
         {
            this.btn_right_part.setBtnDisabled(false);
         }
         this.tf_page_part.text = this.PageIdPart + 1 + "/" + this.PageCountPart;
      }
   }
}

