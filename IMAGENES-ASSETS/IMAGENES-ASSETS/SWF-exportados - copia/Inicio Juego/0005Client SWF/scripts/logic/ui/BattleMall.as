package logic.ui
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.managers.ResManager;
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.HashSet;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.entry.props.propsInfo;
   import logic.game.GameKernel;
   import logic.game.GameMouseZoneManager;
   import logic.reader.CPropsReader;
   import logic.ui.tip.CustomTip;
   import logic.utils.UpdateResource;
   import net.base.NetManager;
   import net.msg.mall.MSG_REQUEST_BUYGOODS;
   
   public class BattleMall extends AbstractPopUp
   {
      
      private static var instance:BattleMall;
      
      private var ItemCount:int = 9;
      
      private var ItemList:Array;
      
      private var btn_front:HButton;
      
      private var btn_next:HButton;
      
      private var tf_honor:TextField;
      
      private var SelectedItem:XMovieClip;
      
      private var SelectedPage:XButton;
      
      private var SelectedType:int;
      
      private var PageId:int;
      
      private var PageCount:int;
      
      private var PageButtonList:Array;
      
      private var tf_page:TextField;
      
      private var CurPropsList:Array;
      
      private var PropsMap:HashSet;
      
      private var McMallBtnPopup:MovieClip;
      
      private var SelectedProps:propsInfo;
      
      private var MallgoodsPopupMc:MovieClip;
      
      private var ParentLock:Container;
      
      private var BattleHonor:int;
      
      private var MaxNum:int;
      
      private var BuyNum:int;
      
      private var SelectedItemId:int;
      
      public function BattleMall()
      {
         super();
         setPopUpName("BattleMall");
      }
      
      public static function getInstance() : BattleMall
      {
         if(instance == null)
         {
            instance = new BattleMall();
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
         this._mc = new MObject("MallbattlehornorScene",385,300);
         this.initMcElement();
         this.Clear();
         GameKernel.popUpDisplayManager.Regisger(instance);
      }
      
      private function Clear() : void
      {
         this.PageButtonClick(null,this.PageButtonList[0]);
         this.ShowHonor();
      }
      
      public function ShowHonor() : void
      {
         this.tf_honor.text = GamePlayer.getInstance().WarScoreExchange.toString();
      }
      
      override public function initMcElement() : void
      {
         var _loc1_:HButton = null;
         var _loc2_:MovieClip = null;
         var _loc5_:XML = null;
         var _loc6_:MovieClip = null;
         var _loc7_:XMovieClip = null;
         var _loc8_:Object = null;
         var _loc9_:Array = null;
         _loc2_ = this._mc.getMC().getChildByName("btn_close") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.CloseClick);
         this.PageButtonList = new Array();
         this.PageButtonList.push(this.CreatePageButton("btn_allgoods",0));
         this.PageButtonList.push(this.CreatePageButton("btn_exspend",1));
         this.PageButtonList.push(this.CreatePageButton("btn_battle",2));
         this.PageButtonList.push(this.CreatePageButton("btn_gem",3));
         this.PageButtonList.push(this.CreatePageButton("btn_remaining0",4));
         this.PageButtonList.push(this.CreatePageButton("btn_remaining1",5));
         _loc2_ = this._mc.getMC().getChildByName("btn_front") as MovieClip;
         this.btn_front = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_frontClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_next") as MovieClip;
         this.btn_next = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_nextClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_bag") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_bagClick);
         this.tf_honor = this._mc.getMC().getChildByName("tf_honor") as TextField;
         this.tf_page = this._mc.getMC().getChildByName("tf_page") as TextField;
         this.ItemList = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < this.ItemCount)
         {
            _loc6_ = GameKernel.getMovieClipInstance("MallbattlegoodsPlan");
            _loc7_ = new XMovieClip(_loc6_);
            _loc7_.Data = _loc3_;
            _loc7_.OnMouseOver = this.ItemOver;
            _loc7_.OnClick = this.ItemClick;
            _loc6_.addEventListener(MouseEvent.MOUSE_OUT,this.ItemOut);
            _loc6_.stop();
            _loc2_ = this._mc.getMC().getChildByName("mc_base" + _loc3_) as MovieClip;
            _loc2_.addChild(_loc6_);
            this.ItemList.push(_loc6_);
            _loc3_++;
         }
         this.McMallBtnPopup = GameKernel.getMovieClipInstance("MallBtnPopup");
         _loc2_ = this.McMallBtnPopup.getChildByName("btn_buy") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_buyClick);
         _loc2_ = this.McMallBtnPopup.getChildByName("btn_gift") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_giftClick);
         _loc1_.setBtnDisabled(true);
         this.InitMallgoodsPopup();
         this.PropsMap = new HashSet();
         var _loc4_:XML = GameKernel.resManager.getXml(ResManager.GAMERES,"BattleShop");
         for each(_loc5_ in _loc4_.*)
         {
            _loc8_ = new Object();
            _loc8_.KindId = int(_loc5_.@KindID);
            _loc8_.Name = String(_loc5_.@Name);
            _loc8_.PropsId = int(_loc5_.@PropsId);
            _loc8_.BattleHonor = int(_loc5_.@BattleHonor);
            _loc9_ = this.PropsMap.GetValue(_loc8_.KindId);
            if(_loc9_ == null)
            {
               _loc9_ = new Array();
               this.PropsMap.Put(_loc8_.KindId,_loc9_);
               XButton(this.PageButtonList[_loc8_.KindId]).setBtnDisabled(false);
            }
            _loc9_.push(_loc8_);
         }
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
         _loc1_.visible = false;
         _loc1_ = this.MallgoodsPopupMc.getChildByName("radiocash") as MovieClip;
         var _loc3_:HButton = new HButton(_loc1_);
         _loc3_.setSelect(true);
         MovieClip(this.MallgoodsPopupMc.getChildByName("mc_money")).visible = false;
         TextField(this.MallgoodsPopupMc.tf_num).maxChars = 4;
         TextField(this.MallgoodsPopupMc.tf_num).restrict = "0-9";
         TextField(this.MallgoodsPopupMc.tf_num).text = "1";
         TextField(this.MallgoodsPopupMc.tf_num).addEventListener(Event.CHANGE,this.tf_numChange);
      }
      
      private function tf_numChange(param1:Event) : void
      {
         var _loc2_:int = 0;
         if(TextField(this.MallgoodsPopupMc.tf_num).text == "")
         {
            TextField(this.MallgoodsPopupMc.tf_allprice).text = "";
            return;
         }
         this.BuyNum = int(TextField(this.MallgoodsPopupMc.tf_num).text);
         if(this.MaxNum > 0 && this.BuyNum > this.MaxNum)
         {
            this.BuyNum = this.MaxNum;
            TextField(this.MallgoodsPopupMc.tf_num).text = this.BuyNum.toString();
         }
         _loc2_ = this.BuyNum * this.BattleHonor;
         TextField(this.MallgoodsPopupMc.tf_allprice).text = _loc2_.toString();
      }
      
      private function BuyClick(param1:MouseEvent) : void
      {
         if(this.BuyNum <= 0)
         {
            return;
         }
         this.SelectedProps = this.GetSelectedGoodInfo(this.SelectedItemId);
         var _loc2_:int = 1;
         var _loc3_:int = UpdateResource.getInstance().HasPackSpace(this.SelectedProps.Id,_loc2_,this.BuyNum);
         if(_loc3_ == 1)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CommanderText12"),10);
            return;
         }
         if(_loc3_ == 2)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("BattleTXT11"),0);
            return;
         }
         var _loc4_:MSG_REQUEST_BUYGOODS = new MSG_REQUEST_BUYGOODS();
         _loc4_.PropsId = this.SelectedProps.Id;
         _loc4_.Type = 4;
         _loc4_.Num = this.BuyNum;
         _loc4_.SeqId = GamePlayer.getInstance().seqID++;
         _loc4_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc4_);
         this.HideMallgoodsPopup();
      }
      
      private function cancelClick(param1:MouseEvent) : void
      {
         this.HideMallgoodsPopup();
      }
      
      private function HideMallgoodsPopup() : void
      {
         this.ParentLock.removeChild(this.MallgoodsPopupMc);
         GameKernel.renderManager.getUI().removeComponent(this.ParentLock);
      }
      
      private function btn_giftClick(param1:MouseEvent) : void
      {
      }
      
      private function btn_buyClick(param1:MouseEvent) : void
      {
         if(this.SelectedProps == null)
         {
            return;
         }
         if(this.MaxNum <= 0)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss171"),0);
            return;
         }
         this.ShowMallgoodsPopup(this.SelectedProps);
         this.HideMcMallBtnPopup();
      }
      
      private function ShowMallgoodsPopup(param1:propsInfo) : void
      {
         var _loc2_:TextField = this.MallgoodsPopupMc.getChildByName("tf_num") as TextField;
         _loc2_.text = "1";
         this.BuyNum = 1;
         _loc2_ = this.MallgoodsPopupMc.getChildByName("tf_allprice") as TextField;
         _loc2_.text = this.BattleHonor.toString();
         TextField(this.MallgoodsPopupMc.tf_name).text = param1.Name;
         TextField(this.MallgoodsPopupMc.tf_detail).htmlText = param1.Comment;
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
      
      private function btn_bagClick(param1:MouseEvent) : void
      {
         GameKernel.popUpDisplayManager.Hide(this);
         GameMouseZoneManager.NagivateToolBarByName("btn_storage",true);
      }
      
      private function btn_nextClick(param1:MouseEvent) : void
      {
         ++this.PageId;
         this.ShowProps();
      }
      
      private function btn_frontClick(param1:MouseEvent) : void
      {
         --this.PageId;
         this.ShowProps();
      }
      
      private function CreatePageButton(param1:String, param2:int) : XButton
      {
         var _loc3_:XButton = null;
         var _loc4_:MovieClip = this._mc.getMC().getChildByName(param1) as MovieClip;
         _loc3_ = new XButton(_loc4_);
         _loc3_.Data = param2;
         _loc3_.OnClick = this.PageButtonClick;
         _loc3_.setBtnDisabled(true);
         return _loc3_;
      }
      
      private function PageButtonClick(param1:MouseEvent, param2:XButton) : void
      {
         var _loc3_:Array = this.PropsMap.GetValue(param2.Data);
         if(_loc3_ == null)
         {
            return;
         }
         if(this.SelectedPage)
         {
            this.SelectedPage.setSelect(false);
         }
         this.SelectedPage = param2;
         this.SelectedPage.setSelect(true);
         this.CurPropsList = _loc3_;
         this.SelectedType = param2.Data;
         this.PageId = 0;
         this.PageCount = Math.ceil(this.CurPropsList.length / this.ItemCount);
         this.ShowProps();
      }
      
      private function ShowProps() : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:Object = null;
         var _loc5_:Bitmap = null;
         var _loc6_:MovieClip = null;
         var _loc1_:int = this.PageId * this.ItemCount;
         var _loc2_:int = 0;
         while(_loc2_ < this.ItemCount)
         {
            _loc3_ = this.ItemList[_loc2_];
            if(_loc1_ < this.CurPropsList.length)
            {
               _loc3_.visible = true;
               _loc4_ = this.CurPropsList[_loc1_];
               TextField(_loc3_.tf_num).text = int(_loc4_.BattleHonor).toString();
               if(_loc4_.PropsInfo == null)
               {
                  _loc4_.PropsInfo = CPropsReader.getInstance().GetPropsInfo(_loc4_.PropsId);
               }
               TextField(_loc3_.f_name).text = _loc4_.PropsInfo.Name;
               _loc5_ = new Bitmap(GameKernel.getTextureInstance(_loc4_.PropsInfo.ImageFileName));
               _loc6_ = _loc3_.getChildByName("mc_base") as MovieClip;
               if(_loc6_.numChildren > 0)
               {
                  _loc6_.removeChildAt(0);
               }
               _loc6_.addChild(_loc5_);
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc1_++;
            _loc2_++;
         }
         this.ResetPageButton();
      }
      
      private function ResetPageButton() : void
      {
         this.btn_front.setBtnDisabled(this.PageId == 0);
         this.btn_next.setBtnDisabled(this.PageId + 1 >= this.PageCount);
         this.tf_page.text = this.PageId + 1 + "/" + this.PageCount;
      }
      
      private function HideMcMallBtnPopup() : void
      {
         if(this._mc.getMC().contains(this.McMallBtnPopup))
         {
            this._mc.getMC().removeChild(this.McMallBtnPopup);
         }
      }
      
      private function ItemClick(param1:MouseEvent, param2:XMovieClip) : void
      {
         CustomTip.GetInstance().Hide();
         var _loc3_:DisplayObject = param1.target as DisplayObject;
         var _loc4_:Point = _loc3_.localToGlobal(new Point(param1.localX,param1.localY));
         _loc4_ = this._mc.getMC().globalToLocal(_loc4_);
         this.McMallBtnPopup.x = _loc4_.x;
         this.McMallBtnPopup.y = _loc4_.y;
         this._mc.getMC().addChild(this.McMallBtnPopup);
         this.SelectedItemId = param2.Data;
      }
      
      private function ItemOver(param1:MouseEvent, param2:XMovieClip) : void
      {
         this.HideMcMallBtnPopup();
         if(this.SelectedItem)
         {
            this.SelectedItem.m_movie.gotoAndStop(1);
         }
         this.SelectedItem = param2;
         this.SelectedItem.m_movie.gotoAndStop(2);
         this.SelectedProps = this.GetSelectedGoodInfo(param2.Data);
         var _loc3_:Point = this.SelectedItem.m_movie.localToGlobal(new Point(0,70));
         CustomTip.GetInstance().Show(this.SelectedProps.Comment,_loc3_);
      }
      
      private function GetSelectedGoodInfo(param1:int) : propsInfo
      {
         var _loc2_:Object = null;
         param1 += this.PageId * this.ItemCount;
         if(param1 < this.CurPropsList.length)
         {
            _loc2_ = this.CurPropsList[param1];
            this.BattleHonor = _loc2_.BattleHonor;
            this.MaxNum = GamePlayer.getInstance().WarScoreExchange / this.BattleHonor;
            return _loc2_.PropsInfo;
         }
         return null;
      }
      
      private function ItemOut(param1:MouseEvent) : void
      {
         CustomTip.GetInstance().Hide();
         if(this.SelectedItem)
         {
            this.SelectedItem.m_movie.gotoAndStop(1);
         }
      }
      
      private function CloseClick(param1:MouseEvent) : void
      {
         GameKernel.popUpDisplayManager.Hide(this);
      }
   }
}

