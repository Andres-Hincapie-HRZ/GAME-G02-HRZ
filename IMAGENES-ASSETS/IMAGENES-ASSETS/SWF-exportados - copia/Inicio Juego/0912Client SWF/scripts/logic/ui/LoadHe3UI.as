package logic.ui
{
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import logic.entry.GShip;
   import logic.entry.GShipTeam;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.entry.commander.CommanderInfo;
   import logic.entry.shipmodel.ShipbodyInfo;
   import logic.entry.shipmodel.ShipmodelInfo;
   import logic.entry.shipmodel.ShippartInfo;
   import logic.game.GameKernel;
   import logic.manager.GalaxyShipManager;
   import logic.reader.CShipmodelReader;
   import net.base.NetManager;
   import net.msg.LoadHe3.MSG_REQUEST_LOADSHIPTEAM;
   import net.msg.LoadHe3.MSG_REQUEST_UNLOADSHIPTEAM;
   import net.router.CommanderRouter;
   import net.router.ShipmodelRouter;
   
   public class LoadHe3UI extends AbstractPopUp
   {
      
      private static var instance:LoadHe3UI;
      
      private var BtnShape:MovieClip;
      
      private var mc_commanderbase:MovieClip;
      
      private var tf_commandername:TextField;
      
      private var tf_lv:TextField;
      
      private var McFleet:MovieClip;
      
      private var tfFleetName:TextField;
      
      private var tfLoadH3Num:TextField;
      
      private var tfHe3Max:TextField;
      
      private var tfKeepCount:TextField;
      
      private const PlanBarMinX:int = -45;
      
      private const PlanBarMaxX:int = 34;
      
      private const PlanBarLen:int = 79;
      
      private var FleetInfo:GShipTeam;
      
      private var FleetStorage:uint;
      
      private var He3Loaded:int;
      
      private var RemaindHe3:int;
      
      private var LoadMax:int;
      
      private var Supply:Number;
      
      private var _FleetId:int;
      
      public function LoadHe3UI()
      {
         super();
         setPopUpName("LoadHe3UI");
      }
      
      public static function getInstance() : LoadHe3UI
      {
         if(instance == null)
         {
            instance = new LoadHe3UI();
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
         this._mc = new MObject("UnloadScene",385,300);
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
         _loc2_.addEventListener(MouseEvent.CLICK,this.CloseClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_ensure") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.LoadHe3Ok);
         _loc2_ = this._mc.getMC().getChildByName("btn_min") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.BtnMinClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_max") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.BtnMaxClick);
         this.BtnShape = this._mc.getMC().getChildByName("btn_shade") as MovieClip;
         this.BtnShape.addEventListener(MouseEvent.MOUSE_DOWN,this.BtnShapeMouseDown);
         this.McFleet = this._mc.getMC().getChildByName("mc_fleetbase") as MovieClip;
         this.tfFleetName = this._mc.getMC().getChildByName("tf_fleetname") as TextField;
         this.tfLoadH3Num = this._mc.getMC().getChildByName("tf_resinput") as TextField;
         this.tfLoadH3Num.addEventListener(Event.CHANGE,this.LoadH3NumInput);
         this.tfLoadH3Num.restrict = "0-9";
         this.tfHe3Max = this._mc.getMC().getChildByName("tf_storageres") as TextField;
         this.tfKeepCount = this._mc.getMC().getChildByName("tf_huihe") as TextField;
         this.mc_commanderbase = this._mc.getMC().getChildByName("mc_commanderbase") as MovieClip;
         this.tf_commandername = this._mc.getMC().getChildByName("tf_commandername") as TextField;
         this.tf_lv = this._mc.getMC().getChildByName("tf_lv") as TextField;
      }
      
      public function Show(param1:int) : void
      {
         if(param1 == this._FleetId)
         {
            this.LoadHe3(param1);
         }
      }
      
      public function LoadHe3(param1:int) : void
      {
         var _loc3_:CommanderInfo = null;
         this._FleetId = param1;
         this.FleetInfo = GalaxyShipManager.instance.getShipDatas(param1);
         if(this.FleetInfo.UserId == -1)
         {
            FleetInfoUI_Router.ShowFleetInfoFunction = this.Show;
            return;
         }
         if(!GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            this.Init();
         }
         if(this.mc_commanderbase.numChildren > 0)
         {
            this.mc_commanderbase.removeChildAt(0);
         }
         var _loc2_:Bitmap = CommanderSceneUI.getInstance().CommanderImg(this.FleetInfo.CommanderID);
         _loc2_.width = 50;
         _loc2_.height = 50;
         this.mc_commanderbase.addChild(_loc2_);
         for each(_loc3_ in CommanderRouter.instance.m_commandInfoAry)
         {
            if(_loc3_.commander_commanderId == this.FleetInfo.CommanderID)
            {
               this.tf_commandername.text = _loc3_.commander_name;
               break;
            }
         }
         this.tf_lv.text = (this.FleetInfo.LevelId + 1).toString();
         if(this.McFleet.numChildren > 0)
         {
            this.McFleet.removeChildAt(0);
         }
         var _loc4_:ShipbodyInfo = CShipmodelReader.getInstance().getShipBodyInfo(this.FleetInfo.BodyId);
         var _loc5_:Bitmap = new Bitmap(GameKernel.getTextureInstance(_loc4_.ImageIcon));
         _loc5_.y = 10;
         this.McFleet.addChild(_loc5_);
         this.tfFleetName.text = this.FleetInfo.TeamName;
         this.GetFleetStorage();
         this.He3Loaded = this.FleetInfo.Gas;
         this.RemaindHe3 = GamePlayer.getInstance().UserHe3 + this.He3Loaded;
         if(this.RemaindHe3 < this.FleetStorage)
         {
            this.LoadMax = this.RemaindHe3;
         }
         else
         {
            this.LoadMax = this.FleetStorage;
         }
         this.CheckLoadH3Num();
         GameKernel.popUpDisplayManager.Show(this);
      }
      
      private function GetFleetStorage() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Number = NaN;
         var _loc4_:GShip = null;
         var _loc5_:ShipmodelInfo = null;
         var _loc6_:ShipbodyInfo = null;
         var _loc7_:int = 0;
         var _loc8_:ShippartInfo = null;
         this.FleetStorage = 0;
         this.Supply = 0;
         var _loc3_:int = 0;
         while(_loc3_ < 9)
         {
            _loc4_ = this.FleetInfo.TeamBody[_loc3_];
            if(!(_loc4_ == null || _loc4_.Num <= 0))
            {
               _loc5_ = ShipmodelRouter.instance.ShipModeList.Get(_loc4_.ShipModelId);
               _loc6_ = CShipmodelReader.getInstance().getShipBodyInfo(_loc5_.m_BodyId);
               _loc1_ = _loc6_.Storage;
               _loc2_ = 0;
               _loc7_ = 0;
               while(_loc7_ < _loc5_.m_PartNum)
               {
                  _loc8_ = CShipmodelReader.getInstance().getShipPartInfo(_loc5_.m_PartId[_loc7_]);
                  _loc1_ += _loc8_.Storage;
                  _loc2_ += _loc8_.Supply;
                  _loc7_++;
               }
               this.Supply += _loc2_ * _loc4_.Num;
               this.FleetStorage += _loc1_ * _loc4_.Num;
            }
            _loc3_++;
         }
      }
      
      private function Clear() : void
      {
         this.tfKeepCount.text = "";
         if(this.McFleet.numChildren > 0)
         {
            this.McFleet.removeChildAt(0);
         }
         this.tfFleetName.text = "";
         this.tfLoadH3Num.text = "";
      }
      
      private function CloseClick(param1:Event) : void
      {
         GameKernel.popUpDisplayManager.Hide(this);
      }
      
      private function LoadHe3Ok(param1:Event) : void
      {
         var _loc2_:MSG_REQUEST_LOADSHIPTEAM = null;
         var _loc3_:MSG_REQUEST_UNLOADSHIPTEAM = null;
         if(this.FleetInfo.Gas < this.He3Loaded)
         {
            _loc2_ = new MSG_REQUEST_LOADSHIPTEAM();
            _loc2_.ShipTeamId = this.FleetInfo.ShipTeamId;
            _loc2_.Gas = this.He3Loaded - this.FleetInfo.Gas;
            _loc2_.SeqId = GamePlayer.getInstance().seqID++;
            _loc2_.Guid = GamePlayer.getInstance().Guid;
            NetManager.Instance().sendObject(_loc2_);
         }
         else if(this.FleetInfo.Gas > this.He3Loaded)
         {
            _loc3_ = new MSG_REQUEST_UNLOADSHIPTEAM();
            _loc3_.ShipTeamId = this.FleetInfo.ShipTeamId;
            _loc3_.Gas = this.FleetInfo.Gas - this.He3Loaded;
            _loc3_.SeqId = GamePlayer.getInstance().seqID++;
            _loc3_.Guid = GamePlayer.getInstance().Guid;
            NetManager.Instance().sendObject(_loc3_);
         }
         GameKernel.popUpDisplayManager.Hide(this);
      }
      
      private function BtnMinClick(param1:Event) : void
      {
         this.He3Loaded = 0;
         this.CheckLoadH3Num();
      }
      
      private function BtnMaxClick(param1:Event) : void
      {
         this.He3Loaded = this.LoadMax;
         this.CheckLoadH3Num();
      }
      
      private function BtnShapeMouseDown(param1:Event) : void
      {
         this._mc.getMC().mouseEnabled = true;
         this._mc.getMC().addEventListener(MouseEvent.MOUSE_MOVE,this.BtnShapeMove);
         this._mc.getMC().addEventListener(MouseEvent.MOUSE_UP,this.BtnShapeMoveOver);
      }
      
      private function BtnShapeMove(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         if(_loc2_ == null)
         {
            this._mc.getMC().mouseEnabled = false;
            this._mc.getMC().removeEventListener(MouseEvent.MOUSE_MOVE,this.BtnShapeMove);
            this._mc.getMC().removeEventListener(MouseEvent.MOUSE_UP,this.BtnShapeMoveOver);
            return;
         }
         var _loc3_:Point = _loc2_.localToGlobal(new Point(param1.localX,param1.localY));
         _loc3_ = this._mc.getMC().globalToLocal(_loc3_);
         if(_loc3_.x < this.PlanBarMinX)
         {
            _loc3_.x = this.PlanBarMinX;
         }
         else if(_loc3_.x > this.PlanBarMaxX)
         {
            _loc3_.x = this.PlanBarMaxX;
         }
         this.BtnShape.x = _loc3_.x;
         var _loc4_:int = _loc3_.x - this.PlanBarMinX;
         this.He3Loaded = this.FleetStorage * (_loc4_ / this.PlanBarLen);
         this.CheckLoadH3Num();
      }
      
      private function BtnShapeMoveOver(param1:MouseEvent) : void
      {
         this._mc.getMC().mouseEnabled = false;
         this._mc.getMC().removeEventListener(MouseEvent.MOUSE_MOVE,this.BtnShapeMove);
         this._mc.getMC().removeEventListener(MouseEvent.MOUSE_UP,this.BtnShapeMoveOver);
      }
      
      private function LoadH3NumInput(param1:Event) : void
      {
         this.He3Loaded = int(this.tfLoadH3Num.text);
         this.CheckLoadH3Num();
      }
      
      private function CheckLoadH3Num() : void
      {
         if(this.He3Loaded > this.LoadMax)
         {
            this.He3Loaded = this.LoadMax;
         }
         this.tfLoadH3Num.text = this.He3Loaded.toString();
         this.ResetBtnShape();
         this.tfHe3Max.text = (this.RemaindHe3 - this.He3Loaded).toString();
         var _loc1_:int = this.He3Loaded / this.Supply;
         this.tfKeepCount.text = _loc1_.toString();
      }
      
      private function ResetBtnShape() : void
      {
         var _loc1_:int = this.PlanBarLen * (this.He3Loaded / this.FleetStorage);
         this.BtnShape.x = this.PlanBarMinX + _loc1_;
      }
   }
}

