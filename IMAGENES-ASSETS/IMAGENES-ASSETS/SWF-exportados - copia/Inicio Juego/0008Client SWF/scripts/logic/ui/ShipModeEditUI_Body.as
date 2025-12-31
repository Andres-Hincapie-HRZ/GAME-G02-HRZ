package logic.ui
{
   import com.star.frameworks.geom.CFilter;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.entry.shipmodel.ShipbodyInfo;
   import logic.game.GameKernel;
   import logic.reader.CShipmodelReader;
   import logic.ui.tip.ShipBodyInfoTip;
   import net.router.ShipmodelRouter;
   
   public class ShipModeEditUI_Body
   {
      
      public static var CanCreate:Boolean;
      
      private var _mc:MObject;
      
      private var _EditUI:ShipModeEditUI;
      
      private var BodyDisplayList:Array;
      
      private var BodyTextList:Array;
      
      private var BodyImg:Array;
      
      private var BodyListPageIndex:int;
      
      private var LastSelectedBody:MovieClip;
      
      private var BodySelectedPage:int;
      
      private var BodyNameTextField:TextField;
      
      private var BodyList:Array;
      
      private var OtherBodyList:Array;
      
      private var BodyCount:int;
      
      public var SelecedBody:ShipbodyInfo;
      
      private var CurBodyType:int;
      
      private var SelectedBodyType:int;
      
      private var tf_page:TextField;
      
      private var btn_up:HButton;
      
      private var btn_down:HButton;
      
      private var filter:CFilter;
      
      private var EnableId:int;
      
      public function ShipModeEditUI_Body(param1:MObject, param2:ShipModeEditUI)
      {
         super();
         this._mc = param1;
         this._EditUI = param2;
         this.BodyDisplayList = new Array();
         this.BodyTextList = new Array();
         this.BodyImg = new Array();
         this.BodyList = new Array();
         this.OtherBodyList = new Array();
         this.LastSelectedBody = null;
         this.filter = ShipModeEditUI.getInstance().filter;
      }
      
      public function IniBodyList() : void
      {
         var _loc1_:HButton = null;
         var _loc3_:DisplayObject = null;
         var _loc4_:MovieClip = null;
         var _loc6_:DisplayObject = null;
         var _loc7_:XMovieClip = null;
         var _loc2_:MovieClip = this._mc.getMC().mc_airshiplist;
         this.BodyNameTextField = this._mc.getMC().tf_airshipname as TextField;
         _loc3_ = _loc2_.getChildByName("btn_up");
         this.btn_up = new HButton(_loc3_ as MovieClip);
         _loc3_.addEventListener(MouseEvent.CLICK,this.BodyPrePage);
         _loc3_ = _loc2_.getChildByName("btn_down");
         this.btn_down = new HButton(_loc3_ as MovieClip);
         _loc3_.addEventListener(MouseEvent.CLICK,this.BodyNextPage);
         this.tf_page = _loc2_.getChildByName("tf_page") as TextField;
         var _loc5_:int = 0;
         while(_loc5_ < 5)
         {
            _loc3_ = _loc2_.getChildByName("mc_list" + _loc5_);
            _loc4_ = _loc3_ as MovieClip;
            _loc4_.stop();
            _loc4_.buttonMode = true;
            _loc4_.mouseChildren = false;
            _loc6_ = _loc2_.getChildByName("btn_cancel" + _loc5_);
            _loc6_.visible = false;
            _loc7_ = new XMovieClip(_loc4_);
            _loc7_.Data = _loc5_;
            _loc7_.OnClick = this.BodySelected;
            _loc7_.OnMouseOver = this.BodyMouseOver;
            _loc3_.addEventListener(MouseEvent.MOUSE_OUT,this.BodyMouseOut);
            _loc3_.visible = false;
            this.BodyDisplayList.push(_loc3_);
            this.BodyTextList.push(_loc4_.getChildByName("tf_shipname"));
            this.BodyImg.push(_loc4_.getChildByName("mc_base"));
            _loc5_++;
         }
      }
      
      public function Clear() : void
      {
         this.SelecedBody = null;
         this.BodyListPageIndex = 0;
         if(this.LastSelectedBody != null)
         {
            this.LastSelectedBody.gotoAndStop("up");
            this.LastSelectedBody = null;
         }
         this.BodyNameTextField.text = "";
         this.tf_page.text = "";
      }
      
      private function BodyNextPage(param1:MouseEvent) : void
      {
         ++this.BodyListPageIndex;
         this.ShowBodyCurPage();
         this.ResetSelected();
      }
      
      private function BodyPrePage(param1:MouseEvent) : void
      {
         --this.BodyListPageIndex;
         this.ShowBodyCurPage();
         this.ResetSelected();
      }
      
      private function ResetPageButton() : void
      {
         if(this.BodyListPageIndex > 0)
         {
            this.btn_up.setBtnDisabled(false);
         }
         else
         {
            this.btn_up.setBtnDisabled(true);
         }
         if((this.BodyListPageIndex + 1) * 5 < this.BodyCount)
         {
            this.btn_down.setBtnDisabled(false);
         }
         else
         {
            this.btn_down.setBtnDisabled(true);
         }
      }
      
      private function ResetSelected() : void
      {
         if(this.LastSelectedBody == null)
         {
            return;
         }
         if(this.BodySelectedPage == this.BodyListPageIndex && this.CurBodyType == this.SelectedBodyType)
         {
            this.LastSelectedBody.gotoAndStop("selected");
         }
         else
         {
            this.LastSelectedBody.gotoAndStop("up");
         }
      }
      
      private function BodySelected(param1:MouseEvent, param2:XMovieClip) : void
      {
         if(this.LastSelectedBody != null)
         {
            this.LastSelectedBody.gotoAndStop("up");
         }
         this.LastSelectedBody = param1.target as MovieClip;
         this.LastSelectedBody.gotoAndStop("selected");
         this.BodySelectedPage = this.BodyListPageIndex;
         this.SelectedBodyType = this.CurBodyType;
         if(param2.Data < this.EnableId)
         {
            CanCreate = true;
            this.SetSelectedBody(this.BodyList[this.BodyListPageIndex * 5 + param2.Data]);
         }
         else
         {
            CanCreate = false;
            this.SetSelectedBody(this.OtherBodyList[this.BodyListPageIndex * 5 + param2.Data - this.BodyList.length]);
         }
         this._EditUI.ShowModeInfo();
      }
      
      public function ShowBody(param1:int) : void
      {
         var _loc2_:ShipbodyInfo = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Array = null;
         this.BodyList.length = 0;
         var _loc3_:int = 0;
         while(_loc3_ < ShipmodelRouter.instance.ShipBodyIds.length)
         {
            _loc4_ = int(ShipmodelRouter.instance.ShipBodyIds[_loc3_]);
            _loc2_ = CShipmodelReader.getInstance().getShipBodyInfo(_loc4_);
            if(_loc2_.KindId == param1)
            {
               _loc5_ = _loc2_.GroupID;
               if(_loc2_.GroupLV > 1)
               {
                  _loc6_ = CShipmodelReader.getInstance().GetBodyIdsByGroupId(param1,_loc5_,_loc2_.GroupLV);
                  this.BodyList = this.BodyList.concat(_loc6_);
               }
               this.BodyList.push(ShipmodelRouter.instance.ShipBodyIds[_loc3_]);
            }
            _loc3_++;
         }
         this.BodyList.sort(Array.NUMERIC);
         this.GetOtherBodyArray(param1);
         this.BodyListPageIndex = 0;
         this.CurBodyType = param1;
         this.ShowBodyCurPage();
         this.ResetSelected();
      }
      
      private function GetOtherBodyArray(param1:int) : void
      {
         var _loc3_:int = 0;
         this.OtherBodyList.splice(0);
         var _loc2_:Array = CShipmodelReader.getInstance().GetBodyArrayByType(param1);
         this.BodyCount = _loc2_.length;
         for each(_loc3_ in _loc2_)
         {
            if(this.BodyList.indexOf(_loc3_) < 0)
            {
               this.OtherBodyList.push(_loc3_);
            }
         }
      }
      
      private function ShowBodyCurPage() : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:TextField = null;
         var _loc5_:int = 0;
         this.tf_page.text = this.BodyListPageIndex + 1 + "";
         var _loc1_:int = this.BodyListPageIndex * 5;
         this.EnableId = 5;
         var _loc4_:int = 0;
         while(_loc4_ < 5)
         {
            _loc2_ = this.BodyDisplayList[_loc4_] as MovieClip;
            if(_loc1_ < this.BodyList.length)
            {
               _loc5_ = int(this.BodyList[_loc1_]);
               this.ShowBodyItem(_loc5_,_loc4_);
               _loc2_.visible = true;
            }
            else if(_loc1_ < this.BodyCount)
            {
               if(_loc4_ < this.EnableId)
               {
                  this.EnableId = _loc4_;
               }
               _loc2_.visible = true;
               this.ShowBodyItem(this.OtherBodyList[_loc1_ - this.BodyList.length],_loc4_,true);
            }
            else
            {
               _loc2_.visible = false;
            }
            _loc1_++;
            _loc4_++;
         }
         this.ResetPageButton();
      }
      
      private function ShowBodyItem(param1:int, param2:int, param3:Boolean = false) : void
      {
         var _loc4_:ShipbodyInfo = CShipmodelReader.getInstance().getShipBodyInfo(param1);
         var _loc5_:MovieClip = this.BodyImg[param2] as MovieClip;
         if(_loc5_.numChildren > 0)
         {
            _loc5_.removeChildAt(0);
         }
         var _loc6_:MovieClip = this.GetShipImage(_loc4_.SmallIcon,18,27);
         _loc6_.filters = this.filter.getFilter(param3);
         if(param3)
         {
            _loc6_.alpha = 0.5;
         }
         else
         {
            _loc6_.alpha = 1;
         }
         _loc5_.addChild(_loc6_);
      }
      
      private function GetShipImage(param1:String, param2:int = 0, param3:int = 0) : MovieClip
      {
         var _loc4_:MovieClip = GameKernel.getMovieClipInstance("moban",param2,param3);
         _loc4_.width = 53;
         _loc4_.height = 53;
         var _loc5_:Bitmap = new Bitmap(GameKernel.getTextureInstance(param1));
         _loc5_.x = -25;
         _loc5_.y = -25;
         _loc5_.smoothing = true;
         _loc4_.addChild(_loc5_);
         return _loc4_;
      }
      
      private function BodyMouseOver(param1:MouseEvent, param2:XMovieClip) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         if(param2.Data >= this.EnableId)
         {
            _loc3_ = int(this.OtherBodyList[this.BodyListPageIndex * 5 + param2.Data - this.BodyList.length]);
            _loc4_ = true;
         }
         else
         {
            _loc3_ = int(this.BodyList[this.BodyListPageIndex * 5 + param2.Data]);
         }
         var _loc5_:ShipbodyInfo = CShipmodelReader.getInstance().getShipBodyInfo(_loc3_);
         var _loc6_:MovieClip = param1.target as MovieClip;
         var _loc7_:Point = _loc6_.localToGlobal(new Point(70,5));
         ShipBodyInfoTip.GetInstance().ShowSimple(_loc5_.Id,_loc7_,_loc4_);
      }
      
      private function BodyMouseOut(param1:MouseEvent) : void
      {
         ShipBodyInfoTip.GetInstance().Hide();
      }
      
      private function SetSelectedBody(param1:int) : void
      {
         if(param1 == -1)
         {
            return;
         }
         var _loc2_:ShipbodyInfo = CShipmodelReader.getInstance().getShipBodyInfo(param1);
         this._EditUI.ResetBody();
         this.SelecedBody = _loc2_;
         this.AddBody();
         this.BodyNameTextField.text = this.SelecedBody.Name;
      }
      
      private function RemoveBody() : void
      {
         var _loc1_:ShipbodyInfo = this.SelecedBody;
         this._EditUI.ModeInfo.metal -= _loc1_.Metal;
         this._EditUI.ModeInfo.he3 -= _loc1_.He3;
         this._EditUI.ModeInfo.cash -= _loc1_.Money;
         this._EditUI.ModeInfo.Shield -= _loc1_.Shield;
         this._EditUI.ModeInfo.Endure -= _loc1_.Endure;
         this._EditUI.ModeInfo.Locomotivity -= _loc1_.Locomotivity;
         this._EditUI.ModeInfo.Cubage -= _loc1_.Cubage;
         this._EditUI.ModeInfo.Storage -= _loc1_.Storage;
         this._EditUI.ModeInfo.Yare -= _loc1_.Yare;
         this._EditUI.ModeInfo.UnitSupply -= _loc1_.UnitSupply;
         this._EditUI.ModeInfo.TransitionTime -= _loc1_.TransitionTime;
         this._EditUI.ModeInfo.BodyCubage = 0;
      }
      
      private function AddBody() : void
      {
         var _loc1_:ShipbodyInfo = this.SelecedBody;
         this._EditUI.ModeInfo.metal += _loc1_.Metal;
         this._EditUI.ModeInfo.he3 += _loc1_.He3;
         this._EditUI.ModeInfo.cash += _loc1_.Money;
         this._EditUI.ModeInfo.Shield += _loc1_._Shield;
         this._EditUI.ModeInfo.Endure += _loc1_._Endure;
         this._EditUI.ModeInfo.ShieldUpgrade += _loc1_.Shield - _loc1_._Shield;
         this._EditUI.ModeInfo.EndureUpgrade += _loc1_.Endure - _loc1_._Endure;
         this._EditUI.ModeInfo.Locomotivity += _loc1_.Locomotivity;
         this._EditUI.ModeInfo.Cubage += _loc1_.Cubage;
         this._EditUI.ModeInfo.Storage += _loc1_.Storage;
         this._EditUI.ModeInfo.Yare += _loc1_.Yare;
         this._EditUI.ModeInfo.UnitSupply += _loc1_.UnitSupply;
         this._EditUI.ModeInfo.CreateTime = _loc1_.CreateTime;
         this._EditUI.ModeInfo.BodyCubage = _loc1_.Cubage;
         this._EditUI.ModeInfo.TransitionTime = _loc1_.TransitionTime;
      }
   }
}

