package logic.widget.textarea
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.events.ActionEvent;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import logic.game.GameKernel;
   import logic.manager.GameInterActiveManager;
   import logic.ui.ChatCustomChannelPopUp;
   
   public class CChatChannelBar extends Container
   {
      
      private var mChannelType:int;
      
      private var mObj:MovieClip;
      
      private var mParent:*;
      
      private var mCustomChannel:MovieClip;
      
      private var mBase:MovieClip;
      
      private var mExpand:Boolean;
      
      public function CChatChannelBar(param1:*)
      {
         super();
         this.mParent = param1;
         this.mExpand = false;
         this.mObj = GameKernel.getMovieClipInstance("ChannelMc");
         this.mCustomChannel = this.mObj.mc_channel as MovieClip;
         this.mBase = this.mObj.mc_base as MovieClip;
         ChatCustomChannelPopUp.getInstance().Init(this.mBase);
         setEnable(true);
         GameInterActiveManager.InstallInterActiveEvent(this.mCustomChannel,ActionEvent.ACTION_CLICK,this.onPopCustomChannel);
         addChild(this.mObj);
      }
      
      public function get ChannelBar() : MovieClip
      {
         return this.mObj;
      }
      
      private function onPopCustomChannel(param1:MouseEvent) : void
      {
         if(this.mExpand)
         {
            ChatCustomChannelPopUp.getInstance().setVisible(false);
         }
         else
         {
            ChatCustomChannelPopUp.getInstance().setVisible(true);
         }
         this.mExpand = !this.mExpand;
      }
   }
}

