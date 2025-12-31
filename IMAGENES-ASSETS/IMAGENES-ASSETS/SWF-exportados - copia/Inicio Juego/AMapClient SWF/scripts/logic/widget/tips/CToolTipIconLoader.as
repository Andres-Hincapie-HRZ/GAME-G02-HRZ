package logic.widget.tips
{
   import flash.display.Bitmap;
   import logic.game.GameKernel;
   
   public class CToolTipIconLoader
   {
      
      public function CToolTipIconLoader()
      {
         super();
      }
      
      public static function getTexture(param1:String) : Bitmap
      {
         return new Bitmap(GameKernel.getTextureInstance(param1));
      }
   }
}

