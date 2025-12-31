package logic.ui
{
   import com.star.frameworks.geom.CFilter;
   import com.star.frameworks.managers.StringManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import logic.entry.HButton;
   import logic.entry.HButtonType;
   import logic.entry.MObject;
   import logic.entry.shipmodel.ShippartInfo;
   import logic.game.GameKernel;
   import logic.reader.CShipmodelReader;
   import logic.ui.tip.ShipPartInfoTip;
   import net.router.ShipmodelRouter;
   
   public class ShipModeEditUI_Part
   {
      
      private var _mc:MObject;
      
      private var _EditUI:ShipModeEditUI;
      
      private var LastSelectedPart:MovieClip;
      
      private var PartSelectedPage:int;
      
      private var PartListPageIndex:int;
      
      private var PartDisplayList:Array;
      
      private var PartTextList:Array;
      
      private var PartImg:Array;
      
      private var LastPartComboBox:Object;
      
      private var PartPage:TextField;
      
      private var PartList:Array;
      
      private var OtherPartList:Array;
      
      private var PartCount:int;
      
      private var PartPageNext:HButton;
      
      private var PartPagePre:HButton;
      
      private var SelectedFuncBtn:HButton;
      
      private var SelectedTypeBtn:HButton;
      
      private var btn_attack:HButton;
      
      private var btn_defense:HButton;
      
      private var btn_assistant:HButton;
      
      private var btn_duixing:HButton;
      
      private var btn_trajectory:HButton;
      
      private var btn_directional:HButton;
      
      private var btn_zhidao:HButton;
      
      private var btn_carrierplane:HButton;
      
      private var btn_jiegou:HButton;
      
      private var btn_hudun:HButton;
      
      private var btn_fangkong:HButton;
      
      private var btn_dianzi:HButton;
      
      private var btn_yueqian:HButton;
      
      private var btn_cunchu:HButton;
      
      private var filter:CFilter;
      
      private var EnableId:int;
      
      public function ShipModeEditUI_Part(param1:MObject, param2:ShipModeEditUI)
      {
         super();
         this._mc = param1;
         this._EditUI = param2;
         this.PartDisplayList = new Array();
         this.PartTextList = new Array();
         this.PartImg = new Array();
         this.PartList = new Array();
         this.OtherPartList = new Array();
         this.LastPartComboBox = null;
         this.filter = ShipModeEditUI.getInstance().filter;
      }
      
      public function IniPart() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:HButton = null;
         _loc1_ = this._mc.getMC().btn_attack as MovieClip;
         this.btn_attack = new HButton(_loc1_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("IconText17"));
         _loc1_.addEventListener(MouseEvent.CLICK,this.AttackClick);
         _loc1_ = this._mc.getMC().btn_defense as MovieClip;
         this.btn_defense = new HButton(_loc1_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("IconText18"));
         _loc1_.addEventListener(MouseEvent.CLICK,this.DefenseClick);
         _loc1_ = this._mc.getMC().btn_assistant as MovieClip;
         this.btn_assistant = new HButton(_loc1_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("IconText19"));
         _loc1_.addEventListener(MouseEvent.CLICK,this.AssistantClick);
         _loc1_ = this._mc.getMC().btn_duixing as MovieClip;
         this.btn_duixing = new HButton(_loc1_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("IconText24"));
         _loc1_.addEventListener(MouseEvent.CLICK,this.DuixingClick);
         _loc1_ = this._mc.getMC().btn_trajectory as MovieClip;
         this.btn_trajectory = new HButton(_loc1_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("IconText25"));
         _loc1_.addEventListener(MouseEvent.CLICK,this.TrajectoryClick);
         _loc1_ = this._mc.getMC().btn_directional as MovieClip;
         this.btn_directional = new HButton(_loc1_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("IconText26"));
         _loc1_.addEventListener(MouseEvent.CLICK,this.DirectionalClick);
         _loc1_ = this._mc.getMC().btn_zhidao as MovieClip;
         this.btn_zhidao = new HButton(_loc1_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("IconText27"));
         _loc1_.addEventListener(MouseEvent.CLICK,this.ZhidaoClick);
         _loc1_ = this._mc.getMC().btn_carrierplane as MovieClip;
         this.btn_carrierplane = new HButton(_loc1_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("IconText28"));
         _loc1_.addEventListener(MouseEvent.CLICK,this.CarrierplaneClick);
         _loc1_ = this._mc.getMC().btn_jiegou as MovieClip;
         this.btn_jiegou = new HButton(_loc1_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("IconText29"));
         _loc1_.addEventListener(MouseEvent.CLICK,this.JiegouClick);
         _loc1_ = this._mc.getMC().btn_hudun as MovieClip;
         this.btn_hudun = new HButton(_loc1_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("IconText30"));
         _loc1_.addEventListener(MouseEvent.CLICK,this.HudunClick);
         _loc1_ = this._mc.getMC().btn_fangkong as MovieClip;
         this.btn_fangkong = new HButton(_loc1_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("IconText31"));
         _loc1_.addEventListener(MouseEvent.CLICK,this.FangkongClick);
         _loc1_ = this._mc.getMC().btn_dianzi as MovieClip;
         this.btn_dianzi = new HButton(_loc1_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("IconText32"));
         _loc1_.addEventListener(MouseEvent.CLICK,this.DianziClick);
         _loc1_ = this._mc.getMC().btn_yueqian as MovieClip;
         this.btn_yueqian = new HButton(_loc1_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("IconText33"));
         _loc1_.addEventListener(MouseEvent.CLICK,this.YueqianClick);
         _loc1_ = this._mc.getMC().btn_cunchu as MovieClip;
         this.btn_cunchu = new HButton(_loc1_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("IconText34"));
         _loc1_.addEventListener(MouseEvent.CLICK,this.CunchuClick);
      }
      
      private function SetButtonVisible(param1:Boolean, param2:Boolean, param3:Boolean) : void
      {
         var _loc4_:MovieClip = null;
         _loc4_ = this._mc.getMC().btn_duixing as MovieClip;
         _loc4_.visible = param1;
         _loc4_ = this._mc.getMC().btn_trajectory as MovieClip;
         _loc4_.visible = param1;
         _loc4_ = this._mc.getMC().btn_directional as MovieClip;
         _loc4_.visible = param1;
         _loc4_ = this._mc.getMC().btn_zhidao as MovieClip;
         _loc4_.visible = param1;
         _loc4_ = this._mc.getMC().btn_carrierplane as MovieClip;
         _loc4_.visible = param1;
         _loc4_ = this._mc.getMC().btn_jiegou as MovieClip;
         _loc4_.visible = param2;
         _loc4_ = this._mc.getMC().btn_hudun as MovieClip;
         _loc4_.visible = param2;
         _loc4_ = this._mc.getMC().btn_fangkong as MovieClip;
         _loc4_.visible = param2;
         _loc4_ = this._mc.getMC().btn_dianzi as MovieClip;
         _loc4_.visible = param3;
         _loc4_ = this._mc.getMC().btn_yueqian as MovieClip;
         _loc4_.visible = param3;
         _loc4_ = this._mc.getMC().btn_cunchu as MovieClip;
         _loc4_.visible = param3;
      }
      
      public function AttackClick(param1:Event) : void
      {
         if(this.SelectedFuncBtn == this.btn_defense)
         {
            MovieClip(this._mc.getMC().mc_mask1).gotoAndPlay(8);
         }
         else
         {
            MovieClip(this._mc.getMC().mc_mask2).gotoAndPlay(8);
         }
         this.ResetSelectedFuncBtn(this.btn_attack);
         MovieClip(this._mc.getMC().mc_mask0).gotoAndPlay(2);
         this.SetButtonVisible(true,false,false);
         this.TrajectoryClick(null);
      }
      
      public function DefenseClick(param1:Event) : void
      {
         if(this.SelectedFuncBtn == this.btn_attack)
         {
            MovieClip(this._mc.getMC().mc_mask0).gotoAndPlay(8);
         }
         else
         {
            MovieClip(this._mc.getMC().mc_mask2).gotoAndPlay(8);
         }
         this.ResetSelectedFuncBtn(this.btn_defense);
         MovieClip(this._mc.getMC().mc_mask1).gotoAndPlay(2);
         this.SetButtonVisible(false,true,false);
         this.JiegouClick(param1);
      }
      
      public function AssistantClick(param1:Event) : void
      {
         if(this.SelectedFuncBtn == this.btn_attack)
         {
            MovieClip(this._mc.getMC().mc_mask0).gotoAndPlay(8);
         }
         else
         {
            MovieClip(this._mc.getMC().mc_mask1).gotoAndPlay(8);
         }
         this.ResetSelectedFuncBtn(this.btn_assistant);
         MovieClip(this._mc.getMC().mc_mask2).gotoAndPlay(2);
         this.SetButtonVisible(false,false,true);
         this.DianziClick(param1);
      }
      
      private function HideButton() : void
      {
         if(this.SelectedFuncBtn == this.btn_attack)
         {
            MovieClip(this._mc.getMC().mc_mask0).gotoAndPlay(8);
         }
         else if(this.SelectedFuncBtn == this.btn_attack)
         {
            MovieClip(this._mc.getMC().mc_mask1).gotoAndPlay(8);
         }
      }
      
      private function DuixingClick(param1:Event) : void
      {
         this.ResetSelectedTypeBtn(this.btn_duixing);
         this.ShowPart(11);
      }
      
      private function TrajectoryClick(param1:Event) : void
      {
         this.ResetSelectedTypeBtn(this.btn_trajectory);
         this.ShowPart(12);
      }
      
      private function DirectionalClick(param1:Event) : void
      {
         this.ResetSelectedTypeBtn(this.btn_directional);
         this.ShowPart(13);
      }
      
      private function ZhidaoClick(param1:Event) : void
      {
         this.ResetSelectedTypeBtn(this.btn_zhidao);
         this.ShowPart(14);
      }
      
      private function CarrierplaneClick(param1:Event) : void
      {
         this.ResetSelectedTypeBtn(this.btn_carrierplane);
         this.ShowPart(15);
      }
      
      private function JiegouClick(param1:Event) : void
      {
         this.ResetSelectedTypeBtn(this.btn_jiegou);
         this.ShowPart(1);
      }
      
      public function HudunClick(param1:Event) : void
      {
         this.ResetSelectedTypeBtn(this.btn_hudun);
         this.ShowPart(2);
      }
      
      private function FangkongClick(param1:Event) : void
      {
         this.ResetSelectedTypeBtn(this.btn_fangkong);
         this.ShowPart(4);
      }
      
      private function DianziClick(param1:Event) : void
      {
         this.ResetSelectedTypeBtn(this.btn_dianzi);
         this.ShowPart(3);
      }
      
      public function YueqianClick(param1:Event) : void
      {
         this.ResetSelectedTypeBtn(this.btn_yueqian);
         this.ShowPart(5);
      }
      
      public function CunchuClick(param1:Event) : void
      {
         this.ResetSelectedTypeBtn(this.btn_cunchu);
         this.ShowPart(6);
      }
      
      private function ResetSelectedFuncBtn(param1:HButton) : void
      {
         if(this.SelectedFuncBtn != null)
         {
            this.SelectedFuncBtn.setSelect(false);
         }
         this.SelectedFuncBtn = param1;
         this.SelectedFuncBtn.setSelect(true);
      }
      
      private function ResetSelectedTypeBtn(param1:HButton) : void
      {
         if(this.SelectedTypeBtn != null)
         {
            this.SelectedTypeBtn.setSelect(false);
         }
         this.SelectedTypeBtn = param1;
         this.SelectedTypeBtn.setSelect(true);
      }
      
      private function ShowPart(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:ShippartInfo = null;
         var _loc5_:int = 0;
         var _loc6_:Array = null;
         var _loc7_:ShippartInfo = null;
         var _loc8_:int = 0;
         if(this.LastSelectedPart != null)
         {
            this.LastSelectedPart.gotoAndStop("up");
            this.LastSelectedPart = null;
         }
         this.PartList.splice(0);
         for each(_loc2_ in ShipmodelRouter.instance.ShipPartIds)
         {
            _loc4_ = CShipmodelReader.getInstance().getShipPartInfo(_loc2_);
            if(_loc4_.KindId == param1)
            {
               _loc5_ = _loc4_.GroupID;
               if(_loc4_.GroupLV > 1)
               {
                  _loc6_ = CShipmodelReader.getInstance().GetPartIdsByGroupId(param1,_loc5_,_loc4_.GroupLV);
                  this.PartList = this.PartList.concat(_loc6_);
               }
               this.PartList.push(_loc2_);
            }
         }
         this.PartList.sort(Array.NUMERIC);
         _loc3_ = 0;
         while(_loc3_ < this.PartList.length)
         {
            _loc7_ = CShipmodelReader.getInstance().getShipPartInfo(this.PartList[_loc3_]);
            if(_loc7_.First == 1)
            {
               _loc8_ = int(this.PartList[_loc3_]);
               this.PartList.splice(_loc3_,1);
               this.PartList.unshift(_loc8_);
            }
            _loc3_++;
         }
         this.GetOtherPartArray(param1);
         this.PartListPageIndex = 0;
         this.ShowPartCurPage();
      }
      
      private function GetOtherPartArray(param1:int) : void
      {
         var _loc3_:int = 0;
         this.OtherPartList.splice(0);
         var _loc2_:Array = CShipmodelReader.getInstance().GetPartArrayByType(param1);
         this.PartCount = _loc2_.length;
         for each(_loc3_ in _loc2_)
         {
            if(this.PartList.indexOf(_loc3_) < 0)
            {
               this.OtherPartList.push(_loc3_);
            }
         }
      }
      
      private function ShowPartCurPage() : void
      {
         var _loc2_:MovieClip = null;
         var _loc4_:int = 0;
         var _loc1_:int = this.PartListPageIndex * 4;
         this.EnableId = 4;
         var _loc3_:int = 0;
         while(_loc3_ < 4)
         {
            _loc2_ = this.PartDisplayList[_loc3_] as MovieClip;
            if(_loc1_ < this.PartList.length)
            {
               _loc4_ = int(this.PartList[_loc1_]);
               this.ShowItem(_loc4_,_loc3_);
               _loc2_.visible = true;
            }
            else if(_loc1_ < this.PartCount)
            {
               if(_loc3_ < this.EnableId)
               {
                  this.EnableId = _loc3_;
               }
               _loc2_.visible = true;
               this.ShowItem(this.OtherPartList[_loc1_ - this.PartList.length],_loc3_,true);
            }
            else
            {
               _loc2_.visible = false;
            }
            _loc1_++;
            _loc3_++;
         }
         this.ResetPageButton();
      }
      
      private function ShowItem(param1:int, param2:int, param3:Boolean = false) : void
      {
         var _loc8_:Bitmap = null;
         var _loc4_:ShippartInfo = CShipmodelReader.getInstance().getShipPartInfo(param1);
         var _loc5_:TextField = this.PartTextList[param2] as TextField;
         _loc5_.text = _loc4_.Name;
         var _loc6_:TextFormat = _loc5_.getTextFormat();
         var _loc7_:MovieClip = this.PartImg[param2] as MovieClip;
         if(_loc7_.numChildren > 0)
         {
            _loc7_.removeChildAt(0);
         }
         _loc8_ = new Bitmap(GameKernel.getTextureInstance(_loc4_.ImageFileName));
         _loc8_.width = 40;
         _loc8_.height = 40;
         _loc8_.filters = this.filter.getFilter(param3);
         if(param3)
         {
            _loc8_.alpha = 0.5;
            _loc6_.color = 6710886;
         }
         else
         {
            _loc8_.alpha = 1;
            _loc6_.color = 16777215;
         }
         _loc7_.addChild(_loc8_);
         _loc5_.setTextFormat(_loc6_);
      }
      
      private function ResetPageButton() : void
      {
         this.PartPage.text = this.PartListPageIndex + 1 + "";
         if(this.PartListPageIndex == 0)
         {
            this.PartPagePre.setBtnDisabled(true);
         }
         else
         {
            this.PartPagePre.setBtnDisabled(false);
         }
         if((this.PartListPageIndex + 1) * 4 >= this.PartCount)
         {
            this.PartPageNext.setBtnDisabled(true);
         }
         else
         {
            this.PartPageNext.setBtnDisabled(false);
         }
      }
      
      private function PartSelected(param1:MouseEvent, param2:XButton) : void
      {
         var _loc3_:int = 0;
         if(this.LastSelectedPart != null)
         {
            this.LastSelectedPart.gotoAndStop("up");
         }
         this.LastSelectedPart = param1.target as MovieClip;
         this.LastSelectedPart.gotoAndStop("selected");
         this.PartSelectedPage = this.PartListPageIndex;
         var _loc4_:Boolean = false;
         if(param2.Data >= this.EnableId)
         {
            _loc3_ = int(this.OtherPartList[this.PartListPageIndex * 4 + param2.Data - this.PartList.length]);
            _loc4_ = true;
         }
         else
         {
            _loc3_ = int(this.PartList[this.PartListPageIndex * 4 + param2.Data]);
         }
         var _loc5_:ShippartInfo = CShipmodelReader.getInstance().getShipPartInfo(_loc3_);
         var _loc6_:Point = this.LastSelectedPart.localToGlobal(new Point(50,40));
         ShipPartInfoTip.GetInstance().Show(_loc5_.Id,_loc6_,_loc4_);
      }
      
      private function PartMouseOut(param1:MouseEvent) : void
      {
         ShipPartInfoTip.GetInstance().Hide();
      }
      
      public function IniPartList() : void
      {
         var _loc5_:DisplayObject = null;
         var _loc6_:MovieClip = null;
         var _loc7_:XButton = null;
         var _loc8_:DisplayObject = null;
         var _loc9_:DisplayObject = null;
         var _loc1_:MovieClip = this._mc.getMC().mc_module;
         var _loc2_:int = 0;
         while(_loc2_ < 4)
         {
            _loc5_ = _loc1_.getChildByName("mc_list" + _loc2_);
            _loc6_ = _loc5_ as MovieClip;
            _loc7_ = new XButton(_loc6_,HButtonType.SELECT);
            _loc7_.Data = _loc2_;
            _loc7_.OnClick = this.AddSelectedPart;
            _loc7_.OnMouseOver = this.PartSelected;
            _loc5_.addEventListener(MouseEvent.MOUSE_OUT,this.PartMouseOut);
            _loc8_ = _loc6_.getChildByName("btn_cancel");
            if(_loc8_ != null)
            {
               _loc8_.visible = false;
            }
            _loc5_.visible = false;
            this.PartDisplayList.push(_loc5_);
            this.PartTextList.push(_loc6_.getChildByName("tf_modulename"));
            _loc9_ = _loc6_.getChildByName("tf_modulenum");
            _loc9_.visible = false;
            this.PartImg.push(_loc6_.getChildByName("mc_base"));
            _loc2_++;
         }
         var _loc3_:MovieClip = _loc1_.getChildByName("btn_left") as MovieClip;
         this.PartPagePre = new HButton(_loc3_);
         _loc3_.addEventListener(MouseEvent.CLICK,this.PartPrePage);
         this.PartPagePre.setBtnDisabled(true);
         var _loc4_:MovieClip = _loc1_.getChildByName("btn_right") as MovieClip;
         this.PartPageNext = new HButton(_loc4_);
         _loc4_.addEventListener(MouseEvent.CLICK,this.PartNextPage);
         this.PartPageNext.setBtnDisabled(true);
         this.PartPage = _loc1_.getChildByName("tf_page") as TextField;
         this.PartPage.text = "0";
         this.AttackClick(null);
      }
      
      private function AddSelectedPart(param1:MouseEvent, param2:XButton) : void
      {
         var _loc4_:int = 0;
         if(!ShipModeEditUI_Body.CanCreate)
         {
            return;
         }
         var _loc3_:int = 0;
         for each(_loc4_ in this._EditUI.SelectedParts.Keys())
         {
            _loc3_ += this._EditUI.SelectedParts.Get(_loc4_);
         }
         if(_loc3_ >= 50)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("DesignText16"),0);
            return;
         }
         if(param2.Data >= this.EnableId)
         {
            return;
         }
         var _loc5_:int = int(this.PartList[this.PartListPageIndex * 4 + param2.Data]);
         var _loc6_:ShippartInfo = CShipmodelReader.getInstance().getShipPartInfo(_loc5_);
         if(this._EditUI.ModeInfo.Cubage - _loc6_.Cubage < 0)
         {
            return;
         }
         if(this._EditUI.AddToSelectedPartList(_loc6_.Id,_loc6_.Limit,_loc6_.Locomotivity) == false)
         {
            return;
         }
         this._EditUI.AddPart(_loc6_);
         this._EditUI.ShowModeInfo();
         this._EditUI.ShowRemainPartCurPage();
      }
      
      private function PartNextPage(param1:MouseEvent) : void
      {
         ++this.PartListPageIndex;
         this.ShowPartCurPage();
         this.ResetPartSelected();
      }
      
      private function PartPrePage(param1:MouseEvent) : void
      {
         --this.PartListPageIndex;
         this.ShowPartCurPage();
         this.ResetPartSelected();
      }
      
      private function ResetPartSelected() : void
      {
         if(this.LastSelectedPart == null)
         {
            return;
         }
         if(this.PartSelectedPage == this.PartListPageIndex)
         {
            this.LastSelectedPart.gotoAndStop("selected");
         }
         else
         {
            this.LastSelectedPart.gotoAndStop("up");
         }
      }
   }
}

