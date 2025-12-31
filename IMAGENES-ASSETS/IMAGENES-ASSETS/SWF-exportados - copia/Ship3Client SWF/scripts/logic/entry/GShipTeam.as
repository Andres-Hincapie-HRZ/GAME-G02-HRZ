package logic.entry
{
   import com.star.frameworks.utils.MusicResHandler;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Point;
   import gs.TweenLite;
   import logic.action.OutSideGalaxiasAction;
   import logic.action.StarMapAction;
   import logic.entry.shipmodel.ShipbodyInfo;
   import logic.entry.shipmodel.ShipmodelInfo;
   import logic.entry.shipmodel.ShippartInfo;
   import logic.game.GameFont;
   import logic.game.GameKernel;
   import logic.game.GameSetting;
   import logic.reader.CShipmodelReader;
   import net.common.MsgTypes;
   import net.router.ShipmodelRouter;
   
   public class GShipTeam
   {
      
      public var GalaxyMapId:int = -1;
      
      public var GalaxyId:int = -1;
      
      public var ShipTeamId:int = -1;
      
      public var ShipNum:int = -1;
      
      public var BodyId:int = -1;
      
      public var Reserve:int = -1;
      
      public var Direction:int = -1;
      
      public var PosX:int = -1;
      
      public var PosY:int = -1;
      
      public var Owner:int = -1;
      
      public var UserId:Number = -1;
      
      public var Gas:uint = 0;
      
      public var Storage:uint;
      
      public var CommanderID:int = -1;
      
      public var TeamName:String = "";
      
      public var Commander:String = "";
      
      public var TeamOwner:String = "";
      
      public var Consortia:String = "";
      
      public var TeamBody:Array = new Array();
      
      public var CommanderHeadId:int;
      
      public var AttackObjInterval:int;
      
      public var AttackObjType:int;
      
      public var LevelId:int;
      
      public var CardLevel:int;
      
      public var GasPercent:int = 0;
      
      private var _icon:MovieClip;
      
      private var _selfFlag:Bitmap = new Bitmap();
      
      private var _tfNum:Bitmap = new Bitmap();
      
      private var _name:String = "shipTeam";
      
      private var _gridPos:Point = new Point(0,0);
      
      public var _isMove:Boolean = false;
      
      private var _pathArray:Array;
      
      private var _move:Boolean = false;
      
      private var count:int = 0;
      
      private var GRID_WIDTH:int = StarMapAction.GRID_WIDTH;
      
      private var GRID_HEIGHT:int = StarMapAction.GRID_HEIGHT;
      
      private var GRID_COUNT:int = StarMapAction.GRID_COUNT;
      
      private var tempx:Number = 0;
      
      private var tempy:Number = 0;
      
      private var moveEffect:MovieClip;
      
      public function GShipTeam()
      {
         super();
         var _loc1_:int = 0;
         while(_loc1_ < MsgTypes.MAX_SHIPTEAMBODY)
         {
            this.TeamBody.push(new GShip());
            _loc1_++;
         }
      }
      
      private function updateBody() : void
      {
         if(this.BodyId == -1)
         {
            return;
         }
         var _loc1_:ShipbodyInfo = CShipmodelReader.getInstance().getShipBodyInfo(this.BodyId);
         this._icon = GameKernel.getMovieClipInstance(_loc1_.ImageFileName,0,0,true);
         this._icon.stop();
         this._icon.mouseEnabled = false;
         this._icon.name = this.ShipTeamId + "";
         this.initFlag();
         this.updateFlag();
         this.initShipNum();
         this.freshShipNum();
      }
      
      public function freshShipBody() : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(this.BodyId == -1)
         {
            return;
         }
         var _loc1_:ShipbodyInfo = CShipmodelReader.getInstance().getShipBodyInfo(this.BodyId);
         var _loc2_:MovieClip = GameKernel.getMovieClipInstance(_loc1_.ImageFileName,0,0,true);
         if(Boolean(this._icon) && Boolean(_loc2_))
         {
            this._icon.removeChild(this._tfNum);
            OutSideGalaxiasAction.getInstance().OutSideDefendContainer.removeChild(this._icon);
            this._icon = _loc2_;
            _loc3_ = GameSetting.MAP_OUTSIDE_GRID_WIDTH * 0.5 * (GameSetting.MAP_OUTSIDE_GRID_NUMBER - this.PosY + this.PosX);
            _loc4_ = GameSetting.MAP_OUTSIDE_GRID_HEIGHT * 0.5 * (this.PosX + this.PosY + 1);
            this._icon.cacheAsBitmap = true;
            this._icon.x = _loc3_;
            this._icon.y = _loc4_ - GameSetting.MAP_OUTSIDE_GRID_HEIGHT * 0.2;
            this._icon.stop();
            this._icon.mouseEnabled = false;
            this._icon.name = this.ShipTeamId + "";
            this._icon.gotoAndStop(this.Direction + 1);
            OutSideGalaxiasAction.getInstance().OutSideDefendContainer.addChild(this._icon);
            this.initFlag();
            this.updateFlag();
            this.initShipNum();
            this.freshShipNum();
            this._icon.gotoAndStop(this.Direction + 1);
         }
      }
      
      private function initFlag() : void
      {
         this._selfFlag.name = "Flag";
         this._selfFlag.x = -24;
         this._selfFlag.y = 22;
         this._icon.addChild(this._selfFlag);
      }
      
      public function updateFlag() : void
      {
         switch(this.Owner)
         {
            case 0:
               this._selfFlag.bitmapData = GameKernel.getTextureInstance("Defense");
               break;
            case 1:
               this._selfFlag.bitmapData = GameKernel.getTextureInstance("Attack");
               break;
            case 2:
               this._selfFlag.bitmapData = GameKernel.getTextureInstance("SelfFlag");
         }
      }
      
      private function initShipNum() : void
      {
         this._tfNum.x = -10;
         this._tfNum.y = 20;
         this._icon.addChild(this._tfNum);
      }
      
      public function freshShipNum() : void
      {
         if(this.ShipNum == 0)
         {
            this._tfNum.bitmapData = null;
         }
         else
         {
            this._tfNum.bitmapData = GameFont.getInt(this.ShipNum);
         }
      }
      
      public function getShipMc() : MovieClip
      {
         if(this._icon == null)
         {
            this.updateBody();
         }
         return this._icon;
      }
      
      public function setShipPos(param1:int, param2:int) : void
      {
         this.PosX = param1;
         this.PosY = param2;
         var _loc3_:int = GameSetting.MAP_OUTSIDE_GRID_WIDTH * 0.5 * (GameSetting.MAP_OUTSIDE_GRID_NUMBER - this.PosY + this.PosX);
         var _loc4_:int = GameSetting.MAP_OUTSIDE_GRID_HEIGHT * 0.5 * (param1 + param2 + 1);
         this.getShipMc();
         this._icon.cacheAsBitmap = true;
         this._icon.x = _loc3_;
         this._icon.y = _loc4_ - GameSetting.MAP_OUTSIDE_GRID_HEIGHT * 0.2;
      }
      
      public function fightMove(param1:int) : void
      {
         switch(param1)
         {
            case 0:
               this.PosX += 1;
               break;
            case 1:
               this.PosY += 1;
               break;
            case 2:
               --this.PosX;
               break;
            case 3:
               --this.PosY;
         }
      }
      
      public function beMove(param1:int, param2:int) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         switch(param1)
         {
            case 0:
               this.PosX += param2;
               break;
            case 1:
               this.PosY += param2;
               break;
            case 2:
               this.PosX -= param2;
               break;
            case 3:
               this.PosY -= param2;
         }
         this.setShipPos(this.PosX,this.PosY);
      }
      
      public function shipMove(param1:int, param2:int) : void
      {
         if(!this._isMove)
         {
            return;
         }
         var _loc3_:MovieClip = GameKernel.getMovieClipInstance("YueqianMc");
         _loc3_.mouseEnabled = false;
         _loc3_.name = this.ShipTeamId + "YueqianMc";
         _loc3_.x = this._icon.x;
         _loc3_.y = this._icon.y;
         if(OutSideGalaxiasAction.getInstance().OutSideDefendContainer.contains(this._icon))
         {
            OutSideGalaxiasAction.getInstance().OutSideDefendContainer.removeChild(this._icon);
         }
         OutSideGalaxiasAction.getInstance().OutSideDefendContainer.addChild(_loc3_);
         var _loc4_:int = GameSetting.MAP_OUTSIDE_GRID_WIDTH * 0.5 * (GameSetting.MAP_OUTSIDE_GRID_NUMBER - param2 + param1);
         var _loc5_:int = GameSetting.MAP_OUTSIDE_GRID_HEIGHT * 0.5 * (param1 + param2 + 1);
         var _loc6_:Number = Math.atan2(_loc5_ - this._icon.y,_loc4_ - this._icon.x);
         var _loc7_:Number = Math.round(_loc6_ * 180 / Math.PI);
         _loc3_.rotation = _loc7_;
         this._icon.x = _loc4_;
         this._icon.y = _loc5_ - GameSetting.MAP_OUTSIDE_GRID_HEIGHT * 0.2;
         TweenLite.to(_loc3_,0.8,{
            "x":_loc4_,
            "y":_loc5_,
            "onComplete":this.moveComplete
         });
         this.PosX = param1;
         this.PosY = param2;
      }
      
      public function moveComplete() : void
      {
         this._isMove = false;
         OutSideGalaxiasAction.getInstance().OutSideDefendContainer.addChild(this._icon);
         var _loc1_:DisplayObject = OutSideGalaxiasAction.getInstance().OutSideDefendContainer.getChildByName(this.ShipTeamId + "YueqianMc");
         var _loc2_:int = 0;
         while(_loc1_ != null)
         {
            if(++_loc2_ > 10)
            {
               break;
            }
            OutSideGalaxiasAction.getInstance().OutSideDefendContainer.removeChild(_loc1_);
            _loc1_ = null;
            _loc1_ = OutSideGalaxiasAction.getInstance().OutSideDefendContainer.getChildByName(this.ShipTeamId + "YueqianMc");
         }
      }
      
      public function updateShipPos(param1:Array) : void
      {
         this._pathArray = param1;
         this._move = true;
         this._icon.addEventListener(Event.ENTER_FRAME,this.onFrame);
      }
      
      public function onFrame(param1:Event) : void
      {
         if(this._pathArray.length < 0)
         {
            return;
         }
         if(!this._pathArray[1] || !this._pathArray[0])
         {
            return;
         }
         if(!this._move)
         {
            return;
         }
         if(this.count == 0)
         {
            this.tempx = this.GRID_WIDTH * 0.5 * (this._pathArray[0].y - this._pathArray[1].y - this._pathArray[0].x + this._pathArray[1].x);
            this.tempy = this.GRID_HEIGHT * 0.5 * (this._pathArray[1].x + this._pathArray[1].y - this._pathArray[0].x - this._pathArray[0].y);
            if(this.tempx > 0 && this.tempy < 0)
            {
               this._icon.gotoAndStop(1);
            }
            if(this.tempx > 0 && this.tempy > 0)
            {
               this._icon.gotoAndStop(2);
            }
            if(this.tempx < 0 && this.tempy > 0)
            {
               this._icon.gotoAndStop(3);
            }
            if(this.tempx < 0 && this.tempy < 0)
            {
               this._icon.gotoAndStop(4);
            }
         }
         this._icon.x += this.tempx * 0.1;
         this._icon.y += this.tempy * 0.1;
         ++this.count;
         if(this.count == 10)
         {
            if(!this._pathArray[1])
            {
               this._icon.removeEventListener(Event.ENTER_FRAME,this.onFrame);
               this._pathArray.splice(0);
               this._move = false;
            }
            else
            {
               this._pathArray.shift();
            }
            this.count = 0;
         }
      }
      
      public function changeDirection(param1:int) : void
      {
         this.Direction = param1;
         this._icon.gotoAndStop(param1 + 1);
      }
      
      public function AllStorage() : int
      {
         var _loc1_:GShip = null;
         var _loc5_:ShipmodelInfo = null;
         var _loc6_:int = 0;
         var _loc7_:ShippartInfo = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < 9)
         {
            _loc1_ = this.TeamBody[_loc4_] as GShip;
            if(_loc1_.ShipModelId >= 0)
            {
               _loc5_ = ShipmodelRouter.instance.ShipModeList.Get(_loc1_.ShipModelId);
               _loc6_ = 0;
               while(_loc6_ < _loc5_.m_PartId.length)
               {
                  _loc7_ = CShipmodelReader.getInstance().getShipPartInfo(_loc5_.m_PartId[_loc6_]);
                  _loc3_ += _loc7_.Storage;
                  _loc6_++;
               }
               _loc2_ += _loc3_ * this.ShipNum;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function get gridPos() : Point
      {
         return this._gridPos;
      }
      
      public function set gridPos(param1:Point) : void
      {
         this._gridPos = param1;
      }
      
      public function moveSkillEffect() : void
      {
         this.moveEffect = GameKernel.getMovieClipInstance("ShipBlast2");
         this.moveEffect.name = "MoveEffect";
         this.moveEffect.play();
         this.moveEffect.addEventListener(Event.ENTER_FRAME,this.SkillEffectFrame);
         MusicResHandler.PlayEffectMusic(MusicResHandler.MOVE_EFFECT);
         this._icon.addChildAt(this.moveEffect,0);
      }
      
      private function SkillEffectFrame(param1:Event) : void
      {
         if(this.moveEffect.currentFrame == this.moveEffect.totalFrames)
         {
            this.moveEffect.stop();
            this.moveEffect.removeEventListener(Event.ENTER_FRAME,this.SkillEffectFrame);
            if(this._icon.contains(this.moveEffect))
            {
               this._icon.removeChild(this.moveEffect);
            }
         }
      }
   }
}

