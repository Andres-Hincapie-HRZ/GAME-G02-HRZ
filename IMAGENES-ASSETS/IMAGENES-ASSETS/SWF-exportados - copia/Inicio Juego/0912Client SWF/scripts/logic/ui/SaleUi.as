package logic.ui
{
   import com.star.frameworks.managers.StringManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import logic.action.ConstructionAction;
   import logic.entry.EquimentTypeEnum;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.entry.props.propsInfo;
   import logic.game.GameKernel;
   import logic.reader.CPropsReader;
   import net.base.NetManager;
   import net.msg.mall.MSG_REQUEST_TRADEGOODS;
   
   public class SaleUi extends AbstractPopUp
   {
      
      private static var instance:SaleUi;
      
      private var content:MovieClip;
      
      private var obj:Object = new Object();
      
      private var bit:Bitmap;
      
      private var SelectedType:int;
      
      private var timint:int;
      
      private var xtf_oneprice:XTextField;
      
      private var sxf:int = 0;
      
      private var btn_sellout:HButton;
      
      private var tip:MovieClip;
      
      public function SaleUi()
      {
         super();
         setPopUpName("SaleUi");
      }
      
      public static function getInstance() : SaleUi
      {
         if(instance == null)
         {
            instance = new SaleUi();
         }
         return instance;
      }
      
      override public function Init() : void
      {
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            return;
         }
         this._mc = new MObject("saleMc",380,320);
         this.initMcElement();
         GameKernel.popUpDisplayManager.Regisger(instance);
      }
      
      override public function initMcElement() : void
      {
         this.content = this._mc.getMC();
         var _loc1_:HButton = new HButton(this.content.btn_close);
         _loc1_.m_movie.addEventListener(MouseEvent.CLICK,this.closeHd);
         TextField(this.content.tf_shipnum).restrict = "0-9";
         TextField(this.content.tf_oneprice).restrict = "0-9";
         TextField(this.content.tf_price).text = "";
         TextField(this.content.tf_charge).text = "";
         this.content.radiogold.gotoAndStop(1);
         this.content.radiocash.gotoAndStop(2);
         this.content.radiogold.ss = 1;
         this.content.radiocash.ss = 0;
         this.SelectedType = 0;
         this.content.radiotime1.gotoAndStop(2);
         this.content.radiotime2.gotoAndStop(1);
         this.content.radiotime3.gotoAndStop(1);
         this.timint = 0;
         this.content.radiogold.addEventListener(MouseEvent.CLICK,this.selectHd);
         this.content.radiocash.addEventListener(MouseEvent.CLICK,this.selectHd);
         var _loc2_:uint = 1;
         while(_loc2_ <= 3)
         {
            this.content["radiotime" + _loc2_].dd = _loc2_;
            this.content["radiotime" + _loc2_].ss = 3;
            this.content["radiotime" + _loc2_].addEventListener(MouseEvent.CLICK,this.selectHd);
            _loc2_++;
         }
         TextField(this.content.tf_oneprice).maxChars = 8;
         TextField(this.content.tf_oneprice).addEventListener(Event.CHANGE,this.changeHd);
         this.xtf_oneprice = new XTextField(TextField(this.content.tf_oneprice),StringManager.getInstance().getMessageString("AuctionText38"));
         TextField(this.content.tf_shipnum).addEventListener(Event.CHANGE,this.nunchanggeHd);
         this.btn_sellout = new HButton(this.content.btn_sellout);
         this.btn_sellout.setBtnDisabled(true);
         this.btn_sellout.m_movie.addEventListener(MouseEvent.CLICK,this.selloutHd);
         this.content.mc_shipbase.addEventListener(MouseEvent.ROLL_OVER,this.rooHd);
         this.content.mc_shipbase.addEventListener(MouseEvent.ROLL_OUT,this.rouHd);
      }
      
      private function selectHd(param1:MouseEvent) : void
      {
         if(param1.currentTarget.ss == 1)
         {
            if(this.SelectedType == 1)
            {
               return;
            }
            this.SelectedType = 1;
            param1.currentTarget.gotoAndStop(2);
            this.content.radiocash.gotoAndStop(1);
            this.ppsd();
            return;
         }
         if(param1.currentTarget.ss == 0)
         {
            if(this.SelectedType == 0)
            {
               return;
            }
            this.SelectedType = 0;
            param1.currentTarget.gotoAndStop(2);
            this.content.radiogold.gotoAndStop(1);
            this.ppsd();
            return;
         }
         if(param1.currentTarget.ss == 3)
         {
            if(param1.currentTarget.dd == 1)
            {
               if(this.timint == 0)
               {
                  return;
               }
               this.timint = 0;
               this.cgou();
               this.content["radiotime" + 1].gotoAndStop(2);
               this.ppsd();
               return;
            }
            if(param1.currentTarget.dd == 2)
            {
               if(this.timint == 1)
               {
                  return;
               }
               this.timint = 1;
               this.cgou();
               this.content["radiotime" + 2].gotoAndStop(2);
               this.ppsd();
               return;
            }
            if(param1.currentTarget.dd == 3)
            {
               if(this.timint == 2)
               {
                  return;
               }
               this.timint = 2;
               this.cgou();
               this.content["radiotime" + 3].gotoAndStop(2);
               this.ppsd();
               return;
            }
         }
      }
      
      private function cgou() : void
      {
         var _loc1_:uint = 1;
         while(_loc1_ <= 3)
         {
            this.content["radiotime" + _loc1_].gotoAndStop(1);
            _loc1_++;
         }
      }
      
      private function nunchanggeHd(param1:Event) : void
      {
         if(int(this.content.tf_shipnum.text) > this.obj.num)
         {
            this.content.tf_shipnum.text = this.obj.num;
         }
      }
      
      public function fuzhiHd(param1:Object) : void
      {
         this.xtf_oneprice.ResetDefaultText();
         this.obj = param1;
         TextField(this.content.tf_shipnum).text = String(this.obj.num);
         if(this.content.mc_shipbase.numChildren >= 2)
         {
            this.content.mc_shipbase.removeChildAt(1);
         }
         var _loc2_:propsInfo = CPropsReader.getInstance().GetPropsInfo(this.obj.PropsId);
         if(_loc2_.PackID == 1)
         {
            this.bit = new Bitmap(GameKernel.getTextureInstance(_loc2_.ImageFileName));
         }
         else
         {
            this.bit = new Bitmap(GameKernel.getTextureInstance(_loc2_.ImageFileName));
         }
         this.content.mc_shipbase.addChild(this.bit);
         this.content.tf_charge.text = "";
         this.content.tf_price.text = "";
      }
      
      private function rooHd(param1:MouseEvent) : void
      {
         this.tip = PackUi.getInstance().TipHd(param1.currentTarget.x,param1.currentTarget.y,this.obj.PropsId,true);
         this.tip.x = param1.currentTarget.x;
         this.tip.y = param1.currentTarget.y;
         if(param1.currentTarget.x >= 100)
         {
            this.tip.x = param1.currentTarget.x - this.tip.width;
         }
         this.content.addChild(this.tip);
      }
      
      private function rouHd(param1:MouseEvent) : void
      {
         if(this.content.contains(this.tip))
         {
            this.content.removeChild(this.tip);
         }
      }
      
      private function changeHd(param1:Event) : void
      {
         this.ppsd();
      }
      
      private function ppsd() : void
      {
         var _loc2_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc1_:Number = this.content.tf_oneprice.text / this.content.tf_shipnum.text;
         TextField(this.content.tf_price).text = String(Math.round(_loc1_ * 100) / 100);
         if(this.timint == 0)
         {
            _loc2_ = 0;
         }
         else if(this.timint == 1)
         {
            _loc2_ = 0.2;
         }
         else if(this.timint == 2)
         {
            _loc2_ = 0.3;
         }
         var _loc3_:int = int(this.content.tf_oneprice.text);
         var _loc5_:Number = ConstructionAction.getInstance().getOwnConstructionByBuilidID(EquimentTypeEnum.EQUIMENT_TYPE_TRADEPORT).equimentLevel.DecreaseTax / 100;
         _loc4_ = Math.round(_loc3_ * _loc5_ * (1 + _loc2_));
         this.sxf = _loc4_;
         if(this.sxf <= 0)
         {
            this.sxf = 1;
         }
         if(this.SelectedType == 0)
         {
            if(GamePlayer.getInstance().UserMoney < this.sxf)
            {
               TextField(this.content.tf_charge).textColor = 16711680;
               this.btn_sellout.setBtnDisabled(true);
            }
            else
            {
               this.btn_sellout.setBtnDisabled(false);
               TextField(this.content.tf_charge).textColor = 16777215;
            }
         }
         else if(GamePlayer.getInstance().cash < this.sxf)
         {
            TextField(this.content.tf_charge).textColor = 16711680;
            this.btn_sellout.setBtnDisabled(true);
         }
         else
         {
            this.btn_sellout.setBtnDisabled(false);
            TextField(this.content.tf_charge).textColor = 16777215;
         }
         if(this.content.tf_oneprice.text == "" || this.content.tf_oneprice.text <= 0)
         {
            this.btn_sellout.setBtnDisabled(true);
         }
         this.content.tf_charge.text = this.sxf.toString();
      }
      
      private function selloutHd(param1:MouseEvent) : void
      {
         var _loc2_:MSG_REQUEST_TRADEGOODS = new MSG_REQUEST_TRADEGOODS();
         _loc2_.TradeType = 1;
         _loc2_.Id = this.obj.PropsId;
         _loc2_.PriceType = this.SelectedType;
         _loc2_.TimeType = this.timint;
         _loc2_.Price = int(this.content.tf_oneprice.text);
         _loc2_.Num = int(this.content.tf_shipnum.text);
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc2_);
         GameKernel.popUpDisplayManager.Hide(instance);
         PackUi.getInstance().Hider();
      }
      
      private function closeHd(param1:MouseEvent) : void
      {
         GameKernel.popUpDisplayManager.Hide(instance);
         PackUi.getInstance().Hider(1);
      }
   }
}

