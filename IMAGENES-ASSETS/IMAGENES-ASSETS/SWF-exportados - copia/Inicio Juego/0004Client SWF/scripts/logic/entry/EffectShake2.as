package logic.entry
{
   import flash.display.*;
   import flash.events.*;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class EffectShake2
   {
      
      private var timer:Timer;
      
      private var deley:Number;
      
      private var startX:Number;
      
      private var startY:Number;
      
      private var para:Number;
      
      private var m_contain:Dictionary;
      
      private var currentID:String;
      
      private var m_count:int = 0;
      
      private var m_wave_obj:MovieClip;
      
      public function EffectShake2(param1:Number = 100, param2:Number = 5)
      {
         super();
         this.m_contain = new Dictionary(true);
         this.deley = param1;
         this.para = param2;
         this.timer = new Timer(param1);
         this.timer.addEventListener(TimerEvent.TIMER,this.onTimer);
      }
      
      public function addList(param1:String, param2:*) : void
      {
         this.m_contain[param1] = param2;
      }
      
      private function onTimer(param1:TimerEvent) : void
      {
         this.moveBy();
      }
      
      public function start(param1:String) : void
      {
         this.startX = this.getObject(param1).x;
         this.startY = this.getObject(param1).y;
         this.currentID = param1;
         this.timer.start();
      }
      
      public function wave(param1:String) : void
      {
         if(!this.m_contain[param1])
         {
            return;
         }
         this.m_wave_obj = this.getObject(param1) as MovieClip;
         this.m_wave_obj.addEventListener(Event.ENTER_FRAME,this.onWave);
         this.start(this.m_wave_obj.name);
      }
      
      private function onWave(param1:Event) : void
      {
         if(this.m_count == 20)
         {
            if(this.m_wave_obj != null)
            {
               this.stop();
               this.m_wave_obj.removeEventListener(Event.ENTER_FRAME,this.onWave);
               this.m_wave_obj = null;
            }
            this.m_count = 0;
            return;
         }
         ++this.m_count;
      }
      
      private function getObject(param1:String) : *
      {
         return this.m_contain[param1];
      }
      
      public function stop() : void
      {
         this.timer.stop();
         if(this.getObject(this.currentID))
         {
            this.getObject(this.currentID).x = this.startX;
            this.getObject(this.currentID).y = this.startY;
         }
      }
      
      public function Init() : void
      {
         this.timer.stop();
         if(this.m_wave_obj != null)
         {
            this.m_wave_obj.removeEventListener(Event.ENTER_FRAME,this.onWave);
            this.m_count = 0;
            this.m_wave_obj = null;
         }
      }
      
      public function destory() : void
      {
         this.timer.removeEventListener(TimerEvent.TIMER,this.onTimer);
      }
      
      public function reStart() : void
      {
         this.timer = new Timer(this.deley);
         this.timer.addEventListener(TimerEvent.TIMER,this.onTimer);
      }
      
      private function moveBy() : void
      {
         this.getObject(this.currentID).x = this.startX + Math.random() * this.para;
         this.getObject(this.currentID).y = this.startY + Math.random() * this.para;
      }
   }
}

