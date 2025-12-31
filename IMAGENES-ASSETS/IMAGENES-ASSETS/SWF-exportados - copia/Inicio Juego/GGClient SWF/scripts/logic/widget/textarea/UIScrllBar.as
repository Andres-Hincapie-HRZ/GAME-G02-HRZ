package logic.widget.textarea
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.geom.RectangleKit;
   import com.star.frameworks.utils.HashSet;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import logic.entry.HButton;
   import logic.game.GameKernel;
   import logic.manager.GameInterActiveManager;
   
   public class UIScrllBar extends Container
   {
      
      private var mParent:*;
      
      private var mUpName:String;
      
      private var mDownName:String;
      
      private var mPageName:String;
      
      private var mUpBtn:HButton;
      
      private var mDownBtn:HButton;
      
      private var mPageBtn:HButton;
      
      private var mText:TextField;
      
      private var TextArea:HashSet;
      
      public function UIScrllBar(param1:* = null, param2:String = null, param3:String = null, param4:String = null)
      {
         super();
         this.mParent = param1;
         this.mUpName = param2;
         this.mDownName = param3;
         this.mPageName = param4;
         setEnable(true);
      }
      
      public function Location(param1:RectangleKit) : void
      {
         if(Boolean(this.getUpMc()) && Boolean(this.getDownMc()) && Boolean(this.getPageMc()))
         {
            this.getUpMc().y = 0;
            this.getDownMc().y = param1.height - this.getDownMc().height - this.getPageMc().height;
            this.getPageMc().y = this.getDownMc().y + this.getDownMc().height;
         }
      }
      
      public function getUpMc() : MovieClip
      {
         return this.mUpBtn != null ? this.mUpBtn.m_movie : null;
      }
      
      public function getDownMc() : MovieClip
      {
         return this.mDownBtn != null ? this.mDownBtn.m_movie : null;
      }
      
      public function getPageMc() : MovieClip
      {
         return this.mPageBtn != null ? this.mPageBtn.m_movie : null;
      }
      
      public function setUpBtn(param1:String = null) : void
      {
         if(param1)
         {
            this.mUpBtn = new HButton(GameKernel.getMovieClipInstance(param1));
         }
         else
         {
            this.mUpBtn = new HButton(GameKernel.getMovieClipInstance(this.mUpName));
         }
         addChild(this.mUpBtn.m_movie);
      }
      
      public function setDownBtn(param1:String = null) : void
      {
         if(param1)
         {
            this.mDownBtn = new HButton(GameKernel.getMovieClipInstance(param1));
         }
         else
         {
            this.mDownBtn = new HButton(GameKernel.getMovieClipInstance(this.mDownName));
         }
         addChild(this.mDownBtn.m_movie);
      }
      
      public function setPageBtn(param1:String = null) : void
      {
         if(param1)
         {
            this.mPageBtn = new HButton(GameKernel.getMovieClipInstance(param1));
         }
         else
         {
            this.mPageBtn = new HButton(GameKernel.getMovieClipInstance(this.mPageName));
         }
         addChild(this.mPageBtn.m_movie);
      }
      
      public function registerEvent() : void
      {
         if(this.mUpBtn)
         {
            GameInterActiveManager.InstallInterActiveEvent(this.mUpBtn.m_movie,ActionEvent.ACTION_CLICK,this.onBtnHandler);
         }
         if(this.mDownBtn)
         {
            GameInterActiveManager.InstallInterActiveEvent(this.mDownBtn.m_movie,ActionEvent.ACTION_CLICK,this.onBtnHandler);
         }
         if(this.mPageBtn)
         {
            GameInterActiveManager.InstallInterActiveEvent(this.mPageBtn.m_movie,ActionEvent.ACTION_CLICK,this.onBtnHandler);
         }
      }
      
      public function unRegisterEvent() : void
      {
         if(this.mUpBtn)
         {
            GameInterActiveManager.unInstallnterActiveEvent(this.mUpBtn.m_movie,ActionEvent.ACTION_CLICK,this.onBtnHandler);
         }
         if(this.mDownBtn)
         {
            GameInterActiveManager.unInstallnterActiveEvent(this.mDownBtn.m_movie,ActionEvent.ACTION_CLICK,this.onBtnHandler);
         }
         if(this.mPageBtn)
         {
            GameInterActiveManager.unInstallnterActiveEvent(this.mPageBtn.m_movie,ActionEvent.ACTION_CLICK,this.onBtnHandler);
         }
      }
      
      private function onBtnHandler(param1:MouseEvent) : void
      {
         param1.updateAfterEvent();
         if(this.TextArea == null)
         {
            this.TextArea = CTextArea(parent).ComponentList;
         }
         if(this.mText == null)
         {
            this.mText = CChatContent(this.TextArea.Get("CChatContent")).TextArea;
         }
         switch(param1.target.name)
         {
            case "Up":
               --this.mText.scrollV;
               break;
            case "Down":
               this.mText.scrollV += 1;
               break;
            case "Next":
               this.mText.scrollV = this.mText.maxScrollV;
         }
      }
      
      public function updateScroll() : void
      {
         if(this.TextArea == null)
         {
            this.TextArea = CTextArea(parent).ComponentList;
         }
         if(this.mText == null)
         {
            this.mText = CChatContent(this.TextArea.Get("CChatContent")).TextArea;
         }
      }
   }
}

