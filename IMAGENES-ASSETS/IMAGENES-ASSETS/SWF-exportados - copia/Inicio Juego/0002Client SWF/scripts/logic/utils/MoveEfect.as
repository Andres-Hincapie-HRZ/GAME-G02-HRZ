package logic.utils
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import logic.game.GameKernel;
   import logic.ui.PackUi;
   
   public class MoveEfect
   {
      
      private static var instance:MoveEfect;
      
      public function MoveEfect()
      {
         super();
      }
      
      public static function getInstance() : MoveEfect
      {
         if(instance == null)
         {
            instance = new MoveEfect();
         }
         return instance;
      }
      
      public function PackYM(param1:MovieClip) : void
      {
      }
      
      public function BlackHd(param1:MovieClip, param2:MovieClip, param3:Number = 0.5) : void
      {
         param2.graphics.clear();
         param2.graphics.beginFill(0,param3);
         param2.graphics.drawRect(GameKernel.fullRect.x,GameKernel.fullRect.y,GameKernel.fullRect.width,GameKernel.fullRect.height + 130);
         param2.graphics.endFill();
         param1.addChild(param2);
         var _loc4_:Point = param1.localToGlobal(new Point(GameKernel.fullRect.x,GameKernel.fullRect.y));
         param2.x = GameKernel.fullRect.x - _loc4_.x;
         param2.y = GameKernel.fullRect.y - _loc4_.y;
         if(param3 == 0)
         {
            param2.addEventListener(MouseEvent.MOUSE_DOWN,PackUi.getInstance().HeiseDownHd);
         }
      }
      
      public function DeleteFun(param1:MovieClip) : void
      {
         param1.addEventListener(MouseEvent.MOUSE_DOWN,PackUi.getInstance().HeiseDownHd);
      }
   }
}

