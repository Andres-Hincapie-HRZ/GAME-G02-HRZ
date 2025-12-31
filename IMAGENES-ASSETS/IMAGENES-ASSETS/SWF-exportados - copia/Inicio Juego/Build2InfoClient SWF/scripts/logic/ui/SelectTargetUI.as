package logic.ui
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import logic.game.GameKernel;
   
   public class SelectTargetUI
   {
      
      private static var _instance:SelectTargetUI = null;
      
      private var _selectedMc:MovieClip;
      
      private var count:Number = 1;
      
      public function SelectTargetUI(param1:Singleton)
      {
         super();
         this._selectedMc = GameKernel.getMovieClipInstance("SelectedPicMc",0,0,true);
         this._selectedMc.name = "selected";
         this._selectedMc.addEventListener(Event.ENTER_FRAME,this.onFrame);
      }
      
      public static function get instance() : SelectTargetUI
      {
         if(_instance == null)
         {
            _instance = new SelectTargetUI(new Singleton());
         }
         return _instance;
      }
      
      private function onFrame(param1:Event) : void
      {
         if(this.count >= 180)
         {
            this.count = 1;
         }
         this._selectedMc.rotation = this.count * 3;
         ++this.count;
      }
      
      public function addFrameEvent() : void
      {
         if(!this._selectedMc.hasEventListener("onFrame"))
         {
            this._selectedMc.addEventListener(Event.ENTER_FRAME,this.onFrame,false,0,true);
         }
      }
      
      public function removeFrameEvent() : void
      {
         if(this._selectedMc.hasEventListener("onFrame"))
         {
            this._selectedMc.removeEventListener(Event.ENTER_FRAME,this.onFrame);
         }
      }
      
      public function get selectedMc() : MovieClip
      {
         return this._selectedMc;
      }
   }
}

class Singleton
{
   
   public function Singleton()
   {
      super();
   }
}
