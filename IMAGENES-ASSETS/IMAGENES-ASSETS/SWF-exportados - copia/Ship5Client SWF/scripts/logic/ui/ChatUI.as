package logic.ui
{
   import com.star.frameworks.geom.RectangleKit;
   import com.star.frameworks.utils.StringUitl;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.text.TextField;
   import logic.action.ChatAction;
   import logic.entry.ChannelEnum;
   import logic.game.GameKernel;
   import logic.utils.Commander;
   import logic.widget.StartComderDrag;
   import logic.widget.textarea.CChatChannelBar;
   import logic.widget.textarea.CChatInputBar;
   import logic.widget.textarea.CTextArea;
   import logic.widget.textarea.UIScrllBar;
   
   public class ChatUI
   {
      
      private static var instance:ChatUI;
      
      public static var chatUIWidth:int = 0;
      
      public static var chatUIHeight:int = 0;
      
      public static var toolObj:Object = new Object();
      
      private var isChange:Boolean;
      
      private var _recivedChannlArray:Array;
      
      private var m_TextArea:CTextArea;
      
      private var _toolMc:*;
      
      private var LastStageWidth:int;
      
      public function ChatUI()
      {
         super();
         this._recivedChannlArray = new Array();
         this.m_TextArea = new CTextArea(new RectangleKit(0,0,364,100));
         this.m_TextArea.x = 0;
         this.m_TextArea.y = 500;
         toolObj.Type = -1;
         toolObj.Proid = -1;
         toolObj.Name = undefined;
         toolObj.CommandID = -1;
         if(this.m_TextArea.stage)
         {
            this.LastStageWidth = this.m_TextArea.stage.stageWidth;
            this.m_TextArea.stage.addEventListener(Event.RESIZE,this.OnResize);
         }
         else
         {
            this.m_TextArea.addEventListener(Event.ADDED_TO_STAGE,this.OnAddToStage);
         }
      }
      
      public static function getInstance() : ChatUI
      {
         if(instance == null)
         {
            instance = new ChatUI();
         }
         return instance;
      }
      
      public function selectRecivedChannel(param1:int) : void
      {
         this._recivedChannlArray.push(param1);
      }
      
      public function get ToolMc() : *
      {
         return this._toolMc;
      }
      
      public function set ToolMc(param1:*) : void
      {
         this._toolMc = param1;
      }
      
      public function get IsChange() : Boolean
      {
         return this.isChange;
      }
      
      public function set IsChange(param1:Boolean) : void
      {
         this.isChange = param1;
      }
      
      public function get TextArea() : CTextArea
      {
         return this.m_TextArea;
      }
      
      public function get RecivedChannel() : Array
      {
         return this._recivedChannlArray;
      }
      
      public function get TF_Channel() : TextField
      {
         return CChatInputBar(this.TextArea.ComponentList.Get("CChatInputBar")).TF_Channel;
      }
      
      public function get TF_ChatInput() : TextField
      {
         return CChatInputBar(this.TextArea.ComponentList.Get("CChatInputBar")).TF_input;
      }
      
      public function getChatInputBar() : CChatInputBar
      {
         return CChatInputBar(this.TextArea.ComponentList.Get("CChatInputBar"));
      }
      
      public function getUIScrollBar() : UIScrllBar
      {
         return UIScrllBar(this.TextArea.ComponentList.Get("UIScrllBar"));
      }
      
      public function getChannelBar() : CChatChannelBar
      {
         return CChatChannelBar(this.TextArea.ComponentList.Get("CChatChannelBar"));
      }
      
      public function copySysteNotice(param1:String) : void
      {
         var _loc2_:String = null;
         if(this.TF_ChatInput.text != null)
         {
            if(ChatAction.getInstance().IsFitShareToolContentReg(StringUitl.Trim(this.TF_ChatInput.text)))
            {
               this.TF_ChatInput.text = "";
            }
            if(ChatUI.toolObj.Name != undefined)
            {
               _loc2_ = this.TF_ChatInput.text;
               this.TF_ChatInput.text = this.TF_ChatInput.text.concat(param1);
            }
         }
      }
      
      public function copyCommanderNotice(param1:String) : void
      {
         if(this.TF_Channel.text != null)
         {
            this.TF_ChatInput.text = StringUitl.Trim(param1);
         }
      }
      
      public function Init() : void
      {
         var _loc1_:DisplayObject = null;
         this.initCustomChannel();
         ChatChannelPopUp.getInstance().Init();
         if(chatUIWidth == 0 && chatUIHeight == 0)
         {
            _loc1_ = GameKernel.gameLayout.getInstallUI("ChatScene");
            ChatUI.chatUIWidth = _loc1_.width;
            ChatUI.chatUIHeight = _loc1_.height - 21;
         }
      }
      
      private function OnAddToStage(param1:Event) : void
      {
         this.m_TextArea.removeEventListener(Event.ADDED_TO_STAGE,this.OnAddToStage);
         this.LastStageWidth = this.m_TextArea.stage.stageWidth;
         this.m_TextArea.stage.addEventListener(Event.RESIZE,this.OnResize);
      }
      
      public function Parser(param1:String) : Object
      {
         var _loc2_:Object = new Object();
         var _loc3_:Array = param1.split(",");
         _loc2_.Guid = parseInt(_loc3_[0]);
         _loc2_.Name = _loc3_[1];
         return _loc2_;
      }
      
      public function ParseSpecial(param1:String) : Object
      {
         var _loc2_:Object = new Object();
         var _loc3_:Array = param1.split(",");
         _loc2_.Type = parseInt(_loc3_[0]);
         _loc2_.ID = parseInt(_loc3_[1]);
         _loc2_.Guid = parseInt(_loc3_[2]);
         _loc2_.Name = _loc3_[3];
         return _loc2_;
      }
      
      public function setSpecialTipState(param1:Boolean) : void
      {
         if(param1)
         {
            if(this._toolMc)
            {
               this.TextArea.addChild(this._toolMc);
            }
         }
         else if(this._toolMc && Boolean(this._toolMc.parent))
         {
            this.TextArea.removeChild(this._toolMc);
            StartComderDrag.getInstance().unRegister(this._toolMc);
            Commander.getInstance().CloseEnHd();
         }
      }
      
      private function initCustomChannel() : void
      {
         if(0 == ChatAction.getInstance().ChatChannelList.length)
         {
            ChatAction.getInstance().ChatChannelList.push(ChannelEnum.CHANNEL_WORLD);
            ChatAction.getInstance().ChatChannelList.push(ChannelEnum.CHANNEL_TEAM);
            ChatAction.getInstance().ChatChannelList.push(ChannelEnum.CHANNEL_PRIVATE);
            ChatAction.getInstance().ChatChannelList.push(ChannelEnum.CHANNEL_GALAXY);
            ChatAction.getInstance().ChatChannelList.push(ChannelEnum.CHANNEL_CONSORTIA);
            ChatAction.getInstance().ChatChannelList.push(ChannelEnum.CHANNEL_GMNOTICE);
            ChatAction.getInstance().ChatChannelList.push(ChannelEnum.CHANNEL_FIGHTING);
         }
      }
      
      public function HideAllChatModuleUI() : void
      {
         ChatToolBar.getInstance().HideToolBar();
         ChatChannelPopUp.getInstance().Hide();
         ChatUI.getInstance().setSpecialTipState(false);
         GameKernel.renderManager.getUI().removeComponent(GemcheckPopUI.getInstance()._mc);
      }
      
      private function OnResize(param1:Event) : void
      {
         this.m_TextArea.x -= (this.m_TextArea.stage.stageWidth - this.LastStageWidth) / 2;
         this.LastStageWidth = this.m_TextArea.stage.stageWidth;
      }
   }
}

