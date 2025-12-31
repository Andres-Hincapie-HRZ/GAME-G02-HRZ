package logic.widget.textarea
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.StringUitl;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import logic.action.ChatAction;
   import logic.entry.ChannelEnum;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.game.GameKernel;
   import logic.game.GameMouseZoneManager;
   import logic.manager.GalaxyManager;
   import logic.manager.GameInterActiveManager;
   import logic.ui.ChatChannelPopUp;
   import logic.ui.ChatToolBar;
   import logic.ui.ChatUI;
   import logic.ui.GemcheckPopUI;
   import logic.ui.GotoGalaxyUI;
   import logic.ui.InstanceMenuUI;
   import logic.ui.LoserPopUI;
   import logic.ui.PackUi;
   import logic.ui.PropsBuyUI;
   import logic.ui.RaidProps;
   import logic.utils.Commander;
   import logic.utils.UpdateResource;
   import logic.widget.ChatModuleUtil;
   import logic.widget.ConstructionOperationWidget;
   import logic.widget.StartComderDrag;
   import net.router.CommanderRouter;
   
   public class CChatInputBar extends Container
   {
      
      private var ft_channel:TextField;
      
      private var isShowTool:Boolean;
      
      private var isChange:Boolean;
      
      private var mParent:*;
      
      private var isClickUserName:Boolean;
      
      private var mState:int;
      
      private var mBar:MovieClip;
      
      private var mChannelBtn:HButton;
      
      private var tf_inputtxt:TextField;
      
      private var mSendBtn:HButton;
      
      private var mChannelSelectBtn:HButton;
      
      private var btn_increase:HButton;
      
      private var btn_decrease:HButton;
      
      private var regand:RegExp = /&/g;
      
      public function CChatInputBar(param1:* = null)
      {
         super();
         this.mParent = param1;
         this.mState = 0;
         this.isClickUserName = false;
         this.isShowTool = false;
         this.isChange = false;
         setEnable(true);
         this.Init();
      }
      
      public function get InputBar() : MovieClip
      {
         return this.mBar;
      }
      
      public function get TF_input() : TextField
      {
         return this.tf_inputtxt;
      }
      
      public function get TF_Channel() : TextField
      {
         return this.ft_channel;
      }
      
      public function get ChatState() : int
      {
         return this.mState;
      }
      
      private function Init() : void
      {
         this.mBar = GameKernel.getMovieClipInstance("ChatScene");
         this.mSendBtn = new HButton(this.mBar.btn_enter);
         this.mChannelSelectBtn = new HButton(this.mBar.btn_up);
         this.btn_increase = new HButton(this.mBar.btn_increase);
         this.btn_decrease = new HButton(this.mBar.btn_decrease);
         this.tf_inputtxt = this.mBar.tf_inputtxt as TextField;
         this.ft_channel = this.mBar.tf_choose as TextField;
         this.tf_inputtxt.maxChars = ChatAction.MaxChatCharNumber;
         GameInterActiveManager.InstallInterActiveEvent(this.mParent,KeyboardEvent.KEY_DOWN,this.onKeyBoardHandler);
         GameInterActiveManager.InstallInterActiveEvent(this.mSendBtn.m_movie,ActionEvent.ACTION_CLICK,this.onChatHandler);
         GameInterActiveManager.InstallInterActiveEvent(this.mChannelSelectBtn.m_movie,ActionEvent.ACTION_CLICK,this.onChatHandler);
         GameInterActiveManager.InstallInterActiveEvent(this.btn_decrease.m_movie,ActionEvent.ACTION_CLICK,this.onChatHandler);
         GameInterActiveManager.InstallInterActiveEvent(this.btn_increase.m_movie,ActionEvent.ACTION_CLICK,this.onChatHandler);
         GameInterActiveManager.InstallInterActiveEvent(this.mParent,ActionEvent.ACTION_TEXT_LINK,this.onChatLinkHandler);
         GameInterActiveManager.InstallInterActiveEvent(this.tf_inputtxt,ActionEvent.ACTION_CLICK,this.onPreInputHandler);
         addChild(this.mBar);
      }
      
      private function onPreInputHandler(param1:MouseEvent) : void
      {
         ChatUI.getInstance().HideAllChatModuleUI();
      }
      
      private function onKeyBoardHandler(param1:KeyboardEvent) : void
      {
         var _loc2_:String = null;
         if(param1.keyCode == 13)
         {
            _loc2_ = this.TF_input.text;
            if(_loc2_ == "Birth Was God")
            {
               ChatUI.getInstance().TF_ChatInput.text = "";
               InstanceMenuUI.instance.showNext = !InstanceMenuUI.instance.showNext;
               return;
            }
            this.Send(this.TF_input.text);
         }
      }
      
      private function onChatLinkHandler(param1:TextEvent) : void
      {
         var _loc2_:Object = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Point = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         if(param1.text.split(",")[0] == "CorpsName")
         {
            _loc3_ = int(param1.text.split(",")[1]);
            LoserPopUI.getInstance().ShowConsortia(_loc3_);
            return;
         }
         if(param1.text.split("#")[0] == "GalaxyFigth")
         {
            _loc4_ = int(param1.text.split("#")[1]);
            GameMouseZoneManager.NagivateToolBarByName("btn_universe",true);
            _loc5_ = GalaxyManager.getStarCoordinate(_loc4_);
            GotoGalaxyUI.instance.GotoGalaxy(_loc5_.x,_loc5_.y);
            return;
         }
         if(param1.text.split(",").length == 4)
         {
            _loc2_ = ChatUI.getInstance().ParseSpecial(param1.text);
            _loc6_ = int(_loc2_.Type);
            _loc7_ = int(_loc2_.ID);
            _loc8_ = int(_loc2_.Guid);
            if(_loc6_ == ChatAction.TOOL_TYPE || _loc6_ == 5)
            {
               ChatUI.getInstance().setSpecialTipState(false);
               GameKernel.renderManager.getUI().removeComponent(GemcheckPopUI.getInstance()._mc);
               ChatUI.getInstance().ToolMc = PackUi.getInstance().TipHd(TextField(param1.target).mouseX,TextField(param1.target).mouseY,_loc7_);
               ChatUI.getInstance().ToolMc.y = ChatUI.getInstance().ToolMc.y - ChatUI.getInstance().ToolMc.height;
               ChatUI.getInstance().setSpecialTipState(true);
               StartComderDrag.getInstance().Register(MovieClip(ChatUI.getInstance().ToolMc));
               ChatToolBar.getInstance().HideToolBar();
               ChatChannelPopUp.getInstance().Hide();
               ConstructionOperationWidget.getInstance().Hide();
            }
            else if(_loc6_ == ChatAction.COMMAND_TYPE)
            {
               ChatUI.getInstance().setSpecialTipState(false);
               GameKernel.renderManager.getUI().removeComponent(GemcheckPopUI.getInstance()._mc);
               if(this.mState)
               {
                  ChatUI.getInstance().ToolMc = Commander.getInstance().CommanderTip(TextField(param1.target).mouseX - 50,TextField(param1.target).mouseY,_loc7_);
                  ChatUI.getInstance().ToolMc.y = ChatUI.getInstance().ToolMc.y - ChatUI.getInstance().ToolMc.height;
               }
               else
               {
                  ChatUI.getInstance().ToolMc = Commander.getInstance().CommanderTip(TextField(param1.target).mouseX - 50,TextField(param1.target).mouseY,_loc7_);
                  ChatUI.getInstance().ToolMc.y = ChatUI.getInstance().ToolMc.y - ChatUI.getInstance().ToolMc.height;
               }
               this.isShowTool = true;
               ChatUI.getInstance().setSpecialTipState(true);
               StartComderDrag.getInstance().Register(ChatUI.getInstance().ToolMc);
               ChatToolBar.getInstance().HideToolBar();
               ChatChannelPopUp.getInstance().Hide();
               ConstructionOperationWidget.getInstance().Hide();
            }
            else if(_loc6_ == ChatAction.COMMAND_CARD)
            {
               ChatUI.getInstance().setSpecialTipState(false);
               GameKernel.renderManager.getUI().removeComponent(GemcheckPopUI.getInstance()._mc);
               if(_loc7_ == -1)
               {
                  return;
               }
               ChatAction.sendObjUserId = _loc8_;
               CommanderRouter.instance.onSendMsgCOMMANDERSTONEINFO(_loc7_,ChatAction.sendObjUserId);
            }
         }
         else if(param1.text == StringManager.getInstance().getMessageString("ChatingTXT18"))
         {
            PropsBuyUI.getInstance().Init();
            PropsBuyUI.getInstance().setpreant("xiaolaba");
            PropsBuyUI.getInstance().SetState(921);
            PropsBuyUI.getInstance().InitPopUp();
            GameKernel.popUpDisplayManager.Show(PropsBuyUI.getInstance());
         }
         else if(param1.text == "RAID")
         {
            RaidProps.getInstance().Init();
            GameKernel.popUpDisplayManager.Show(RaidProps.getInstance());
         }
         else
         {
            this.isClickUserName = true;
            _loc2_ = ChatUI.getInstance().Parser(param1.text);
            ChatAction.currentPlayer.objGuid = _loc2_.Guid;
            ChatAction.currentPlayer.userName = _loc2_.Name;
            if(_loc2_.Guid == GamePlayer.getInstance().Guid || _loc2_.Guid == GamePlayer.getInstance().userID)
            {
               return;
            }
            if(ChatUI.getInstance().ToolMc && Boolean(this.mParent.contains(ChatUI.getInstance().ToolMc)))
            {
               this.mParent.removeChild(ChatUI.getInstance().ToolMc);
            }
            ChatUI.getInstance().setSpecialTipState(false);
            GameKernel.renderManager.getUI().removeComponent(GemcheckPopUI.getInstance()._mc);
            ChatToolBar.getInstance().setLocationXY(TextField(param1.target).mouseX,TextField(param1.target).mouseY - ChatToolBar.getInstance().getToolBar().height);
            ChatToolBar.getInstance().setToolBar(this.mParent);
            ChatToolBar.getInstance().setChatDestPlayer(_loc2_);
            ChatChannelPopUp.getInstance().Hide();
            ConstructionOperationWidget.getInstance().Hide();
         }
      }
      
      private function onChatTextAreaHandler(param1:MouseEvent) : void
      {
         ChatUI.getInstance().setSpecialTipState(false);
         GameKernel.renderManager.getUI().removeComponent(GemcheckPopUI.getInstance()._mc);
         if(this.isClickUserName && ChatToolBar.getInstance().isShow())
         {
            ChatToolBar.getInstance().HideToolBar();
         }
         this.isClickUserName = false;
      }
      
      public function Send(param1:String) : void
      {
         var _loc2_:String = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(param1 == "$SHOWHTML")
         {
            ChatAction.getInstance().ShowHtml();
            return;
         }
         param1 = param1.replace(this.regand,"&amp;");
         if(!ChatAction.isContinue)
         {
            if(!(ChatAction.currentChannel == ChannelEnum.CHANNEL_PRIVATE || ChatAction.currentChannel == ChannelEnum.CHANNEL_CONSORTIA || ChatAction.currentChannel == ChannelEnum.CHANNEL_GALAXY))
            {
               ChatAction.getInstance().appendMsgContent(StringManager.getInstance().getMessageString("ChatingTXT3"),ChannelEnum.CHANNEL_SYSTEM);
               ChatAction.getInstance().startTick();
               return;
            }
            ChatAction.isContinue = true;
         }
         param1 = StringUitl.Trim(param1);
         if(param1 == "" || param1 == null)
         {
            return;
         }
         this.tf_inputtxt.text = ChatModuleUtil.filterHtmlCode(param1);
         ChatModuleUtil.filterPrivateChannel(param1);
         if(!ChatAction.getInstance().IsFitShareToolContentReg(param1))
         {
            ChatAction.specialType = ChatAction.COMMON_TYPE;
            ChatUI.toolObj.Type = -1;
            ChatUI.toolObj.Proid = -1;
            ChatUI.toolObj.Name = undefined;
         }
         if(!ChatAction.getInstance().IsFitPrivateContentReg(param1) && ChatAction.currentChannel == ChannelEnum.CHANNEL_PRIVATE)
         {
            ChatAction.currentChannel = ChannelEnum.CHANNEL_WORLD;
            ChatUI.getInstance().TF_Channel.text = ChatModuleUtil.MatchChannel(ChannelEnum.CHANNEL_WORLD);
            ChatUI.getInstance().TF_Channel.textColor = ChatModuleUtil.getChannelColor(ChannelEnum.CHANNEL_WORLD);
            ChatAction.getInstance().SendChatMessage(ChannelEnum.CHANNEL_WORLD,param1);
            ChatChannelPopUp.getInstance().setChannel(ChannelEnum.CHANNEL_WORLD);
         }
         else
         {
            if(ChatAction.currentChannel == ChannelEnum.CHANNEL_WORLD && !UpdateResource.getInstance().XiaoLaBaHd(921))
            {
               _loc2_ = StringManager.getInstance().getMessageString("ChatingTXT12");
               _loc3_ = "<a href=\'event:" + StringManager.getInstance().getMessageString("ChatingTXT18") + "\'>" + StringManager.getInstance().getMessageString("ChatingTXT18") + "</a>";
               _loc2_ = _loc2_.replace("XXX",_loc3_);
               ChatAction.getInstance().appendMsgContent(_loc2_,ChannelEnum.CHANNEL_SYSTEM);
               return;
            }
            ChatAction.getInstance().SendChatMessage(ChatAction.currentChannel,this.tf_inputtxt.text);
         }
         if(ChatAction.currentChannel == ChannelEnum.CHANNEL_PRIVATE)
         {
            if(ChatAction.prexChatPlayer.userName != null || ChatAction.prexChatPlayer.userName != "")
            {
               if(GamePlayer.getInstance().language == 10)
               {
                  _loc4_ = ":" + StringUitl.Trim(ChatAction.prexChatPlayer.userName) + "/";
               }
               else
               {
                  _loc4_ = "/" + StringUitl.Trim(ChatAction.prexChatPlayer.userName) + ":";
               }
               this.tf_inputtxt.text = _loc4_;
            }
         }
         ChatAction.isContinue = false;
         if(ChatAction.currentChannel != ChannelEnum.CHANNEL_PRIVATE)
         {
            this.tf_inputtxt.text = "";
         }
         if(ChatAction.currentChannel == ChannelEnum.CHANNEL_PRIVATE || ChatAction.currentChannel == ChannelEnum.CHANNEL_CONSORTIA || ChatAction.currentChannel == ChannelEnum.CHANNEL_GALAXY)
         {
            ChatAction.isContinue = true;
            return;
         }
         ChatAction.getInstance().startTick();
      }
      
      private function onChatHandler(param1:MouseEvent) : void
      {
         ConstructionOperationWidget.getInstance().Hide();
         var _loc2_:DisplayObject = GameKernel.gameLayout.getInstallUI("ChatScene");
         switch(param1.target.name)
         {
            case "btn_decrease":
               if(this.mState == 0)
               {
                  return;
               }
               --this.mState;
               CChatController.getInstance().changeChatContent(this.mState,CChatController.DIRECTION_UNEXPAND);
               break;
            case "btn_increase":
               if(this.mState == 2)
               {
                  return;
               }
               ++this.mState;
               CChatController.getInstance().changeChatContent(this.mState,CChatController.DIRECTION_EXPAND);
               break;
            case "btn_enter":
               this.Send(this.TF_input.text);
               break;
            case "btn_up":
               if(!ChatUI.getInstance().IsChange)
               {
                  ChatChannelPopUp.getInstance().Show(10,-ChatChannelPopUp.getInstance().Display.height,this.mBar);
               }
               else
               {
                  ChatChannelPopUp.getInstance().Hide();
               }
               ChatUI.getInstance().IsChange = !ChatUI.getInstance().IsChange;
         }
         ChatToolBar.getInstance().HideToolBar();
      }
   }
}

