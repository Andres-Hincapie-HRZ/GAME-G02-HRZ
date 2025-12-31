package logic.ui
{
   import com.star.frameworks.geom.CFilter;
   import com.star.frameworks.managers.ResManager;
   import com.star.frameworks.managers.StringManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import logic.action.GalaxyMapAction;
   import logic.entry.GShipTeam;
   import logic.entry.GStar;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.HButtonType;
   import logic.entry.MObject;
   import logic.game.GameKernel;
   import logic.manager.FightManager;
   import logic.manager.GalaxyManager;
   import logic.manager.GalaxyShipManager;
   import logic.utils.UpdateResource;
   import logic.widget.DataWidget;
   import net.base.NetManager;
   import net.msg.fightMsg.MSG_REQUEST_ECTYPE;
   import net.msg.fightMsg.MSG_REQUEST_WARFIELD_STATUS;
   import net.msg.fightMsg.MSG_RESP_WARFIELD_PLAYERLIST;
   import net.msg.fightMsg.MSG_RESP_WARFIELD_STATUS;
   import net.msg.ship.MSG_RESP_JUMPGALAXYSHIP_TEMP;
   
   public class BattlefieldUI extends AbstractPopUp
   {
      
      private static var instance:BattlefieldUI;
      
      private var ShipShowList:Array;
      
      private var btn_left:HButton;
      
      private var btn_right:HButton;
      
      private var FleetPageId:int;
      
      private var FleetPageCount:int;
      
      private var tf_selectednum:TextField;
      
      private const FleetMaxItem:int = 4;
      
      private const MaxFleet:int = 8;
      
      private var SelectedFleetList:Array;
      
      private var SelfBallfield:int;
      
      private var filterList:Array;
      
      private var SelectedStar:XMovieClip;
      
      private var btn_register:HButton;
      
      private var btn_cancel:HButton;
      
      private var btn_view:HButton;
      
      private var SelectedStarId:int;
      
      private var PopBtn:Sprite;
      
      private var _StatusMsg:MSG_RESP_WARFIELD_STATUS;
      
      private var FieldList:Array;
      
      private var txt_num:TextField;
      
      private var ViewRoomId:int = -1;
      
      private var BattlePropsId:int = 4424;
      
      private var txt_time:TextField;
      
      private var txt_BattleName:TextField;
      
      private var FilterArray:Array;
      
      private var SelfeLevel:int;
      
      private var ii:int = 0;
      
      private var mc_help:MovieClip;
      
      private var ViewButtonId:int;
      
      private var MemberUI:BattleMemberUI;
      
      private var aDayTime:int = 86400;
      
      private var aWeekTime:int = this.aDayTime * 7;
      
      private var BattleType:int;
      
      private var CountDownTimer:Timer;
      
      private var LTime:int;
      
      private var LastTime:uint;
      
      private var txt_titletime:TextField;
      
      private var BattleEndTime:int;
      
      private var InBattle:Boolean;
      
      private var MaxUserNum:int;
      
      public function BattlefieldUI()
      {
         super();
         setPopUpName("BattlefieldUI");
      }
      
      public static function getInstance() : BattlefieldUI
      {
         if(instance == null)
         {
            instance = new BattlefieldUI();
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
         this._mc = new MObject("BattleScenemc",385,300);
         this.initMcElement();
         this.Clear();
         GameKernel.popUpDisplayManager.Regisger(instance);
      }
      
      override public function initMcElement() : void
      {
         var _loc4_:HButton = null;
         var _loc5_:MovieClip = null;
         var _loc6_:int = 0;
         var _loc7_:XMovieClip = null;
         var _loc8_:MovieClip = null;
         var _loc9_:XButton = null;
         var _loc1_:CFilter = new CFilter();
         _loc1_.generate_colorMatrix_filter();
         this.FilterArray = _loc1_.getFilter(true);
         this.CountDownTimer = new Timer(1000);
         this.CountDownTimer.addEventListener(TimerEvent.TIMER,this.OnTimer);
         this.PopBtn = new Sprite();
         var _loc2_:HButton = new HButton(GameKernel.getMovieClipInstance("viewbtn"));
         _loc2_.m_movie.stop();
         _loc2_.m_movie.addEventListener(MouseEvent.CLICK,this.viewbtnClick);
         this.PopBtn.addChild(_loc2_.m_movie);
         var _loc3_:HButton = new HButton(GameKernel.getMovieClipInstance("members"));
         _loc3_.m_movie.stop();
         _loc3_.m_movie.addEventListener(MouseEvent.CLICK,this.MembersClick);
         _loc3_.m_movie.y = _loc2_.m_movie.height;
         this.PopBtn.addChild(_loc3_.m_movie);
         _loc5_ = this._mc.getMC().getChildByName("btn_close") as MovieClip;
         _loc4_ = new HButton(_loc5_);
         _loc5_.addEventListener(MouseEvent.CLICK,this.CloseClick);
         _loc5_ = this._mc.getMC().getChildByName("btn_help") as MovieClip;
         _loc4_ = new HButton(_loc5_);
         _loc5_.addEventListener(MouseEvent.CLICK,this.btn_helpClick);
         this.mc_help = this._mc.getMC().getChildByName("mc_help") as MovieClip;
         this.mc_help.addEventListener(MouseEvent.CLICK,this.btn_helpClick);
         this.mc_help.visible = false;
         _loc5_ = this._mc.getMC().getChildByName("btn_register") as MovieClip;
         this.btn_register = new HButton(_loc5_);
         _loc5_.addEventListener(MouseEvent.CLICK,this.btn_registerClick);
         _loc5_ = this._mc.getMC().getChildByName("btn_cancel") as MovieClip;
         this.btn_cancel = new HButton(_loc5_);
         _loc5_.addEventListener(MouseEvent.CLICK,this.btn_cancel_regClick);
         _loc5_ = this._mc.getMC().getChildByName("btn_view") as MovieClip;
         this.btn_view = new HButton(_loc5_);
         _loc5_.addEventListener(MouseEvent.CLICK,this.btn_viewClick);
         _loc5_ = this._mc.getMC().getChildByName("btn_addfleet") as MovieClip;
         _loc4_ = new HButton(_loc5_);
         _loc5_.addEventListener(MouseEvent.CLICK,this.btn_addfleetClick);
         _loc5_ = this._mc.getMC().getChildByName("btn_ranking") as MovieClip;
         _loc4_ = new HButton(_loc5_);
         _loc5_.addEventListener(MouseEvent.CLICK,this.btn_rankingClick);
         _loc5_ = this._mc.getMC().getChildByName("btn_mall") as MovieClip;
         _loc4_ = new HButton(_loc5_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("Boss170"));
         _loc5_.addEventListener(MouseEvent.CLICK,this.btn_mallClick);
         this.txt_num = this._mc.getMC().getChildByName("txt_num") as TextField;
         this.txt_time = this._mc.getMC().getChildByName("txt_time") as TextField;
         this.txt_titletime = this._mc.getMC().getChildByName("txt_titletime") as TextField;
         this.FieldList = new Array();
         _loc6_ = 0;
         while(_loc6_ < 999)
         {
            if(this._mc.getMC().getChildByName("mc_" + _loc6_) == null)
            {
               break;
            }
            _loc5_ = this._mc.getMC().getChildByName("mc_" + _loc6_) as MovieClip;
            _loc5_.buttonMode = true;
            _loc7_ = new XMovieClip(_loc5_);
            _loc7_.OnClick = this.StarClick;
            _loc7_.OnMouseOver = this.StarOver;
            _loc7_.Data = _loc6_;
            _loc5_.addEventListener(MouseEvent.MOUSE_OUT,this.StarOut);
            this.FieldList.push(_loc5_);
            _loc6_++;
         }
         _loc5_ = this._mc.getMC().getChildByName("btn_left") as MovieClip;
         this.btn_left = new HButton(_loc5_);
         _loc5_.addEventListener(MouseEvent.CLICK,this.btn_leftClick);
         _loc5_ = this._mc.getMC().getChildByName("btn_right") as MovieClip;
         this.btn_right = new HButton(_loc5_);
         _loc5_.addEventListener(MouseEvent.CLICK,this.btn_rightClick);
         this.tf_selectednum = this._mc.getMC().getChildByName("tf_selectednum") as TextField;
         this.ShipShowList = new Array();
         _loc6_ = 0;
         while(_loc6_ < this.FleetMaxItem)
         {
            _loc8_ = this._mc.getMC().getChildByName("mc_list" + _loc6_) as MovieClip;
            _loc8_.visible = false;
            this.ShipShowList.push(_loc8_);
            _loc5_ = _loc8_.getChildByName("btn_cancel") as MovieClip;
            _loc9_ = new XButton(_loc5_);
            _loc9_.Data = _loc6_;
            _loc9_.OnClick = this.btn_cancelClick;
            _loc6_++;
         }
         this.SelectedFleetList = new Array();
         this.SelfBallfield = -2;
         this.filterList = new Array(new GlowFilter(51711,0.5));
         this.RequstStatus(0,0);
         this.txt_BattleName = TextField(this._mc.getMC().btn_rules.txt_name);
         this.MemberUI = new BattleMemberUI();
         this.MemberUI.Init();
      }
      
      private function MembersClick(param1:MouseEvent) : void
      {
         this.RequstStatus(6,this.ViewButtonId);
         if(this.PopBtn.parent)
         {
            this.PopBtn.parent.removeChild(this.PopBtn);
         }
      }
      
      private function btn_helpClick(param1:MouseEvent) : void
      {
         this.mc_help.visible = !this.mc_help.visible;
      }
      
      private function OnTimer(param1:TimerEvent) : void
      {
         if(this.LastTime == 0)
         {
            this.LastTime = getTimer();
         }
         var _loc2_:int = getTimer() - this.LastTime;
         var _loc3_:int = _loc2_ / 1000;
         this.LastTime = getTimer() - _loc2_ % 1000;
         this.LTime -= _loc3_;
         if(this.LTime <= 0)
         {
            this.LTime = 0;
            this.RefreshTime();
         }
         this.txt_time.text = DataWidget.secondFormatToTime(this.LTime);
      }
      
      private function btn_viewClick(param1:MouseEvent) : void
      {
         this.ViewRoomId = this.SelfBallfield;
         this.RequstStatus(2,this.SelfBallfield);
      }
      
      private function btn_cancel_regClick(param1:MouseEvent) : void
      {
         this.RequstStatus(1,0);
      }
      
      private function btn_rightClick(param1:MouseEvent) : void
      {
         ++this.FleetPageId;
         this.ShowFleetList();
      }
      
      private function btn_leftClick(param1:MouseEvent) : void
      {
         --this.FleetPageId;
         this.ShowFleetList();
      }
      
      private function ShowFleetList() : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:MSG_RESP_JUMPGALAXYSHIP_TEMP = null;
         var _loc5_:MovieClip = null;
         var _loc6_:MovieClip = null;
         this.ResetFleetPageButton();
         var _loc1_:int = this.FleetPageId * this.FleetMaxItem;
         var _loc2_:int = 0;
         for(; _loc2_ < this.FleetMaxItem; _loc2_++)
         {
            _loc3_ = this.ShipShowList[_loc2_];
            if(_loc1_ < this.SelectedFleetList.length)
            {
               _loc3_.visible = true;
               if(!this.SelectedFleetList[_loc1_])
               {
                  continue;
               }
               _loc4_ = this.SelectedFleetList[_loc1_][1] as MSG_RESP_JUMPGALAXYSHIP_TEMP;
               if(!_loc4_)
               {
                  continue;
               }
               _loc5_ = MovieClip(_loc3_.mc_commanderbase);
               if(_loc5_.numChildren > 1)
               {
                  _loc5_.removeChildAt(1);
               }
               _loc5_.addChild(CommanderSceneUI.getInstance().CommanderImg(_loc4_.CommanderId));
               _loc6_ = MovieClip(_loc3_.mc_fleetbase);
               if(_loc6_.numChildren > 1)
               {
                  _loc6_.removeChildAt(1);
               }
               _loc6_.addChild(GalaxyShipManager.instance.getShipImg(_loc4_.BodyId));
               TextField(_loc3_.tf_fleetname).text = "" + _loc4_.TeamName;
               TextField(_loc3_.tf_fleetnum).text = "" + _loc4_.ShipNum;
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc1_++;
         }
      }
      
      private function ResetFleetPageButton() : void
      {
         this.btn_left.setBtnDisabled(this.FleetPageId <= 0);
         this.btn_right.setBtnDisabled(this.FleetPageId + 1 >= this.FleetPageCount);
         if(this.FleetPageCount == 0)
         {
            this.tf_selectednum.text = "0/0";
         }
         else
         {
            this.tf_selectednum.text = this.FleetPageId + 1 + "/" + this.FleetPageCount;
         }
      }
      
      public function receiveData(param1:Array) : void
      {
         var _loc3_:* = undefined;
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = param1[_loc2_];
            _loc4_ = false;
            _loc5_ = 0;
            while(_loc5_ < this.SelectedFleetList.length)
            {
               if(_loc3_[0] == this.SelectedFleetList[_loc5_][0])
               {
                  _loc4_ = true;
                  break;
               }
               _loc5_++;
            }
            if(!_loc4_)
            {
               if(this.SelectedFleetList.length >= this.MaxFleet)
               {
                  _loc6_ = StringManager.getInstance().getMessageString("Boss143");
                  _loc6_ = _loc6_.replace("@@1",this.MaxFleet);
                  MessagePopup.getInstance().Show(_loc6_,0);
                  break;
               }
               this.SelectedFleetList.push(_loc3_);
            }
            _loc2_++;
         }
         this.FleetPageCount = Math.ceil(this.SelectedFleetList.length / this.FleetMaxItem);
         this.ShowFleetList();
      }
      
      private function GetTodyXML() : int
      {
         var _loc5_:XML = null;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc8_:Array = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         this.InBattle = false;
         var _loc1_:int = this.aWeekTime;
         var _loc2_:XML = GameKernel.resManager.getXml(ResManager.GAMERES,"Others");
         _loc2_ = _loc2_.List[5] as XML;
         var _loc3_:XMLList = _loc2_.children();
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length())
         {
            _loc5_ = _loc3_[_loc4_];
            _loc6_ = GamePlayer.getInstance().ServerDate.toString();
            _loc7_ = GamePlayer.getInstance().ServerDate.getDay() * this.aDayTime + GamePlayer.getInstance().ServerDate.getHours() * 3600 + GamePlayer.getInstance().ServerDate.getMinutes() * 60 + GamePlayer.getInstance().ServerDate.getSeconds();
            this.MaxUserNum = parseInt(_loc5_.@MaxUser);
            _loc8_ = String(_loc5_.@BeginTime).split(":");
            _loc9_ = parseInt(_loc5_.@BeginDay) * this.aDayTime + (parseInt(_loc8_[0]) * 3600 + parseInt(_loc8_[1]) * 60 + parseInt(_loc8_[2]));
            _loc8_ = String(_loc5_.@EndTime).split(":");
            _loc10_ = parseInt(_loc5_.@EndDay) * this.aDayTime + (parseInt(_loc8_[0]) * 3600 + parseInt(_loc8_[1]) * 60 + parseInt(_loc8_[2]));
            _loc8_ = String(_loc5_.@BattleEndTime).split(":");
            _loc11_ = parseInt(_loc5_.@BattleEndDay) * this.aDayTime + (parseInt(_loc8_[0]) * 3600 + parseInt(_loc8_[1]) * 60 + parseInt(_loc8_[2]));
            if(_loc10_ < _loc9_ && (_loc7_ <= _loc10_ || _loc7_ >= _loc9_))
            {
               _loc12_ = _loc10_ - _loc7_;
               if(_loc12_ < 0)
               {
                  _loc12_ += this.aWeekTime;
               }
               this.BattleType = _loc5_.@Type;
               return _loc12_;
            }
            if(_loc7_ >= _loc9_ && _loc7_ <= _loc10_)
            {
               this.BattleType = _loc5_.@Type;
               return _loc10_ - _loc7_;
            }
            if(_loc11_ < _loc10_ && (_loc7_ <= _loc11_ || _loc7_ >= _loc10_))
            {
               this.InBattle = true;
               _loc12_ = _loc11_ - _loc7_;
               if(_loc12_ < 0)
               {
                  _loc12_ += this.aWeekTime;
               }
               this.BattleType = _loc5_.@Type;
               return _loc12_;
            }
            if(_loc7_ >= _loc10_ && _loc7_ <= _loc11_)
            {
               this.InBattle = true;
               this.BattleType = _loc5_.@Type;
               return _loc11_ - _loc7_;
            }
            this.BattleType = 0;
            _loc13_ = _loc9_ - _loc7_;
            if(_loc13_ < 0)
            {
               _loc13_ += this.aWeekTime;
            }
            if(_loc13_ < _loc1_)
            {
               _loc1_ = _loc13_;
            }
            _loc4_++;
         }
         return -_loc1_;
      }
      
      private function Clear() : void
      {
         if(this._mc.getMC().contains(this.MemberUI.MemberList))
         {
            this._mc.getMC().removeChild(this.MemberUI.MemberList);
         }
         this.RefreshTime();
         if(this.SelfBallfield == -2)
         {
            this.SelectedFleetList.splice(0);
         }
         this.FleetPageId = 0;
         this.FleetPageCount = Math.ceil(this.SelectedFleetList.length / this.FleetMaxItem);
         this.ShowFleetList();
      }
      
      private function RefreshTime() : void
      {
         var _loc2_:MovieClip = null;
         this.LTime = this.GetTodyXML();
         this.LastTime = 0;
         this.txt_time.text = DataWidget.secondFormatToTime(Math.abs(this.LTime));
         this.CountDownTimer.start();
         if(this.LTime > 0)
         {
            if(this.InBattle)
            {
               this.txt_titletime.text = StringManager.getInstance().getMessageString("Boss162");
            }
            else
            {
               this.txt_titletime.text = StringManager.getInstance().getMessageString("Boss156");
            }
         }
         else
         {
            this.txt_titletime.text = StringManager.getInstance().getMessageString("Boss157");
         }
         if(this.BattleType == 1)
         {
            this.txt_BattleName.text = StringManager.getInstance().getMessageString("Boss160");
         }
         else if(this.BattleType == 2)
         {
            this.txt_BattleName.text = StringManager.getInstance().getMessageString("Boss161");
         }
         else
         {
            this.txt_BattleName.text = StringManager.getInstance().getMessageString("Boss164");
         }
         this.LTime = Math.abs(this.LTime);
         var _loc1_:int = 0;
         while(_loc1_ < this.FieldList.length)
         {
            _loc2_ = this.FieldList[_loc1_];
            _loc2_.filters = this.FilterArray;
            _loc1_++;
         }
         if(this._StatusMsg != null)
         {
            this.RestStatusMsg(this._StatusMsg);
         }
      }
      
      private function RequstStatus(param1:int, param2:int) : void
      {
         var _loc3_:MSG_REQUEST_WARFIELD_STATUS = new MSG_REQUEST_WARFIELD_STATUS();
         _loc3_.SeqId = GamePlayer.getInstance().seqID++;
         _loc3_.Guid = GamePlayer.getInstance().Guid;
         _loc3_.Request = param1;
         _loc3_.RoomID = param2;
         NetManager.Instance().sendObject(_loc3_);
      }
      
      public function RestStatusMsg(param1:MSG_RESP_WARFIELD_STATUS) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = 0;
         if(param1.MatchLevel != -1)
         {
            this.SelfeLevel = param1.MatchLevel;
         }
         this._StatusMsg = param1;
         if(param1.Status == -1)
         {
            this.SelfBallfield = param1.Status;
            this.SetMainButton(true,false,false);
         }
         else if(param1.Status == -2)
         {
            this.SelfBallfield = param1.Status;
            this.SetMainButton(false,true,false);
         }
         else if(param1.Status >= 0)
         {
            this.SelfBallfield = param1.Status;
            this.SetMainButton(false,false,true);
         }
         if(param1.Warfield != -1)
         {
            _loc2_ = 0;
            while(_loc2_ < this.FieldList.length)
            {
               _loc3_ = param1.Warfield;
               _loc3_ = _loc3_ >> _loc2_ & 1;
               if(this.ViewRoomId == _loc2_ && _loc3_ == 0)
               {
                  this.ViewRoomId = -1;
               }
               if(_loc2_ == 0)
               {
                  MovieClip(this.FieldList[_loc2_]).gotoAndStop(_loc3_ + 1);
                  if(_loc3_)
                  {
                     Sprite(this.FieldList[_loc2_]).filters = null;
                  }
               }
               else if(_loc3_ == 1)
               {
                  Sprite(this.FieldList[_loc2_]).filters = null;
                  if(this.SelfBallfield == _loc2_)
                  {
                     Sprite(this.FieldList[_loc2_].mc_self).visible = true;
                     Sprite(this.FieldList[_loc2_].mc_other).visible = false;
                  }
                  else
                  {
                     Sprite(this.FieldList[_loc2_].mc_self).visible = false;
                     Sprite(this.FieldList[_loc2_].mc_other).visible = true;
                  }
               }
               else
               {
                  Sprite(this.FieldList[_loc2_].mc_self).visible = false;
                  Sprite(this.FieldList[_loc2_].mc_other).visible = false;
                  Sprite(this.FieldList[_loc2_]).filters = this.FilterArray;
               }
               _loc2_++;
            }
         }
         this.txt_num.text = param1.UserNumber.toString();
      }
      
      private function SetMainButton(param1:Boolean, param2:Boolean, param3:Boolean) : void
      {
         this.btn_cancel.setVisible(param1);
         this.btn_register.setVisible(param2);
         this.btn_view.setVisible(param3);
      }
      
      private function StarOut(param1:MouseEvent) : void
      {
         if(this.SelectedStar == null)
         {
            return;
         }
         this.SelectedStar.m_movie.filters = null;
         this.SelectedStar = null;
      }
      
      private function StarClick(param1:MouseEvent, param2:XMovieClip) : void
      {
         if(this._StatusMsg == null)
         {
            return;
         }
         if(this._StatusMsg.Warfield == -1)
         {
            return;
         }
         var _loc3_:* = this._StatusMsg.Warfield;
         _loc3_ = _loc3_ >> param2.Data & 1;
         if(_loc3_ == 0)
         {
            return;
         }
         var _loc4_:Sprite = param2.m_movie.parent as Sprite;
         var _loc5_:Point = new Point(param1.stageX,param1.stageY);
         _loc5_ = _loc4_.globalToLocal(_loc5_);
         this.PopBtn.x = _loc5_.x - this.PopBtn.width / 2;
         this.PopBtn.y = _loc5_.y - this.PopBtn.height / 2;
         _loc4_.addChild(this.PopBtn);
         this.ViewButtonId = this.SelectedStarId;
      }
      
      private function viewbtnOut(param1:MouseEvent) : void
      {
         if(this.PopBtn.parent)
         {
            this.PopBtn.parent.removeChild(this.PopBtn);
         }
      }
      
      private function viewbtnClick(param1:MouseEvent) : void
      {
         this.ViewRoomId = this.ViewButtonId;
         this.RequstStatus(2,this.ViewRoomId);
         if(this.PopBtn.parent)
         {
            this.PopBtn.parent.removeChild(this.PopBtn);
         }
      }
      
      private function StarOver(param1:Event, param2:XMovieClip) : void
      {
         if(this._StatusMsg.Warfield == -1)
         {
            return;
         }
         var _loc3_:* = this._StatusMsg.Warfield;
         _loc3_ = _loc3_ >> param2.Data & 1;
         if(_loc3_ == 0)
         {
            return;
         }
         this.SelectedStarId = param2.Data;
         this.SelectedStar = param2;
         param2.m_movie.filters = this.filterList;
      }
      
      private function btn_mallClick(param1:MouseEvent) : void
      {
         GameKernel.popUpDisplayManager.Hide(this);
         BattleMall.getInstance().Init();
         GameKernel.popUpDisplayManager.Show(BattleMall.getInstance());
      }
      
      private function btn_rankingClick(param1:MouseEvent) : void
      {
         GameKernel.popUpDisplayManager.Hide(this);
         RankingSceneUI.getInstance().ShowBattleRank();
      }
      
      private function btn_addfleetClick(param1:MouseEvent) : void
      {
         if(this.SelfBallfield != -2)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss152"),0);
            return;
         }
         var _loc2_:GStar = GalaxyMapAction.instance.curStar;
         ShipTransferUI.instance.RequestJumpShips(_loc2_.GalaxyId,_loc2_.GalaxyMapId,3,5,this.MaxFleet);
      }
      
      private function btn_cancelClick(param1:Event, param2:XButton) : void
      {
         if(this.SelfBallfield != -2)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss152"),0);
            return;
         }
         var _loc3_:int = this.FleetPageId * this.FleetMaxItem + param2.Data;
         if(_loc3_ >= this.SelectedFleetList.length)
         {
            return;
         }
         this.SelectedFleetList.splice(_loc3_,1);
         this.FleetPageCount = Math.ceil(this.SelectedFleetList.length / this.FleetMaxItem);
         if(this.FleetPageCount < 0)
         {
            this.FleetPageId = 0;
         }
         this.ShowFleetList();
      }
      
      private function RegisterWithCredit() : void
      {
         if(GamePlayer.getInstance().cash < 100)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("AuctionText31"),0);
            return;
         }
         GamePlayer.getInstance().cash = GamePlayer.getInstance().cash - 100;
         ResPlaneUI.getInstance().updateResPlane();
         this.Register();
      }
      
      private function Register() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:GShipTeam = null;
         if(this.SelectedFleetList.length <= 0)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss127"),0);
            return;
         }
         var _loc1_:MSG_REQUEST_ECTYPE = new MSG_REQUEST_ECTYPE();
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         _loc1_.Activity = 2;
         _loc2_ = int(this.SelectedFleetList.length);
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_)
         {
            _loc3_ = int(this.SelectedFleetList[_loc5_][0]);
            _loc4_ = GalaxyShipManager.instance.getShipDatas(_loc3_);
            _loc1_.ShipTeamId[_loc5_] = _loc3_;
            _loc5_++;
         }
         _loc1_.DataLen = _loc2_;
         NetManager.Instance().sendObject(_loc1_);
         if(this.BattleType == 2)
         {
            UpdateResource.getInstance().DeleteProps(this.BattlePropsId,1,1);
         }
      }
      
      private function btn_registerClick(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         if(this.InBattle)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss163"),0);
            return;
         }
         var _loc2_:int = this.GetTodyXML();
         if(_loc2_ < 0)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss165"),0);
            return;
         }
         if(this.SelectedFleetList.length <= 0)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss127"),0);
            return;
         }
         if(this.MaxUserNum > 0 && this._StatusMsg.UserNumber >= this.MaxUserNum)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss172"),0);
            return;
         }
         if(this.BattleType == 2)
         {
            _loc3_ = UpdateResource.getInstance().GetPropsNum(this.BattlePropsId);
            if(_loc3_ <= 0)
            {
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss153"),0);
               return;
            }
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss154"),2,this.Register);
            return;
         }
         if(this.SelfeLevel < 4)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss166"),2,this.RegisterWithCredit);
            return;
         }
         this.Register();
      }
      
      private function CloseClick(param1:Event) : void
      {
         this.CountDownTimer.stop();
         GameKernel.popUpDisplayManager.Hide(this);
      }
      
      public function LeaveView() : void
      {
         if(this.ViewRoomId == -1)
         {
            return;
         }
         this.RequstStatus(3,this.ViewRoomId);
         FightManager.instance.CleanFight();
         GalaxyManager.instance.sendRequestGalaxy();
         this.ViewRoomId = -1;
      }
      
      public function RespMemberList(param1:MSG_RESP_WARFIELD_PLAYERLIST) : void
      {
         this.MemberUI.RespMemberList(param1);
         if(!this._mc.getMC().contains(this.MemberUI.MemberList))
         {
            this._mc.getMC().addChild(this.MemberUI.MemberList);
         }
      }
   }
}

