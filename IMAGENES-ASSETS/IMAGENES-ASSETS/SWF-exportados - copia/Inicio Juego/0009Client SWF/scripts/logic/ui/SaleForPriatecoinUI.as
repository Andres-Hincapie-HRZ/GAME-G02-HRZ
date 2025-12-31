package logic.ui
{
   import com.star.frameworks.managers.StringManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.entry.ScienceSystem;
   import logic.entry.props.PackPropsInfo;
   import logic.entry.props.propsInfo;
   import logic.game.GameKernel;
   import logic.reader.CPropsReader;
   import logic.ui.tip.CustomTip;
   import logic.utils.UpdateResource;
   import net.base.NetManager;
   import net.msg.ChipLottery.MSG_REQUEST_SELLPROPS;
   
   public class SaleForPriatecoinUI extends AbstractPopUp
   {
      
      private static var instance:SaleForPriatecoinUI;
      
      private var BaseMc:Sprite;
      
      private var btn_res:HButton;
      
      private var btn_uppage:HButton;
      
      private var btn_downpage:HButton;
      
      private var tf_page:TextField;
      
      private var tf_cash:TextField;
      
      private var tf_num:TextField;
      
      private var btn_all:HButton;
      
      private var CardList:Array;
      
      private var PaperList:Array;
      
      private var PageCount:int;
      
      private var PageId:int;
      
      private var PropsCount:int;
      
      private var SelectedType:int;
      
      private var SelectedProps:XMovieClip;
      
      private var SelectedSaleItem:XMovieClip;
      
      private var DropMc:Sprite;
      
      private var DropBitmap:Bitmap;
      
      private var LastSelected:XMovieClip;
      
      private var SelectedPropsInfo:PackPropsInfo;
      
      private var SelectedSaleInfo:PackPropsInfo;
      
      private var SaleList:Array;
      
      private var SelectedItemId:int;
      
      private var SaleCoins:int;
      
      private var SellMsg:MSG_REQUEST_SELLPROPS;
      
      public var SaleCount:int;
      
      public function SaleForPriatecoinUI()
      {
         super();
         setPopUpName("SaleForPriatecoinUI");
      }
      
      public static function getInstance() : SaleForPriatecoinUI
      {
         if(instance == null)
         {
            instance = new SaleForPriatecoinUI();
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
         this._mc = new MObject("MallStorageScene",385,300);
         this.initMcElement();
         this.CardList = new Array();
         this.PaperList = new Array();
         this.SellMsg = new MSG_REQUEST_SELLPROPS();
         this.Clear();
         GameKernel.popUpDisplayManager.Regisger(instance);
      }
      
      override public function initMcElement() : void
      {
         var _loc1_:HButton = null;
         var _loc4_:XMovieClip = null;
         var _loc5_:XMovieClip = null;
         this.BaseMc = this._mc.getMC();
         _loc1_ = new HButton(this.BaseMc.getChildByName("btn_close") as MovieClip);
         _loc1_.m_movie.addEventListener(MouseEvent.CLICK,this.btn_closeClick);
         _loc1_ = new HButton(this.BaseMc.getChildByName("btn_sale") as MovieClip);
         _loc1_.m_movie.addEventListener(MouseEvent.CLICK,this.btn_saleClick);
         this.btn_res = new HButton(this.BaseMc.getChildByName("btn_res") as MovieClip);
         this.btn_res.SetTip(StringManager.getInstance().getMessageString("BagTXT06"));
         this.btn_res.m_movie.addEventListener(MouseEvent.CLICK,this.btn_resClick);
         this.btn_all = new HButton(this.BaseMc.getChildByName("btn_all") as MovieClip);
         this.btn_all.SetTip(StringManager.getInstance().getMessageString("BagTXT08"));
         this.btn_all.m_movie.addEventListener(MouseEvent.CLICK,this.btn_allClick);
         this.btn_uppage = new HButton(this.BaseMc.getChildByName("btn_uppage") as MovieClip);
         this.btn_uppage.m_movie.addEventListener(MouseEvent.CLICK,this.btn_uppageClick);
         this.btn_downpage = new HButton(this.BaseMc.getChildByName("btn_downpage") as MovieClip);
         this.btn_downpage.m_movie.addEventListener(MouseEvent.CLICK,this.btn_downpageClick);
         this.tf_page = this.BaseMc.getChildByName("tf_page") as TextField;
         this.tf_cash = this.BaseMc.getChildByName("tf_cash") as TextField;
         this.tf_num = this.BaseMc.getChildByName("tf_num") as TextField;
         var _loc2_:int = 0;
         while(_loc2_ < 20)
         {
            _loc4_ = new XMovieClip(this.BaseMc.getChildByName("mc_storagebase" + _loc2_) as MovieClip);
            _loc4_.m_movie.gotoAndStop(1);
            _loc4_.Data = _loc2_;
            _loc4_.OnMouseOver = this.SaleItemOver;
            _loc4_.OnMouseDown = this.SaleItemClick;
            _loc4_.m_movie.addEventListener(MouseEvent.MOUSE_OUT,this.aPropsOut);
            _loc2_++;
         }
         var _loc3_:int = 0;
         while(_loc3_ < 25)
         {
            _loc5_ = new XMovieClip(this.BaseMc.getChildByName("mc_base" + _loc3_) as MovieClip);
            _loc5_.m_movie.gotoAndStop(1);
            _loc5_.Data = _loc3_;
            _loc5_.OnMouseOver = this.aPropsOver;
            _loc5_.OnMouseDown = this.aPropsClick;
            _loc5_.m_movie.addEventListener(MouseEvent.MOUSE_OUT,this.aPropsOut);
            _loc3_++;
         }
         this.BaseMc.addEventListener(MouseEvent.MOUSE_MOVE,this.BaseMcMove);
         this.DropMc = new Sprite();
         this.DropBitmap = new Bitmap();
         this.DropBitmap.x = -22;
         this.DropBitmap.y = -22;
         this.DropMc.addChild(this.DropBitmap);
         this.DropMc.addEventListener(MouseEvent.MOUSE_UP,this.DropMcUp);
         this.DropMc.visible = false;
         this.BaseMc.addChild(this.DropMc);
         this.SaleList = new Array();
      }
      
      public function Clear() : void
      {
         var _loc2_:propsInfo = null;
         var _loc3_:PackPropsInfo = null;
         this.Invalid(true);
         this.SaleList.splice(0);
         this.CardList.splice(0);
         this.PaperList.splice(0);
         var _loc1_:uint = 0;
         while(_loc1_ < ScienceSystem.getinstance().Packarr.length)
         {
            _loc2_ = CPropsReader.getInstance().GetPropsInfo(ScienceSystem.getinstance().Packarr[_loc1_].PropsId);
            if(_loc2_.PackID == 1 || _loc2_.PackID == 0)
            {
               _loc3_ = new PackPropsInfo();
               _loc3_.Id = _loc2_.Id;
               _loc3_.LockFlag = ScienceSystem.getinstance().Packarr[_loc1_].LockFlag;
               _loc3_.Num = ScienceSystem.getinstance().Packarr[_loc1_].PropsNum;
               _loc3_._PropsInfo = _loc2_;
               if(_loc2_.PackID == 1)
               {
                  this.CardList.push(_loc3_);
               }
               else
               {
                  this.PaperList.push(_loc3_);
               }
            }
            else if(_loc2_.CostPirateCoin > 0)
            {
               _loc3_ = new PackPropsInfo();
               _loc3_.Id = _loc2_.Id;
               _loc3_.LockFlag = ScienceSystem.getinstance().Packarr[_loc1_].LockFlag;
               _loc3_.Num = ScienceSystem.getinstance().Packarr[_loc1_].PropsNum;
               _loc3_._PropsInfo = _loc2_;
               this.PaperList.push(_loc3_);
            }
            _loc1_++;
         }
         this.ShowSaleList();
         this.tf_num.text = "";
         this.btn_allClick(null);
         this.LastSelected = null;
      }
      
      private function ShowCurPage() : void
      {
         var _loc3_:MovieClip = null;
         var _loc1_:int = this.PageId * 25;
         var _loc2_:int = 0;
         while(_loc2_ < 25)
         {
            _loc3_ = this.BaseMc.getChildByName("mc_base" + _loc2_) as MovieClip;
            if(_loc1_ < this.PropsCount)
            {
               _loc3_.visible = true;
               _loc3_.gotoAndStop(1);
               if(this.SelectedType == 0)
               {
                  if(_loc1_ < this.PaperList.length)
                  {
                     this.ShowProps(this.PaperList[_loc1_],_loc3_);
                  }
               }
               else if(_loc1_ < this.CardList.length)
               {
                  this.ShowProps(this.CardList[_loc1_],_loc3_);
               }
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc1_++;
            _loc2_++;
         }
      }
      
      private function ShowProps(param1:PackPropsInfo, param2:MovieClip) : void
      {
         var _loc3_:Sprite = Sprite(param2.mc_base);
         if(_loc3_.numChildren > 0)
         {
            _loc3_.removeChildAt(0);
         }
         _loc3_.addChildAt(new Bitmap(GameKernel.getTextureInstance(param1._PropsInfo.ImageFileName)),0);
         Sprite(param2.mc_lock).visible = param1.LockFlag == 1;
         TextField(param2.tf_num).text = param1.Num.toString();
      }
      
      private function btn_closeClick(param1:MouseEvent) : void
      {
         GameKernel.popUpDisplayManager.Hide(this);
      }
      
      private function btn_saleClick(param1:MouseEvent) : void
      {
         var _loc2_:PackPropsInfo = null;
         if(this.SaleCoins <= 0)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss71"),0);
            return;
         }
         this.Invalid(false);
         this.SaleCount = this.SaleList.length;
         for each(_loc2_ in this.SaleList)
         {
            this.SellMsg.Type = 0;
            this.SellMsg.Id = _loc2_.Id;
            this.SellMsg.SeqId = GamePlayer.getInstance().seqID++;
            this.SellMsg.Guid = GamePlayer.getInstance().Guid;
            this.SellMsg.Num = _loc2_.Num;
            this.SellMsg.LockFlag = _loc2_.LockFlag;
            NetManager.Instance().sendObject(this.SellMsg);
            UpdateResource.getInstance().DeleteProps(_loc2_.Id,_loc2_.LockFlag,_loc2_.Num);
         }
         this.SaleCoins = 0;
         this.SaleList.splice(0);
      }
      
      private function ResetPageCount() : void
      {
         if(this.SelectedType == 0)
         {
            this.PropsCount = this.PaperList.length;
         }
         else
         {
            this.PropsCount = this.CardList.length;
         }
         this.PageCount = Math.ceil(this.PropsCount / 25);
         this.ResetPageButton();
      }
      
      private function ResetPageButton() : void
      {
         this.btn_uppage.setBtnDisabled(this.PageId == 0);
         this.btn_downpage.setBtnDisabled(this.PageId + 1 >= this.PageCount);
         this.tf_page.text = int(this.PageId + 1) + "/" + this.PageCount;
      }
      
      private function btn_allClick(param1:MouseEvent) : void
      {
         this.btn_all.setSelect(true);
         this.btn_res.setSelect(false);
         this.PageId = 0;
         this.SelectedType = 1;
         this.ResetPageCount();
         this.ShowCurPage();
      }
      
      private function btn_resClick(param1:MouseEvent) : void
      {
         this.btn_all.setSelect(false);
         this.btn_res.setSelect(true);
         this.PageId = 0;
         this.SelectedType = 0;
         this.ResetPageCount();
         this.ShowCurPage();
      }
      
      private function btn_downpageClick(param1:MouseEvent) : void
      {
         ++this.PageId;
         this.ResetPageCount();
         this.ShowCurPage();
      }
      
      private function btn_uppageClick(param1:MouseEvent) : void
      {
         --this.PageId;
         this.ResetPageCount();
         this.ShowCurPage();
      }
      
      private function SaleItemClick(param1:MouseEvent, param2:XMovieClip) : void
      {
         if(param2.Data >= this.SaleList.length)
         {
            return;
         }
         if(this.SelectedSaleItem != null)
         {
            this.SelectedSaleItem.m_movie.gotoAndStop(1);
         }
         this.SelectedSaleItem = param2;
         this.SelectedSaleItem.m_movie.gotoAndStop(5);
         this.LastSelected = this.SelectedSaleItem;
      }
      
      private function SaleItemOver(param1:MouseEvent, param2:XMovieClip) : void
      {
         if(param2.Data >= this.SaleList.length)
         {
            return;
         }
         var _loc3_:PackPropsInfo = this.SaleList[param2.Data];
         this.ShwoTip(_loc3_,param2.m_movie);
      }
      
      private function aPropsOut(param1:MouseEvent) : void
      {
         CustomTip.GetInstance().Hide();
      }
      
      private function aPropsClick(param1:MouseEvent, param2:XMovieClip) : void
      {
         if(this.SelectedProps != null)
         {
            this.SelectedProps.m_movie.gotoAndStop(1);
         }
         this.SelectedProps = param2;
         this.SelectedProps.m_movie.gotoAndStop(5);
         this.LastSelected = this.SelectedProps;
      }
      
      private function aPropsOver(param1:MouseEvent, param2:XMovieClip) : void
      {
         var _loc3_:PackPropsInfo = this.GetSelectedProps(param2);
         this.ShwoTip(_loc3_,param2.m_movie);
      }
      
      private function GetSelectedProps(param1:XMovieClip) : PackPropsInfo
      {
         var _loc3_:PackPropsInfo = null;
         var _loc2_:int = this.PageId * 25 + param1.Data;
         if(this.SelectedType == 0)
         {
            _loc3_ = this.PaperList[_loc2_];
         }
         else
         {
            _loc3_ = this.CardList[_loc2_];
         }
         return _loc3_;
      }
      
      private function BaseMcMove(param1:MouseEvent) : void
      {
         if(param1.buttonDown == false)
         {
            return;
         }
         if(this.LastSelected != null)
         {
            this.DropMc.visible = true;
            this.DropBitmap.bitmapData = Bitmap(Sprite(this.LastSelected.m_movie.mc_base).getChildAt(0)).bitmapData;
            this.DropMc.startDrag(true);
         }
      }
      
      private function DropMcUp(param1:MouseEvent) : void
      {
         this.DropMc.stopDrag();
         this.DropMc.visible = false;
         if(this.LastSelected == this.SelectedProps)
         {
            if(this.DropMc.x >= -245 && this.DropMc.x < 0 && this.DropMc.y > -100 && this.DropMc.y < 99)
            {
               this.AddToSale();
            }
         }
         else if(this.DropMc.x >= 20 && this.DropMc.x < 268 && this.DropMc.y > -100 && this.DropMc.y < 146)
         {
            this.RemoveFromSaleList();
         }
         this.LastSelected = null;
      }
      
      private function RemoveFromSaleList() : void
      {
         this.SelectedSaleInfo = this.SaleList[this.SelectedSaleItem.Data];
         FleetNumUI.getInstance().Show(this.BaseMc as MovieClip,this.SelectedSaleInfo.Num,this.RemoveFromSaleListCallback,StringManager.getInstance().getMessageString("FormationText3"));
      }
      
      private function RemoveFromSaleListCallback(param1:int) : void
      {
         this.AddSaleItem(this.SelectedSaleInfo,-param1);
         if(this.SelectedSaleInfo._PropsInfo.PackID == 1)
         {
            this.AddProps(this.CardList,this.SelectedSaleInfo,param1);
         }
         else
         {
            this.AddProps(this.PaperList,this.SelectedSaleInfo,param1);
         }
         this.ResetPageCount();
         this.ShowCurPage();
      }
      
      private function AddProps(param1:Array, param2:PackPropsInfo, param3:int) : void
      {
         var _loc4_:PackPropsInfo = null;
         var _loc5_:PackPropsInfo = null;
         for each(_loc4_ in param1)
         {
            if(_loc4_.Id == param2.Id && _loc4_.LockFlag == param2.LockFlag)
            {
               _loc4_.Num += param3;
               return;
            }
         }
         _loc5_ = new PackPropsInfo();
         _loc5_.Id = param2.Id;
         _loc5_.LockFlag = param2.LockFlag;
         _loc5_._PropsInfo = param2._PropsInfo;
         _loc5_.Num = param3;
         param1.push(_loc5_);
      }
      
      private function AddToSale() : void
      {
         if(this.SaleList.length == 20)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss72"),0);
            return;
         }
         this.SelectedPropsInfo = this.GetSelectedProps(this.SelectedProps);
         this.SelectedItemId = this.PageId * 25 + this.SelectedProps.Data;
         FleetNumUI.getInstance().Show(this.BaseMc as MovieClip,this.SelectedPropsInfo.Num,this.AddToSaleCallback,StringManager.getInstance().getMessageString("FormationText3"));
      }
      
      private function AddToSaleCallback(param1:int) : void
      {
         this.SelectedPropsInfo.Num -= param1;
         if(this.SelectedPropsInfo.Num == 0)
         {
            if(this.SelectedType == 0)
            {
               this.PaperList.splice(this.SelectedItemId,1);
            }
            else
            {
               this.CardList.splice(this.SelectedItemId,1);
            }
         }
         this.ResetPageCount();
         this.ShowCurPage();
         this.AddSaleItem(this.SelectedPropsInfo,param1);
      }
      
      private function AddSaleItem(param1:PackPropsInfo, param2:int) : void
      {
         var _loc5_:PackPropsInfo = null;
         var _loc3_:int = 0;
         while(_loc3_ < this.SaleList.length)
         {
            _loc5_ = this.SaleList[_loc3_];
            if(_loc5_.Id == param1.Id && _loc5_.LockFlag == param1.LockFlag)
            {
               _loc5_.Num += param2;
               if(_loc5_.Num == 0)
               {
                  this.SaleList.splice(_loc3_,1);
               }
               this.ShowSaleList();
               return;
            }
            _loc3_++;
         }
         if(param2 > 0 && this.SaleList.length == 20)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss72"),0);
            return;
         }
         var _loc4_:PackPropsInfo = new PackPropsInfo();
         _loc4_.Id = param1.Id;
         _loc4_.LockFlag = param1.LockFlag;
         _loc4_._PropsInfo = param1._PropsInfo;
         _loc4_.Num = param2;
         this.SaleList.push(_loc4_);
         this.ShowSaleList();
      }
      
      private function ShowSaleList() : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:PackPropsInfo = null;
         var _loc4_:* = 0;
         this.SaleCoins = 0;
         var _loc1_:int = 0;
         while(_loc1_ < 20)
         {
            _loc2_ = this.BaseMc.getChildByName("mc_storagebase" + _loc1_) as MovieClip;
            Sprite(_loc2_.mc_lock).visible = false;
            TextField(_loc2_.tf_num).text = "";
            Sprite(_loc2_.mc_base).visible = false;
            _loc2_.gotoAndStop(1);
            if(_loc1_ < this.SaleList.length)
            {
               this.ShowProps(this.SaleList[_loc1_],_loc2_);
               Sprite(_loc2_.mc_base).visible = true;
               _loc3_ = this.SaleList[_loc1_];
               _loc4_ = 1;
               if(_loc3_._PropsInfo.PackID == 1)
               {
                  _loc4_ = 1 << _loc3_._PropsInfo.Id % 9;
               }
               this.SaleCoins += _loc4_ * _loc3_._PropsInfo.CostPirateCoin * _loc3_.Num;
            }
            _loc1_++;
         }
         this.tf_num.text = this.SaleCoins.toString();
      }
      
      private function ShwoTip(param1:PackPropsInfo, param2:MovieClip) : void
      {
         var _loc3_:* = 1;
         if(param1._PropsInfo.PackID == 1)
         {
            _loc3_ = 1 << param1._PropsInfo.Id % 9;
         }
         var _loc4_:* = "<font color=\'#ccba7a\'>" + StringManager.getInstance().getMessageString("MailText17") + "</font><font color=\'#00ff00\'>" + param1._PropsInfo.Name + "</font><br/>";
         _loc4_ = _loc4_ + ("<font color=\'#ccba7a\'>" + StringManager.getInstance().getMessageString("Boss73") + "</font><font color=\'#00ff00\'>" + int(_loc3_ * param1._PropsInfo.CostPirateCoin).toString() + StringManager.getInstance().getMessageString("Boss63") + "</font>");
         var _loc5_:Point = param2.localToGlobal(new Point(-20,param2.height - 25));
         CustomTip.GetInstance().Show(_loc4_,_loc5_);
      }
      
      public function SetPriateCoins(param1:int) : void
      {
         this.tf_cash.text = param1.toString();
      }
   }
}

