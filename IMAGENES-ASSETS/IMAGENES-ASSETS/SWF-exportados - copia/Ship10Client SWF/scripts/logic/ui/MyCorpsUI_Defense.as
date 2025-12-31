package logic.ui
{
   import com.star.frameworks.facebook.FacebookUserInfo;
   import com.star.frameworks.managers.StringManager;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.text.StyleSheet;
   import flash.text.TextField;
   import flash.utils.Timer;
   import logic.action.ChatAction;
   import logic.entry.GamePlayer;
   import logic.game.GameKernel;
   import logic.manager.GalaxyManager;
   import logic.widget.DataWidget;
   import net.base.NetManager;
   import net.msg.corpsMsg.MSG_REQUEST_CONSORTIAATTACKINFO;
   import net.msg.corpsMsg.MSG_RESP_CONSORTIAATTACKINFO;
   import net.msg.corpsMsg.MSG_RESP_CONSORTIAATTACKINFO_TEMP;
   import net.msg.ship.MSG_REQUEST_VIEWJUMPSHIPTEAM;
   import net.msg.ship.MSG_RESP_VIEWJUMPSHIPTEAM;
   import net.router.MapRouter;
   
   public class MyCorpsUI_Defense implements MyCorpsUI_Base
   {
      
      private static var instance:MyCorpsUI_Defense;
      
      public var PageIndex:int;
      
      public var PageCount:int;
      
      private var _PageRows:int;
      
      private var McList:Array;
      
      private var SelectedRow:XButton;
      
      private var DefenseMsg:MSG_RESP_CONSORTIAATTACKINFO;
      
      private var UserIdList:Array;
      
      private var UserNameList:Array;
      
      private var _Timer:Timer;
      
      public function MyCorpsUI_Defense(param1:int)
      {
         var _loc3_:MovieClip = null;
         var _loc4_:XButton = null;
         var _loc5_:XButton = null;
         var _loc6_:XButton = null;
         var _loc7_:XTextField = null;
         var _loc8_:XTextField = null;
         var _loc9_:String = null;
         var _loc10_:StyleSheet = null;
         super();
         this.UserIdList = new Array();
         this.UserNameList = new Array();
         this._PageRows = param1;
         this.McList = new Array();
         this._Timer = new Timer(1000);
         this._Timer.addEventListener(TimerEvent.TIMER,this.UpdateTime);
         var _loc2_:int = 0;
         while(_loc2_ < this._PageRows)
         {
            _loc3_ = GameKernel.getMovieClipInstance("SourceslistPlan",0,0,false);
            _loc4_ = new XButton(_loc3_);
            _loc4_.OnMouseOver = this.RowClick;
            _loc5_ = new XButton(_loc3_.btn_help);
            _loc5_.Data = _loc2_;
            _loc5_.OnClick = this.btn_helpClick;
            _loc6_ = new XButton(_loc3_.btn_lookover);
            _loc6_.Data = _loc2_;
            _loc6_.OnClick = this.btn_lookoverClick;
            _loc7_ = new XTextField(_loc3_.tf_name);
            _loc7_.Data = _loc2_;
            _loc7_.OnClick = this.tf_nameClick;
            _loc8_ = new XTextField(_loc3_.tf_corpsfriend);
            _loc8_.Data = _loc2_;
            _loc8_.OnClick = this.tf_corpsfriendClick;
            _loc3_.mouseChildren = true;
            _loc3_.visible = false;
            this.McList.push(_loc3_);
            _loc9_ = "a:link{text-decoration: underline;} a:hover{color:#ff0000;text-decoration: underline;} a:active{text-decoration: underline;}";
            _loc10_ = new StyleSheet();
            _loc10_.parseCSS(_loc9_);
            _loc3_.tf_name.styleSheet = _loc10_;
            _loc3_.tf_corpsfriend.styleSheet = _loc10_;
            _loc2_++;
         }
      }
      
      public static function getInstance(param1:int = -1) : MyCorpsUI_Defense
      {
         if(instance == null)
         {
            instance = new MyCorpsUI_Defense(param1);
         }
         return instance;
      }
      
      private function Clear() : void
      {
         var _loc2_:MovieClip = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._PageRows)
         {
            _loc2_ = this.McList[_loc1_];
            _loc2_.visible = false;
            _loc1_++;
         }
      }
      
      public function GetList(param1:int = -1) : Array
      {
         if(param1 >= 0 && param1 < this.PageCount)
         {
            this.PageIndex = param1;
         }
         if(!this._Timer.running)
         {
            this._Timer.start();
         }
         this.RequestDefense();
         return this.McList;
      }
      
      public function GetPageIndex() : int
      {
         return this.PageIndex;
      }
      
      public function GetPageCount() : int
      {
         return this.PageCount;
      }
      
      public function NextPage() : Array
      {
         if(this.PageIndex + 1 < this.PageCount)
         {
            ++this.PageIndex;
            this.RequestDefense();
         }
         return this.McList;
      }
      
      public function PrePage() : Array
      {
         if(this.PageIndex > 0)
         {
            --this.PageIndex;
            this.RequestDefense();
         }
         return this.McList;
      }
      
      public function GetHeadString() : String
      {
         return StringManager.getInstance().getMessageString("CorpsText67");
      }
      
      private function RequestDefense() : void
      {
         var _loc1_:MSG_REQUEST_CONSORTIAATTACKINFO = null;
         if(GameKernel.getInstance().isInit)
         {
            _loc1_ = new MSG_REQUEST_CONSORTIAATTACKINFO();
            _loc1_.PageId = this.PageIndex;
            _loc1_.SeqId = GamePlayer.getInstance().seqID++;
            _loc1_.Guid = GamePlayer.getInstance().Guid;
            NetManager.Instance().sendObject(_loc1_);
         }
         this.Clear();
      }
      
      public function RespDefenseList(param1:MSG_RESP_CONSORTIAATTACKINFO) : void
      {
         this.DefenseMsg = param1;
         this.PageCount = param1.AttackCount / this._PageRows;
         if(this.PageCount * this._PageRows < param1.AttackCount)
         {
            ++this.PageCount;
         }
         MyCorpsUI.getInstance().ShowPageButton();
         this.ShowCurPage();
      }
      
      private function ShowCurPage() : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:MSG_RESP_CONSORTIAATTACKINFO_TEMP = null;
         var _loc4_:Point = null;
         if(this.DefenseMsg == null)
         {
            return;
         }
         this.UserIdList.splice(0);
         this.UserNameList.splice(0);
         var _loc1_:int = 0;
         while(_loc1_ < this._PageRows)
         {
            _loc2_ = this.McList[_loc1_];
            if(_loc1_ < this.DefenseMsg.DataLen)
            {
               _loc2_.visible = true;
               _loc3_ = this.DefenseMsg.Data[_loc1_];
               TextField(_loc2_.tf_name).htmlText = "<a href=\'event:\'>" + _loc3_.SrcName + "</a>";
               this.UserIdList.push(_loc3_.SrcUserId);
               this.UserNameList.push(_loc3_.SrcName);
               _loc4_ = GalaxyManager.getStarCoordinate(_loc3_.SrcGalaxyId);
               TextField(_loc2_.tf_location).text = _loc4_.x + "," + _loc4_.y;
               TextField(_loc2_.tf_corps).htmlText = "<a href=\'event:\'>" + _loc3_.SrcConsortiaName + "</a>";
               TextField(_loc2_.tf_states).text = StringManager.getInstance().getMessageString("CorpsText167");
               TextField(_loc2_.tf_corpsfriend).text = _loc3_.ObjName;
               this.UserIdList.push(_loc3_.ObjUserId);
               this.UserNameList.push(_loc3_.ObjName);
               _loc4_ = GalaxyManager.getStarCoordinate(_loc3_.ObjGalaxyId);
               TextField(_loc2_.tf_friendlocation).text = _loc4_.x + "," + _loc4_.y;
               TextField(_loc2_.tf_remaintime).text = DataWidget.secondFormatToTime(_loc3_.NeedTime);
            }
            else
            {
               _loc2_.visible = false;
            }
            _loc1_++;
         }
         GameKernel.getPlayerFacebookInfoArray(this.UserIdList,this.getPlayerFacebookInfoArrayCallback,this.UserNameList);
      }
      
      private function getPlayerFacebookInfoArrayCallback(param1:Array) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:FacebookUserInfo = null;
         var _loc4_:int = 0;
         var _loc5_:MSG_RESP_CONSORTIAATTACKINFO_TEMP = null;
         if(param1 == null)
         {
            return;
         }
         for each(_loc3_ in param1)
         {
            _loc4_ = 0;
            while(_loc4_ < this.DefenseMsg.DataLen)
            {
               _loc5_ = this.DefenseMsg.Data[_loc4_];
               if(_loc5_.SrcUserId == _loc3_.uid)
               {
                  _loc2_ = this.McList[_loc4_];
                  TextField(_loc2_.tf_name).htmlText = "<a href=\'event:\'>" + _loc3_.first_name + "</a>";
               }
               else if(_loc5_.ObjUserId == _loc3_.uid)
               {
                  _loc2_ = this.McList[_loc4_];
                  TextField(_loc2_.tf_corpsfriend).htmlText = "<a href=\'event:\'>" + _loc3_.first_name + "</a>";
               }
               _loc4_++;
            }
         }
      }
      
      private function RowClick(param1:MouseEvent, param2:XButton) : void
      {
         if(this.SelectedRow != null)
         {
            this.SelectedRow.setSelect(false);
         }
         this.SelectedRow = param2;
         this.SelectedRow.setSelect(true);
      }
      
      private function btn_helpClick(param1:MouseEvent, param2:XButton) : void
      {
         var _loc3_:MSG_RESP_CONSORTIAATTACKINFO_TEMP = this.DefenseMsg.Data[param2.Data];
         ShipTransferUI.instance.RequestJumpShips(_loc3_.ObjGalaxyId,GamePlayer.getInstance().galaxyMapID);
      }
      
      private function btn_lookoverClick(param1:MouseEvent, param2:XButton) : void
      {
         MapRouter.instance.MSG_RESP_VIEWJUMPSHIPTEAM_SrcType = 1;
         var _loc3_:MSG_RESP_CONSORTIAATTACKINFO_TEMP = this.DefenseMsg.Data[param2.Data];
         var _loc4_:MSG_REQUEST_VIEWJUMPSHIPTEAM = new MSG_REQUEST_VIEWJUMPSHIPTEAM();
         _loc4_.ShipTeamId = _loc3_.Reserve;
         _loc4_.Type = 1;
         _loc4_.SeqId = GamePlayer.getInstance().seqID++;
         _loc4_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc4_);
      }
      
      public function RespViewJumpShipTeam(param1:MSG_RESP_VIEWJUMPSHIPTEAM) : void
      {
         var _loc3_:MSG_RESP_CONSORTIAATTACKINFO_TEMP = null;
         if(this.DefenseMsg == null)
         {
            return;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this.DefenseMsg.DataLen)
         {
            _loc3_ = this.DefenseMsg.Data[_loc2_];
            if(_loc3_.Reserve == param1.ShipTeamId)
            {
               TransforingUI_View.getInstance().ShowShipTeamInfo(param1,_loc3_.SrcGalaxyId,DataWidget.localToDataZone(_loc3_.NeedTime),1);
               return;
            }
            _loc2_++;
         }
      }
      
      public function StopTimer() : void
      {
         this._Timer.stop();
      }
      
      private function UpdateTime(param1:Event) : void
      {
         var _loc4_:MSG_RESP_CONSORTIAATTACKINFO_TEMP = null;
         var _loc5_:MovieClip = null;
         var _loc6_:TextField = null;
         if(this.DefenseMsg == null)
         {
            return;
         }
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         while(_loc3_ < this.DefenseMsg.DataLen)
         {
            _loc4_ = this.DefenseMsg.Data[_loc3_];
            if(_loc4_.NeedTime > 0)
            {
               --_loc4_.NeedTime;
            }
            if(_loc4_.NeedTime > 0)
            {
               _loc5_ = this.McList[_loc3_];
               _loc6_ = _loc5_.getChildByName("tf_remaintime") as TextField;
               _loc6_.text = DataWidget.secondFormatToTime(_loc4_.NeedTime);
            }
            else
            {
               _loc2_ = true;
            }
            _loc3_++;
         }
         if(_loc2_)
         {
            this.RequestDefense();
         }
      }
      
      private function tf_nameClick(param1:MouseEvent, param2:XTextField) : void
      {
         if(this.DefenseMsg == null)
         {
            return;
         }
         var _loc3_:MSG_RESP_CONSORTIAATTACKINFO_TEMP = this.DefenseMsg.Data[param2.Data];
         PlayerInfoPopUp.Module = true;
         ChatAction.getInstance().sendChatUserInfoMessage(-1,_loc3_.SrcGuid,3);
      }
      
      private function tf_corpsfriendClick(param1:MouseEvent, param2:XTextField) : void
      {
         if(this.DefenseMsg == null)
         {
            return;
         }
         var _loc3_:MSG_RESP_CONSORTIAATTACKINFO_TEMP = this.DefenseMsg.Data[param2.Data];
         ChatAction.getInstance().sendChatUserInfoMessage(-1,_loc3_.ObjGuid,3);
      }
   }
}

