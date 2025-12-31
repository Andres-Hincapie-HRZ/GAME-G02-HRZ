package logic.ui
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.utils.CEffectText;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.game.GameKernel;
   import logic.ui.info.BleakingLineForThai;
   
   public class MessagePopup
   {
      
      private static var instance:MessagePopup;
      
      private var _OkClickCallback:Function;
      
      private var _CancelClickCallback:Function;
      
      private var MessageMc:MovieClip;
      
      private var ParentLock:Container;
      
      private var tf_content:TextField;
      
      private var OkButton:HButton;
      
      private var CancelButton:HButton;
      
      private var OkButtonX:int;
      
      public function MessagePopup()
      {
         super();
         this.Init();
      }
      
      public static function getInstance() : MessagePopup
      {
         if(instance == null)
         {
            instance = new MessagePopup();
         }
         return instance;
      }
      
      private function Init() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:HButton = null;
         this.MessageMc = GameKernel.getMovieClipInstance("HireScenePopup",380,300,false);
         _loc1_ = this.MessageMc.getChildByName("mc_ensure") as MovieClip;
         _loc1_.stop();
         this.OkButton = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_ensureClick);
         this.OkButtonX = _loc1_.x;
         _loc1_ = this.MessageMc.getChildByName("btn_cancel") as MovieClip;
         this.CancelButton = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_cancelClick);
         this.tf_content = this.MessageMc.getChildByName("tf_content") as TextField;
         this.ParentLock = new Container("MessageSceneLock");
         this.ParentLock.mouseEnabled = true;
         this.ParentLock.mouseChildren = true;
         this.ParentLock.fillRectangleWithoutBorder(GameKernel.fullRect.x,GameKernel.fullRect.y,GameKernel.fullRect.width,GameKernel.fullRect.height,0,0.5);
      }
      
      public function Show(param1:String, param2:int = 2, param3:Function = null, param4:Function = null, param5:Boolean = false) : void
      {
         if(param2 == 10)
         {
            StoragepopupTip.getInstance().Init();
            StoragepopupTip.getInstance().Show();
            if(GamePlayer.getInstance().PropsPack == PackUi.getInstance().maxNum)
            {
               StoragepopupTip.getInstance().ppd(2);
            }
            else
            {
               StoragepopupTip.getInstance().ppd(1);
            }
            return;
         }
         if(param2 == 0)
         {
            CEffectText.getInstance().showEffectText(GameKernel.renderManager.getUI().getContainer(),param1,param5);
         }
         else
         {
            this._OkClickCallback = param3;
            this._CancelClickCallback = param4;
            this.tf_content.htmlText = param1;
            BleakingLineForThai.GetInstance().BleakThaiLanguage(this.tf_content);
            if(param2 == 1)
            {
               this.OkButton.m_movie.x = this.CancelButton.m_movie.x;
               this.OkButton.setVisible(true);
               this.CancelButton.setVisible(false);
            }
            else if(param2 == 2)
            {
               this.OkButton.setVisible(true);
               this.OkButton.m_movie.x = this.OkButtonX;
               this.CancelButton.setVisible(true);
            }
            else if(param2 == 3)
            {
               this.OkButton.setVisible(false);
               this.CancelButton.setVisible(true);
            }
            else if(param2 == -1)
            {
               this.OkButton.setVisible(false);
               this.CancelButton.setVisible(false);
            }
            else if(param2 == 4)
            {
               this.OkButton.setVisible(true);
               this.OkButton.m_movie.x = this.OkButtonX;
               this.CancelButton.setVisible(true);
            }
            this.ParentLock.fillRectangleWithoutBorder(GameKernel.fullRect.left,GameKernel.fullRect.top,GameKernel.fullRect.width,GameKernel.fullRect.height + 130,0,0.5);
            GameKernel.renderManager.getUI().addComponent(this.ParentLock);
            this.ParentLock.addChild(this.MessageMc);
         }
      }
      
      private function btn_ensureClick(param1:Event) : void
      {
         this.Hide();
         if(this._OkClickCallback != null)
         {
            this._OkClickCallback();
         }
      }
      
      private function btn_cancelClick(param1:Event) : void
      {
         if(this._CancelClickCallback != null)
         {
            this._CancelClickCallback();
         }
         this.Hide();
      }
      
      public function Hide() : void
      {
         if(this.MessageMc.parent != null && this.MessageMc.parent.contains(this.MessageMc))
         {
            this.MessageMc.parent.removeChild(this.MessageMc);
            GameKernel.renderManager.getUI().removeComponent(this.ParentLock);
         }
      }
   }
}

