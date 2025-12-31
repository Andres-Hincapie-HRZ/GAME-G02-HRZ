package logic.ui
{
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.managers.FontManager;
   import com.star.frameworks.managers.StringManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.system.System;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import logic.action.ChatAction;
   import logic.action.GalaxyMapAction;
   import logic.entry.GShipTeam;
   import logic.entry.GStar;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.HButtonType;
   import logic.entry.MObject;
   import logic.entry.props.propsInfo;
   import logic.game.GameKernel;
   import logic.manager.FightManager;
   import logic.manager.GalaxyManager;
   import logic.manager.GalaxyShipManager;
   import logic.reader.CPropsReader;
   import logic.utils.UpdateResource;
   import logic.widget.DataWidget;
   import net.base.NetManager;
   import net.common.MsgTypes;
   import net.msg.RaidProps.MSG_REQUEST_CAPTURE_STATE;
   import net.msg.RaidProps.MSG_RESP_CAPTURE_ARK_INFO;
   import net.msg.RaidProps.MSG_RESP_CAPTURE_ARK_LIST;
   import net.msg.RaidProps.MSG_RESP_CAPTURE_ARK_ROOM;
   import net.msg.RaidProps.MSG_RESP_CAPTURE_ARK_TMP;
   import net.msg.RaidProps.MSG_RESP_CAPTURE_BULLETIN;
   import net.msg.fightMsg.MSG_REQUEST_ECTYPE;
   import net.msg.ship.MSG_REQUEST_JUMPGALAXYSHIP;
   import net.msg.ship.MSG_RESP_JUMPGALAXYSHIP_TEMP;
   
   public class RaidProps extends AbstractPopUp
   {
      
      private static var instance:RaidProps;
      
      private var btn_addfleet:HButton;
      
      private var btn_search:HButton;
      
      private var btn_first:HButton;
      
      private var btn_prev:HButton;
      
      private var btn_next:HButton;
      
      private var btn_last:HButton;
      
      private var btn_refresh:HButton;
      
      private var btn_left:HButton;
      
      private var btn_right:HButton;
      
      private var ShipShowList:Array;
      
      private var txt_input:XTextField;
      
      private var tf_page:TextField;
      
      private var txt_f0:TextField;
      
      private var txt_f1:TextField;
      
      private var txt_f2:TextField;
      
      private var tf_selectednum:TextField;
      
      private var RoomList:Array;
      
      private var ShipListMsg:MSG_REQUEST_JUMPGALAXYSHIP;
      
      private var SelectedFleetList:Array;
      
      private var FleetPageId:int;
      
      private var FleetPageCount:int;
      
      private const FleetMaxItem:int = 2;
      
      private var RoomPageId:int;
      
      private var RoomPageCount:int;
      
      private var RoomListMsg:MSG_RESP_CAPTURE_ARK_LIST;
      
      private const RoomMaxItem:int = 6;
      
      private var SelfRommMsg:MSG_RESP_CAPTURE_ARK_INFO;
      
      private var SelfRoomStatus:int = 0;
      
      private var SelectedRoomId:int;
      
      private var SelectedStatus:int;
      
      private var SelectedPropsId:int = -1;
      
      private var SelectedPropsLock:int = 1;
      
      private var CountDownTimer:Timer;
      
      private var NextFunction:Function;
      
      private var SelectedButton:XButton;
      
      private var ViewRoomId:int = -1;
      
      private var tf_notice:Object;
      
      private var txt_time:TextField;
      
      private var _PropsTip:MovieClip;
      
      private var MaxShip:int;
      
      private var SearchNum:int;
      
      private var SearchCount:int;
      
      private var CaptureNum:int;
      
      private var CaptureCount:int;
      
      private var LastTime:uint;
      
      public function RaidProps()
      {
         super();
         setPopUpName("RaidProps");
      }
      
      public static function getInstance() : RaidProps
      {
         if(instance == null)
         {
            instance = new RaidProps();
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
         this._mc = new MObject("LuckyScene",385,300);
         this.initMcElement();
         this.Clear();
         GameKernel.popUpDisplayManager.Regisger(instance);
      }
      
      override public function initMcElement() : void
      {
         var _loc1_:HButton = null;
         var _loc2_:MovieClip = null;
         var _loc7_:MovieClip = null;
         var _loc8_:MovieClip = null;
         var _loc9_:Sprite = null;
         var _loc10_:XButton = null;
         var _loc11_:XMovieClip = null;
         var _loc12_:Sprite = null;
         this.CountDownTimer = new Timer(1000);
         this.CountDownTimer.addEventListener(TimerEvent.TIMER,this.OnTimer);
         this.RequestRoomStatus(0);
         _loc2_ = this._mc.getMC().getChildByName("btn_close") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.CloseClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_addfleet") as MovieClip;
         this.btn_addfleet = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_addfleetClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_search") as MovieClip;
         this.btn_search = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_searchClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_first") as MovieClip;
         this.btn_first = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_firstClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_prev") as MovieClip;
         this.btn_prev = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_prevClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_next") as MovieClip;
         this.btn_next = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_nextClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_last") as MovieClip;
         this.btn_last = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_lastClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_left") as MovieClip;
         this.btn_left = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_leftClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_right") as MovieClip;
         this.btn_right = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_rightClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_help") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_helpClick);
         Sprite(this._mc.getMC().getChildByName("mc_help")).addEventListener(MouseEvent.CLICK,this.btn_helpClick);
         Sprite(this._mc.getMC().getChildByName("mc_help")).visible = false;
         this.ShipShowList = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < 2)
         {
            _loc7_ = this._mc.getMC().getChildByName("mc_list" + _loc3_) as MovieClip;
            _loc7_.visible = false;
            this.ShipShowList.push(_loc7_);
            _loc2_ = _loc7_.getChildByName("btn_cancel") as MovieClip;
            _loc10_ = new XButton(_loc2_);
            _loc10_.Data = _loc3_;
            _loc10_.OnClick = this.btn_cancelClick;
            _loc3_++;
         }
         var _loc4_:TextField = this._mc.getMC().getChildByName("txt_input") as TextField;
         this.txt_input = new XTextField(_loc4_,_loc4_.text);
         _loc4_.restrict = "0-9";
         this.txt_time = this._mc.getMC().getChildByName("txt_time") as TextField;
         this.tf_page = this._mc.getMC().getChildByName("tf_page") as TextField;
         this.txt_f0 = this._mc.getMC().getChildByName("txt_tf0") as TextField;
         this.txt_f1 = this._mc.getMC().getChildByName("txt_tf1") as TextField;
         this.txt_f2 = this._mc.getMC().getChildByName("txt_tf2") as TextField;
         this.tf_selectednum = this._mc.getMC().getChildByName("tf_selectednum") as TextField;
         this.tf_notice = this._mc.getMC().getChildByName("tf_notice") as Object;
         var _loc5_:TextFormat = FontManager.getInstance().getTextFormat("Tahoma",12,6667519);
         _loc5_.leading = 2;
         this.tf_notice.setStyle("textFormat",_loc5_);
         this.tf_notice.editable = false;
         this.tf_notice.addEventListener(ActionEvent.ACTION_TEXT_LINK,this.tf_noticeClick);
         System.gc();
         this.RoomList = new Array();
         var _loc6_:int = 0;
         while(_loc6_ < this.RoomMaxItem)
         {
            _loc8_ = GameKernel.getMovieClipInstance("Luckybase");
            _loc9_ = this._mc.getMC().getChildByName("mc_li" + _loc6_) as Sprite;
            _loc9_.addChild(_loc8_);
            this.RoomList.push(_loc8_);
            _loc2_ = MovieClip(_loc8_.btn_join0);
            _loc10_ = new XButton(_loc2_);
            _loc10_.Data = _loc6_;
            _loc10_.OnClick = this.btn_join0Click;
            _loc2_ = MovieClip(_loc8_.btn_join1);
            _loc10_ = new XButton(_loc2_);
            _loc10_.Data = _loc6_;
            _loc10_.OnClick = this.btn_join1Click;
            _loc2_ = MovieClip(_loc8_.btn_cancel0);
            _loc10_ = new XButton(_loc2_);
            _loc10_.Data = _loc6_;
            _loc10_.OnClick = this.btn_cancel0Click;
            _loc2_ = MovieClip(_loc8_.btn_cancel1);
            _loc10_ = new XButton(_loc2_);
            _loc10_.Data = _loc6_;
            _loc10_.OnClick = this.btn_cancel1Click;
            _loc2_ = MovieClip(_loc8_.btn_snatch);
            _loc10_ = new XButton(_loc2_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("Boss148"));
            _loc10_.Data = _loc6_;
            _loc10_.OnClick = this.btn_snatchClick;
            _loc2_ = MovieClip(_loc8_.btn_view);
            _loc10_ = new XButton(_loc2_);
            _loc10_.Data = _loc6_;
            _loc10_.OnClick = this.btn_viewClick;
            Sprite(_loc8_.btn_cancel0).visible = false;
            Sprite(_loc8_.btn_cancel1).visible = false;
            _loc11_ = new XMovieClip(_loc8_.mc_0 as MovieClip);
            _loc11_.Data = _loc6_ + 1;
            _loc11_.OnMouseOver = this.RoomOver;
            _loc11_.m_movie.addEventListener(MouseEvent.MOUSE_OUT,this.RoomOut);
            _loc11_ = new XMovieClip(_loc8_.mc_1 as MovieClip);
            _loc11_.Data = -(_loc6_ + 1);
            _loc11_.OnMouseOver = this.RoomOver;
            _loc11_.m_movie.addEventListener(MouseEvent.MOUSE_OUT,this.RoomOut);
            _loc12_ = Sprite(_loc8_.getChildByName("mc_fighticon"));
            _loc12_.addChild(new Bitmap(GameKernel.getTextureInstance("png_battle")));
            _loc12_.visible = false;
            _loc6_++;
         }
         this.SelectedFleetList = new Array();
      }
      
      private function btn_helpClick(param1:MouseEvent) : void
      {
         Sprite(this._mc.getMC().getChildByName("mc_help")).visible = !Sprite(this._mc.getMC().getChildByName("mc_help")).visible;
      }
      
      private function tf_noticeClick(param1:TextEvent) : void
      {
         ChatAction.getInstance().sendChatUserInfoMessage(-1,-1,3,-1,param1.text);
      }
      
      private function RoomOut(param1:MouseEvent) : void
      {
         if(this._PropsTip != null && this._PropsTip.parent != null && this._PropsTip.parent.contains(this._PropsTip))
         {
            this._PropsTip.parent.removeChild(this._PropsTip);
         }
      }
      
      private function RoomOver(param1:MouseEvent, param2:XMovieClip) : void
      {
         if(this.RoomListMsg == null)
         {
            return;
         }
         var _loc3_:int = Math.abs(param2.Data);
         _loc3_--;
         _loc3_ = this.RoomPageId * this.RoomMaxItem + _loc3_;
         var _loc4_:MSG_RESP_CAPTURE_ARK_TMP = this.RoomListMsg.Room[_loc3_];
         var _loc5_:int = -1;
         if(param2.Data >= 0)
         {
            _loc5_ = int(_loc4_.LeftPropsID);
         }
         else
         {
            _loc5_ = int(_loc4_.RightPropsID);
         }
         if(_loc5_ > 0)
         {
            this.ShowPropsTip(param2.m_movie,_loc5_);
         }
      }
      
      private function ShowPropsTip(param1:MovieClip, param2:int) : void
      {
         var _loc3_:Point = param1.localToGlobal(new Point(0,param1.height));
         _loc3_ = this._mc.getMC().globalToLocal(_loc3_);
         this._PropsTip = PackUi.getInstance().TipHd(_loc3_.x,_loc3_.y,param2,true);
         this._PropsTip.x = _loc3_.x;
         this._PropsTip.y = _loc3_.y;
         this._mc.getMC().addChild(this._PropsTip);
      }
      
      private function OnTimer(param1:TimerEvent) : void
      {
         var _loc7_:MSG_RESP_CAPTURE_ARK_TMP = null;
         var _loc8_:MovieClip = null;
         if(this.RoomListMsg == null)
         {
            return;
         }
         if(this.SelfRommMsg == null)
         {
            return;
         }
         if(this.LastTime == 0)
         {
            this.LastTime = getTimer();
         }
         var _loc2_:int = getTimer() - this.LastTime;
         var _loc3_:int = _loc2_ / 1000;
         this.LastTime = getTimer() - _loc2_ % 1000;
         var _loc4_:int = 0;
         while(_loc4_ < this.RoomListMsg.DataLen)
         {
            _loc7_ = this.RoomListMsg.Room[_loc4_];
            if(_loc7_.RoomState > 2 && _loc7_.RoomState < 8 && _loc7_.Countdown > 0)
            {
               _loc7_.Countdown -= _loc3_;
            }
            _loc4_++;
         }
         var _loc5_:int = this.RoomPageId * this.RoomMaxItem;
         var _loc6_:int = 0;
         while(_loc6_ < this.RoomMaxItem)
         {
            if(_loc5_ >= this.RoomListMsg.DataLen)
            {
               break;
            }
            _loc8_ = MovieClip(this.RoomList[_loc6_]);
            _loc7_ = this.RoomListMsg.Room[_loc5_];
            if(_loc7_.RoomState > 2 && _loc7_.RoomState < 8 && _loc7_.Countdown > 0)
            {
               TextField(_loc8_.txt_time).text = DataWidget.secondFormatToTime(_loc7_.Countdown);
            }
            else
            {
               TextField(_loc8_.txt_time).text = "";
            }
            _loc5_++;
            _loc6_++;
         }
         if(this.SelfRommMsg.Countdown > 0)
         {
            this.SelfRommMsg.Countdown -= _loc3_;
            this.txt_f0.text = DataWidget.secondFormatToTime(this.SelfRommMsg.Countdown);
         }
         if(this.SelfRommMsg.SpareTime > 0)
         {
            this.SelfRommMsg.SpareTime -= _loc3_;
            this.ShowCountDown();
         }
      }
      
      private function OnSelectedProps(param1:int) : void
      {
         this.SelectedPropsId = param1;
         this.JoinRoom(this.SelectedRoomId,param1,this.SelectedStatus);
      }
      
      private function JoinRoom(param1:int, param2:int, param3:int) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:GShipTeam = null;
         var _loc4_:MSG_REQUEST_ECTYPE = new MSG_REQUEST_ECTYPE();
         _loc4_.SeqId = GamePlayer.getInstance().seqID++;
         _loc4_.Guid = GamePlayer.getInstance().Guid;
         _loc4_.Activity = 1;
         _loc4_.CapturePlace = param3;
         _loc4_.PropsID = param2;
         _loc4_.RoomId = param1;
         if(this.SelectedFleetList)
         {
            _loc5_ = int(this.SelectedFleetList.length);
         }
         else
         {
            _loc5_ = 0;
         }
         _loc5_ = _loc5_ > MsgTypes.MAX_USERSHIPTEAMNUM ? MsgTypes.MAX_USERSHIPTEAMNUM : _loc5_;
         var _loc8_:int = 0;
         while(_loc8_ < _loc5_)
         {
            _loc6_ = int(this.SelectedFleetList[_loc8_][0]);
            _loc7_ = GalaxyShipManager.instance.getShipDatas(_loc6_);
            _loc4_.ShipTeamId[_loc8_] = _loc6_;
            _loc8_++;
         }
         _loc4_.DataLen = _loc5_;
         NetManager.Instance().sendObject(_loc4_);
      }
      
      private function CheckJoin(param1:XButton, param2:Function) : Boolean
      {
         var _loc3_:String = null;
         if(this.SelfRommMsg.SpareType != 2)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss126"),0);
            return false;
         }
         if(this.SearchNum >= this.SearchCount)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss146"),0);
            return false;
         }
         if(this.SelectedFleetList == null || this.SelectedFleetList.length == 0)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss127"),0);
            this.MaxShip = this.RoomListMsg.SearchFleets;
            this.AddFleet();
            this.NextFunction = param2;
            this.SelectedButton = param1;
            return false;
         }
         if(this.SelectedFleetList.length > this.RoomListMsg.SearchFleets)
         {
            _loc3_ = StringManager.getInstance().getMessageString("Boss143");
            _loc3_ = _loc3_.replace("@@1",this.RoomListMsg.SearchFleets);
            MessagePopup.getInstance().Show(_loc3_,0);
            return false;
         }
         return true;
      }
      
      private function btn_join0Click(param1:Event, param2:XButton) : void
      {
         if(!this.CheckJoin(param2,this.btn_join0Click))
         {
            return;
         }
         this.SelectedRoomId = param2.Data;
         this.SelectedRoomId = this.RoomPageId * this.RoomMaxItem + this.SelectedRoomId;
         this.SelectedStatus = 2;
         RaidProps_SelectProps.getInstance().Show(42,this.OnSelectedProps);
      }
      
      private function btn_join1Click(param1:Event, param2:XButton) : void
      {
         if(!this.CheckJoin(param2,this.btn_join1Click))
         {
            return;
         }
         this.SelectedRoomId = param2.Data;
         this.SelectedRoomId = this.RoomPageId * this.RoomMaxItem + this.SelectedRoomId;
         this.SelectedStatus = 1;
         RaidProps_SelectProps.getInstance().Show(43,this.OnSelectedProps);
      }
      
      private function btn_cancel0Click(param1:Event, param2:XButton) : void
      {
         this.SelectedRoomId = param2.Data;
         this.SelectedRoomId = this.RoomPageId * this.RoomMaxItem + this.SelectedRoomId;
         this.SelectedStatus = 2;
         this.RequestRoomStatus(1,this.SelectedRoomId);
      }
      
      private function btn_cancel1Click(param1:Event, param2:XButton) : void
      {
         this.SelectedRoomId = param2.Data;
         this.SelectedRoomId = this.RoomPageId * this.RoomMaxItem + this.SelectedRoomId;
         this.SelectedStatus = 1;
         this.RequestRoomStatus(1,this.SelectedRoomId);
      }
      
      private function btn_snatchClick(param1:Event, param2:XButton) : void
      {
         var _loc3_:String = null;
         if(this.CaptureNum >= this.CaptureCount)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss147"),0);
            return;
         }
         if(GamePlayer.getInstance().UserMoney < 100000)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss128"),0);
            return;
         }
         if(this.SelfRommMsg.Countdown > 0)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss129"),0);
            return;
         }
         if(this.SelectedFleetList == null || this.SelectedFleetList.length == 0)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss127"),0);
            this.MaxShip = this.RoomListMsg.CaptureFleets;
            this.AddFleet();
            this.NextFunction = this.btn_snatchClick;
            this.SelectedButton = param2;
            return;
         }
         if(this.SelectedFleetList.length > this.RoomListMsg.CaptureFleets)
         {
            _loc3_ = StringManager.getInstance().getMessageString("Boss143");
            _loc3_ = _loc3_.replace("@@1",this.RoomListMsg.CaptureFleets);
            MessagePopup.getInstance().Show(_loc3_,0);
            return;
         }
         this.SelectedRoomId = param2.Data;
         this.SelectedRoomId = this.RoomPageId * this.RoomMaxItem + this.SelectedRoomId;
         this.SelectedStatus = 4;
         this.JoinRoom(this.SelectedRoomId,0,this.SelectedStatus);
      }
      
      private function btn_viewClick(param1:Event, param2:XButton) : void
      {
         this.SelectedRoomId = param2.Data;
         this.SelectedRoomId = this.RoomPageId * this.RoomMaxItem + this.SelectedRoomId;
         this.ViewBattle(this.SelectedRoomId);
      }
      
      private function btn_cancelClick(param1:MouseEvent, param2:XButton) : void
      {
         if(this.SelfRoomStatus > 0)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss130"),0);
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
      
      private function btn_refreshClick(param1:MouseEvent) : void
      {
      }
      
      private function btn_lastClick(param1:MouseEvent) : void
      {
         this.RoomPageId = this.RoomPageCount - 1;
         this.ShowRoomList();
      }
      
      private function ShowRoomList() : void
      {
         var _loc3_:MSG_RESP_CAPTURE_ARK_TMP = null;
         if(this.RoomListMsg == null)
         {
            return;
         }
         this.ResetRoomPageButton();
         var _loc1_:int = this.RoomPageId * this.RoomMaxItem;
         var _loc2_:int = 0;
         while(_loc2_ < this.RoomMaxItem)
         {
            if(_loc1_ >= this.RoomListMsg.DataLen)
            {
               break;
            }
            _loc3_ = this.RoomListMsg.Room[_loc1_];
            this.SetRoomStatus(_loc2_,_loc1_,_loc3_.Countdown,_loc3_.RoomState,_loc3_.LeftPropsID,_loc3_.RightPropsID);
            _loc1_++;
            _loc2_++;
         }
         while(_loc2_ < this.RoomMaxItem)
         {
            MovieClip(this.RoomList[_loc2_]).visible = false;
            _loc2_++;
         }
      }
      
      private function SetRoomStatus(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : void
      {
         var _loc9_:Bitmap = null;
         var _loc10_:propsInfo = null;
         var _loc11_:Bitmap = null;
         var _loc7_:MovieClip = MovieClip(this.RoomList[param1]);
         _loc7_.visible = true;
         TextField(_loc7_.txt_roomnum).text = (param2 + 1).toString();
         Sprite(_loc7_.btn_join0).visible = this.SelfRoomStatus == 0 && param4 < 2;
         Sprite(_loc7_.btn_join1).visible = this.SelfRoomStatus == 0 && (param4 == 0 || param4 == 2);
         Sprite(_loc7_.btn_snatch).visible = this.SelfRoomStatus == 0 && param4 > 3 && param4 < 8;
         Sprite(_loc7_.btn_view).visible = param4 >= 8;
         Sprite(_loc7_.btn_cancel0).visible = false;
         Sprite(_loc7_.btn_cancel1).visible = false;
         Sprite(_loc7_.mc_fighticon).visible = param4 >= 8;
         if(this.SelfRommMsg != null && this.SelfRommMsg.RoomID == param2)
         {
            Sprite(_loc7_.btn_cancel0).visible = this.SelfRommMsg.Place == 2 && param4 < 4;
            Sprite(_loc7_.btn_cancel1).visible = this.SelfRommMsg.Place == 1 && param4 < 4;
         }
         var _loc8_:Sprite = Sprite(Sprite(_loc7_.mc_0).getChildByName("mc_base0"));
         if(_loc8_.numChildren > 0)
         {
            _loc8_.removeChildAt(0);
         }
         if(param4 >= 2)
         {
            if(param5 == 0)
            {
               _loc9_ = new Bitmap(GameKernel.getTextureInstance("wenhao"));
            }
            else
            {
               _loc10_ = CPropsReader.getInstance().GetPropsInfo(param5);
               _loc9_ = new Bitmap(GameKernel.getTextureInstance(_loc10_.ImageFileName));
            }
            _loc8_.addChildAt(_loc9_,0);
         }
         _loc8_ = Sprite(Sprite(_loc7_.mc_1).getChildByName("mc_base0"));
         if(_loc8_.numChildren > 0)
         {
            _loc8_.removeChildAt(0);
         }
         if(param4 >= 1 && param4 != 2)
         {
            if(param6 == 0)
            {
               _loc11_ = new Bitmap(GameKernel.getTextureInstance("wenhao"));
            }
            else
            {
               _loc10_ = CPropsReader.getInstance().GetPropsInfo(param6);
               _loc11_ = new Bitmap(GameKernel.getTextureInstance(_loc10_.ImageFileName));
            }
            _loc8_.addChildAt(_loc11_,0);
         }
         if(param4 > 2 && param4 < 8 && param3 > 0)
         {
            TextField(_loc7_.txt_time).text = DataWidget.secondFormatToTime(param3);
         }
         else
         {
            TextField(_loc7_.txt_time).text = "";
         }
      }
      
      private function btn_nextClick(param1:MouseEvent) : void
      {
         ++this.RoomPageId;
         this.ShowRoomList();
      }
      
      private function btn_prevClick(param1:MouseEvent) : void
      {
         --this.RoomPageId;
         this.ShowRoomList();
      }
      
      private function btn_firstClick(param1:MouseEvent) : void
      {
         this.RoomPageId = 0;
         this.ShowRoomList();
      }
      
      private function btn_searchClick(param1:MouseEvent) : void
      {
         if(this.RoomListMsg == null || this.txt_input.text == "" || this.txt_input.text == this.txt_input.DefaultText)
         {
            return;
         }
         var _loc2_:int = parseInt(this.txt_input.text);
         if(_loc2_ > this.RoomListMsg.DataLen)
         {
            return;
         }
         this.RoomPageId = Math.floor((_loc2_ - 1) / this.RoomMaxItem);
         this.ShowRoomList();
      }
      
      private function btn_addfleetClick(param1:MouseEvent) : void
      {
         if(this.SelfRoomStatus > 0)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss130"),0);
            return;
         }
         this.SelectedButton = null;
         this.NextFunction = null;
         this.AddFleet();
      }
      
      private function AddFleet() : void
      {
         var _loc1_:GStar = GalaxyMapAction.instance.curStar;
         ShipTransferUI.instance.RequestJumpShips(_loc1_.GalaxyId,_loc1_.GalaxyMapId,3,4,this.MaxShip);
         this.MaxShip = 0;
      }
      
      public function receiveData(param1:Array) : void
      {
         var _loc3_:* = undefined;
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
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
               this.SelectedFleetList.push(_loc3_);
            }
            _loc2_++;
         }
         this.FleetPageCount = Math.ceil(this.SelectedFleetList.length / this.FleetMaxItem);
         this.ShowFleetList();
         if(this.SelectedFleetList.length > 0 && this.NextFunction != null)
         {
            this.NextFunction(null,this.SelectedButton);
            this.NextFunction = null;
            this.SelectedButton = null;
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
      
      private function ResetRoomPageButton() : void
      {
         this.btn_prev.setBtnDisabled(this.RoomPageId <= 0);
         this.btn_next.setBtnDisabled(this.RoomPageId + 1 >= this.RoomPageCount);
         this.btn_first.setBtnDisabled(this.RoomPageId <= 0);
         this.btn_last.setBtnDisabled(this.RoomPageId + 1 >= this.RoomPageCount);
         this.tf_page.text = this.RoomPageId + 1 + "/" + this.RoomPageCount;
      }
      
      private function CloseClick(param1:MouseEvent) : void
      {
         GameKernel.popUpDisplayManager.Hide(this);
      }
      
      private function Clear() : void
      {
         this.NextFunction = null;
         this.SelectedButton = null;
         this.CountDownTimer.start();
         if(this.SelfRoomStatus == 0)
         {
            this.SelectedFleetList.splice(0);
         }
         this.FleetPageId = 0;
         this.FleetPageCount = 0;
         this.ShowFleetList();
         this.RoomPageId = 0;
         this.ShowRoomList();
      }
      
      private function RequestRoomStatus(param1:int, param2:int = -1) : void
      {
         var _loc3_:MSG_REQUEST_CAPTURE_STATE = new MSG_REQUEST_CAPTURE_STATE();
         _loc3_.SeqId = GamePlayer.getInstance().seqID++;
         _loc3_.Guid = GamePlayer.getInstance().Guid;
         _loc3_.RoomID = param2;
         _loc3_.Request = param1;
         NetManager.Instance().sendObject(_loc3_);
      }
      
      public function ViewBattle(param1:int) : void
      {
         this.ViewRoomId = param1;
         this.RequestRoomStatus(2,this.ViewRoomId);
         this.CloseClick(null);
      }
      
      public function LeaveView() : void
      {
         if(this.ViewRoomId < 0)
         {
            return;
         }
         this.RequestRoomStatus(3,this.ViewRoomId);
         FightManager.instance.CleanFight();
         GalaxyManager.instance.sendRequestGalaxy();
         this.ViewRoomId = -1;
      }
      
      public function RespRoomList(param1:MSG_RESP_CAPTURE_ARK_LIST) : void
      {
         this.RoomListMsg = param1;
         this.LastTime = 0;
         this.RoomPageCount = Math.ceil(param1.DataLen / this.RoomMaxItem);
         this.ShowRoomList();
         if(this.ViewRoomId >= 0 && MSG_RESP_CAPTURE_ARK_TMP(param1.Room[this.ViewRoomId]).RoomState < 8)
         {
            this.ViewRoomId = -1;
         }
      }
      
      public function RespRoomStatus(param1:MSG_RESP_CAPTURE_ARK_ROOM) : void
      {
         if(this.RoomListMsg == null)
         {
            return;
         }
         var _loc2_:MSG_RESP_CAPTURE_ARK_TMP = this.RoomListMsg.Room[param1.RoomID];
         _loc2_.RightPropsID = param1.RightPropsID;
         _loc2_.LeftPropsID = param1.LeftPropsID;
         _loc2_.Countdown = param1.Countdown;
         _loc2_.RoomState = param1.RoomState;
         _loc2_.RoomID = param1.RoomID;
         if(Math.floor(param1.RoomID / this.RoomMaxItem) == this.RoomPageId)
         {
            this.SetRoomStatus(param1.RoomID % this.RoomMaxItem,_loc2_.RoomID,_loc2_.Countdown,_loc2_.RoomState,_loc2_.LeftPropsID,_loc2_.RightPropsID);
         }
         this.DeleteProps();
      }
      
      public function RespSelfRoomMsg(param1:MSG_RESP_CAPTURE_ARK_INFO) : void
      {
         this.SelfRommMsg = param1;
         this.SelfRoomStatus = param1.Place;
         if(this.RoomListMsg == null)
         {
            return;
         }
         this.ShowRoomList();
         this.txt_f0.text = DataWidget.secondFormatToTime(param1.Countdown);
         this.SearchCount = (param1.Search & 0xF0) >> 4;
         this.SearchNum = param1.Search & 0x0F;
         this.txt_f1.text = this.SearchNum.toString() + "/" + this.SearchCount.toString();
         this.CaptureCount = (param1.Capture & 0xF0) >> 4;
         this.CaptureNum = param1.Capture & 0x0F;
         this.txt_f2.text = this.CaptureNum.toString() + "/" + this.CaptureCount.toString();
         if(param1.Place == 4)
         {
            this.ViewRoomId = param1.RoomID;
         }
         this.DeleteProps();
         this.ShowCountDown();
      }
      
      private function ShowCountDown() : void
      {
         var _loc1_:String = null;
         if(this.SelfRommMsg.SpareType == 1)
         {
            _loc1_ = StringManager.getInstance().getMessageString("Boss131");
         }
         else
         {
            _loc1_ = StringManager.getInstance().getMessageString("Boss132");
         }
         _loc1_ = _loc1_.replace("@@1",DataWidget.secondFormatToTime(this.SelfRommMsg.SpareTime));
         this.txt_time.text = _loc1_;
      }
      
      private function DeleteProps() : void
      {
         var _loc1_:MSG_RESP_CAPTURE_ARK_TMP = null;
         if(this.SelfRommMsg == null || this.RoomListMsg == null)
         {
            return;
         }
         if(this.SelectedPropsId > 0 && (this.SelfRommMsg.Place == 1 || this.SelfRommMsg.Place == 2))
         {
            _loc1_ = this.RoomListMsg.Room[this.SelfRommMsg.RoomID];
            if(_loc1_.RoomState > 3)
            {
               UpdateResource.getInstance().UpdateYfHd(this.SelectedPropsId,this.SelectedPropsLock);
               this.SelectedPropsId = -1;
            }
         }
      }
      
      public function RespMessage(param1:MSG_RESP_CAPTURE_BULLETIN) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc2_:String = "";
         var _loc3_:String = "";
         if(param1.BulletinType == 1)
         {
            _loc3_ = "#FF3300";
            _loc2_ = StringManager.getInstance().getMessageString("Boss133");
            _loc2_ = _loc2_.replace("@@1",(param1.RoomID + 1).toString());
         }
         else if(param1.BulletinType == 2)
         {
            _loc3_ = "#55BAFF";
            _loc2_ = StringManager.getInstance().getMessageString("Boss134");
            _loc4_ = "<a href=\'event:" + param1.CaptureUserName + "\'>" + param1.CaptureUserName + "</a>";
            _loc5_ = "<a href=\'event:" + param1.LeftUserName + "\'>" + param1.LeftUserName + "</a>";
            _loc6_ = "<a href=\'event:" + param1.RightUserName + "\'>" + param1.RightUserName + "</a>";
            _loc2_ = _loc2_.replace("@@1",_loc4_);
            _loc2_ = _loc2_.replace("@@2",(param1.RoomID + 1).toString());
            _loc2_ = _loc2_.replace("@@3",_loc5_);
            _loc2_ = _loc2_.replace("@@4",_loc6_);
         }
         this.tf_notice.htmlText += "<font color=\'" + _loc3_ + "\'>" + _loc2_ + "</font><br/>";
         this.tf_notice.drawNow();
         this.tf_notice.verticalScrollPosition = this.tf_notice.maxVerticalScrollPosition;
      }
      
      private function GetRaidPropsNum(param1:int) : String
      {
         var _loc2_:* = (param1 & 0xF0) >> 4;
         var _loc3_:* = param1 & 0x0F;
         return _loc3_.toString() + "/" + _loc2_.toString();
      }
   }
}

