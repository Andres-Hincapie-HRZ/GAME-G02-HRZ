package logic.ui
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import logic.entry.test.MovieClipDataBox;
   import logic.game.GameKernel;
   import logic.ui.info.BleakingLineForThai;
   
   public class MessageBox
   {
      
      private static var _movie:MovieClip = GameKernel.getMovieClipInstance("HireScenePopup");
      
      private static var _movieData:MovieClipDataBox = new MovieClipDataBox(_movie,true);
      
      private static var _defaultHandle:Function = null;
      
      private static var _instance:MessageBox = null;
      
      public function MessageBox(param1:HHH)
      {
         super();
      }
      
      public static function show(param1:String, param2:Function = null) : void
      {
         _movie.x = GameKernel.getStageWidth() * 0.5;
         _movie.y = GameKernel.getStageHeight() * 0.5;
         var _loc3_:TextField = _movieData.getTF("tf_content");
         _loc3_.multiline = true;
         _loc3_.wordWrap = true;
         _loc3_.htmlText = param1;
         BleakingLineForThai.GetInstance().BleakThaiLanguage(_loc3_,65535);
         var _loc4_:MovieClip = _movieData.getMC("mc_ensure");
         _defaultHandle = param2;
         _loc4_.addEventListener(MouseEvent.CLICK,onClick);
         var _loc5_:MovieClip = _movieData.getMC("btn_cancel");
         _loc5_.addEventListener(MouseEvent.CLICK,onCancel);
         GameKernel.renderManager.getUI().addComponent(_movie);
      }
      
      private static function onClick(param1:MouseEvent) : void
      {
         if(_defaultHandle != null)
         {
            _defaultHandle();
         }
         var _loc2_:MovieClip = _movieData.getMC("mc_ensure");
         _loc2_.removeEventListener(MouseEvent.CLICK,onClick);
         GameKernel.renderManager.getUI().removeComponent(_movie);
      }
      
      private static function onCancel(param1:MouseEvent) : void
      {
         GameKernel.renderManager.getUI().removeComponent(_movie);
      }
      
      public static function get instance() : MessageBox
      {
         if(_instance == null)
         {
            _instance = new MessageBox(new HHH());
         }
         return _instance;
      }
   }
}

class HHH
{
   
   public function HHH()
   {
      super();
   }
}
