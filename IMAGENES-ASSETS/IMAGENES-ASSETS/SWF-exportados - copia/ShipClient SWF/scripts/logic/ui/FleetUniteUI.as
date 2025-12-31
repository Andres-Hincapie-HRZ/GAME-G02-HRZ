package logic.ui
{
   import com.star.frameworks.managers.StringManager;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import logic.entry.GShipTeam;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.game.GameKernel;
   import logic.manager.GalaxyShipManager;
   import net.base.NetManager;
   import net.msg.ship.*;
   
   public class FleetUniteUI extends AbstractPopUp
   {
      
      private static var instance:FleetUniteUI;
      
      private var Fleet1:FleetUniteUI_Fleet;
      
      private var Fleet2:FleetUniteUI_Fleet;
      
      private var SelectedFleet:FleetUniteUI_Fleet;
      
      private var List0:MovieClip;
      
      private var List1:MovieClip;
      
      private var SelectedShipImg:MovieClip;
      
      private var SelectedCellId:int;
      
      private var SelectedFleetId:int;
      
      private var SelectedModelId:int;
      
      private var SelectedNum:int;
      
      private var Fleet1H3Num:int;
      
      private var Fleet2H3Num:int;
      
      private var _FleetId1:int;
      
      private var _FleetId2:int;
      
      public function FleetUniteUI()
      {
         super();
         setPopUpName("FleetUniteUI");
      }
      
      public static function getInstance() : FleetUniteUI
      {
         if(instance == null)
         {
            instance = new FleetUniteUI();
         }
         return instance;
      }
      
      public function Uinite(param1:int, param2:int) : void
      {
         this._FleetId1 = param1;
         this._FleetId2 = param2;
         var _loc3_:GShipTeam = GalaxyShipManager.instance.getShipDatas(param1);
         if(_loc3_.UserId == -1)
         {
            FleetInfoUI_Router.ShowFleetInfoFunction = this.Show;
            return;
         }
         var _loc4_:GShipTeam = GalaxyShipManager.instance.getShipDatas(param2);
         if(_loc4_.UserId == -1)
         {
            FleetInfoUI_Router.ShowFleetInfoFunction = this.Show;
            return;
         }
         if(_loc3_.UserId != _loc4_.UserId || _loc3_.UserId != GamePlayer.getInstance().userID || _loc4_.UserId != GamePlayer.getInstance().userID)
         {
            return;
         }
         this.Init();
         this.Fleet1H3Num = this.Fleet1.InitValue(param1);
         if(param2 == param1)
         {
            this.Fleet2H3Num = this.Fleet2.InitValue(-1);
            this.Fleet1.UnitedSelf(true);
         }
         else
         {
            this.Fleet1.UnitedSelf(false);
            this.Fleet2H3Num = this.Fleet2.InitValue(param2);
            this.Fleet2.SetHe3Count(this.Fleet1H3Num + this.Fleet2H3Num);
         }
         this.Fleet1.SetHe3Count(this.Fleet1H3Num + this.Fleet2H3Num);
         GameKernel.popUpDisplayManager.Show(this);
      }
      
      public function Show(param1:int) : void
      {
         if(this._FleetId1 == param1 || this._FleetId2 == param1)
         {
            this.Uinite(this._FleetId1,this._FleetId2);
         }
      }
      
      override public function Init() : void
      {
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            return;
         }
         this._mc = new MObject("FleetcombinationScene",385,300);
         this.initMcElement();
         GameKernel.popUpDisplayManager.Regisger(instance);
      }
      
      override public function initMcElement() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:HButton = null;
         _loc1_ = this._mc.getMC().btn_close as MovieClip;
         _loc2_ = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_closeClick);
         _loc1_ = this._mc.getMC().btn_ensure as MovieClip;
         _loc2_ = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_ensureClick);
         this.List0 = this._mc.getMC().getChildByName("mc_list0") as MovieClip;
         this.Fleet1 = new FleetUniteUI_Fleet(this.List0,this);
         this.List1 = this._mc.getMC().getChildByName("mc_list1") as MovieClip;
         this.Fleet2 = new FleetUniteUI_Fleet(this.List1,this);
      }
      
      private function btn_closeClick(param1:Event) : void
      {
         this._FleetId1 = 0;
         this._FleetId2 = 0;
         GameKernel.popUpDisplayManager.Hide(this);
      }
      
      private function btn_ensureClick(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc4_:MSG_SHIPTEAM_NUM = null;
         var _loc5_:int = 0;
         var _loc7_:GShipTeam = null;
         var _loc2_:MSG_REQUEST_UNITESHIPTEAM = new MSG_REQUEST_UNITESHIPTEAM();
         _loc2_.ShipTeamId = this.Fleet1.GetFleetId();
         _loc2_.Gas = this.Fleet1.GetHe3Num();
         _loc3_ = 0;
         while(_loc3_ < 9)
         {
            _loc4_ = _loc2_.TeamBody[_loc3_];
            _loc4_.ShipModelId = this.Fleet1._ShipTeamInfo.ShipModelId[_loc3_];
            _loc4_.Num = this.Fleet1._ShipTeamInfo.Num[_loc3_];
            _loc5_ += _loc4_.Num;
            _loc3_++;
         }
         var _loc6_:GShipTeam = GalaxyShipManager.instance.getShipDatas(this.Fleet1.GetFleetId());
         _loc6_.ShipNum = _loc5_;
         _loc6_.freshShipBody();
         if(this.Fleet2.GetFleetId() == -1)
         {
            _loc2_.ShipTeamId2 = this.Fleet1.GetFleetId();
            _loc2_.Gas2 = this.Fleet1.GetHe3Num();
            _loc3_ = 0;
            while(_loc3_ < 9)
            {
               _loc4_ = _loc2_.TeamBody2[_loc3_];
               _loc4_.ShipModelId = this.Fleet1._ShipTeamInfo.ShipModelId[_loc3_];
               _loc4_.Num = this.Fleet1._ShipTeamInfo.Num[_loc3_];
               _loc3_++;
            }
         }
         else
         {
            _loc2_.ShipTeamId2 = this.Fleet2.GetFleetId();
            _loc2_.Gas2 = this.Fleet2.GetHe3Num();
            _loc5_ = 0;
            _loc3_ = 0;
            while(_loc3_ < 9)
            {
               _loc4_ = _loc2_.TeamBody2[_loc3_];
               _loc4_.ShipModelId = this.Fleet2._ShipTeamInfo.ShipModelId[_loc3_];
               _loc4_.Num = this.Fleet2._ShipTeamInfo.Num[_loc3_];
               _loc5_ += _loc4_.Num;
               _loc3_++;
            }
            _loc7_ = GalaxyShipManager.instance.getShipDatas(this.Fleet2.GetFleetId());
            _loc7_.ShipNum = _loc5_;
            _loc7_.freshShipBody();
         }
         _loc2_.GalaxyMapId = this.Fleet1.GalaxyMapId;
         _loc2_.GalaxyId = this.Fleet1.GalaxyId;
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc2_);
         GameKernel.popUpDisplayManager.Hide(this);
      }
      
      public function SelectedShip(param1:FleetUniteUI_Fleet, param2:Point, param3:MovieClip, param4:int, param5:int, param6:int, param7:int) : void
      {
         this.SelectedShipImg = param3;
         this.SelectedFleet = param1;
         this.SelectedCellId = param4;
         this.SelectedFleetId = param5;
         this.SelectedModelId = param6;
         this.SelectedNum = param7;
         var _loc8_:Point = this._mc.getMC().globalToLocal(param2);
         param3.x = _loc8_.x;
         param3.y = _loc8_.y;
         this._mc.getMC().addChild(param3);
         param3.addEventListener(MouseEvent.MOUSE_UP,this.SelectedShipImgMouseUp);
         param3.startDrag(true);
      }
      
      private function SelectedShipImgMouseUp(param1:MouseEvent) : void
      {
         this.SelectedShipImg.stopDrag();
         this._mc.getMC().removeChild(this.SelectedShipImg);
         var _loc2_:MovieClip = param1.target as MovieClip;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:Point = new Point(this.SelectedShipImg.x,this.SelectedShipImg.y);
         _loc3_ = this._mc.getMC().localToGlobal(_loc3_);
         if(this.SelectedShipImg.y > this.List0.y + this.List0.height)
         {
            this.Fleet2.ReplaceShip(this.SelectedShipImg,this.SelectedCellId,this.SelectedFleetId,this.SelectedModelId,this.SelectedNum,_loc3_);
         }
         else
         {
            this.Fleet1.ReplaceShip(this.SelectedShipImg,this.SelectedCellId,this.SelectedFleetId,this.SelectedModelId,this.SelectedNum,_loc3_);
         }
      }
      
      public function ShowEnterShipNumForm(param1:Function, param2:int) : void
      {
         FleetNumUI.getInstance().Show(this._mc.getMC(),param2,param1,StringManager.getInstance().getMessageString("FormationText3"));
      }
      
      public function MoveSelectedShip(param1:int) : void
      {
         this.SelectedFleet.RemoveShip(this.SelectedCellId,param1);
      }
      
      public function ReplaceSelectedShip(param1:int, param2:int, param3:MovieClip) : void
      {
         this.SelectedFleet.ResetShip(this.SelectedCellId,param1,param2,param3);
      }
      
      public function CheckHe3Num() : void
      {
         this.SelectedFleet.CheckHe3Num();
      }
      
      public function DeleteHe3Count(param1:FleetUniteUI_Fleet, param2:int) : void
      {
         if(this.Fleet1 != param1)
         {
            this.Fleet1.DeleteHe3Count(param2);
         }
         else
         {
            this.Fleet2.DeleteHe3Count(param2);
         }
      }
   }
}

