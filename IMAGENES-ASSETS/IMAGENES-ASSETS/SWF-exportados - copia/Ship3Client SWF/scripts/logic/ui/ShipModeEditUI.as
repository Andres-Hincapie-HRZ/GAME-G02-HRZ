package logic.ui
{
   import com.star.frameworks.geom.CFilter;
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.HashSet;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.HButtonType;
   import logic.entry.MObject;
   import logic.entry.shipmodel.ShipModeCreateInfo;
   import logic.entry.shipmodel.ShippartInfo;
   import logic.game.GameKernel;
   import logic.reader.CShipmodelReader;
   import logic.ui.tip.CaptionTip;
   import logic.widget.DataWidget;
   import net.base.NetManager;
   import net.common.MsgTypes;
   import net.msg.shipmodelMsg.MSG_REQUEST_CREATESHIPMODEL;
   import net.router.ShipmodelRouter;
   
   public class ShipModeEditUI extends AbstractPopUp
   {
      
      private static var instance:ShipModeEditUI;
      
      public var SelectedParts:HashSet;
      
      public var SelectedPartId:Array;
      
      public var ModeInfo:ShipModeCreateInfo;
      
      private var _ShipModeEditUI_Body:ShipModeEditUI_Body;
      
      private var _ShipModeEditUI_Part:ShipModeEditUI_Part;
      
      private var _ShipModeEditUI_RemainPart:ShipModeEditUI_RemainPart;
      
      private var RemainNumText:TextField;
      
      private var RemainPlanBar:MovieClip;
      
      private var SelectedBodyBtn:HButton;
      
      private var btn_frigate:HButton;
      
      private var btn_warship:HButton;
      
      private var btn_cruiser:HButton;
      
      private var btn_others:HButton;
      
      private var btn_new:HButton;
      
      private var mc_huwei:MovieClip;
      
      private var mc_zhanlie:MovieClip;
      
      private var mc_xuanyang:MovieClip;
      
      private var mc_special:MovieClip;
      
      public var filter:CFilter;
      
      private var McHelp:MovieClip;
      
      private var tf_blueprintname:XTextField;
      
      private var btn_qijian:HButton;
      
      public function ShipModeEditUI()
      {
         super();
         this.filter = new CFilter();
         this.filter.generate_colorMatrix_filter();
         this.SelectedParts = new HashSet();
         this.ModeInfo = new ShipModeCreateInfo();
         this.SelectedPartId = new Array();
         setPopUpName("ShipModeEditUI");
      }
      
      public static function getInstance() : ShipModeEditUI
      {
         if(instance == null)
         {
            instance = new ShipModeEditUI();
         }
         return instance;
      }
      
      override public function Init() : void
      {
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            this.ClearView();
            return;
         }
         this._mc = new MObject("AirshipdesignScene",375,325);
         this._ShipModeEditUI_Body = new ShipModeEditUI_Body(this._mc,this);
         this._ShipModeEditUI_Part = new ShipModeEditUI_Part(this._mc,this);
         this._ShipModeEditUI_RemainPart = new ShipModeEditUI_RemainPart(this._mc,this);
         this.initMcElement();
         this.ClearView();
         GameKernel.popUpDisplayManager.Regisger(instance);
      }
      
      override public function initMcElement() : void
      {
         var _loc1_:MovieClip = this._mc.getMC().mc_fitmodule;
         this.RemainNumText = this._mc.getMC().tf_time as TextField;
         this.RemainNumText.text = "";
         this.RemainPlanBar = this._mc.getMC().getChildByName("mc_planbar") as MovieClip;
         this.RemainPlanBar.width = 0;
         var _loc2_:HButton = new HButton(this._mc.getMC().btn_over);
         this._mc.getMC().btn_over.addEventListener(MouseEvent.CLICK,this.btn_completeClick);
         this.btn_frigate = new HButton(this._mc.getMC().btn_frigate,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("IconText13"));
         this._mc.getMC().btn_frigate.addEventListener(MouseEvent.CLICK,this.btn_frigateClick);
         this.btn_warship = new HButton(this._mc.getMC().btn_warship,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("IconText15"));
         this._mc.getMC().btn_warship.addEventListener(MouseEvent.CLICK,this.btn_warshipClick);
         this.btn_cruiser = new HButton(this._mc.getMC().btn_cruiser,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("IconText14"));
         this._mc.getMC().btn_cruiser.addEventListener(MouseEvent.CLICK,this.btn_cruiserClick);
         var _loc3_:* = this._mc.getMC().getChildByName("btn_qijian");
         if(_loc3_)
         {
            this.btn_qijian = new HButton(this._mc.getMC().btn_qijian,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("Boss68"));
            this._mc.getMC().btn_qijian.addEventListener(MouseEvent.CLICK,this.btn_qijianClick);
         }
         this.btn_others = new HButton(this._mc.getMC().btn_others,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("IconText16"));
         this._mc.getMC().btn_others.addEventListener(MouseEvent.CLICK,this.btn_othersClick);
         this.btn_new = new HButton(this._mc.getMC().btn_new,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("Boss191"));
         this._mc.getMC().btn_new.addEventListener(MouseEvent.CLICK,this.btn_newClick);
         _loc2_ = new HButton(this._mc.getMC().btn_close);
         this._mc.getMC().btn_close.addEventListener(MouseEvent.CLICK,this.btn_closeClick);
         _loc2_ = new HButton(this._mc.getMC().btn_help,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("IconText39"));
         this._mc.getMC().btn_help.addEventListener(MouseEvent.CLICK,this.btn_helpClick);
         this.McHelp = GameKernel.getMovieClipInstance("HelpMc3",_mc.getMC().x + 20,_mc.getMC().y);
         this.McHelp.addEventListener(MouseEvent.CLICK,this.McHelpClick);
         var _loc4_:TextField = this._mc.getMC().tf_blueprintname as TextField;
         _loc4_.maxChars = GamePlayer.getInstance().language == 0 ? 8 : 16;
         this.tf_blueprintname = new XTextField(_loc4_,StringManager.getInstance().getMessageString("DesignText17"));
         this.mc_huwei = this._mc.getMC().mc_huwei as MovieClip;
         this.mc_zhanlie = this._mc.getMC().mc_zhanlie as MovieClip;
         this.mc_xuanyang = this._mc.getMC().mc_xuanyang as MovieClip;
         this.mc_special = this._mc.getMC().mc_special as MovieClip;
         this._ShipModeEditUI_Body.IniBodyList();
         this._ShipModeEditUI_Part.IniPart();
         this.ClearText();
         this._ShipModeEditUI_RemainPart.IniRemainPart();
         this._ShipModeEditUI_Part.IniPartList();
         this.ClearModeInfo();
         this.InitCaption();
      }
      
      private function InitCaption() : void
      {
         var _loc1_:CaptionTip = null;
         _loc1_ = new CaptionTip(this._mc.getMC().pic_hudun,StringManager.getInstance().getMessageString("IconText6"));
         MovieClip(this._mc.getMC().pic_hudun).addEventListener(MouseEvent.CLICK,this.pic_hudunClick);
         _loc1_ = new CaptionTip(this._mc.getMC().pic_shecheng,StringManager.getInstance().getMessageString("IconText7"));
         _loc1_ = new CaptionTip(this._mc.getMC().pic_cunchu,StringManager.getInstance().getMessageString("IconText1"));
         MovieClip(this._mc.getMC().pic_cunchu).addEventListener(MouseEvent.CLICK,this.pic_cunchuClick);
         _loc1_ = new CaptionTip(this._mc.getMC().pic_gongjili,StringManager.getInstance().getMessageString("IconText4"));
         MovieClip(this._mc.getMC().pic_gongjili).addEventListener(MouseEvent.CLICK,this.pic_gongjiliClick);
         _loc1_ = new CaptionTip(this._mc.getMC().pic_jiegou,StringManager.getInstance().getMessageString("IconText41"));
         MovieClip(this._mc.getMC().pic_jiegou).addEventListener(MouseEvent.CLICK,this.pic_jiegouClick);
         _loc1_ = new CaptionTip(this._mc.getMC().pic_yidongli,StringManager.getInstance().getMessageString("IconText0"));
         MovieClip(this._mc.getMC().pic_yidongli).addEventListener(MouseEvent.CLICK,this.pic_yidongliClick);
         _loc1_ = new CaptionTip(this._mc.getMC().pic_jianzao,StringManager.getInstance().getMessageString("IconText8"));
         _loc1_ = new CaptionTip(this._mc.getMC().pic_yueqian,StringManager.getInstance().getMessageString("IconText9"));
      }
      
      private function pic_hudunClick(param1:MouseEvent) : void
      {
         this._ShipModeEditUI_Part.DefenseClick(null);
         this._ShipModeEditUI_Part.HudunClick(null);
      }
      
      private function pic_jiegouClick(param1:MouseEvent) : void
      {
         this._ShipModeEditUI_Part.DefenseClick(null);
      }
      
      private function pic_yidongliClick(param1:MouseEvent) : void
      {
         this._ShipModeEditUI_Part.AssistantClick(null);
         this._ShipModeEditUI_Part.YueqianClick(null);
      }
      
      private function pic_cunchuClick(param1:MouseEvent) : void
      {
         this._ShipModeEditUI_Part.AssistantClick(null);
         this._ShipModeEditUI_Part.CunchuClick(null);
      }
      
      private function pic_gongjiliClick(param1:MouseEvent) : void
      {
         this._ShipModeEditUI_Part.AttackClick(param1);
      }
      
      private function ClearText() : void
      {
         var _loc1_:TextField = null;
         _loc1_ = this._mc.getMC().tf_airshipname;
         _loc1_.text = "";
         _loc1_ = this._mc.getMC().tf_metal;
         _loc1_.text = "";
         _loc1_ = this._mc.getMC().tf_He3;
         _loc1_.text = "";
         _loc1_ = this._mc.getMC().tf_cash;
         _loc1_.text = "";
         this.tf_blueprintname.ResetDefaultText();
         _loc1_ = this._mc.getMC().tf_Moneylj as TextField;
         _loc1_.text = "";
      }
      
      public function ShowRemainPartCurPage() : void
      {
         this._ShipModeEditUI_RemainPart.ShowRemainPartCurPage();
      }
      
      public function AddToSelectedPartList(param1:int, param2:int, param3:int) : Boolean
      {
         var _loc4_:int = 0;
         if(this.SelectedParts.ContainsKey(param1))
         {
            _loc4_ = this.SelectedParts.Get(param1);
         }
         if(++param2 > 0 && this.GetPartGroupCount(param1) + 1 > param2)
         {
            return false;
         }
         if(param3 + this.ModeInfo.Locomotivity > 16)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("DesignText18"),0);
            return false;
         }
         if(!this.SelectedParts.ContainsKey(param1))
         {
            this.SelectedPartId.push(param1);
         }
         this.SelectedParts.Put(param1,_loc4_);
         return true;
      }
      
      private function GetPartGroupCount(param1:int) : int
      {
         var _loc4_:int = 0;
         var _loc5_:ShippartInfo = null;
         var _loc2_:int = 0;
         var _loc3_:ShippartInfo = CShipmodelReader.getInstance().getShipPartInfo(param1);
         for each(_loc4_ in this.SelectedParts.Keys())
         {
            _loc5_ = CShipmodelReader.getInstance().getShipPartInfo(_loc4_);
            if(_loc5_.KindId == _loc3_.KindId && _loc5_.GroupID == _loc3_.GroupID)
            {
               _loc2_ += this.SelectedParts.Get(_loc4_);
            }
         }
         return _loc2_;
      }
      
      private function ClearModeInfo() : void
      {
         TextField(this._mc.getMC().tf_hudun).text = "";
         TextField(this._mc.getMC().tf_gongjili).text = "";
         TextField(this._mc.getMC().tf_jiegou).text = "";
         TextField(this._mc.getMC().tf_shecheng).text = "";
         TextField(this._mc.getMC().tf_yidongli).text = "";
         TextField(this._mc.getMC().tf_cunchu).text = "";
         var _loc1_:TextField = this._mc.getMC().tf_jianzao as TextField;
         _loc1_.text = "";
         _loc1_ = this._mc.getMC().tf_yueqian as TextField;
         _loc1_.text = "";
         this.ModeInfo.metal = 0;
         this.ModeInfo.he3 = 0;
         this.ModeInfo.cash = 0;
         this.ModeInfo.Shield = 0;
         this.ModeInfo.Endure = 0;
         this.ModeInfo.ShieldUpgrade = 0;
         this.ModeInfo.EndureUpgrade = 0;
         this.ModeInfo.Locomotivity = 0;
         this.ModeInfo.MinAssault = 0;
         this.ModeInfo.MaxAssault = 0;
         this.ModeInfo.MinRange = 0;
         this.ModeInfo.MaxRange = 0;
         this.ModeInfo.Cubage = 0;
         this.ModeInfo.Storage = 0;
         this.ModeInfo.Yare = 0;
         this.ModeInfo.UnitSupply = 0;
         this.ModeInfo.TransitionTime = 0;
         this.ModeInfo.CreateTime = 0;
         this.RemainNumText.text = "0";
         this.RemainPlanBar.width = 0;
      }
      
      public function RemovePart(param1:ShippartInfo) : void
      {
         this.ModeInfo.metal -= param1.Metal;
         this.ModeInfo.he3 -= param1.He3;
         this.ModeInfo.cash -= param1.Money;
         this.ModeInfo.Shield -= param1.Shield;
         this.ModeInfo.Endure -= param1.Endure;
         this.ModeInfo.Locomotivity -= param1.Locomotivity;
         this.ModeInfo.MinAssault -= param1.MinAssault;
         this.ModeInfo.MaxAssault -= param1.MaxAssault;
         this.GetRange();
         this.ModeInfo.Cubage += param1.Cubage;
         this.ModeInfo.Storage -= param1.Storage;
         this.ModeInfo.Yare -= param1.Yare;
         this.ModeInfo.UnitSupply -= param1.UnitSupply;
         this.ModeInfo.TransitionTime -= param1.TransitionTime;
         this.ModeInfo.CreateTime -= param1.CreateTime;
      }
      
      private function GetRange() : void
      {
         var _loc3_:int = 0;
         var _loc4_:ShippartInfo = null;
         var _loc1_:int = 9999;
         var _loc2_:int = 0;
         for each(_loc3_ in this.SelectedParts.Keys())
         {
            _loc4_ = CShipmodelReader.getInstance().getShipPartInfo(_loc3_);
            if(_loc4_.MinRange > 0 && _loc4_.MinRange < _loc1_)
            {
               _loc1_ = _loc4_.MinRange;
            }
            if(_loc4_.MaxRange > _loc2_)
            {
               _loc2_ = _loc4_.MaxRange;
            }
         }
         if(this.SelectedParts.Keys().length == 0)
         {
            this.ModeInfo.MinRange = 0;
            this.ModeInfo.MaxRange = 0;
         }
         else
         {
            this.ModeInfo.MinRange = _loc1_;
            this.ModeInfo.MaxRange = _loc2_;
         }
         if(this.ModeInfo.MinRange > this.ModeInfo.MaxRange)
         {
            this.ModeInfo.MinRange = 0;
         }
      }
      
      public function AddPart(param1:ShippartInfo) : void
      {
         this.ModeInfo.metal += param1.Metal;
         this.ModeInfo.he3 += param1.He3;
         this.ModeInfo.cash += param1.Money;
         this.ModeInfo.Shield += param1.Shield;
         this.ModeInfo.Endure += param1.Endure;
         this.ModeInfo.Locomotivity += param1.Locomotivity;
         this.ModeInfo.MinAssault += param1.MinAssault;
         this.ModeInfo.MaxAssault += param1.MaxAssault;
         if(param1.MinRange > 0)
         {
            if(this.ModeInfo.MinRange == 0)
            {
               this.ModeInfo.MinRange = param1.MinRange;
            }
            else
            {
               this.ModeInfo.MinRange = Math.min(this.ModeInfo.MinRange,param1.MinRange);
            }
         }
         this.ModeInfo.MaxRange = Math.max(this.ModeInfo.MaxRange,param1.MaxRange);
         this.ModeInfo.Cubage -= param1.Cubage;
         this.ModeInfo.Storage += param1.Storage;
         this.ModeInfo.Yare += param1.Yare;
         this.ModeInfo.UnitSupply += param1.UnitSupply;
         this.ModeInfo.TransitionTime += param1.TransitionTime;
         this.ModeInfo.CreateTime += param1.CreateTime;
      }
      
      public function ShowModeInfo() : void
      {
         var _loc1_:TextField = null;
         var _loc3_:TextFormat = null;
         if(this.ModeInfo.ShieldUpgrade > 0)
         {
            TextField(this._mc.getMC().tf_hudun).htmlText = this.ModeInfo.Shield.toString() + "<font color=\'#00FF00\'>(+" + this.ModeInfo.ShieldUpgrade + ")</font>";
         }
         else
         {
            TextField(this._mc.getMC().tf_hudun).htmlText = this.ModeInfo.Shield.toString();
         }
         TextField(this._mc.getMC().tf_gongjili).text = this.ModeInfo.MinAssault + " - " + this.ModeInfo.MaxAssault;
         if(this.ModeInfo.EndureUpgrade > 0)
         {
            TextField(this._mc.getMC().tf_jiegou).htmlText = this.ModeInfo.Endure.toString() + "<font color=\'#00FF00\'>(+" + this.ModeInfo.EndureUpgrade + ")</font>";
         }
         else
         {
            TextField(this._mc.getMC().tf_jiegou).htmlText = this.ModeInfo.Endure.toString();
         }
         TextField(this._mc.getMC().tf_shecheng).text = this.ModeInfo.MinRange + " - " + this.ModeInfo.MaxRange;
         TextField(this._mc.getMC().tf_yidongli).text = this.ModeInfo.Locomotivity.toString();
         TextField(this._mc.getMC().tf_cunchu).text = this.ModeInfo.Storage.toString();
         _loc1_ = this._mc.getMC().tf_yueqian as TextField;
         _loc1_.text = DataWidget.GetTimeString(this.ModeInfo.TransitionTime);
         _loc1_ = this._mc.getMC().tf_jianzao as TextField;
         _loc1_.text = DataWidget.GetTimeString(this.ModeInfo.CreateTime);
         _loc1_ = this._mc.getMC().tf_metal;
         _loc1_.text = this.ModeInfo.metal.toString();
         _loc1_ = this._mc.getMC().tf_He3;
         _loc1_.text = this.ModeInfo.he3.toString();
         _loc1_ = this._mc.getMC().tf_cash;
         _loc1_.text = this.ModeInfo.cash.toString();
         _loc1_ = this._mc.getMC().tf_Moneylj as TextField;
         _loc1_.text = this.ModeInfo.cash.toString();
         if(GamePlayer.getInstance().UserMoney < this.ModeInfo.cash)
         {
            _loc3_ = _loc1_.getTextFormat();
            _loc3_.color = 16711680;
            _loc1_.setTextFormat(_loc3_);
         }
         this.RemainNumText.text = this._ShipModeEditUI_Body.SelecedBody.Cubage - this.ModeInfo.Cubage + "/" + this._ShipModeEditUI_Body.SelecedBody.Cubage;
         var _loc2_:int = 143 * (1 - this.ModeInfo.Cubage / this.ModeInfo.BodyCubage);
         this.RemainPlanBar.width = _loc2_;
      }
      
      private function btn_closeClick(param1:Event) : void
      {
         GameKernel.popUpDisplayManager.Hide(this);
      }
      
      private function btn_frigateClick(param1:Event) : void
      {
         this.ResetSelectedBtn(this.btn_frigate);
         this._ShipModeEditUI_Body.ShowBody(0);
         this.mc_huwei.visible = true;
         this.mc_zhanlie.visible = false;
         this.mc_xuanyang.visible = false;
         this.mc_special.visible = false;
      }
      
      private function btn_warshipClick(param1:Event) : void
      {
         this.ResetSelectedBtn(this.btn_warship);
         this._ShipModeEditUI_Body.ShowBody(2);
         this.mc_huwei.visible = false;
         this.mc_zhanlie.visible = true;
         this.mc_xuanyang.visible = false;
         this.mc_special.visible = false;
      }
      
      private function btn_cruiserClick(param1:Event) : void
      {
         this.ResetSelectedBtn(this.btn_cruiser);
         this._ShipModeEditUI_Body.ShowBody(1);
         this.mc_huwei.visible = false;
         this.mc_zhanlie.visible = false;
         this.mc_xuanyang.visible = true;
         this.mc_special.visible = false;
      }
      
      private function btn_newClick(param1:Event) : void
      {
         this.ResetSelectedBtn(this.btn_new);
         this._ShipModeEditUI_Body.ShowBody(6);
         this.mc_huwei.visible = false;
         this.mc_zhanlie.visible = false;
         this.mc_xuanyang.visible = false;
         this.mc_special.visible = true;
      }
      
      private function btn_othersClick(param1:Event) : void
      {
         this.ResetSelectedBtn(this.btn_others);
         this._ShipModeEditUI_Body.ShowBody(4);
         this.mc_huwei.visible = false;
         this.mc_zhanlie.visible = false;
         this.mc_xuanyang.visible = false;
         this.mc_special.visible = true;
      }
      
      private function btn_qijianClick(param1:Event) : void
      {
         this.ResetSelectedBtn(this.btn_qijian);
         this._ShipModeEditUI_Body.ShowBody(5);
         this.mc_huwei.visible = false;
         this.mc_zhanlie.visible = false;
         this.mc_xuanyang.visible = false;
         this.mc_special.visible = true;
      }
      
      private function ResetSelectedBtn(param1:HButton) : void
      {
         if(this.SelectedBodyBtn != null)
         {
            this.SelectedBodyBtn.setSelect(false);
         }
         this.SelectedBodyBtn = param1;
         this.SelectedBodyBtn.setSelect(true);
      }
      
      private function btn_completeClick(param1:Event) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(GamePlayer.getInstance().UserMoney < this.ModeInfo.cash)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("DesignText3"),0);
            return;
         }
         if(ShipmodelRouter.instance.m_ShipmodelInfoAry.length >= MsgTypes.MAX_SHIPMODEL)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("DesignText4"),0);
            return;
         }
         var _loc2_:TextField = this._mc.getMC().tf_blueprintname as TextField;
         _loc2_.text = _loc2_.text.replace(/^\s*/g,"");
         _loc2_.text = _loc2_.text.replace(/\s*$/g,"");
         if(_loc2_.text == "")
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("DesignText2"),0);
            return;
         }
         if(ShipmodelRouter.instance.GetShipModelByName(_loc2_.text) != null)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CorpsText26"),0);
            return;
         }
         if(this.SelectedPartId.length == 0)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("DesignText0"),0);
            return;
         }
         if(this.ModeInfo.Locomotivity <= 0)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("DesignText1"),0);
            return;
         }
         var _loc3_:MSG_REQUEST_CREATESHIPMODEL = new MSG_REQUEST_CREATESHIPMODEL();
         _loc3_.BodyId = this._ShipModeEditUI_Body.SelecedBody.Id;
         _loc3_.ShipName = _loc2_.text;
         var _loc4_:int = 0;
         for each(_loc5_ in this.SelectedPartId)
         {
            _loc6_ = this.SelectedParts.Get(_loc5_);
            _loc7_ = 0;
            while(_loc7_ < _loc6_)
            {
               _loc3_.PartId[_loc4_] = _loc5_;
               _loc4_++;
               _loc7_++;
            }
         }
         _loc3_.PartNum = _loc4_;
         _loc3_.SeqId = GamePlayer.getInstance().seqID++;
         _loc3_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc3_);
         this.ClearView();
      }
      
      private function ClearView() : void
      {
         this.ClearText();
         this.ClearModeInfo();
         this._ShipModeEditUI_RemainPart.ClearRemainPart();
         this._ShipModeEditUI_Body.Clear();
         this.SelectedParts.Clear();
         this.SelectedPartId.length = 0;
         this.btn_frigateClick(null);
         this._ShipModeEditUI_Part.AttackClick(null);
      }
      
      public function ResetBody() : void
      {
         this.ClearModeInfo();
         this._ShipModeEditUI_RemainPart.ClearRemainPart();
         this.SelectedParts.Clear();
         this.SelectedPartId.length = 0;
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

