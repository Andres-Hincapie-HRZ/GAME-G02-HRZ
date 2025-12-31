package logic.widget
{
   import com.star.frameworks.display.Container;
   import flash.display.MovieClip;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import logic.game.GameKernel;
   
   public class CMediaPlayer
   {
      
      private static var instance:CMediaPlayer;
      
      private var _background:Container;
      
      private var _callBack:Function;
      
      private var _sour:MovieClip;
      
      private var _timer:Timer;
      
      public function CMediaPlayer()
      {
         super();
         this._timer = new Timer(25);
         this._timer.addEventListener(TimerEvent.TIMER,this.onTick);
      }
      
      public static function getInstance() : CMediaPlayer
      {
         if(instance == null)
         {
            instance = new CMediaPlayer();
         }
         return instance;
      }
      
      public function setCallBack(param1:Function) : void
      {
         this._callBack = param1;
      }
      
      private function DoCallBack() : void
      {
         if(this._callBack != null)
         {
            this._callBack();
         }
      }
      
      public function Draw() : void
      {
         if(this._background == null)
         {
            this._background = new Container();
            this._background.graphics.clear();
            this._background.graphics.beginFill(0);
            this._background.graphics.drawRect(GameKernel.fullRect.x,GameKernel.fullRect.y,GameKernel.fullRect.width,GameKernel.fullRect.height);
            this._background.graphics.endFill();
            GameKernel.renderManager.getScene().addComponent(this._background);
         }
      }
      
      public function Clear() : void
      {
         if(GameKernel.renderManager.getScene().getContainer().contains(this._background))
         {
            GameKernel.renderManager.getScene().removeComponent(this._background);
         }
      }
      
      public function setMediaDocument(param1:MovieClip, param2:Function) : void
      {
         this._sour = param1;
         this._callBack = param2;
      }
      
      public function Play() : void
      {
         if(Boolean(this._timer) && this._timer.running)
         {
            return;
         }
         if(!this._timer.hasEventListener(TimerEvent.TIMER))
         {
            this._timer.addEventListener(TimerEvent.TIMER,this.onTick);
         }
         this._timer.start();
      }
      
      public function Stop() : void
      {
         if(Boolean(this._timer) && !this._timer.running)
         {
            return;
         }
         if(this._timer.hasEventListener(TimerEvent.TIMER))
         {
            this._timer.removeEventListener(TimerEvent.TIMER,this.onTick);
         }
         this._timer.stop();
      }
      
      private function onTick(param1:TimerEvent) : void
      {
         if(this._sour == null)
         {
            this._timer.stop();
            this._timer.removeEventListener(TimerEvent.TIMER,this.onTick);
            return;
         }
         if(this._sour.currentFrame === this._sour.totalFrames)
         {
            this._timer.stop();
            this._timer.removeEventListener(TimerEvent.TIMER,this.onTick);
            this.DoCallBack();
            return;
         }
         this._sour.nextFrame();
      }
   }
}

