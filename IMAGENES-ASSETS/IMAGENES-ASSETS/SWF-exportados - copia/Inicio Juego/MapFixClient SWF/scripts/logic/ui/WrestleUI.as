package logic.ui
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.facebook.FacebookUserInfo;
   import com.star.frameworks.managers.StringManager;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Point;
   import flash.text.StyleSheet;
   import flash.text.TextField;
   import logic.action.ChatAction;
   import logic.action.ConstructionAction;
   import logic.action.GalaxyMapAction;
   import logic.entry.GStar;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.game.GameKernel;
   import logic.manager.FightManager;
   import logic.manager.GalaxyManager;
   import logic.manager.GalaxyShipManager;
   import logic.manager.InstanceManager;
   import net.base.NetManager;
   import net.msg.fightMsg.MSG_REQUEST_ARENA_PAGE;
   import net.msg.fightMsg.MSG_REQUEST_ARENA_STATUS;
   import net.msg.fightMsg.MSG_REQUEST_ECTYPE;
   import net.msg.fightMsg.MSG_RESP_ARENA_PAGE;
   import net.msg.fightMsg.MSG_RESP_ARENA_PAGE_TEMP;
   import net.msg.fightMsg.MSG_RESP_ARENA_STATUS;
   import net.msg.ship.MSG_RESP_JUMPGALAXYSHIP_TEMP;
   
   public class WrestleUI extends AbstractPopUp
   {
      
      private static var instance:WrestleUI;
      
      private var FreeList:Array;
      
      private var FightingList:Array;
      
      private var PageId:int;
      
      private var PageCount:int;
      
      private var SelectedRoom:int;
      
      private var SelectedRoomId:int;
      
      private var SelectedTypeId:int;
      
      private var FleetPageId:int;
      
      private var FleetPageCount:int;
      
      private var SelectedFleetList:Array;
      
      private var btn_right:HButton;
      
      private var btn_back:HButton;
      
      private var btn_join:HButton;
      
      private var btn_begin:HButton;
      
      private var btn_leave:HButton;
      
      private var btn_prev:HButton;
      
      private var btn_next:HButton;
      
      private var btn_first:HButton;
      
      private var btn_last:HButton;
      
      private var btn_left:HButton;
      
      private var btn_create:HButton;
      
      private var btn_free:XButton;
      
      private var btn_fighting:XButton;
      
      private var FormMC:MovieClip;
      
      private var tf_selectednum:TextField;
      
      private var tf_page:TextField;
      
      private var txt_input:XTextField;
      
      private var ParentLock:Container;
      
      private var CreateForm:MovieClip;
      
      private var JoinForm:MovieClip;
      
      private var SelectedRoomList:Array;
      
      private var SelectedRoodMc:MovieClip;
      
      private var HasRoom:Boolean = false;
      
      private var CanStart:Boolean = false;
      
      private var IsOwer:Boolean = false;
      
      private var RoomMsg:MSG_RESP_ARENA_PAGE;
      
      private var btn_remove:HButton;
      
      private var PopButton:MovieClip;
      
      private var SelectedUserId:Number;
      
      private var SelectedGuid:int;
      
      private var SelectedName:String;
      
      private var btn_view:HButton;
      
      public var WatchStatus:int;
      
      public function WrestleUI()
      {
         super();
         setPopUpName("WrestleUI");
      }
      
      public static function getInstance() : WrestleUI
      {
         if(instance == null)
         {
            instance = new WrestleUI();
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
         this._mc = new MObject("ArenaScene",385,300);
         this.initMcElement();
         this.Clear();
         GameKernel.popUpDisplayManager.Regisger(instance);
      }
      
      private function Clear() : void
      {
         this.RoomMsg = null;
         this.FormMC.mouseEnabled = true;
         if(this.SelectedRoodMc)
         {
            this.SelectedRoodMc.gotoAndStop(1);
            this.SelectedRoodMc = null;
         }
         this.PageId = 0;
         this.PageCount = 0;
         this.SelectedTypeId = -1;
         this.ShowList(0);
         if(this.HasRoom == false)
         {
            this.SelectedFleetList.splice(0);
            this.ClearFleet();
            this.FleetPageCount = 0;
            this.FleetPageId = 0;
            this.ResetFleetPageButton();
         }
         else
         {
            this.ShowFleetList();
         }
         this.txt_input.ResetDefaultText();
      }
      
      override public function initMcElement() : void
      {
         var _loc1_:HButton = null;
         var _loc2_:MovieClip = null;
         var _loc4_:XButton = null;
         var _loc11_:XMovieClip = null;
         var _loc12_:XMovieClip = null;
         var _loc13_:MovieClip = null;
         this.SelectedFleetList = new Array();
         this.FormMC = this._mc.getMC();
         _loc2_ = this.FormMC.getChildByName("btn_close") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.CloseClick);
         this.tf_selectednum = this.FormMC.getChildByName("tf_selectednum") as TextField;
         this.tf_page = this.FormMC.getChildByName("tf_page") as TextField;
         var _loc3_:TextField = this.FormMC.getChildByName("txt_input") as TextField;
         this.txt_input = new XTextField(_loc3_,_loc3_.text);
         this.btn_free = new XButton(this.FormMC.getChildByName("btn_free") as MovieClip);
         this.btn_free.Data = 0;
         this.btn_free.OnClick = this.TypeButtonClick;
         this.btn_fighting = new XButton(this.FormMC.getChildByName("btn_fighting") as MovieClip);
         this.btn_fighting.Data = 1;
         this.btn_fighting.OnClick = this.TypeButtonClick;
         _loc2_ = this.FormMC.getChildByName("btn_create") as MovieClip;
         this.btn_create = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_createClick);
         _loc2_ = this.FormMC.getChildByName("btn_back") as MovieClip;
         this.btn_back = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_backClick);
         _loc2_ = this.FormMC.getChildByName("btn_join") as MovieClip;
         this.btn_join = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_joinClick);
         _loc2_ = this.FormMC.getChildByName("btn_begin") as MovieClip;
         this.btn_begin = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_beginClick);
         _loc2_ = this.FormMC.getChildByName("btn_leave") as MovieClip;
         this.btn_leave = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_leaveClick);
         _loc2_ = this.FormMC.getChildByName("btn_prev") as MovieClip;
         this.btn_prev = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_prevClick);
         _loc2_ = this.FormMC.getChildByName("btn_next") as MovieClip;
         this.btn_next = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_nextClick);
         _loc2_ = this.FormMC.getChildByName("btn_first") as MovieClip;
         this.btn_first = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_firstClick);
         _loc2_ = this.FormMC.getChildByName("btn_last") as MovieClip;
         this.btn_last = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_lastClick);
         _loc2_ = this.FormMC.getChildByName("btn_left") as MovieClip;
         this.btn_left = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_leftClick);
         _loc2_ = this.FormMC.getChildByName("btn_right") as MovieClip;
         this.btn_right = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_rightClick);
         _loc2_ = this.FormMC.getChildByName("btn_search") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_searchClick);
         _loc2_ = this.FormMC.getChildByName("btn_addfleet") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_addfleetClick);
         _loc2_ = this.FormMC.getChildByName("btn_view") as MovieClip;
         this.btn_view = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_viewClick);
         _loc2_ = this.FormMC.getChildByName("btn_refresh") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_refreshClick);
         var _loc5_:int = 0;
         while(_loc5_ < 4)
         {
            _loc2_ = this.FormMC.getChildByName("mc_list" + _loc5_) as MovieClip;
            _loc4_ = new XButton(_loc2_.getChildByName("btn_cancel") as MovieClip);
            _loc4_.Data = _loc5_;
            _loc4_.OnClick = this.btn_cancelClick;
            _loc2_.visible = false;
            _loc5_++;
         }
         var _loc6_:String = "a:link{text-decoration: underline;} a:hover{color:#ff0000;text-decoration: underline;} a:active{text-decoration: underline;}";
         var _loc7_:StyleSheet = new StyleSheet();
         _loc7_.parseCSS(_loc6_);
         this.FreeList = new Array();
         var _loc8_:int = 0;
         while(_loc8_ < 5)
         {
            _loc2_ = GameKernel.getMovieClipInstance("Arena_freevs");
            _loc11_ = new XMovieClip(_loc2_);
            _loc11_.Data = _loc8_;
            _loc11_.OnMouseOver = this.FreeOver;
            _loc11_.OnClick = this.FreeClick;
            this.FreeList.push(_loc2_);
            TextField(_loc2_.txt_name0).styleSheet = _loc7_;
            TextField(_loc2_.txt_name1).styleSheet = _loc7_;
            TextField(_loc2_.txt_name0).addEventListener(TextEvent.LINK,this.NameClick);
            TextField(_loc2_.txt_name1).addEventListener(TextEvent.LINK,this.NameClick);
            _loc8_++;
         }
         this.FightingList = new Array();
         var _loc9_:int = 0;
         while(_loc9_ < 5)
         {
            _loc2_ = GameKernel.getMovieClipInstance("Arena_fightingvs");
            _loc12_ = new XMovieClip(_loc2_);
            _loc12_.Data = _loc9_;
            _loc12_.OnMouseOver = this.FightingOver;
            _loc12_.OnClick = this.FightingClick;
            this.FightingList.push(_loc2_);
            TextField(_loc2_.txt_name0).styleSheet = _loc7_;
            TextField(_loc2_.txt_name1).styleSheet = _loc7_;
            TextField(_loc2_.txt_name0).addEventListener(TextEvent.LINK,this.NameClick);
            TextField(_loc2_.txt_name1).addEventListener(TextEvent.LINK,this.NameClick);
            _loc9_++;
         }
         var _loc10_:int = 0;
         while(_loc10_ < 5)
         {
            _loc13_ = this.FormMC.getChildByName("mc_li" + _loc10_) as MovieClip;
            _loc13_.addChild(this.FreeList[_loc10_]);
            _loc13_.addChild(this.FightingList[_loc10_]);
            _loc10_++;
         }
         this.ParentLock = new Container("SceneLock");
         this.ParentLock.mouseEnabled = true;
         this.ParentLock.mouseChildren = false;
         this.ParentLock.fillRectangleWithoutBorder(0,0,100,100,0,0);
         this.ParentLock.x = 0 - this.FormMC.width / 2;
         this.ParentLock.y = 0 - this.FormMC.height / 2;
         this.ParentLock.width = this.FormMC.width;
         this.ParentLock.height = this.FormMC.height;
         this.InitCreateForm();
         this.InitJoinForm();
         this.InitPopButton();
         this.FormMC.swapChildren(this.btn_create.m_movie,this.btn_back.m_movie);
         this.btn_back.setVisible(false);
         this.RestStatus();
      }
      
      private function NameClick(param1:TextEvent) : void
      {
         var _loc2_:TextField = param1.target as TextField;
         var _loc3_:Point = _loc2_.localToGlobal(new Point(0,0));
         _loc3_ = this.FormMC.globalToLocal(_loc3_);
         this.PopButton.x = _loc3_.x;
         this.PopButton.y = _loc3_.y + _loc2_.height;
         this.PopButton.visible = true;
         var _loc4_:int = int(param1.text);
         var _loc5_:* = _loc4_ < 0;
         _loc4_ = Math.abs(_loc4_) - 1;
         var _loc6_:MSG_RESP_ARENA_PAGE_TEMP = this.RoomMsg.Data[_loc4_];
         if(this.SelectedTypeId == 0)
         {
            if(_loc6_.SrcGuid == GamePlayer.getInstance().Guid)
            {
               this.btn_remove.setVisible(_loc5_);
            }
            else
            {
               this.btn_remove.setVisible(false);
            }
         }
         else
         {
            this.btn_remove.setVisible(false);
         }
         if(_loc5_)
         {
            this.SelectedName = _loc6_.ObjName;
            this.SelectedUserId = _loc6_.ObjUserId;
            this.SelectedGuid = _loc6_.ObjGuid;
         }
         else
         {
            this.SelectedName = _loc6_.SrcName;
            this.SelectedUserId = _loc6_.SrcUserId;
            this.SelectedGuid = _loc6_.SrcGuid;
         }
      }
      
      private function InitPopButton() : void
      {
         this.PopButton = GameKernel.getMovieClipInstance("Arena_dropbtn");
         var _loc1_:HButton = new HButton(MovieClip(this.PopButton.btn_chat));
         MovieClip(_loc1_.m_movie).addEventListener(MouseEvent.CLICK,this.btn_chatClick);
         this.btn_remove = new HButton(MovieClip(this.PopButton.btn_remove));
         MovieClip(this.btn_remove.m_movie).addEventListener(MouseEvent.CLICK,this.btn_removeClick);
         var _loc2_:HButton = new HButton(MovieClip(this.PopButton.btn_info));
         MovieClip(_loc2_.m_movie).addEventListener(MouseEvent.CLICK,this.btn_infoClick);
         this.PopButton.visible = false;
         this.FormMC.addChild(this.PopButton);
      }
      
      private function btn_removeClick(param1:MouseEvent) : void
      {
         this.PopButton.visible = false;
         this.ReqestStatus(1);
         this.FormMC.mouseEnabled = true;
         this.RefreshPage();
         this.CanStart = false;
         this.btn_begin.setBtnDisabled(true);
      }
      
      private function btn_chatClick(param1:MouseEvent) : void
      {
         ChatAction.prexChatPlayer.objGuid = this.SelectedGuid;
         ChatAction.prexChatPlayer.userName = this.SelectedName;
         ChatAction.getInstance().toPrivateChannel(0,this.SelectedName);
         this.PopButton.visible = false;
         this.CloseClick(null);
      }
      
      private function btn_infoClick(param1:MouseEvent) : void
      {
         ChatAction.getInstance().sendChatUserInfoMessage(-1,-1,3,this.SelectedUserId);
         this.PopButton.visible = false;
      }
      
      private function btn_viewClick(param1:MouseEvent) : void
      {
         if(this.SelectedRoom < 0)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss90"),0);
            return;
         }
         var _loc2_:MSG_RESP_ARENA_PAGE_TEMP = this.RoomMsg.Data[this.SelectedRoom];
         if(_loc2_.SrcGuid == GamePlayer.getInstance().Guid || _loc2_.ObjGuid == GamePlayer.getInstance().Guid)
         {
            if(InstanceManager.instance.curStatus != 2)
            {
               this.RefreshPage();
               return;
            }
            this.btn_backClick(null);
            return;
         }
         this.ReqestStatus(5,_loc2_.SrcGuid);
      }
      
      private function btn_refreshClick(param1:MouseEvent) : void
      {
         this.RefreshPage();
      }
      
      private function InitCreateForm() : void
      {
         this.CreateForm = GameKernel.getMovieClipInstance("Arenacreatpop");
         this.CreateForm.x = -this.CreateForm.width / 2;
         this.CreateForm.y = -this.CreateForm.height / 2;
         var _loc1_:TextField = TextField(this.CreateForm.txt_password);
         _loc1_.restrict = "0-9";
         _loc1_.maxChars = 6;
         var _loc2_:MovieClip = this.CreateForm.getChildByName("btn_creat") as MovieClip;
         var _loc3_:HButton = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_creatFormClick);
         _loc2_ = this.CreateForm.getChildByName("btn_cancel") as MovieClip;
         _loc3_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_cancelFormClick);
      }
      
      private function InitJoinForm() : void
      {
         this.JoinForm = GameKernel.getMovieClipInstance("Arenacreatapplypop");
         this.JoinForm.x = -this.JoinForm.width / 2;
         this.JoinForm.y = -this.JoinForm.height / 2;
         var _loc1_:TextField = TextField(this.JoinForm.txt_password);
         _loc1_.restrict = "0-9";
         _loc1_.maxChars = 6;
         var _loc2_:MovieClip = this.JoinForm.getChildByName("btn_apply") as MovieClip;
         var _loc3_:HButton = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_applyClick);
         _loc2_ = this.JoinForm.getChildByName("btn_close") as MovieClip;
         _loc3_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_closeJoinFormClick);
      }
      
      public function SetSelectedFleetList(param1:Array) : void
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
         this.FleetPageCount = Math.ceil(this.SelectedFleetList.length / 4);
         this.ShowFleetList();
      }
      
      private function ShowList(param1:int) : void
      {
         this.SelectedRoom = -1;
         if(this.SelectedTypeId == param1)
         {
            return;
         }
         this.btn_view.setVisible(param1 == 1);
         if(param1 == 0)
         {
            if(this.IsOwer)
            {
               this.btn_begin.setVisible(true);
               this.btn_begin.setBtnDisabled(!this.CanStart);
            }
            else
            {
               this.btn_begin.setVisible(false);
               this.btn_join.setVisible(true);
               this.btn_join.setBtnDisabled(this.HasRoom);
            }
         }
         this.btn_free.setSelect(param1 == 0);
         this.btn_fighting.setSelect(param1 == 1);
         this.SelectedTypeId = param1;
         if(param1 == 1)
         {
            this.SelectedRoomList = this.FightingList;
         }
         else
         {
            this.SelectedRoomList = this.FreeList;
         }
         this.ResetRoomPageButton();
         this.RefreshPage();
      }
      
      private function RefreshPage(param1:String = "") : void
      {
         this.SelectedRoom = -1;
         this.ClearList();
         var _loc2_:MSG_REQUEST_ARENA_PAGE = new MSG_REQUEST_ARENA_PAGE();
         _loc2_.ArenaFlag = this.SelectedTypeId;
         _loc2_.PageId = this.PageId;
         _loc2_.ItemNum = 5;
         _loc2_.cName = param1;
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc2_);
      }
      
      private function ShowFleetList() : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:MSG_RESP_JUMPGALAXYSHIP_TEMP = null;
         var _loc5_:MovieClip = null;
         var _loc6_:MovieClip = null;
         this.ResetFleetPageButton();
         var _loc1_:int = this.FleetPageId * 4;
         var _loc2_:int = 0;
         for(; _loc2_ < 4; _loc2_++)
         {
            _loc3_ = this.FormMC.getChildByName("mc_list" + _loc2_) as MovieClip;
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
         this.btn_prev.setBtnDisabled(this.PageId <= 0);
         this.btn_next.setBtnDisabled(this.PageId + 1 >= this.PageCount);
         this.btn_first.setBtnDisabled(this.PageId <= 0);
         this.btn_last.setBtnDisabled(this.PageId + 1 >= this.PageCount);
         if(this.PageCount == 0)
         {
            this.tf_page.text = "0/0";
         }
         else
         {
            this.tf_page.text = this.PageId + 1 + "/" + this.PageCount;
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
      
      private function ClearFleet() : void
      {
         var _loc2_:MovieClip = null;
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            _loc2_ = this.FormMC.getChildByName("mc_list" + _loc1_) as MovieClip;
            _loc2_.visible = false;
            _loc1_++;
         }
      }
      
      private function ClearList() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            Sprite(this.FreeList[_loc1_]).visible = false;
            Sprite(this.FightingList[_loc1_]).visible = false;
            _loc1_++;
         }
         this.PopButton.visible = false;
      }
      
      private function btn_createClick(param1:MouseEvent) : void
      {
         if(InstanceManager.instance.curStatus != 0)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss91"),0);
            return;
         }
         this.ShowCreateForm();
      }
      
      private function FreeClick(param1:Event, param2:XMovieClip) : void
      {
         this.SelectedRoom = param2.Data;
         this.SetSelectedRoom(param2);
         this.btn_join.setBtnDisabled(this.HasRoom);
      }
      
      private function FreeOver(param1:Event, param2:XMovieClip) : void
      {
         this.PopButton.visible = false;
      }
      
      private function FightingClick(param1:Event, param2:XMovieClip) : void
      {
         this.SelectedRoom = param2.Data;
         this.SetSelectedRoom(param2);
      }
      
      private function SetSelectedRoom(param1:XMovieClip) : void
      {
         if(this.SelectedRoodMc)
         {
            this.SelectedRoodMc.gotoAndStop(1);
         }
         this.SelectedRoodMc = param1.m_movie;
         this.SelectedRoodMc.gotoAndStop(2);
      }
      
      private function FightingOver(param1:Event, param2:XMovieClip) : void
      {
         this.PopButton.visible = false;
      }
      
      private function btn_beginClick(param1:MouseEvent) : void
      {
         if(this.CanStart == false)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss92"),0);
            return;
         }
         this.ReqestStatus(0);
      }
      
      private function btn_addfleetClick(param1:MouseEvent) : void
      {
         if(this.HasRoom)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss93"),0);
            return;
         }
         var _loc2_:GStar = GalaxyMapAction.instance.curStar;
         ShipTransferUI.instance.RequestJumpShips(_loc2_.GalaxyId,_loc2_.GalaxyMapId,3,0);
      }
      
      private function btn_searchClick(param1:MouseEvent) : void
      {
         if(this.txt_input.text != "")
         {
            this.RefreshPage(this.txt_input.text);
         }
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
      
      private function btn_lastClick(param1:MouseEvent) : void
      {
         this.PageId = this.PageCount - 1;
         if(this.PageId < 0)
         {
            this.PageId = 0;
         }
         this.RefreshPage();
      }
      
      private function btn_firstClick(param1:MouseEvent) : void
      {
         this.PageId = 0;
         this.RefreshPage();
      }
      
      private function btn_nextClick(param1:MouseEvent) : void
      {
         ++this.PageId;
         this.RefreshPage();
      }
      
      private function btn_prevClick(param1:MouseEvent) : void
      {
         --this.PageId;
         this.RefreshPage();
      }
      
      private function btn_leaveClick(param1:MouseEvent) : void
      {
         if(this.HasRoom == false)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss94"),0);
            return;
         }
         if(InstanceManager.instance.curStatus == 4)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss95"),2,this.LeaveRoom);
         }
         else
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss118"),0);
         }
      }
      
      private function LeaveRoom() : void
      {
         this.ReqestStatus(2);
         this.FormMC.mouseEnabled = true;
      }
      
      private function btn_joinClick(param1:MouseEvent) : void
      {
         if(this.HasRoom)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss96"),0);
            return;
         }
         if(InstanceManager.instance.curStatus != 0)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss97"),0);
            return;
         }
         if(this.SelectedRoom < 0)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss90"),0);
            return;
         }
         if(this.SelectedFleetList.length <= 0)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss98"),0);
            return;
         }
         var _loc2_:MSG_RESP_ARENA_PAGE_TEMP = this.RoomMsg.Data[this.SelectedRoom];
         this.SelectedRoomId = _loc2_.SrcGuid;
         if(_loc2_.PassKey != 0)
         {
            this.FormMC.addChild(this.ParentLock);
            this.FormMC.addChild(this.JoinForm);
            TextField(this.JoinForm.txt_password).text = "";
         }
         else
         {
            this.EnterForm(-1,this.SelectedRoomId);
         }
      }
      
      private function btn_cancelClick(param1:Event, param2:XButton) : void
      {
         if(this.HasRoom)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss99"),0);
            return;
         }
         var _loc3_:int = this.FleetPageId * 4 + param2.Data;
         if(_loc3_ >= this.SelectedFleetList.length)
         {
            return;
         }
         this.SelectedFleetList.splice(_loc3_,1);
         this.FleetPageCount = Math.ceil(this.SelectedFleetList.length / 4);
         if(this.FleetPageCount <= 0)
         {
            this.FleetPageId = 0;
         }
         this.ShowFleetList();
      }
      
      private function btn_backClick(param1:MouseEvent) : void
      {
         this.CloseClick(null);
         InstanceManager.instance.request_MSG_REQUEST_ECTYPEINFO(1);
         FightManager.instance.CleanFight();
      }
      
      private function TypeButtonClick(param1:Event, param2:XButton) : void
      {
         this.PageId = 0;
         this.PageCount = 0;
         this.ShowList(param2.Data);
      }
      
      private function CloseClick(param1:Event) : void
      {
         GameKernel.popUpDisplayManager.Hide(this);
      }
      
      public function Show() : void
      {
         this.Init();
         GameKernel.popUpDisplayManager.Show(this);
      }
      
      private function ShowCreateForm() : void
      {
         if(this.SelectedFleetList.length <= 0)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss98"),0);
            return;
         }
         this.FormMC.addChild(this.ParentLock);
         this.FormMC.addChild(this.CreateForm);
         TextField(this.CreateForm.txt_password).text = "";
      }
      
      private function ShowJoinForm() : void
      {
         this.FormMC.addChild(this.ParentLock);
         this.FormMC.addChild(this.JoinForm);
         TextField(this.JoinForm.txt_password).text = "";
      }
      
      private function btn_applyClick(param1:MouseEvent) : void
      {
         this.FormMC.removeChild(this.ParentLock);
         this.FormMC.removeChild(this.JoinForm);
         var _loc2_:int = -1;
         var _loc3_:TextField = TextField(this.JoinForm.txt_password);
         if(_loc3_.text != "")
         {
            _loc2_ = parseInt(_loc3_.text);
         }
         this.EnterForm(_loc2_,this.SelectedRoomId);
      }
      
      private function btn_closeJoinFormClick(param1:MouseEvent) : void
      {
         this.FormMC.removeChild(this.ParentLock);
         this.FormMC.removeChild(this.JoinForm);
      }
      
      private function btn_cancelFormClick(param1:MouseEvent) : void
      {
         this.FormMC.removeChild(this.ParentLock);
         this.FormMC.removeChild(this.CreateForm);
      }
      
      private function btn_creatFormClick(param1:MouseEvent) : void
      {
         this.FormMC.removeChild(this.ParentLock);
         this.FormMC.removeChild(this.CreateForm);
         var _loc2_:int = -1;
         var _loc3_:TextField = TextField(this.CreateForm.txt_password);
         if(_loc3_.text != "")
         {
            _loc2_ = parseInt(_loc3_.text);
         }
         this.EnterForm(_loc2_);
      }
      
      private function EnterForm(param1:int, param2:int = -1) : void
      {
         var _loc6_:MSG_RESP_JUMPGALAXYSHIP_TEMP = null;
         this.FormMC.mouseEnabled = false;
         var _loc3_:MSG_REQUEST_ECTYPE = new MSG_REQUEST_ECTYPE();
         _loc3_.DataLen = this.SelectedFleetList.length;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         while(_loc5_ < this.SelectedFleetList.length)
         {
            if(this.SelectedFleetList[_loc5_])
            {
               _loc6_ = this.SelectedFleetList[_loc5_][1] as MSG_RESP_JUMPGALAXYSHIP_TEMP;
               _loc3_.ShipTeamId[_loc4_] = _loc6_.ShipTeamId;
               _loc4_++;
            }
            _loc5_++;
         }
         _loc3_.RoomId = param2;
         _loc3_.EctypeId = 1001;
         _loc3_.PassKey = param1;
         _loc3_.SeqId = GamePlayer.getInstance().seqID++;
         _loc3_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc3_);
      }
      
      private function ReqestStatus(param1:int, param2:int = -1) : void
      {
         var _loc3_:MSG_REQUEST_ARENA_STATUS = new MSG_REQUEST_ARENA_STATUS();
         _loc3_.Request = param1;
         _loc3_.RoomId = param2;
         _loc3_.SeqId = GamePlayer.getInstance().seqID++;
         _loc3_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc3_);
         if(this.FormMC == null)
         {
            return;
         }
         this.FormMC.mouseEnabled = false;
      }
      
      public function Resp_MSG_RESP_ARENA_STATUS(param1:MSG_RESP_ARENA_STATUS) : void
      {
         var _loc2_:String = null;
         if(this.FormMC == null)
         {
            return;
         }
         this.FormMC.mouseEnabled = true;
         if(param1.Status == 1)
         {
            if(param1.Request == 100)
            {
               this.btn_join.setVisible(false);
               this.btn_create.setVisible(false);
               this.btn_begin.setVisible(true);
               this.btn_begin.setBtnDisabled(true);
               this.HasRoom = true;
               this.CanStart = false;
               this.IsOwer = true;
               this.RefreshPage();
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss100"),0);
            }
            else if(param1.Request == 101)
            {
               this.btn_create.setVisible(false);
               if(param1.RoomId == GamePlayer.getInstance().Guid)
               {
                  MessagePopup.getInstance().Show(param1.cName + StringManager.getInstance().getMessageString("Boss101"),2,this.StartMath);
                  this.btn_begin.setBtnDisabled(false);
                  this.CanStart = true;
               }
               else
               {
                  MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss102"),0);
                  this.btn_join.setBtnDisabled(true);
               }
               this.HasRoom = true;
               this.RefreshPage();
            }
            else if(param1.Request == 2)
            {
               if(param1.Guid == GamePlayer.getInstance().Guid)
               {
                  MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss103"),0);
                  this.CanStart = false;
                  this.IsOwer = false;
               }
               else
               {
                  MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss104"),0);
               }
               this.RefreshPage();
               if(this.CanStart == false)
               {
                  this.HasRoom = false;
                  this.CanStart = false;
                  this.btn_create.setVisible(true);
                  this.btn_join.setVisible(true);
                  this.btn_join.setBtnDisabled(false);
                  this.btn_begin.setVisible(false);
               }
               else
               {
                  this.CanStart = false;
                  this.btn_begin.setBtnDisabled(true);
               }
            }
            else if(param1.Request == 0)
            {
               this.CanStart = false;
               this.btn_leave.setVisible(false);
               this.btn_back.setVisible(true);
               this.btn_begin.setBtnDisabled(true);
               this.btn_join.setBtnDisabled(true);
            }
            else if(param1.Request == 1)
            {
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss105"),0);
               this.RefreshPage();
               this.HasRoom = false;
               this.CanStart = false;
               this.btn_create.setVisible(true);
               this.btn_join.setVisible(true);
            }
            else if(param1.Request == 5)
            {
               FightManager.instance.CleanFight();
               this.CloseClick(null);
               this.WatchStatus = 1;
            }
            else if(param1.Request == 6)
            {
               this.DoLeave();
            }
            else if(param1.Request == 3)
            {
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss115"),2,this.AgreeStop,this.RefuseStop);
            }
            else if(param1.Request == 4)
            {
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss116"),1);
            }
         }
         else
         {
            this.RefreshPage();
            if(param1.Request < 100)
            {
               _loc2_ = StringManager.getInstance().getMessageString("Boss" + int(106 + param1.Request));
            }
            else
            {
               _loc2_ = StringManager.getInstance().getMessageString("Boss" + int(12 + param1.Request));
            }
            MessagePopup.getInstance().Show(_loc2_,1);
         }
      }
      
      private function RefuseStop() : void
      {
         this.ReqestStatus(4);
      }
      
      private function AgreeStop() : void
      {
         this.ReqestStatus(3);
      }
      
      public function RequestLeave() : void
      {
         this.ReqestStatus(6);
      }
      
      public function DoLeave() : void
      {
         if(this.WatchStatus == 0)
         {
            return;
         }
         this.WatchStatus = 0;
         ConstructionAction.getInstance().forceOnConstructionModuel();
         FightManager.instance.CleanFight();
         GalaxyManager.instance.sendRequestGalaxy();
      }
      
      private function StartMath() : void
      {
         this.ReqestStatus(0);
      }
      
      public function RespRoomList(param1:MSG_RESP_ARENA_PAGE) : void
      {
         var _loc4_:MovieClip = null;
         var _loc5_:MSG_RESP_ARENA_PAGE_TEMP = null;
         var _loc6_:int = 0;
         var _loc7_:MovieClip = null;
         var _loc8_:Sprite = null;
         if(this.SelectedTypeId != param1.ArenaFlag)
         {
            return;
         }
         this.RoomMsg = param1;
         this.PageCount = param1.PageNum;
         this.PageId = param1.PageId;
         this.ResetRoomPageButton();
         var _loc2_:Array = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < this.SelectedRoomList.length)
         {
            _loc4_ = this.SelectedRoomList[_loc3_];
            if(_loc3_ < param1.DataLen)
            {
               _loc4_.visible = true;
               _loc4_.gotoAndStop(1);
               _loc5_ = param1.Data[_loc3_];
               _loc6_ = _loc3_ + 1;
               TextField(_loc4_.txt_name0).htmlText = "<a href=\'event:" + _loc6_ + "\'>" + _loc5_.SrcName + "</a>";
               TextField(_loc4_.txt_num0).text = _loc5_.SrcShipnum.toString();
               TextField(_loc4_.txt_name1).htmlText = "<a href=\'event:-" + _loc6_ + "\'>" + _loc5_.ObjName + "</a>";
               if(_loc5_.ObjShipnum > 0)
               {
                  TextField(_loc4_.txt_num1).text = _loc5_.ObjShipnum.toString();
               }
               else
               {
                  TextField(_loc4_.txt_num1).text = "";
               }
               _loc2_.push(_loc5_.SrcUserId);
               if(_loc5_.ObjUserId > 0)
               {
                  _loc2_.push(_loc5_.ObjUserId);
               }
               _loc7_ = MovieClip(_loc4_.mc_0.mc_base0);
               if(_loc7_.numChildren > 1)
               {
                  _loc7_.removeChildAt(1);
               }
               _loc7_ = MovieClip(_loc4_.mc_1.mc_base0);
               if(_loc7_.numChildren > 1)
               {
                  _loc7_.removeChildAt(1);
               }
               if(this.SelectedTypeId == 0)
               {
                  _loc8_ = Sprite(_loc4_.mc_lock);
                  _loc8_.visible = _loc5_.PassKey != 0;
               }
            }
            else
            {
               _loc4_.visible = false;
               _loc4_.gotoAndStop(1);
            }
            _loc3_++;
         }
         GameKernel.getPlayerFacebookInfoArray(_loc2_,this.getPlayerFacebookInfoArrayCallback);
      }
      
      private function getPlayerFacebookInfoArrayCallback(param1:Array) : void
      {
         var _loc2_:FacebookUserInfo = null;
         var _loc3_:int = 0;
         var _loc4_:MSG_RESP_ARENA_PAGE_TEMP = null;
         if(this.RoomMsg == null)
         {
            return;
         }
         for each(_loc2_ in param1)
         {
            _loc3_ = 0;
            while(_loc3_ < this.RoomMsg.DataLen)
            {
               _loc4_ = this.RoomMsg.Data[_loc3_];
               if(_loc4_.SrcUserId == _loc2_.uid || _loc4_.ObjUserId == _loc2_.uid)
               {
                  FleetInfoUI_Res.GetInstance().GetFacebookUserImg(_loc2_.uid,_loc2_.pic_square,this.GetFacebookUserImgCallback);
               }
               _loc3_++;
            }
         }
      }
      
      private function GetFacebookUserImgCallback(param1:Number, param2:DisplayObject) : void
      {
         var _loc4_:MSG_RESP_ARENA_PAGE_TEMP = null;
         var _loc5_:MovieClip = null;
         var _loc6_:Sprite = null;
         if(this.RoomMsg == null || param2 == null)
         {
            return;
         }
         var _loc3_:int = 0;
         while(_loc3_ < this.RoomMsg.DataLen)
         {
            _loc4_ = this.RoomMsg.Data[_loc3_];
            if(_loc4_.SrcUserId == param1)
            {
               _loc5_ = MovieClip(this.SelectedRoomList[_loc3_].mc_0);
            }
            else if(_loc4_.ObjUserId == param1)
            {
               _loc5_ = MovieClip(this.SelectedRoomList[_loc3_].mc_1);
            }
            if(_loc5_ != null)
            {
               _loc6_ = _loc5_.getChildByName("mc_base0") as Sprite;
               param2.width = _loc6_.width;
               param2.height = _loc6_.height;
               param2.x = 0;
               param2.y = 0;
               _loc6_.addChild(param2);
               break;
            }
            _loc3_++;
         }
      }
      
      public function RestStatus() : void
      {
         if(this.FormMC == null)
         {
            return;
         }
         if(InstanceManager.instance.curStatus != 0 && InstanceManager.instance.curEctype == 1001)
         {
            this.HasRoom = true;
            this.btn_create.setVisible(false);
            this.btn_back.setVisible(InstanceManager.instance.curStatus != InstanceManager.FB_WAITING);
            if(InstanceManager.instance.curStatus != InstanceManager.FB_WAITING)
            {
               this.CloseClick(null);
            }
            if(this.CanStart)
            {
               this.btn_join.setVisible(false);
               this.btn_begin.setVisible(true);
               this.btn_begin.setBtnDisabled(false);
            }
            else if(this.IsOwer)
            {
               this.btn_join.setVisible(false);
               this.btn_begin.setVisible(true);
               this.btn_begin.setBtnDisabled(true);
            }
            else
            {
               this.btn_join.setVisible(true);
               this.btn_join.setBtnDisabled(true);
               this.btn_begin.setVisible(false);
            }
         }
         else
         {
            this.HasRoom = false;
            this.CanStart = false;
            this.IsOwer = false;
            this.btn_back.setVisible(false);
            this.btn_create.setVisible(true);
            this.btn_begin.setVisible(false);
            this.btn_join.setVisible(true);
            this.btn_join.setBtnDisabled(false);
         }
      }
      
      public function StopWrestle() : void
      {
         this.ReqestStatus(3);
      }
   }
}

