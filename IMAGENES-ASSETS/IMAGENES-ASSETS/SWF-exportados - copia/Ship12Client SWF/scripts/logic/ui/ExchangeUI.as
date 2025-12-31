package logic.ui
{
   import com.star.frameworks.managers.StringManager;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import logic.action.ConstructionAction;
   import logic.entry.EquimentTypeEnum;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.entry.blurprint.EquimentBlueprint;
   import logic.game.GameKernel;
   import logic.reader.CConstructionReader;
   import net.base.NetManager;
   import net.msg.MSG_REQUEST_EXCHANGERES;
   
   public class ExchangeUI extends AbstractPopUp
   {
      
      private static var instance:ExchangeUI;
      
      private var mc_check0:MovieClip;
      
      private var mc_check1:MovieClip;
      
      private var restradelise0:MovieClip;
      
      private var restradelise1:MovieClip;
      
      private var txt_bili0:TextField;
      
      private var txt_bili1:TextField;
      
      private var SelectedType:int;
      
      private var ExchangeValue:Number;
      
      public function ExchangeUI()
      {
         super();
         setPopUpName("ExchangeUI");
      }
      
      public static function getInstance() : ExchangeUI
      {
         if(instance == null)
         {
            instance = new ExchangeUI();
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
         this._mc = new MObject("ResTradeMc",385,300);
         this.initMcElement();
         this.Clear();
         GameKernel.popUpDisplayManager.Regisger(instance);
      }
      
      override public function initMcElement() : void
      {
         var _loc1_:HButton = null;
         var _loc2_:MovieClip = null;
         _loc2_ = this._mc.getMC().getChildByName("btn_close") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_closeClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_ok") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_okClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_cancel") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_cancelClick);
         this.mc_check0 = this._mc.getMC().getChildByName("mc_check0") as MovieClip;
         this.mc_check0.addEventListener(MouseEvent.CLICK,this.mc_check0Click);
         this.mc_check1 = this._mc.getMC().getChildByName("mc_check1") as MovieClip;
         this.mc_check1.addEventListener(MouseEvent.CLICK,this.mc_check1Click);
         this.restradelise0 = this._mc.getMC().getChildByName("restradelise0") as MovieClip;
         this.restradelise1 = this._mc.getMC().getChildByName("restradelise1") as MovieClip;
         this.txt_bili0 = this._mc.getMC().getChildByName("txt_bili0") as TextField;
         this.txt_bili1 = this._mc.getMC().getChildByName("txt_bili1") as TextField;
         TextField(this.restradelise0.txt_num0).restrict = "0-9";
         TextField(this.restradelise0.txt_num1).restrict = "0-9";
         TextField(this.restradelise1.txt_num0).restrict = "0-9";
         TextField(this.restradelise1.txt_num1).restrict = "0-9";
         TextField(this.restradelise0.txt_num0).text = "";
         TextField(this.restradelise0.txt_num1).text = "";
         TextField(this.restradelise1.txt_num0).text = "";
         TextField(this.restradelise1.txt_num1).text = "";
         TextField(this.restradelise0.txt_num1).mouseEnabled = false;
         TextField(this.restradelise1.txt_num1).mouseEnabled = false;
         TextField(this.restradelise0.txt_num0).addEventListener(Event.CHANGE,this.txt_num0Change);
         TextField(this.restradelise1.txt_num0).addEventListener(Event.CHANGE,this.txt_num1Change);
      }
      
      private function txt_num1Change(param1:Event) : void
      {
         if(TextField(this.restradelise1.txt_num0).text.length > 8)
         {
            TextField(this.restradelise1.txt_num0).text = "100000000";
         }
         var _loc2_:int = parseInt(TextField(this.restradelise1.txt_num0).text);
         if(GamePlayer.getInstance().UserHe3 < _loc2_)
         {
            _loc2_ = int(GamePlayer.getInstance().UserHe3);
            TextField(this.restradelise1.txt_num0).text = _loc2_.toString();
         }
         TextField(this.restradelise1.txt_num1).text = int(_loc2_ * this.ExchangeValue).toString();
      }
      
      private function txt_num0Change(param1:Event) : void
      {
         if(TextField(this.restradelise0.txt_num0).text.length > 8)
         {
            TextField(this.restradelise0.txt_num0).text = "100000000";
         }
         var _loc2_:int = parseInt(TextField(this.restradelise0.txt_num0).text);
         if(GamePlayer.getInstance().UserMetal < _loc2_)
         {
            _loc2_ = int(GamePlayer.getInstance().UserMetal);
            TextField(this.restradelise0.txt_num0).text = _loc2_.toString();
         }
         TextField(this.restradelise0.txt_num1).text = int(_loc2_ * this.ExchangeValue).toString();
      }
      
      private function btn_closeClick(param1:MouseEvent) : void
      {
         GameKernel.popUpDisplayManager.Hide(this);
      }
      
      private function SetSelectedType(param1:int) : void
      {
         this.SelectedType = param1;
         this.mc_check0.gotoAndStop(this.SelectedType == 1 ? 2 : 1);
         this.mc_check1.gotoAndStop(this.SelectedType == 2 ? 2 : 1);
         this.restradelise0.gotoAndStop(this.SelectedType == 1 ? 2 : 1);
         this.restradelise1.gotoAndStop(this.SelectedType == 2 ? 2 : 1);
         if(this.SelectedType == 1)
         {
            TextField(this.restradelise0.txt_num0).mouseEnabled = true;
            TextField(this.restradelise1.txt_num0).mouseEnabled = false;
            TextField(this.restradelise1.txt_num0).text = "";
            TextField(this.restradelise1.txt_num1).text = "";
         }
         else
         {
            TextField(this.restradelise0.txt_num0).text = "";
            TextField(this.restradelise0.txt_num1).text = "";
            TextField(this.restradelise0.txt_num0).mouseEnabled = false;
            TextField(this.restradelise1.txt_num0).mouseEnabled = true;
         }
      }
      
      private function mc_check1Click(param1:MouseEvent) : void
      {
         this.SetSelectedType(2);
      }
      
      private function mc_check0Click(param1:MouseEvent) : void
      {
         this.SetSelectedType(1);
      }
      
      private function btn_cancelClick(param1:MouseEvent) : void
      {
         GameKernel.popUpDisplayManager.Hide(this);
      }
      
      private function btn_okClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(this.SelectedType == 1)
         {
            if(TextField(this.restradelise0.txt_num0).text == "")
            {
               return;
            }
            _loc2_ = parseInt(TextField(this.restradelise0.txt_num0).text);
         }
         else
         {
            if(TextField(this.restradelise1.txt_num0).text == "")
            {
               return;
            }
            _loc2_ = parseInt(TextField(this.restradelise1.txt_num0).text);
         }
         var _loc3_:MSG_REQUEST_EXCHANGERES = new MSG_REQUEST_EXCHANGERES();
         _loc3_.Type = this.SelectedType - 1;
         _loc3_.Value = _loc2_;
         _loc3_.Guid = GamePlayer.getInstance().Guid;
         _loc3_.SeqId = GamePlayer.getInstance().seqID++;
         NetManager.Instance().sendObject(_loc3_);
         GameKernel.popUpDisplayManager.Hide(this);
      }
      
      private function Clear() : void
      {
         var _loc1_:Object = ConstructionAction.ownConstructionCopyList.Get(EquimentTypeEnum.EQUIMENT_TYPE_TRADEPORT);
         var _loc2_:EquimentBlueprint = CConstructionReader.getInstance().Read(EquimentTypeEnum.EQUIMENT_TYPE_TRADEPORT,_loc1_.LevelID);
         this.ExchangeValue = _loc2_.Exchange / 100;
         this.txt_bili0.text = "1:" + this.ExchangeValue;
         if(_loc1_.LevelID < 8)
         {
            _loc2_ = CConstructionReader.getInstance().Read(EquimentTypeEnum.EQUIMENT_TYPE_TRADEPORT,_loc1_.LevelID + 1);
            this.txt_bili1.text = "1:" + _loc2_.Exchange / 100;
         }
         else
         {
            this.txt_bili1.text = "1:" + this.ExchangeValue;
         }
         TextField(this._mc.getMC().txt_name).text = _loc2_.BuildingName + StringManager.getInstance().getMessageString("BuildingText21") + int(_loc1_.LevelID + 1);
         this.SetSelectedType(1);
      }
   }
}

