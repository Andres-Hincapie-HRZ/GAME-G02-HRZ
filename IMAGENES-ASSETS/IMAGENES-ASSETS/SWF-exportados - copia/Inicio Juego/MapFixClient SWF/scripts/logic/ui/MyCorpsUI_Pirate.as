package logic.ui
{
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.managers.FontManager;
   import com.star.frameworks.managers.StringManager;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Point;
   import flash.text.StyleSheet;
   import flash.text.TextField;
   import logic.action.ChatAction;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.game.GameKernel;
   import logic.game.GameMouseZoneManager;
   import logic.manager.GalaxyManager;
   import logic.reader.CorpsPirateReader;
   import logic.ui.info.BleakingLineForThai;
   import logic.ui.tip.PirateTip;
   import net.base.NetManager;
   import net.msg.corpsMsg.MSG_REQUEST_CONSORTIAPIRATE;
   import net.msg.corpsMsg.MSG_REQUEST_CONSORTIAPIRATECHOOSE;
   import net.msg.corpsMsg.MSG_RESP_CONSORTIAMYSELF;
   import net.msg.corpsMsg.MSG_RESP_CONSORTIAPIRATECHOOSE;
   import net.msg.corpsMsg.MSG_RESP_INSERTFLAGCONSORTIAIMEMBER_TEMP;
   
   public class MyCorpsUI_Pirate
   {
      
      private static var instance:MyCorpsUI_Pirate;
      
      public var McPirate:MovieClip;
      
      private var _CorpsInfo:MSG_RESP_CONSORTIAMYSELF;
      
      private var SelectedUser:MSG_RESP_INSERTFLAGCONSORTIAIMEMBER_TEMP;
      
      private var SelectedLevel:int;
      
      private var btn_selected:HButton;
      
      private var btn_star:HButton;
      
      private var LastFrame:int;
      
      private var LastOver:XMovieClip;
      
      private var SelectedLvelMc:MovieClip;
      
      public function MyCorpsUI_Pirate()
      {
         var _loc4_:MovieClip = null;
         var _loc5_:XMovieClip = null;
         super();
         this.McPirate = GameKernel.getMovieClipInstance("PirateScene",0,0,false);
         var _loc1_:int = 0;
         while(_loc1_ < 10)
         {
            _loc4_ = this.McPirate.getChildByName("mc_pirateclass" + _loc1_) as MovieClip;
            _loc5_ = new XMovieClip(_loc4_);
            _loc5_.Data = _loc1_;
            _loc5_.OnClick = this.LevelClick;
            _loc5_.OnMouseOver = this.LevelMouseOver;
            _loc4_.addEventListener(MouseEvent.ROLL_OUT,this.LevelMouseOut);
            _loc1_++;
         }
         this.btn_selected = new HButton(this.McPirate.btn_selected);
         this.btn_selected.m_movie.addEventListener(MouseEvent.CLICK,this.btn_selectedClick);
         this.btn_star = new HButton(this.McPirate.btn_star);
         this.btn_star.m_movie.addEventListener(MouseEvent.CLICK,this.btn_starClick);
         this.McPirate.txt_escriptive.setStyle("textFormat",FontManager.getInstance().getTextFormat("Tahoma",12,6667519));
         this.McPirate.txt_escriptive.editable = false;
         this.McPirate.txt_escriptive.htmlText = StringManager.getInstance().getMessageString("Pirate14");
         this.ResetTextareaForThai();
         TextField(this.McPirate.txt_defend).addEventListener(ActionEvent.ACTION_TEXT_LINK,this.txt_defendClick);
         TextField(this.McPirate.txt_coordinate).addEventListener(ActionEvent.ACTION_TEXT_LINK,this.txt_coordinateClick);
         var _loc2_:String = "a:link{text-decoration: underline;} a:hover{color:#ff0000;text-decoration: underline;} a:active{text-decoration: underline;}";
         var _loc3_:StyleSheet = new StyleSheet();
         _loc3_.parseCSS(_loc2_);
         TextField(this.McPirate.txt_defend).styleSheet = _loc3_;
         TextField(this.McPirate.txt_coordinate).styleSheet = _loc3_;
         this.SelectedLevel = -1;
         this.SelectedUser = null;
      }
      
      public static function getInstance() : MyCorpsUI_Pirate
      {
         if(instance == null)
         {
            instance = new MyCorpsUI_Pirate();
         }
         return instance;
      }
      
      private function ResetTextareaForThai() : void
      {
         if(GamePlayer.getInstance().language != 7)
         {
            return;
         }
         var _loc1_:Object = this.McPirate.txt_escriptive;
         var _loc2_:TextField = new TextField();
         _loc2_.width = _loc1_.width - 25;
         _loc2_.multiline = true;
         _loc2_.wordWrap = true;
         _loc2_.setTextFormat(FontManager.getInstance().getTextFormat("Tahoma",12,6667519));
         _loc2_.htmlText = _loc1_.htmlText;
         BleakingLineForThai.GetInstance().BleakThaiLanguage(_loc2_,6667519);
         _loc1_.htmlText = _loc2_.htmlText;
      }
      
      public function Clear(param1:MSG_RESP_CONSORTIAMYSELF) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:XML = null;
         this._CorpsInfo = param1;
         TextField(this.McPirate.txt_time).text = "0";
         var _loc2_:int = 0;
         while(_loc2_ < 10)
         {
            _loc3_ = this.McPirate.getChildByName("mc_pirateclass" + _loc2_) as MovieClip;
            _loc3_.buttonMode = true;
            _loc4_ = CorpsPirateReader.GetPirateInfo(_loc2_);
            if(_loc4_.@CorpsLv <= param1.Level && _loc4_.@Level - 1 <= this._CorpsInfo.PiratePassLevel)
            {
               _loc3_.gotoAndStop("disabled");
            }
            else
            {
               _loc3_.gotoAndStop("up");
            }
            _loc2_++;
         }
         if(this.SelectedLvelMc != null)
         {
            this.SelectedLvelMc.gotoAndStop("selected");
         }
         if(this._CorpsInfo.AttackUser != "")
         {
            this.SelectedUser = new MSG_RESP_INSERTFLAGCONSORTIAIMEMBER_TEMP();
            this.SelectedUser.Guid = -1;
            this.SelectedUser.Assault = this._CorpsInfo.AttackUserAssault;
            this.SelectedUser.GalaxyId = this._CorpsInfo.AttackUserGalaxyId;
            this.SelectedUser.LevelId = this._CorpsInfo.AttackUserLevel;
            this.SelectedUser.Name = this._CorpsInfo.AttackUser;
            this.ShowSelectedUser(this.SelectedUser);
            this.btn_selected.setBtnDisabled(true);
            this.btn_star.setBtnDisabled(true);
            return;
         }
         if(this._CorpsInfo.PirateNum > 0)
         {
            this.btn_selected.setBtnDisabled(true);
            this.btn_star.setBtnDisabled(true);
            return;
         }
         this.SelectedLevel = -1;
         this.SelectedUser = null;
         TextField(this.McPirate.txt_defend).text = "";
         TextField(this.McPirate.txt_coordinate).text = "";
         TextField(this.McPirate.txt_battle).text = "";
         TextField(this.McPirate.txt_class0).text = "";
         TextField(this.McPirate.txt_time).text = int(1 - this._CorpsInfo.PirateNum).toString();
         this.btn_selected.setBtnDisabled(GamePlayer.getInstance().ConsortiaJob != 1);
         this.btn_star.setBtnDisabled(GamePlayer.getInstance().ConsortiaJob != 1);
      }
      
      private function LevelMouseOver(param1:Event, param2:XMovieClip) : void
      {
         this.LastOver = null;
         var _loc3_:XML = CorpsPirateReader.GetPirateInfo(param2.Data);
         if(_loc3_.@CorpsLv <= this._CorpsInfo.Level && _loc3_.@Level - 1 <= this._CorpsInfo.PiratePassLevel && this.SelectedLvelMc != param2.m_movie)
         {
            this.LastOver = param2;
            param2.m_movie.gotoAndStop("over");
         }
         var _loc4_:Point = param2.m_movie.localToGlobal(new Point(0,param2.m_movie.height));
         PirateTip.GetInstance().ShowPirateTip(param2.Data,_loc4_,this._CorpsInfo.Wealth,this._CorpsInfo.PiratePassLevel,this._CorpsInfo.Level);
      }
      
      private function LevelMouseOut(param1:Event) : void
      {
         PirateTip.GetInstance().Hide();
         if(this.LastOver == null)
         {
            return;
         }
         this.LastOver.m_movie.gotoAndStop("disabled");
      }
      
      private function LevelClick(param1:Event, param2:XMovieClip) : void
      {
         var _loc6_:String = null;
         PirateTip.GetInstance().Hide();
         var _loc3_:XML = CorpsPirateReader.GetPirateInfo(param2.Data);
         var _loc4_:int = int(_loc3_.@CorpsLv);
         if(_loc3_.@CorpsLv > this._CorpsInfo.Level)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Pirate20"),1);
            return;
         }
         if(_loc3_.@wealth > this._CorpsInfo.Wealth)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Pirate11"),1);
            return;
         }
         var _loc5_:int = int(_loc3_.@Level);
         if(_loc5_ - 1 > this._CorpsInfo.PiratePassLevel)
         {
            _loc6_ = StringManager.getInstance().getMessageString("Pirate17");
            _loc6_ = _loc6_.replace("@@1"," [" + CorpsPirateReader.GetPirateInfo(_loc5_ - 1).@Name + "]");
            MessagePopup.getInstance().Show(_loc6_,1);
            return;
         }
         this.SelectedLevel = _loc3_.@Level;
         if(this.SelectedLvelMc != null)
         {
            this.SelectedLvelMc.gotoAndStop("disabled");
         }
         this.SelectedLvelMc = param2.m_movie;
         this.SelectedLvelMc.gotoAndStop("selected");
      }
      
      private function btn_selectedClick(param1:Event) : void
      {
         LoserPopUI.getInstance().ShowConsortia(this._CorpsInfo.ConsortiaId,true);
      }
      
      private function btn_starClick(param1:Event) : void
      {
         if(this.SelectedUser == null)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Pirate16"),1);
            return;
         }
         if(this.SelectedLevel < 0)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Pirate15"),1);
            return;
         }
         var _loc2_:MSG_REQUEST_CONSORTIAPIRATE = new MSG_REQUEST_CONSORTIAPIRATE();
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.ObjGuid = this.SelectedUser.Guid;
         _loc2_.Level = this.SelectedLevel;
         NetManager.Instance().sendObject(_loc2_);
         ++this._CorpsInfo.PirateNum;
         this._CorpsInfo.AttackUserAssault = this.SelectedUser.Assault;
         this._CorpsInfo.AttackUserGalaxyId = this.SelectedUser.GalaxyId;
         this._CorpsInfo.AttackUserLevel = this.SelectedUser.LevelId;
         this._CorpsInfo.AttackUser = this.SelectedUser.Name;
         this.Clear(this._CorpsInfo);
      }
      
      public function SelecteUser(param1:MSG_RESP_INSERTFLAGCONSORTIAIMEMBER_TEMP) : void
      {
         this.SelectedUser = null;
         var _loc2_:MSG_REQUEST_CONSORTIAPIRATECHOOSE = new MSG_REQUEST_CONSORTIAPIRATECHOOSE();
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.ObjGuid = param1.Guid;
         NetManager.Instance().sendObject(_loc2_);
      }
      
      public function Resp_MSG_RESP_CONSORTIAPIRATECHOOSE(param1:MSG_RESP_CONSORTIAPIRATECHOOSE) : void
      {
         if(param1.ErrorCode == 0)
         {
            this.SelectedUser = new MSG_RESP_INSERTFLAGCONSORTIAIMEMBER_TEMP();
            this.SelectedUser.Guid = param1.ObjGuid;
            this.SelectedUser.Assault = param1.Assault;
            this.SelectedUser.GalaxyId = param1.GalaxyId;
            this.SelectedUser.LevelId = param1.LevelId;
            this.SelectedUser.Name = param1.ObjName;
            this.ShowSelectedUser(this.SelectedUser);
         }
         else
         {
            this.SelectedUser = null;
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Pirate0" + int(4 + param1.ErrorCode)),1);
         }
      }
      
      private function ShowSelectedUser(param1:MSG_RESP_INSERTFLAGCONSORTIAIMEMBER_TEMP) : void
      {
         TextField(this.McPirate.txt_defend).htmlText = "<a href=\'event:\'>" + param1.Name + "</a>";
         var _loc2_:Point = GalaxyManager.getStarCoordinate(param1.GalaxyId);
         TextField(this.McPirate.txt_coordinate).htmlText = "<a href=\'event:\'>" + _loc2_.x + "," + _loc2_.y + "</a>";
         TextField(this.McPirate.txt_battle).text = param1.Assault.toString();
         TextField(this.McPirate.txt_class0).text = int(param1.LevelId + 1).toString();
      }
      
      private function txt_defendClick(param1:TextEvent) : void
      {
         if(this.SelectedUser == null)
         {
            return;
         }
         ChatAction.getInstance().sendChatUserInfoMessage(this.SelectedUser.GalaxyId,-1,3);
      }
      
      private function txt_coordinateClick(param1:TextEvent) : void
      {
         if(this.SelectedUser == null)
         {
            return;
         }
         GameMouseZoneManager.NagivateToolBarByName("btn_universe",true);
         var _loc2_:Point = GalaxyManager.getStarCoordinate(this.SelectedUser.GalaxyId);
         GotoGalaxyUI.instance.GotoGalaxy(_loc2_.x,_loc2_.y);
      }
   }
}

