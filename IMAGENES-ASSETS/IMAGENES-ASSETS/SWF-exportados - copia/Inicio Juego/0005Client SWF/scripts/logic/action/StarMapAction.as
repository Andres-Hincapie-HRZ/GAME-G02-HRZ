package logic.action
{
   import com.star.frameworks.display.Container;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import logic.entry.AbstraceAction;
   import logic.entry.Effect02;
   import logic.entry.GShipTeam;
   import logic.entry.GamePlayer;
   import logic.game.GameKernel;
   import logic.game.GameSetting;
   import logic.manager.GalaxyShipManager;
   import logic.ui.FleetEditUI;
   import net.base.NetManager;
   import net.msg.ship.*;
   
   public class StarMapAction extends AbstraceAction
   {
      
      public static const GRID_WIDTH:int = 95;
      
      public static const GRID_HEIGHT:int = 56;
      
      public static const GRID_COUNT:int = 25;
      
      private static var _instance:StarMapAction = null;
      
      private var _bg:MovieClip;
      
      private var _starMapSprite:Container;
      
      private var _gridMapSprite:Sprite;
      
      private var _target:Sprite = new Sprite();
      
      private var _icon:MovieClip;
      
      private var _pathSprite:Sprite = new Sprite();
      
      private var _ship:GShipTeam = new GShipTeam();
      
      private var curShip:GShipTeam;
      
      public function StarMapAction(param1:HHH)
      {
         super();
         super.ActionName = "Map_StarMap_Action";
         this._bg = GameKernel.getMovieClipInstance("GalaxyMapBg");
         this._starMapSprite = new Container("StarMap");
         this._starMapSprite.addChild(this._bg);
         this._gridMapSprite = new Sprite();
         this._gridMapSprite.graphics.lineStyle(1);
         this._gridMapSprite.graphics.beginFill(16777215,0.01);
         this._gridMapSprite.graphics.moveTo(GRID_WIDTH * GRID_COUNT * 0.5,0);
         this._gridMapSprite.graphics.lineTo(0,GRID_HEIGHT * GRID_COUNT * 0.5);
         this._gridMapSprite.graphics.lineTo(GRID_WIDTH * GRID_COUNT * 0.5,GRID_HEIGHT * GRID_COUNT);
         this._gridMapSprite.graphics.lineTo(GRID_WIDTH * GRID_COUNT,GRID_HEIGHT * GRID_COUNT * 0.5);
         this._gridMapSprite.graphics.lineTo(GRID_WIDTH * GRID_COUNT * 0.5,0);
         this._gridMapSprite.graphics.endFill();
         this._gridMapSprite.graphics.lineStyle(1,16777215,0.3);
         var _loc2_:int = 0;
         while(_loc2_ <= 25)
         {
            this._gridMapSprite.graphics.moveTo(GRID_WIDTH * 0.5 * (GRID_COUNT + _loc2_),GRID_HEIGHT * 0.5 * _loc2_);
            this._gridMapSprite.graphics.lineTo(GRID_WIDTH * 0.5 * _loc2_,GRID_HEIGHT * 0.5 * (GRID_COUNT + _loc2_));
            this._gridMapSprite.graphics.moveTo(GRID_WIDTH * 0.5 * (GRID_COUNT - _loc2_),GRID_HEIGHT * 0.5 * _loc2_);
            this._gridMapSprite.graphics.lineTo(GRID_WIDTH * (GRID_COUNT - 0.5 * _loc2_),GRID_HEIGHT * 0.5 * (GRID_COUNT + _loc2_));
            _loc2_++;
         }
         this._gridMapSprite.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag,false,0,true);
         this._gridMapSprite.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag,false,0,true);
         this._gridMapSprite.addEventListener(MouseEvent.MOUSE_MOVE,this.onMove,false,0,true);
         this._gridMapSprite.addEventListener(MouseEvent.CLICK,this.onClick);
         this._starMapSprite.addChild(this._gridMapSprite);
         this._target.graphics.beginFill(16711680,0.5);
         this._target.graphics.moveTo(0,-28);
         this._target.graphics.lineTo(47.5,0);
         this._target.graphics.lineTo(0,28);
         this._target.graphics.lineTo(-47.5,0);
         this._target.graphics.lineTo(0,-28);
         this._target.graphics.endFill();
         this._gridMapSprite.addChild(this._target);
         this._icon = GameKernel.getMovieClipInstance("BuildMc2");
         this._icon.mouseEnabled = false;
         this._gridMapSprite.addChild(this._icon);
      }
      
      public static function get instance() : StarMapAction
      {
         if(_instance == null)
         {
            _instance = new StarMapAction(new HHH());
         }
         return _instance;
      }
      
      private function onEffectClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MSG_REQUEST_DIRECTIONSHIPTEAM = null;
         var _loc4_:MSG_REQUEST_DISBANDSHIPTEAM = null;
         switch(param1.target)
         {
            case Effect02.instance.btn1:
               _loc2_ = this.curShip.Direction == 3 ? 0 : this.curShip.Direction + 1;
               _loc3_ = new MSG_REQUEST_DIRECTIONSHIPTEAM();
               _loc3_.SeqId = GamePlayer.getInstance().seqID;
               _loc3_.Guid = GamePlayer.getInstance().Guid;
               _loc3_.ShipTeamId = this.curShip.ShipTeamId;
               _loc3_.Direction = _loc2_;
               NetManager.Instance().sendObject(_loc3_);
               break;
            case Effect02.instance.btn2:
               break;
            case Effect02.instance.btn3:
               if(this.curShip.UserId != -1)
               {
                  FleetEditUI.getInstance().UpdateFleet(this.curShip.ShipTeamId);
                  return;
               }
               break;
            case Effect02.instance.btn4:
               break;
            case Effect02.instance.btn5:
               _loc4_ = new MSG_REQUEST_DISBANDSHIPTEAM();
               _loc4_.Guid = GamePlayer.getInstance().Guid;
               _loc4_.SeqId = GamePlayer.getInstance().seqID++;
               _loc4_.ShipTeamId = this.curShip.ShipTeamId;
               NetManager.Instance().sendObject(_loc4_);
         }
      }
      
      private function initMapPathFinder() : void
      {
         var _loc1_:* = "";
         var _loc2_:int = 0;
         while(_loc2_ < GRID_COUNT * GRID_COUNT)
         {
            _loc1_ += "0";
            _loc2_++;
         }
      }
      
      private function initShipTeam() : void
      {
      }
      
      private function getBuild(param1:int, param2:int) : MovieClip
      {
         var _loc3_:MovieClip = GameKernel.getMovieClipInstance("BuildMc2");
         _loc3_.mouseEnabled = false;
         var _loc4_:int = GameSetting.MAP_OUTSIDE_GRID_WIDTH * 0.5 * (GameSetting.MAP_OUTSIDE_GRID_NUMBER - param2 + param1);
         var _loc5_:int = GameSetting.MAP_OUTSIDE_GRID_HEIGHT * 0.5 * (param1 + param2 + 1);
         _loc3_.x = _loc4_;
         _loc3_.y = _loc5_;
         return _loc3_;
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc9_:MSG_REQUEST_SHIPTEAMINFO = null;
         var _loc10_:MSG_REQUEST_MOVESHIPTEAM = null;
         var _loc2_:Point = GalaxyShipManager.getGird(param1.localX,param1.localY);
         var _loc3_:int = _loc2_.x;
         var _loc4_:int = _loc2_.y;
         var _loc5_:Point = GalaxyShipManager.getPixel(_loc3_,_loc4_);
         this._gridMapSprite.graphics.beginFill(16711680,0.5);
         this._gridMapSprite.graphics.moveTo(_loc5_.x,_loc5_.y - 28);
         this._gridMapSprite.graphics.lineTo(_loc5_.x + 47.5,_loc5_.y);
         this._gridMapSprite.graphics.lineTo(_loc5_.x,_loc5_.y + 28);
         this._gridMapSprite.graphics.lineTo(_loc5_.x - 47.5,_loc5_.y);
         this._gridMapSprite.graphics.lineTo(_loc5_.x,_loc5_.y - 28);
         this._gridMapSprite.graphics.endFill();
         this._gridMapSprite.addChild(this.getBuild(_loc3_,_loc4_));
         if(GalaxyShipManager.instance.getShipByPos(_loc3_,_loc4_))
         {
            this.curShip = GalaxyShipManager.instance.getShipByPos(_loc3_,_loc4_);
            if(this.curShip.UserId == -1)
            {
               _loc9_ = new MSG_REQUEST_SHIPTEAMINFO();
               _loc9_.SeqId = GamePlayer.getInstance().seqID++;
               _loc9_.Guid = GamePlayer.getInstance().Guid;
               _loc9_.GalaxyMapId = this.curShip.GalaxyMapId;
               _loc9_.GalaxyId = this.curShip.GalaxyId;
               _loc9_.ShipTeamId = this.curShip.ShipTeamId;
               NetManager.Instance().sendObject(_loc9_);
            }
            Effect02.instance.open();
         }
         else if(this.curShip)
         {
            _loc10_ = new MSG_REQUEST_MOVESHIPTEAM();
            _loc10_.Guid = GamePlayer.getInstance().Guid;
            _loc10_.SeqId = GamePlayer.getInstance().seqID++;
            _loc10_.ShipTeamId = this.curShip.ShipTeamId;
            _loc10_.PosX = _loc3_;
            _loc10_.PosY = _loc4_;
            NetManager.Instance().sendObject(_loc10_);
            Effect02.instance.close();
            this.curShip = null;
         }
         this._target.x = GRID_WIDTH * 0.5 * (GRID_COUNT - _loc4_ + _loc3_);
         this._target.y = GRID_HEIGHT * 0.5 * (_loc3_ + _loc4_ + 1);
         var _loc8_:Point = new Point(_loc3_,_loc4_);
         if(!this._gridMapSprite.getChildByName("shipTeam"))
         {
         }
      }
      
      private function onStartDrag(param1:MouseEvent) : void
      {
         param1.target.startDrag();
      }
      
      private function onStopDrag(param1:MouseEvent) : void
      {
         param1.target.stopDrag();
      }
      
      private function onMove(param1:MouseEvent) : void
      {
         var _loc2_:Point = GalaxyShipManager.getGird(param1.localX,param1.localY);
         _loc2_ = GalaxyShipManager.getPixel(_loc2_.x,_loc2_.y);
         this._icon.x = _loc2_.x;
         this._icon.y = _loc2_.y;
      }
      
      override public function Init() : void
      {
      }
      
      public function Release() : void
      {
         GameKernel.renderManager.getMap().removeComponent(this._starMapSprite,true);
      }
      
      override public function getUI() : Container
      {
         return this._starMapSprite;
      }
      
      public function get gridMapSprite() : Sprite
      {
         return this._gridMapSprite;
      }
   }
}

class HHH
{
   
   public function HHH()
   {
      super();
   }
}
