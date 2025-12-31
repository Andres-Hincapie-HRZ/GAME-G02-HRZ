package logic.entry
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.events.ActionEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.ui.Mouse;
   import logic.game.GameKernel;
   import logic.manager.GameInterActiveManager;
   
   public class CMouseCursor extends Container
   {
      
      private static var instance:CMouseCursor;
      
      private var cursor:MovieClip;
      
      private var curState:int;
      
      private var bitData:Bitmap;
      
      public function CMouseCursor()
      {
         super("MouseCursor");
      }
      
      public static function getInstance() : CMouseCursor
      {
         if(instance == null)
         {
            instance = new CMouseCursor();
         }
         return instance;
      }
      
      public function get Cursor() : MovieClip
      {
         return this.cursor;
      }
      
      public function initCursorEvent() : void
      {
         Mouse.hide();
         GameKernel.getInstance().addChild(this);
         GameInterActiveManager.InstallInterActiveEvent(GameKernel.getInstance().stage,ActionEvent.ACTION_MOUSE_MOVE,this.onUpdateMouseCursor);
      }
      
      private function ClearGameDefaultMouse() : void
      {
         if(this.bitData != null && this.bitData.parent != null)
         {
            removeChild(this.bitData);
         }
      }
      
      public function setSystemDefaultState() : void
      {
         if(this.parent != null)
         {
            this.parent.removeChild(this);
            GameInterActiveManager.unInstallnterActiveEvent(GameKernel.getInstance().stage,ActionEvent.ACTION_MOUSE_MOVE,this.onUpdateMouseCursor);
         }
         this.curState = 0;
         Mouse.show();
      }
      
      private function onUpdateMouseCursor(param1:MouseEvent) : void
      {
         x = param1.stageX;
         y = param1.stageY;
         param1.updateAfterEvent();
      }
      
      public function setOriginality() : void
      {
         this.Release();
         this.setSystemDefaultState();
      }
      
      public function setSelectHandlerState() : void
      {
         if(this.curState == 0)
         {
            return;
         }
         this.Release();
         this.bitData = new Bitmap(GameKernel.getTextureInstance("Mouse"));
         addChild(this.bitData);
         this.curState = 0;
         this.initCursorEvent();
      }
      
      public function setFetchHandlerState(param1:MouseEvent) : void
      {
         if(this.curState == 1)
         {
            return;
         }
         this.Release();
         this.cursor = GameKernel.getMovieClipInstance("FetchMc",0,0,true);
         this.curState = 1;
         addChild(this.cursor);
         this.x = param1.stageX;
         this.y = param1.stageY;
         this.initCursorEvent();
      }
      
      public function setClearHandlerState(param1:MouseEvent) : void
      {
         if(this.curState == 2)
         {
            return;
         }
         this.Release();
         this.cursor = GameKernel.getMovieClipInstance("MoveMc",0,0,true);
         this.curState = 2;
         addChild(this.cursor);
         this.x = param1.stageX;
         this.y = param1.stageY;
         this.initCursorEvent();
      }
      
      private function Release() : void
      {
         if(this.cursor != null && this.cursor.parent != null)
         {
            this.cursor.stop();
            this.cursor.parent.removeChild(this.cursor);
            this.cursor = null;
         }
      }
   }
}

