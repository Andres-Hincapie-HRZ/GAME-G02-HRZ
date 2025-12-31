package logic.ui
{
   import com.star.frameworks.managers.StringManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import logic.entry.GShip;
   import logic.entry.GShipTeam;
   import logic.entry.HButton;
   import logic.entry.commander.CommanderInfo;
   import logic.entry.fleet.ShipTeamInfo;
   import logic.entry.shipmodel.ShipbodyInfo;
   import logic.entry.shipmodel.ShipmodelInfo;
   import logic.entry.shipmodel.ShippartInfo;
   import logic.game.GameKernel;
   import logic.manager.GalaxyShipManager;
   import logic.reader.CShipmodelReader;
   import logic.ui.tip.ShipModelInfoTip;
   import net.common.MsgTypes;
   import net.router.CommanderRouter;
   import net.router.ShipmodelRouter;
   
   public class FleetUniteUI_Fleet
   {
      
      private const PlanBarMinX:int = 45;
      
      private const PlanBarMaxX:int = 134;
      
      private const PlanBarLen:int = 89;
      
      private var _ParentMc:MovieClip;
      
      private var _FleetId:int;
      
      private var tfH3Num:TextField;
      
      private var mcFleetGrid:MovieClip;
      
      private var BtnShape:MovieClip;
      
      public var _ShipTeamInfo:ShipTeamInfo;
      
      private var He3Num:int;
      
      private var He3Count:int;
      
      private var _FleetUniteUI:FleetUniteUI;
      
      private var TeamShipDisplay:Array = new Array();
      
      private var SelectedShipImg:MovieClip;
      
      private var SelectedModelId:int;
      
      private var ReplaceShipImg:MovieClip;
      
      private var ReplaceCellId:int;
      
      private var FleetStorage:int;
      
      private var _UnitedSelf:Boolean;
      
      public var GalaxyMapId:int;
      
      public var GalaxyId:int;
      
      private var btn_left:HButton;
      
      private var btn_right:HButton;
      
      public function FleetUniteUI_Fleet(param1:MovieClip, param2:FleetUniteUI)
      {
         super();
         this.Init(param1);
         this._FleetUniteUI = param2;
         this._ShipTeamInfo = new ShipTeamInfo();
         this._UnitedSelf = false;
      }
      
      private function Init(param1:MovieClip) : void
      {
         var _loc2_:MovieClip = null;
         this._ParentMc = param1;
         this.mcFleetGrid = this._ParentMc.mc_fleetgrid as MovieClip;
         var _loc3_:int = 0;
         while(_loc3_ < 9)
         {
            _loc2_ = this.mcFleetGrid.getChildByName("mc_base" + _loc3_) as MovieClip;
            _loc2_.addEventListener(MouseEvent.MOUSE_DOWN,this.ShipMouseDown);
            _loc2_.addEventListener(MouseEvent.MOUSE_OVER,this.ShipMouseOver);
            _loc2_.addEventListener(MouseEvent.MOUSE_OUT,this.ShipMouseOut);
            _loc2_.mouseChildren = false;
            this.TeamShipDisplay.push(_loc2_);
            _loc3_++;
         }
         this.BtnShape = param1.btn_shade as MovieClip;
         this.BtnShape.addEventListener(MouseEvent.MOUSE_DOWN,this.BtnShapeMouseDown);
         this.mcFleetGrid.mouseEnabled = true;
         _loc2_ = this._ParentMc.btn_left as MovieClip;
         this.btn_left = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_leftClick);
         _loc2_ = this._ParentMc.btn_right as MovieClip;
         this.btn_right = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_rightClick);
      }
      
      public function UnitedSelf(param1:Boolean) : void
      {
         this._UnitedSelf = param1;
         this.btn_left.setBtnDisabled(param1);
         this.btn_right.setBtnDisabled(param1);
         this.BtnShape.mouseEnabled = !param1;
      }
      
      public function InitValue(param1:int) : int
      {
         var _loc2_:GShipTeam = null;
         var _loc7_:CommanderInfo = null;
         var _loc8_:int = 0;
         var _loc9_:GShip = null;
         var _loc10_:TextField = null;
         var _loc11_:ShipmodelInfo = null;
         var _loc12_:ShipbodyInfo = null;
         var _loc13_:MovieClip = null;
         if(param1 == -1)
         {
            this._FleetId = -1;
            this._ParentMc.visible = false;
            return 0;
         }
         this._ParentMc.visible = true;
         this._FleetId = param1;
         _loc2_ = GalaxyShipManager.instance.getShipDatas(param1);
         this.He3Num = _loc2_.Gas;
         this.GalaxyMapId = _loc2_.GalaxyMapId;
         this.GalaxyId = _loc2_.GalaxyId;
         var _loc3_:MovieClip = this._ParentMc.mc_commanderbase as MovieClip;
         if(_loc3_.numChildren > 0)
         {
            _loc3_.removeChildAt(0);
         }
         var _loc4_:Bitmap = CommanderSceneUI.getInstance().CommanderImg(_loc2_.CommanderID);
         _loc4_.width = 50;
         _loc4_.height = 50;
         _loc3_.addChild(_loc4_);
         var _loc5_:TextField = this._ParentMc.tf_commandergrade as TextField;
         _loc5_.text = (_loc2_.LevelId + 1).toString();
         var _loc6_:TextField = this._ParentMc.tf_fleetname as TextField;
         _loc6_.text = _loc2_.TeamName;
         for each(_loc7_ in CommanderRouter.instance.m_commandInfoAry)
         {
            if(_loc7_.commander_commanderId == _loc2_.CommanderID)
            {
               _loc6_ = this._ParentMc.tf_commandername as TextField;
               _loc6_.text = _loc7_.commander_name;
               break;
            }
         }
         this.tfH3Num = this._ParentMc.tf_he3num as TextField;
         this.tfH3Num.text = this.He3Num.toString();
         this.mcFleetGrid = this._ParentMc.mc_fleetgrid as MovieClip;
         _loc8_ = 0;
         while(_loc8_ < 9)
         {
            _loc9_ = _loc2_.TeamBody[_loc8_];
            if(_loc9_ == null || _loc9_.Num <= 0)
            {
               this._ShipTeamInfo.ShipModelId[_loc8_] = -1;
               this._ShipTeamInfo.Num[_loc8_] = 0;
            }
            else
            {
               this._ShipTeamInfo.ShipModelId[_loc8_] = _loc9_.ShipModelId;
               this._ShipTeamInfo.Num[_loc8_] = _loc9_.Num;
            }
            _loc3_ = this.TeamShipDisplay[_loc8_];
            _loc10_ = _loc3_.getChildByName("tf_num") as TextField;
            _loc3_ = _loc3_.mc_base as MovieClip;
            if(_loc3_.numChildren)
            {
               _loc3_.removeChildAt(0);
            }
            if(_loc9_ != null && _loc9_.ShipModelId != -1 && _loc9_.Num > 0)
            {
               _loc11_ = ShipmodelRouter.instance.ShipModeList.Get(_loc9_.ShipModelId);
               _loc12_ = CShipmodelReader.getInstance().getShipBodyInfo(_loc11_.m_BodyId);
               _loc13_ = this.GetShipImage(_loc12_.SmallIcon,25,30);
               _loc13_.stop();
               _loc3_.addChild(_loc13_);
               _loc10_.text = _loc9_.Num.toString();
            }
            else
            {
               _loc10_.text = "";
            }
            _loc8_++;
         }
         this.GetFleetStorage();
         if(this.He3Num > this.FleetStorage)
         {
            this.He3Num = this.FleetStorage;
         }
         return this.He3Num;
      }
      
      private function GetShipImage(param1:String, param2:int = 0, param3:int = 0) : MovieClip
      {
         var _loc4_:MovieClip = GameKernel.getMovieClipInstance("moban",param2,param3);
         var _loc5_:Bitmap = new Bitmap(GameKernel.getTextureInstance(param1));
         _loc5_.x = -33;
         _loc5_.y = -25;
         _loc5_.smoothing = true;
         _loc4_.addChild(_loc5_);
         _loc4_.width = 50;
         _loc4_.height = 50;
         return _loc4_;
      }
      
      public function GetFleetId() : int
      {
         return this._FleetId;
      }
      
      public function GetHe3Num() : int
      {
         return this.He3Num;
      }
      
      private function ShipMouseOver(param1:Event) : void
      {
         var _loc4_:int = 0;
         var _loc5_:Point = null;
         var _loc2_:MovieClip = param1.target as MovieClip;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:int = int(_loc2_.name.substring(7));
         if(_loc3_ >= 0)
         {
            if(this._ShipTeamInfo.ShipModelId[_loc3_] == -1)
            {
               return;
            }
            _loc4_ = int(this._ShipTeamInfo.ShipModelId[_loc3_]);
            _loc5_ = _loc2_.localToGlobal(new Point(20,30));
            ShipModelInfoTip.GetInstance().Show(_loc4_,_loc5_);
         }
      }
      
      private function ShipMouseOut(param1:Event) : void
      {
         ShipModelInfoTip.GetInstance().Hide();
      }
      
      private function ShipMouseDown(param1:Event) : void
      {
         var _loc4_:int = 0;
         var _loc5_:ShipmodelInfo = null;
         var _loc6_:ShipbodyInfo = null;
         var _loc7_:Point = null;
         var _loc8_:MovieClip = null;
         var _loc2_:MovieClip = param1.target as MovieClip;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:int = int(_loc2_.name.substring(7));
         if(_loc3_ >= 0)
         {
            if(this._ShipTeamInfo.ShipModelId[_loc3_] == -1)
            {
               return;
            }
            _loc4_ = int(this._ShipTeamInfo.ShipModelId[_loc3_]);
            _loc5_ = ShipmodelRouter.instance.ShipModeList.Get(_loc4_);
            _loc6_ = CShipmodelReader.getInstance().getShipBodyInfo(_loc5_.m_BodyId);
            _loc7_ = _loc2_.localToGlobal(new Point(17,17));
            _loc8_ = this.GetShipImage(_loc6_.SmallIcon,22,22);
            this._FleetUniteUI.SelectedShip(this,_loc7_,_loc8_,_loc3_,this._FleetId,this._ShipTeamInfo.ShipModelId[_loc3_],this._ShipTeamInfo.Num[_loc3_]);
         }
      }
      
      public function SetHe3Count(param1:int) : void
      {
         this.He3Count = param1;
         this.ShowHe3Num();
      }
      
      public function DeleteHe3Count(param1:int) : void
      {
         this.He3Num -= param1;
         this.CheckHe3Num();
      }
      
      public function CheckHe3Num() : void
      {
         var _loc1_:int = 0;
         if(this._UnitedSelf)
         {
            return;
         }
         if(this.He3Num > this.FleetStorage)
         {
            _loc1_ = this.He3Num;
            this.He3Num = this.FleetStorage;
            this._FleetUniteUI.DeleteHe3Count(this,this.FleetStorage - _loc1_);
         }
         else if(this.He3Num < 0)
         {
            _loc1_ = this.He3Num;
            this.He3Num = 0;
            this._FleetUniteUI.DeleteHe3Count(this,_loc1_);
         }
         this.ShowHe3Num();
      }
      
      private function ShowHe3Num() : void
      {
         var _loc1_:int = this.PlanBarLen * (this.He3Num / this.He3Count);
         var _loc2_:int = this.PlanBarMinX + _loc1_;
         this.BtnShape.x = _loc2_;
         if(this.BtnShape.x - this.PlanBarMinX < 0)
         {
         }
         this.tfH3Num.text = this.He3Num.toString() + "/" + this.FleetStorage;
      }
      
      private function GetFleetStorage() : void
      {
         var _loc1_:int = 0;
         var _loc3_:ShipmodelInfo = null;
         var _loc4_:ShipbodyInfo = null;
         var _loc5_:int = 0;
         var _loc6_:ShippartInfo = null;
         this.FleetStorage = 0;
         var _loc2_:int = 0;
         while(_loc2_ < 9)
         {
            if(this._ShipTeamInfo.ShipModelId[_loc2_] >= 0)
            {
               _loc3_ = ShipmodelRouter.instance.ShipModeList.Get(this._ShipTeamInfo.ShipModelId[_loc2_]);
               _loc4_ = CShipmodelReader.getInstance().getShipBodyInfo(_loc3_.m_BodyId);
               _loc1_ = _loc4_.Storage;
               _loc5_ = 0;
               while(_loc5_ < _loc3_.m_PartNum)
               {
                  _loc6_ = CShipmodelReader.getInstance().getShipPartInfo(_loc3_.m_PartId[_loc5_]);
                  _loc1_ += _loc6_.Storage;
                  _loc5_++;
               }
               this.FleetStorage += _loc1_ * this._ShipTeamInfo.Num[_loc2_];
            }
            _loc2_++;
         }
      }
      
      private function BtnShapeMouseDown(param1:Event) : void
      {
         if(this._UnitedSelf)
         {
            return;
         }
         this._ParentMc.mouseEnabled = true;
         this._ParentMc.addEventListener(MouseEvent.MOUSE_MOVE,this.BtnShapeMove);
         this._ParentMc.addEventListener(MouseEvent.MOUSE_UP,this.BtnShapeMoveOver);
      }
      
      private function BtnShapeMove(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         if(_loc2_ == null)
         {
            this._ParentMc.mouseEnabled = false;
            this._ParentMc.removeEventListener(MouseEvent.MOUSE_MOVE,this.BtnShapeMove);
            this._ParentMc.removeEventListener(MouseEvent.MOUSE_UP,this.BtnShapeMoveOver);
            return;
         }
         var _loc3_:Point = _loc2_.localToGlobal(new Point(param1.localX,param1.localY));
         _loc3_ = this._ParentMc.globalToLocal(_loc3_);
         if(_loc3_.x < this.PlanBarMinX)
         {
            _loc3_.x = this.PlanBarMinX;
         }
         else if(_loc3_.x > this.PlanBarMaxX)
         {
            _loc3_.x = this.PlanBarMaxX;
         }
         this.BtnShape.x = _loc3_.x;
         this.ResetHe3();
      }
      
      private function ResetHe3() : void
      {
         var _loc3_:int = 0;
         var _loc1_:int = this.BtnShape.x - this.PlanBarMinX;
         var _loc2_:int = this.He3Count * (_loc1_ / this.PlanBarLen);
         if(_loc2_ > this.FleetStorage)
         {
            _loc3_ = this.He3Num;
            this.He3Num = this.FleetStorage;
            this._FleetUniteUI.DeleteHe3Count(this,this.FleetStorage - _loc3_);
            this.ShowHe3Num();
         }
         else
         {
            _loc3_ = this.He3Num;
            this.He3Num = _loc2_;
            this.tfH3Num.text = this.He3Num.toString();
            this._FleetUniteUI.DeleteHe3Count(this,_loc2_ - _loc3_);
         }
      }
      
      private function btn_rightClick(param1:Event) : void
      {
         if(this.BtnShape.x < this.PlanBarMaxX)
         {
            ++this.BtnShape.x;
         }
         this.ResetHe3();
      }
      
      private function btn_leftClick(param1:Event) : void
      {
         if(this.BtnShape.x > this.PlanBarMinX)
         {
            --this.BtnShape.x;
         }
         this.ResetHe3();
      }
      
      private function BtnShapeMoveOver(param1:MouseEvent) : void
      {
         this._ParentMc.mouseEnabled = false;
         this._ParentMc.removeEventListener(MouseEvent.MOUSE_MOVE,this.BtnShapeMove);
         this._ParentMc.removeEventListener(MouseEvent.MOUSE_UP,this.BtnShapeMoveOver);
      }
      
      public function ReplaceShip(param1:MovieClip, param2:int, param3:int, param4:int, param5:int, param6:Point) : void
      {
         var _loc7_:int = 0;
         var _loc8_:ShipmodelInfo = null;
         var _loc9_:ShipbodyInfo = null;
         var _loc10_:MovieClip = null;
         var _loc11_:MovieClip = null;
         var _loc12_:MovieClip = null;
         this.ReplaceCellId = this.GetSelectedIndex(param6);
         this.ReplaceShipImg = param1;
         if(this.ReplaceCellId == -1)
         {
            return;
         }
         if(param3 == this._FleetId && param2 == this.ReplaceCellId)
         {
            return;
         }
         if(this._ShipTeamInfo.ShipModelId[this.ReplaceCellId] == -1 || this._ShipTeamInfo.ShipModelId[this.ReplaceCellId] == param4)
         {
            if(this._ShipTeamInfo.ShipModelId[this.ReplaceCellId] == -1)
            {
               _loc8_ = ShipmodelRouter.instance.ShipModeList.Get(param4);
               _loc9_ = CShipmodelReader.getInstance().getShipBodyInfo(_loc8_.m_BodyId);
               if(_loc9_.KindId == 5)
               {
                  MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss76"),0);
                  return;
               }
            }
            this.SelectedModelId = param4;
            _loc7_ = Math.min(MsgTypes.MAX_MATRIXSHIP - this._ShipTeamInfo.Num[this.ReplaceCellId],param5);
            if(_loc7_ > 0)
            {
               this._FleetUniteUI.ShowEnterShipNumForm(this.MoveSelectedShip,_loc7_);
            }
         }
         else
         {
            if(this.CanReplaceFagShip(param4) == false)
            {
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss76"),0);
               return;
            }
            _loc10_ = this.TeamShipDisplay[this.ReplaceCellId];
            _loc11_ = _loc10_.mc_base as MovieClip;
            _loc12_ = _loc11_.getChildAt(0) as MovieClip;
            this._FleetUniteUI.ReplaceSelectedShip(this._ShipTeamInfo.ShipModelId[this.ReplaceCellId],this._ShipTeamInfo.Num[this.ReplaceCellId],_loc12_);
            this.ResetShip(this.ReplaceCellId,param4,param5,param1);
            this.CheckHe3Num();
            this._FleetUniteUI.CheckHe3Num();
         }
      }
      
      private function CanReplaceFagShip(param1:int) : Boolean
      {
         var _loc2_:ShipmodelInfo = ShipmodelRouter.instance.ShipModeList.Get(param1);
         var _loc3_:ShipbodyInfo = CShipmodelReader.getInstance().getShipBodyInfo(_loc2_.m_BodyId);
         var _loc4_:int = int(this._ShipTeamInfo.ShipModelId[this.ReplaceCellId]);
         var _loc5_:ShipmodelInfo = ShipmodelRouter.instance.ShipModeList.Get(_loc4_);
         var _loc6_:ShipbodyInfo = CShipmodelReader.getInstance().getShipBodyInfo(_loc5_.m_BodyId);
         if(_loc3_.KindId != 5 && _loc6_.KindId != 5)
         {
            return true;
         }
         if(_loc3_.KindId == 5 && _loc6_.KindId == 5)
         {
            return true;
         }
         return false;
      }
      
      public function ResetShip(param1:int, param2:int, param3:int, param4:MovieClip) : void
      {
         this._ShipTeamInfo.ShipModelId[param1] = param2;
         this._ShipTeamInfo.Num[param1] = param3;
         var _loc5_:MovieClip = this.TeamShipDisplay[param1];
         var _loc6_:MovieClip = _loc5_.mc_base as MovieClip;
         if(_loc6_.numChildren)
         {
            _loc6_.removeChildAt(0);
         }
         param4.x = 25;
         param4.y = 30;
         _loc6_.addChild(param4);
         var _loc7_:TextField = _loc5_.tf_num as TextField;
         _loc7_.text = param3.toString();
         this.GetFleetStorage();
      }
      
      public function RemoveShip(param1:int, param2:int) : void
      {
         this._ShipTeamInfo.Num[param1] -= param2;
         var _loc3_:MovieClip = this.TeamShipDisplay[param1];
         var _loc4_:TextField = _loc3_.tf_num as TextField;
         if(this._ShipTeamInfo.Num[param1] == 0)
         {
            _loc3_ = _loc3_.mc_base as MovieClip;
            if(_loc3_.numChildren > 0)
            {
               _loc3_.removeChildAt(0);
            }
            _loc4_.text = "";
            this._ShipTeamInfo.ShipModelId[param1] = -1;
         }
         else
         {
            _loc4_.text = this._ShipTeamInfo.Num[param1].toString();
         }
         this.GetFleetStorage();
         this.CheckHe3Num();
      }
      
      private function MoveSelectedShip(param1:int) : void
      {
         if(this._ShipTeamInfo.ShipModelId[this.ReplaceCellId] == -1)
         {
            this._ShipTeamInfo.Num[this.ReplaceCellId] = param1;
            this._ShipTeamInfo.ShipModelId[this.ReplaceCellId] = this.SelectedModelId;
         }
         else
         {
            this._ShipTeamInfo.Num[this.ReplaceCellId] += param1;
         }
         var _loc2_:MovieClip = this.TeamShipDisplay[this.ReplaceCellId];
         var _loc3_:TextField = _loc2_.tf_num as TextField;
         _loc3_.text = this._ShipTeamInfo.Num[this.ReplaceCellId].toString();
         _loc2_ = _loc2_.mc_base as MovieClip;
         if(_loc2_.numChildren == 0)
         {
            this.ReplaceShipImg.x = 25;
            this.ReplaceShipImg.y = 30;
            _loc2_.addChild(this.ReplaceShipImg);
         }
         this.GetFleetStorage();
         this._FleetUniteUI.MoveSelectedShip(param1);
         this.CheckHe3Num();
      }
      
      private function GetSelectedIndex(param1:Point) : int
      {
         var _loc4_:MovieClip = null;
         var _loc2_:Point = this.mcFleetGrid.globalToLocal(param1);
         var _loc3_:int = 0;
         for each(_loc4_ in this.TeamShipDisplay)
         {
            if(_loc2_.x >= _loc4_.x && _loc2_.x <= _loc4_.x + 35 && _loc2_.y >= _loc4_.y && _loc2_.y <= _loc4_.y + 35)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
   }
}

