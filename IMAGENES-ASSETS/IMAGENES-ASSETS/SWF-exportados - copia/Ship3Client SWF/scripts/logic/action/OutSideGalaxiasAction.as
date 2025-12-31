package logic.action
{
   import com.star.frameworks.basic.Point3D;
   import com.star.frameworks.display.Container;
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.geom.PointKit;
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.HashSet;
   import com.star.frameworks.utils.MusicResHandler;
   import com.star.frameworks.utils.ObjectUtil;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.text.TextField;
   import gs.TweenLite;
   import logic.entry.AbstraceAction;
   import logic.entry.ConstructionState;
   import logic.entry.Equiment;
   import logic.entry.EquimentFactory;
   import logic.entry.EquimentTypeEnum;
   import logic.entry.FortificationStar;
   import logic.entry.GShipTeam;
   import logic.entry.GalaxyType;
   import logic.entry.GamePlaceType;
   import logic.entry.test.MovieClipDataBox;
   import logic.game.GameKernel;
   import logic.game.GameSetting;
   import logic.game.GameStateManager;
   import logic.manager.GalaxyManager;
   import logic.manager.GalaxyShipManager;
   import logic.manager.GameInterActiveManager;
   import logic.manager.InstanceManager;
   import logic.reader.FortificationStarReader;
   import logic.ui.AlignManager;
   import logic.ui.FleetUniteUI;
   import logic.ui.GymkhanaUI;
   import logic.ui.ShipInfoUI;
   import logic.ui.ShipPopUI;
   import logic.ui.UpgradeModulesPopUp;
   import logic.ui.tip.CustomTip;
   import logic.widget.ConstructionOperationWidget;
   import logic.widget.OperationEnum;
   import logic.widget.OutSideGalaxiasDragger;
   import logic.widget.OutSideGalaxiasUtil;
   import logic.widget.SingleLoader;
   import net.msg.ship.*;
   
   public class OutSideGalaxiasAction extends AbstraceAction
   {
      
      private static var instance:OutSideGalaxiasAction;
      
      public static var ctrlDown:Boolean = false;
      
      private static var filter:Array = [new GlowFilter(16776960,1)];
      
      private var _hv:int;
      
      private var _diff:int = 3;
      
      private var isConstructionModel:Boolean;
      
      private var isButtonClick:Boolean = false;
      
      private var _defendEquiment:Equiment;
      
      private var _attackRegions:Array;
      
      private var _gridObjList:Array;
      
      private var _constuction:ConstructionAction;
      
      private var _currentPX:int;
      
      private var _currentPY:int;
      
      private var _isLoad:Boolean;
      
      private var _preEquiment:Equiment;
      
      private var _tmpEquiment:Equiment;
      
      private var _outSideMap:Array;
      
      private var outSideBgWidth:Number = 0;
      
      private var outSideBgHeight:Number = 0;
      
      private var _curShip:GShipTeam;
      
      private var _uniteShip:GShipTeam;
      
      private var _uniteFlag:Boolean = false;
      
      private var outSideBg:Container;
      
      private var outSideContainer:Container;
      
      private var outSideDefendLayOut:Container;
      
      private var tempLine:Sprite = new Sprite();
      
      private var gridList:Array;
      
      public var textList:Array;
      
      private var gateArr:Array = new Array();
      
      private var spaceEquimentPosition:Point;
      
      private var firstX:Number = -1;
      
      private var firstY:Number = -1;
      
      private var firstPoint:PointKit;
      
      private var lastPoint:PointKit;
      
      private var selectShips:HashSet = new HashSet();
      
      private var _boutMc:MovieClip;
      
      private var _boutData:MovieClipDataBox;
      
      private var mouseShip:GShipTeam;
      
      private var lockCount:int = 0;
      
      public function OutSideGalaxiasAction()
      {
         super();
         if(instance != null)
         {
            throw new Error("SingleTon");
         }
         super.ActionName = "OutSideGalaxiasAction";
         this.isConstructionModel = false;
         this._isLoad = false;
         this._constuction = ConstructionAction.getInstance();
         this._constuction.SufFaceUI = this.outSideDefendLayOut;
      }
      
      public static function getInstance() : OutSideGalaxiasAction
      {
         if(instance == null)
         {
            instance = new OutSideGalaxiasAction();
         }
         return instance;
      }
      
      override public function getUI() : Container
      {
         return this.outSideContainer;
      }
      
      public function get GridList() : Array
      {
         return this.gridList;
      }
      
      public function get OutSideDefendContainer() : Container
      {
         return this.outSideDefendLayOut;
      }
      
      public function get IsConstuctionModel() : Boolean
      {
         return this.isConstructionModel;
      }
      
      public function set IsConstuctionModel(param1:Boolean) : void
      {
         this.isConstructionModel = param1;
      }
      
      public function get uniteFlag() : Boolean
      {
         return this._uniteFlag;
      }
      
      public function mouseDown(param1:MouseEvent) : void
      {
         var _loc2_:GShipTeam = null;
         var _loc3_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(!ctrlDown)
         {
            this.tempLine.graphics.clear();
            this.firstX = -1;
            this.firstY = -1;
            this.firstPoint = null;
            this.lastPoint = null;
            return;
         }
         if(this.firstX == -1 && this.firstY == -1)
         {
            this.firstX = param1.localX;
            this.firstY = param1.localY;
         }
         this.tempLine.graphics.clear();
         this.tempLine.graphics.lineStyle(2,26367,1);
         this.tempLine.graphics.moveTo(this.firstX,this.firstY);
         this.tempLine.graphics.lineTo(param1.localX,this.firstY);
         this.tempLine.graphics.lineTo(param1.localX,param1.localY);
         this.tempLine.graphics.lineTo(this.firstX,param1.localY);
         this.tempLine.graphics.lineTo(this.firstX,this.firstY);
         this.firstPoint = OutSideGalaxiasUtil.getPosition2(this.firstX,this.firstY + (param1.localY - this.firstY) * 0.5);
         this.lastPoint = OutSideGalaxiasUtil.getPosition2(param1.localX,this.firstY + (param1.localY - this.firstY) * 0.5);
         var _loc4_:int = 0;
         while(_loc4_ < this.lastPoint.x - this.firstPoint.x)
         {
            _loc5_ = 0;
            while(_loc5_ < this.firstPoint.y - this.lastPoint.y)
            {
               _loc3_ = GalaxyShipManager.instance.getShipsByPos(this.firstPoint.x + _loc4_,this.firstPoint.y - _loc5_);
               if(_loc3_.length != 0)
               {
                  _loc6_ = 0;
                  while(_loc6_ < _loc3_.length)
                  {
                     _loc2_ = _loc3_[_loc6_] as GShipTeam;
                     _loc2_.getShipMc().filters = [new GlowFilter(16776960,1)];
                     this.selectShips.Put(_loc2_.ShipTeamId,_loc2_);
                     _loc6_++;
                  }
               }
               _loc5_++;
            }
            _loc4_++;
         }
      }
      
      override public function Init() : void
      {
         if(this.outSideDefendLayOut)
         {
            if(!GameInterActiveManager.HasInterActiveEvent(this.outSideDefendLayOut,ActionEvent.ACTION_CLICK))
            {
               GameInterActiveManager.InstallInterActiveEvent(this.OutSideDefendContainer,ActionEvent.ACTION_CLICK,this.onCreate);
            }
            GameKernel.getInstance().initStageKeyBoard();
            GameInterActiveManager.InstallInterActiveEvent(this.OutSideDefendContainer,ActionEvent.ACTION_MOUSE_MOVE,this.onTipShow);
            if(!GameInterActiveManager.HasInterActiveEvent(this.outSideDefendLayOut,ActionEvent.ACTION_MOUSE_MOVE))
            {
               GameInterActiveManager.InstallInterActiveEvent(this.OutSideDefendContainer,ActionEvent.ACTION_MOUSE_MOVE,this.mouseDown);
            }
            this.loadStarGates();
            return;
         }
         this.outSideContainer = new Container();
         this.outSideContainer.name = "OutSideContainer";
         var _loc1_:Bitmap = new Bitmap(GameKernel.getTextureInstance("Map1"));
         this.outSideBg = new Container();
         this.outSideBg.Base_SetBackGround(_loc1_);
         this.outSideBg.name = "GalaxyMapBg";
         this.outSideContainer.addChild(this.outSideBg);
         AlignManager.GetInstance().SetAlign(this.outSideBg,"none");
         this.outSideDefendLayOut = new Container();
         this.outSideDefendLayOut.name = "OutSideDefendLayOut";
         this.outSideDefendLayOut.setEnable(true);
         this.outSideContainer.addChild(this.outSideDefendLayOut);
         this.loadStarGates();
         this.cacheOutSideBgWH();
         this.initGridList();
         this.paintRegion();
         this.paintGridLine();
         GameInterActiveManager.InstallInterActiveEvent(this.OutSideDefendContainer,ActionEvent.ACTION_CLICK,this.onCreate);
         GameKernel.getInstance().initStageKeyBoard();
         GameInterActiveManager.InstallInterActiveEvent(this.OutSideDefendContainer,ActionEvent.ACTION_MOUSE_MOVE,this.mouseDown);
         GameInterActiveManager.InstallInterActiveEvent(this.OutSideDefendContainer,ActionEvent.ACTION_MOUSE_MOVE,this.onTipShow);
         OutSideGalaxiasDragger.getInstance().Register(this.OutSideDefendContainer);
         this.OutSideDefendContainer.setLocationXY(-GameSetting.MAP_OUTSIDE_OFFSETX,-GameSetting.MAP_OUTSIDE_OFFSETY);
         this.OutSideDefendContainer.addChild(this.tempLine);
         var _loc2_:int = GameSetting.MAP_OUTSIDE_GRID_WIDTH;
         var _loc3_:int = GameSetting.MAP_OUTSIDE_GRID_HEIGHT;
         var _loc4_:* = GameSetting.MAP_OUTSIDE_GRID_WIDTH >> 1;
         var _loc5_:* = GameSetting.MAP_OUTSIDE_GRID_HEIGHT >> 1;
         this._boutMc = GameKernel.getMovieClipInstance("HuiheTxtMc");
         this._boutData = new MovieClipDataBox(this._boutMc);
         this._boutMc.visible = false;
         this._boutMc.x = 580;
         this._boutMc.y = 60;
         this.outSideContainer.addChild(this._boutMc);
      }
      
      public function get BoutVisible() : Boolean
      {
         return this._boutMc.visible;
      }
      
      public function set BoutVisible(param1:Boolean) : void
      {
         this._boutMc.visible = param1;
      }
      
      public function setBoutText(param1:int) : void
      {
         param1 += 1;
         this._boutData.getMC("mc_txt0").gotoAndStop(Math.floor(param1 / 100) + 1);
         this._boutData.getMC("mc_txt1").gotoAndStop(Math.floor(param1 / 10) + 1);
         this._boutData.getMC("mc_txt2").gotoAndStop(param1 % 10 + 1);
      }
      
      public function cacheOutSideBgWH() : void
      {
         if(this.outSideBgWidth != 0 && this.outSideBgHeight != 0)
         {
            return;
         }
         this.outSideBgWidth = this.outSideBg.width;
         this.outSideBgHeight = this.outSideBg.height;
      }
      
      public function loadStarGates() : void
      {
         var _loc1_:Point = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:Equiment = null;
         var _loc7_:Equiment = null;
         var _loc8_:Equiment = null;
         var _loc4_:int = 0;
         if(GalaxyManager.instance.enterStar.Type == GalaxyType.GT_3)
         {
            if(this.gateArr.length)
            {
               while(this.gateArr.length > 0)
               {
                  _loc7_ = this.gateArr.pop();
                  if((Boolean(_loc7_)) && Boolean(_loc7_.parent))
                  {
                     _loc7_.Release();
                     this.outSideDefendLayOut.removeChild(_loc7_);
                     _loc7_ = null;
                  }
               }
            }
            ObjectUtil.ClearArray(this.gateArr);
            _loc6_ = new Equiment(null);
            _loc6_.setEnable(false);
            _loc6_.mouseChildren = false;
            _loc6_.reLoadMc("StargateMc");
            _loc6_.EquimentInfoData.PosX = 0;
            _loc6_.EquimentInfoData.PosY = 0;
            _loc1_ = GalaxyShipManager.getPixel(_loc6_.EquimentInfoData.PosX,_loc6_.EquimentInfoData.PosY);
            _loc6_.Position = new Point3D(_loc1_.x,_loc1_.y);
            this.outSideDefendLayOut.addChild(_loc6_);
            return;
         }
         if(this.gateArr.length)
         {
            return;
         }
         var _loc5_:int = 0;
         while(_loc5_ < 4)
         {
            _loc8_ = new Equiment(null);
            _loc8_.setEnable(false);
            _loc8_.mouseChildren = false;
            _loc8_.reLoadMc("StargateMc");
            if(_loc5_ < 2)
            {
               _loc2_ = 0;
            }
            else
            {
               _loc2_ = GameSetting.MAP_OUTSIDE_GRID_NUMBER - 1;
            }
            if(_loc4_ % 2 == 0)
            {
               _loc3_ = 0;
            }
            else
            {
               _loc3_ = GameSetting.MAP_OUTSIDE_GRID_NUMBER - 1;
            }
            _loc8_.EquimentInfoData.PosX = _loc2_;
            _loc8_.EquimentInfoData.PosY = _loc3_;
            this.gateArr.push(_loc8_);
            _loc1_ = GalaxyShipManager.getPixel(_loc8_.EquimentInfoData.PosX,_loc8_.EquimentInfoData.PosY);
            _loc8_.Position = new Point3D(_loc1_.x,_loc1_.y);
            this.outSideDefendLayOut.addChild(_loc8_);
            _loc5_++;
            _loc4_++;
         }
      }
      
      public function loadOutSideContructionList() : void
      {
         var _loc2_:Equiment = null;
         var _loc3_:Point = null;
         if(this.outSideContainer == null)
         {
            this.Init();
         }
         this.clearOutSideGridList();
         var _loc1_:Array = ConstructionAction.outSideContuctionList.Values();
         for each(_loc2_ in _loc1_)
         {
            _loc2_.registerActionEvent();
            if(_loc2_.EquimentInfoData.BuildID == EquimentTypeEnum.EQUIMENT_TYPE_SPACESTATION)
            {
               this.setGirdLoad(_loc2_.EquimentInfoData.PosX,_loc2_.EquimentInfoData.PosY);
               this.setGirdLoad(_loc2_.EquimentInfoData.PosX + 1,_loc2_.EquimentInfoData.PosY);
               this.setGirdLoad(_loc2_.EquimentInfoData.PosX + 1,_loc2_.EquimentInfoData.PosY - 1);
               this.setGirdLoad(_loc2_.EquimentInfoData.PosX,_loc2_.EquimentInfoData.PosY - 1);
               this.spaceEquimentPosition = new Point(_loc2_.EquimentInfoData.PosX,_loc2_.EquimentInfoData.PosY);
            }
            else if(this.ValidateCollision(this.spaceEquimentPosition,_loc2_.EquimentInfoData.PosX,_loc2_.EquimentInfoData.PosY))
            {
               _loc2_.EquimentInfoData.PosX += 4;
               _loc2_.EquimentInfoData.PosY += 4;
               this.setGirdLoad(_loc2_.EquimentInfoData.PosX,_loc2_.EquimentInfoData.PosY);
            }
            else
            {
               this.setGirdLoad(_loc2_.EquimentInfoData.PosX,_loc2_.EquimentInfoData.PosY);
            }
            _loc3_ = GalaxyShipManager.getPixel(_loc2_.EquimentInfoData.PosX,_loc2_.EquimentInfoData.PosY);
            _loc2_.Position = new Point3D(_loc3_.x,_loc3_.y);
            this.outSideDefendLayOut.addChild(_loc2_);
         }
         this.setGirdLoad(0,0);
         this.setGirdLoad(1,0);
         this.setGirdLoad(2,0);
         this.setGirdLoad(0,1);
         this.setGirdLoad(0,2);
         this.setGirdLoad(1,1);
         this.setGirdLoad(24,24);
         this.setGirdLoad(24,23);
         this.setGirdLoad(24,22);
         this.setGirdLoad(23,24);
         this.setGirdLoad(22,24);
         this.setGirdLoad(23,23);
         this.setGirdLoad(0,24);
         this.setGirdLoad(1,24);
         this.setGirdLoad(2,24);
         this.setGirdLoad(0,23);
         this.setGirdLoad(0,22);
         this.setGirdLoad(1,23);
         this.setGirdLoad(24,0);
         this.setGirdLoad(24,1);
         this.setGirdLoad(24,2);
         this.setGirdLoad(23,0);
         this.setGirdLoad(22,0);
         this.setGirdLoad(23,1);
         this.spaceEquimentPosition = null;
         this.sortList();
      }
      
      private function ValidateCollision(param1:Point, param2:int, param3:int) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var _loc4_:int = param1.x;
         var _loc5_:int = param1.y;
         if(param2 == _loc4_ && param3 == _loc5_)
         {
            return true;
         }
         if(param2 == _loc4_ + 1 && param3 == _loc5_)
         {
            return true;
         }
         if(param2 == _loc4_ && param3 == _loc5_ - 1)
         {
            return true;
         }
         if(param2 == _loc5_ && param3 == _loc5_ - 1)
         {
            return true;
         }
         return false;
      }
      
      public function removeConstructionAll() : void
      {
         var _loc2_:Equiment = null;
         var _loc1_:Array = ConstructionAction.outSideContuctionList.Values();
         for each(_loc2_ in _loc1_)
         {
            if(_loc2_.parent)
            {
               _loc2_.parent.removeChild(_loc2_);
            }
         }
      }
      
      public function drawConstruction(param1:Equiment) : void
      {
         if(param1.parent == this.outSideDefendLayOut)
         {
            return;
         }
         this.outSideDefendLayOut.addChild(param1);
      }
      
      internal function paintText() : void
      {
         var _loc2_:int = 0;
         var _loc3_:TextField = null;
         this.textList = new Array();
         var _loc1_:int = 0;
         while(_loc1_ < GameSetting.MAP_OUTSIDE_GRID_NUMBER)
         {
            this.textList[_loc1_] = new Array();
            _loc2_ = 0;
            while(_loc2_ < GameSetting.MAP_OUTSIDE_GRID_NUMBER)
            {
               _loc3_ = new TextField();
               _loc3_.border = true;
               _loc3_.autoSize = "center";
               _loc3_.width = 20;
               _loc3_.borderColor = 16777215;
               _loc3_.textColor = 16777215;
               _loc3_.text = _loc2_ + "," + _loc1_;
               _loc3_.x = GameSetting.MAP_OUTSIDE_GRID_WIDTH * 0.5 * (GameSetting.MAP_OUTSIDE_GRID_NUMBER - _loc2_ + _loc1_) - 15;
               _loc3_.y = GameSetting.MAP_OUTSIDE_GRID_HEIGHT * 0.5 * (_loc2_ + _loc1_) + 15;
               _loc3_.mouseEnabled = false;
               _loc3_.alpha = 0.5;
               this.textList[_loc1_][_loc2_] = _loc3_;
               this.OutSideDefendContainer.addChild(_loc3_);
               _loc2_++;
            }
            _loc1_++;
         }
      }
      
      internal function paintRegion() : void
      {
         var _loc1_:int = GameSetting.MAP_OUTSIDE_GRID_WIDTH;
         var _loc2_:int = GameSetting.MAP_OUTSIDE_GRID_HEIGHT;
         this.outSideDefendLayOut.graphics.beginFill(16777215,0.01);
         this.outSideDefendLayOut.graphics.moveTo(_loc1_ * GameSetting.MAP_OUTSIDE_GRID_NUMBER * 0.5,0);
         this.outSideDefendLayOut.graphics.lineTo(0,_loc2_ * GameSetting.MAP_OUTSIDE_GRID_NUMBER * 0.5);
         this.outSideDefendLayOut.graphics.lineTo(_loc1_ * GameSetting.MAP_OUTSIDE_GRID_NUMBER * 0.5,_loc2_ * GameSetting.MAP_OUTSIDE_GRID_NUMBER);
         this.outSideDefendLayOut.graphics.lineTo(_loc1_ * GameSetting.MAP_OUTSIDE_GRID_NUMBER,_loc2_ * GameSetting.MAP_OUTSIDE_GRID_NUMBER * 0.5);
         this.outSideDefendLayOut.graphics.lineTo(_loc1_ * GameSetting.MAP_OUTSIDE_GRID_NUMBER * 0.5,0);
         this.outSideDefendLayOut.graphics.endFill();
      }
      
      internal function initGridList() : void
      {
         var _loc2_:int = 0;
         var _loc3_:Object = null;
         this.gridList = [];
         var _loc1_:int = 0;
         while(_loc1_ < GameSetting.MAP_OUTSIDE_GRID_NUMBER)
         {
            this.gridList[_loc1_] = [];
            _loc2_ = 0;
            while(_loc2_ < GameSetting.MAP_OUTSIDE_GRID_NUMBER)
            {
               _loc3_ = new Object();
               _loc3_.px = _loc1_;
               _loc3_.py = _loc2_;
               _loc3_.father = null;
               _loc3_.isCover = false;
               _loc3_.isLoad = false;
               _loc3_.distance = -1;
               this.gridList[_loc1_][_loc2_] = _loc3_;
               _loc2_++;
            }
            _loc1_++;
         }
      }
      
      public function setGirdLoad(param1:int, param2:int, param3:Boolean = true) : void
      {
         if(param1 >= GameSetting.MAP_OUTSIDE_GRID_NUMBER || param2 >= GameSetting.MAP_OUTSIDE_GRID_NUMBER)
         {
            return;
         }
         if(this.gridList[param1][param2] == null)
         {
            return;
         }
         this.gridList[param1][param2].isLoad = param3;
      }
      
      public function FillGraphics(param1:int, param2:int, param3:uint = 16711680, param4:Number = 0.15) : void
      {
         var _loc5_:int = GameSetting.MAP_OUTSIDE_GRID_WIDTH;
         var _loc6_:int = GameSetting.MAP_OUTSIDE_GRID_HEIGHT;
         var _loc7_:* = GameSetting.MAP_OUTSIDE_GRID_WIDTH >> 1;
         var _loc8_:* = GameSetting.MAP_OUTSIDE_GRID_HEIGHT >> 1;
         var _loc9_:Point = GalaxyShipManager.getPixel(param1,param2);
         this.outSideDefendLayOut.graphics.beginFill(param3,param4);
         this.OutSideDefendContainer.graphics.moveTo(_loc9_.x,_loc9_.y - _loc8_);
         this.OutSideDefendContainer.graphics.lineTo(_loc9_.x + _loc7_,_loc9_.y);
         this.OutSideDefendContainer.graphics.lineTo(_loc9_.x,_loc9_.y + _loc8_);
         this.OutSideDefendContainer.graphics.lineTo(_loc9_.x - _loc7_,_loc9_.y);
         this.OutSideDefendContainer.graphics.lineTo(_loc9_.x,_loc9_.y - _loc8_);
         this.OutSideDefendContainer.graphics.endFill();
      }
      
      public function rePaintRegion() : void
      {
         this.reSetOutSideGridList();
         this.OutSideDefendContainer.graphics.clear();
         this.paintRegion();
         this.paintGridLine();
      }
      
      private function paintGridLoadState() : void
      {
         var _loc2_:Equiment = null;
         var _loc1_:Array = ConstructionAction.outSideContuctionList.Values();
         for each(_loc2_ in _loc1_)
         {
            if(_loc2_.EquimentInfoData.BuildID == EquimentTypeEnum.EQUIMENT_TYPE_SPACESTATION)
            {
               this.FillGraphics(_loc2_.EquimentInfoData.PosX,_loc2_.EquimentInfoData.PosY);
               this.FillGraphics(_loc2_.EquimentInfoData.PosX - 1,_loc2_.EquimentInfoData.PosY);
               this.FillGraphics(_loc2_.EquimentInfoData.PosX - 1,_loc2_.EquimentInfoData.PosY - 1);
               this.FillGraphics(_loc2_.EquimentInfoData.PosX,_loc2_.EquimentInfoData.PosY - 1);
            }
            else
            {
               this.FillGraphics(_loc2_.EquimentInfoData.PosX,_loc2_.EquimentInfoData.PosY);
            }
         }
      }
      
      private function reSetOutSideGridList() : void
      {
         var _loc1_:Array = null;
         var _loc2_:Object = null;
         for each(_loc1_ in this.gridList)
         {
            for each(_loc2_ in _loc1_)
            {
               _loc2_.distance = -1;
            }
         }
      }
      
      private function clearOutSideGridList() : void
      {
         var _loc1_:Array = null;
         var _loc2_:Object = null;
         if(this.gridList == null)
         {
            this.initGridList();
         }
         for each(_loc1_ in this.gridList)
         {
            for each(_loc2_ in _loc1_)
            {
               _loc2_.father = null;
               _loc2_.isCover = false;
               _loc2_.isLoad = false;
               _loc2_.distance = -1;
            }
         }
      }
      
      public function getGridObject(param1:int, param2:int) : Object
      {
         return this.gridList[param1][param2];
      }
      
      public function paintGridLine() : void
      {
         var _loc1_:int = GameSetting.MAP_OUTSIDE_GRID_WIDTH;
         var _loc2_:int = GameSetting.MAP_OUTSIDE_GRID_HEIGHT;
         this.outSideDefendLayOut.graphics.lineStyle(2,16777215,0.8);
         this.outSideDefendLayOut.graphics.moveTo(_loc1_ * 0.5 * GameSetting.MAP_OUTSIDE_GRID_NUMBER,0);
         this.outSideDefendLayOut.graphics.lineTo(0,_loc2_ * 0.5 * GameSetting.MAP_OUTSIDE_GRID_NUMBER);
         this.outSideDefendLayOut.graphics.lineTo(_loc1_ * 0.5 * GameSetting.MAP_OUTSIDE_GRID_NUMBER,_loc2_ * GameSetting.MAP_OUTSIDE_GRID_NUMBER);
         this.outSideDefendLayOut.graphics.lineTo(_loc1_ * GameSetting.MAP_OUTSIDE_GRID_NUMBER,_loc2_ * 0.5 * GameSetting.MAP_OUTSIDE_GRID_NUMBER);
         this.outSideDefendLayOut.graphics.lineTo(_loc1_ * 0.5 * GameSetting.MAP_OUTSIDE_GRID_NUMBER,0);
         this.outSideDefendLayOut.graphics.lineStyle(1,16777215,0.058);
         var _loc3_:int = 0;
         while(_loc3_ <= GameSetting.MAP_OUTSIDE_GRID_NUMBER)
         {
            this.outSideDefendLayOut.graphics.moveTo(_loc1_ * 0.5 * (GameSetting.MAP_OUTSIDE_GRID_NUMBER + _loc3_),_loc2_ * 0.5 * _loc3_);
            this.outSideDefendLayOut.graphics.lineTo(_loc1_ * 0.5 * _loc3_,_loc2_ * 0.5 * (GameSetting.MAP_OUTSIDE_GRID_NUMBER + _loc3_));
            this.outSideDefendLayOut.graphics.moveTo(_loc1_ * 0.5 * (GameSetting.MAP_OUTSIDE_GRID_NUMBER - _loc3_),_loc2_ * 0.5 * _loc3_);
            this.outSideDefendLayOut.graphics.lineTo(_loc1_ * (GameSetting.MAP_OUTSIDE_GRID_NUMBER - 0.5 * _loc3_),_loc2_ * 0.5 * (GameSetting.MAP_OUTSIDE_GRID_NUMBER + _loc3_));
            _loc3_++;
         }
      }
      
      private function renderGate() : void
      {
      }
      
      private function releaseGate() : void
      {
      }
      
      public function unRegisterShipEvent() : void
      {
         GameInterActiveManager.unInstallnterActiveEvent(this.OutSideDefendContainer,ActionEvent.ACTION_MOUSE_MOVE,this.mouseDown);
         GameInterActiveManager.unInstallnterActiveEvent(this.OutSideDefendContainer,ActionEvent.ACTION_MOUSE_MOVE,this.onTipShow);
      }
      
      public function RegisterShipEvent() : void
      {
         GameInterActiveManager.InstallInterActiveEvent(this.OutSideDefendContainer,ActionEvent.ACTION_MOUSE_MOVE,this.mouseDown);
         GameInterActiveManager.InstallInterActiveEvent(this.OutSideDefendContainer,ActionEvent.ACTION_MOUSE_MOVE,this.onTipShow);
      }
      
      public function addActionEvent() : void
      {
         if(!this.outSideDefendLayOut.parent.hasEventListener(MouseEvent.MOUSE_MOVE))
         {
            GameInterActiveManager.InstallInterActiveEvent(this.outSideDefendLayOut.parent,ActionEvent.ACTION_MOUSE_MOVE,this.onMove);
         }
      }
      
      public function removeActionEvent() : void
      {
         if(this.outSideDefendLayOut.parent.hasEventListener(MouseEvent.MOUSE_MOVE))
         {
            GameInterActiveManager.unInstallnterActiveEvent(this.outSideDefendLayOut.parent,ActionEvent.ACTION_MOUSE_MOVE,this.onMove);
         }
      }
      
      public function removeCreateEvent() : void
      {
         if(Boolean(this.OutSideDefendContainer) && this.OutSideDefendContainer.hasEventListener(MouseEvent.CLICK))
         {
            GameInterActiveManager.unInstallnterActiveEvent(this.OutSideDefendContainer,ActionEvent.ACTION_CLICK,this.onCreate);
         }
      }
      
      public function changeConstuctionModel(param1:Boolean) : void
      {
         var _loc3_:Equiment = null;
         GameKernel.isBuildModule = param1;
         var _loc2_:Array = ConstructionAction.outSideContuctionList.Values();
         if(param1)
         {
            for each(_loc3_ in _loc2_)
            {
               _loc3_.unRegisterActionEvent();
               _loc3_.setEnable(false);
            }
         }
         else
         {
            for each(_loc3_ in _loc2_)
            {
               _loc3_.registerActionEvent();
            }
         }
      }
      
      private function onMove(param1:MouseEvent) : void
      {
         var _loc2_:Equiment = null;
         if(ConstructionAction.currentTarget == null)
         {
            return;
         }
         param1.updateAfterEvent();
         this.checkLocation(param1);
         if(this.getGridObject(this._currentPX,this._currentPY).isLoad)
         {
            ConstructionAction.currentTarget.getMC().filters = [new GlowFilter()];
            if(ConstructionAction.getInstance().isOnSpace(this._currentPX,this._currentPY))
            {
               _loc2_ = ConstructionAction.getInstance().getSpaceStation();
            }
            else
            {
               _loc2_ = this.getGalaxyConstructionByPXY(this._currentPX,this._currentPY);
            }
            if(this._preEquiment)
            {
               this._preEquiment.getMC().filters = null;
            }
            this._preEquiment = _loc2_;
            if(_loc2_)
            {
               _loc2_.getMC().filters = [new GlowFilter()];
            }
         }
         else
         {
            ConstructionAction.currentTarget.getMC().filters = null;
            if(this._preEquiment)
            {
               if(this._preEquiment.State == ConstructionState.STATE_COMPLETE)
               {
                  this._preEquiment.getMC().filters = null;
               }
            }
         }
      }
      
      private function onTipShow(param1:MouseEvent) : void
      {
         var _loc4_:Point = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc8_:Point = null;
         var _loc2_:PointKit = OutSideGalaxiasUtil.getPosition(param1);
         var _loc3_:GShipTeam = GalaxyShipManager.instance.getShipByPos(_loc2_.x,_loc2_.y);
         if(_loc3_)
         {
            if(Boolean(this.mouseShip) && _loc3_ != this.mouseShip)
            {
               this.mouseShip.getShipMc().filters = null;
               this.mouseShip = null;
            }
            if(_loc3_.UserId == -1)
            {
               GalaxyShipManager.instance.requestShipTeamInfo(_loc3_);
            }
            _loc4_ = _loc3_.getShipMc().localToGlobal(new Point());
            if(ShipPopUI.getInstance().Opened() && this.mouseShip == this._curShip)
            {
               return;
            }
            _loc5_ = _loc4_.x + _loc3_.getShipMc().width * 0.5;
            _loc6_ = _loc4_.y;
            _loc3_.getShipMc().filters = filter;
            ShipInfoUI.instance.Show(_loc3_);
            this.mouseShip = _loc3_;
            _loc3_ = null;
            return;
         }
         if(this.mouseShip)
         {
            this.mouseShip.getShipMc().filters = null;
            this.mouseShip = null;
         }
         ShipInfoUI.instance.Hiden();
         var _loc7_:Equiment = this.getGalaxyConstructionByPXY(_loc2_.x,_loc2_.y);
         if(_loc7_)
         {
            if(_loc7_.getMC() == null)
            {
               return;
            }
            _loc8_ = _loc7_.getMC().localToGlobal(new Point());
            if(Boolean(this._tmpEquiment) && _loc7_ != this._tmpEquiment)
            {
               this._tmpEquiment.setConstructionModule(false);
            }
            if(!ConstructionOperationWidget.getInstance().isPopUp())
            {
               if(_loc7_.State != ConstructionState.STATE_REPAIR)
               {
                  CustomTip.GetInstance().ShowTip(StringManager.getInstance().getMessageString("BuildingText21") + (_loc7_.EquimentInfoData.LevelId + 1) + " " + _loc7_.EquimentInfoData.BuildName,_loc8_);
               }
            }
            this._tmpEquiment = _loc7_;
         }
         else
         {
            if(this._tmpEquiment)
            {
               if(!(this._tmpEquiment.State == ConstructionState.STATE_BUILING || this._tmpEquiment.State == ConstructionState.STATE_UPDATE))
               {
                  this._tmpEquiment.setConstructionModule(false);
               }
            }
            CustomTip.GetInstance().Hide();
         }
      }
      
      public function onCreate(param1:MouseEvent) : void
      {
         var _loc3_:Point = null;
         var _loc4_:Equiment = null;
         var _loc5_:Equiment = null;
         var _loc6_:Equiment = null;
         var _loc7_:Point = null;
         var _loc8_:FortificationStar = null;
         var _loc9_:GShipTeam = null;
         var _loc10_:int = 0;
         if(!GameKernel.isBuildModule)
         {
            this.removeActionEvent();
         }
         var _loc2_:PointKit = OutSideGalaxiasUtil.getPosition(param1);
         if(GameKernel.isBuildModule && !OutSideGalaxiasDragger.getInstance().isStop())
         {
            return;
         }
         if(GameKernel.isBuildModule)
         {
            if(ConstructionAction.currentTarget == null)
            {
               return;
            }
            switch(ConstructionAction.currentTarget.State)
            {
               case ConstructionState.STATE_PREBUIDING:
                  _loc3_ = GalaxyShipManager.getPixel(this._currentPX,this._currentPY);
                  ConstructionAction.currentTarget.EquimentInfoData.PosX = this._currentPX;
                  ConstructionAction.currentTarget.EquimentInfoData.PosY = this._currentPY;
                  if(this.getGridObject(ConstructionAction.currentTarget.EquimentInfoData.PosX,ConstructionAction.currentTarget.EquimentInfoData.PosY).isLoad)
                  {
                     _loc5_ = this.getGalaxyConstructionByPXY(this._currentPX,this._currentPY);
                     if(_loc5_)
                     {
                        _loc5_.getMC().filters = null;
                     }
                     ConstructionAction.getInstance().clearConstructionModule();
                     return;
                  }
                  if(ConstructionAction.getInstance().CheckConstructionProgreeIsFull())
                  {
                     ConstructionOperationWidget.currenCmd = OperationEnum.OPERATION_TYPE_UPGRADE;
                     UpgradeModulesPopUp.getInstance().Init();
                     UpgradeModulesPopUp.getInstance().Show();
                     ConstructionOperationWidget.getInstance().Hide();
                     return;
                  }
                  if(!ConstructionAction.getInstance().checkCanBuild(ConstructionAction.currentTarget.EquimentInfoData.BuildID,ConstructionAction.currentTarget.EquimentInfoData.LevelId))
                  {
                     return;
                  }
                  this._constuction.createBuildRequest(ConstructionAction.currentTarget);
                  this.removeActionEvent();
                  _loc4_ = EquimentFactory.createEquiment(ConstructionAction.currentTarget.EquimentInfoData.BuildID,ConstructionAction.currentTarget.EquimentInfoData.LevelId);
                  if(!_loc4_.IsOkay)
                  {
                     SingleLoader.GetInstance().Init(_loc4_,ConstructionAction.getInstance().RenderConstruction);
                     SingleLoader.GetInstance().Load();
                  }
                  _loc4_.registerActionEvent();
                  this.RegisterShipEvent();
                  _loc4_.CloneEquimentData(ConstructionAction.currentTarget);
                  _loc4_.Position = new Point3D(_loc3_.x,_loc3_.y);
                  this.OutSideDefendContainer.addChild(_loc4_);
                  ConstructionAction.BuildingList.push(_loc4_);
                  this.changeConstuctionModel(false);
                  ConstructionAction.currentTarget.HideEquimentInfluence();
                  this.outSideDefendLayOut.removeChild(ConstructionAction.currentTarget);
                  ConstructionAction.currentTarget = null;
                  this.sortList();
                  break;
               case ConstructionState.STATE_MIRGRATE:
                  if(this.getGridObject(this._currentPX,this._currentPY).isLoad)
                  {
                     return;
                  }
                  ConstructionAction.currentTarget.EquimentInfoData.PosX = this._currentPX;
                  ConstructionAction.currentTarget.EquimentInfoData.PosY = this._currentPY;
                  ConstructionAction.currentTarget.HideEquimentInfluence();
                  ConstructionAction.getInstance().moveBuildingRequest(ConstructionAction.currentTarget);
                  this.OutSideDefendContainer.addChild(ConstructionAction.currentTarget);
                  this.removeActionEvent();
                  this.RegisterShipEvent();
                  this.changeConstuctionModel(false);
                  this.sortList();
                  ConstructionAction.currentTarget = null;
                  break;
               case ConstructionState.STATE_COMPLETE:
            }
         }
         else
         {
            _loc6_ = this.getGalaxyConstructionByPXY(_loc2_.x,_loc2_.y);
            if(_loc6_)
            {
               ShipPopUI.getInstance().Close();
               if(this._curShip)
               {
                  this._curShip = null;
               }
               if(ConstructionAction.currentTarget)
               {
                  if(ConstructionAction.currentTarget != _loc6_)
                  {
                     _loc6_.removeEquimentSenseZone();
                  }
               }
               ConstructionAction.currentTarget = _loc6_;
               if(Boolean(GalaxyManager.instance.enterStar) && GalaxyManager.instance.enterStar.Type == GalaxyType.GT_3)
               {
                  _loc7_ = _loc6_.localToGlobal(new Point());
                  _loc8_ = FortificationStarReader.getInstance().Read(_loc6_.EquimentInfoData.BuildID,_loc6_.EquimentInfoData.LevelId + 1);
                  if(ConstructionAction.isConsortiaLeader)
                  {
                     ConstructionOperationWidget.getInstance().Assemble(8);
                  }
                  else
                  {
                     ConstructionOperationWidget.getInstance().Assemble(9);
                  }
                  if(GalaxyManager.instance.enterStar.FightFlag != 1 && InstanceManager.instance.instanceStatus != InstanceManager.FB_FIGHT)
                  {
                     if(_loc6_.EquimentInfoData.BuildID == EquimentTypeEnum.EQUIMENT_TYPE_SPACESTATION)
                     {
                        ConstructionOperationWidget.getInstance().setLocation(_loc7_.x + (_loc6_.getMC().width >> 1),_loc7_.y);
                     }
                     else
                     {
                        ConstructionOperationWidget.getInstance().setLocation(_loc7_.x,_loc7_.y);
                     }
                  }
               }
               else if(GameStateManager.playerPlace == GamePlaceType.PLACE_HOME)
               {
                  if(GalaxyManager.instance.enterStar.FightFlag != 1 && InstanceManager.instance.instanceStatus != InstanceManager.FB_FIGHT)
                  {
                     _loc6_.showConstructionToolBarInfo();
                  }
                  _loc6_.setConstructionModule();
                  _loc6_.getMC().alpha = 0.7;
               }
               _loc6_.setConstructionModule();
               _loc6_.getMC().alpha = 0.7;
               CustomTip.GetInstance().Hide();
            }
            else if(ConstructionAction.currentTarget)
            {
               ConstructionAction.currentTarget.setConstructionModule(false);
               if(!(ConstructionAction.currentTarget.State == ConstructionState.STATE_BUILING || ConstructionAction.currentTarget.State == ConstructionState.STATE_UPDATE))
               {
                  ConstructionAction.currentTarget.getMC().filters = null;
                  ConstructionAction.currentTarget.getMC().alpha = 1;
               }
            }
            if(this.selectShips.Length() > 0)
            {
               _loc10_ = 0;
               while(_loc10_ < this.selectShips.Length())
               {
                  _loc9_ = this.selectShips.Values()[_loc10_] as GShipTeam;
                  _loc9_.getShipMc().filters = null;
                  if(GalaxyMapAction.instance.curStar.FightFlag != 1 && GymkhanaUI.getInstance().getStatus() == 0)
                  {
                     GalaxyShipManager.instance.requestShipMove(_loc9_.ShipTeamId,_loc2_.x,_loc2_.y);
                  }
                  _loc10_++;
               }
               this.selectShips.removeAll();
            }
            if(param1.target is MovieClip)
            {
               return;
            }
            if(param1.target is Container && ConstructionAction.currentTarget && ConstructionAction.currentTarget.IsShowInfluence)
            {
               ConstructionAction.currentTarget.HideEquimentInfluence();
            }
            this._currentPX = _loc2_.x;
            this._currentPY = _loc2_.y;
            if(GalaxyShipManager.instance.getShipByPos(this._currentPX,this._currentPY))
            {
               if(this._uniteFlag)
               {
                  if(this._curShip)
                  {
                     this._uniteShip = GalaxyShipManager.instance.getShipByPos(this._currentPX,this._currentPY);
                     if(this._uniteShip.UserId == -1)
                     {
                        GalaxyShipManager.instance.requestShipTeamInfo(this._uniteShip);
                     }
                     FleetUniteUI.getInstance().Uinite(this._curShip.ShipTeamId,this._uniteShip.ShipTeamId);
                  }
                  this._curShip = null;
                  this._uniteShip = null;
                  this._uniteFlag = false;
               }
               else
               {
                  this._curShip = GalaxyShipManager.instance.getShipByPos(this._currentPX,this._currentPY);
                  if(this._curShip.UserId == -1)
                  {
                     GalaxyShipManager.instance.requestShipTeamInfo(this._curShip);
                  }
                  InstanceManager.instance.instanceStatus;
                  this.isButtonClick = false;
                  if(this._curShip.Owner == 2 && GymkhanaUI.getInstance().getStatus() == 0)
                  {
                     ShipPopUI.getInstance().Show(param1);
                  }
               }
            }
            else if(this._curShip && !this._uniteFlag && !this.isButtonClick && !this.getGalaxyConstructionByPXY(_loc2_.x,_loc2_.y))
            {
               if(GalaxyMapAction.instance.curStar.FightFlag != 1 && GymkhanaUI.getInstance().getStatus() == 0)
               {
                  GalaxyShipManager.instance.requestShipMove(this._curShip.ShipTeamId,_loc2_.x,_loc2_.y);
               }
               ShipPopUI.getInstance().Close();
               this._curShip = null;
            }
         }
      }
      
      private function getGalaxyConstructionByPXY(param1:int, param2:int) : Equiment
      {
         var _loc4_:Equiment = null;
         if(ConstructionAction.outSideContuctionList.Length() == 0)
         {
            return null;
         }
         var _loc3_:Array = ConstructionAction.outSideContuctionList.Values();
         for each(_loc4_ in _loc3_)
         {
            if(_loc4_.EquimentInfoData.BuildID == EquimentTypeEnum.EQUIMENT_TYPE_SPACESTATION)
            {
               if(_loc4_.EquimentInfoData.PosX + 1 == param1 && _loc4_.EquimentInfoData.PosY == param2 || _loc4_.EquimentInfoData.PosX + 1 == param1 && _loc4_.EquimentInfoData.PosY - 1 == param2 || _loc4_.EquimentInfoData.PosX == param1 && _loc4_.EquimentInfoData.PosY - 1 == param2 || _loc4_.EquimentInfoData.PosX == param1 && _loc4_.EquimentInfoData.PosY == param2)
               {
                  return _loc4_;
               }
            }
            else if(_loc4_.EquimentInfoData.PosX == param1 && _loc4_.EquimentInfoData.PosY == param2)
            {
               return _loc4_;
            }
         }
         return null;
      }
      
      public function LockObjEffect(param1:Point, param2:Point, param3:int) : void
      {
         var _loc4_:MovieClip = null;
         switch(param3)
         {
            case BattleAction.E_LOCK:
               _loc4_ = GameKernel.getMovieClipInstance("PostAnim");
               break;
            case BattleAction.E_LOCK2:
               _loc4_ = GameKernel.getMovieClipInstance("PostAnim2");
               break;
            case BattleAction.E_LOCK3:
               _loc4_ = GameKernel.getMovieClipInstance("PostAnim3");
         }
         _loc4_.addEventListener(Event.ENTER_FRAME,this.onLockFrame);
         _loc4_.x = param1.x;
         _loc4_.y = param1.y;
         _loc4_.play();
         this.outSideDefendLayOut.addChildAt(_loc4_,0);
         TweenLite.to(_loc4_,0.3,{
            "x":param2.x,
            "y":param2.y
         });
      }
      
      private function onLockFrame(param1:Event) : void
      {
         if(this.lockCount > 10)
         {
            if(this.lockCount % 2 == 0)
            {
               param1.target.visible = true;
            }
            else
            {
               param1.target.visible = false;
            }
         }
         if(this.lockCount == 19)
         {
            param1.target.removeEventListener(Event.ENTER_FRAME,this.onLockFrame);
            this.lockCount = 0;
            this.outSideDefendLayOut.removeChild(param1.target as DisplayObject);
         }
         ++this.lockCount;
      }
      
      public function OutSideAddFightEffect(param1:int, param2:Point, param3:String = "") : void
      {
         var _loc4_:MovieClip = null;
         var _loc5_:String = null;
         switch(param1)
         {
            case BattleAction.E_BOMB:
               _loc4_ = GameKernel.getMovieClipInstance("Bomb");
               _loc5_ = MusicResHandler.BOMB_EFFECT;
               break;
            case BattleAction.E_BOMB2:
               _loc4_ = GameKernel.getMovieClipInstance("BitBomb");
               _loc5_ = MusicResHandler.BOMB_EFFECT;
               break;
            case BattleAction.E_BOMB3:
               _loc4_ = GameKernel.getMovieClipInstance("CommanderBlast2");
               _loc5_ = MusicResHandler.BOMB_EFFECT;
               break;
            case BattleAction.E_LOCK:
               _loc4_ = GameKernel.getMovieClipInstance("PostAnim");
            case BattleAction.E_THOR:
               _loc4_ = GameKernel.getMovieClipInstance("Thor");
               _loc5_ = MusicResHandler.THOR_EFFECT;
               break;
            case BattleAction.E_THOR2:
               _loc4_ = GameKernel.getMovieClipInstance("ThorSec");
               _loc5_ = MusicResHandler.THOR_EFFECT;
               break;
            case BattleAction.E_FLACK:
               _loc4_ = GameKernel.getMovieClipInstance("Flack");
               _loc5_ = MusicResHandler.FLACK_EFFECT;
               break;
            case BattleAction.E_PARTICLE:
               _loc4_ = GameKernel.getMovieClipInstance("Particle");
               _loc5_ = MusicResHandler.PARTICLE_EFFECT;
               break;
            case BattleAction.E_SPACE:
               _loc4_ = GameKernel.getMovieClipInstance("Thor2");
               _loc5_ = MusicResHandler.THOR_EFFECT;
               break;
            case BattleAction.E_BleedNum:
               _loc4_ = GameKernel.getMovieClipInstance("TxtAnim");
               (_loc4_.mc_base.tf_num as TextField).text = param3;
               (_loc4_.mc_base.tf_num as TextField).textColor = 16711680;
         }
         MusicResHandler.PlayEffectMusic(_loc5_);
         _loc4_.addEventListener(Event.ENTER_FRAME,this._OutSizeEffect);
         _loc4_.x = param2.x - 20;
         _loc4_.y = param2.y;
         _loc4_.play();
         this.outSideDefendLayOut.addChild(_loc4_);
      }
      
      private function _OutSizeEffect(param1:Event) : void
      {
         if(param1.target.currentFrame == param1.target.totalFrames)
         {
            param1.target.stop();
            param1.target.removeEventListener(Event.ENTER_FRAME,this._OutSizeEffect);
            this.outSideDefendLayOut.removeChild(param1.target as DisplayObject);
         }
      }
      
      public function sortList() : void
      {
         var _loc1_:Array = ConstructionAction.outSideContuctionList.Values().sortOn("zIndex",Array.NUMERIC);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            if(Equiment(_loc1_[_loc2_]).EquimentInfoData.IndexId == 28)
            {
            }
            this.OutSideDefendContainer.setChildIndex(_loc1_[_loc2_],_loc2_);
            _loc2_++;
         }
      }
      
      public function checkLocation(param1:MouseEvent) : void
      {
         if(param1.target is MovieClip)
         {
            return;
         }
         var _loc2_:Point = GalaxyShipManager.getGird(param1.localX,param1.localY);
         if(_loc2_.x < 0)
         {
            _loc2_.x = 0;
         }
         else if(_loc2_.x >= GameSetting.MAP_OUTSIDE_GRID_NUMBER)
         {
            _loc2_.x = GameSetting.MAP_OUTSIDE_GRID_NUMBER - 1;
         }
         if(_loc2_.y < 0)
         {
            _loc2_.y = 0;
         }
         else if(_loc2_.y >= GameSetting.MAP_OUTSIDE_GRID_NUMBER)
         {
            _loc2_.y = GameSetting.MAP_OUTSIDE_GRID_NUMBER - 1;
         }
         this._currentPX = _loc2_.x;
         this._currentPY = _loc2_.y;
         ConstructionAction.currentTarget.showEquimentInfluence(_loc2_.x,_loc2_.y);
         _loc2_ = GalaxyShipManager.getPixel(_loc2_.x,_loc2_.y);
         ConstructionAction.currentTarget.Position = new Point3D(_loc2_.x,_loc2_.y);
      }
      
      public function get CurShip() : GShipTeam
      {
         return this._curShip;
      }
      
      public function set uniteFlag(param1:Boolean) : void
      {
         this._uniteFlag = param1;
      }
   }
}

