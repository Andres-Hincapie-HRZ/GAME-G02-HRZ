package logic.manager
{
   import com.star.frameworks.utils.HashSet;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.geom.Point;
   import logic.action.GalaxyMapAction;
   import logic.action.OutSideGalaxiasAction;
   import logic.action.StarMapAction;
   import logic.entry.GShipTeam;
   import logic.entry.GamePlayer;
   import logic.entry.shipmodel.ShipbodyInfo;
   import logic.game.GameKernel;
   import logic.game.GameSetting;
   import logic.reader.CShipmodelReader;
   import net.base.NetManager;
   import net.msg.ship.*;
   
   public class GalaxyShipManager
   {
      
      private static var _instance:GalaxyShipManager = null;
      
      public var _shipDatas:HashSet = new HashSet();
      
      public function GalaxyShipManager()
      {
         super();
      }
      
      public static function getGird(param1:Number, param2:Number) : Point
      {
         var _loc3_:Number = -GameSetting.MAP_OUTSIDE_GRID_HEIGHT / GameSetting.MAP_OUTSIDE_GRID_WIDTH;
         var _loc4_:Number = GameSetting.MAP_OUTSIDE_GRID_HEIGHT * GameSetting.MAP_OUTSIDE_GRID_NUMBER * 0.5;
         var _loc5_:Number = param2 - _loc3_ * param1;
         var _loc6_:Number = Math.sqrt(GameSetting.MAP_OUTSIDE_GRID_WIDTH * 0.5 * (GameSetting.MAP_OUTSIDE_GRID_WIDTH * 0.5) + GameSetting.MAP_OUTSIDE_GRID_HEIGHT * 0.5 * (GameSetting.MAP_OUTSIDE_GRID_HEIGHT * 0.5));
         var _loc7_:int = Math.floor((_loc5_ - _loc4_) / _loc6_);
         _loc3_ = GameSetting.MAP_OUTSIDE_GRID_HEIGHT / GameSetting.MAP_OUTSIDE_GRID_WIDTH;
         _loc5_ = param2 - _loc3_ * param1;
         var _loc8_:int = Math.floor((_loc5_ + _loc4_) / _loc6_);
         return new Point(_loc7_,_loc8_);
      }
      
      public static function getPixel(param1:int, param2:int) : Point
      {
         var _loc3_:int = GameSetting.MAP_OUTSIDE_GRID_WIDTH * 0.5 * (GameSetting.MAP_OUTSIDE_GRID_NUMBER - param2 + param1);
         var _loc4_:int = GameSetting.MAP_OUTSIDE_GRID_HEIGHT * 0.5 * (param1 + param2 + 1);
         return new Point(_loc3_,_loc4_);
      }
      
      public static function get instance() : GalaxyShipManager
      {
         if(_instance == null)
         {
            _instance = new GalaxyShipManager();
         }
         return _instance;
      }
      
      public function getAllShipSGalaxyId() : Array
      {
         var _loc1_:HashSet = new HashSet();
         var _loc2_:int = 0;
         while(_loc2_ < this._shipDatas.Length())
         {
            _loc1_.Put((this._shipDatas.Values()[_loc2_] as GShipTeam).GalaxyId + "",this._shipDatas.Values()[_loc2_]);
            _loc2_++;
         }
         return _loc1_.Keys();
      }
      
      public function getShipsByGalaxyId(param1:int) : Array
      {
         var _loc4_:GShipTeam = null;
         var _loc2_:Array = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < this._shipDatas.Length())
         {
            _loc4_ = this._shipDatas.Values()[_loc3_] as GShipTeam;
            if(param1 == _loc4_.GalaxyId)
            {
               _loc2_.push(_loc4_);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function showShipTeam() : void
      {
         var _loc1_:GShipTeam = null;
         var _loc3_:Bitmap = null;
         var _loc2_:int = 0;
         while(_loc2_ < this._shipDatas.Length())
         {
            _loc1_ = this._shipDatas.Values()[_loc2_];
            if(_loc1_.GalaxyId == GalaxyMapAction.instance.curStar.GalaxyId)
            {
               if(_loc1_.ShipTeamId != -1 && !StarMapAction.instance.gridMapSprite.getChildByName(_loc1_.ShipTeamId + ""))
               {
                  _loc1_.setShipPos(_loc1_.PosX,_loc1_.PosY);
                  _loc1_.changeDirection(_loc1_.Direction);
                  switch(_loc1_.Owner)
                  {
                     case 0:
                        _loc3_ = new Bitmap(GameKernel.getTextureInstance("Defense"));
                        break;
                     case 1:
                        _loc3_ = new Bitmap(GameKernel.getTextureInstance("Attack"));
                        break;
                     case 2:
                        _loc3_ = new Bitmap(GameKernel.getTextureInstance("SelfFlag"));
                  }
                  _loc3_.name = "Flag";
                  _loc3_.x = -24;
                  _loc3_.y = 20;
                  _loc1_.getShipMc().addChild(_loc3_);
                  OutSideGalaxiasAction.getInstance().Init();
                  if(OutSideGalaxiasAction.getInstance().OutSideDefendContainer.getChildByName(_loc1_.ShipTeamId + "") == null)
                  {
                     OutSideGalaxiasAction.getInstance().OutSideDefendContainer.addChild(_loc1_.getShipMc());
                  }
               }
            }
            _loc2_++;
         }
      }
      
      public function releaseShipTeam() : void
      {
         var _loc2_:GShipTeam = null;
         var _loc3_:DisplayObjectContainer = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._shipDatas.Length())
         {
            _loc2_ = this._shipDatas.Values()[_loc1_];
            if(_loc2_.getShipMc().getChildByName("Flag"))
            {
               _loc2_.getShipMc().removeChild(_loc2_.getShipMc().getChildByName("Flag"));
            }
            _loc3_ = OutSideGalaxiasAction.getInstance().OutSideDefendContainer;
            if(_loc3_.contains(_loc2_.getShipMc()))
            {
               _loc3_.removeChild(_loc2_.getShipMc());
            }
            _loc1_++;
         }
         this._shipDatas.removeAll();
         this._shipDatas.Clear();
      }
      
      public function renderOneShipTeam(param1:GShipTeam) : void
      {
         if(this.pushShipDatas(param1))
         {
            param1.setShipPos(param1.PosX,param1.PosY);
            param1.changeDirection(param1.Direction);
            OutSideGalaxiasAction.getInstance().OutSideDefendContainer.addChild(param1.getShipMc());
         }
      }
      
      public function deleteOneShipTeam(param1:int) : void
      {
         if(!this._shipDatas.Get(param1))
         {
            return;
         }
         var _loc2_:DisplayObject = OutSideGalaxiasAction.getInstance().OutSideDefendContainer.getChildByName(param1 + "") as DisplayObject;
         var _loc3_:int = 0;
         if(_loc2_ != null)
         {
            OutSideGalaxiasAction.getInstance().OutSideDefendContainer.removeChild(_loc2_);
         }
         this._shipDatas.Remove(param1 + "");
      }
      
      public function getShipImg(param1:int) : Bitmap
      {
         var _loc2_:ShipbodyInfo = CShipmodelReader.getInstance().getShipBodyInfo(param1);
         return new Bitmap(GameKernel.getTextureInstance(_loc2_.SmallIcon));
      }
      
      public function getShipByPos(param1:int, param2:int) : GShipTeam
      {
         var _loc4_:GShipTeam = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < this._shipDatas.Length())
         {
            _loc4_ = this._shipDatas.Values()[_loc3_] as GShipTeam;
            if(_loc4_.PosX == param1 && _loc4_.PosY == param2 && _loc4_.Owner == 2)
            {
               return _loc4_;
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this._shipDatas.Length())
         {
            _loc4_ = this._shipDatas.Values()[_loc3_] as GShipTeam;
            if(_loc4_.PosX == param1 && _loc4_.PosY == param2)
            {
               return _loc4_;
            }
            _loc3_++;
         }
         return null;
      }
      
      public function getShipsByPos(param1:int, param2:int) : Array
      {
         var _loc5_:GShipTeam = null;
         var _loc3_:Array = new Array();
         var _loc4_:int = 0;
         while(_loc4_ < this._shipDatas.Length())
         {
            _loc5_ = this._shipDatas.Values()[_loc4_] as GShipTeam;
            if(_loc5_.PosX == param1 && _loc5_.PosY == param2 && _loc5_.Owner == 2)
            {
               _loc3_.push(_loc5_);
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function getShipDatas(param1:int) : GShipTeam
      {
         if(this._shipDatas.Get(param1 + ""))
         {
            return this._shipDatas.Get(param1) as GShipTeam;
         }
         return null;
      }
      
      public function getShipByCommanderId(param1:int) : GShipTeam
      {
         var _loc2_:GShipTeam = null;
         var _loc3_:int = 0;
         while(_loc3_ < this._shipDatas.Length())
         {
            _loc2_ = this._shipDatas.Values()[_loc3_] as GShipTeam;
            if(_loc2_.CommanderID == param1)
            {
               return _loc2_;
            }
            _loc3_++;
         }
         return null;
      }
      
      public function pushShipDatas(param1:GShipTeam) : Boolean
      {
         if(this._shipDatas.ContainsKey(param1.ShipTeamId))
         {
            param1 = this._shipDatas.Get(param1.ShipTeamId);
            return false;
         }
         this._shipDatas.Put(param1.ShipTeamId,param1);
         return true;
      }
      
      public function DEGUG() : void
      {
      }
      
      public function requestShipMove(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:MSG_REQUEST_MOVESHIPTEAM = new MSG_REQUEST_MOVESHIPTEAM();
         _loc4_.Guid = GamePlayer.getInstance().Guid;
         _loc4_.SeqId = GamePlayer.getInstance().seqID++;
         _loc4_.ShipTeamId = param1;
         _loc4_.PosX = param2;
         _loc4_.PosY = param3;
         NetManager.Instance().sendObject(_loc4_);
      }
      
      public function requestShipTeamInfo(param1:GShipTeam) : void
      {
         var _loc2_:MSG_REQUEST_SHIPTEAMINFO = new MSG_REQUEST_SHIPTEAMINFO();
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         _loc2_.GalaxyMapId = param1.GalaxyMapId;
         _loc2_.GalaxyId = param1.GalaxyId;
         _loc2_.ShipTeamId = param1.ShipTeamId;
         NetManager.Instance().sendObject(_loc2_);
      }
      
      public function MoveHome(param1:int, param2:int) : void
      {
         var _loc4_:GShipTeam = null;
         var _loc3_:int = 0;
         while(_loc3_ < this._shipDatas.Values().length)
         {
            _loc4_ = this._shipDatas.Values()[_loc3_] as GShipTeam;
            _loc4_.GalaxyMapId = param1;
            _loc4_.GalaxyId = param2;
            _loc3_++;
         }
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
