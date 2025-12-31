package logic.manager
{
   import com.star.frameworks.facebook.FacebookUserInfo;
   import com.star.frameworks.utils.HashSet;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import flash.net.LocalConnection;
   import logic.action.GalaxyMapAction;
   import logic.action.OutSideGalaxiasAction;
   import logic.entry.GStar;
   import logic.entry.GalaxyType;
   import logic.entry.GamePlayer;
   import logic.entry.GameStageEnum;
   import logic.game.GameKernel;
   import logic.ui.GotoGalaxyUI;
   import net.base.NetManager;
   import net.msg.galaxyMap.*;
   
   public class GalaxyManager
   {
      
      private static var _maxArea:int;
      
      public static const AREAGRIDX:int = 10;
      
      public static const AREAGRIDY:int = 10;
      
      public static const GRIDPIXELX:int = 80;
      
      public static const GRIDPIXELY:int = 80;
      
      public static const AREAGRID:int = AREAGRIDX * AREAGRIDY;
      
      public static const MAX_MAPAREA:int = 42;
      
      public static var MAX_MAPAREAGRID_X:int = _maxArea * 360 / 42;
      
      public static var MAX_MAPAREAGRID:int = AREAGRIDY * MAX_MAPAREA;
      
      public static var MAX_MAPAREAS:int = _maxArea * 3600;
      
      private static var starInfoMap:HashSet = new HashSet();
      
      private static var _instance:GalaxyManager = null;
      
      private var _miniMapDatas:Array = new Array();
      
      private var _currMapDatas:Array = new Array();
      
      private var _cacheMapDatas:Array = new Array();
      
      private var gridH:int = 3;
      
      private var gridW:int = 3;
      
      private var freshX:int = 0;
      
      private var freshY:int = 0;
      
      private var _enterStar:GStar = null;
      
      private var UserIdList:Array = new Array();
      
      private var UserNameList:Array = new Array();
      
      public var LastRequestGalaxyId:int;
      
      private var ballGridW:uint = 80;
      
      private var ballGridH:uint = 80;
      
      public function GalaxyManager(param1:HHH)
      {
         super();
      }
      
      public static function getStarCoordinate(param1:int) : Point
      {
         return new Point(Math.floor(param1 / GalaxyManager.MAX_MAPAREAGRID),param1 % GalaxyManager.MAX_MAPAREAGRID);
      }
      
      public static function getStarIndex(param1:int, param2:int) : int
      {
         return param2 + param1 * GalaxyManager.MAX_MAPAREAGRID;
      }
      
      public static function getStarArea(param1:int) : int
      {
         var _loc2_:int = Math.floor(Math.floor(param1 / GalaxyManager.MAX_MAPAREAGRID) / GalaxyManager.AREAGRIDX) * GalaxyManager.MAX_MAPAREA;
         var _loc3_:int = Math.floor(param1 % GalaxyManager.MAX_MAPAREAGRID / GalaxyManager.AREAGRIDY);
         return _loc2_ + _loc3_;
      }
      
      public static function RequestMapDatas(param1:int) : void
      {
         var _loc2_:MSG_REQUEST_MAPAREA = new MSG_REQUEST_MAPAREA();
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         _loc2_.GalaxyMapId = 0;
         var _loc3_:int = 0;
         while(_loc3_ < 9)
         {
            _loc2_.RegionId[_loc3_] = -1;
            _loc3_++;
         }
         _loc2_.RegionId[0] = param1;
         NetManager.Instance().sendObject(_loc2_);
         _loc2_.release();
      }
      
      public static function RequestMapsDatas(param1:Array) : void
      {
         var _loc2_:MSG_REQUEST_MAPAREA = new MSG_REQUEST_MAPAREA();
         var _loc3_:int = 0;
         while(_loc3_ < 16)
         {
            _loc2_.RegionId[_loc3_] = -1;
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_.RegionId[_loc3_] = param1[_loc3_];
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc2_.RegionId.length)
         {
            if(_loc2_.RegionId[_loc3_] != -1)
            {
               _loc2_.SeqId = GamePlayer.getInstance().seqID++;
               _loc2_.Guid = GamePlayer.getInstance().Guid;
               _loc2_.GalaxyMapId = 0;
               NetManager.Instance().sendObject(_loc2_);
               break;
            }
            _loc3_++;
         }
         _loc2_.release();
      }
      
      public static function get instance() : GalaxyManager
      {
         if(_instance == null)
         {
            _instance = new GalaxyManager(new HHH());
         }
         return _instance;
      }
      
      public static function get maxArea() : int
      {
         return _maxArea;
      }
      
      public static function set maxArea(param1:int) : void
      {
         _maxArea = param1;
         MAX_MAPAREAGRID_X = _maxArea * 360 / 42;
         MAX_MAPAREAGRID = AREAGRIDY * MAX_MAPAREA;
         MAX_MAPAREAS = _maxArea * 3600;
      }
      
      public static function getStarTexture(param1:int) : BitmapData
      {
         var _loc2_:int = 0;
         if(param1 == 0)
         {
            _loc2_ = int(GalaxyType.GT_6);
         }
         else if(param1 == 1)
         {
            _loc2_ = int(GalaxyType.GT_3);
         }
         else if(param1 == 2)
         {
            _loc2_ = 101;
         }
         return GameKernel.getTextureInstance("Star" + _loc2_);
      }
      
      public function printAllStar() : void
      {
         var _loc4_:GStar = null;
      }
      
      public function fresh() : void
      {
         this.printCacheStar(this.freshX,this.freshY);
      }
      
      public function get enterStar() : GStar
      {
         if(GalaxyManager.instance.getData(this._enterStar.GalaxyId))
         {
            this._enterStar = GalaxyManager.instance.getData(this._enterStar.GalaxyId);
         }
         return this._enterStar;
      }
      
      public function set enterStar(param1:GStar) : void
      {
         this._enterStar = param1;
      }
      
      public function isMineHome() : Boolean
      {
         return this._enterStar.GalaxyId == GamePlayer.getInstance().galaxyStar.GalaxyId;
      }
      
      public function RefreshStarInfo(param1:int, param2:Number = -1, param3:String = "") : void
      {
         var _loc4_:int = param1 / GalaxyManager.MAX_MAPAREAGRID;
         var _loc5_:int = param1 % GalaxyManager.MAX_MAPAREAGRID;
         this._cacheMapDatas[param1] = null;
         if(_loc4_ < this.freshX || _loc4_ > this.freshX + AREAGRIDX * 3)
         {
            return;
         }
         if(_loc5_ < this.freshY || _loc5_ > this.freshY + AREAGRIDY * 3)
         {
            return;
         }
         var _loc6_:int = _loc4_ - this.freshX;
         var _loc7_:int = _loc5_ - this.freshY;
         var _loc8_:String = "ball" + _loc7_ + _loc6_;
         var _loc9_:DisplayObject = GalaxyMapAction.instance.curMapSprite.getChildByName(_loc8_);
         if(_loc9_)
         {
            GalaxyMapAction.instance.curMapSprite.removeChild(_loc9_);
         }
         this._cacheMapDatas[_loc6_ * AREAGRIDX * 3 + _loc7_] = this._miniMapDatas[param1];
         this.PrintStar(param1,_loc6_,_loc7_,param2,param3);
      }
      
      private function PrintStar(param1:int, param2:int, param3:int, param4:Number = -1, param5:String = "") : void
      {
         var _loc6_:GStar = null;
         var _loc7_:Point = null;
         var _loc8_:Bitmap = null;
         var _loc9_:StarInfo = null;
         var _loc10_:Array = null;
         var _loc11_:int = 0;
         var _loc12_:MSG_HOLDGALAXY_TEMP = null;
         var _loc13_:DisplayObject = null;
         var _loc14_:DisplayObject = null;
         if(this._miniMapDatas[param1])
         {
            _loc6_ = this._miniMapDatas[param1] as GStar;
            _loc7_ = getStarCoordinate(param1);
            _loc8_ = null;
            _loc9_ = null;
            switch(_loc6_.Type)
            {
               case GalaxyType.GT_1:
                  if(GalaxyMapAction.instance.MapButtonStatus == 1)
                  {
                     _loc8_ = this.getBallImg(_loc6_.Type);
                     _loc8_.x = param2 * this.ballGridW;
                     _loc8_.y = param3 * this.ballGridH;
                     _loc8_.name = "ball" + param3 + "" + param2;
                  }
                  break;
               case GalaxyType.GT_2:
                  if(_loc6_.LoserFlag == 1)
                  {
                     _loc8_ = this.getBallImg(101);
                  }
                  else
                  {
                     _loc8_ = this.getBallImg(100);
                  }
                  _loc8_.x = param2 * this.ballGridW;
                  _loc8_.y = param3 * this.ballGridH;
                  _loc8_.name = "ball" + param3 + "" + param2;
                  _loc9_ = new StarInfo();
                  _loc9_.x = param2 * this.ballGridW;
                  _loc9_.y = param3 * this.ballGridH - 30;
                  break;
               case GalaxyType.GT_3:
                  _loc8_ = this.getBallImg(_loc6_.Type);
                  _loc8_.x = param2 * this.ballGridW;
                  _loc8_.y = param3 * this.ballGridH;
                  _loc8_.name = "ball" + param3 + "" + param2;
                  _loc9_ = new StarInfo();
                  _loc9_.x = param2 * this.ballGridW;
                  _loc9_.y = param3 * this.ballGridH - 30;
                  break;
               case GalaxyType.GT_4:
                  _loc8_ = this.getBallImg(_loc6_.Type,_loc6_.StarFace);
                  _loc8_.x = param2 * this.ballGridW;
                  _loc8_.y = param3 * this.ballGridH;
                  _loc8_.name = "ball" + param3 + "" + param2;
                  _loc9_ = new StarInfo();
                  _loc9_.x = param2 * this.ballGridW;
                  _loc9_.y = param3 * this.ballGridH - 30;
                  break;
               case GalaxyType.GT_5:
                  _loc8_ = this.getBallImg(_loc6_.Type,_loc6_.StarFace);
                  _loc8_.x = param2 * this.ballGridW;
                  _loc8_.y = param3 * this.ballGridH;
                  _loc8_.name = "ball" + param3 + "" + param2;
                  _loc9_ = new StarInfo();
                  _loc9_.x = param2 * this.ballGridW;
                  _loc9_.y = param3 * this.ballGridH - 30;
                  break;
               case GalaxyType.GT_6:
                  _loc8_ = this.getBallImg(_loc6_.Type,_loc6_.StarFace);
                  _loc8_.x = param2 * this.ballGridW;
                  _loc8_.y = param3 * this.ballGridH;
                  _loc8_.name = "ball" + param3 + "" + param2;
                  _loc9_ = new StarInfo();
                  _loc9_.x = param2 * this.ballGridW;
                  _loc9_.y = param3 * this.ballGridH - 30;
            }
            if(GamePlayer.getInstance().galaxyID == _loc6_.GalaxyId)
            {
               FarmLandMananger.instance.RenderMyFarmland(_loc6_.Level,param2,param3);
            }
            if(_loc8_)
            {
               this._currMapDatas.push(_loc8_);
               GalaxyMapAction.instance.curMapSprite.addChild(_loc8_);
               if(_loc9_)
               {
                  if(_loc6_.Type != GalaxyType.GT_2)
                  {
                     if(_loc6_.LoserFlag == 0)
                     {
                        _loc9_.setLoserFlag(true);
                     }
                     else
                     {
                        _loc9_.setLoserFlag(false);
                     }
                  }
                  if(_loc6_.FightFlag == 1)
                  {
                     _loc9_.setFightFlag(true);
                  }
                  else
                  {
                     _loc9_.setFightFlag(false);
                  }
                  if(_loc6_.Camp == 0)
                  {
                     _loc9_.updateText(_loc6_,0);
                  }
                  else if(_loc6_.Camp == 1)
                  {
                     _loc9_.updateText(_loc6_,1);
                  }
                  else
                  {
                     _loc9_.updateText(_loc6_);
                  }
                  starInfoMap.Put(_loc6_.UserId,_loc9_);
                  GalaxyMapAction.instance.curMapSprite.addChild(_loc9_);
                  if(_loc6_.Type >= GalaxyType.GT_4)
                  {
                     this.UserIdList.push(_loc6_.UserId);
                     this.UserNameList.push(_loc6_.UserName);
                  }
                  if(param4 > 0)
                  {
                     GameKernel.getPlayerFacebookInfo(param4,this.getPlayerFacebookInfoCallback,param5);
                  }
               }
               if(_loc9_)
               {
                  _loc10_ = HoldGalaxyManager.instance.holdGalaxys;
                  _loc11_ = 0;
                  while(_loc11_ < _loc10_.length)
                  {
                     _loc12_ = _loc10_[_loc11_];
                     if(_loc12_.GalaxyMapId == _loc6_.GalaxyMapId && _loc12_.GalaxyId == _loc6_.GalaxyId && GamePlayer.getInstance().galaxyID != _loc6_.GalaxyId)
                     {
                        _loc9_.updateFlag(1);
                     }
                     _loc11_++;
                  }
               }
            }
         }
         else if(param4 > 0)
         {
            _loc13_ = GalaxyMapAction.instance.curMapSprite.getChildByName("ball" + param3 + "" + param2);
            if(_loc13_ != null)
            {
               param2 = int(this._currMapDatas.indexOf(_loc13_));
               if(param2 >= 0)
               {
                  this._currMapDatas.splice(param2,1);
               }
               GalaxyMapAction.instance.curMapSprite.removeChild(_loc13_);
            }
            if(starInfoMap.ContainsKey(param4))
            {
               _loc14_ = starInfoMap.Get(param4);
               GalaxyMapAction.instance.curMapSprite.removeChild(_loc14_);
               starInfoMap.Remove(_loc14_);
            }
         }
      }
      
      public function printCacheStar(param1:int, param2:int) : void
      {
         var _loc5_:int = 0;
         this.freshX = param1;
         this.freshY = param2;
         this.clearCurMap();
         this._cacheMapDatas.splice(0);
         FarmLandMananger.instance.RemoverFarmland(true);
         var _loc3_:int = 0;
         this.UserIdList.splice(0);
         this.UserNameList.splice(0);
         var _loc4_:int = 0;
         while(_loc4_ < AREAGRIDX * 3)
         {
            _loc5_ = 0;
            while(_loc5_ < AREAGRIDY * 3)
            {
               _loc3_ = param2 + _loc5_ + (param1 + _loc4_) * MAX_MAPAREAGRID;
               if(param2 + _loc5_ >= 0 && param2 + _loc5_ < MAX_MAPAREAGRID && param1 + _loc4_ >= 0)
               {
                  this._cacheMapDatas.push(this._miniMapDatas[_loc3_]);
                  this.PrintStar(_loc3_,_loc4_,_loc5_);
               }
               else
               {
                  this._cacheMapDatas.push(null);
               }
               _loc5_++;
            }
            _loc4_++;
         }
         GameKernel.getPlayerFacebookInfoArray(this.UserIdList,this.FaceBookUserNameCallBack,this.UserNameList);
      }
      
      private function FaceBookUserNameCallBack(param1:Array) : void
      {
         var _loc2_:FacebookUserInfo = null;
         if(param1 == null)
         {
            return;
         }
         for each(_loc2_ in param1)
         {
            if(starInfoMap.ContainsKey(_loc2_.uid))
            {
               (starInfoMap.Get(_loc2_.uid) as StarInfo).updateUserName(_loc2_.first_name);
            }
         }
      }
      
      private function getPlayerFacebookInfoCallback(param1:FacebookUserInfo) : void
      {
         if(param1 != null && starInfoMap.ContainsKey(param1.uid))
         {
            (starInfoMap.Get(param1.uid) as StarInfo).updateUserName(param1.first_name);
         }
      }
      
      public function getFirstCacheDataIndex() : GStar
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._cacheMapDatas.length)
         {
            if(this._cacheMapDatas[_loc1_] != null)
            {
               return this._cacheMapDatas[_loc1_] as GStar;
            }
            _loc1_++;
         }
         return null;
      }
      
      private function clearCurMap() : void
      {
         var i:int = 0;
         while(i < this._currMapDatas.length)
         {
            if(GalaxyMapAction.instance.curMapSprite.getChildByName("StarInfo"))
            {
               GalaxyMapAction.instance.curMapSprite.removeChild(GalaxyMapAction.instance.curMapSprite.getChildByName("StarInfo"));
            }
            if(Bitmap(this._currMapDatas[i]).parent)
            {
               GalaxyMapAction.instance.curMapSprite.removeChild(this._currMapDatas[i]);
            }
            this._currMapDatas[i] = null;
            i++;
         }
         this._currMapDatas.splice(0);
         try
         {
            new LocalConnection().connect("foo");
            new LocalConnection().connect("foo");
         }
         catch(e:*)
         {
         }
      }
      
      public function sendRequestGalaxy() : void
      {
         var _loc1_:int = GamePlayer.getInstance().galaxyID;
         var _loc2_:int = GamePlayer.getInstance().galaxyMapID;
         if(GalaxyManager.instance.enterStar)
         {
            _loc2_ = GalaxyManager.instance.enterStar.GalaxyMapId;
            _loc1_ = GalaxyManager.instance.enterStar.GalaxyId;
         }
         this.LastRequestGalaxyId = _loc1_;
         var _loc3_:MSG_REQUEST_GALAXY = new MSG_REQUEST_GALAXY();
         _loc3_.GalaxyMapId = _loc2_;
         _loc3_.GalaxyId = _loc1_;
         _loc3_.Guid = GamePlayer.getInstance().Guid;
         _loc3_.SeqId = GamePlayer.getInstance().seqID++;
         NetManager.Instance().sendObject(_loc3_);
      }
      
      public function requestGalaxy(param1:int, param2:int) : void
      {
         var _loc8_:int = 0;
         var _loc3_:int = Math.floor(param2 % GalaxyManager.MAX_MAPAREAGRID / GalaxyManager.AREAGRIDY) + Math.floor(Math.floor(param2 / GalaxyManager.MAX_MAPAREAGRID) / GalaxyManager.AREAGRIDX) * 10;
         var _loc4_:int = _loc3_ - 10 - 1;
         var _loc5_:Array = new Array();
         var _loc6_:int = 0;
         while(_loc6_ < 4)
         {
            _loc8_ = 0;
            while(_loc8_ < 4)
            {
               _loc3_ = _loc4_ + _loc8_ + _loc6_ * 10;
               if(_loc3_ > -1 && _loc3_ < GalaxyManager.MAX_MAPAREAS)
               {
                  _loc5_.push(_loc3_);
               }
               _loc8_++;
            }
            _loc6_++;
         }
         GalaxyManager.RequestMapsDatas(_loc5_);
         this.LastRequestGalaxyId = param2;
         var _loc7_:MSG_REQUEST_GALAXY = new MSG_REQUEST_GALAXY();
         _loc7_.GalaxyMapId = param1;
         _loc7_.GalaxyId = param2;
         _loc7_.Guid = GamePlayer.getInstance().Guid;
         _loc7_.SeqId = GamePlayer.getInstance().seqID++;
         NetManager.Instance().sendObject(_loc7_);
      }
      
      public function gotoGalaxyMap() : void
      {
         var _loc1_:int = GalaxyMapAction.instance.curStar.GalaxyId;
         var _loc2_:int = GalaxyManager.getStarCoordinate(_loc1_).x - 15;
         var _loc3_:int = GalaxyManager.getStarCoordinate(_loc1_).y - 15;
         GalaxyManager.instance.printCacheStar(_loc2_,_loc3_);
      }
      
      public function goHome() : void
      {
         var _loc1_:int = GamePlayer.getInstance().galaxyID;
         var _loc2_:int = GalaxyManager.getStarCoordinate(_loc1_).x;
         var _loc3_:int = GalaxyManager.getStarCoordinate(_loc1_).y;
         GotoGalaxyUI.instance.GotoGalaxy(_loc2_,_loc3_);
      }
      
      public function getBallImg(param1:uint, param2:int = -1) : Bitmap
      {
         var _loc3_:int = int(param1);
         if(param2 >= 10)
         {
            _loc3_ = 10 + 3 * (param2 - 10) + (param1 - 4);
         }
         var _loc4_:Bitmap = new Bitmap(GameKernel.getTextureInstance("Star" + _loc3_));
         if(_loc4_ == null)
         {
            _loc4_ = new Bitmap(GameKernel.getTextureInstance("Star" + param1));
         }
         return _loc4_;
      }
      
      public function isTheTypeStar(param1:int, param2:int) : Boolean
      {
         if(this._miniMapDatas[param1])
         {
            return (this._miniMapDatas[param1] as GStar).Type == param2;
         }
         throw new Error("3:未知星球 " + param1);
      }
      
      public function get miniMapDatas() : Array
      {
         var _loc1_:Array = new Array();
         return this._miniMapDatas;
      }
      
      public function pushData(param1:GStar) : void
      {
         if(!param1)
         {
            return;
         }
         this._miniMapDatas[param1.GalaxyId] = param1;
      }
      
      public function getData(param1:int) : GStar
      {
         var _loc2_:GStar = null;
         if(this._miniMapDatas[param1])
         {
            _loc2_ = new GStar();
            return this._miniMapDatas[param1] as GStar;
         }
         return null;
      }
      
      public function getCacheData(param1:int) : GStar
      {
         var _loc2_:GStar = null;
         if(this._cacheMapDatas[param1])
         {
            return this._cacheMapDatas[param1] as GStar;
         }
         return null;
      }
      
      public function gotoGalaxyById(param1:int) : void
      {
         FightManager.instance.CleanFight();
         GalaxyManager.instance.requestGalaxy(GamePlayer.getInstance().galaxyMapID,param1);
         GalaxyMapAction.instance.curStar = GalaxyManager.instance.getData(param1);
         GameKernel.currentMapModelIndex = 1;
         GameKernel.currentGameStage = GameStageEnum.GAME_STAGE_OUTSIDE;
         OutSideGalaxiasAction.getInstance().Init();
         GameScreenManager.getInstance().ShowScreen(OutSideGalaxiasAction.getInstance());
      }
      
      public function MoveHome(param1:int, param2:int) : void
      {
         var _loc3_:GStar = null;
         var _loc4_:GStar = null;
         if(this._miniMapDatas[param1])
         {
            _loc3_ = this._miniMapDatas[param1] as GStar;
            _loc3_.GalaxyId = param2;
            this._miniMapDatas[param2] = _loc3_;
            _loc4_ = new GStar(param1,GalaxyType.GT_1);
            this._miniMapDatas[param1] = _loc4_;
            if(this._enterStar.GalaxyId == param1)
            {
               this._enterStar = _loc3_;
            }
            GalaxyMapAction.instance.curStar = this._enterStar;
         }
      }
      
      public function LeaveGalaxy() : void
      {
         var _loc1_:MSG_REQUEST_LEAVEGALAXY = new MSG_REQUEST_LEAVEGALAXY();
         _loc1_.GalaxyId = GalaxyMapAction.instance.curStar.GalaxyId;
         _loc1_.GalaxyId = GalaxyMapAction.instance.curStar.GalaxyMapId;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         NetManager.Instance().sendObject(_loc1_);
      }
   }
}

import com.star.frameworks.managers.StringManager;
import flash.display.Bitmap;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.text.TextField;
import logic.entry.GStar;
import logic.entry.GalaxyType;
import logic.game.GameKernel;

class HHH
{
   
   public function HHH()
   {
      super();
   }
}

class StarInfo extends Sprite
{
   
   private var movie:MovieClip;
   
   private var txtCamp:TextField;
   
   private var txtName:TextField;
   
   private var txtCampLevel:TextField;
   
   private var loserFlag:Bitmap = new Bitmap();
   
   private var flag:Bitmap = new Bitmap();
   
   private var fightFlag:Bitmap = new Bitmap();
   
   private var CampFlag:Bitmap = new Bitmap();
   
   public function StarInfo()
   {
      super();
      this.movie = GameKernel.getMovieClipInstance("StarnamePop");
      this.movie.x = GalaxyManager.GRIDPIXELX * 0.5;
      this.txtCamp = this.movie.tf_corpsname as TextField;
      this.txtName = this.movie.tf_player as TextField;
      this.txtCampLevel = this.movie.tf_corpsgrade as TextField;
      this.addChild(this.movie);
      this.name = "StarInfo";
      this.CampFlag.x = this.CampFlag.y = 5;
      this.movie.mc_base.addChild(this.CampFlag);
      this.loserFlag.y = 30;
      addChild(this.loserFlag);
      this.flag.x = 45;
      this.flag.y = 80;
      addChild(this.flag);
      this.fightFlag.y = 80;
      addChild(this.fightFlag);
   }
   
   public function updateUserName(param1:String) : void
   {
      this.txtName.text = param1;
   }
   
   public function updateText(param1:GStar, param2:int = -1) : void
   {
      if(param1.ConsortiaName.length > 0)
      {
         if(param1.Camp == 0)
         {
            this.txtCamp.textColor = 15569188;
            this.txtName.textColor = 15569188;
            this.txtCampLevel.textColor = 15569188;
         }
         else if(param1.Camp == 1)
         {
            this.txtCamp.textColor = 56123;
            this.txtName.textColor = 56123;
            this.txtCampLevel.textColor = 56123;
         }
         else
         {
            this.txtCamp.textColor = 7246266;
            this.txtName.textColor = 7246266;
            this.txtCampLevel.textColor = 7246266;
         }
         if(param1.FightFlag == 2)
         {
            this.txtName.textColor = 40191;
         }
         this.txtCamp.text = "[" + param1.ConsortiaName + "]";
         this.txtCampLevel.text = param1.ConsortiaLevelId + 1 + "";
         this.CampFlag.bitmapData = GameKernel.getTextureInstance("corp_" + param1.ConsortiaHeadId);
         this.CampFlag.scaleX = this.CampFlag.scaleY = 0.5;
      }
      else
      {
         this.txtCamp.textColor = 7246266;
         this.txtName.textColor = 7246266;
         this.txtCampLevel.textColor = 7246266;
         this.txtCamp.text = "";
         this.txtCampLevel.text = "";
         if(param1.Type == GalaxyType.GT_3)
         {
            this.txtName.textColor = 11811556;
         }
      }
      if(param1.Type == GalaxyType.GT_3)
      {
         this.txtName.text = StringManager.getInstance().getMessageString("BattleTXT09");
      }
      else if(param1.Type == GalaxyType.GT_2)
      {
         this.txtName.text = StringManager.getInstance().getMessageString("Boss46");
      }
      else
      {
         this.txtName.text = param1.UserName;
      }
      this.updateFlag(param2);
   }
   
   public function setLoserFlag(param1:Boolean) : void
   {
      if(param1)
      {
         this.loserFlag.bitmapData = GameKernel.getTextureInstance("Loser");
      }
      else
      {
         this.loserFlag.bitmapData = null;
      }
   }
   
   public function setFightFlag(param1:Boolean) : void
   {
      if(param1)
      {
         this.fightFlag.bitmapData = GameKernel.getTextureInstance("Battleing");
      }
      else
      {
         this.fightFlag.bitmapData = null;
      }
   }
   
   public function updateFlag(param1:int) : void
   {
      switch(param1)
      {
         case FlagType.F_SELF:
            this.flag.bitmapData = GameKernel.getTextureInstance("Homestead");
            break;
         case FlagType.F_FIGHT:
            this.flag.bitmapData = GameKernel.getTextureInstance("Battleing");
      }
   }
}

class FlagType
{
   
   public static const F_SELF:int = 0;
   
   public static const F_CAMP:int = 1;
   
   public static const F_FIGHT:int = 2;
   
   public function FlagType()
   {
      super();
   }
}
