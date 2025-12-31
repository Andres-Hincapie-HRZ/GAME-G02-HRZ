package logic.ui
{
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import logic.entry.MObject;
   import logic.entry.shipmodel.ShippartInfo;
   import logic.game.GameKernel;
   import logic.reader.CShipmodelReader;
   import logic.ui.tip.ShipPartInfoTip;
   
   public class ShipModeEditUI_RemainPart
   {
      
      private var _mc:MObject;
      
      private var _EditUI:ShipModeEditUI;
      
      private var LastSelectedRemainPart:MovieClip;
      
      private var RemainPartSelectedPage:int;
      
      private var RemainPartListPageIndex:int;
      
      private var RemainPartDisplayList:Array;
      
      private var RemainPartNumTextList:Array;
      
      private var RemainPartImg:Array;
      
      public function ShipModeEditUI_RemainPart(param1:MObject, param2:ShipModeEditUI)
      {
         super();
         this._mc = param1;
         this._EditUI = param2;
         this.RemainPartDisplayList = new Array();
         this.RemainPartNumTextList = new Array();
         this.RemainPartImg = new Array();
         this.LastSelectedRemainPart = null;
      }
      
      public function IniRemainPart() : void
      {
         var _loc3_:DisplayObject = null;
         var _loc4_:MovieClip = null;
         var _loc5_:TextField = null;
         var _loc6_:MovieClip = null;
         var _loc1_:MovieClip = this._mc.getMC().mc_fitmodule;
         var _loc2_:int = 0;
         while(_loc2_ < 50)
         {
            _loc3_ = _loc1_.getChildByName("mc_list" + _loc2_);
            _loc4_ = _loc3_ as MovieClip;
            _loc3_.visible = false;
            this.RemainPartDisplayList.push(_loc3_);
            _loc5_ = _loc4_.getChildByName("tf_num") as TextField;
            _loc5_.mouseEnabled = false;
            this.RemainPartNumTextList.push(_loc5_);
            _loc6_ = _loc4_.getChildByName("mc_base") as MovieClip;
            _loc6_.buttonMode = true;
            _loc6_.addEventListener(MouseEvent.CLICK,this.DeleteRemainPart);
            _loc6_.addEventListener(MouseEvent.MOUSE_OVER,this.RemainPartSelected);
            _loc6_.addEventListener(MouseEvent.MOUSE_OUT,this.RemainPartMouseOut);
            this.RemainPartImg.push(_loc6_);
            _loc2_++;
         }
      }
      
      public function ClearRemainPart() : void
      {
         var _loc3_:MovieClip = null;
         var _loc1_:MovieClip = this._mc.getMC().mc_fitmodule;
         var _loc2_:int = 0;
         while(_loc2_ < 50)
         {
            _loc3_ = _loc1_.getChildByName("mc_list" + _loc2_) as MovieClip;
            _loc3_.visible = false;
            _loc2_++;
         }
         if(this.LastSelectedRemainPart != null)
         {
            this.LastSelectedRemainPart.gotoAndStop("up");
            this.LastSelectedRemainPart = null;
         }
      }
      
      public function ShowRemainPartCurPage() : void
      {
         var _loc2_:ShippartInfo = null;
         var _loc3_:MovieClip = null;
         var _loc4_:TextField = null;
         var _loc6_:int = 0;
         var _loc7_:MovieClip = null;
         var _loc8_:Bitmap = null;
         var _loc1_:int = 0;
         var _loc5_:int = 0;
         while(_loc5_ < 50)
         {
            _loc3_ = this.RemainPartDisplayList[_loc5_] as MovieClip;
            if(_loc1_ < this._EditUI.SelectedParts.Keys().length)
            {
               _loc6_ = int(this._EditUI.SelectedPartId[_loc1_]);
               _loc1_++;
               _loc2_ = CShipmodelReader.getInstance().getShipPartInfo(_loc6_);
               _loc4_ = this.RemainPartNumTextList[_loc5_] as TextField;
               _loc4_.text = this._EditUI.SelectedParts.Get(_loc6_);
               _loc7_ = this.RemainPartImg[_loc5_] as MovieClip;
               if(_loc7_.numChildren > 0)
               {
                  _loc7_.removeChildAt(0);
               }
               _loc8_ = new Bitmap(GameKernel.getTextureInstance(_loc2_.ImageFileName));
               _loc8_.width = 30;
               _loc8_.height = 30;
               _loc7_.addChild(_loc8_);
               _loc3_.visible = true;
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc5_++;
         }
      }
      
      private function DeleteRemainPart(param1:MouseEvent) : void
      {
         if(this.LastSelectedRemainPart == null)
         {
            return;
         }
         var _loc2_:int = int(this.LastSelectedRemainPart.name.substr(7));
         var _loc3_:int = int(this._EditUI.SelectedPartId[_loc2_]);
         var _loc4_:* = this._EditUI.SelectedParts.Get(_loc3_);
         _loc4_ = _loc4_ - 1;
         if(_loc4_ == 0)
         {
            this._EditUI.SelectedParts.Remove(_loc3_);
            this._EditUI.SelectedPartId.splice(_loc2_,1);
         }
         else
         {
            this._EditUI.SelectedParts.Put(_loc3_,_loc4_);
         }
         this._EditUI.RemovePart(CShipmodelReader.getInstance().getShipPartInfo(_loc3_));
         this.ShowRemainPartCurPage();
         this._EditUI.ShowModeInfo();
      }
      
      private function RemainPartSelected(param1:MouseEvent) : void
      {
         var _loc3_:DisplayObject = null;
         var _loc2_:MovieClip = param1.target as MovieClip;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.name == "btn_cancel")
         {
            return;
         }
         if(this.LastSelectedRemainPart != null)
         {
            this.LastSelectedRemainPart.gotoAndStop("up");
         }
         this.LastSelectedRemainPart = param1.target as MovieClip;
         this.LastSelectedRemainPart = this.LastSelectedRemainPart.parent as MovieClip;
         if(this.LastSelectedRemainPart == null)
         {
            return;
         }
         this.LastSelectedRemainPart.gotoAndStop("selected");
         this.RemainPartSelectedPage = this.RemainPartListPageIndex;
         var _loc4_:int = int(this.LastSelectedRemainPart.name.substr(7));
         var _loc5_:int = int(this._EditUI.SelectedPartId[_loc4_]);
         var _loc6_:Point = this.LastSelectedRemainPart.localToGlobal(new Point(25,25));
         ShipPartInfoTip.GetInstance().ShowSimple(_loc5_,_loc6_);
      }
      
      private function RemainPartMouseOut(param1:MouseEvent) : void
      {
         ShipPartInfoTip.GetInstance().Hide();
      }
      
      private function ResetRemainPartSelected() : void
      {
         if(this.LastSelectedRemainPart == null)
         {
            return;
         }
         if(this.RemainPartSelectedPage == this.RemainPartListPageIndex)
         {
            this.LastSelectedRemainPart.gotoAndStop("selected");
         }
         else
         {
            this.LastSelectedRemainPart.gotoAndStop("up");
         }
      }
   }
}

