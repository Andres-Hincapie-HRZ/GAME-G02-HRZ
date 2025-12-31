package logic.ui
{
   import com.star.frameworks.events.ActionEvent;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import logic.action.ChatAction;
   import logic.entry.ChannelEnum;
   import logic.entry.HButton;
   import logic.game.GameKernel;
   import logic.manager.GameInterActiveManager;
   import logic.widget.ChatModuleUtil;
   
   public class ChatChannelPopUp
   {
      
      private static var instance:ChatChannelPopUp;
      
      private var worldBtn:HButton;
      
      private var corpsBtn:HButton;
      
      private var planetBtn:HButton;
      
      private var teamBtn:HButton;
      
      private var _mc:MovieClip;
      
      public function ChatChannelPopUp()
      {
         super();
      }
      
      public static function getInstance() : ChatChannelPopUp
      {
         if(instance == null)
         {
            instance = new ChatChannelPopUp();
         }
         return instance;
      }
      
      public function get Display() : MovieClip
      {
         return this._mc;
      }
      
      public function Init() : void
      {
         this._mc = GameKernel.getMovieClipInstance("Channelpopup",0,0,true);
         this.initMcElement();
      }
      
      private function initMcElement() : void
      {
         if(this._mc == null)
         {
            return;
         }
         this.worldBtn = new HButton(this._mc.btn_world);
         this.corpsBtn = new HButton(this._mc.btn_corps);
         this.planetBtn = new HButton(this._mc.btn_planet);
         this.teamBtn = new HButton(this._mc.btn_team);
         ChatAction.currentChannel = ChannelEnum.CHANNEL_WORLD;
         ChatUI.getInstance().TF_Channel.text = ChatModuleUtil.MatchChannel(ChannelEnum.CHANNEL_WORLD);
         ChatUI.getInstance().TF_Channel.textColor = ChatModuleUtil.getChannelColor(ChannelEnum.CHANNEL_WORLD);
         ChatUI.getInstance().TF_ChatInput.textColor = ChatModuleUtil.getChannelColor(ChannelEnum.CHANNEL_WORLD);
      }
      
      private function addEvent() : void
      {
         GameInterActiveManager.InstallInterActiveEvent(this.worldBtn.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
         GameInterActiveManager.InstallInterActiveEvent(this.corpsBtn.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
         GameInterActiveManager.InstallInterActiveEvent(this.planetBtn.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
         GameInterActiveManager.InstallInterActiveEvent(this.teamBtn.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
      }
      
      public function Show(param1:int, param2:int, param3:DisplayObjectContainer) : void
      {
         this._mc.x = param1;
         this._mc.y = param2;
         if(param3)
         {
            param3.addChild(this._mc);
         }
         this.addEvent();
      }
      
      public function Hide() : void
      {
         if(this._mc.parent)
         {
            this._mc.parent.removeChild(this._mc);
            GameInterActiveManager.unInstallnterActiveEvent(this.worldBtn.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
            GameInterActiveManager.unInstallnterActiveEvent(this.corpsBtn.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
            GameInterActiveManager.unInstallnterActiveEvent(this.planetBtn.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
            GameInterActiveManager.unInstallnterActiveEvent(this.teamBtn.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
         }
      }
      
      public function setChannel(param1:int) : void
      {
         switch(param1)
         {
            case ChannelEnum.CHANNEL_PRIVATE:
               ChatAction.currentChannel = ChannelEnum.CHANNEL_PRIVATE;
               ChatUI.getInstance().TF_Channel.text = ChatModuleUtil.MatchChannel(ChannelEnum.CHANNEL_PRIVATE);
               ChatUI.getInstance().TF_Channel.textColor = ChatModuleUtil.getChannelColor(ChannelEnum.CHANNEL_PRIVATE);
               ChatUI.getInstance().TF_ChatInput.textColor = ChatModuleUtil.getChannelColor(ChannelEnum.CHANNEL_PRIVATE);
         }
      }
      
      private function onHandler(param1:MouseEvent) : void
      {
         switch(param1.target.name)
         {
            case "btn_world":
               ChatAction.currentChannel = ChannelEnum.CHANNEL_WORLD;
               ChatUI.getInstance().TF_Channel.text = ChatModuleUtil.MatchChannel(ChannelEnum.CHANNEL_WORLD);
               ChatUI.getInstance().TF_Channel.textColor = ChatModuleUtil.getChannelColor(ChannelEnum.CHANNEL_WORLD);
               ChatUI.getInstance().TF_ChatInput.textColor = ChatModuleUtil.getChannelColor(ChannelEnum.CHANNEL_WORLD);
               break;
            case "btn_corps":
               ChatAction.currentChannel = ChannelEnum.CHANNEL_CONSORTIA;
               ChatUI.getInstance().TF_Channel.text = ChatModuleUtil.MatchChannel(ChannelEnum.CHANNEL_CONSORTIA);
               ChatUI.getInstance().TF_Channel.textColor = ChatModuleUtil.getChannelColor(ChannelEnum.CHANNEL_CONSORTIA);
               ChatUI.getInstance().TF_ChatInput.textColor = ChatModuleUtil.getChannelColor(ChannelEnum.CHANNEL_CONSORTIA);
               break;
            case "btn_planet":
               ChatAction.currentChannel = ChannelEnum.CHANNEL_GALAXY;
               ChatUI.getInstance().TF_Channel.text = ChatModuleUtil.MatchChannel(ChannelEnum.CHANNEL_GALAXY);
               ChatUI.getInstance().TF_Channel.textColor = ChatModuleUtil.getChannelColor(ChannelEnum.CHANNEL_GALAXY);
               ChatUI.getInstance().TF_ChatInput.textColor = ChatModuleUtil.getChannelColor(ChannelEnum.CHANNEL_GALAXY);
               break;
            case "btn_team":
               ChatAction.currentChannel = ChannelEnum.CHANNEL_TEAM;
               ChatUI.getInstance().TF_Channel.text = ChatModuleUtil.MatchChannel(ChannelEnum.CHANNEL_TEAM);
               ChatUI.getInstance().TF_Channel.textColor = ChatModuleUtil.getChannelColor(ChannelEnum.CHANNEL_TEAM);
               ChatUI.getInstance().TF_ChatInput.textColor = ChatModuleUtil.getChannelColor(ChannelEnum.CHANNEL_TEAM);
         }
         ChatUI.getInstance().TF_ChatInput.text = "";
         this.Hide();
         ChatUI.getInstance().IsChange = !ChatUI.getInstance().IsChange;
      }
   }
}

