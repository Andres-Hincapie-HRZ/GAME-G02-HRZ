package logic.ui
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.facebook.FacebookUserInfo;
   import com.star.frameworks.managers.FontManager;
   import com.star.frameworks.managers.StringManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   import logic.action.ConstructionAction;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.HButtonType;
   import logic.entry.MObject;
   import logic.game.GameKernel;
   import logic.game.GameMouseZoneManager;
   import logic.reader.CcorpsReader;
   import logic.widget.DataWidget;
   import logic.widget.NotifyWidget;
   import net.base.NetManager;
   import net.msg.corpsMsg.MSG_REQUEST_CONSORTIAMYSELF;
   import net.msg.corpsMsg.MSG_REQUEST_EDITCONSORTIA;
   import net.msg.corpsMsg.MSG_RESP_CONSORTIAMEMBER;
   import net.msg.corpsMsg.MSG_RESP_CONSORTIAMYSELF;
   import net.msg.corpsMsg.MSG_RESP_CONSORTIAUPGRADE;
   import net.msg.corpsMsg.MSG_RESP_CONSORTIAUPGRADECANCEL;
   
   public class MyCorpsUI
   {
      
      private static var instance:MyCorpsUI;
      
      private var ParentLock:Container;
      
      private var _mc:MObject;
      
      private var tf_treasure:TextField;
      
      private var tf_maintenance:TextField;
      
      private var btn_left:HButton;
      
      private var btn_right:HButton;
      
      private var tf_page:TextField;
      
      private var tf_notice:Object;
      
      private var btn_member:HButton;
      
      private var btn_demesne:HButton;
      
      private var btn_matter:HButton;
      
      private var btn_diplomatism:HButton;
      
      private var btn_recruit:HButton;
      
      private var btn_enounce:HButton;
      
      private var btn_defense:HButton;
      
      private var btn_ensure:HButton;
      
      private var btn_cancel:HButton;
      
      private var btn_change:HButton;
      
      private var btn_upgrade:HButton;
      
      private var btn_equipment:HButton;
      
      private var btn_jobmanage:HButton;
      
      private var btn_editnotice:HButton;
      
      private var LastSelectedBtn:HButton;
      
      private var tf_corpsenounce:Object;
      
      private var _MyCorpsUI_Member:MyCorpsUI_Member;
      
      private var _MyCorpsUI_Recruit:MyCorpsUI_Recruit;
      
      private var _MyCorpsUI_Demesne:MyCorpsUI_Demesne;
      
      private var _MyCorpsUI_Defense:MyCorpsUI_Defense;
      
      private var _MyCorpsUI_Matterlist:MyCorpsUI_Matterlist;
      
      private var _MyCorpsUI_Pirate:MyCorpsUI_Pirate;
      
      private var SelectdListUI:MyCorpsUI_Base;
      
      private var tf_navigation:TextField;
      
      private var CorpsInfo:MSG_RESP_CONSORTIAMYSELF;
      
      private var tf_corpsres:TextField;
      
      public var _ConsortiaJobName:Array;
      
      private var btn_corpsmall:HButton;
      
      private var btn_compose:HButton;
      
      private var btn_personalstorage:HButton;
      
      private var mc_corpstime:MovieClip;
      
      private var UpgradeTimer:Timer;
      
      private var mc_corpstimeLen:int;
      
      private var tf_corpsenounceColor:int;
      
      private var btn_matterall:XButton;
      
      private var btn_matterupgrade:XButton;
      
      private var btn_matterbattle:XButton;
      
      private var btn_mattermember:XButton;
      
      private var btn_matterother:XButton;
      
      private var SelectedMatterButton:XButton;
      
      private var SelectedUserId:Number;
      
      private var UpgradeTime:int;
      
      public function MyCorpsUI()
      {
         super();
         this.Init();
      }
      
      public static function getInstance() : MyCorpsUI
      {
         if(instance == null)
         {
            instance = new MyCorpsUI();
         }
         return instance;
      }
      
      public function Show(param1:int = 0) : void
      {
         NotifyWidget.getInstance().removeNotify(3);
         this.Refresh();
         this.ParentLock.fillRectangleWithoutBorder(GameKernel.fullRect.left,GameKernel.fullRect.top,GameKernel.fullRect.width,GameKernel.fullRect.height + 130,0,0.5);
         GameKernel.renderManager.getUI().addComponent(this.ParentLock);
         this.ParentLock.addChild(this._mc.getMC());
         if(param1 == 0)
         {
            this.btn_memberClick(null);
         }
         else if(param1 == 1)
         {
            this.btn_defenseClick(null);
         }
      }
      
      public function Refresh() : void
      {
         this.Clear();
         this.RequestMyCorpsInfo();
      }
      
      public function Hide(param1:Boolean = true) : void
      {
         this.UpgradeTimer.stop();
         this.CorpsInfo = null;
         this.ParentLock.removeChild(this._mc.getMC());
         GameKernel.renderManager.getUI().removeComponent(this.ParentLock);
         CorpsListUI.getInstance().Close(param1);
      }
      
      public function Init() : void
      {
         this._mc = new MObject("MycorpsScene",GameKernel.fullRect.width / 2 + GameKernel.fullRect.x,300);
         this.initMcElement();
         this._MyCorpsUI_Member = new MyCorpsUI_Member(6);
         this._MyCorpsUI_Recruit = MyCorpsUI_Recruit.getInstance(6);
         this._MyCorpsUI_Demesne = MyCorpsUI_Demesne.getInstance(6);
         this._MyCorpsUI_Defense = MyCorpsUI_Defense.getInstance(6);
         this._MyCorpsUI_Matterlist = MyCorpsUI_Matterlist.getInstance(9);
         this._MyCorpsUI_Pirate = MyCorpsUI_Pirate.getInstance();
         var _loc1_:MovieClip = this._mc.getMC().getChildByName("mc_list0") as MovieClip;
         this._MyCorpsUI_Pirate.McPirate.x = this.tf_navigation.x;
         this._MyCorpsUI_Pirate.McPirate.y = this.tf_navigation.y;
         this._mc.getMC().addChild(this._MyCorpsUI_Pirate.McPirate);
         this._MyCorpsUI_Pirate.McPirate.visible = false;
      }
      
      public function initMcElement() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:HButton = null;
         _loc1_ = this._mc.getMC().getChildByName("btn_close") as MovieClip;
         _loc2_ = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_closeClick);
         _loc1_ = this._mc.getMC().getChildByName("btn_member") as MovieClip;
         this.btn_member = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_memberClick);
         _loc1_ = this._mc.getMC().getChildByName("btn_demesne") as MovieClip;
         this.btn_demesne = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_demesneClick);
         _loc1_ = this._mc.getMC().getChildByName("btn_matter") as MovieClip;
         this.btn_matter = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_matterClick);
         _loc1_ = this._mc.getMC().getChildByName("btn_diplomatism") as MovieClip;
         this.btn_diplomatism = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_diplomatismClick);
         _loc1_ = this._mc.getMC().getChildByName("btn_recruit") as MovieClip;
         this.btn_recruit = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_recruitClick);
         _loc1_ = this._mc.getMC().getChildByName("btn_enounce") as MovieClip;
         this.btn_enounce = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_enounceClick);
         _loc1_ = this._mc.getMC().getChildByName("btn_sources") as MovieClip;
         this.btn_defense = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_defenseClick);
         _loc1_ = this._mc.getMC().getChildByName("btn_ensure") as MovieClip;
         this.btn_ensure = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_ensureClick);
         _loc1_ = this._mc.getMC().getChildByName("btn_cancel") as MovieClip;
         this.btn_cancel = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_cancelClick);
         _loc1_ = this._mc.getMC().getChildByName("btn_editnotice") as MovieClip;
         this.btn_editnotice = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_editnoticeClick);
         _loc1_ = this._mc.getMC().getChildByName("btn_contribute") as MovieClip;
         _loc2_ = new HButton(_loc1_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("CorpsText0"),true);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_contributeClick);
         _loc1_ = this._mc.getMC().getChildByName("btn_corpsmall") as MovieClip;
         this.btn_corpsmall = new HButton(_loc1_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("CorpsText1"),true);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_corpsmallClick);
         _loc1_ = this._mc.getMC().getChildByName("btn_compose") as MovieClip;
         this.btn_compose = new HButton(_loc1_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("CorpsText2"),true);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_composeClick);
         _loc1_ = this._mc.getMC().getChildByName("btn_personalstorage") as MovieClip;
         this.btn_personalstorage = new HButton(_loc1_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("CorpsText3"),true);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_personalstorageClick);
         _loc1_ = this._mc.getMC().getChildByName("btn_jobmanage") as MovieClip;
         this.btn_jobmanage = new HButton(_loc1_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("CorpsText4"),true);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_jobmanageClick);
         _loc1_ = this._mc.getMC().getChildByName("btn_upgrade") as MovieClip;
         this.btn_upgrade = new HButton(_loc1_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("CorpsText5"),true);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_upgradeClick);
         _loc1_ = this._mc.getMC().getChildByName("btn_change") as MovieClip;
         this.btn_change = new HButton(_loc1_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("CorpsText6"),true);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_changeClick);
         _loc1_ = this._mc.getMC().getChildByName("btn_equipment") as MovieClip;
         this.btn_equipment = new HButton(_loc1_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("CorpsText7"),true);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_equipmentClick);
         this.tf_treasure = this._mc.getMC().getChildByName("tf_treasure") as TextField;
         this.tf_maintenance = this._mc.getMC().getChildByName("tf_maintenance") as TextField;
         _loc1_ = this._mc.getMC().getChildByName("btn_left") as MovieClip;
         this.btn_left = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_leftClick);
         _loc1_ = this._mc.getMC().getChildByName("btn_right") as MovieClip;
         this.btn_right = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_rightClick);
         this.tf_page = this._mc.getMC().getChildByName("tf_page") as TextField;
         this.tf_corpsenounce = this._mc.getMC().getChildByName("mcq_corpsenounce");
         this.tf_corpsenounce.setStyle("textFormat",FontManager.getInstance().getTextFormat("Tahoma",13,6667519));
         this.tf_notice = this._mc.getMC().getChildByName("tf_notice") as Object;
         if(GamePlayer.getInstance().language == 0)
         {
            this.tf_corpsenounce.maxChars = 64;
            this.tf_notice.maxChars = 64;
         }
         else
         {
            this.tf_corpsenounce.maxChars = 128;
            this.tf_notice.maxChars = 128;
         }
         this.tf_notice.setStyle("textFormat",FontManager.getInstance().getTextFormat("Tahoma",13,6667519));
         this.tf_navigation = this._mc.getMC().getChildByName("tf_navigation") as TextField;
         this.tf_corpsres = this._mc.getMC().getChildByName("tf_corpsres") as TextField;
         this.mc_corpstime = this._mc.getMC().getChildByName("mc_corpstime") as MovieClip;
         this.mc_corpstimeLen = this.mc_corpstime.width - 28;
         this.ParentLock = new Container("MyCorpsUISceneLock");
         this.ParentLock.mouseEnabled = true;
         this.ParentLock.mouseChildren = true;
         this.ParentLock.fillRectangleWithoutBorder(GameKernel.fullRect.x,GameKernel.fullRect.y,GameKernel.fullRect.width,GameKernel.fullRect.height,0,0.5);
         this.UpgradeTimer = new Timer(1000);
         this.UpgradeTimer.addEventListener(TimerEvent.TIMER,this.OnUpgradeTimer);
         this.InitMatterButton();
      }
      
      private function InitMatterButton() : void
      {
         var _loc1_:MovieClip = null;
         _loc1_ = this._mc.getMC().getChildByName("btn_matterall") as MovieClip;
         this.btn_matterall = new XButton(_loc1_);
         this.btn_matterall.Data = -1;
         this.btn_matterall.OnClick = this.MatterButtonClick;
         _loc1_ = this._mc.getMC().getChildByName("btn_matterupgrade") as MovieClip;
         this.btn_matterupgrade = new XButton(_loc1_);
         this.btn_matterupgrade.Data = 0;
         this.btn_matterupgrade.OnClick = this.MatterButtonClick;
         _loc1_ = this._mc.getMC().getChildByName("btn_matterbattle") as MovieClip;
         this.btn_matterbattle = new XButton(_loc1_);
         this.btn_matterbattle.Data = 2;
         this.btn_matterbattle.OnClick = this.MatterButtonClick;
         _loc1_ = this._mc.getMC().getChildByName("btn_mattermember") as MovieClip;
         this.btn_mattermember = new XButton(_loc1_);
         this.btn_mattermember.Data = 1;
         this.btn_mattermember.OnClick = this.MatterButtonClick;
         _loc1_ = this._mc.getMC().getChildByName("btn_matterother") as MovieClip;
         this.btn_matterother = new XButton(_loc1_);
         this.btn_matterother.Data = 3;
         this.btn_matterother.OnClick = this.MatterButtonClick;
      }
      
      private function MatterButtonClick(param1:MouseEvent, param2:XButton) : void
      {
         if(this.SelectedMatterButton != null)
         {
            this.SelectedMatterButton.setSelect(false);
         }
         this.SelectedMatterButton = param2;
         this.SelectedMatterButton.setSelect(true);
         this._MyCorpsUI_Matterlist.SetEventType(param2.Data);
      }
      
      private function SetMatterButtonVisible(param1:Boolean) : void
      {
         this.btn_matterall.setVisible(param1);
         this.btn_matterupgrade.setVisible(param1);
         this.btn_matterbattle.setVisible(param1);
         this.btn_mattermember.setVisible(param1);
         this.btn_matterother.setVisible(param1);
      }
      
      private function Clear() : void
      {
         var _loc1_:TextField = null;
         var _loc2_:MovieClip = null;
         this.btn_left.setBtnDisabled(true);
         this.btn_right.setBtnDisabled(true);
         this.tf_page.text = "";
         _loc1_ = this._mc.getMC().getChildByName("tf_corpsname") as TextField;
         _loc1_.text = "";
         _loc1_ = this._mc.getMC().getChildByName("tf_corpsofficer") as TextField;
         _loc1_.text = "";
         _loc1_ = this._mc.getMC().getChildByName("tf_membernum") as TextField;
         _loc1_.text = "";
         _loc1_ = this._mc.getMC().getChildByName("tf_corpsranking") as TextField;
         _loc1_.text = "";
         _loc1_ = this._mc.getMC().getChildByName("tf_treasure") as TextField;
         _loc1_.text = "";
         this.tf_corpsenounce.text = StringManager.getInstance().getMessageString("CorpsText60");
         _loc2_ = this._mc.getMC().getChildByName("btn_editnotice") as MovieClip;
         this.btn_upgrade.setBtnDisabled(GamePlayer.getInstance().ConsortiaJob != 1);
         this.btn_change.setBtnDisabled(GamePlayer.getInstance().ConsortiaJob != 1);
         this.btn_jobmanage.setBtnDisabled(GamePlayer.getInstance().ConsortiaJob != 1);
         if(GamePlayer.getInstance().ConsortiaJob == 1 || GamePlayer.getInstance().ConsortiaJob == 2)
         {
            this.btn_recruit.setBtnDisabled(false);
            this.btn_editnotice.setVisible(true);
            _loc2_.visible = true;
            this.tf_notice.editable = true;
            this.tf_corpsenounce.editable = true;
         }
         else
         {
            if(GamePlayer.getInstance().ConsortiaJob == 3)
            {
               this.btn_recruit.setBtnDisabled(false);
            }
            else
            {
               this.btn_recruit.setBtnDisabled(true);
            }
            this.btn_upgrade.setBtnDisabled(true);
            this.btn_change.setBtnDisabled(true);
            this.btn_jobmanage.setBtnDisabled(true);
            this.btn_editnotice.setVisible(false);
            _loc2_.visible = false;
            this.tf_notice.editable = false;
            this.tf_corpsenounce.editable = false;
         }
         this.mc_corpstime.visible = false;
      }
      
      private function SetListVisible(param1:Boolean) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < 6)
         {
            _loc2_ = this._mc.getMC().getChildByName("mc_list" + _loc3_) as MovieClip;
            if(param1 == false && _loc2_.numChildren > 0)
            {
               _loc2_.removeChildAt(0);
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < 9)
         {
            _loc2_ = this._mc.getMC().getChildByName("mc_matterlist" + _loc3_) as MovieClip;
            if(param1 == false && _loc2_.numChildren > 0)
            {
               _loc2_.removeChildAt(0);
            }
            _loc3_++;
         }
         this.btn_left.setVisible(false);
         this.btn_right.setVisible(false);
         this.tf_page.text = "";
         this._MyCorpsUI_Pirate.McPirate.visible = false;
      }
      
      private function HideList(param1:int) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < 6)
         {
            _loc2_ = this._mc.getMC().getChildByName("mc_list" + _loc3_) as MovieClip;
            _loc2_.visible = param1 == 0;
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < 9)
         {
            _loc2_ = this._mc.getMC().getChildByName("mc_matterlist" + _loc3_) as MovieClip;
            _loc2_.visible = param1 == 1;
            _loc3_++;
         }
         this.SetMatterButtonVisible(param1 == 1);
      }
      
      public function RequestMyCorpsInfo() : void
      {
         this._MyCorpsUI_Member.ClearMyCorpsMemberList();
         var _loc1_:MSG_REQUEST_CONSORTIAMYSELF = new MSG_REQUEST_CONSORTIAMYSELF();
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc1_);
      }
      
      public function AddMember() : void
      {
         ++this.CorpsInfo.MemberCount;
         var _loc1_:TextField = this._mc.getMC().getChildByName("tf_membernum") as TextField;
         _loc1_.text = this.CorpsInfo.MemberCount + "/" + this.CorpsInfo.MaxMemberCount;
      }
      
      public function DeleteMember() : void
      {
         --this.CorpsInfo.MemberCount;
         var _loc1_:TextField = this._mc.getMC().getChildByName("tf_membernum") as TextField;
         _loc1_.text = this.CorpsInfo.MemberCount + "/" + this.CorpsInfo.MaxMemberCount;
      }
      
      private function getPlayerFacebookInfoCallback(param1:FacebookUserInfo) : void
      {
         var _loc2_:TextField = null;
         if(param1 != null && this.SelectedUserId == param1.uid)
         {
            _loc2_ = this._mc.getMC().getChildByName("tf_corpsofficer") as TextField;
            _loc2_.text = param1.first_name;
         }
      }
      
      private function ShowCorpsUpgradeInfo() : void
      {
         if(this.CorpsInfo == null)
         {
            return;
         }
         var _loc1_:XML = CcorpsReader.getInstance().GetCorpsUpgradeInfo(this.CorpsInfo.Level);
         var _loc2_:String = StringManager.getInstance().getMessageString("CorpsText64");
         if(GamePlayer.getInstance().language == 10)
         {
            _loc2_ += "/n" + StringManager.getInstance().getMessageString("ShipText8") + "+" + _loc1_.@Efficiency + "%" + " " + StringManager.getInstance().getMessageString("ShipText9") + "+" + _loc1_.@Efficiency + "%" + " " + StringManager.getInstance().getMessageString("ShipText10") + "+" + _loc1_.@Efficiency + "%";
         }
         else
         {
            _loc2_ += StringManager.getInstance().getMessageString("ShipText8") + "+" + _loc1_.@Efficiency + "%" + " " + StringManager.getInstance().getMessageString("ShipText9") + "+" + _loc1_.@Efficiency + "%" + " " + StringManager.getInstance().getMessageString("ShipText10") + "+" + _loc1_.@Efficiency + "%";
         }
         this.tf_corpsres.htmlText = _loc2_;
      }
      
      private function SetJobName() : void
      {
         var _loc2_:int = 0;
         this._ConsortiaJobName = new Array();
         this._ConsortiaJobName.push(this.CorpsInfo.JobName.Name0);
         this._ConsortiaJobName.push(this.CorpsInfo.JobName.Name1);
         this._ConsortiaJobName.push(this.CorpsInfo.JobName.Name2);
         this._ConsortiaJobName.push(this.CorpsInfo.JobName.Name3);
         this._ConsortiaJobName.push(this.CorpsInfo.JobName.Name4);
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            if(this._ConsortiaJobName[_loc1_] == "")
            {
               _loc2_ = 14 + _loc1_;
               this._ConsortiaJobName[_loc1_] = StringManager.getInstance().getMessageString("CorpsText" + _loc2_);
            }
            _loc1_++;
         }
      }
      
      private function GetUpgradeTime(param1:MSG_RESP_CONSORTIAMYSELF) : void
      {
         if(param1.UpgradeTime <= 0)
         {
            return;
         }
         switch(param1.UpgradeType)
         {
            case 0:
               this.UpgradeTime = CcorpsReader.getInstance().GetCorpsUpgradeInfo(param1.Level + 1).@Time;
               break;
            case 1:
               this.UpgradeTime = CcorpsReader.getInstance().GetStorageUpgradeInfo(param1.StorageLevel + 1).@Time;
               break;
            case 2:
               this.UpgradeTime = CcorpsReader.getInstance().GetComposeUpgradeInfo(param1.UnionLevel + 1).@Time;
               break;
            case 3:
               this.UpgradeTime = CcorpsReader.getInstance().GetShopUpgradeInfo(GamePlayer.getInstance().ConsortiaShopLevel + 1).@Time;
         }
      }
      
      public function ShowCorpsInfo(param1:MSG_RESP_CONSORTIAMYSELF) : void
      {
         var _loc2_:TextField = null;
         this.GetUpgradeTime(param1);
         this.CorpsInfo = param1;
         this.SetJobName();
         _loc2_ = this._mc.getMC().getChildByName("tf_corpsname") as TextField;
         _loc2_.text = param1.Name;
         this.tf_notice.text = param1.Notice;
         if(this.tf_notice.text == "")
         {
            this.tf_notice.text = StringManager.getInstance().getMessageString("CorpsText59");
         }
         _loc2_ = this._mc.getMC().getChildByName("tf_corpsofficer") as TextField;
         _loc2_.text = param1.ConsortiaLead;
         this.SelectedUserId = param1.ConsortiaLeadUserId;
         GameKernel.getPlayerFacebookInfo(param1.ConsortiaLeadUserId,this.getPlayerFacebookInfoCallback,param1.ConsortiaLead);
         _loc2_ = this._mc.getMC().getChildByName("tf_corpsgrade") as TextField;
         _loc2_.text = (param1.Level + 1).toString();
         _loc2_ = this._mc.getMC().getChildByName("tf_membernum") as TextField;
         _loc2_.text = param1.MemberCount + "/" + param1.MaxMemberCount;
         _loc2_ = this._mc.getMC().getChildByName("tf_corpsranking") as TextField;
         _loc2_.text = (param1.SortId + 1).toString();
         _loc2_ = this._mc.getMC().getChildByName("tf_treasure") as TextField;
         _loc2_.text = param1.Wealth.toString();
         _loc2_ = this._mc.getMC().getChildByName("tf_maintenance") as TextField;
         _loc2_.text = param1.RepairWealth.toString();
         _loc2_ = this._mc.getMC().getChildByName("tf_resplanet") as TextField;
         _loc2_.text = param1.HoldGalaxy + "/" + param1.MaxHoldGalaxy;
         _loc2_ = this._mc.getMC().getChildByName("tf_corpsstorage") as TextField;
         _loc2_.text = (param1.StorageLevel + 1).toString();
         _loc2_ = this._mc.getMC().getChildByName("tf_compose") as TextField;
         _loc2_.text = (param1.UnionLevel + 1).toString();
         _loc2_ = this._mc.getMC().getChildByName("tf_corpsmall") as TextField;
         _loc2_.text = (GamePlayer.getInstance().ConsortiaShopLevel + 1).toString();
         if(GamePlayer.getInstance().ConsortiaShopLevel < 0)
         {
            this.btn_corpsmall.SetTip(StringManager.getInstance().getMessageString("CorpsText88"));
         }
         if(param1.UnionLevel < 0)
         {
            this.btn_compose.SetTip(StringManager.getInstance().getMessageString("CorpsText89"));
         }
         if(param1.StorageLevel < 0)
         {
            this.btn_personalstorage.SetTip(StringManager.getInstance().getMessageString("CorpsText90"));
         }
         if(GamePlayer.getInstance().ConsortiaThrowValue < GamePlayer.getInstance().ConsortiaShopValue)
         {
            this.btn_corpsmall.SetTip(StringManager.getInstance().getMessageString("CorpsText91"));
         }
         if(GamePlayer.getInstance().ConsortiaThrowValue < GamePlayer.getInstance().ConsortiaUnionValue)
         {
            this.btn_compose.SetTip(StringManager.getInstance().getMessageString("CorpsText91"));
         }
         this.tf_corpsenounce.text = param1.Proclaim;
         if(this.tf_corpsenounce.text == "")
         {
            this.tf_corpsenounce.text = StringManager.getInstance().getMessageString("CorpsText60");
         }
         var _loc3_:MovieClip = this._mc.getMC().getChildByName("mc_corpsbase") as MovieClip;
         if(_loc3_.numChildren > 0)
         {
            _loc3_.removeChildAt(0);
         }
         var _loc4_:Bitmap = new Bitmap(GameKernel.getTextureInstance("corp_" + param1.HeadId));
         _loc3_.addChild(_loc4_);
         this.ShowCorpsUpgradeInfo();
         this.ShowUpgradeTime();
         if(this.CorpsInfo.Level < 2)
         {
            this.btn_diplomatism.SetTip(StringManager.getInstance().getMessageString("Pirate18"));
         }
         else
         {
            this.btn_diplomatism.SetTip("");
         }
      }
      
      public function RespUpgrade(param1:MSG_RESP_CONSORTIAUPGRADE) : void
      {
         if(this.CorpsInfo == null)
         {
            return;
         }
         this.CorpsInfo.UpgradeTime = param1.Needtime;
         this.CorpsInfo.UpgradeType = param1.Type;
      }
      
      public function RespUpgradeCancel(param1:MSG_RESP_CONSORTIAUPGRADECANCEL) : void
      {
         if(this.CorpsInfo == null)
         {
            return;
         }
         this.CorpsInfo.Wealth = param1.Wealth;
         this.ClearUpgrade();
      }
      
      private function ShowUpgradeTime() : void
      {
         if(this.CorpsInfo == null)
         {
            return;
         }
         if(this.CorpsInfo.UpgradeTime > 0)
         {
            if(this.UpgradeTimer.running == false)
            {
               this.UpgradeTimer.start();
            }
            this.mc_corpstime.visible = true;
            --this.CorpsInfo.UpgradeTime;
            TextField(this.mc_corpstime.tf_name).text = StringManager.getInstance().getMessageString("CorpsText" + int(93 + this.CorpsInfo.UpgradeType));
            TextField(this.mc_corpstime.tf_time).text = DataWidget.localToDataZone(this.CorpsInfo.UpgradeTime);
            MovieClip(this.mc_corpstime.mc_bar).width = this.mc_corpstimeLen * ((this.UpgradeTime - this.CorpsInfo.UpgradeTime) / this.UpgradeTime);
         }
         else
         {
            if(this.UpgradeTimer.running)
            {
               this.UpgradeTimer.stop();
            }
            this.mc_corpstime.visible = false;
         }
      }
      
      private function OnUpgradeTimer(param1:Event) : void
      {
         this.ShowUpgradeTime();
      }
      
      private function ClearUpgrade() : void
      {
         this.CorpsInfo.UpgradeType = -1;
         this.CorpsInfo.UpgradeTime = 0;
         this.UpgradeTimer.stop();
         this.mc_corpstime.visible = false;
      }
      
      public function RespCorpsUpgrade() : void
      {
         var _loc1_:TextField = null;
         var _loc2_:int = 0;
         if(this.ParentLock.contains(this._mc.getMC()) && this.CorpsInfo != null)
         {
            ++this.CorpsInfo.Level;
            _loc1_ = this._mc.getMC().getChildByName("tf_corpsgrade") as TextField;
            _loc1_.text = (this.CorpsInfo.Level + 1).toString();
            _loc2_ = int(CcorpsReader.getInstance().GetCorpsUpgradeInfo(this.CorpsInfo.Level).@wealth);
            this.CorpsInfo.Wealth -= _loc2_;
            _loc1_ = this._mc.getMC().getChildByName("tf_treasure") as TextField;
            _loc1_.text = this.CorpsInfo.Wealth.toString();
            this.ClearUpgrade();
         }
      }
      
      public function RespCorpsStorageUpgrade() : void
      {
         var _loc1_:TextField = null;
         var _loc2_:int = 0;
         if(this.ParentLock.contains(this._mc.getMC()) && this.CorpsInfo != null)
         {
            ++this.CorpsInfo.StorageLevel;
            _loc1_ = this._mc.getMC().getChildByName("tf_corpsstorage") as TextField;
            _loc1_.text = (this.CorpsInfo.StorageLevel + 1).toString();
            _loc2_ = int(CcorpsReader.getInstance().GetStorageUpgradeInfo(this.CorpsInfo.StorageLevel).@wealth);
            this.CorpsInfo.Wealth -= _loc2_;
            _loc1_ = this._mc.getMC().getChildByName("tf_treasure") as TextField;
            _loc1_.text = this.CorpsInfo.Wealth.toString();
            this.ClearUpgrade();
         }
      }
      
      public function RespComposeUpgrade() : void
      {
         var _loc1_:TextField = null;
         var _loc2_:int = 0;
         if(this.ParentLock.contains(this._mc.getMC()) && this.CorpsInfo != null)
         {
            ++this.CorpsInfo.UnionLevel;
            _loc1_ = this._mc.getMC().getChildByName("tf_compose") as TextField;
            _loc1_.text = (this.CorpsInfo.UnionLevel + 1).toString();
            _loc2_ = int(CcorpsReader.getInstance().GetComposeUpgradeInfo(this.CorpsInfo.UnionLevel).@wealth);
            this.CorpsInfo.Wealth -= _loc2_;
            _loc1_ = this._mc.getMC().getChildByName("tf_treasure") as TextField;
            _loc1_.text = this.CorpsInfo.Wealth.toString();
            this.ClearUpgrade();
         }
      }
      
      public function RespShopUpgrade() : void
      {
         var _loc1_:TextField = null;
         var _loc2_:int = 0;
         if(this.ParentLock.contains(this._mc.getMC()) && this.CorpsInfo != null)
         {
            ++GamePlayer.getInstance().ConsortiaShopLevel;
            _loc1_ = this._mc.getMC().getChildByName("tf_compose") as TextField;
            _loc1_.text = (GamePlayer.getInstance().ConsortiaShopLevel + 1).toString();
            _loc2_ = int(CcorpsReader.getInstance().GetShopUpgradeInfo(this.CorpsInfo.UnionLevel).@wealth);
            this.CorpsInfo.Wealth -= _loc2_;
            _loc1_ = this._mc.getMC().getChildByName("tf_treasure") as TextField;
            _loc1_.text = this.CorpsInfo.Wealth.toString();
            this.ClearUpgrade();
         }
      }
      
      public function ShowMyCorpsMemberList(param1:MSG_RESP_CONSORTIAMEMBER) : void
      {
         this._MyCorpsUI_Member.AppendMyCorpsMemberList(param1);
         this._MyCorpsUI_Member.ShowCurPage();
         if(this.LastSelectedBtn == this.btn_member)
         {
            this.ShowList(this._MyCorpsUI_Member.MemberMcList);
            this.ShowPageButton();
         }
      }
      
      private function ResetSelectedButton(param1:HButton) : void
      {
         if(this.LastSelectedBtn != null)
         {
            this.LastSelectedBtn.setSelect(false);
         }
         this.LastSelectedBtn = param1;
         this.LastSelectedBtn.setSelect(true);
      }
      
      private function ShowList(param1:Array) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         if(this.SelectdListUI == this._MyCorpsUI_Matterlist)
         {
            _loc2_ = 0;
            while(_loc2_ < 9)
            {
               _loc3_ = this._mc.getMC().getChildByName("mc_matterlist" + _loc2_) as MovieClip;
               if(_loc3_.numChildren > 0)
               {
                  _loc3_.removeChildAt(0);
               }
               _loc3_.addChild(param1[_loc2_]);
               _loc2_++;
            }
         }
         else
         {
            _loc2_ = 0;
            while(_loc2_ < 6)
            {
               _loc3_ = this._mc.getMC().getChildByName("mc_list" + _loc2_) as MovieClip;
               if(_loc3_.numChildren > 0)
               {
                  _loc3_.removeChildAt(0);
               }
               _loc3_.addChild(param1[_loc2_]);
               _loc2_++;
            }
         }
      }
      
      private function ShowMcList(param1:HButton, param2:Array) : void
      {
         if(param1 == this.LastSelectedBtn)
         {
            this.ShowList(param2);
            this.ShowPageButton();
         }
      }
      
      public function ShowPageButton() : void
      {
         this.btn_left.setVisible(true);
         this.btn_right.setVisible(true);
         var _loc1_:int = this.SelectdListUI.GetPageIndex() + 1;
         var _loc2_:int = this.SelectdListUI.GetPageCount();
         if(_loc2_ <= 0 || _loc1_ == -1)
         {
            this.tf_page.text = "1/1";
            this.btn_left.setBtnDisabled(true);
            this.btn_right.setBtnDisabled(true);
            return;
         }
         this.tf_page.text = _loc1_ + "/" + _loc2_;
         if(_loc1_ == 1)
         {
            this.btn_left.setBtnDisabled(true);
         }
         else
         {
            this.btn_left.setBtnDisabled(false);
         }
         if(_loc1_ < _loc2_)
         {
            this.btn_right.setBtnDisabled(false);
         }
         else
         {
            this.btn_right.setBtnDisabled(true);
         }
      }
      
      private function btn_leftClick(param1:Event) : void
      {
         this.ShowList(this.SelectdListUI.PrePage());
         this.ShowPageButton();
      }
      
      private function btn_rightClick(param1:Event) : void
      {
         this.ShowList(this.SelectdListUI.NextPage());
         this.ShowPageButton();
      }
      
      private function SetEnounceVisible(param1:Boolean) : void
      {
         this.tf_corpsenounce.visible = param1;
         if(param1 && (GamePlayer.getInstance().ConsortiaJob == 1 || GamePlayer.getInstance().ConsortiaJob == 2))
         {
            this.btn_cancel.setVisible(param1);
            this.btn_ensure.setVisible(param1);
         }
         else
         {
            this.btn_cancel.setVisible(false);
            this.btn_ensure.setVisible(false);
         }
      }
      
      private function btn_closeClick(param1:Event) : void
      {
         this.Hide();
      }
      
      private function btn_memberClick(param1:Event) : void
      {
         this.ResetSelectedButton(this.btn_member);
         this.SetListVisible(false);
         this.HideList(0);
         this.SetEnounceVisible(false);
         this.SelectdListUI = this._MyCorpsUI_Member;
         this.ShowCurList();
         this.ShowCorpsUpgradeInfo();
      }
      
      private function btn_demesneClick(param1:Event) : void
      {
         this.ResetSelectedButton(this.btn_demesne);
         this.SetListVisible(false);
         this.HideList(0);
         this.SetEnounceVisible(false);
         this.SelectdListUI = this._MyCorpsUI_Demesne;
         this.tf_corpsres.htmlText = "";
         this.ShowCurList();
      }
      
      public function ShowListInfo(param1:String) : void
      {
         this.tf_corpsres.htmlText = param1;
      }
      
      private function btn_matterClick(param1:Event) : void
      {
         this.ResetSelectedButton(this.btn_matter);
         this.SetListVisible(false);
         this.HideList(1);
         this.SetEnounceVisible(false);
         this.SelectdListUI = this._MyCorpsUI_Matterlist;
         this.ShowCurList();
         this.tf_corpsres.htmlText = "";
         if(this.SelectedMatterButton == null)
         {
            this.SelectedMatterButton = this.btn_matterall;
            this.SelectedMatterButton.setSelect(true);
         }
      }
      
      private function btn_diplomatismClick(param1:Event) : void
      {
         if(this.CorpsInfo == null || this.CorpsInfo.Level < 2)
         {
            return;
         }
         this.ResetSelectedButton(this.btn_diplomatism);
         this.SetListVisible(false);
         this.HideList(0);
         this.SetEnounceVisible(false);
         this.tf_navigation.text = "";
         this.tf_corpsres.htmlText = "";
         this._MyCorpsUI_Pirate.Clear(this.CorpsInfo);
         this._MyCorpsUI_Pirate.McPirate.visible = true;
      }
      
      private function btn_recruitClick(param1:Event) : void
      {
         this.ResetSelectedButton(this.btn_recruit);
         this.SetListVisible(false);
         this.HideList(0);
         this.SetEnounceVisible(false);
         this.SelectdListUI = this._MyCorpsUI_Recruit;
         this.ShowCurList();
         this.tf_corpsres.htmlText = "";
      }
      
      private function btn_enounceClick(param1:Event) : void
      {
         this.ResetSelectedButton(this.btn_enounce);
         this.SetListVisible(false);
         this.HideList(0);
         this.SetEnounceVisible(true);
         this.tf_navigation.text = StringManager.getInstance().getMessageString("CorpsText61");
         this.tf_corpsres.htmlText = "";
      }
      
      private function btn_defenseClick(param1:Event) : void
      {
         this.ResetSelectedButton(this.btn_defense);
         this.SetListVisible(false);
         this.HideList(0);
         this.SetEnounceVisible(false);
         this.SelectdListUI = this._MyCorpsUI_Defense;
         this.ShowCurList();
         this.tf_corpsres.htmlText = "";
      }
      
      private function ShowCurList() : void
      {
         this._MyCorpsUI_Demesne.StopTimer();
         this._MyCorpsUI_Defense.StopTimer();
         this.tf_navigation.htmlText = this.SelectdListUI.GetHeadString();
         this.ShowList(this.SelectdListUI.GetList(0));
         this.ShowPageButton();
      }
      
      private function btn_editnoticeClick(param1:Event) : void
      {
         this.CorpsInfo.Notice = this.tf_notice.text;
         this.UpdateNotice();
         MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CorpsText120"),0);
      }
      
      private function btn_contributeClick(param1:Event) : void
      {
         this.Hide();
         MyCorpsUI_Offer.getInstance().Show();
      }
      
      private function btn_corpsmallClick(param1:Event) : void
      {
         if(this.btn_corpsmall.m_statue == "disabled")
         {
            return;
         }
         MyCorpsUI_Mall.getInstance().Show();
      }
      
      private function btn_composeClick(param1:Event) : void
      {
         if(ConstructionAction.getInstance().getComposeCenterNumber() < 0)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CorpsText102"),0);
            return;
         }
         this.Hide(false);
         ComposeUI.getInstance().Init();
         GameKernel.popUpDisplayManager.Show(ComposeUI.getInstance());
      }
      
      private function btn_personalstorageClick(param1:Event) : void
      {
         this.Hide(false);
         GameMouseZoneManager.NagivateToolBarByName("btn_storage",true);
      }
      
      private function btn_jobmanageClick(param1:Event) : void
      {
         MyCorpsUI_JobManage.getInstance().Show();
      }
      
      private function btn_upgradeClick(param1:Event) : void
      {
         if(this.CorpsInfo == null)
         {
            return;
         }
         if(this.CorpsInfo.UpgradeTime > 0)
         {
            MyCorpsUI_Upgrade.getInstance().Show(this.CorpsInfo.Level,this.CorpsInfo.StorageLevel,this.CorpsInfo.Wealth,this.CorpsInfo.UnionLevel,GamePlayer.getInstance().ConsortiaShopLevel,this.CorpsInfo.UpgradeType);
         }
         else
         {
            MyCorpsUI_Upgrade.getInstance().Show(this.CorpsInfo.Level,this.CorpsInfo.StorageLevel,this.CorpsInfo.Wealth,this.CorpsInfo.UnionLevel,GamePlayer.getInstance().ConsortiaShopLevel,-1);
         }
         this.Hide();
      }
      
      private function btn_changeClick(param1:Event) : void
      {
         this.Hide();
         MyCorpsUI_Transfer.getInstance().Show();
      }
      
      private function btn_equipmentClick(param1:Event) : void
      {
         MyCorpsUI_EquipmentManage.getInstance().Show();
      }
      
      private function btn_cancelClick(param1:Event) : void
      {
         this.tf_corpsenounce.text = this.CorpsInfo.Proclaim;
      }
      
      private function btn_ensureClick(param1:Event) : void
      {
         this.CorpsInfo.Proclaim = this.tf_corpsenounce.text;
         this.UpdateNotice();
         MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CorpsText121"),0);
      }
      
      private function UpdateNotice() : void
      {
         var _loc1_:MSG_REQUEST_EDITCONSORTIA = new MSG_REQUEST_EDITCONSORTIA();
         _loc1_.Proclaim = this.CorpsInfo.Proclaim;
         _loc1_.Notice = this.CorpsInfo.Notice;
         _loc1_.HeadId = -1;
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc1_);
      }
   }
}

