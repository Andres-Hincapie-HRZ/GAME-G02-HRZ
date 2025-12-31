package net.router
{
   import com.star.frameworks.facebook.FacebookUserInfo;
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.CEffectText;
   import com.star.frameworks.utils.HashSet;
   import com.star.frameworks.utils.StringUitl;
   import flash.events.TimerEvent;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   import logic.action.ChatAction;
   import logic.entry.ChannelEnum;
   import logic.entry.GShipTeam;
   import logic.entry.GamePlayer;
   import logic.entry.ScienceSystem;
   import logic.entry.commander.CommanderInfo;
   import logic.entry.commander.CommanderStoneInfo;
   import logic.game.GameKernel;
   import logic.manager.GalaxyShipManager;
   import logic.reader.CPropsReader;
   import logic.ui.CommanderSceneUI;
   import logic.ui.CommandercardSceneUI;
   import logic.ui.ComposeUI_Commander;
   import logic.ui.ComposeUI_CommanderChip;
   import logic.ui.FleetEditUI;
   import logic.ui.GemcheckPopUI;
   import logic.ui.MainUI;
   import logic.ui.tip.CommanderInfoTip;
   import logic.utils.UpdateResource;
   import logic.widget.CommanderCardDragger;
   import net.base.NetManager;
   import net.msg.commanderMsg.*;
   
   public class CommanderRouter
   {
      
      private static var _instance:CommanderRouter = null;
      
      private var m_str0:String;
      
      private var m_str1:String;
      
      public var NextInviteTime:int;
      
      public var m_try:HashSet = new HashSet();
      
      public var m_commandInfoObj:HashSet = new HashSet();
      
      public var m_commandInfoAry:Array = new Array();
      
      private var m_cardID:int;
      
      public var m_firstCardPropsId:int = -1;
      
      public var m_NextCardPropsId1:int = -1;
      
      public var m_NextCardPropsId2:int = -1;
      
      public var m_IsCommanderUISend:Boolean = true;
      
      private var m_time:Timer;
      
      public var m_AnimationCard:Boolean = false;
      
      public var m_commanderStateAry:Array = new Array();
      
      private var m_Guid:int;
      
      private var m_typeNum:Number;
      
      private var m_UidCardAry:Array = new Array();
      
      public var m_reSet:Boolean = false;
      
      public var commanderstoneinfo:CommanderStoneInfo = new CommanderStoneInfo();
      
      public function CommanderRouter()
      {
         super();
      }
      
      public static function get instance() : CommanderRouter
      {
         if(_instance == null)
         {
            _instance = new CommanderRouter();
         }
         return _instance;
      }
      
      public function resp_MSG_RESP_COMMANDERBASEINFO(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc5_:int = 0;
         var _loc7_:MSG_RESP_COMMANDERBASEINFO_TEMP = null;
         var _loc8_:CommanderInfo = null;
         var _loc9_:CommanderInfo = null;
         var _loc4_:MSG_RESP_COMMANDERBASEINFO = new MSG_RESP_COMMANDERBASEINFO();
         NetManager.Instance().readObject(_loc4_,param3);
         this.NextInviteTime = _loc4_.NextInviteTime;
         if(this.m_time == null)
         {
            this.m_time = new Timer(1000);
            this.m_time.addEventListener(TimerEvent.TIMER,this.onTick,false,0,true);
            if(this.NextInviteTime > 0)
            {
               this.m_time.start();
            }
         }
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_.DataLen)
         {
            _loc7_ = _loc4_.Data[_loc6_] as MSG_RESP_COMMANDERBASEINFO_TEMP;
            _loc8_ = new CommanderInfo();
            _loc9_ = new CommanderInfo();
            _loc8_ = this.assignment(_loc8_,_loc7_);
            _loc5_ = 0;
            while(_loc5_ < this.m_commandInfoAry.length)
            {
               _loc9_ = this.m_commandInfoAry[_loc5_];
               if(_loc9_.commander_commanderId == _loc8_.commander_commanderId)
               {
                  this.m_commandInfoAry[_loc5_] = _loc8_;
                  break;
               }
               _loc5_++;
            }
            if(_loc5_ == this.m_commandInfoAry.length)
            {
               this.m_commandInfoAry.push(_loc8_);
               this.m_commanderStateAry.push(_loc7_.State);
            }
            _loc6_++;
         }
      }
      
      public function deleteShipTeam(param1:int) : void
      {
         var _loc2_:CommanderInfo = null;
         var _loc3_:int = 0;
         while(_loc3_ < this.m_commandInfoAry.length)
         {
            _loc2_ = this.m_commandInfoAry[_loc3_];
            if(_loc2_.commander_shipTeamId == param1)
            {
               _loc2_.commander_shipTeamId = -1;
               break;
            }
            _loc3_++;
         }
      }
      
      public function resp_MSG_RESP_COMMANDERINFO(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc5_:int = 0;
         var _loc9_:int = 0;
         var _loc4_:MSG_RESP_COMMANDERINFO = new MSG_RESP_COMMANDERINFO();
         NetManager.Instance().readObject(_loc4_,param3);
         var _loc6_:String = String(_loc4_.CommanderId);
         var _loc7_:int = _loc4_.ShowType;
         var _loc8_:int = 0;
         while(_loc8_ < this.m_commandInfoAry.length)
         {
            if(_loc4_.CommanderId == this.m_commandInfoAry[_loc8_].commander_commanderId)
            {
               _loc5_ = _loc8_;
               this.m_commandInfoAry[_loc8_].commander_restTime = _loc4_.RestTime;
               this.m_commandInfoAry[_loc8_].commander_shipTeamId = _loc4_.ShipTeamId;
               this.m_commandInfoAry[_loc8_].commander_exp = _loc4_.Exp;
               this.m_commandInfoAry[_loc8_].commander_blench = _loc4_.Blench;
               this.m_commandInfoAry[_loc8_].commander_priority = _loc4_.Priority;
               this.m_commandInfoAry[_loc8_].commander_electron = _loc4_.Electron;
               this.m_commandInfoAry[_loc8_].commander_aim = _loc4_.Aim;
               this.m_commandInfoAry[_loc8_].commander_cardLevel = _loc4_.CardLevel;
               this.m_commandInfoAry[_loc8_].HasCardLevel = true;
               this.m_commandInfoAry[_loc8_].commander_level = _loc4_.Level;
               this.m_commandInfoAry[_loc8_].commander_state = _loc4_.State;
               this.m_commanderStateAry[_loc8_] = _loc4_.State;
               this.m_commandInfoAry[_loc8_].commander_type = _loc4_.Type;
               this.m_commandInfoAry[_loc8_].commander_state = _loc4_.State;
               this.m_commandInfoAry[_loc8_].commander_commanderZJ = _loc4_.CommanderZJ;
               this.m_commandInfoAry[_loc8_].commander_Target = _loc4_.Target;
               this.m_commandInfoAry[_loc8_].commander_TargetInterval = _loc4_.TargetInterval;
               this.m_commandInfoAry[_loc8_].commander_TeamBody = _loc4_.TeamBody;
               this.m_commandInfoAry[_loc8_].commander_Stone = _loc4_.Stone;
               this.m_commandInfoAry[_loc8_].commander_StoneHole = _loc4_.StoneHole;
               this.m_commandInfoAry[_loc8_].commander_AimPer = _loc4_.AimPer;
               this.m_commandInfoAry[_loc8_].commander_BlenchPer = _loc4_.BlenchPer;
               this.m_commandInfoAry[_loc8_].commander_PriorityPer = _loc4_.PriorityPer;
               this.m_commandInfoAry[_loc8_].commander_ElectronPer = _loc4_.ElectronPer;
               this.m_commandInfoAry[_loc8_].ChipList = _loc4_.Cmos;
               this.m_commandInfoAry[_loc8_].ChipExpList = _loc4_.CmosExp;
            }
            _loc9_ = 0;
            while(_loc9_ < _loc4_.AllStatusLen)
            {
               if(_loc4_.AllStatus[_loc9_].CommanderId == this.m_commandInfoAry[_loc8_].commander_commanderId)
               {
                  this.m_commanderStateAry[_loc8_] = _loc4_.AllStatus[_loc9_].State;
                  break;
               }
               _loc9_++;
            }
            _loc8_++;
         }
         if(_loc7_ == 0)
         {
            CommanderSceneUI.getInstance().showCommanderList();
            CommanderSceneUI.getInstance().showCommanderinfo(this.m_commandInfoAry[_loc5_]);
         }
         else if(_loc7_ == 1)
         {
            CommanderInfoTip.GetInstance().RespCommanderInfo(this.m_commandInfoAry[_loc5_]);
         }
         else if(_loc7_ == 2)
         {
            ComposeUI_Commander.GetInstance().RespCommanderInfo(this.m_commandInfoAry[_loc5_]);
         }
         else if(_loc7_ == 3)
         {
            ComposeUI_CommanderChip.GetInstance().RespCommanderInfo(this.m_commandInfoAry[_loc5_]);
         }
      }
      
      public function resp__MSG_RESP_CREATECOMMANDER(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_CREATECOMMANDER = new MSG_RESP_CREATECOMMANDER();
         NetManager.Instance().readObject(_loc4_,param3);
         this.NextInviteTime = _loc4_.NextInviteTime;
         var _loc5_:MSG_RESP_COMMANDERBASEINFO_TEMP = _loc4_.Data;
         var _loc6_:CommanderInfo = new CommanderInfo();
         var _loc7_:CommanderInfo = new CommanderInfo();
         _loc6_ = this.assignment(_loc6_,_loc5_);
         if(CommanderSceneUI.getInstance().m_Activation == 1)
         {
            if(_loc6_.commander_type == 1 && _loc6_.commander_level == 0)
            {
               if(_loc6_.commander_commanderId != -1)
               {
                  this.onSendMsgDeleteCommander(_loc6_.commander_commanderId);
                  ChatAction.getInstance().appendMsgContent(StringManager.getInstance().getMessageString("CommanderText24"));
                  if(this.m_time == null)
                  {
                     this.m_time = new Timer(1000);
                     this.m_time.addEventListener(TimerEvent.TIMER,this.onTick,false,0,true);
                  }
                  if(this.NextInviteTime > 0)
                  {
                     this.m_time.start();
                  }
                  CommanderSceneUI.getInstance().InitPopUp();
                  CommanderSceneUI.getInstance().m_pagenum = (this.m_commandInfoAry.length - 1) / CommanderSceneUI.SHOWCOMMANDERNUM;
                  CommanderSceneUI.getInstance().Highlight((this.m_commandInfoAry.length - 1) % CommanderSceneUI.SHOWCOMMANDERNUM);
                  CommanderSceneUI.getInstance().showCommanderList();
                  return;
               }
            }
            else if(_loc6_.commander_commanderId != -1)
            {
               this.m_commandInfoAry.push(_loc6_);
            }
         }
         else if(_loc6_.commander_commanderId != -1)
         {
            this.m_commandInfoAry.push(_loc6_);
         }
         if(GameKernel.getInstance().isCommanderInit == false)
         {
            GameKernel.getInstance().isCommanderInit = true;
            CommanderSceneUI.getInstance().Init();
         }
         if(this.m_IsCommanderUISend == false)
         {
            this.m_IsCommanderUISend = true;
            FleetEditUI.getInstance().startTime();
         }
         else
         {
            CommanderSceneUI.getInstance().InitPopUp();
            CommanderSceneUI.getInstance().m_pagenum = (this.m_commandInfoAry.length - 1) / CommanderSceneUI.SHOWCOMMANDERNUM;
            CommanderSceneUI.getInstance().Highlight((this.m_commandInfoAry.length - 1) % CommanderSceneUI.SHOWCOMMANDERNUM);
            CommanderSceneUI.getInstance().showCommanderList();
            this.onSendMsgCommander(_loc6_.commander_commanderId);
         }
         if(this.m_time == null)
         {
            this.m_time = new Timer(1000);
            this.m_time.addEventListener(TimerEvent.TIMER,this.onTick,false,0,true);
         }
         if(this.NextInviteTime > 0)
         {
            this.m_time.start();
         }
         if(this.m_AnimationCard == true)
         {
            this.m_AnimationCard = false;
         }
      }
      
      public function resp_MSG_RESP_COMMANDERCARD(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc7_:int = 0;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:* = null;
         var _loc11_:int = 0;
         var _loc4_:MSG_RESP_COMMANDERCARD = new MSG_RESP_COMMANDERCARD();
         NetManager.Instance().readObject(_loc4_,param3);
         var _loc5_:Boolean = false;
         var _loc6_:Object = new Object();
         _loc6_.PropsId = _loc4_.PropsId;
         this.m_cardID = _loc4_.PropsId;
         _loc6_.PropsNum = 1;
         _loc6_.CardLevel = _loc4_.CardLevel + 1;
         _loc6_.StorageType = 0;
         _loc6_.LockFlag = 0;
         this.m_typeNum = _loc4_.CommanderType;
         this.m_Guid = _loc4_.Guid;
         if(GamePlayer.getInstance().userID == _loc4_.UserId)
         {
            if(CommandercardSceneUI.getinstance()._BeingOpenCardUI == true)
            {
               if(CommandercardSceneUI.getinstance()._CardNum == 0)
               {
                  this.m_NextCardPropsId1 = _loc4_.NextCardPropsId1;
                  this.m_NextCardPropsId2 = _loc4_.NextCardPropsId2;
                  this.m_firstCardPropsId = _loc4_.PropsId;
                  CommandercardSceneUI.getinstance().ShowCard();
                  _loc7_ = GamePlayer.getInstance().Commander_Card;
               }
               else if(CommandercardSceneUI.getinstance()._CardNum == 1)
               {
                  CommandercardSceneUI.getinstance().ShowSecCard();
                  _loc7_ = GamePlayer.getInstance().Commander_Card2;
               }
               else if(CommandercardSceneUI.getinstance()._CardNum == 2)
               {
                  CommandercardSceneUI.getinstance().ShowSecCard();
                  _loc7_ = GamePlayer.getInstance().Commander_Card3;
               }
               CommandercardSceneUI.getinstance().SubCash(_loc7_);
               ++CommandercardSceneUI.getinstance()._CardNum;
               CommandercardSceneUI.getinstance().Animation();
            }
            while(_loc11_ < ScienceSystem.getinstance().Packarr.length)
            {
               if(_loc6_.PropsId == ScienceSystem.getinstance().Packarr[_loc11_].PropsId && ScienceSystem.getinstance().Packarr[_loc11_].LockFlag == 0)
               {
                  ++ScienceSystem.getinstance().Packarr[_loc11_].PropsNum;
                  _loc5_ = true;
               }
               _loc11_++;
            }
            if(_loc5_ == false)
            {
               ScienceSystem.getinstance().Packarr.push(_loc6_);
            }
            if(this.m_AnimationCard == true)
            {
               this.m_AnimationCard = false;
               CommanderSceneUI.getInstance().AnimationCard();
            }
         }
         if(_loc4_.PropsId % 9 == 0)
         {
            _loc8_ = CPropsReader.getInstance().GetPropsInfo(Math.ceil(_loc4_.PropsId / 9) * 9).Comment;
            _loc9_ = CPropsReader.getInstance().GetPropsInfo(Math.ceil(_loc4_.PropsId / 9) * 9).Name;
         }
         else
         {
            _loc8_ = CPropsReader.getInstance().GetPropsInfo((Math.ceil(_loc4_.PropsId / 9) - 1) * 9).Comment;
            _loc9_ = CPropsReader.getInstance().GetPropsInfo((Math.ceil(_loc4_.PropsId / 9) - 1) * 9).Name;
         }
         this.m_str0 = _loc8_;
         this.m_str1 = _loc9_;
         _loc4_.Name = _loc4_.Name.replace("\r","");
         _loc4_.Name = _loc4_.Name.replace("\n","");
         if(GamePlayer.getInstance().language == 10)
         {
            _loc10_ = "<font color=\'#99FFFF\'>" + "<a href=\'event:" + ChatAction.COMMAND_TYPE + "," + this.m_cardID + "," + _loc4_.Guid + "," + this.m_str1 + "\'>" + StringUitl.Trim(" [" + this.m_str1 + "]") + "</a></font>" + MainUI.getInstance().m_typeAry[this.m_typeNum - 2] + "<a href=\'event:" + _loc4_.Guid + "," + _loc4_.Name + "\'><font color=\'#FFFFFF\'>" + _loc4_.Name + "</font></a> " + StringManager.getInstance().getMessageString("CommanderText22");
            ChatAction.getInstance().appendMsgContent(StringUitl.Trim(_loc10_),ChannelEnum.CHANNEL_SYSTEM,_loc4_.Name,false);
         }
         else
         {
            _loc10_ = "<a href=\'event:" + _loc4_.Guid + "," + _loc4_.Name + "\'>" + _loc4_.Name + "</a> " + StringManager.getInstance().getMessageString("CommanderText22") + MainUI.getInstance().m_typeAry[this.m_typeNum - 2] + "<font color=\'#99FFFF\'>" + "<a href=\'event:" + ChatAction.COMMAND_TYPE + "," + this.m_cardID + "," + _loc4_.Guid + "," + this.m_str1 + "\'>" + StringUitl.Trim(" [" + this.m_str1 + "]") + "</a></font>";
            ChatAction.getInstance().appendMsgContent(StringUitl.Trim(_loc10_),ChannelEnum.CHANNEL_SYSTEM,_loc4_.Name);
         }
      }
      
      public function UserIdCallback(param1:FacebookUserInfo) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(param1 == null)
         {
            return;
         }
         if(String(param1.first_name) == null)
         {
            return;
         }
         _loc2_ = param1.first_name;
         _loc2_ = _loc2_.replace("\r","");
         _loc2_ = _loc2_.replace("\n","");
         var _loc7_:Boolean = false;
         var _loc8_:int = 0;
         while(_loc8_ < this.m_UidCardAry.length)
         {
            if(param1.uid == this.m_UidCardAry[_loc8_].UserId)
            {
               _loc3_ = int(this.m_UidCardAry[_loc8_].Guid);
               _loc5_ = int(this.m_UidCardAry[_loc8_].typeNum);
               _loc6_ = int(this.m_UidCardAry[_loc8_].cardID);
               _loc4_ = this.m_UidCardAry[_loc8_].Str;
               this.m_UidCardAry.splice(_loc8_,1);
               break;
            }
            _loc8_++;
         }
         var _loc9_:* = "<a href=\'event:" + _loc3_ + "," + _loc2_ + "\'>" + _loc2_ + "</a> " + StringManager.getInstance().getMessageString("CommanderText22") + MainUI.getInstance().m_typeAry[_loc5_ - 2] + "<font color=\'#99FFFF\'>" + "<a href=\'event:" + ChatAction.COMMAND_TYPE + "," + _loc6_ + "," + _loc4_ + "\'>" + StringUitl.Trim(" [" + _loc4_ + "]") + "</a></font>";
         ChatAction.getInstance().appendMsgContent(StringUitl.Trim(_loc9_),ChannelEnum.CHANNEL_SYSTEM,_loc2_);
      }
      
      public function resp_MSG_RESP_COMMANDEREDITSHIPTEAM(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc5_:GShipTeam = null;
         var _loc4_:MSG_RESP_COMMANDEREDITSHIPTEAM = new MSG_RESP_COMMANDEREDITSHIPTEAM();
         NetManager.Instance().readObject(_loc4_,param3);
         if(_loc4_.Type == 0)
         {
            if(_loc4_.ErrorCode == 1)
            {
               this.onSendMsgCommander(this.m_commandInfoAry[CommanderSceneUI.getInstance().m_choosenum].commander_commanderId);
            }
            else
            {
               CommanderSceneUI.getInstance().showTeamChangeTxt();
               _loc5_ = GalaxyShipManager.instance.getShipDatas(this.m_commandInfoAry[CommanderSceneUI.getInstance().m_choosenum].commander_shipTeamId);
               if(_loc5_ != null)
               {
                  _loc5_.UserId = -1;
               }
            }
         }
         else if(_loc4_.ErrorCode == 1)
         {
         }
      }
      
      public function onSendMsgCommander(param1:int) : void
      {
         var _loc2_:MSG_REQUEST_COMMANDERINFO = new MSG_REQUEST_COMMANDERINFO();
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         _loc2_.CommanderId = param1;
         _loc2_.ShowType = 0;
         NetManager.Instance().sendObject(_loc2_);
      }
      
      public function onSendMsgCreateCommander(param1:int) : void
      {
         var _loc2_:MSG_REQUEST_CREATECOMMANDER = new MSG_REQUEST_CREATECOMMANDER();
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         _loc2_.Type = param1;
         NetManager.Instance().sendObject(_loc2_);
      }
      
      public function onSendMsgGETSECONDCOMMANDERCARD(param1:int) : void
      {
         var _loc2_:MSG_REQUEST_GETSECONDCOMMANDERCARD = new MSG_REQUEST_GETSECONDCOMMANDERCARD();
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         _loc2_.PropsId = param1;
         NetManager.Instance().sendObject(_loc2_);
      }
      
      public function onSendMsgChangeName(param1:int, param2:String) : void
      {
         var _loc3_:MSG_REQUEST_UPDATENAMECOMMANDER = new MSG_REQUEST_UPDATENAMECOMMANDER();
         _loc3_.SeqId = GamePlayer.getInstance().seqID++;
         _loc3_.Guid = GamePlayer.getInstance().Guid;
         _loc3_.CommanderId = param1;
         _loc3_.Name = param2;
         NetManager.Instance().sendObject(_loc3_);
      }
      
      public function onSendMsgDeleteCommander(param1:int) : void
      {
         var _loc2_:MSG_REQUEST_DELETECOMMANDER = new MSG_REQUEST_DELETECOMMANDER();
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         _loc2_.CommanderId = param1;
         NetManager.Instance().sendObject(_loc2_);
      }
      
      public function resp_MSG_RESP_DELETECOMMANDER(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_DELETECOMMANDER = new MSG_RESP_DELETECOMMANDER();
         NetManager.Instance().readObject(_loc4_,param3);
         CommanderSceneUI.getInstance().deleteCommaner(_loc4_.CommanderId);
      }
      
      public function onSendMsgShipTeam(param1:int, param2:int, param3:int, param4:Array) : void
      {
         var _loc5_:MSG_REQUEST_COMMANDEREDITSHIPTEAM = new MSG_REQUEST_COMMANDEREDITSHIPTEAM();
         _loc5_.SeqId = GamePlayer.getInstance().seqID++;
         _loc5_.Guid = GamePlayer.getInstance().Guid;
         _loc5_.ShipTeamId = param1;
         _loc5_.Target = param2;
         _loc5_.TargetInterval = param3;
         _loc5_.TeamBody = param4;
         _loc5_.Type = 0;
         NetManager.Instance().sendObject(_loc5_);
      }
      
      public function onSendMsgRELIVECOMMANDER(param1:int) : void
      {
         var _loc2_:MSG_REQUEST_RELIVECOMMANDER = new MSG_REQUEST_RELIVECOMMANDER();
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         _loc2_.CommanderId = param1;
         NetManager.Instance().sendObject(_loc2_);
      }
      
      public function resp_MSG_RESP_RELIVECOMMANDER(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_RELIVECOMMANDER = new MSG_RESP_RELIVECOMMANDER();
         NetManager.Instance().readObject(_loc4_,param3);
         UpdateResource.getInstance().UpdateYfHd(_loc4_.PropsId,_loc4_.LockFlag);
         CEffectText.getInstance().showEffectText(GameKernel.renderManager.getUI().getContainer(),StringManager.getInstance().getMessageString("CommanderText45"));
         CommanderSceneUI.getInstance().Resume();
         CommanderSceneUI.getInstance().showCommanderList();
      }
      
      public function onSendMsgRESUMECOMMANDER(param1:int) : void
      {
         var _loc2_:MSG_REQUEST_RESUMECOMMANDER = new MSG_REQUEST_RESUMECOMMANDER();
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         _loc2_.CommanderId = param1;
         NetManager.Instance().sendObject(_loc2_);
      }
      
      public function resp_MSG_RESP_RESUMECOMMANDER(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_RESUMECOMMANDER = new MSG_RESP_RESUMECOMMANDER();
         NetManager.Instance().readObject(_loc4_,param3);
         UpdateResource.getInstance().UpdateYfHd(_loc4_.PropsId,_loc4_.LockFlag);
         CEffectText.getInstance().showEffectText(GameKernel.renderManager.getUI().getContainer(),StringManager.getInstance().getMessageString("CommanderText46"));
         CommanderSceneUI.getInstance().Resume();
         CommanderSceneUI.getInstance().showCommanderList();
      }
      
      public function onSendMsgCLEARCOMMANDERPERCENT(param1:int) : void
      {
         var _loc2_:MSG_REQUEST_CLEARCOMMANDERPERCENT = new MSG_REQUEST_CLEARCOMMANDERPERCENT();
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         _loc2_.CommanderId = param1;
         NetManager.Instance().sendObject(_loc2_);
      }
      
      public function resp_MSG_RESP_CLEARCOMMANDERPERCENT(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc7_:CommanderInfo = null;
         var _loc8_:CommanderInfo = null;
         var _loc4_:MSG_RESP_CLEARCOMMANDERPERCENT = new MSG_RESP_CLEARCOMMANDERPERCENT();
         NetManager.Instance().readObject(_loc4_,param3);
         var _loc5_:int = 0;
         while(_loc5_ < this.m_commandInfoAry.length)
         {
            if(this.m_commandInfoAry[_loc5_].commander_commanderId == _loc4_.CommanderId)
            {
               _loc8_ = this.m_commandInfoAry[_loc5_] as CommanderInfo;
               _loc8_.commander_level = _loc4_.Level;
               _loc8_.commander_exp = _loc4_.Exp;
               _loc8_.commander_aim = _loc4_.Aim;
               _loc8_.commander_blench = _loc4_.Blench;
               _loc8_.commander_priority = _loc4_.Priority;
               _loc8_.commander_electron = _loc4_.Electron;
               _loc8_.commander_StoneHole = 1;
               _loc8_.commander_AimPer = _loc4_.AimPer;
               _loc8_.commander_PriorityPer = _loc4_.PriorityPer;
               _loc8_.commander_ElectronPer = _loc4_.ElectronPer;
               _loc8_.commander_BlenchPer = _loc4_.BlenchPer;
               this.m_reSet = true;
               CommanderSceneUI.getInstance().showCommanderinfo(_loc8_);
               UpdateResource.getInstance().UpdateYfHd(924,_loc4_.LockFlag);
            }
            _loc5_++;
         }
         var _loc6_:GShipTeam = GalaxyShipManager.instance.getShipByCommanderId(_loc4_.CommanderId);
         if(_loc6_)
         {
            _loc7_ = this.selectCommander(_loc4_.CommanderId);
            _loc6_.CardLevel = _loc7_.commander_cardLevel;
            _loc6_.LevelId = _loc7_.commander_level;
         }
      }
      
      public function sendmsgCOMMANDERCHANGECARD(param1:int) : void
      {
         var _loc2_:MSG_REQUEST_COMMANDERCHANGECARD = new MSG_REQUEST_COMMANDERCHANGECARD();
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         _loc2_.CommanderId = param1;
         NetManager.Instance().sendObject(_loc2_);
      }
      
      public function resp_MSG_RESP_COMMANDERCHANGECARD(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_COMMANDERCHANGECARD = new MSG_RESP_COMMANDERCHANGECARD();
         NetManager.Instance().readObject(_loc4_,param3);
         UpdateResource.getInstance().AddToPack(_loc4_.PropsId,1,_loc4_.LockFlag);
         UpdateResource.getInstance().UpdateYfHd(_loc4_.UsePropsId,_loc4_.UseLockFlag);
         var _loc5_:int = 0;
         while(_loc5_ < this.m_commandInfoAry.length)
         {
            if(_loc4_.CommanderId == this.m_commandInfoAry[_loc5_].commander_commanderId)
            {
               this.m_commandInfoAry.splice(_loc5_,1);
               CommanderSceneUI.getInstance().setfriendButton(true);
               CommanderSceneUI.getInstance().m_pagenum = 0;
               CommanderSceneUI.getInstance().showCommanderList();
               CommanderSceneUI.getInstance().Highlight(0);
               CommanderSceneUI.getInstance().AnimationCard();
               return;
            }
            _loc5_++;
         }
      }
      
      public function resp_MSG_RESP_REFRESHCOMMANDERBASEINFO(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc6_:MSG_RESP_REFRESHCOMMANDERBASEINFO_TEMP = null;
         var _loc7_:int = 0;
         var _loc4_:MSG_RESP_REFRESHCOMMANDERBASEINFO = new MSG_RESP_REFRESHCOMMANDERBASEINFO();
         NetManager.Instance().readObject(_loc4_,param3);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.DataLen)
         {
            _loc6_ = _loc4_.Data[_loc5_] as MSG_RESP_REFRESHCOMMANDERBASEINFO_TEMP;
            _loc7_ = 0;
            while(_loc7_ < this.m_commandInfoAry.length)
            {
               if(_loc6_.CommanderId == this.m_commandInfoAry[_loc7_].commander_commanderId)
               {
                  this.m_commandInfoAry[_loc7_].commander_exp = _loc6_.Exp;
                  this.m_commandInfoAry[_loc7_].commander_aim = _loc6_.Aim;
                  this.m_commandInfoAry[_loc7_].commander_blench = _loc6_.Blench;
                  this.m_commandInfoAry[_loc7_].commander_priority = _loc6_.Priority;
                  this.m_commandInfoAry[_loc7_].commander_electron = _loc6_.Electron;
                  this.m_commandInfoAry[_loc7_].commander_level = _loc6_.Level;
               }
               _loc7_++;
            }
            _loc5_++;
         }
      }
      
      public function onSendMsgCOMMANDERSTONEINFO(param1:int, param2:int = 0) : void
      {
         var _loc3_:MSG_REQUEST_COMMANDERSTONEINFO = new MSG_REQUEST_COMMANDERSTONEINFO();
         _loc3_.SeqId = GamePlayer.getInstance().seqID++;
         _loc3_.Guid = GamePlayer.getInstance().Guid;
         _loc3_.CommanderId = param1;
         _loc3_.ObjGuid = param2;
         NetManager.Instance().sendObject(_loc3_);
      }
      
      public function resp_MSG_RESP_COMMANDERSTONEINFO(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_COMMANDERSTONEINFO = new MSG_RESP_COMMANDERSTONEINFO();
         NetManager.Instance().readObject(_loc4_,param3);
         this.commanderstoneinfo.UserName = _loc4_.UserName;
         this.commanderstoneinfo.CommanderZJ = _loc4_.CommanderZJ;
         this.commanderstoneinfo.Exp = _loc4_.Exp;
         this.commanderstoneinfo.SkillId = _loc4_.SkillId;
         this.commanderstoneinfo.Level = _loc4_.Level;
         this.commanderstoneinfo.CardLevel = _loc4_.CardLevel;
         this.commanderstoneinfo.Aim = _loc4_.Aim;
         this.commanderstoneinfo.Blench = _loc4_.Blench;
         this.commanderstoneinfo.Priority = _loc4_.Priority;
         this.commanderstoneinfo.Electron = _loc4_.Electron;
         this.commanderstoneinfo.S_Aim = _loc4_.S_Aim;
         this.commanderstoneinfo.S_Blench = _loc4_.S_Blench;
         this.commanderstoneinfo.S_Electron = _loc4_.S_Electron;
         this.commanderstoneinfo.S_Priority = _loc4_.S_Priority;
         this.commanderstoneinfo.S_Assault = _loc4_.S_Assault;
         this.commanderstoneinfo.S_Endure = _loc4_.S_Endure;
         this.commanderstoneinfo.S_Shield = _loc4_.S_Shield;
         this.commanderstoneinfo.S_BlastHurt = _loc4_.S_BlastHurt;
         this.commanderstoneinfo.S_Blast = _loc4_.S_Blast;
         this.commanderstoneinfo.S_DoubleHit = _loc4_.S_DoubleHit;
         this.commanderstoneinfo.S_RepairShield = _loc4_.S_RepairShield;
         this.commanderstoneinfo.S_Exp = _loc4_.S_Exp;
         this.commanderstoneinfo.AimPer = _loc4_.AimPer;
         this.commanderstoneinfo.BlenchPer = _loc4_.BlenchPer;
         this.commanderstoneinfo.PriorityPer = _loc4_.PriorityPer;
         this.commanderstoneinfo.ElectronPer = _loc4_.ElectronPer;
         this.commanderstoneinfo.Cmos = _loc4_.Cmos;
         GemcheckPopUI.getInstance().Init();
         GameKernel.renderManager.getUI().addComponent(GemcheckPopUI.getInstance()._mc);
         GemcheckPopUI.getInstance().initpop();
         CommanderCardDragger.GetInstance().Register(GemcheckPopUI.getInstance()._mc);
      }
      
      private function assignment(param1:CommanderInfo, param2:MSG_RESP_COMMANDERBASEINFO_TEMP) : CommanderInfo
      {
         var _loc3_:int = param2.CommanderId;
         param1.commander_name = param2.Name;
         param1.commander_userId = param2.UserId;
         param1.commander_commanderId = param2.CommanderId;
         param1.commander_shipTeamId = param2.ShipTeamId;
         param1.HasCardLevel = false;
         param1.commander_exp = -1;
         param1.commander_skill = param2.Skill;
         param1.commander_level = param2.Level;
         param1.commander_type = param2.Type;
         param1.commander_state = param2.State;
         return param1;
      }
      
      public function selectCommander(param1:int) : CommanderInfo
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.m_commandInfoAry.length)
         {
            if(param1 == this.m_commandInfoAry[_loc2_].commander_commanderId)
            {
               return this.m_commandInfoAry[_loc2_] as CommanderInfo;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function getHaveCommander() : Boolean
      {
         if(this.m_commandInfoAry.length > 0)
         {
            return true;
         }
         return false;
      }
      
      private function onTick(param1:TimerEvent) : void
      {
         if(--this.NextInviteTime <= 0)
         {
            this.m_time.stop();
         }
      }
   }
}

