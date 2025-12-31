package logic.ui
{
   import flash.display.MovieClip;
   import logic.action.ChatAction;
   import logic.entry.ChannelEnum;
   import logic.entry.HButton;
   import logic.game.GameKernel;
   import logic.widget.com.ComCheckBox;
   
   public class ChatCustomChannelPopUp
   {
      
      private static var instance:ChatCustomChannelPopUp;
      
      private var mInstance:MovieClip;
      
      private var mParent:MovieClip;
      
      private var okayBtn:HButton;
      
      private var cancelBtn:HButton;
      
      private var worldBox:ComCheckBox;
      
      private var teamBox:ComCheckBox;
      
      private var corpsBox:ComCheckBox;
      
      private var privateBox:ComCheckBox;
      
      private var planetBox:ComCheckBox;
      
      private var fightBox:ComCheckBox;
      
      public function ChatCustomChannelPopUp()
      {
         super();
      }
      
      public static function getInstance() : ChatCustomChannelPopUp
      {
         if(instance == null)
         {
            instance = new ChatCustomChannelPopUp();
         }
         return instance;
      }
      
      public static function updateChannel(param1:Object, param2:int = 0) : void
      {
         var _loc4_:int = 0;
         var _loc3_:Array = ChatAction.getInstance().ChatChannelList;
         switch(param2)
         {
            case 0:
               if(_loc3_.length == 0)
               {
                  _loc3_.push(param1);
               }
               _loc4_ = 0;
               while(_loc4_ < _loc3_.length)
               {
                  if(_loc3_[_loc4_] == param1)
                  {
                     return;
                  }
                  _loc4_++;
               }
               _loc3_.push(param1);
               break;
            case 1:
               if(_loc3_.length == 0)
               {
                  return;
               }
               _loc4_ = 0;
               while(_loc4_ < _loc3_.length)
               {
                  if(_loc3_[_loc4_] == param1)
                  {
                     _loc3_.splice(_loc4_,1);
                     return;
                  }
                  _loc4_++;
               }
         }
      }
      
      public function Init(param1:MovieClip) : void
      {
         if(this.mInstance != null)
         {
            return;
         }
         this.mParent = param1;
         this.mInstance = GameKernel.getMovieClipInstance("CustomchannelMc");
         this.initMcElement();
      }
      
      public function initMcElement() : void
      {
         this.worldBox = new ComCheckBox(this.mInstance.mc_worldbox,ChannelEnum.CHANNEL_WORLD);
         this.teamBox = new ComCheckBox(this.mInstance.mc_teambox,ChannelEnum.CHANNEL_PRIVATE);
         this.corpsBox = new ComCheckBox(this.mInstance.mc_corpsbox,ChannelEnum.CHANNEL_CONSORTIA);
         this.privateBox = new ComCheckBox(this.mInstance.mc_privatebox,ChannelEnum.CHANNEL_TEAM);
         this.planetBox = new ComCheckBox(this.mInstance.mc_planetbox,ChannelEnum.CHANNEL_GALAXY);
         this.fightBox = new ComCheckBox(this.mInstance.mc_battlebox,ChannelEnum.CHANNEL_FIGHTING);
         this.initCustomChannel();
      }
      
      public function get FightBox() : ComCheckBox
      {
         return this.fightBox;
      }
      
      public function setVisible(param1:Boolean) : void
      {
         if(this.mParent == null)
         {
            return;
         }
         if(param1)
         {
            if(!this.mParent.contains(this.mInstance))
            {
               this.mParent.addChild(this.mInstance);
            }
         }
         else if(this.mParent.contains(this.mInstance))
         {
            this.mParent.removeChild(this.mInstance);
         }
      }
      
      private function initCustomChannel() : void
      {
         this.worldBox.setCheckBoxStateOn();
         this.teamBox.setCheckBoxStateOn();
         this.corpsBox.setCheckBoxStateOn();
         this.privateBox.setCheckBoxStateOn();
         this.planetBox.setCheckBoxStateOn();
         this.fightBox.setCheckBoxStateOn();
      }
   }
}

