package logic.action
{
   import com.star.frameworks.facebook.FacebookUserInfo;
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.stl.QueueList;
   import com.star.frameworks.utils.StringUitl;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.utils.Timer;
   import logic.entry.AbstraceAction;
   import logic.entry.ChannelEnum;
   import logic.entry.ChatInfo;
   import logic.entry.GamePlayer;
   import logic.entry.GameUserInfo;
   import logic.game.GameSetting;
   import logic.manager.GalaxyManager;
   import logic.reader.CorpsPirateReader;
   import logic.ui.ChatChannelPopUp;
   import logic.ui.ChatCustomChannelPopUp;
   import logic.ui.ChatUI;
   import logic.ui.PlayerInfoPopUp;
   import logic.ui.info.BleakingLineForThai;
   import logic.widget.ChatModuleUtil;
   import logic.widget.textarea.CChatContent;
   import logic.widget.textarea.CChatInputBar;
   import logic.widget.textarea.CTextArea;
   import net.base.NetManager;
   import net.msg.chatMsg.MSG_CHAT_MESSAGE;
   import net.msg.chatMsg.MSG_REQUEST_USERINFO;
   import net.msg.chatMsg.MSG_RESP_GALAXYBROADCAST;
   import net.msg.chatMsg.MSG_RESP_USERINFO;
   import net.msg.fightMsg.MSG_FIGHTGALAXYBEGIN;
   import net.msg.friend.MSG_REQUEST_ADDFRIEND;
   
   public class ChatAction extends AbstraceAction
   {
      
      private static var instance:ChatAction;
      
      public static const MaxChatLine:int = 50;
      
      public static const MaxChatCharNumber:int = GameSetting.CHAT_MAXCHARNUMBER_BIG;
      
      public static const OffsetNum:int = 50;
      
      public static const COMMON_TYPE:int = 0;
      
      public static const TOOL_TYPE:int = 1;
      
      public static const COMMAND_TYPE:int = 2;
      
      public static const COMMAND_CARD:int = 3;
      
      public static var sendObjUserId:int = 0;
      
      public static var currentPlayer:GameUserInfo = new GameUserInfo();
      
      public static var prexChatPlayer:GameUserInfo = new GameUserInfo();
      
      public static var currentChannel:int = ChannelEnum.CHANNEL_WORLD;
      
      public static var isContinue:Boolean = true;
      
      public static var specialType:int = 0;
      
      private var mCTextArea:CTextArea;
      
      private var mTextContent:TextField;
      
      private var _ChatInfoList:Array;
      
      private var _chatChannelList:Array;
      
      private var _chatContentList:QueueList;
      
      private var _chatOffsetList:QueueList;
      
      private var _sendChatTime:Timer;
      
      private var galaxyBroadcastList:Array;
      
      public var _SenderType:int;
      
      public function ChatAction()
      {
         super();
         this._ChatInfoList = new Array();
         this.galaxyBroadcastList = new Array();
         this._chatChannelList = new Array();
         this._chatContentList = new QueueList();
         this.mCTextArea = ChatUI.getInstance().TextArea;
         this.mTextContent = CChatContent(ChatUI.getInstance().TextArea.ComponentList.Get("CChatContent")).TextArea;
         this._sendChatTime = new Timer(GameSetting.CHAT_INTERVAL_TIME);
         this._sendChatTime.addEventListener(TimerEvent.TIMER,this.onCompleted);
      }
      
      public static function getInstance() : ChatAction
      {
         if(instance == null)
         {
            instance = new ChatAction();
         }
         return instance;
      }
      
      public function get ChatChannelList() : Array
      {
         return this._chatChannelList;
      }
      
      public function get ChatContentList() : QueueList
      {
         return this._chatContentList;
      }
      
      private function onCompleted(param1:TimerEvent) : void
      {
         isContinue = true;
         this.stopTick();
      }
      
      public function startTick() : void
      {
         if(!this._sendChatTime.running)
         {
            this._sendChatTime.start();
         }
      }
      
      public function stopTick() : void
      {
         if(this._sendChatTime.running)
         {
            this._sendChatTime.stop();
         }
      }
      
      public function sendChatUserInfoMessage(param1:int, param2:int = -1, param3:int = 0, param4:Number = -1, param5:String = "") : void
      {
         var _loc6_:MSG_REQUEST_USERINFO = null;
         this._SenderType = param3;
         _loc6_ = new MSG_REQUEST_USERINFO();
         _loc6_.SeqId = GamePlayer.getInstance().seqID++;
         _loc6_.Guid = GamePlayer.getInstance().Guid;
         _loc6_.ObjGuid = param2;
         _loc6_.ObjGalaxyId = param1;
         _loc6_.UserId = param4;
         _loc6_.UserName = param5;
         NetManager.Instance().sendObject(_loc6_);
      }
      
      public function resp_Msg_UserInfo(param1:MSG_RESP_USERINFO) : void
      {
         var _loc2_:Date = null;
         var _loc3_:Number = NaN;
         ChatAction.currentPlayer.objGuid = param1.Guid;
         ChatAction.currentPlayer.userName = param1.UserName;
         ChatAction.currentPlayer.consortia = param1.Consortia;
         ChatAction.currentPlayer.levelId = param1.LevelId;
         ChatAction.currentPlayer.rank = param1.RankId;
         ChatAction.currentPlayer.x = param1.PosX;
         ChatAction.currentPlayer.y = param1.PosY;
         ChatAction.currentPlayer.peaceTime = param1.PeaceTime;
         ChatAction.currentPlayer.MatchLevel = param1.MatchLevel;
         ChatAction.currentPlayer.spaceLv = param1.SpaceLevel;
         ChatAction.currentPlayer.cityLv = param1.CityLevel;
         ChatAction.currentPlayer.UserId = param1.UserId;
         ChatAction.currentPlayer.galaxyId = param1.GalaxyId;
         ChatAction.currentPlayer.PassMaxEctypt = param1.PassMaxEctypt;
         ChatAction.currentPlayer.consortiaId = param1.ConsortiaId;
         if(param1.PassInsertFlagTime > 0)
         {
            _loc2_ = new Date();
            _loc3_ = Date.parse(_loc2_) - param1.PassInsertFlagTime * 1000;
            ChatAction.currentPlayer.InsertFlagTime = _loc3_;
         }
         else
         {
            ChatAction.currentPlayer.InsertFlagTime = 0;
         }
         ChatAction.currentPlayer.InsertFlagConsortiaId = param1.InsertFlagConsortiaId;
         ChatAction.currentPlayer.InsertFlagConsortia = param1.InsertFlagConsortia;
         PlayerInfoPopUp.getInstance().Init();
         PlayerInfoPopUp.getInstance().Show();
      }
      
      public function SendChatMessage(param1:int, param2:String) : void
      {
         var _loc3_:MSG_CHAT_MESSAGE = new MSG_CHAT_MESSAGE();
         _loc3_.Guid = GamePlayer.getInstance().Guid;
         _loc3_.SeqId = GamePlayer.getInstance().seqID++;
         _loc3_.Type = param1;
         _loc3_.buffer = param2;
         _loc3_.ToName = "";
         _loc3_.ObjGuid = ChatAction.prexChatPlayer.objGuid;
         _loc3_.name = "";
         _loc3_.SrcUserId = GamePlayer.getInstance().srcUserId;
         _loc3_.ObjUserId = 0;
         _loc3_.SpecialType = ChatAction.specialType;
         _loc3_.PropsId = ChatUI.toolObj.Proid;
         NetManager.Instance().sendObject(_loc3_);
      }
      
      public function RESP_MSG_CHATMESSAGE(param1:MSG_CHAT_MESSAGE) : void
      {
         var _loc10_:int = 0;
         var _loc11_:ChatInfo = null;
         var _loc2_:* = param1.SeqId;
         var _loc3_:* = param1.Guid;
         var _loc4_:* = param1.Type;
         var _loc5_:String = param1.name;
         var _loc6_:String = param1.ToName;
         var _loc7_:* = param1.SrcUserId;
         var _loc8_:* = param1.ObjUserId;
         var _loc9_:String = param1.buffer;
         ChatAction.specialType = _loc4_ == 6 ? 0 : int(param1.SpecialType);
         ChatAction.sendObjUserId = param1.Guid;
         ChatUI.toolObj.Proid = param1.PropsId;
         ChatUI.toolObj.Type = ChatAction.specialType;
         for each(_loc10_ in this.ChatChannelList)
         {
            this.SetTextFormat();
            if(_loc4_ == _loc10_)
            {
               _loc11_ = new ChatInfo();
               _loc11_.type = _loc4_;
               _loc11_.srcGuid = _loc3_;
               _loc11_.UserId = _loc7_;
               _loc11_.content = _loc9_;
               if(_loc4_ == 6)
               {
                  _loc9_ = ChatModuleUtil.createTxtLink(_loc11_.srcGuid,_loc11_.type,_loc11_.UserId.toString(),_loc11_.content,ChatModuleUtil.setFontColor(_loc11_.type),param1);
                  _loc9_ = this.ClearHtmlForAe(_loc9_,_loc4_);
                  this.ValidateChatContentCount(_loc9_);
                  this.mTextContent.htmlText += _loc9_;
                  this.mTextContent.scrollV = this.mTextContent.maxScrollV;
                  break;
               }
               _loc9_ = ChatModuleUtil.createTxtLink(_loc11_.srcGuid,_loc11_.type,_loc5_,_loc11_.content,ChatModuleUtil.setFontColor(_loc11_.type),param1);
               _loc9_ = this.ClearHtmlForAe(_loc9_,_loc4_);
               this.ValidateChatContentCount(_loc9_);
               this.mTextContent.htmlText += _loc9_;
               this.mTextContent.scrollV = this.mTextContent.maxScrollV;
               break;
            }
         }
         if(_loc4_ >= 100)
         {
            this.SetTextFormat();
            _loc11_ = new ChatInfo();
            _loc11_.type = _loc4_;
            _loc11_.srcGuid = _loc3_;
            _loc11_.UserId = _loc7_;
            _loc11_.content = _loc9_;
            if(_loc4_ == 6)
            {
               _loc9_ = ChatModuleUtil.createTxtLink(_loc11_.srcGuid,_loc11_.type,_loc11_.UserId.toString(),_loc11_.content,ChatModuleUtil.setFontColor(_loc11_.type),param1);
               _loc9_ = this.ClearHtmlForAe(_loc9_,_loc4_);
               this.ValidateChatContentCount(_loc9_);
               this.mTextContent.htmlText += _loc9_;
               this.mTextContent.scrollV = this.mTextContent.maxScrollV;
            }
            else
            {
               _loc9_ = ChatModuleUtil.createTxtLink(_loc11_.srcGuid,_loc11_.type,_loc5_,_loc11_.content,ChatModuleUtil.setFontColor(_loc11_.type),param1);
               _loc9_ = this.ClearHtmlForAe(_loc9_,_loc4_);
               this.ValidateChatContentCount(_loc9_);
               this.mTextContent.htmlText += _loc9_;
               this.mTextContent.scrollV = this.mTextContent.maxScrollV;
            }
         }
      }
      
      private function SetTextFormat() : void
      {
         var _loc1_:TextFormat = null;
         if(GamePlayer.getInstance().language == 10)
         {
            _loc1_ = this.mTextContent.getTextFormat();
            _loc1_.align = TextFieldAutoSize.RIGHT;
            this.mTextContent.setTextFormat(_loc1_);
            this.mTextContent.defaultTextFormat = _loc1_;
         }
      }
      
      private function ClearHtmlForAe(param1:String, param2:int = -1, param3:String = null, param4:Boolean = true) : String
      {
         var _loc10_:int = 0;
         var _loc9_:String = null;
         var _loc12_:int = 0;
         var _loc8_:String = null;
         var _loc11_:String = null;
         var _loc14_:* = null;
         var _loc15_:int = 0;
         var _loc16_:String = null;
         var _loc17_:int = 0;
         if(GamePlayer.getInstance().language != 10)
         {
            return param1;
         }
         var _loc5_:int = int(param1.indexOf("["));
         var _loc6_:int = int(param1.indexOf("]"));
         var _loc7_:String = param1.substr(_loc5_ + 1,_loc6_ - _loc5_ - 1);
         _loc9_ = param1.substr(0,_loc5_);
         _loc10_ = int(_loc9_.indexOf("<a"));
         if(_loc10_ >= 0)
         {
            _loc15_ = int(_loc9_.indexOf(">",_loc10_));
            _loc8_ = _loc9_.substr(_loc10_,_loc15_ - _loc10_ + 1);
         }
         _loc12_ = int(_loc9_.indexOf("color="));
         if(_loc12_ > 0)
         {
            _loc16_ = _loc9_.charAt(_loc12_ + 6);
            _loc17_ = int(_loc9_.indexOf(_loc16_,_loc12_ + 7));
            _loc11_ = _loc9_.substring(_loc12_ + 7,_loc17_ - 1);
         }
         param1 = param1.substr(_loc6_ + 1);
         param1 = param1.replace(":","");
         var _loc13_:String = param1;
         if(param4)
         {
            _loc13_ = BleakingLineForThai.GetInstance().ClearHtmlForAe(param1);
         }
         if(_loc8_ != null)
         {
            if(_loc11_ != null)
            {
               _loc14_ = _loc13_ + ": <font color=\'" + _loc11_ + "\'>" + _loc8_ + _loc7_ + "</a></font>";
            }
            else
            {
               _loc14_ = _loc13_ + ": " + _loc8_ + _loc7_ + "</a>";
            }
         }
         else if(_loc11_ != null)
         {
            _loc14_ = _loc13_ + ": <font color=\'" + _loc11_ + "\'>" + _loc7_ + "</font>";
         }
         else
         {
            _loc14_ = _loc13_ + ": " + _loc7_;
         }
         if(param2 >= 0)
         {
            _loc14_ = "<font color=\'" + ChatModuleUtil.setFontColor(param2) + "\'>" + _loc14_ + "</font>";
         }
         return _loc14_;
      }
      
      public function updateContentScroll() : void
      {
         this.mTextContent.scrollV = this.mTextContent.maxScrollV;
      }
      
      public function RESP_MSG_GALAXYBROADCAST(param1:MSG_RESP_GALAXYBROADCAST) : void
      {
         var _loc6_:String = null;
         var _loc2_:* = param1.Guid;
         var _loc3_:String = param1.Name;
         var _loc4_:* = param1.UserId;
         var _loc5_:* = param1.Type;
         if(0 == _loc5_)
         {
            _loc6_ = "<a href=\'event:" + _loc2_ + "," + _loc3_ + "\'>[" + StringUitl.Trim(_loc3_) + "]</a>" + StringManager.getInstance().getMessageString("ChatingTXT20");
         }
         else if(1 == _loc5_)
         {
            _loc6_ = "<a href=\'event:" + _loc2_ + "," + _loc3_ + "\'>[" + StringUitl.Trim(_loc3_) + "]</a>" + StringManager.getInstance().getMessageString("ChatingTXT21");
         }
         ChatAction.getInstance().appendMsgContent(StringUitl.Trim(_loc6_),ChannelEnum.CHANNEL_SYSTEM,_loc3_,false);
      }
      
      private function getPlayerFacebookInfo(param1:FacebookUserInfo) : void
      {
         var _loc3_:MSG_RESP_GALAXYBROADCAST = null;
         var _loc4_:* = 0;
         var _loc5_:String = null;
         var _loc6_:* = NaN;
         var _loc7_:* = 0;
         var _loc8_:String = null;
         if(param1 == null)
         {
            return;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this.galaxyBroadcastList.length)
         {
            _loc3_ = this.galaxyBroadcastList[_loc2_];
            if(_loc3_.UserId == param1.uid)
            {
               _loc4_ = _loc3_.Guid;
               _loc5_ = param1.first_name;
               _loc6_ = _loc3_.UserId;
               _loc7_ = _loc3_.Type;
               if(0 == _loc7_)
               {
                  _loc8_ = "<a href=\'event:" + _loc4_ + "," + _loc5_ + "\'>[" + StringUitl.Trim(_loc5_) + "]</a>" + StringManager.getInstance().getMessageString("ChatingTXT20");
               }
               else if(1 == _loc7_)
               {
                  _loc8_ = "<a href=\'event:" + _loc4_ + "," + _loc5_ + "\'>[" + StringUitl.Trim(_loc5_) + "]</a>" + StringManager.getInstance().getMessageString("ChatingTXT21");
               }
               ChatAction.getInstance().appendMsgContent(StringUitl.Trim(_loc8_),ChannelEnum.CHANNEL_SYSTEM,_loc5_);
               this.galaxyBroadcastList.splice(_loc2_,1);
            }
            else
            {
               _loc2_++;
            }
         }
      }
      
      public function ValidateChatContentCount(param1:String) : void
      {
         if(this._chatContentList.Length() >= ChatAction.MaxChatLine)
         {
            if(this._chatOffsetList == null)
            {
               this._chatOffsetList = new QueueList();
            }
            if(this._chatOffsetList.Length() >= ChatAction.OffsetNum)
            {
               this.reAppendMsgContent();
               return;
            }
            this._chatOffsetList.Push(param1);
         }
         else
         {
            this._chatContentList.Push(param1);
         }
      }
      
      private function reAppendMsgContent() : void
      {
         var _loc4_:String = null;
         if(this._chatContentList.Length() == 0)
         {
            return;
         }
         var _loc1_:Array = this._chatOffsetList.toArray();
         this.mTextContent.htmlText = "";
         var _loc2_:int = 0;
         var _loc3_:String = "";
         for each(_loc4_ in _loc1_)
         {
            _loc4_ = ChatModuleUtil.replaceContent(_loc4_);
            _loc3_ += _loc4_;
         }
         this.SetTextFormat();
         this.mTextContent.htmlText = _loc3_;
         this.mTextContent.scrollV = _loc1_.length;
         this.mTextContent.scrollV = this.mTextContent.maxScrollV;
         this._chatContentList.Clear();
         this._chatOffsetList.Clear();
         this._chatOffsetList = null;
      }
      
      public function locationGalaxyFigthPostion(param1:MSG_FIGHTGALAXYBEGIN) : void
      {
         var _loc2_:Point = null;
         var _loc3_:* = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(ChatCustomChannelPopUp.getInstance().FightBox.IsSelect)
         {
            _loc2_ = GalaxyManager.getStarCoordinate(param1.GalaxyId);
            _loc3_ = "";
            if(param1.Type == 0)
            {
               _loc3_ = "<font color=\'#00ff00\'><a href=\'event:" + "GalaxyFigth#" + param1.GalaxyId + "\'>[" + _loc2_.x + "," + _loc2_.y + "]</a></font> " + StringManager.getInstance().getMessageString("ChatingTXT23");
            }
            else if(param1.Type == 1)
            {
               _loc3_ = "<font color=\'#00ff00\'><a href=\'event:" + "GalaxyFigth#" + param1.GalaxyId + "\'>[" + _loc2_.x + "," + _loc2_.y + "]</a></font> " + StringManager.getInstance().getMessageString("ChatingTXT26");
            }
            else if(param1.Type == 2)
            {
               _loc3_ = "<font color=\'#FF9999\'><a href=\'event:CorpsName," + param1.ConsortiaId + "\'>[" + param1.ConsortiaName + "]</a></font><font color=\'#00FF00\'><a href=\'event:GalaxyFigth#" + param1.GalaxyId + "\'>[" + _loc2_.x + "," + _loc2_.y + "]</a></font>";
               _loc4_ = " Lv." + int(param1.PirateLevelId + 1) + " " + CorpsPirateReader.GetPirateInfo(param1.PirateLevelId).@Name;
               _loc5_ = StringManager.getInstance().getMessageString("Pirate19");
               _loc5_ = _loc5_.replace("@@1",_loc4_);
               _loc3_ += _loc5_;
            }
            else if(param1.Type == 3)
            {
               _loc3_ = "<font color=\'#00ff00\'><a href=\'event:" + "GalaxyFigth#" + param1.GalaxyId + "\'>[" + _loc2_.x + "," + _loc2_.y + "]</a></font> " + StringManager.getInstance().getMessageString("Boss47");
            }
            ChatAction.getInstance().appendMsgContent(_loc3_,ChannelEnum.CHANNEL_SYSTEM,null,false);
         }
      }
      
      public function IsFitPrivateContentReg(param1:String) : Boolean
      {
         if(this.IsFitPrivateCorrect(param1))
         {
            if(ChatAction.prexChatPlayer.userName != null && StringUitl.Trim(ChatAction.prexChatPlayer.userName) == StringUitl.Trim(ChatModuleUtil.filterPrivateChannel(param1)[0]))
            {
               return true;
            }
         }
         return false;
      }
      
      private function IsFitPrivateCorrect(param1:String) : Boolean
      {
         if(param1 == null || param1 == "")
         {
            return false;
         }
         if(GamePlayer.getInstance().language == 10)
         {
            return true;
         }
         if(0 == param1.indexOf("/"))
         {
            return param1.indexOf(":") != -1;
         }
         return false;
      }
      
      public function IsFitShareToolContentReg(param1:String) : Boolean
      {
         var _loc2_:String = null;
         if(param1 == null || param1 == "")
         {
            return false;
         }
         if(StringUitl.Trim("[" + ChatUI.toolObj.Name + "]/").length != StringUitl.Trim(param1).length)
         {
            _loc2_ = StringUitl.Trim(param1).replace(StringUitl.Trim("[" + ChatUI.toolObj.Name + "]/"),"");
            if(_loc2_.length == StringUitl.Trim(param1).length)
            {
               return false;
            }
            return true;
         }
         return true;
      }
      
      public function IsFitToolName(param1:String) : Boolean
      {
         if(param1 == null || param1 == "")
         {
            return false;
         }
         param1 = StringUitl.Trim(param1);
         var _loc2_:Array = param1.split("/");
         var _loc3_:String = _loc2_[0];
         return StringUitl.Trim(_loc3_) == StringUitl.Trim("[" + ChatUI.toolObj.Name + "]");
      }
      
      public function toPrivateChannel(param1:int, param2:String) : void
      {
         var _loc4_:TextField = null;
         ChatAction.currentChannel = ChannelEnum.CHANNEL_PRIVATE;
         ChatChannelPopUp.getInstance().setChannel(ChannelEnum.CHANNEL_PRIVATE);
         var _loc3_:* = StringUitl.Trim(param2);
         _loc4_ = CChatInputBar(this.mCTextArea.ComponentList.Get("CChatInputBar")).TF_input;
         _loc4_.multiline = false;
         if(GamePlayer.getInstance().language == 10)
         {
            _loc3_ = ":" + _loc3_ + "/";
         }
         else
         {
            _loc3_ = "/" + _loc3_ + ":";
         }
         _loc4_.text = _loc3_;
      }
      
      public function sendAddFriendRequest(param1:int) : void
      {
         var _loc2_:MSG_REQUEST_ADDFRIEND = new MSG_REQUEST_ADDFRIEND();
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         _loc2_.ObjGuid = param1;
         NetManager.Instance().sendObject(_loc2_);
      }
      
      public function appendMsgContent(param1:String, param2:int = 0, param3:String = null, param4:Boolean = true) : void
      {
         if(param4)
         {
            param1 = BleakingLineForThai.GetInstance().ClearHtmlForAe(param1);
         }
         if(param1 == "" || param1 == null)
         {
            return;
         }
         this.SetTextFormat();
         param1 = ChatModuleUtil.createAppendMsgContentHtml(param2,param1);
         param1 = this.ClearHtmlForAe(param1,param2,param3,param4);
         this.ValidateChatContentCount(param1);
         this.mTextContent.htmlText += param1;
         this.mTextContent.scrollV = this.mTextContent.maxScrollV;
      }
      
      private function ProcessObjName(param1:String, param2:String = null) : String
      {
         var _loc3_:int = 0;
         if(GamePlayer.getInstance().language == 10 && param2 != null)
         {
            _loc3_ = 0;
            while(_loc3_ < param2.length)
            {
               if(param2.charCodeAt(_loc3_) <= 128)
               {
                  param1 = param1.replace(param2,"\n" + param2 + "\n");
                  break;
               }
               _loc3_++;
            }
         }
         return param1;
      }
      
      public function ShowHtml() : void
      {
         this.mTextContent.text = this.mTextContent.htmlText;
      }
      
      private function getPlayerFacebookInfoCallback(param1:FacebookUserInfo) : void
      {
         var _loc3_:ChatInfo = null;
         var _loc4_:String = null;
         var _loc2_:int = 0;
         if(param1 == null)
         {
            while(_loc2_ < this._ChatInfoList.length)
            {
               _loc3_ = this._ChatInfoList[_loc2_];
               _loc4_ = ChatModuleUtil.createTxtLink(_loc3_.srcGuid,_loc3_.type,_loc3_.UserId.toString(),_loc3_.content,ChatModuleUtil.setFontColor(_loc3_.type));
               _loc4_ = this.ClearHtmlForAe(_loc4_,_loc3_.type);
               this.ValidateChatContentCount(_loc4_);
               this.mTextContent.htmlText += _loc4_;
               this.mTextContent.scrollV = this.mTextContent.maxScrollV;
               _loc2_++;
            }
            this._ChatInfoList.splice(0);
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < this._ChatInfoList.length)
         {
            _loc3_ = this._ChatInfoList[_loc2_];
            if(_loc3_.UserId == param1.uid)
            {
               _loc4_ = ChatModuleUtil.createTxtLink(_loc3_.srcGuid,_loc3_.type,param1.first_name,_loc3_.content,ChatModuleUtil.setFontColor(_loc3_.type));
               _loc4_ = this.ClearHtmlForAe(_loc4_,_loc3_.type);
               this.ValidateChatContentCount(_loc4_);
               this.mTextContent.htmlText += _loc4_;
               this.mTextContent.scrollV = this.mTextContent.maxScrollV;
               this._ChatInfoList.splice(_loc2_,1);
            }
            else
            {
               _loc2_++;
            }
         }
      }
   }
}

