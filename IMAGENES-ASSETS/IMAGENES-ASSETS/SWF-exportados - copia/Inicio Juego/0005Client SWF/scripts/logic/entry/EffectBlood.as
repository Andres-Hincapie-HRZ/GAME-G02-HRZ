package logic.entry
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import logic.game.GameKernel;
   
   public class EffectBlood extends Sprite
   {
      
      private var _movie:MovieClip = GameKernel.getMovieClipInstance("BloodbarMc");
      
      private var reduceShield:Number;
      
      private var reduceEndure:Number;
      
      private var count:int = 0;
      
      public function EffectBlood(param1:Number, param2:Number)
      {
         super();
         this._movie = GameKernel.getMovieClipInstance("BloodbarMc");
         this.name = "BleedMC";
         this.addChild(this._movie);
         this._movie.mc_defensebar.width = 60 * param1;
         this._movie.mc_bloodbar.width = 60 * param2;
      }
      
      public function update(param1:Number, param2:Number) : void
      {
         this.reduceShield = param1;
         this.reduceEndure = param2;
         addEventListener(Event.ENTER_FRAME,this.onFrame);
      }
      
      private function onFrame(param1:Event) : void
      {
         if(this.count == 10)
         {
            removeEventListener(Event.ENTER_FRAME,this.onFrame);
            this.parent.removeChild(this);
            this.count = 0;
            return;
         }
         if(this.reduceShield >= 0)
         {
            this._movie.mc_defensebar.width -= 50 * this.reduceShield * 0.1;
         }
         if(this.reduceEndure >= 0)
         {
            this._movie.mc_bloodbar.width -= 50 * this.reduceEndure * 0.1;
         }
         ++this.count;
      }
   }
}

