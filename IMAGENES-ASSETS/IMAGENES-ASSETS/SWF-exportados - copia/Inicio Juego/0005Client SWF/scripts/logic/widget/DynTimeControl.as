package logic.widget
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class DynTimeControl
   {
      
      private static var instance:DynTimeControl;
      
      private var _time:Timer;
      
      private var _callBack:Function;
      
      public function DynTimeControl()
      {
         super();
      }
      
      public static function getInstance() : DynTimeControl
      {
         if(instance == null)
         {
            instance = new DynTimeControl();
         }
         return instance;
      }
      
      public function Init(param1:int, param2:int = 1, param3:Function = null) : void
      {
         this._callBack = param3;
         if(this._time != null)
         {
            this.DoBack();
            return;
         }
         this._time = new Timer(param1,param2);
         this._time.addEventListener(TimerEvent.TIMER,this.onTimer);
      }
      
      private function onTimer(param1:TimerEvent) : void
      {
         this.DoBack();
         this.Release();
      }
      
      private function DoBack() : void
      {
         if(this._callBack != null)
         {
            this._callBack();
         }
      }
      
      public function Start() : void
      {
         if(this._time == null)
         {
            return;
         }
         if(this._time.running)
         {
            return;
         }
         this._time.start();
      }
      
      public function Stop() : void
      {
         if(this._time == null)
         {
            return;
         }
         if(this._time.running)
         {
            this._time.stop();
         }
      }
      
      public function Release() : void
      {
         if(this._time != null)
         {
            this.Stop();
            this._time.removeEventListener(TimerEvent.TIMER,this.onTimer);
            this._time = null;
         }
      }
   }
}

