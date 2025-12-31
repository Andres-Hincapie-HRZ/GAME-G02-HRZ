package logic.ui
{
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.StringUitl;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFieldType;
   import logic.action.ConstructionAction;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.entry.shipmodel.DamageShip;
   import logic.entry.shipmodel.PartNameNum;
   import logic.entry.shipmodel.ShipModelProperty;
   import logic.entry.shipmodel.ShipTeamNum;
   import logic.entry.shipmodel.ShipbodyInfo;
   import logic.entry.shipmodel.ShipmodelInfo;
   import logic.entry.shipmodel.ShippartInfo;
   import logic.game.GameKernel;
   import logic.manager.GameInterActiveManager;
   import logic.reader.CShipmodelReader;
   import net.router.DestructionShipRouter;
   import net.router.ShipmodelRouter;
   
   public class DestructionShipUI extends AbstractPopUp
   {
      
      private static var instance:DestructionShipUI;
      
      private static const PageShipNum:int = 5;
      
      private static const PagePartNum:int = 21;
      
      private static const DamageShipNum:int = 5;
      
      private var _Close:HButton;
      
      private var _fix:HButton;
      
      private var mcairshiplistAry:Array = new Array();
      
      private var mcmodulelistAry:Array = new Array();
      
      private var mcconstructlistAry:Array = new Array();
      
      private var mcdamageAry:Array = new Array();
      
      private var mccancelAry:Array = new Array();
      
      private var _ShipUp:MovieClip;
      
      private var _ShipDown:MovieClip;
      
      private var _PartLeft:MovieClip;
      
      private var _PartRight:MovieClip;
      
      private var _DamageShipLeft:MovieClip;
      
      private var _DamageShipRight:MovieClip;
      
      private var m_shipStorageAry:Array = new Array();
      
      private var m_shipPageMaxNum:int = 0;
      
      private var m_shipPageNum:int = 0;
      
      private var m_partAry:Array = new Array();
      
      private var m_partStorageAry:Array = new Array();
      
      private var m_partPageMaxNum:int = 0;
      
      private var m_partPageNum:int = 0;
      
      private var m_DamageShipAry:Array = new Array();
      
      private var m_DamageShipStorageAry:Array = new Array();
      
      private var m_DamageShipPageMaxNum:int = 0;
      
      private var m_DamageShipPageNum:int = 0;
      
      private var m_chooseNum:int = -1;
      
      public var m_itemnameAry:Array = new Array();
      
      private var m_KindNameAry:Array = new Array();
      
      private var m_times:int = 0;
      
      public var shipinfo:ShipModelProperty = new ShipModelProperty();
      
      private var IsOverShip:Boolean;
      
      public function DestructionShipUI()
      {
         super();
         setPopUpName("DestructionShipUI");
      }
      
      public static function getinstance() : DestructionShipUI
      {
         if(instance == null)
         {
            instance = new DestructionShipUI();
         }
         return instance;
      }
      
      override public function Init() : void
      {
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            return;
         }
         this._mc = new MObject("BoatdestroyScene",400,300);
         this.initMcElement();
         GameKernel.popUpDisplayManager.Regisger(instance);
         this.m_itemnameAry.push(StringManager.getInstance().getMessageString("MailText17"));
         this.m_itemnameAry.push(StringManager.getInstance().getMessageString("DesignText9"));
         this.m_itemnameAry.push(StringManager.getInstance().getMessageString("DesignText8"));
         this.m_itemnameAry.push(StringManager.getInstance().getMessageString("DesignText13"));
         this.m_itemnameAry.push(StringManager.getInstance().getMessageString("DesignText6"));
         this.m_itemnameAry.push(StringManager.getInstance().getMessageString("FormationText19"));
         this.m_itemnameAry.push(StringManager.getInstance().getMessageString("Text1"));
         this.m_itemnameAry.push(StringManager.getInstance().getMessageString("FormationText20"));
         this.m_itemnameAry.push(StringManager.getInstance().getMessageString("DesignText10"));
         this.m_itemnameAry.push(StringManager.getInstance().getMessageString("FormationText17"));
         this.m_itemnameAry.push(StringManager.getInstance().getMessageString("FormationText21"));
         this.m_itemnameAry.push("Metal");
         this.m_itemnameAry.push("He3");
         this.m_itemnameAry.push("Gold");
         this.m_KindNameAry.push(StringManager.getInstance().getMessageString("IconText13"));
         this.m_KindNameAry.push(StringManager.getInstance().getMessageString("IconText14"));
         this.m_KindNameAry.push(StringManager.getInstance().getMessageString("IconText15"));
      }
      
      override public function initMcElement() : void
      {
         var _loc1_:MovieClip = this._mc.getMC().mc_airshiplist;
         var _loc2_:MovieClip = this._mc.getMC().mc_modulelist;
         var _loc3_:MovieClip = this._mc.getMC().mc_constructlist;
         this._Close = new HButton(this._mc.getMC().btn_close);
         GameInterActiveManager.InstallInterActiveEvent(this._Close.m_movie,ActionEvent.ACTION_CLICK,this.ChickButton);
         this._fix = new HButton(this._mc.getMC().btn_fix);
         GameInterActiveManager.InstallInterActiveEvent(this._fix.m_movie,ActionEvent.ACTION_CLICK,this.ChickButton);
         GameInterActiveManager.InstallInterActiveEvent(this._fix.m_movie,ActionEvent.ACTION_MOUSE_OVER,this.OverButton);
         GameInterActiveManager.InstallInterActiveEvent(this._fix.m_movie,ActionEvent.ACTION_MOUSE_OUT,this.OutButton);
         var _loc4_:MovieClip = this._mc.getMC().tf_planbar as MovieClip;
         _loc4_.gotoAndStop(1);
         var _loc5_:int = 0;
         while(_loc5_ < 5)
         {
            this.mcairshiplistAry[_loc5_] = _loc1_.getChildByName("mc_list" + _loc5_) as MovieClip;
            MovieClip(this.mcairshiplistAry[_loc5_]).buttonMode = true;
            this.mcairshiplistAry[_loc5_].gotoAndStop("up");
            this.mcairshiplistAry[0].gotoAndStop("selected");
            this.mcairshiplistAry[_loc5_].addEventListener(ActionEvent.ACTION_CLICK,this.ChooseShipEve);
            this.mcairshiplistAry[_loc5_].addEventListener(ActionEvent.ACTION_MOUSE_MOVE,this.OverShipEve);
            this.mcairshiplistAry[_loc5_].addEventListener(ActionEvent.ACTION_MOUSE_OUT,this.OutShipEve);
            _loc5_++;
         }
         this._ShipUp = _loc1_.btn_up as MovieClip;
         this._ShipUp.buttonMode = true;
         this._ShipUp.addEventListener(ActionEvent.ACTION_CLICK,this.ChickButton);
         this._ShipUp.addEventListener(ActionEvent.ACTION_MOUSE_OVER,this.OverButton);
         this._ShipUp.addEventListener(ActionEvent.ACTION_MOUSE_OUT,this.OutButton);
         this._ShipDown = _loc1_.btn_down as MovieClip;
         this._ShipDown.buttonMode = true;
         this._ShipDown.addEventListener(ActionEvent.ACTION_CLICK,this.ChickButton);
         this._ShipDown.addEventListener(ActionEvent.ACTION_MOUSE_OVER,this.OverButton);
         this._ShipDown.addEventListener(ActionEvent.ACTION_MOUSE_OUT,this.OutButton);
         var _loc6_:int = 0;
         while(_loc6_ < PagePartNum)
         {
            this.mcmodulelistAry[_loc6_] = _loc2_.getChildByName("mc_list" + _loc6_) as MovieClip;
            this.mcmodulelistAry[_loc6_].buttonMode = true;
            this.mcmodulelistAry[_loc6_].addEventListener(ActionEvent.ACTION_MOUSE_OVER,this.OverPartEve);
            this.mcmodulelistAry[_loc6_].addEventListener(ActionEvent.ACTION_MOUSE_OUT,this.OutPartEve);
            TextField(this.mcmodulelistAry[_loc6_].tf_num).text = "";
            _loc6_++;
         }
         this._PartLeft = _loc2_.btn_left as MovieClip;
         this._PartLeft.buttonMode = true;
         this._PartLeft.addEventListener(ActionEvent.ACTION_CLICK,this.ChickButton);
         this._PartLeft.addEventListener(ActionEvent.ACTION_MOUSE_OVER,this.OverButton);
         this._PartLeft.addEventListener(ActionEvent.ACTION_MOUSE_OUT,this.OutButton);
         this._PartRight = _loc2_.btn_right as MovieClip;
         this._PartRight.buttonMode = true;
         this._PartRight.addEventListener(ActionEvent.ACTION_CLICK,this.ChickButton);
         this._PartRight.addEventListener(ActionEvent.ACTION_MOUSE_OVER,this.OverButton);
         this._PartRight.addEventListener(ActionEvent.ACTION_MOUSE_OUT,this.OutButton);
         this._PartLeft.gotoAndStop("up");
         this._PartRight.gotoAndStop("up");
         TextField(this._mc.getMC().tf_num).type = TextFieldType.INPUT;
         TextField(this._mc.getMC().tf_num).autoSize = TextFieldAutoSize.CENTER;
         TextField(this._mc.getMC().tf_num).restrict = "0-9";
         TextField(this._mc.getMC().tf_num).addEventListener(Event.CHANGE,this.changeHd);
         TextField(this._mc.getMC().tf_num).addEventListener(ActionEvent.ACTION_CLICK,this.ChickButton);
      }
      
      public function InitPopUp() : void
      {
         this.shipstorage();
         this.showShip();
         this.ChooseShip(0);
      }
      
      public function shipmodelInfo() : void
      {
         var _loc2_:ShipTeamNum = null;
         var _loc3_:int = 0;
         var _loc4_:ShipmodelInfo = null;
         var _loc1_:int = 0;
         while(_loc1_ < DestructionShipRouter.instance.m_ShipTeamNumAry.length)
         {
            _loc2_ = DestructionShipRouter.instance.m_ShipTeamNumAry[_loc1_] as ShipTeamNum;
            _loc3_ = 0;
            while(_loc3_ < ShipmodelRouter.instance.m_ZoonShipmodelInfoAry.length)
            {
               if(DestructionShipRouter.instance.m_ShipTeamNumAry[_loc1_].ShipModelId == ShipmodelRouter.instance.m_ZoonShipmodelInfoAry[_loc3_].m_ShipModelId)
               {
                  _loc4_ = ShipmodelRouter.instance.m_ZoonShipmodelInfoAry[_loc3_] as ShipmodelInfo;
                  _loc2_.ShipName = _loc4_.m_ShipName;
                  _loc2_.BodyID = _loc4_.m_BodyId;
                  _loc2_.PartId = _loc4_.m_PartId;
                  _loc2_.PartNum = _loc4_.m_PartNum;
                  DestructionShipRouter.instance.m_ShipTeamNumAry[_loc1_] = _loc2_;
               }
               _loc3_++;
            }
            _loc1_++;
         }
      }
      
      public function shipstorage() : void
      {
         this.m_shipStorageAry.length = 0;
         if(DestructionShipRouter.instance.m_ShipTeamNumAry.length % PageShipNum != 0)
         {
            this.m_shipPageMaxNum = DestructionShipRouter.instance.m_ShipTeamNumAry.length / PageShipNum + 1;
         }
         else
         {
            this.m_shipPageMaxNum = DestructionShipRouter.instance.m_ShipTeamNumAry.length / PageShipNum;
         }
         var _loc1_:int = 0;
         while(this.m_shipPageNum * PageShipNum + _loc1_ < DestructionShipRouter.instance.m_ShipTeamNumAry.length && _loc1_ < PageShipNum)
         {
            this.m_shipStorageAry[_loc1_] = DestructionShipRouter.instance.m_ShipTeamNumAry[this.m_shipPageNum * PageShipNum + _loc1_];
            _loc1_++;
         }
      }
      
      private function ClearShipMc() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < PageShipNum)
         {
            if(this.mcairshiplistAry[_loc1_].mc_base.numChildren > 1)
            {
               this.mcairshiplistAry[_loc1_].mc_base.removeChildAt(1);
            }
            TextField(this.mcairshiplistAry[_loc1_].tf_num).text = "";
            _loc1_++;
         }
      }
      
      public function showShip() : void
      {
         var _loc2_:ShipTeamNum = null;
         var _loc3_:String = null;
         var _loc4_:Bitmap = null;
         this.ClearShipMc();
         var _loc1_:int = 0;
         while(_loc1_ < this.m_shipStorageAry.length)
         {
            _loc2_ = this.m_shipStorageAry[_loc1_] as ShipTeamNum;
            _loc3_ = CShipmodelReader.getInstance().getShipBodyInfo(_loc2_.BodyID).SmallIcon;
            _loc4_ = new Bitmap(GameKernel.getTextureInstance(_loc3_));
            _loc4_.x = -9;
            this.mcairshiplistAry[_loc1_].mc_base.addChild(_loc4_);
            _loc1_++;
         }
         TextField(this._mc.getMC().tf_metal).text = "";
         TextField(this._mc.getMC().tf_He3).text = "";
         TextField(this._mc.getMC().tf_gold).text = "";
         TextField(this._mc.getMC().tf_bluepaper).text = String(this.m_shipStorageAry.length + this.m_shipPageNum * PageShipNum) + "/" + String(DestructionShipRouter.instance.m_ShipTeamNumAry.length);
         TextField(this._mc.getMC().mc_airshiplist.tf_page).text = String(this.m_shipPageNum + 1);
         if(this.m_shipPageNum > 0)
         {
            this._ShipUp.gotoAndStop("up");
         }
         else
         {
            this._ShipUp.gotoAndStop("disabled");
         }
         if(this.m_shipPageNum + 1 < this.m_shipPageMaxNum)
         {
            this._ShipDown.gotoAndStop("up");
         }
         else
         {
            this._ShipDown.gotoAndStop("disabled");
         }
      }
      
      private function PartInfo(param1:int) : void
      {
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
         var _loc6_:PartNameNum = null;
         var _loc2_:ShipTeamNum = this.m_shipStorageAry[param1] as ShipTeamNum;
         this.m_partAry.length = 0;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.PartNum)
         {
            _loc4_ = false;
            _loc5_ = 0;
            while(_loc5_ < this.m_partAry.length)
            {
               if(_loc2_.PartId[_loc3_] == this.m_partAry[_loc5_].partId)
               {
                  ++this.m_partAry[_loc5_].Num;
                  _loc4_ = true;
                  break;
               }
               _loc5_++;
            }
            if(_loc4_ == false)
            {
               _loc6_ = new PartNameNum();
               _loc6_.partId = _loc2_.PartId[_loc3_];
               _loc6_.Num = 1;
               _loc6_.Name = CShipmodelReader.getInstance().getShipPartInfo(_loc6_.partId).Name;
               this.m_partAry.push(_loc6_);
            }
            _loc3_++;
         }
         this.PartStorage();
      }
      
      private function PartStorage() : void
      {
         this.m_partStorageAry.length = 0;
         if(this.m_partAry.length % PagePartNum == 0)
         {
            this.m_partPageMaxNum = this.m_partAry.length / PagePartNum;
         }
         else
         {
            this.m_partPageMaxNum = this.m_partAry.length / PagePartNum + 1;
         }
         var _loc1_:int = 0;
         while(this.m_partPageNum * PagePartNum + _loc1_ < this.m_partAry.length && _loc1_ < PagePartNum)
         {
            this.m_partStorageAry[_loc1_] = this.m_partAry[this.m_partPageNum * PagePartNum + _loc1_];
            _loc1_++;
         }
         this.showPart();
      }
      
      private function ClearPartMc() : void
      {
         var _loc2_:MovieClip = null;
         var _loc1_:int = 0;
         while(_loc1_ < PagePartNum)
         {
            _loc2_ = this.mcmodulelistAry[_loc1_].mc_base as MovieClip;
            if(_loc2_.numChildren > 1)
            {
               _loc2_.removeChildAt(1);
            }
            TextField(this.mcmodulelistAry[_loc1_].tf_num).text = "";
            _loc1_++;
         }
      }
      
      private function showPart() : void
      {
         var _loc2_:String = null;
         var _loc3_:Bitmap = null;
         this.ClearPartMc();
         var _loc1_:int = 0;
         while(_loc1_ < this.m_partStorageAry.length)
         {
            _loc2_ = CShipmodelReader.getInstance().getShipPartInfo(this.m_partStorageAry[_loc1_].partId).ImageFileName;
            _loc3_ = new Bitmap(GameKernel.getTextureInstance(_loc2_));
            _loc3_.width = this.mcmodulelistAry[_loc1_].mc_base.width;
            _loc3_.height = this.mcmodulelistAry[_loc1_].mc_base.height;
            this.mcmodulelistAry[_loc1_].mc_base.addChild(_loc3_);
            TextField(this.mcmodulelistAry[_loc1_].tf_num).text = this.m_partStorageAry[_loc1_].Num;
            _loc1_++;
         }
         this._PartLeft.gotoAndStop("up");
         this._PartRight.gotoAndStop("up");
      }
      
      private function ChooseShipEve(param1:Event) : void
      {
         var _loc2_:String = param1.currentTarget.name;
         _loc2_ = _loc2_.substring(7);
         var _loc3_:int = int(_loc2_);
         if(_loc3_ < this.m_shipStorageAry.length)
         {
            this.ChooseShip(_loc3_);
         }
      }
      
      private function ChooseShip(param1:int) : void
      {
         this.m_chooseNum = param1;
         var _loc2_:int = 0;
         while(_loc2_ < PageShipNum)
         {
            this.mcairshiplistAry[_loc2_].gotoAndStop("up");
            _loc2_++;
         }
         this.mcairshiplistAry[param1].gotoAndStop("selected");
         if(this.m_shipStorageAry[param1] == null)
         {
            return;
         }
         var _loc3_:String = CShipmodelReader.getInstance().getShipBodyInfo(this.m_shipStorageAry[param1].BodyID).ImageIcon;
         var _loc4_:Bitmap = new Bitmap(GameKernel.getTextureInstance(_loc3_));
         _loc4_.x = 0;
         _loc4_.y = 26;
         TextField(this._mc.getMC().tf_shipnum).text = StringUitl.toUSFormat(this.m_shipStorageAry[param1].Num);
         TextField(this._mc.getMC().tf_num).text = StringManager.getInstance().getMessageString("ReclaimText0");
         this.m_partPageNum = 0;
         this.PartInfo(param1);
      }
      
      private function OverShipEve(param1:Event) : void
      {
         var _loc4_:ShipbodyInfo = null;
         var _loc5_:int = 0;
         var _loc6_:MovieClip = null;
         var _loc7_:Point = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc2_:String = param1.currentTarget.name;
         _loc2_ = _loc2_.substring(7);
         var _loc3_:int = int(_loc2_);
         if(this.m_shipStorageAry.length > _loc3_)
         {
            this.IsOverShip = true;
            _loc4_ = CShipmodelReader.getInstance().getShipBodyInfo(this.m_shipStorageAry[_loc3_].BodyID);
            this.shipinfo.ShipName = DestructionShipRouter.instance.m_ShipTeamNumAry[this.m_shipPageNum * 5 + _loc3_].ShipName;
            this.shipinfo.KindName = this.m_KindNameAry[_loc4_.BodyType];
            this.shipinfo.Shield = _loc4_.Shield;
            this.shipinfo.Endure = _loc4_.Endure;
            this.shipinfo.Locomotivity = _loc4_.Locomotivity;
            this.shipinfo.Yare = _loc4_.Yare;
            this.shipinfo.Storage = _loc4_.Storage;
            this.shipinfo.Cubage = _loc4_.Cubage;
            this.shipinfo.TransitionTime = _loc4_.TransitionTime;
            this.shipinfo.UnitSupply = _loc4_.UnitSupply;
            this.shipinfo.CreateTime = _loc4_.CreateTime;
            this.shipinfo.Metal = _loc4_.Metal;
            this.shipinfo.He3 = _loc4_.He3;
            this.shipinfo.money = _loc4_.Money;
            this.shipinfo.ValidNum = _loc4_.ValidNum;
            this.m_times = 0;
            _loc5_ = 0;
            while(_loc5_ < this.m_shipStorageAry[_loc3_].PartNum)
            {
               _loc10_ = int(this.m_shipStorageAry[_loc3_].PartId[_loc5_]);
               this.shipinfo = this.addpart(_loc10_,this.shipinfo);
               _loc5_++;
            }
            Suspension.getInstance();
            Suspension.getInstance().Init(200,20 * 14,0);
            _loc6_ = param1.currentTarget as MovieClip;
            _loc7_ = _loc6_.localToGlobal(new Point(0,0));
            _loc7_ = this._mc.getMC().globalToLocal(_loc7_);
            Suspension.getInstance().setLocationXY(_loc7_.x + param1.currentTarget.height + 20,_loc7_.y);
            this._mc.getMC().addChild(Suspension.getInstance());
            this.shipinfo.shipmodelproAry.length = 0;
            this.shipinfo.getshipPro();
            Suspension.getInstance().putRect(0,"    " + this.m_itemnameAry[0],this.shipinfo.ShipName,13417082,65280);
            _loc8_ = 0;
            while(_loc8_ < 10)
            {
               Suspension.getInstance().putRect(_loc8_ + 1,"    " + this.m_itemnameAry[_loc8_ + 1],this.shipinfo.shipmodelproAry[_loc8_],13417082,65280);
               _loc8_++;
            }
            _loc9_ = 10;
            while(_loc9_ < 13)
            {
               Suspension.getInstance().putRectImg(_loc9_ + 1,this.m_itemnameAry[_loc9_ + 1],this.shipinfo.shipmodelproAry[_loc9_],13417082,65280);
               _loc9_++;
            }
         }
      }
      
      private function addpart(param1:int, param2:ShipModelProperty) : ShipModelProperty
      {
         var _loc3_:ShippartInfo = CShipmodelReader.getInstance().getShipPartInfo(param1);
         param2.Shield += _loc3_.Shield;
         param2.Endure += _loc3_.Endure;
         param2.Locomotivity += _loc3_.Locomotivity;
         param2.Yare += _loc3_.Yare;
         var _loc4_:int = _loc3_.MinRange;
         var _loc5_:int = _loc3_.MaxRange;
         var _loc6_:int = _loc3_.MinAssault;
         var _loc7_:int = _loc3_.MaxAssault;
         if(this.m_times == 0)
         {
            param2.MinAssault = _loc6_;
            param2.MaxAssault = _loc7_;
            param2.MinRange = _loc4_;
            param2.MaxRange = _loc5_;
            ++this.m_times;
         }
         else
         {
            param2.MinAssault += _loc3_.MinAssault;
            param2.MaxAssault += _loc3_.MaxAssault;
            if(param2.MinRange > _loc4_ && _loc4_ > 0 || param2.MinRange == 0)
            {
               param2.MinRange = _loc4_;
            }
            if(param2.MaxRange < _loc5_)
            {
               param2.MaxRange = _loc5_;
            }
         }
         param2.Storage += _loc3_.Storage;
         param2.Cubage += _loc3_.Cubage;
         param2.TransitionTime += _loc3_.TransitionTime;
         param2.UnitSupply += _loc3_.UnitSupply;
         param2.CreateTime += _loc3_.CreateTime;
         param2.Metal += _loc3_.Metal;
         param2.He3 += _loc3_.He3;
         param2.money += _loc3_.Money;
         return param2;
      }
      
      private function OutShipEve(param1:Event) : void
      {
         var _loc2_:String = param1.currentTarget.name;
         _loc2_ = _loc2_.substring(7);
         var _loc3_:int = int(_loc2_);
         if(this.m_shipStorageAry.length > _loc3_)
         {
            if(this.IsOverShip == false)
            {
               return;
            }
            if(Suspension.getInstance() == null)
            {
               return;
            }
            this.IsOverShip = false;
            this._mc.getMC().removeChild(Suspension.getInstance());
            Suspension.getInstance().delinstance();
         }
      }
      
      private function ShipCost(param1:int, param2:int) : void
      {
         var _loc4_:ShipModelProperty = null;
         var _loc5_:ShipbodyInfo = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:ShippartInfo = null;
         var _loc3_:int = 0;
         while(_loc3_ < ShipmodelRouter.instance.m_ZoonShipmodelInfoAry.length)
         {
            if(param1 == ShipmodelRouter.instance.m_ZoonShipmodelInfoAry[_loc3_].m_ShipModelId)
            {
               _loc4_ = new ShipModelProperty();
               _loc5_ = CShipmodelReader.getInstance().getShipBodyInfo(ShipmodelRouter.instance.m_ZoonShipmodelInfoAry[_loc3_].m_BodyId);
               _loc4_.Metal = _loc5_.Metal;
               _loc4_.He3 = _loc5_.He3;
               _loc4_.money = _loc5_.Money;
               _loc6_ = 0;
               while(_loc6_ < ShipmodelRouter.instance.m_ZoonShipmodelInfoAry[_loc3_].m_PartNum)
               {
                  _loc8_ = int(ShipmodelRouter.instance.m_ZoonShipmodelInfoAry[_loc3_].m_PartId[_loc6_]);
                  _loc9_ = CShipmodelReader.getInstance().getShipPartInfo(_loc8_);
                  _loc4_.Metal += _loc9_.Metal;
                  _loc4_.He3 += _loc9_.He3;
                  _loc4_.money += _loc9_.Money;
                  _loc6_++;
               }
               _loc4_.Metal *= param2;
               _loc4_.He3 *= param2;
               _loc4_.money *= param2;
               _loc7_ = ConstructionAction.getInstance().getResourceRecyclNum();
               _loc4_.Metal = _loc4_.Metal * _loc7_ / 100;
               _loc4_.He3 = _loc4_.He3 * _loc7_ / 100;
               _loc4_.money = _loc4_.money * _loc7_ / 100;
               this._mc.getMC().tf_metal.text = StringUitl.toUSFormat(_loc4_.Metal);
               this._mc.getMC().tf_He3.text = StringUitl.toUSFormat(_loc4_.He3);
               this._mc.getMC().tf_gold.text = StringUitl.toUSFormat(_loc4_.money);
               return;
            }
            _loc3_++;
         }
      }
      
      private function OverPartEve(param1:Event) : void
      {
         var _loc2_:String = param1.currentTarget.name;
         _loc2_ = _loc2_.substr(7);
         var _loc3_:int = int(_loc2_);
         if(_loc3_ < this.m_partStorageAry.length)
         {
            this.OverPart(_loc3_,param1);
         }
      }
      
      private function OverPart(param1:int, param2:Event) : void
      {
         var _loc3_:String = this.m_partStorageAry[param1].Name;
         var _loc4_:TextField = new TextField();
         _loc4_.text = _loc3_;
         Suspension.getInstance();
         Suspension.getInstance().Init(_loc4_.textWidth + 5,20,1);
         var _loc5_:MovieClip = param2.currentTarget as MovieClip;
         var _loc6_:Point = _loc5_.localToGlobal(new Point(0,0));
         _loc6_ = this._mc.getMC().globalToLocal(_loc6_);
         Suspension.getInstance().setLocationXY(_loc6_.x,_loc6_.y + _loc5_.height);
         var _loc7_:int = 0;
         while(_loc7_ < 1)
         {
            Suspension.getInstance().putRectOnlyOne(_loc7_,_loc3_,_loc4_.textWidth + 5);
            _loc7_++;
         }
         this._mc.getMC().addChild(Suspension.getInstance());
      }
      
      private function OutPartEve(param1:Event) : void
      {
         var _loc2_:String = param1.currentTarget.name;
         _loc2_ = _loc2_.substring(7);
         var _loc3_:int = int(_loc2_);
         if(_loc3_ < this.m_partStorageAry.length)
         {
            this._mc.getMC().removeChild(Suspension.getInstance());
            Suspension.getInstance().delinstance();
         }
      }
      
      private function ChickButton(param1:Event) : void
      {
         if(param1.currentTarget.name == "btn_up")
         {
            if(this.m_shipPageNum > 0)
            {
               this._ShipUp.gotoAndStop("down");
               --this.m_shipPageNum;
               this.shipstorage();
               this.showShip();
               this.ChooseShip(0);
            }
         }
         else if(param1.currentTarget.name == "btn_down")
         {
            if(this.m_shipPageNum + 1 < this.m_shipPageMaxNum)
            {
               this._ShipDown.gotoAndStop("down");
               ++this.m_shipPageNum;
               this.shipstorage();
               this.showShip();
               this.ChooseShip(0);
            }
         }
         else if(param1.currentTarget.name == "btn_right")
         {
            if(param1.currentTarget.parent.name == "mc_constructlist")
            {
               if((this.m_DamageShipPageNum + 1) * DamageShipNum < this.m_DamageShipAry.length)
               {
                  this._DamageShipRight.gotoAndStop("down");
                  ++this.m_DamageShipPageNum;
                  this.damageshipstorage();
               }
            }
            else if((this.m_partPageNum + 1) * PagePartNum < this.m_partAry.length)
            {
               this._PartRight.gotoAndStop("down");
               ++this.m_partPageNum;
               this.PartStorage();
            }
         }
         else if(param1.currentTarget.name == "btn_left")
         {
            if(param1.currentTarget.parent.name == "mc_constructlist")
            {
               if(this.m_DamageShipPageNum > 0)
               {
                  this._DamageShipLeft.gotoAndStop("down");
                  --this.m_DamageShipPageNum;
                  this.damageshipstorage();
               }
            }
            else if(this.m_partPageNum > 0)
            {
               this._PartLeft.gotoAndStop("down");
               --this.m_partPageNum;
               this.PartStorage();
            }
         }
         else if(param1.currentTarget.name == "btn_close")
         {
            this.m_shipPageNum = 0;
            GameKernel.popUpDisplayManager.Hide(instance);
         }
         else if(param1.currentTarget.name == "btn_fix")
         {
            if(this.m_DamageShipAry.length == 0)
            {
               return;
            }
            DestructionShipRouter.instance.sendmsgDESTROYSHIP(this.m_DamageShipAry.length,this.m_DamageShipAry);
         }
         else if(param1.currentTarget.name == "tf_num")
         {
            TextField(this._mc.getMC().tf_num).type = TextFieldType.INPUT;
            TextField(this._mc.getMC().tf_num).selectable = true;
            TextField(this._mc.getMC().tf_num).stage.focus = this._mc.getMC().tf_num;
            TextField(this._mc.getMC().tf_num).text = "";
         }
      }
      
      private function OverButton(param1:Event) : void
      {
         var _loc2_:TextField = null;
         var _loc3_:MovieClip = null;
         var _loc4_:Point = null;
         var _loc5_:int = 0;
         if(param1.currentTarget.name == "btn_up")
         {
            if(this.m_shipPageNum > 0)
            {
               this._ShipUp.gotoAndStop("over");
            }
         }
         else if(param1.currentTarget.name == "btn_down")
         {
            if(this.m_shipPageNum + 1 < this.m_shipPageMaxNum)
            {
               this._ShipDown.gotoAndStop("over");
            }
         }
         else if(param1.currentTarget.name == "btn_right")
         {
            if(param1.currentTarget.parent.name == "mc_constructlist")
            {
               if((this.m_DamageShipPageNum + 1) * DamageShipNum < this.m_DamageShipAry.length)
               {
                  this._DamageShipRight.gotoAndStop("over");
               }
            }
            else if((this.m_partPageNum + 1) * PagePartNum < this.m_partAry.length)
            {
               this._PartRight.gotoAndStop("over");
            }
         }
         else if(param1.currentTarget.name == "btn_left")
         {
            if(param1.currentTarget.parent.name == "mc_constructlist")
            {
               if(this.m_DamageShipPageNum > 0)
               {
                  this._DamageShipLeft.gotoAndStop("over");
               }
            }
            else if(this.m_partPageNum > 0)
            {
               this._PartLeft.gotoAndStop("over");
            }
         }
         else if(param1.currentTarget.name == "btn_fix")
         {
            _loc2_ = new TextField();
            _loc3_ = param1.currentTarget as MovieClip;
            _loc4_ = _loc3_.localToGlobal(new Point(0,0));
            _loc2_.text = StringManager.getInstance().getMessageString("ReclaimText1");
            Suspension.getInstance();
            Suspension.getInstance().Init(_loc2_.textWidth + 5,20,1);
            _loc4_ = this._mc.getMC().globalToLocal(_loc4_);
            Suspension.getInstance().setLocationXY(_loc4_.x,_loc4_.y - 20);
            _loc5_ = 0;
            while(_loc5_ < 1)
            {
               Suspension.getInstance().putRectOnlyOne(_loc5_,StringManager.getInstance().getMessageString("ReclaimText1"),_loc2_.textWidth + 5);
               _loc5_++;
            }
            this._mc.getMC().addChild(Suspension.getInstance());
         }
      }
      
      private function OutButton(param1:Event) : void
      {
         if(param1.currentTarget.name == "btn_up")
         {
            if(this.m_shipPageNum > 0)
            {
               this._ShipUp.gotoAndStop("up");
            }
         }
         else if(param1.currentTarget.name == "btn_down")
         {
            if(this.m_shipPageNum + 1 < this.m_shipPageMaxNum)
            {
               this._ShipDown.gotoAndStop("up");
            }
         }
         else if(param1.currentTarget.name == "btn_right")
         {
            if(param1.currentTarget.parent.name == "mc_constructlist")
            {
               if((this.m_DamageShipPageNum + 1) * DamageShipNum < this.m_DamageShipAry.length)
               {
                  this._DamageShipRight.gotoAndStop("up");
               }
            }
            else if((this.m_partPageNum + 1) * PagePartNum < this.m_partAry.length)
            {
               this._PartRight.gotoAndStop("up");
            }
         }
         else if(param1.currentTarget.name == "btn_left")
         {
            if(param1.currentTarget.parent.name == "mc_constructlist")
            {
               if(this.m_DamageShipPageNum > 0)
               {
                  this._DamageShipLeft.gotoAndStop("up");
               }
            }
            else if(this.m_partPageNum > 0)
            {
               this._PartLeft.gotoAndStop("up");
            }
         }
         else if(param1.currentTarget.name == "btn_fix")
         {
            this._mc.getMC().removeChild(Suspension.getInstance());
            Suspension.getInstance().delinstance();
         }
      }
      
      private function ChooseShipDamageEve(param1:Event) : void
      {
         var _loc2_:String = param1.currentTarget.name;
         _loc2_ = _loc2_.substring(10);
         var _loc3_:int = int(_loc2_);
         if(_loc3_ < this.m_shipStorageAry.length)
         {
            this.ChooseShipDamage(_loc3_);
         }
      }
      
      private function ChooseShipDamage(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Boolean = false;
         while(_loc3_ < this.m_DamageShipAry.length)
         {
            if(this.m_shipStorageAry[param1].ShipModelId == this.m_DamageShipAry[_loc3_].ShipModelId)
            {
               _loc2_ = true;
               break;
            }
            _loc3_++;
         }
         if(_loc2_ == false)
         {
            this.m_chooseNum = param1;
            DestructionShipNumUI.getInstance().Init();
            DestructionShipNumUI.getInstance().setParent(instance);
            DestructionShipNumUI.getInstance().Show(DestructionShipRouter.instance.m_ShipTeamNumAry[this.m_shipPageNum * PageShipNum + param1].Num,"请输入需销毁的数量：");
         }
      }
      
      public function moveList(param1:int) : void
      {
         var _loc2_:DamageShip = new DamageShip();
         _loc2_.ShipModelId = this.m_shipStorageAry[this.m_chooseNum].ShipModelId;
         _loc2_.BodyID = this.m_shipStorageAry[this.m_chooseNum].BodyID;
         _loc2_.ShipName = this.m_shipStorageAry[this.m_chooseNum].ShipName;
         _loc2_.Num = param1;
         DestructionShipRouter.instance.m_ShipTeamNumAry[this.m_shipPageNum * PageShipNum + this.m_chooseNum].Num -= param1;
         this.m_DamageShipAry.push(_loc2_);
         this.shipstorage();
         if(this.m_DamageShipAry.length % DamageShipNum == 0)
         {
            this.m_DamageShipPageMaxNum = this.m_DamageShipAry.length / DamageShipNum;
         }
         else
         {
            this.m_DamageShipPageMaxNum = this.m_DamageShipAry.length / DamageShipNum + 1;
         }
         this.m_DamageShipPageNum = this.m_DamageShipPageMaxNum - 1;
         this.damageshipstorage();
      }
      
      private function ClearDamageShipMc() : void
      {
         var _loc2_:MovieClip = null;
         var _loc1_:int = 0;
         while(_loc1_ < DamageShipNum)
         {
            _loc2_ = this.mcconstructlistAry[_loc1_].mc_base as MovieClip;
            if(_loc2_.numChildren > 1)
            {
               _loc2_.removeChildAt(1);
            }
            this.mccancelAry[_loc1_].visible = false;
            TextField(this.mcconstructlistAry[_loc1_].tf_num).text = "";
            TextField(this.mcconstructlistAry[_loc1_].tf_num).type = TextFieldType.DYNAMIC;
            TextField(this.mcconstructlistAry[_loc1_].tf_shipname).text = "";
            _loc1_++;
         }
      }
      
      private function damageshipstorage() : void
      {
      }
      
      private function changeHd(param1:Event) : void
      {
         this.changeNum();
      }
      
      private function changeNum() : void
      {
         var _loc1_:int = StringUitl.toint(TextField(this._mc.getMC().tf_shipnum).text);
         var _loc2_:int = StringUitl.toint(TextField(this._mc.getMC().tf_num).text);
         TextField(this._mc.getMC().tf_num).text = StringUitl.toUSFormat(_loc2_);
         if(_loc2_ >= _loc1_)
         {
            _loc2_ = _loc1_;
            TextField(this._mc.getMC().tf_num).text = StringUitl.toUSFormat(_loc1_);
         }
         var _loc3_:int = TextField(this._mc.getMC().tf_num).text.length;
         TextField(this._mc.getMC().tf_num).setSelection(_loc3_,_loc3_);
         if(this.m_shipStorageAry[this.m_chooseNum] == null)
         {
            return;
         }
         this.ShipCost(this.m_shipStorageAry[this.m_chooseNum].ShipModelId,_loc2_);
         this.m_DamageShipAry.length = 0;
         var _loc4_:DamageShip = new DamageShip();
         _loc4_.ShipModelId = this.m_shipStorageAry[this.m_chooseNum].ShipModelId;
         _loc4_.Num = _loc2_;
         this.m_DamageShipAry[0] = _loc4_;
      }
      
      public function deleteDamageShipAry() : void
      {
         this.damageshipstorage();
         var _loc1_:int = 0;
         while(_loc1_ < DestructionShipRouter.instance.m_ShipTeamNumAry.length)
         {
            if(this.m_DamageShipAry[0].ShipModelId == DestructionShipRouter.instance.m_ShipTeamNumAry[_loc1_].ShipModelId)
            {
               DestructionShipRouter.instance.m_ShipTeamNumAry[_loc1_].Num -= this.m_DamageShipAry[0].Num;
            }
            if(DestructionShipRouter.instance.m_ShipTeamNumAry[_loc1_].Num == 0)
            {
               DestructionShipRouter.instance.m_ShipTeamNumAry.splice(_loc1_,1);
            }
            else
            {
               _loc1_++;
            }
         }
         this.m_DamageShipAry.length = 0;
         this.shipstorage();
         this.showShip();
         this.ChooseShip(0);
      }
   }
}

