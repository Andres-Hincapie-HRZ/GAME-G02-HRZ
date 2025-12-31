package logic.ui
{
   import com.star.frameworks.managers.StringManager;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import logic.entry.HButton;
   import logic.entry.HButtonType;
   import logic.entry.MObject;
   import logic.game.GameKernel;
   import logic.ui.tip.ShipModelInfoTip;
   
   public class MallUI extends AbstractPopUp
   {
      
      private static var instance:MallUI;
      
      private var btn_buy:HButton;
      
      private var btn_sell:HButton;
      
      private var btn_selling:HButton;
      
      private var btn_blackmarket:HButton;
      
      private var SelectedBtn:HButton;
      
      private var mc_base:MovieClip;
      
      private var _MallUI_Sell:MallUI_Sell;
      
      private var _MallUI_Buy:MallUI_Buy;
      
      private var _MallUI_Selling:MallUI_Selling;
      
      private var McHelp:MovieClip;
      
      public function MallUI()
      {
         super();
         setPopUpName("MallUI");
      }
      
      public static function getInstance() : MallUI
      {
         if(instance == null)
         {
            instance = new MallUI();
         }
         return instance;
      }
      
      override public function Init() : void
      {
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            this._MallUI_Sell.Clear();
            this._MallUI_Buy.Clear();
            this.btn_buyClick(null);
            return;
         }
         this._mc = new MObject("MallScene",385,283);
         this.initMcElement();
         GameKernel.popUpDisplayManager.Regisger(instance);
         this._MallUI_Sell.Clear();
         this._MallUI_Buy.Clear();
         this.btn_buyClick(null);
      }
      
      override public function initMcElement() : void
      {
         var _loc1_:MovieClip = this._mc.getMC().getChildByName("btn_close") as MovieClip;
         var _loc2_:HButton = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_closeClick);
         _loc1_ = this._mc.getMC().getChildByName("btn_buy") as MovieClip;
         this.btn_buy = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_buyClick);
         _loc1_ = this._mc.getMC().getChildByName("btn_sell") as MovieClip;
         this.btn_sell = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_sellClick);
         _loc1_ = this._mc.getMC().getChildByName("btn_selling") as MovieClip;
         this.btn_selling = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_sellingClick);
         this.mc_base = this._mc.getMC().getChildByName("mc_base") as MovieClip;
         this._MallUI_Sell = MallUI_Sell.getInstance();
         this._MallUI_Buy = MallUI_Buy.getInstance();
         this._MallUI_Selling = MallUI_Selling.getInstance();
         _loc2_ = new HButton(this._mc.getMC().btn_help,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("IconText39"));
         this._mc.getMC().btn_help.addEventListener(MouseEvent.CLICK,this.btn_helpClick);
         this.McHelp = GameKernel.getMovieClipInstance("HelpMc5",_mc.getMC().x,_mc.getMC().y);
         this.McHelp.addEventListener(MouseEvent.CLICK,this.McHelpClick);
      }
      
      private function btn_closeClick(param1:MouseEvent) : void
      {
         ShipModelInfoTip.GetInstance().Hide();
         GameKernel.popUpDisplayManager.Hide(this);
      }
      
      private function btn_buyClick(param1:MouseEvent) : void
      {
         this.ResetSelectedBtn(this.btn_buy);
         this.ShowMc(this._MallUI_Buy.GetMc());
      }
      
      private function btn_sellClick(param1:MouseEvent) : void
      {
         ShipModelInfoTip.GetInstance().Hide();
         this.ResetSelectedBtn(this.btn_sell);
         this.ShowMc(this._MallUI_Sell.GetMc());
      }
      
      private function btn_sellingClick(param1:MouseEvent) : void
      {
         ShipModelInfoTip.GetInstance().Hide();
         this.ResetSelectedBtn(this.btn_selling);
         this.ShowMc(this._MallUI_Selling.GetMc());
      }
      
      private function ShowMc(param1:MovieClip) : void
      {
         if(this.mc_base.numChildren > 0)
         {
            this.mc_base.removeChildAt(0);
         }
         this.mc_base.addChild(param1);
      }
      
      private function ResetSelectedBtn(param1:HButton) : void
      {
         if(param1 == this.SelectedBtn)
         {
            return;
         }
         if(this.SelectedBtn != null)
         {
            this.SelectedBtn.setSelect(false);
         }
         this.SelectedBtn = param1;
         this.SelectedBtn.setSelect(true);
      }
      
      private function btn_helpClick(param1:MouseEvent) : void
      {
         if(this._mc.contains(this.McHelp))
         {
            this._mc.removeChild(this.McHelp);
            this.Invalid(true);
         }
         else
         {
            this.Invalid(false);
            this._mc.addChild(this.McHelp);
         }
      }
      
      private function McHelpClick(param1:MouseEvent) : void
      {
         this._mc.removeChild(this.McHelp);
         this.Invalid(true);
      }
   }
}

