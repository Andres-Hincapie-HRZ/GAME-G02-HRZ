package logic.ui
{
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.CEffectText;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.entry.ScienceSystem;
   import logic.entry.props.propsInfo;
   import logic.game.GameKernel;
   import logic.manager.GameInterActiveManager;
   import logic.reader.CPropsReader;
   import net.base.NetManager;
   import net.msg.mall.MSG_REQUEST_BUYGOODS;
   import net.msg.mall.MSG_RESP_BUYGOODS;
   import net.router.MallRouter;
   
   public class PropsBuyUI extends AbstractPopUp
   {
      
      private static var instance:PropsBuyUI;
      
      private static const MAXNUMMONEY:int = 100;
      
      private var radiocash:MovieClip;
      
      private var radiogold:MovieClip;
      
      private var chooseCash:int;
      
      private var cash:int;
      
      private var number:int = 0;
      
      private var _state:int = -1;
      
      private var _preant:String = "";
      
      private var Switch:Boolean = false;
      
      public var ShowCreateCorpsUI:int = 0;
      
      public function PropsBuyUI()
      {
         super();
         setPopUpName("PropsBuyUI");
      }
      
      public static function getInstance() : PropsBuyUI
      {
         if(instance == null)
         {
            instance = new PropsBuyUI();
         }
         return instance;
      }
      
      override public function Init() : void
      {
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            return;
         }
         this._mc = new MObject("StorepayPop",400,250);
         this.initMcElement();
         GameKernel.popUpDisplayManager.Regisger(instance);
      }
      
      override public function initMcElement() : void
      {
         var _loc1_:HButton = new HButton(this._mc.getMC().btn_cancel);
         GameInterActiveManager.InstallInterActiveEvent(_loc1_.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         var _loc2_:HButton = new HButton(this._mc.getMC().btn_buy);
         GameInterActiveManager.InstallInterActiveEvent(_loc2_.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         this.radiocash = _mc.getMC().radiocash as MovieClip;
         this.radiocash.addEventListener(ActionEvent.ACTION_CLICK,this.chickButton);
         this.radiocash.gotoAndStop(2);
         this.chooseCash = 0;
         this.radiogold = _mc.getMC().radiogold as MovieClip;
         this.radiogold.addEventListener(ActionEvent.ACTION_CLICK,this.chickButton);
         this.radiogold.gotoAndStop(1);
         TextField(this._mc.getMC().tf_allprice).type = TextFieldType.DYNAMIC;
         TextField(this._mc.getMC().tf_num).type = TextFieldType.INPUT;
         TextField(this._mc.getMC().tf_num).restrict = "0-9";
         TextField(this._mc.getMC().tf_num).addEventListener(Event.CHANGE,this.txtChange);
      }
      
      public function SetState(param1:int) : void
      {
         this._state = param1;
      }
      
      public function setpreant(param1:String) : void
      {
         this._preant = param1;
      }
      
      public function InitPopUp() : void
      {
         var _loc4_:Bitmap = null;
         var _loc1_:propsInfo = new propsInfo();
         _loc1_ = CPropsReader.getInstance().GetPropsInfo(this._state);
         this.cash = int(_loc1_.Cash);
         var _loc2_:MovieClip = this._mc.getMC().mc_base as MovieClip;
         var _loc3_:String = CPropsReader.getInstance().GetPropsInfo(this._state).ImageFileName;
         _loc3_ = _loc1_.ImageFileName;
         _loc4_ = new Bitmap(GameKernel.getTextureInstance(_loc3_));
         _loc2_.addChild(_loc4_);
         TextField(this._mc.getMC().tf_name).text = _loc1_.Name;
         TextField(this._mc.getMC().tf_detail).htmlText = _loc1_.Comment;
         TextField(this._mc.getMC().tf_num).text = "1";
         TextField(this._mc.getMC().tf_allprice).text = String(this.cash);
         if(_loc1_.UseMoney == 1)
         {
            this.radiogold.visible = true;
            _mc.getMC().mc_money.visible = true;
         }
         else
         {
            this.radiogold.visible = false;
            _mc.getMC().mc_money.visible = false;
         }
         this.Switch = true;
      }
      
      private function chickButton(param1:Event) : void
      {
         if(param1.currentTarget.name == "btn_cancel")
         {
            if(this._state == 903 || this._state == 904 || this._state == 924 || this._state == 926)
            {
               CommanderSceneUI.getInstance().removeBackMC();
            }
            GameKernel.popUpDisplayManager.Hide(instance);
            if(this.ShowCreateCorpsUI == 0)
            {
               if(this._preant == "xiaolaba")
               {
                  this._preant = "";
                  GameKernel.popUpDisplayManager.Hide(instance);
               }
               else
               {
                  StateHandlingUI.getInstance().Init();
                  StateHandlingUI.getInstance().InitPopUp();
               }
            }
            else if(this.ShowCreateCorpsUI == 1)
            {
               CreateCorpsUI.getInstance().Clear();
               GameKernel.popUpDisplayManager.Hide(StateHandlingUI.getInstance());
               this.ShowCreateCorpsUI = 0;
            }
            else if(this.ShowCreateCorpsUI == 2)
            {
               ComposeUI.getInstance().RefreshGoods();
               this.ShowCreateCorpsUI = 0;
            }
            else if(this.ShowCreateCorpsUI == 3)
            {
               GameKernel.popUpDisplayManager.Hide(StateHandlingUI.getInstance());
               this.ShowCreateCorpsUI = 0;
            }
         }
         else if(param1.currentTarget.name == "btn_buy")
         {
            if(GamePlayer.getInstance().PropsPack - ScienceSystem.getinstance().Packarr.length > 0)
            {
               this.number = int(this._mc.getMC().tf_num.text);
               if(this._state == 918)
               {
                  if(this.number > MAXNUMMONEY - GamePlayer.getInstance().MoneyBuyNum)
                  {
                     this.number = MAXNUMMONEY - GamePlayer.getInstance().MoneyBuyNum;
                     if(this.number < 0)
                     {
                        this.number = 0;
                     }
                     CEffectText.getInstance().showEffectText(GameKernel.renderManager.getUI().getContainer(),StringManager.getInstance().getMessageString("ItemText14"));
                     return;
                  }
               }
               if(this.chooseCash == 0)
               {
                  if(this.cash * this.number > GamePlayer.getInstance().cash)
                  {
                     CEffectText.getInstance().showEffectText(GameKernel.renderManager.getUI().getContainer(),StringManager.getInstance().getMessageString("AuctionText31"));
                     return;
                  }
               }
               else if(this.cash * this.number > GamePlayer.getInstance().coins)
               {
                  CEffectText.getInstance().showEffectText(GameKernel.renderManager.getUI().getContainer(),StringManager.getInstance().getMessageString("AuctionText32"));
                  return;
               }
               if(this.Switch == false)
               {
                  return;
               }
               this.Switch = false;
               this.RequestBuyGoods(this.chooseCash,this._state,this.number);
            }
            else
            {
               StoragepopupTip.getInstance().Init();
               StoragepopupTip.getInstance().Show();
               if(GamePlayer.getInstance().PropsPack == PackUi.getInstance().maxNum)
               {
                  StoragepopupTip.getInstance().ppd(2);
               }
               else
               {
                  StoragepopupTip.getInstance().ppd(1);
               }
            }
         }
         else if(param1.currentTarget.name == "radiocash")
         {
            if(this.chooseCash == 0)
            {
               return;
            }
            this.chooseCash = 0;
            this.radiocash.gotoAndStop(2);
            this.radiogold.gotoAndStop(1);
            this._mc.getMC().mc_cash.visible = true;
            this._mc.getMC().mc_gold.visible = false;
         }
         else if(param1.currentTarget.name == "radiogold")
         {
            if(this.chooseCash == 1)
            {
               return;
            }
            this.chooseCash = 1;
            this.radiocash.gotoAndStop(1);
            this.radiogold.gotoAndStop(2);
            this._mc.getMC().mc_cash.visible = false;
            this._mc.getMC().mc_gold.visible = true;
         }
      }
      
      private function txtChange(param1:Event) : void
      {
         var _loc2_:String = TextField(this._mc.getMC().tf_num).text;
         var _loc3_:int = int(_loc2_);
         if(this.chooseCash == 1)
         {
            if(_loc3_ * this.cash > GamePlayer.getInstance().coins)
            {
               _loc3_ = GamePlayer.getInstance().coins / this.cash;
               TextField(this._mc.getMC().tf_num).text = String(_loc3_);
            }
         }
         else if(_loc3_ * this.cash > GamePlayer.getInstance().cash)
         {
            _loc3_ = GamePlayer.getInstance().cash / this.cash;
            TextField(this._mc.getMC().tf_num).text = String(_loc3_);
         }
         if(this._state == 918)
         {
            if(_loc3_ > MAXNUMMONEY - GamePlayer.getInstance().MoneyBuyNum)
            {
               _loc3_ = MAXNUMMONEY - GamePlayer.getInstance().MoneyBuyNum;
            }
         }
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         this.number = _loc3_;
         _loc3_ *= this.cash;
         TextField(this._mc.getMC().tf_num).text = String(this.number);
         TextField(this._mc.getMC().tf_allprice).text = String(_loc3_);
      }
      
      private function RequestBuyGoods(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:MSG_REQUEST_BUYGOODS = new MSG_REQUEST_BUYGOODS();
         _loc4_.PropsId = param2;
         _loc4_.Type = param1;
         _loc4_.SeqId = GamePlayer.getInstance().seqID++;
         _loc4_.Guid = GamePlayer.getInstance().Guid;
         _loc4_.Num = param3;
         NetManager.Instance().sendObject(_loc4_);
         MallRouter.instance.OnBuyGood = this.OnBuyGood;
      }
      
      private function OnBuyGood(param1:MSG_RESP_BUYGOODS) : void
      {
         GameKernel.popUpDisplayManager.Hide(instance);
         if(this.ShowCreateCorpsUI == 0)
         {
            if(this._preant == "xiaolaba")
            {
               this._preant = "";
               GameKernel.popUpDisplayManager.Hide(instance);
            }
            else
            {
               StateHandlingUI.getInstance().Init();
               GameKernel.popUpDisplayManager.Show(StateHandlingUI.getInstance());
               StateHandlingUI.getInstance().InitPopUp();
            }
         }
         else if(this.ShowCreateCorpsUI == 1)
         {
            GameKernel.popUpDisplayManager.Hide(StateHandlingUI.getInstance());
            CreateCorpsUI.getInstance().Clear();
            this.ShowCreateCorpsUI = 0;
         }
         else if(this.ShowCreateCorpsUI == 2)
         {
            ComposeUI.getInstance().RefreshGoods();
            this.ShowCreateCorpsUI = 0;
         }
         else if(this.ShowCreateCorpsUI == 3)
         {
            GameKernel.popUpDisplayManager.Hide(StateHandlingUI.getInstance());
            ChangeServerUI.getInstance().DoChangeServer();
            this.ShowCreateCorpsUI = 0;
         }
      }
   }
}

