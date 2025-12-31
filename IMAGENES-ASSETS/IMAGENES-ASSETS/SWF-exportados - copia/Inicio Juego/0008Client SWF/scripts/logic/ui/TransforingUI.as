package logic.ui
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.facebook.FacebookUserInfo;
   import com.star.frameworks.managers.ResManager;
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.HashSet;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.text.StyleSheet;
   import flash.text.TextField;
   import flash.utils.Timer;
   import logic.action.ChatAction;
   import logic.action.GalaxyMapAction;
   import logic.entry.GalaxyType;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.HButtonType;
   import logic.entry.MObject;
   import logic.entry.test.BirthButton;
   import logic.game.GameKernel;
   import logic.manager.GalaxyManager;
   import logic.manager.MiniMapManager;
   import logic.ui.tip.CustomTip;
   import logic.widget.DataWidget;
   import logic.widget.NotifyWidget;
   import net.base.NetManager;
   import net.msg.MSG_REQUEST_FROMRESOURCESTARTOHOME;
   import net.msg.miniMap.MSG_REQUEST_MAPBLOCK;
   import net.msg.miniMap.MSG_REQUEST_MAPBLOCKUSERINFO;
   import net.msg.miniMap.MSG_RESP_MAPBLOCKUSERINFO;
   import net.msg.ship.*;
   import net.router.MapRouter;
   
   public class TransforingUI extends AbstractPopUp
   {
      
      private static const M_WIGHT:int = 6;
      
      private static const M_HEITHT:int = 6;
      
      private static const G_W:int = 60;
      
      private static const MG_W:int = 7;
      
      private static const MG_H:int = 5;
      
      private static var _instance:TransforingUI = null;
      
      private var _UI:Container = new Container();
      
      private var _miniMap:Sprite = new Sprite();
      
      private var _miniMapIcon:Sprite = new Sprite();
      
      private var _mapIcons:Array = new Array();
      
      private var _UIElements:HashSet = new HashSet();
      
      private var _datas:Array = new Array();
      
      private var _AttackList:Array = new Array();
      
      private var _DefenseList:Array = new Array();
      
      private var _AddList:Array = new Array();
      
      private var _BattleList:Array = new Array();
      
      private var _HoldList:Array = new Array();
      
      private var SelectedList:Array = new Array();
      
      private var btn_attack:HButton;
      
      private var btn_defense:HButton;
      
      private var btn_add:HButton;
      
      private var btn_battle:HButton;
      
      private var btn_hold:HButton;
      
      private var SelectedButton:HButton;
      
      private var SelectedType:int;
      
      private var btn_backList:Array = new Array();
      
      private var _timer:Timer = new Timer(1000);
      
      private var mapConfig:XML = ResManager.getInstance().getXml("GameRes","GalaxyMap");
      
      private var btn_front:HButton;
      
      private var btn_next:HButton;
      
      private var FirstGId:int;
      
      private var _GalaxyTextMc:MovieClip;
      
      private var _TestText:TextField = new TextField();
      
      private var upBtn:BirthButton = new BirthButton("UP",50,20);
      
      private var downBtn:BirthButton = new BirthButton("DOWN",50,20);
      
      private var leftBtn:BirthButton = new BirthButton("LEFT",50,20);
      
      private var rightBtn:BirthButton = new BirthButton("RIGHT",50,20);
      
      private var moveId:int;
      
      private var moveCount:int;
      
      private var BlockUserinfoMap:HashSet = new HashSet();
      
      private var _curBlockId:int;
      
      private var iconDataArr:Array;
      
      private var _pageSize:int = 6;
      
      private var _curPage:int = 0;
      
      private var _lastPage:int = 0;
      
      public function TransforingUI(param1:HHH)
      {
         super();
         setPopUpName("TransferingUI");
      }
      
      public static function requestMapBlock(param1:int) : void
      {
         var _loc2_:MSG_REQUEST_MAPBLOCK = new MSG_REQUEST_MAPBLOCK();
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         _loc2_.GalaxyMapId = 0;
         _loc2_.BlockId = param1;
         NetManager.Instance().sendObject(_loc2_);
      }
      
      public static function get instance() : TransforingUI
      {
         if(_instance == null)
         {
            _instance = new TransforingUI(new HHH());
         }
         return _instance;
      }
      
      override public function Init() : void
      {
         if(!GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            this._mc = new MObject("GalaxymapScene",385,300);
            this.InitUI();
            GameKernel.popUpDisplayManager.Regisger(_instance);
         }
      }
      
      public function Show(param1:int = 0) : void
      {
         NotifyWidget.getInstance().removeNotify(2);
         this.Init();
         this._curPage = 0;
         this._lastPage = 0;
         this.InitItem();
         this.InitMap();
         this.ShowPageButton();
         this.RequestJumpShipTeamInfo();
         GameKernel.popUpDisplayManager.Show(_instance);
         if(param1 == 1)
         {
            this.ShowList(this.btn_defense,1,this._DefenseList);
         }
      }
      
      private function RequestJumpShipTeamInfo() : void
      {
         this.ClearJumpList();
         var _loc1_:MSG_REQUEST_JUMPSHIPTEAMINFO = new MSG_REQUEST_JUMPSHIPTEAMINFO();
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc1_);
      }
      
      private function ClearJumpList() : void
      {
         var _loc2_:MovieClip = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._pageSize)
         {
            _loc2_ = this._mc.getMC().getChildByName("mc_list" + _loc1_) as MovieClip;
            _loc2_.visible = false;
            _loc1_++;
         }
         this._AttackList.splice(0);
         this._DefenseList.splice(0);
         this._AddList.splice(0);
         this._BattleList.splice(0);
         this._HoldList.splice(0);
      }
      
      private function InitUI() : void
      {
         var _loc1_:int = 0;
         var _loc3_:HButton = null;
         var _loc4_:MovieClip = null;
         var _loc7_:XButton = null;
         var _loc8_:XButton = null;
         var _loc9_:XTextField = null;
         var _loc2_:Graphics = (_mc.getMC().getChildByName("mc_base") as MovieClip).graphics;
         this._miniMapIcon.graphics.beginFill(221,0.1);
         this._miniMapIcon.graphics.drawRect(0,0,MG_W * G_W,MG_H * G_W);
         this._miniMapIcon.graphics.endFill();
         (_mc.getMC().getChildByName("mc_base") as MovieClip).addEventListener(MouseEvent.CLICK,this.onMiniMapClick);
         (_mc.getMC().getChildByName("mc_base") as MovieClip).addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         (_mc.getMC().getChildByName("mc_base") as MovieClip).addChild(this._miniMapIcon);
         _loc4_ = this._mc.getMC().getChildByName("btn_close") as MovieClip;
         _loc4_.addEventListener(MouseEvent.CLICK,this.Release,false,0,true);
         _loc3_ = new HButton(_loc4_);
         this._UIElements.Put("btn_close",_loc3_);
         _loc4_ = this._mc.getMC().getChildByName("btn_left") as MovieClip;
         _loc4_.addEventListener(MouseEvent.CLICK,this.onChangeBlock,false,0,true);
         _loc3_ = new HButton(_loc4_);
         this._UIElements.Put("btn_left",_loc3_);
         _loc4_ = this._mc.getMC().getChildByName("btn_right") as MovieClip;
         _loc4_.addEventListener(MouseEvent.CLICK,this.onChangeBlock,false,0,true);
         _loc3_ = new HButton(_loc4_);
         this._UIElements.Put("btn_right",_loc3_);
         _loc4_ = this._mc.getMC().getChildByName("btn_up") as MovieClip;
         _loc4_.addEventListener(MouseEvent.CLICK,this.onChangeBlock,false,0,true);
         _loc3_ = new HButton(_loc4_);
         this._UIElements.Put("btn_up",_loc3_);
         _loc4_ = this._mc.getMC().getChildByName("btn_down") as MovieClip;
         _loc4_.addEventListener(MouseEvent.CLICK,this.onChangeBlock,false,0,true);
         _loc3_ = new HButton(_loc4_);
         this._UIElements.Put("btn_down",_loc3_);
         _loc4_ = this._mc.getMC().getChildByName("btn_attack") as MovieClip;
         _loc4_.addEventListener(MouseEvent.CLICK,this.onButtonClick,false,0,true);
         this.btn_attack = new HButton(_loc4_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("StarText26"));
         this._UIElements.Put("btn_attack",_loc3_);
         _loc4_ = this._mc.getMC().getChildByName("btn_defense") as MovieClip;
         _loc4_.addEventListener(MouseEvent.CLICK,this.onButtonClick,false,0,true);
         this.btn_defense = new HButton(_loc4_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("StarText27"));
         this._UIElements.Put("btn_defense",_loc3_);
         _loc4_ = this._mc.getMC().getChildByName("btn_add") as MovieClip;
         _loc4_.addEventListener(MouseEvent.CLICK,this.onButtonClick,false,0,true);
         this.btn_add = new HButton(_loc4_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("StarText28"));
         this._UIElements.Put("btn_add",_loc3_);
         _loc4_ = this._mc.getMC().getChildByName("btn_battle") as MovieClip;
         _loc4_.addEventListener(MouseEvent.CLICK,this.onButtonClick,false,0,true);
         this.btn_battle = new HButton(_loc4_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("StarText29"));
         this._UIElements.Put("btn_battle",_loc3_);
         _loc4_ = this._mc.getMC().getChildByName("btn_hold") as MovieClip;
         _loc4_.addEventListener(MouseEvent.CLICK,this.onButtonClick,false,0,true);
         this.btn_hold = new HButton(_loc4_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("StarText30"));
         this._UIElements.Put("btn_hold",_loc3_);
         _loc4_ = this._mc.getMC().getChildByName("btn_ally") as MovieClip;
         _loc4_.addEventListener(MouseEvent.CLICK,this.onButtonClick,false,0,true);
         _loc4_.addEventListener(MouseEvent.MOUSE_OVER,this.onButtonOver);
         _loc3_ = new HButton(_loc4_,HButtonType.SELECT);
         _loc3_.setSelect(true);
         this._UIElements.Put("btn_ally",_loc3_);
         _loc4_ = this._mc.getMC().getChildByName("btn_enemy") as MovieClip;
         _loc4_.addEventListener(MouseEvent.CLICK,this.onButtonClick,false,0,true);
         _loc4_.addEventListener(MouseEvent.MOUSE_OVER,this.onButtonOver);
         _loc3_ = new HButton(_loc4_,HButtonType.SELECT);
         _loc3_.setSelect(true);
         this._UIElements.Put("btn_enemy",_loc3_);
         _loc4_ = this._mc.getMC().getChildByName("btn_airship") as MovieClip;
         _loc4_.addEventListener(MouseEvent.CLICK,this.onButtonClick,false,0,true);
         _loc4_.addEventListener(MouseEvent.MOUSE_OVER,this.onButtonOver);
         _loc3_ = new HButton(_loc4_,HButtonType.SELECT);
         _loc3_.setSelect(true);
         this._UIElements.Put("btn_airship",_loc3_);
         _loc4_ = this._mc.getMC().getChildByName("btn_flyline") as MovieClip;
         _loc4_.addEventListener(MouseEvent.CLICK,this.onButtonClick,false,0,true);
         _loc4_.addEventListener(MouseEvent.MOUSE_OVER,this.onButtonOver);
         _loc3_ = new HButton(_loc4_,HButtonType.SELECT);
         _loc3_.setSelect(true);
         this._UIElements.Put("btn_flyline",_loc3_);
         _loc4_ = this._mc.getMC().getChildByName("btn_front") as MovieClip;
         _loc4_.addEventListener(MouseEvent.CLICK,this.onButtonClick,false,0,true);
         this.btn_front = new HButton(_loc4_);
         this._UIElements.Put("btn_front",_loc3_);
         _loc4_ = this._mc.getMC().getChildByName("btn_next") as MovieClip;
         _loc4_.addEventListener(MouseEvent.CLICK,this.onButtonClick,false,0,true);
         this.btn_next = new HButton(_loc4_);
         this._UIElements.Put("btn_next",_loc3_);
         (this._mc.getMC().getChildByName("tf_page") as TextField).text = "";
         var _loc5_:String = "a:link{text-decoration: underline;} a:hover{color:#ff0000;text-decoration: underline;} a:active{text-decoration: underline;}";
         var _loc6_:StyleSheet = new StyleSheet();
         _loc6_.parseCSS(_loc5_);
         _loc1_ = 0;
         while(_loc1_ < 6)
         {
            (this._mc.getMC().getChildByName("mc_list" + _loc1_) as MovieClip).stop();
            (this._mc.getMC().getChildByName("mc_list" + _loc1_) as MovieClip).visible = false;
            _loc4_ = this._mc.getMC().getChildByName("mc_list" + _loc1_) as MovieClip;
            _loc7_ = new XButton(_loc4_.btn_wait);
            _loc7_.Data = _loc1_;
            _loc7_.OnClick = this.btn_waitClick;
            _loc8_ = new XButton(_loc4_.btn_back);
            _loc8_.Data = _loc1_;
            _loc8_.OnClick = this.btn_backClick;
            this.btn_backList.push(_loc8_);
            _loc9_ = new XTextField(_loc4_.tf_name);
            _loc9_.Data = _loc1_;
            _loc9_.OnClick = this.tf_nameClick;
            _loc4_.tf_name.styleSheet = _loc6_;
            _loc1_++;
         }
         this.initTestText();
      }
      
      private function onMiniMapClick(param1:MouseEvent) : void
      {
         (_mc.getMC().getChildByName("mc_rader") as MovieClip).play();
         var _loc2_:int = int(this._curBlockId / 7) * 60 * GalaxyManager.MAX_MAPAREAGRID + this._curBlockId % 7 * 60;
         var _loc3_:int = _loc2_ + Math.floor(param1.localX / MG_W) * GalaxyManager.MAX_MAPAREAGRID + Math.floor(param1.localY / MG_H);
         var _loc4_:int = GalaxyManager.getStarCoordinate(_loc3_).x - 15;
         var _loc5_:int = GalaxyManager.getStarCoordinate(_loc3_).y - 13;
         GalaxyMapAction.instance.requestAreas(_loc4_,_loc5_);
         GalaxyManager.instance.printCacheStar(_loc4_,_loc5_);
      }
      
      private function onRollOver(param1:MouseEvent) : void
      {
         (_mc.getMC().getChildByName("mc_base") as MovieClip).addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         (_mc.getMC().getChildByName("mc_base") as MovieClip).addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
      }
      
      private function onRollOut(param1:MouseEvent) : void
      {
         if((_mc.getMC().getChildByName("mc_base") as MovieClip).hasEventListener(Event.ENTER_FRAME))
         {
            (_mc.getMC().getChildByName("mc_base") as MovieClip).removeEventListener(Event.ENTER_FRAME,this.onCount);
         }
         (_mc.getMC().getChildByName("mc_base") as MovieClip).removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         (_mc.getMC().getChildByName("mc_base") as MovieClip).removeEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
      }
      
      private function initTestText() : void
      {
         this._GalaxyTextMc = GameKernel.getMovieClipInstance("GalaxytxtMc");
         (this._GalaxyTextMc.tf_corpsname as TextField).mouseEnabled = false;
         (this._GalaxyTextMc.tf_name as TextField).mouseEnabled = false;
         this._GalaxyTextMc.x = 2;
         this._GalaxyTextMc.y = 255;
         this._miniMapIcon.addChild(this._GalaxyTextMc);
      }
      
      private function onMouseMove(param1:MouseEvent) : void
      {
         var _loc2_:int = int(this._curBlockId / 7) * 60 * GalaxyManager.MAX_MAPAREAGRID + this._curBlockId % 7 * 60;
         var _loc3_:int = _loc2_ + Math.floor(param1.localX / MG_W) * GalaxyManager.MAX_MAPAREAGRID + Math.floor(param1.localY / MG_H);
         if(!this.checkGalaxyId(_loc3_))
         {
            this.cleanMinimapInfo();
            return;
         }
         if(this.moveId != _loc3_)
         {
            this.moveId = _loc3_;
            if((_mc.getMC().getChildByName("mc_base") as MovieClip).hasEventListener(Event.ENTER_FRAME))
            {
               (_mc.getMC().getChildByName("mc_base") as MovieClip).removeEventListener(Event.ENTER_FRAME,this.onCount);
            }
            this.moveCount = 0;
            this.cleanMinimapInfo();
         }
         if(this.moveId == _loc3_)
         {
            if(!(_mc.getMC().getChildByName("mc_base") as MovieClip).hasEventListener(Event.ENTER_FRAME))
            {
               (_mc.getMC().getChildByName("mc_base") as MovieClip).addEventListener(Event.ENTER_FRAME,this.onCount);
            }
         }
         var _loc4_:int = GalaxyManager.getStarCoordinate(_loc3_).x;
         var _loc5_:int = GalaxyManager.getStarCoordinate(_loc3_).y;
         (_mc.getMC().getChildByName("tf_location") as TextField).text = "x:" + _loc4_ + " y:" + _loc5_;
         if(param1.target.name == "GalaxytxtMc")
         {
            if(this._GalaxyTextMc.x < this._GalaxyTextMc.width)
            {
               this._GalaxyTextMc.x = 300;
            }
            else
            {
               this._GalaxyTextMc.x = 2;
            }
         }
      }
      
      private function onCount(param1:Event) : void
      {
         var _loc2_:MSG_RESP_MAPBLOCKUSERINFO = null;
         if(this.moveCount == 30)
         {
            if(this.BlockUserinfoMap.Get(this.moveId))
            {
               _loc2_ = this.BlockUserinfoMap.Get(this.moveId);
               this.updateMinimapInfo(_loc2_);
            }
            else
            {
               if(this.BlockUserinfoMap.ContainsKey(this.moveId))
               {
                  return;
               }
               this.BlockUserinfoMap.Put("moveId",null);
               this.requestMapBlockUserinfo(this.moveId);
            }
            return;
         }
         ++this.moveCount;
      }
      
      private function requestMapBlockUserinfo(param1:int) : void
      {
         var _loc2_:MSG_REQUEST_MAPBLOCKUSERINFO = new MSG_REQUEST_MAPBLOCKUSERINFO();
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.GalaxyId = param1;
         NetManager.Instance().sendObject(_loc2_);
      }
      
      public function updateMinimapInfo(param1:MSG_RESP_MAPBLOCKUSERINFO) : void
      {
         this.BlockUserinfoMap.Put(param1.GalaxyId,param1);
         TextField(this._GalaxyTextMc.tf_corpsname).text = param1.ConsortiaName + "";
         TextField(this._GalaxyTextMc.tf_name).text = param1.Name + "";
         GameKernel.getPlayerFacebookInfo(param1.UserId,this.callback,param1.Name);
         this._GalaxyTextMc.visible = true;
      }
      
      private function callback(param1:FacebookUserInfo) : void
      {
         if(param1 != null)
         {
            TextField(this._GalaxyTextMc.tf_name).text = param1.first_name + "";
         }
      }
      
      private function cleanMinimapInfo() : void
      {
         TextField(this._GalaxyTextMc.tf_corpsname).text = "";
         TextField(this._GalaxyTextMc.tf_name).text = "";
         this._GalaxyTextMc.visible = false;
      }
      
      private function checkGalaxyId(param1:int) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:Array = MiniMapManager.instance.getAllCorps();
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc2_ = int(_loc3_[_loc4_]);
            if(param1 == _loc2_)
            {
               return true;
            }
            _loc4_++;
         }
         if(param1 == GamePlayer.getInstance().galaxyID)
         {
            return true;
         }
         if(!this.iconDataArr)
         {
            return false;
         }
         var _loc5_:int = 0;
         while(_loc5_ < this.iconDataArr.length)
         {
            _loc2_ = int(this.iconDataArr[_loc5_]);
            if(param1 == _loc2_)
            {
               return true;
            }
            _loc5_++;
         }
         return false;
      }
      
      private function onChangeBlock(param1:MouseEvent) : void
      {
         switch(param1.target.name)
         {
            case "btn_up":
               --this._curBlockId;
               break;
            case "btn_down":
               this._curBlockId += 1;
               break;
            case "btn_left":
               this._curBlockId -= 7;
               break;
            case "btn_right":
               this._curBlockId += 7;
         }
         this.ShowPageButton();
         if(this._curBlockId < 0 || this._curBlockId > GalaxyManager.maxArea)
         {
            return;
         }
         TransforingUI.requestMapBlock(this._curBlockId);
         (_mc.getMC().tf_name as TextField).text = StringManager.getInstance().getMessageString("StarBtn15") + (this._curBlockId + 1);
      }
      
      private function ShowPageButton() : void
      {
         var _loc1_:int = this._curBlockId;
         var _loc2_:int = GalaxyManager.maxArea;
         HButton(this._UIElements.Get("btn_up")).setBtnDisabled(_loc1_ % 7 == 0);
         HButton(this._UIElements.Get("btn_down")).setBtnDisabled(_loc1_ % 7 == 6);
         HButton(this._UIElements.Get("btn_left")).setBtnDisabled(int(_loc1_ / 7) == 0);
         HButton(this._UIElements.Get("btn_right")).setBtnDisabled(int(_loc1_ / 7) + 1 == int(GalaxyManager.maxArea / 7));
      }
      
      public function InitMap() : void
      {
         var _loc1_:int = GamePlayer.getInstance().galaxyID;
         this._curBlockId = int(int(GamePlayer.getInstance().galaxyID / GalaxyManager.MAX_MAPAREAGRID) / 60) * 7 + int(GamePlayer.getInstance().galaxyID % GalaxyManager.MAX_MAPAREAGRID / 60);
         (_mc.getMC().tf_name as TextField).text = StringManager.getInstance().getMessageString("StarBtn15") + (this._curBlockId + 1);
         TransforingUI.requestMapBlock(this._curBlockId);
      }
      
      public function freshMiniMap(param1:Array) : void
      {
         var _loc3_:XML = null;
         this.iconDataArr = param1;
         this.clearIcons();
         this.FirstGId = int(this._curBlockId / 7) * 60 * GalaxyManager.MAX_MAPAREAGRID + this._curBlockId % 7 * 60;
         var _loc2_:Array = MiniMapManager.instance.getAllCorps();
         if((this._UIElements.Get("btn_airship") as HButton).selsected)
         {
            this.DrawRects(_loc2_,"Allystar");
         }
         this.DrawRect(GamePlayer.getInstance().galaxyID - this.FirstGId,"Mainstar");
         if((this._UIElements.Get("btn_enemy") as HButton).selsected)
         {
            this.DrawRects(param1,"Battlestate2");
         }
         for each(_loc3_ in this.mapConfig.*)
         {
            switch(_loc3_.@Type + "")
            {
               case GalaxyType.GT_2 + "":
                  if((this._UIElements.Get("btn_flyline") as HButton).selsected)
                  {
                     this.DrawGate(_loc3_.@X,_loc3_.@Y,"Stargate");
                  }
                  break;
               case GalaxyType.GT_3 + "":
                  if((this._UIElements.Get("btn_ally") as HButton).selsected)
                  {
                     this.DrawGate(_loc3_.@X,_loc3_.@Y,"Resstar");
                  }
            }
         }
      }
      
      private function clearIcons() : void
      {
         var _loc1_:DisplayObject = null;
         var _loc2_:int = 0;
         while(_loc2_ < this._mapIcons.length)
         {
            _loc1_ = this._mapIcons[_loc2_] as DisplayObject;
            if(this._miniMapIcon.contains(_loc1_))
            {
               this._miniMapIcon.removeChild(_loc1_);
            }
            _loc2_++;
         }
         _loc1_ = null;
         this._mapIcons.splice(0);
      }
      
      private function DrawRects(param1:Array, param2:String) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         for each(_loc3_ in param1)
         {
            _loc4_ = _loc3_ - this.FirstGId;
            this.DrawRect(_loc4_,param2);
         }
      }
      
      public function DrawRect(param1:int, param2:String) : void
      {
         var _loc5_:MovieClip = null;
         var _loc3_:int = param1 / GalaxyManager.MAX_MAPAREAGRID;
         var _loc4_:int = param1 % GalaxyManager.MAX_MAPAREAGRID;
         if(_loc3_ >= 0 && _loc3_ < 60 && _loc4_ >= 0 && _loc4_ < 60)
         {
            if(param2 == "")
            {
               return;
            }
            _loc5_ = GameKernel.getMovieClipInstance(param2);
            _loc5_.mouseEnabled = _loc5_.mouseChildren = false;
            _loc5_.x = _loc3_ * MG_W;
            _loc5_.y = _loc4_ * MG_H;
            this._mapIcons.push(_loc5_);
            this._miniMapIcon.addChild(_loc5_);
         }
      }
      
      public function DrawGate(param1:int, param2:int, param3:String) : void
      {
         if(param3 == "")
         {
            return;
         }
         if(param1 <= 0 && param1 > 60 && param2 <= 0 && param2 > 60)
         {
            return;
         }
         var _loc4_:MovieClip = GameKernel.getMovieClipInstance(param3);
         _loc4_.mouseEnabled = _loc4_.mouseChildren = false;
         _loc4_.x = param1 * MG_W;
         _loc4_.y = param2 * MG_H;
         this._mapIcons.push(_loc4_);
         this._miniMapIcon.addChild(_loc4_);
      }
      
      private function InitItem() : void
      {
         this.ShowList(this.btn_attack,0,this._AttackList);
         this._timer.start();
         this._timer.addEventListener(TimerEvent.TIMER,this.onTimer);
      }
      
      private function onTimer(param1:Event) : void
      {
         this.UpdateNeedTime(this._AttackList);
         this.UpdateNeedTime(this._DefenseList);
         this.UpdateNeedTime(this._AddList);
      }
      
      private function UpdateNeedTime(param1:Array) : void
      {
         var _loc2_:MSG_RESP_JUMPSHIPTEAMINFO_TEMP = null;
         if(param1 == null || param1.length == 0)
         {
            return;
         }
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         while(_loc4_ < param1.length)
         {
            _loc2_ = param1[_loc4_] as MSG_RESP_JUMPSHIPTEAMINFO_TEMP;
            --_loc2_.SpareTime;
            if(_loc2_.SpareTime <= 0)
            {
               param1.splice(_loc4_,1);
               if(_loc4_ / this._pageSize >= this._curPage)
               {
                  _loc3_ = true;
               }
            }
            else
            {
               _loc4_++;
            }
         }
         if(param1 == this.SelectedList)
         {
            this.ShowCurPage(_loc3_);
            this.ResetPageButton();
         }
      }
      
      private function cleanItem() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:int = 0;
         while(_loc2_ < this._pageSize)
         {
            _loc1_ = this._mc.getMC().getChildByName("mc_list" + _loc2_) as MovieClip;
            _loc1_.visible = false;
            if(_loc1_.mc_base.getChildByName("CommanderHead"))
            {
               _loc1_.mc_base.removeChild(_loc1_.mc_base.getChildByName("CommanderHead"));
            }
            _loc1_.mc_bar.width = 116;
            TextField(_loc1_.tf_name).text = "";
            TextField(_loc1_.tf_time).text = "00:00:00";
            _loc2_++;
         }
      }
      
      public function Release(param1:MouseEvent = null) : void
      {
         this._timer.stop();
         this._timer.removeEventListener(TimerEvent.TIMER,this.onTimer);
         this.cleanItem();
         this._AttackList.splice(0);
         this._DefenseList.splice(0);
         this._AddList.splice(0);
         this._BattleList.splice(0);
         this._HoldList.splice(0);
         this._datas.splice(0);
         GameKernel.popUpDisplayManager.Hide(this);
      }
      
      public function RespJumpInfo(param1:MSG_RESP_JUMPSHIPTEAMINFO) : void
      {
         var _loc4_:MSG_RESP_JUMPSHIPTEAMINFO_TEMP = null;
         var _loc2_:int = 0;
         if(this.SelectedList != null)
         {
            _loc2_ = int(this.SelectedList.length);
         }
         var _loc3_:int = 0;
         while(_loc3_ < param1.DataLen)
         {
            _loc4_ = param1.Data[_loc3_];
            switch(_loc4_.Type)
            {
               case 0:
                  this._AttackList.push(_loc4_);
                  break;
               case 1:
                  this._DefenseList.push(_loc4_);
                  break;
               case 2:
                  this._AddList.push(_loc4_);
                  break;
               case 3:
                  this._BattleList.push(_loc4_);
                  break;
               case 4:
                  this._HoldList.push(_loc4_);
            }
            _loc3_++;
         }
         if(this.SelectedList != null && _loc2_ < this.SelectedList.length)
         {
            this._lastPage = this.SelectedList.length / this._pageSize;
            if(this._lastPage * this._pageSize < this.SelectedList.length)
            {
               ++this._lastPage;
            }
            if(_loc2_ == 0 || _loc2_ / this._pageSize == this._curPage && _loc2_ % this._pageSize > 0)
            {
               this.ShowCurPage();
            }
         }
      }
      
      public function RespBackInfo(param1:MSG_RESP_CANCELJUMPSHIPTEAM) : void
      {
         var _loc3_:MSG_RESP_JUMPSHIPTEAMINFO_TEMP = null;
         var _loc4_:MSG_RESP_JUMPSHIPTEAMINFO_TEMP = null;
         var _loc2_:int = 0;
         for each(_loc4_ in this._AttackList)
         {
            if(_loc4_.ShipTeamId == param1.ShipTeamId)
            {
               _loc4_.SpareTime = param1.NeedTime;
               _loc4_.TotalTime = param1.NeedTime;
               _loc4_.FromGalaxyMapId = _loc4_.ToGalaxyMapId;
               _loc4_.FromGalaxyId = _loc4_.ToGalaxyId;
               _loc4_.ToGalaxyMapId = GamePlayer.getInstance().galaxyMapID;
               _loc4_.ToGalaxyId = GamePlayer.getInstance().galaxyID;
               _loc4_.UserId = GamePlayer.getInstance().userID;
               GameKernel.currentGameUserInfo;
               _loc4_.UserName = GameKernel.youselfFaceBook.first_name;
               _loc3_ = _loc4_;
               break;
            }
            _loc2_++;
         }
         if(this.SelectedType == 0 && _loc3_ != null)
         {
            if(int(_loc2_ / this._pageSize) == this._curPage)
            {
               this.UpdateItem(_loc2_ % this._pageSize,_loc3_,true);
            }
         }
      }
      
      public function pushData(param1:MSG_RESP_JUMPSHIPTEAMINFO_TEMP) : void
      {
      }
      
      private function ShowCurPage(param1:Boolean = true) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:MSG_RESP_JUMPSHIPTEAMINFO_TEMP = null;
         var _loc4_:int = this._curPage * this._pageSize;
         var _loc5_:int = 0;
         while(_loc5_ < this._pageSize)
         {
            if(_loc4_ < this.SelectedList.length)
            {
               _loc3_ = this.SelectedList[_loc4_] as MSG_RESP_JUMPSHIPTEAMINFO_TEMP;
               this.UpdateItem(_loc5_,_loc3_,param1);
            }
            else
            {
               this.UpdateItem(_loc5_,null,param1);
            }
            _loc4_++;
            _loc5_++;
         }
         this.ResetPageButton();
      }
      
      private function UpdateItem(param1:int, param2:MSG_RESP_JUMPSHIPTEAMINFO_TEMP, param3:Boolean) : void
      {
         var _loc5_:int = 0;
         var _loc4_:MovieClip = this._mc.getMC().getChildByName("mc_list" + param1) as MovieClip;
         if(param2 != null)
         {
            _loc4_.visible = true;
            if(param3)
            {
               if(this.SelectedType == 0)
               {
                  _loc5_ = GamePlayer.getInstance().galaxyID;
                  if(param2.ToGalaxyMapId == GamePlayer.getInstance().galaxyMapID && param2.ToGalaxyId == GamePlayer.getInstance().galaxyID)
                  {
                     TextField(_loc4_.tf_type).text = StringManager.getInstance().getMessageString("StarText14");
                  }
                  else
                  {
                     TextField(_loc4_.tf_type).text = StringManager.getInstance().getMessageString("StarText13");
                  }
               }
               else if(this.SelectedType == 1)
               {
                  TextField(_loc4_.tf_type).text = StringManager.getInstance().getMessageString("StarText15");
               }
               else if(this.SelectedType == 2)
               {
                  TextField(_loc4_.tf_type).text = StringManager.getInstance().getMessageString("StarText16");
               }
               else if(this.SelectedType == 3)
               {
                  TextField(_loc4_.tf_type).text = StringManager.getInstance().getMessageString("StarText17");
               }
               else if(this.SelectedType == 4)
               {
                  TextField(_loc4_.tf_type).text = StringManager.getInstance().getMessageString("StarText39");
               }
               if(param2.GalaxyType == 1)
               {
                  if(param2.UserName == "")
                  {
                     TextField(_loc4_.tf_name).htmlText = "<a href=\'event:\'>" + param2.UserId + "</a>";
                  }
                  else
                  {
                     TextField(_loc4_.tf_name).htmlText = "<a href=\'event:\'>" + param2.UserName + "</a>";
                  }
               }
               else if(param2.GalaxyType == 2)
               {
                  TextField(_loc4_.tf_name).htmlText = "<a href=\'event:\'>" + StringManager.getInstance().getMessageString("Boss46") + "</a>";
               }
               else
               {
                  TextField(_loc4_.tf_name).htmlText = "<a href=\'event:\'>" + StringManager.getInstance().getMessageString("StarText5") + "</a>";
               }
               if(param2.Type == 3 && param2.FromGalaxyMapId == 1)
               {
                  TextField(_loc4_.tf_name).text = StringManager.getInstance().getMessageString("StarText18");
               }
               if(this.SelectedType == 0 && (param2.ToGalaxyMapId != GamePlayer.getInstance().galaxyMapID || param2.ToGalaxyId != GamePlayer.getInstance().galaxyID))
               {
                  XButton(this.btn_backList[param1]).setBtnDisabled(false);
               }
               else if(this.SelectedType == 4)
               {
                  XButton(this.btn_backList[param1]).setBtnDisabled(false);
               }
               else
               {
                  XButton(this.btn_backList[param1]).setBtnDisabled(true);
               }
            }
            if(param2.Type == 3 || param2.Type == 4)
            {
               _loc4_.mc_bar.width = 0;
               TextField(_loc4_.tf_time).text = "";
            }
            else
            {
               _loc4_.mc_bar.width = (param2.TotalTime - param2.SpareTime) / param2.TotalTime * 116;
               TextField(_loc4_.tf_time).text = DataWidget.localToDataZone(param2.SpareTime);
            }
         }
         else
         {
            _loc4_.visible = false;
         }
      }
      
      private function btn_waitClick(param1:MouseEvent, param2:XButton) : void
      {
         var _loc4_:MSG_RESP_JUMPSHIPTEAMINFO_TEMP = null;
         var _loc5_:MSG_REQUEST_VIEWJUMPSHIPTEAM = null;
         var _loc3_:int = param2.Data + this._curPage * this._pageSize;
         if(_loc3_ < this.SelectedList.length)
         {
            MapRouter.instance.MSG_RESP_VIEWJUMPSHIPTEAM_SrcType = 0;
            _loc4_ = this.SelectedList[_loc3_] as MSG_RESP_JUMPSHIPTEAMINFO_TEMP;
            _loc5_ = new MSG_REQUEST_VIEWJUMPSHIPTEAM();
            _loc5_.ShipTeamId = _loc4_.ShipTeamId;
            _loc5_.Type = this.SelectedType;
            _loc5_.SeqId = GamePlayer.getInstance().seqID++;
            _loc5_.Guid = GamePlayer.getInstance().Guid;
            NetManager.Instance().sendObject(_loc5_);
         }
      }
      
      public function RespViewJumpShipTeam(param1:MSG_RESP_VIEWJUMPSHIPTEAM) : void
      {
         var _loc2_:MSG_RESP_JUMPSHIPTEAMINFO_TEMP = null;
         if(this.SelectedList == null)
         {
            return;
         }
         for each(_loc2_ in this.SelectedList)
         {
            if(_loc2_.ShipTeamId == param1.ShipTeamId)
            {
               TransforingUI_View.getInstance().ShowShipTeamInfo(param1,_loc2_.FromGalaxyId,DataWidget.localToDataZone(_loc2_.SpareTime),_loc2_.Type);
               return;
            }
         }
      }
      
      private function btn_backClick(param1:MouseEvent, param2:XButton) : void
      {
         var _loc4_:MSG_RESP_JUMPSHIPTEAMINFO_TEMP = null;
         var _loc5_:MSG_REQUEST_CANCELJUMPSHIPTEAM = null;
         var _loc6_:MSG_REQUEST_FROMRESOURCESTARTOHOME = null;
         var _loc7_:MSG_REQUEST_SHIPTEAMGOHOME = null;
         var _loc3_:int = param2.Data + this._curPage * this._pageSize;
         if(_loc3_ < this.SelectedList.length)
         {
            _loc4_ = this.SelectedList[_loc3_] as MSG_RESP_JUMPSHIPTEAMINFO_TEMP;
            if(this.SelectedType == 0)
            {
               _loc5_ = new MSG_REQUEST_CANCELJUMPSHIPTEAM();
               _loc5_.ShipTeamId = _loc4_.ShipTeamId;
               _loc5_.SeqId = GamePlayer.getInstance().seqID++;
               _loc5_.Guid = GamePlayer.getInstance().Guid;
               NetManager.Instance().sendObject(_loc5_);
               param2.setBtnDisabled(true);
            }
            else if(this.SelectedType == 4)
            {
               if(_loc4_.GalaxyType == GalaxyType.GT_3)
               {
                  _loc6_ = new MSG_REQUEST_FROMRESOURCESTARTOHOME();
                  _loc6_.GalaxyMapId = _loc4_.ToGalaxyMapId;
                  _loc6_.GalaxyId = _loc4_.ToGalaxyId;
                  _loc6_.ShipTeamId = _loc4_.ShipTeamId;
                  _loc6_.Guid = GamePlayer.getInstance().Guid;
                  _loc6_.SeqId = GamePlayer.getInstance().seqID++;
                  NetManager.Instance().sendObject(_loc6_);
               }
               else
               {
                  _loc7_ = new MSG_REQUEST_SHIPTEAMGOHOME();
                  _loc7_.ShipTeamId = _loc4_.ShipTeamId;
                  _loc7_.Guid = GamePlayer.getInstance().Guid;
                  _loc7_.SeqId = GamePlayer.getInstance().seqID++;
                  NetManager.Instance().sendObject(_loc7_);
               }
               this.RequestJumpShipTeamInfo();
            }
         }
      }
      
      private function frontPage() : void
      {
         --this._curPage;
         this.ShowCurPage();
         this.ResetPageButton();
      }
      
      private function nextPage() : void
      {
         this._curPage += 1;
         this.ShowCurPage();
         this.ResetPageButton();
      }
      
      private function ResetPageButton() : void
      {
         if(this._curPage == 0)
         {
            this.btn_front.setBtnDisabled(true);
         }
         else
         {
            this.btn_front.setBtnDisabled(false);
         }
         if(this._curPage + 1 >= this._lastPage)
         {
            this.btn_next.setBtnDisabled(true);
         }
         else
         {
            this.btn_next.setBtnDisabled(false);
         }
         (this._mc.getMC().getChildByName("tf_page") as TextField).text = this._curPage + 1 + "";
      }
      
      private function onButtonClick(param1:MouseEvent) : void
      {
         switch(param1.target.name)
         {
            case "btn_attack":
               this.ShowList(this.btn_attack,0,this._AttackList);
               break;
            case "btn_defense":
               this.ShowList(this.btn_defense,1,this._DefenseList);
               break;
            case "btn_add":
               this.ShowList(this.btn_add,2,this._AddList);
               break;
            case "btn_battle":
               this.ShowList(this.btn_battle,3,this._BattleList);
               break;
            case "btn_hold":
               this.ShowList(this.btn_hold,4,this._HoldList);
               break;
            case "btn_ally":
               this.freshMiniMap(this.iconDataArr);
               break;
            case "btn_enemy":
               this.freshMiniMap(this.iconDataArr);
               break;
            case "btn_airship":
               this.freshMiniMap(this.iconDataArr);
               break;
            case "btn_flyline":
               this.freshMiniMap(this.iconDataArr);
               break;
            case "btn_front":
               this.frontPage();
               break;
            case "btn_next":
               this.nextPage();
         }
      }
      
      private function onButtonOver(param1:MouseEvent) : void
      {
         var _loc2_:String = "";
         switch(param1.target.name)
         {
            case "btn_ally":
               _loc2_ = StringManager.getInstance().getMessageString("StarText34");
               break;
            case "btn_enemy":
               _loc2_ = StringManager.getInstance().getMessageString("StarText36");
               break;
            case "btn_airship":
               _loc2_ = StringManager.getInstance().getMessageString("StarText33");
               break;
            case "btn_flyline":
               _loc2_ = StringManager.getInstance().getMessageString("StarText35");
         }
         var _loc3_:Point = param1.target.localToGlobal(new Point());
         _loc3_.y -= param1.target.height;
         CustomTip.GetInstance().Show(_loc2_,_loc3_);
         param1.target.addEventListener(MouseEvent.MOUSE_OUT,this.onButtonOut);
      }
      
      private function onButtonOut(param1:MouseEvent) : void
      {
         CustomTip.GetInstance().Hide();
         param1.target.removeEventListener(MouseEvent.MOUSE_OUT,this.onButtonOut);
      }
      
      private function ShowList(param1:HButton, param2:int, param3:Array) : void
      {
         var _loc5_:Bitmap = null;
         var _loc6_:MovieClip = null;
         var _loc7_:MovieClip = null;
         if(this.SelectedButton != null)
         {
            this.SelectedButton.setSelect(false);
         }
         this.SelectedButton = param1;
         this.SelectedButton.setSelect(true);
         this.SelectedType = param2;
         this.SelectedList = param3;
         this._curPage = 0;
         this._lastPage = this.SelectedList.length / this._pageSize;
         if(this._lastPage * this._pageSize < this.SelectedList.length)
         {
            ++this._lastPage;
         }
         this.ShowCurPage();
         var _loc4_:int = 0;
         while(_loc4_ < 6)
         {
            if(this.SelectedType == 0)
            {
               _loc5_ = new Bitmap(GameKernel.getTextureInstance("Transition"));
            }
            else if(this.SelectedType == 1)
            {
               _loc5_ = new Bitmap(GameKernel.getTextureInstance("Enemy"));
            }
            else if(this.SelectedType == 2)
            {
               _loc5_ = new Bitmap(GameKernel.getTextureInstance("Transition"));
            }
            else if(this.SelectedType == 3)
            {
               _loc5_ = new Bitmap(GameKernel.getTextureInstance("Battlenow"));
            }
            else if(this.SelectedType == 4)
            {
               _loc5_ = new Bitmap(GameKernel.getTextureInstance("Defend"));
            }
            else if(this.SelectedType == 5)
            {
               _loc5_ = new Bitmap(GameKernel.getTextureInstance("Holdup"));
            }
            _loc6_ = this._mc.getMC().getChildByName("mc_list" + _loc4_) as MovieClip;
            _loc7_ = _loc6_.mc_base as MovieClip;
            if(_loc7_.numChildren > 0)
            {
               _loc7_.removeChildAt(0);
            }
            _loc5_.x = -10;
            _loc5_.y = -10;
            _loc7_.addChild(_loc5_);
            _loc4_++;
         }
      }
      
      private function onItemClick(param1:MouseEvent) : void
      {
         var _loc2_:int = parseInt(String(param1.target.parent.name).split("mc_list")[1],10);
         _loc2_ += this._curPage * this._pageSize;
      }
      
      private function tf_nameClick(param1:MouseEvent, param2:XTextField) : void
      {
         var _loc3_:int = this._curPage * this._pageSize + param2.Data;
         if(this.SelectedList == null || _loc3_ >= this.SelectedList.length)
         {
            return;
         }
         var _loc4_:MSG_RESP_JUMPSHIPTEAMINFO_TEMP = this.SelectedList[_loc3_] as MSG_RESP_JUMPSHIPTEAMINFO_TEMP;
         PlayerInfoPopUp.Module = true;
         if(this.SelectedType == 0)
         {
            ChatAction.getInstance().sendChatUserInfoMessage(_loc4_.ToGalaxyId,-1,3);
         }
         else if(this.SelectedType == 1)
         {
            ChatAction.getInstance().sendChatUserInfoMessage(_loc4_.FromGalaxyId,-1,3);
         }
         else if(this.SelectedType == 2)
         {
            ChatAction.getInstance().sendChatUserInfoMessage(_loc4_.FromGalaxyId,-1,3);
         }
         else if(this.SelectedType == 3)
         {
            ChatAction.getInstance().sendChatUserInfoMessage(_loc4_.ToGalaxyId,-1,3);
         }
         else
         {
            ChatAction.getInstance().sendChatUserInfoMessage(_loc4_.ToGalaxyId,-1,3);
         }
      }
   }
}

import flash.display.Sprite;
import flash.text.TextField;

class HHH
{
   
   public function HHH()
   {
      super();
   }
}

class Item extends Sprite
{
   
   private var _shipTeamId:int;
   
   private var _teamName:String;
   
   private var _shipNum:int;
   
   private var _jumpNeedTime:int;
   
   private var _commanderId:int;
   
   private var _bodyId:int;
   
   private var _gas:int;
   
   public var ShipTeamIdTxt:TextField = new TextField();
   
   public var TeamNameTxt:TextField = new TextField();
   
   public var ShipNumTxt:TextField = new TextField();
   
   public var JumpNeedTimeTxt:TextField = new TextField();
   
   public var CommanderIdTxt:TextField = new TextField();
   
   public var BodyIdTxt:TextField = new TextField();
   
   public var GasTxt:TextField = new TextField();
   
   public function Item()
   {
      super();
      this.graphics.lineStyle(1,16777215,1);
      this.graphics.beginFill(16777215,0.7);
      this.graphics.drawRoundRect(0,0,210,40,5,5);
      this.graphics.endFill();
      this.ShipTeamIdTxt.x = 0;
      this.ShipTeamIdTxt.text = "TeamID:";
      this.ShipTeamIdTxt.mouseEnabled = false;
      addChild(this.ShipTeamIdTxt);
      this.TeamNameTxt.x = 70;
      this.TeamNameTxt.y = 0;
      this.TeamNameTxt.text = "Name:";
      this.TeamNameTxt.mouseEnabled = false;
      addChild(this.TeamNameTxt);
      this.JumpNeedTimeTxt.x = 140;
      this.JumpNeedTimeTxt.text = "Time:";
      this.JumpNeedTimeTxt.mouseEnabled = false;
      addChild(this.JumpNeedTimeTxt);
      this.CommanderIdTxt.x = 0;
      this.CommanderIdTxt.y = 20;
      this.CommanderIdTxt.text = "CID:";
      this.CommanderIdTxt.mouseEnabled = false;
      addChild(this.CommanderIdTxt);
      this.BodyIdTxt.x = 70;
      this.BodyIdTxt.y = 20;
      this.BodyIdTxt.text = "BID:";
      this.BodyIdTxt.mouseEnabled = false;
      addChild(this.BodyIdTxt);
   }
   
   public function get shipTeamId() : int
   {
      return this._shipTeamId;
   }
   
   public function set shipTeamId(param1:int) : void
   {
      this._shipTeamId = param1;
      this.ShipTeamIdTxt.text = "STId:" + this._shipTeamId;
   }
   
   public function get teamName() : String
   {
      return this._teamName;
   }
   
   public function set teamName(param1:String) : void
   {
      this._teamName = param1;
      this.TeamNameTxt.text = "GoTo:" + this._teamName;
   }
   
   public function get shipNum() : int
   {
      return this._shipNum;
   }
   
   public function set shipNum(param1:int) : void
   {
      this._shipNum = param1;
      this.ShipNumTxt.text = "ShipNum" + this._shipNum;
   }
   
   public function get jumpNeedTime() : int
   {
      return this._jumpNeedTime;
   }
   
   public function set jumpNeedTime(param1:int) : void
   {
      this._jumpNeedTime = param1;
      this.JumpNeedTimeTxt.text = "Time:" + this._jumpNeedTime;
   }
   
   public function get commanderId() : int
   {
      return this._commanderId;
   }
   
   public function set commanderId(param1:int) : void
   {
      this._commanderId = param1;
      this.CommanderIdTxt.text = "CId:" + this._commanderId;
   }
   
   public function get bodyId() : int
   {
      return this._bodyId;
   }
   
   public function set bodyId(param1:int) : void
   {
      this._bodyId = param1;
      this.BodyIdTxt.text = "BId:" + this._bodyId;
   }
   
   public function get gas() : int
   {
      return this._gas;
   }
   
   public function set gas(param1:int) : void
   {
      this._gas = param1;
      this.GasTxt.text = "Gas:" + this._gas;
   }
}
