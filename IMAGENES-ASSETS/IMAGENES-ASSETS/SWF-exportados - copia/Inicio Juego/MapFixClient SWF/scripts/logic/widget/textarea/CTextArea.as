package logic.widget.textarea
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.geom.RectangleKit;
   import com.star.frameworks.utils.HashSet;
   import flash.events.MouseEvent;
   import logic.entry.GameStageEnum;
   import logic.game.GameKernel;
   import logic.manager.GameInterActiveManager;
   import logic.widget.OutSideGalaxiasDragger;
   
   public class CTextArea extends Container
   {
      
      private var mComponentList:HashSet;
      
      private var mRect:RectangleKit;
      
      private var mBgColor:uint;
      
      private var mBgAlpha:Number;
      
      private var mState:int;
      
      private var uiScrollBar:UIScrllBar;
      
      private var content:CChatContent;
      
      private var channelBar:CChatChannelBar;
      
      private var inputBar:CChatInputBar;
      
      public function CTextArea(param1:RectangleKit)
      {
         super();
         this.mComponentList = new HashSet();
         this.mRect = param1;
         this.installUIScrollBar();
         this.installContent();
         this.installInputBar();
         this.installChannelBar();
         if(GameKernel.currentGameStage == GameStageEnum.GAME_STAGE_STARSURFACE)
         {
            this.setBgSelectedState();
         }
         else
         {
            this.setBgUnSelectedState();
         }
         this.addCTextAreaEvent();
      }
      
      public function get ComponentList() : HashSet
      {
         return this.mComponentList;
      }
      
      private function Draw(param1:uint = 0, param2:Number = 0.7) : void
      {
         this.setBackgroundColor(param1);
         this.setBackgroundAlpha(param2);
         graphics.clear();
         graphics.beginFill(this.mBgColor,this.mBgAlpha);
         graphics.drawRoundRect(this.mRect.x,this.mRect.y,this.mRect.width,this.mRect.height,10,10);
         graphics.endFill();
      }
      
      public function setBgUnSelectedState() : void
      {
         this.Draw(0,0.1);
         this.channelBar.ChannelBar.alpha = 0.2;
      }
      
      public function setBgSelectedState() : void
      {
         this.Draw();
         this.channelBar.ChannelBar.alpha = 1;
      }
      
      public function Validate() : void
      {
         if(GameKernel.currentGameStage == GameStageEnum.GAME_STAGE_STARSURFACE)
         {
            this.setBgSelectedState();
            this.removeCTextAreaEvent();
         }
         else
         {
            this.setBgUnSelectedState();
            this.addCTextAreaEvent();
         }
      }
      
      public function rePaint(param1:RectangleKit, param2:uint = 0, param3:Number = 0.7) : void
      {
         this.setRect(param1);
         this.Draw(param2,param3);
         this.uiScrollBar.Location(param1);
         this.content.setXYWH(this.uiScrollBar.width + 5,5,param1.width - this.uiScrollBar.width - 15,param1.height - 15);
         this.inputBar.setLocationXY(0,param1.height);
      }
      
      public function installUIScrollBar() : void
      {
         this.uiScrollBar = new UIScrllBar(this,"Up","Down","Next");
         this.uiScrollBar.setUpBtn();
         this.uiScrollBar.setDownBtn();
         this.uiScrollBar.setPageBtn();
         this.uiScrollBar.registerEvent();
         this.uiScrollBar.Location(this.mRect);
         this.mComponentList.Put("UIScrllBar",this.uiScrollBar);
         addChild(this.uiScrollBar);
      }
      
      public function installContent() : void
      {
         this.content = new CChatContent(this);
         this.content.setXYWH(this.uiScrollBar.width + 5,5,this.mRect.width - this.uiScrollBar.width - 15,this.mRect.height - 15);
         this.mComponentList.Put("CChatContent",this.content);
         addChild(this.content.TextArea);
      }
      
      public function installInputBar() : void
      {
         this.inputBar = new CChatInputBar(this);
         this.inputBar.setLocationXY(0,this.mRect.height);
         this.mComponentList.Put("CChatInputBar",this.inputBar);
         addChild(this.inputBar);
      }
      
      public function installChannelBar() : void
      {
         this.channelBar = new CChatChannelBar(this);
         this.channelBar.setLocationXY(0,-this.channelBar.height);
         this.mComponentList.Put("CChatChannelBar",this.channelBar);
         addChild(this.channelBar);
      }
      
      public function setRect(param1:RectangleKit) : void
      {
         this.mRect = param1;
      }
      
      public function setBackgroundColor(param1:uint) : void
      {
         if(this.mBgColor == param1)
         {
            return;
         }
         this.mBgColor = param1;
      }
      
      public function setBackgroundAlpha(param1:Number) : void
      {
         if(this.mBgAlpha == param1)
         {
            return;
         }
         this.mBgAlpha = param1;
      }
      
      public function addCTextAreaEvent() : void
      {
         GameInterActiveManager.InstallInterActiveEvent(this,ActionEvent.ACTION_MOUSE_OVER,this.onOverHandler);
         GameInterActiveManager.InstallInterActiveEvent(this,ActionEvent.ACTION_MOUSE_OUT,this.onOutHandler);
      }
      
      public function removeCTextAreaEvent() : void
      {
         GameInterActiveManager.unInstallnterActiveEvent(this,ActionEvent.ACTION_MOUSE_OVER,this.onOverHandler);
         GameInterActiveManager.unInstallnterActiveEvent(this,ActionEvent.ACTION_MOUSE_OUT,this.onOutHandler);
      }
      
      private function onOverHandler(param1:MouseEvent) : void
      {
         if(OutSideGalaxiasDragger.getInstance().IsMove)
         {
            return;
         }
         this.setBgSelectedState();
      }
      
      private function onOutHandler(param1:MouseEvent) : void
      {
         if(GameKernel.currentGameStage == GameStageEnum.GAME_STAGE_STARSURFACE)
         {
            return;
         }
         this.setBgUnSelectedState();
      }
   }
}

