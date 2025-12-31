package logic.ui
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import gs.TweenLite;
   import gs.easing.Strong;
   import logic.action.GalaxyMapAction;
   import logic.action.OutSideGalaxiasAction;
   import logic.entry.GShipTeam;
   import logic.entry.GalaxyType;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.game.GameKernel;
   import logic.manager.GalaxyManager;
   import logic.manager.InstanceManager;
   import logic.ui.tip.ShipTeamInfoTip;
   import net.base.NetManager;
   import net.msg.MSG_REQUEST_FROMRESOURCESTARTOHOME;
   import net.msg.ship.*;
   
   public class ShipPopUI
   {
      
      private static var instance:ShipPopUI;
      
      private var PopMc1:MovieClip;
      
      private var PopMc2:MovieClip;
      
      private var SelectedPopMc:MovieClip;
      
      public function ShipPopUI()
      {
         var _loc1_:MovieClip = null;
         var _loc2_:HButton = null;
         super();
         this.PopMc1 = GameKernel.getMovieClipInstance("Fleetinfopopup");
         this.PopMc1.visible = false;
         _loc1_ = this.PopMc1.btn_turnaround as MovieClip;
         _loc2_ = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_turnaroundClick);
         _loc1_ = this.PopMc1.btn_imbark as MovieClip;
         _loc2_ = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_imbarkClick);
         _loc1_ = this.PopMc1.btn_revise as MovieClip;
         _loc2_ = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_reviseClick);
         _loc1_ = this.PopMc1.btn_merge as MovieClip;
         _loc2_ = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_mergeClick);
         _loc1_ = this.PopMc1.btn_disband as MovieClip;
         _loc2_ = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_disbandClick);
         this.PopMc2 = GameKernel.getMovieClipInstance("Fleetinfopopup2");
         this.PopMc2.visible = false;
         _loc1_ = this.PopMc2.btn_turnaround as MovieClip;
         _loc2_ = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_turnaroundClick);
         _loc1_ = this.PopMc2.btn_backhome as MovieClip;
         _loc2_ = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_backhomeClick);
         _loc1_ = this.PopMc2.btn_merge as MovieClip;
         _loc2_ = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_mergeClick);
         _loc1_ = this.PopMc2.btn_revise as MovieClip;
         _loc2_ = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_reviseClick);
      }
      
      public static function getInstance() : ShipPopUI
      {
         if(instance == null)
         {
            instance = new ShipPopUI();
         }
         return instance;
      }
      
      public function Show(param1:MouseEvent) : void
      {
         if(InstanceManager.instance.curStatus == 1)
         {
            return;
         }
         if(GalaxyManager.instance.enterStar.FightFlag == 1)
         {
            return;
         }
         ShipTeamInfoTip.instance.Hide();
         this.Close();
         var _loc2_:DisplayObject = param1.target as DisplayObject;
         var _loc3_:Point = _loc2_.localToGlobal(new Point(param1.localX,param1.localY));
         _loc3_ = OutSideGalaxiasAction.getInstance().OutSideDefendContainer.globalToLocal(_loc3_);
         _loc3_.x += 50;
         if(GalaxyManager.instance.isMineHome())
         {
            this.SelectedPopMc = this.PopMc1;
         }
         else
         {
            this.SelectedPopMc = this.PopMc2;
         }
         this.SelectedPopMc.x = _loc3_.x;
         this.SelectedPopMc.y = _loc3_.y;
         var _loc4_:int = _loc3_.x;
         var _loc5_:int = _loc3_.y - this.SelectedPopMc.height / 2 + 5;
         this.SelectedPopMc.width = 0;
         this.SelectedPopMc.height = 0;
         OutSideGalaxiasAction.getInstance().OutSideDefendContainer.addChild(this.SelectedPopMc);
         TweenLite.to(this.SelectedPopMc,0.5,{
            "x":_loc4_,
            "y":_loc5_,
            "autoAlpha":1,
            "scaleX":1,
            "scaleY":1,
            "ease":Strong.easeOut
         });
      }
      
      public function Close() : void
      {
         if(this.SelectedPopMc != null && this.SelectedPopMc.parent != null && this.SelectedPopMc.parent.contains(this.SelectedPopMc))
         {
            this.SelectedPopMc.parent.removeChild(this.SelectedPopMc);
            this.SelectedPopMc = null;
         }
      }
      
      public function Opened() : Boolean
      {
         return this.SelectedPopMc != null;
      }
      
      private function btn_turnaroundClick(param1:MouseEvent) : void
      {
         var _loc2_:GShipTeam = OutSideGalaxiasAction.getInstance().CurShip;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:int = _loc2_.Direction == 3 ? 0 : _loc2_.Direction + 1;
         var _loc4_:MSG_REQUEST_DIRECTIONSHIPTEAM = new MSG_REQUEST_DIRECTIONSHIPTEAM();
         _loc4_.SeqId = GamePlayer.getInstance().seqID++;
         _loc4_.Guid = GamePlayer.getInstance().Guid;
         _loc4_.ShipTeamId = _loc2_.ShipTeamId;
         _loc4_.Direction = _loc3_;
         NetManager.Instance().sendObject(_loc4_);
      }
      
      private function btn_imbarkClick(param1:MouseEvent) : void
      {
         this.Close();
         var _loc2_:GShipTeam = OutSideGalaxiasAction.getInstance().CurShip;
         if(_loc2_ == null)
         {
            return;
         }
         LoadHe3UI.getInstance().LoadHe3(_loc2_.ShipTeamId);
      }
      
      private function btn_reviseClick(param1:MouseEvent) : void
      {
         this.Close();
         var _loc2_:GShipTeam = OutSideGalaxiasAction.getInstance().CurShip;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.UserId != -1)
         {
            FleetEditUI.getInstance().UpdateFleet(_loc2_.ShipTeamId);
            return;
         }
      }
      
      private function btn_mergeClick(param1:MouseEvent) : void
      {
         this.Close();
         OutSideGalaxiasAction.getInstance().uniteFlag = true;
      }
      
      private function btn_disbandClick(param1:MouseEvent) : void
      {
         this.Close();
         var _loc2_:GShipTeam = OutSideGalaxiasAction.getInstance().CurShip;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:MSG_REQUEST_DISBANDSHIPTEAM = new MSG_REQUEST_DISBANDSHIPTEAM();
         _loc3_.Guid = GamePlayer.getInstance().Guid;
         _loc3_.SeqId = GamePlayer.getInstance().seqID++;
         _loc3_.ShipTeamId = _loc2_.ShipTeamId;
         NetManager.Instance().sendObject(_loc3_);
      }
      
      private function btn_backhomeClick(param1:MouseEvent) : void
      {
         var _loc3_:MSG_REQUEST_FROMRESOURCESTARTOHOME = null;
         var _loc4_:MSG_REQUEST_SHIPTEAMGOHOME = null;
         this.Close();
         var _loc2_:GShipTeam = OutSideGalaxiasAction.getInstance().CurShip;
         if(_loc2_ == null)
         {
            return;
         }
         if(GalaxyMapAction.instance.curStar.Type == GalaxyType.GT_3)
         {
            _loc3_ = new MSG_REQUEST_FROMRESOURCESTARTOHOME();
            _loc3_.GalaxyMapId = GalaxyMapAction.instance.curStar.GalaxyMapId;
            _loc3_.GalaxyId = GalaxyMapAction.instance.curStar.GalaxyId;
            _loc3_.ShipTeamId = _loc2_.ShipTeamId;
            _loc3_.Guid = GamePlayer.getInstance().Guid;
            _loc3_.SeqId = GamePlayer.getInstance().seqID++;
            NetManager.Instance().sendObject(_loc3_);
         }
         else
         {
            _loc4_ = new MSG_REQUEST_SHIPTEAMGOHOME();
            _loc4_.ShipTeamId = _loc2_.ShipTeamId;
            _loc4_.Guid = GamePlayer.getInstance().Guid;
            _loc4_.SeqId = GamePlayer.getInstance().seqID++;
            NetManager.Instance().sendObject(_loc4_);
         }
      }
   }
}

