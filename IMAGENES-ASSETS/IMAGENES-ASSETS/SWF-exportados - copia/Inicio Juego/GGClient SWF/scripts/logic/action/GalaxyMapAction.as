package logic.action
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.managers.ResManager;
   import com.star.frameworks.managers.StringManager;
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.text.TextField;
   import logic.entry.AbstraceAction;
   import logic.entry.GStar;
   import logic.entry.GalaxyType;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.HButtonType;
   import logic.entry.MObject;
   import logic.entry.ScienceSystem;
   import logic.entry.test.Dirt;
   import logic.game.GameKernel;
   import logic.manager.FarmLandMananger;
   import logic.manager.GalaxyManager;
   import logic.ui.AlignManager;
   import logic.ui.ChangeServerUI;
   import logic.ui.ChatUI;
   import logic.ui.GameSystemUI;
   import logic.ui.GemcheckPopUI;
   import logic.ui.GotoGalaxyUI;
   import logic.ui.MallBuyModulesPopup;
   import logic.ui.MessagePopup;
   import logic.ui.TransforingUI;
   import logic.widget.ConstructionOperationWidget;
   import logic.widget.OperationEnum;
   import net.base.NetManager;
   import net.msg.galaxyMap.MSG_REQUEST_MOVEHOME;
   
   public class GalaxyMapAction extends AbstraceAction
   {
      
      public static const gridH:int = 3;
      
      public static const gridW:int = 3;
      
      public static const ballGridW:int = 80;
      
      public static const ballGridH:int = 80;
      
      private static var _instance:GalaxyMapAction = null;
      
      private static var TipText:TextField = new TextField();
      
      private var _bg:Container;
      
      private var _dirtSprite:Sprite;
      
      private var _dirtArr:Array;
      
      private var _galaxyMapSprite:Container;
      
      private var _miniMapSprite:Container;
      
      private var _curMapSprite:Sprite;
      
      private var _curMapRect:Sprite;
      
      private var _tempShowSprite:Sprite;
      
      private var _showSprite:Sprite;
      
      private var _cacheSprite:Sprite;
      
      private var _userSprite:Sprite;
      
      private var mapButtonStatus:int = 0;
      
      private var McMapButton:MovieClip;
      
      public var galaxyMapBgWidth:Number = 0;
      
      public var galayMapBgHeight:Number = 0;
      
      private var moveX:int = 0;
      
      private var moveY:int = 0;
      
      private var startGridX:uint;
      
      private var startGridY:uint;
      
      private var _curStar:GStar;
      
      private var _lastTimeStar:GStar;
      
      private var lastPosX:int;
      
      private var lastPosY:int;
      
      private var tempBitmap:DisplayObject;
      
      private var btn_map:HButton;
      
      private var McMapButtonPoint:Point;
      
      private var McFacebookUIPoint:Point;
      
      private var ChangeServerBtn:HButton;
      
      private var ServerName:String = "";
      
      public function GalaxyMapAction()
      {
         var _loc3_:XML = null;
         var _loc4_:Dirt = null;
         this._dirtArr = new Array();
         super();
         this.ActionName = "Map_GalaxyMap_Action";
         this._bg = new Container();
         AlignManager.GetInstance().SetAlign(this._bg,"none");
         this._galaxyMapSprite = new Container("GalaxyMap");
         this._galaxyMapSprite.addChild(this._bg);
         this._dirtSprite = new Sprite();
         this._bg.addEventListener(Event.ADDED_TO_STAGE,this.OnAddToStage);
         var _loc2_:XML = ResManager.getInstance().getXml(ResManager.GAMERES,"GalaxyMapDirt");
         for each(_loc3_ in _loc2_.*)
         {
            _loc4_ = new Dirt(_loc3_.@Name);
            _loc4_.moveNum = Number(Number(_loc3_.@Type));
            _loc4_.x = _loc3_.@X * ballGridW;
            _loc4_.y = _loc3_.@Y * ballGridH;
            this._dirtArr.push(_loc4_);
            this._dirtSprite.mouseEnabled = this._dirtSprite.mouseChildren = false;
            this._dirtSprite.addChild(_loc4_);
         }
         this._galaxyMapSprite.addChild(this._dirtSprite);
      }
      
      public static function get instance() : GalaxyMapAction
      {
         if(_instance == null)
         {
            _instance = new GalaxyMapAction();
         }
         return _instance;
      }
      
      private function OnAddToStage(param1:Event) : void
      {
         this._bg.removeEventListener(Event.ADDED_TO_STAGE,this.OnAddToStage);
         this._bg.width = this._bg.stage.stageWidth;
         this._bg.height = this._bg.stage.stageHeight;
      }
      
      public function getGalaxyMapBg() : Container
      {
         return this._bg;
      }
      
      public function cacheGalaxyMapBgWH() : void
      {
         if(this.galaxyMapBgWidth == 0 && this.galayMapBgHeight == 0)
         {
            this.galaxyMapBgWidth = Number(Number(this.getGalaxyMapBg().BackgroundWH.x));
            this.galayMapBgHeight = Number(Number(this.getGalaxyMapBg().BackgroundWH.y));
         }
      }
      
      override public function Init() : void
      {
         this._curMapSprite = new Sprite();
         this._curMapSprite.name = "curMap";
         this._curMapSprite.graphics.beginFill(0,0.1);
         this._curMapSprite.graphics.drawRect(0,0,ballGridW * GalaxyManager.AREAGRID * 2,ballGridH * GalaxyManager.AREAGRID * 2);
         this._curMapSprite.graphics.endFill();
         this._curMapSprite.graphics.lineStyle(1,16711935,0.1);
         var _loc1_:int = 0;
         while(_loc1_ <= GalaxyManager.AREAGRIDY * 3)
         {
            this._curMapSprite.graphics.moveTo(0,_loc1_ * ballGridH);
            this._curMapSprite.graphics.lineTo(ballGridW * GalaxyManager.AREAGRIDY * 3,_loc1_ * ballGridH);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ <= GalaxyManager.AREAGRIDX * 3)
         {
            this._curMapSprite.graphics.moveTo(_loc1_ * ballGridW,0);
            this._curMapSprite.graphics.lineTo(_loc1_ * ballGridW,ballGridH * GalaxyManager.AREAGRIDX * 3);
            _loc1_++;
         }
         this._curMapSprite.addEventListener(MouseEvent.CLICK,this.onClick,false,0,true);
         this._curMapSprite.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartMove,false,0,true);
         this._curMapSprite.addEventListener(MouseEvent.MOUSE_UP,this.onStopMove,false,0,true);
         this._curMapSprite.addEventListener(MouseEvent.MOUSE_MOVE,this.MapSpriteMouseMove);
         this._curMapSprite.x = (0 - ballGridW) * 10;
         this._curMapSprite.y = (0 - ballGridH) * 10;
         this._galaxyMapSprite.addChild(this._curMapSprite);
         this._curMapRect = new Sprite();
         this._curMapRect.graphics.lineStyle(1,65535,1);
         this._curMapRect.graphics.drawRect(0,0,ballGridW * 10,ballGridH * 10);
         this._miniMapSprite = new Container("miniMap");
         var _loc2_:Graphics = this._miniMapSprite.graphics;
         _loc2_.lineStyle(1,16777215,0.5);
         _loc1_ = 0;
         while(_loc1_ <= GalaxyManager.MAX_MAPAREAGRID)
         {
            if(_loc1_ % GalaxyManager.AREAGRIDY == 0)
            {
               _loc2_.lineStyle(2,16711680,0.5);
            }
            else
            {
               _loc2_.lineStyle(1,16777215,0.3);
            }
            _loc2_.moveTo(0,_loc1_ * gridH);
            _loc2_.lineTo(gridW * GalaxyManager.MAX_MAPAREAGRID_X,_loc1_ * gridH);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ <= GalaxyManager.MAX_MAPAREAGRID_X)
         {
            if(_loc1_ % GalaxyManager.AREAGRIDX == 0)
            {
               _loc2_.lineStyle(2,16711680,0.5);
            }
            else
            {
               _loc2_.lineStyle(1,16777215,0.3);
            }
            _loc2_.moveTo(_loc1_ * gridW,0);
            _loc2_.lineTo(_loc1_ * gridW,gridH * GalaxyManager.MAX_MAPAREAGRID);
            _loc1_++;
         }
         this._miniMapSprite.x = 0;
         this._miniMapSprite.y = 60;
         this._cacheSprite = new Sprite();
         this._userSprite = new Sprite();
         this._tempShowSprite = new Sprite();
         this._tempShowSprite.graphics.lineStyle(1,65535,1);
         this._tempShowSprite.graphics.drawRect(0,0,GalaxyManager.AREAGRIDX * 3 * gridW,GalaxyManager.AREAGRIDY * 3 * gridH);
         this._miniMapSprite.addChild(this._tempShowSprite);
         this._showSprite = new Sprite();
         this._showSprite.name = "ShowSprite";
         this._showSprite.graphics.lineStyle(1,16776960,1);
         this._showSprite.graphics.beginFill(16777215,0.3);
         this._showSprite.graphics.drawRect(0,0,GalaxyManager.AREAGRIDX * gridW,GalaxyManager.AREAGRIDY * gridH);
         this._showSprite.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartMove,false,0,true);
         this._showSprite.addEventListener(MouseEvent.MOUSE_UP,this.onStopMove,false,0,true);
         this._miniMapSprite.addChild(this._showSprite);
         this.IniMapButton();
      }
      
      override public function getUI() : Container
      {
         return this._galaxyMapSprite;
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         FarmLandMananger.instance.RemoverFarmland(false);
         if(param1.target.name != "curMap")
         {
            return;
         }
         if(this.lastPosX != param1.target.x || this.lastPosY != param1.target.y)
         {
            return;
         }
         var _loc2_:int = Math.floor(param1.localX / ballGridW);
         var _loc3_:int = Math.floor(param1.localY / ballGridH);
         var _loc4_:int = _loc3_ + _loc2_ * GalaxyManager.AREAGRIDY * 3;
         if(GalaxyManager.instance.getCacheData(_loc4_) && GalaxyManager.instance.getCacheData(_loc4_).Type != GalaxyType.GT_0)
         {
            this._curStar = GalaxyManager.instance.getCacheData(_loc4_);
            if(this._curStar.GalaxyId != GamePlayer.getInstance().galaxyID && (this._curStar.Type == GalaxyType.GT_4 || this._curStar.Type == GalaxyType.GT_5 || this._curStar.Type == GalaxyType.GT_6))
            {
               FarmLandMananger.instance.RenderFarmland(_loc2_,_loc3_,this._curStar,false);
            }
            if(this.curStar.Type != GalaxyType.GT_1)
            {
               ChatAction.getInstance().sendChatUserInfoMessage(this.curStar.GalaxyId);
            }
            else if(this.MapButtonStatus == 1)
            {
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("StarText11"),2,this.RequestMoveHome);
            }
         }
      }
      
      private function RequestMoveHome() : void
      {
         var _loc2_:MSG_REQUEST_MOVEHOME = null;
         var _loc1_:int = 0;
         while(_loc1_ < ScienceSystem.getinstance().Packarr.length)
         {
            if(ScienceSystem.getinstance().Packarr[_loc1_].PropsId == 901)
            {
               _loc2_ = new MSG_REQUEST_MOVEHOME();
               _loc2_.ToGalaxyId = int(int(this.curStar.GalaxyMapId));
               _loc2_.ToGalaxyId = int(int(this.curStar.GalaxyId));
               _loc2_.SeqId = int(int(GamePlayer.getInstance().seqID++));
               _loc2_.Guid = int(int(GamePlayer.getInstance().Guid));
               NetManager.Instance().sendObject(_loc2_);
               return;
            }
            _loc1_++;
         }
         ConstructionOperationWidget.currenCmd = OperationEnum.OPERATION_TYPE_SPEED;
         MallBuyModulesPopup.getInstance().Init();
         MallBuyModulesPopup.getInstance().setToolPropID(901);
         MallBuyModulesPopup.getInstance().setMessage(StringManager.getInstance().getMessageString("StarText12"));
         MallBuyModulesPopup.getInstance().setShowUserView(1);
         MallBuyModulesPopup.getInstance().Show();
      }
      
      private function onStartMove(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Dirt = null;
         GameKernel.renderManager.getUI().removeComponent(GemcheckPopUI.getInstance()._mc);
         ChatUI.getInstance().setSpecialTipState(false);
         if(param1.target.name == "ShowSprite")
         {
            param1.target.startDrag();
         }
         if(param1.target.name == "curMap")
         {
            param1.target.startDrag();
            this.lastPosX = int(int(param1.target.x));
            this.lastPosY = int(int(param1.target.y));
            _loc2_ = 0;
            while(_loc2_ < this._dirtArr.length)
            {
               _loc3_ = this._dirtArr[_loc2_];
               _loc3_.BeginDrag();
               _loc2_++;
            }
            this._curMapSprite.addEventListener(Event.ENTER_FRAME,this.onFrame,false,0,true);
            this._curMapSprite.addEventListener(MouseEvent.MOUSE_OUT,this.MoveOut,false,0,true);
         }
      }
      
      private function MoveOut(param1:Event) : void
      {
         this._curMapSprite.stopDrag();
         this._curMapSprite.removeEventListener(MouseEvent.MOUSE_OUT,this.MoveOut);
      }
      
      private function onStopMove(param1:MouseEvent) : void
      {
         var _loc8_:Dirt = null;
         if(param1.target.name != "curMap")
         {
            return;
         }
         param1.target.stopDrag();
         var _loc2_:int = 0;
         while(_loc2_ < this._dirtArr.length)
         {
            _loc8_ = this._dirtArr[_loc2_];
            _loc8_.EndDrag();
            _loc2_++;
         }
         ExternalInterface.call("console.log","[#] PASSING " + param1.target.name);
         this._curMapSprite.removeEventListener(Event.ENTER_FRAME,this.onFrame);
         var _loc3_:int = Math.floor((this._curMapRect.x - param1.target.x) / ballGridW);
         var _loc4_:int = Math.floor((this._curMapRect.y - param1.target.y) / ballGridH);
         var _loc5_:int = _loc4_ + _loc3_ * GalaxyManager.AREAGRIDY * 3;
         var _loc6_:int = this.searchCacheData(_loc3_,_loc4_);
         ExternalInterface.call("console.log","[#] Loc3 = " + _loc3_ + ", Loc4 = " + _loc4_);
         ExternalInterface.call("console.log","[#] Loc5 = " + _loc5_ + ", Loc6 = " + _loc6_);
         var _loc7_:int = int(int(_loc6_ / GalaxyManager.MAX_MAPAREAGRID) / 60) * 7 + int(_loc6_ % (GalaxyManager.MAX_MAPAREAGRID / 60));
         GalaxyMapAction.instance.SetLocationId(_loc7_);
         if(_loc6_ != -1)
         {
            _loc4_ = _loc6_ % (GalaxyManager.MAX_MAPAREAGRID - 10);
            _loc3_ = Math.floor(_loc6_ / GalaxyManager.MAX_MAPAREAGRID) - 10;
            this.requestAreas(_loc3_,_loc4_);
            GalaxyManager.instance.printCacheStar(_loc3_,_loc4_);
            this._tempShowSprite.x = _loc3_ * gridW;
            this._tempShowSprite.y = _loc4_ * gridH;
            this._showSprite.x = _loc3_ * gridW + gridW * 10;
            this._showSprite.y = _loc4_ * gridH + gridH * 10;
         }
         if((param1.target.x - (0 - ballGridW) * 10) % ballGridW < 0)
         {
            param1.target.x = ((0 - ballGridW) * 10 + (param1.target.x - (0 - ballGridW) * 10)) % ballGridW;
         }
         else if((param1.target.x - (0 - ballGridW) * 10) % ballGridW > 0)
         {
            param1.target.x = ((0 - ballGridW) * 10 - (ballGridW - (param1.target.x - (0 - ballGridW) * 10))) % ballGridW;
         }
         if((param1.target.y - (0 - ballGridH) * 10) % ballGridH < 0)
         {
            param1.target.y = ((0 - ballGridH) * 10 + (param1.target.y - (0 - ballGridH) * 10)) % ballGridH;
         }
         else if((param1.target.y - (0 - ballGridH) * 10) % ballGridH > 0)
         {
            param1.target.y = ((0 - ballGridH) * 10 - (ballGridH - (param1.target.y - (0 - ballGridH) * 10))) % ballGridH;
         }
      }
      
      private function onFrame(param1:Event) : void
      {
         var _loc3_:Dirt = null;
         if(this.lastPosX == this._curMapSprite.x && this.lastPosY == this._curMapSprite.y)
         {
            return;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this._dirtArr.length)
         {
            _loc3_ = this._dirtArr[_loc2_];
            _loc3_.Draging(this._curMapSprite.x + 807,this._curMapSprite.y + 824);
            _loc2_++;
         }
      }
      
      private function searchCacheData(param1:int, param2:int) : int
      {
         var _loc9_:int = 0;
         var _loc3_:int = -1;
         var _loc4_:Boolean = false;
         var _loc5_:* = -1;
         var _loc6_:* = -1;
         var _loc7_:int = -1;
         var _loc8_:int = 0;
         while(_loc8_ < 3)
         {
            _loc9_ = 0;
            while(_loc9_ < 3)
            {
               _loc3_ = param2 - _loc9_ + (param1 - _loc8_) * GalaxyManager.AREAGRIDY * 3;
               if(GalaxyManager.instance.getCacheData(_loc3_))
               {
                  _loc4_ = true;
                  _loc7_ = GalaxyManager.instance.getCacheData(_loc3_).GalaxyId;
                  _loc5_ = _loc8_;
                  _loc6_ = _loc9_;
                  break;
               }
               _loc9_++;
            }
            if(_loc4_)
            {
               break;
            }
            _loc8_++;
         }
         if(_loc4_)
         {
            return int(_loc7_ + _loc5_ * GalaxyManager.MAX_MAPAREAGRID + _loc6_);
         }
         _loc8_ = 0;
         while(_loc8_ < 3)
         {
            _loc9_ = 0;
            while(_loc9_ < 3)
            {
               _loc3_ = param2 + _loc9_ + (param1 + _loc8_) * GalaxyManager.AREAGRIDY * 3;
               if(GalaxyManager.instance.getCacheData(_loc3_))
               {
                  _loc4_ = true;
                  _loc7_ = GalaxyManager.instance.getCacheData(_loc3_).GalaxyId;
                  _loc5_ = _loc8_;
                  _loc6_ = _loc9_;
                  break;
               }
               _loc9_++;
            }
            if(_loc4_)
            {
               break;
            }
            _loc8_++;
         }
         if(_loc4_)
         {
            return int(_loc7_ - _loc5_ * GalaxyManager.MAX_MAPAREAGRID - _loc6_);
         }
         return -1;
      }
      
      public function requestAreas(param1:int, param2:int) : void
      {
         var _loc4_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param2 < 0)
         {
            param2 = 0;
         }
         var _loc3_:int = GalaxyManager.getStarArea(param2 + param1 * GalaxyManager.MAX_MAPAREAGRID);
         var _loc5_:Array = new Array();
         var _loc6_:int = 0;
         while(_loc6_ < 4)
         {
            _loc8_ = 0;
            while(_loc8_ < 4)
            {
               _loc4_ = _loc3_ + _loc8_ + _loc6_ * GalaxyManager.MAX_MAPAREA;
               if(_loc4_ > -1 && _loc4_ < GalaxyManager.MAX_MAPAREAS)
               {
                  _loc5_.push(_loc4_);
               }
               _loc8_++;
            }
            _loc6_++;
         }
         var _loc7_:int = 0;
         while(_loc7_ < _loc5_.length)
         {
            _loc9_ = int(_loc5_[_loc7_]);
            _loc10_ = _loc9_ % (GalaxyManager.MAX_MAPAREA * GalaxyManager.AREAGRIDY + Math.floor(_loc9_ / GalaxyManager.MAX_MAPAREA) * GalaxyManager.MAX_MAPAREAGRID * GalaxyManager.AREAGRIDY);
            _loc6_ = 0;
            while(_loc6_ < GalaxyManager.AREAGRIDX)
            {
               _loc8_ = 0;
               while(_loc8_ < GalaxyManager.AREAGRIDY)
               {
                  if(GalaxyManager.instance.getData(_loc10_ + _loc8_ + GalaxyManager.MAX_MAPAREAGRID * _loc6_))
                  {
                     _loc5_[_loc7_] = -1;
                     break;
                  }
                  _loc8_++;
               }
               if(_loc5_[_loc7_] == -1)
               {
                  break;
               }
               _loc6_++;
            }
            if(GalaxyManager.instance.getData(_loc10_))
            {
               _loc5_[_loc7_] = -1;
            }
            _loc7_++;
         }
         GalaxyManager.RequestMapsDatas(_loc5_);
      }
      
      public function Release() : void
      {
         GameKernel.renderManager.getMap().removeComponent(this._galaxyMapSprite,true);
      }
      
      public function get miniMapSprite() : Container
      {
         return this._miniMapSprite;
      }
      
      public function get curMapSprite() : Sprite
      {
         return this._curMapSprite;
      }
      
      public function get cacheSprite() : Sprite
      {
         return this._cacheSprite;
      }
      
      public function get MapButtonStatus() : int
      {
         return this.mapButtonStatus;
      }
      
      public function get curStar() : GStar
      {
         return this._curStar;
      }
      
      public function set curStar(param1:GStar) : void
      {
         this._curStar = param1;
      }
      
      public function InitCurStar() : void
      {
         if(GamePlayer.getInstance().galaxyStar)
         {
            this._curStar = GamePlayer.getInstance().galaxyStar;
            GalaxyManager.instance.enterStar = GamePlayer.getInstance().galaxyStar;
         }
      }
      
      public function InitLastStar() : void
      {
         this._lastTimeStar = this._curStar;
      }
      
      public function resetCurStar() : void
      {
         if(this._curStar && this.lastTimeStar)
         {
            this._curStar = this.lastTimeStar;
         }
      }
      
      public function get lastTimeStar() : GStar
      {
         return this._lastTimeStar;
      }
      
      public function set lastTimeStar(param1:GStar) : void
      {
         this._lastTimeStar = param1;
      }
      
      private function MapSpriteMouseMove(param1:MouseEvent) : void
      {
         var _loc2_:int = Math.floor(param1.localX / ballGridW);
         var _loc3_:int = Math.floor(param1.localY / ballGridH);
         var _loc4_:int = _loc3_ + _loc2_ * GalaxyManager.AREAGRIDY * 3;
         var _loc5_:GStar = GalaxyManager.instance.getCacheData(_loc4_);
         if(_loc5_)
         {
            if(_loc5_.GalaxyId != GamePlayer.getInstance().galaxyID && (_loc5_.Type == GalaxyType.GT_4 || _loc5_.Type == GalaxyType.GT_5 || _loc5_.Type == GalaxyType.GT_6))
            {
               FarmLandMananger.instance.RenderFarmland(_loc2_,_loc3_,_loc5_,false);
            }
            if(_loc5_.Type == GalaxyType.GT_2 || _loc5_.Type == GalaxyType.GT_3 || _loc5_.Type == GalaxyType.GT_4 || _loc5_.Type == GalaxyType.GT_5 || _loc5_.Type == GalaxyType.GT_6)
            {
               this.tempBitmap = this._curMapSprite.getChildByName("ball" + _loc3_ + "" + _loc2_);
               if(this.tempBitmap)
               {
                  this.tempBitmap.filters = [new GlowFilter(65535)];
               }
            }
         }
         else
         {
            FarmLandMananger.instance.RemoverFarmland(false);
            if(this.tempBitmap)
            {
               this.tempBitmap.filters = null;
            }
            TipText.visible = false;
         }
      }
      
      public function GetStarInfo(param1:MouseEvent) : GStar
      {
         var _loc5_:GStar = null;
         var _loc2_:int = Math.floor(param1.localX / ballGridW);
         var _loc3_:int = Math.floor(param1.localY / ballGridH);
         var _loc4_:int = _loc3_ + _loc2_ * GalaxyManager.AREAGRIDY * 3;
         if(GalaxyManager.instance.getCacheData(_loc4_) && GalaxyManager.instance.getCacheData(_loc4_).Type != 0)
         {
            return GalaxyManager.instance.getCacheData(_loc4_);
         }
         return null;
      }
      
      private function ChangeServerBtnClick(param1:MouseEvent) : void
      {
         ChangeServerUI.getInstance().Show();
      }
      
      private function IniMapButton() : void
      {
         var _loc4_:DisplayObject = null;
         this.ChangeServerBtn = new HButton(GameKernel.getMovieClipInstance("ChangeServerBtn"));
         this.ChangeServerBtn.m_movie.x = 0;
         this.ChangeServerBtn.m_movie.y = 66;
         this.ChangeServerBtn.m_movie.addEventListener(MouseEvent.CLICK,this.ChangeServerBtnClick);
         this._galaxyMapSprite.addChild(this.ChangeServerBtn.m_movie);
         AlignManager.GetInstance().SetAlign(this.ChangeServerBtn.m_movie,"left");
         TextField(this.ChangeServerBtn.m_movie.tf_name).text = "";
         this.McMapButton = GameKernel.getMovieClipInstance("MinibtnMc");
         var _loc1_:Point = GameSystemUI.getInstance().Display.localToGlobal(new Point());
         this.McMapButton.x = 360;
         if(GameKernel.ForFB == 1)
         {
            this.McMapButton.y = GameKernel.fullRect.height - GameSystemUI.systemUIHeight + 15;
         }
         else
         {
            _loc4_ = GameKernel.gameLayout.getInstallUI("FacebookUiScene");
            this.McMapButton.y = GameKernel.fullRect.height - GameSystemUI.systemUIHeight - _loc4_.height + 15;
         }
         this.McMapButtonPoint = GameKernel.getInstance().GetBtngatherMcRect();
         this.McFacebookUIPoint = GameKernel.getInstance().GetFacebookUIRect();
         this._galaxyMapSprite.addChild(this.McMapButton);
         AlignManager.GetInstance().SetAlign(this.McMapButton,"right");
         var _loc2_:MovieClip = this.McMapButton.getChildByName("btn_galaxy") as MovieClip;
         var _loc3_:HButton = new HButton(_loc2_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("StarBtn0"));
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_galaxyClick);
         _loc2_ = this.McMapButton.getChildByName("btn_map") as MovieClip;
         this.btn_map = new HButton(_loc2_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("StarBtn1"));
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_mapClick);
         _loc2_ = this.McMapButton.getChildByName("btn_search") as MovieClip;
         _loc3_ = new HButton(_loc2_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("StarBtn2"));
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_searchClick);
      }
      
      public function RefreshServerName() : void
      {
         var _loc1_:int = GamePlayer.getInstance().GameServerId;
         this.ServerName = StringManager.getInstance().getMessageString("ServerName" + int(GamePlayer.getInstance().GameServerId + 1));
         TextField(this.ChangeServerBtn.m_movie.tf_name).text = this.ServerName;
      }
      
      public function SetLocationId(param1:int) : void
      {
         TextField(this.ChangeServerBtn.m_movie.tf_name).text = this.ServerName + "(" + int(param1 + 1) + ")";
      }
      
      public function setFullLocation(param1:Boolean) : void
      {
         var _loc2_:MObject = GameKernel.gameLayout.getInstallUI("BtngatherMc") as MObject;
         var _loc3_:DisplayObject = GameKernel.gameLayout.getInstallUI("FacebookUiScene");
         if(param1 || GameKernel.ForFB == 1)
         {
            this.McMapButton.y = _loc2_.stage.stageHeight - GameSystemUI.systemUIHeight + 15;
         }
         else
         {
            this.McMapButton.y = _loc2_.stage.stageHeight - _loc3_.height - GameSystemUI.systemUIHeight + 15;
         }
      }
      
      private function btn_galaxyClick(param1:Event) : void
      {
         TransforingUI.instance.Show();
      }
      
      private function btn_searchClick(param1:Event) : void
      {
         GotoGalaxyUI.instance.Init();
      }
      
      private function btn_mapClick(param1:Event) : void
      {
         this.mapButtonStatus = int(int((this.mapButtonStatus + 1) % 2));
         if(this.MapButtonStatus == 1)
         {
            this.btn_map.SetTip(StringManager.getInstance().getMessageString("StarBtn3"));
         }
         else
         {
            this.btn_map.SetTip(StringManager.getInstance().getMessageString("StarBtn1"));
         }
         GalaxyManager.instance.fresh();
      }
   }
}

