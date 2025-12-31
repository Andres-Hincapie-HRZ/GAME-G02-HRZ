package logic.utils
{
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import logic.game.GameKernel;
   import logic.reader.CScienceReader;
   
   public class McBitmap
   {
      
      private static var instance:McBitmap;
      
      public var mcarr:Array = new Array();
      
      private var mc:MovieClip;
      
      private var mc1:MovieClip;
      
      public var mcarr1:Array = new Array();
      
      public function McBitmap()
      {
         super();
      }
      
      public static function getInstance() : McBitmap
      {
         if(instance == null)
         {
            instance = new McBitmap();
         }
         return instance;
      }
      
      public function begin() : void
      {
         this.comHd();
      }
      
      private function comHd() : void
      {
         var _loc1_:Bitmap = null;
         var _loc2_:Bitmap = null;
         var _loc4_:Class = null;
         var _loc3_:uint = 0;
         while(_loc3_ < 111)
         {
            if(_loc3_ < 64)
            {
               _loc1_ = new Bitmap(GameKernel.getTextureInstance(CScienceReader.getInstance().WeaponTechAry[_loc3_].imageFileName));
               _loc2_ = new Bitmap(GameKernel.getTextureInstance(CScienceReader.getInstance().WeaponTechAry[_loc3_].imageFileName));
            }
            else if(_loc3_ >= 64 && _loc3_ < 70)
            {
               _loc1_ = new Bitmap(GameKernel.getTextureInstance(CScienceReader.getInstance().WeaponTechAry[0].imageFileName));
               _loc2_ = new Bitmap(GameKernel.getTextureInstance(CScienceReader.getInstance().WeaponTechAry[0].imageFileName));
            }
            else if(_loc3_ >= 70 && _loc3_ < 97)
            {
               _loc1_ = new Bitmap(GameKernel.getTextureInstance(CScienceReader.getInstance().DefenceTechAry[_loc3_].imageFileName));
               _loc2_ = new Bitmap(GameKernel.getTextureInstance(CScienceReader.getInstance().DefenceTechAry[_loc3_].imageFileName));
            }
            else if(_loc3_ >= 97 && _loc3_ < 100)
            {
               _loc1_ = new Bitmap(GameKernel.getTextureInstance(CScienceReader.getInstance().WeaponTechAry[0].imageFileName));
               _loc2_ = new Bitmap(GameKernel.getTextureInstance(CScienceReader.getInstance().WeaponTechAry[0].imageFileName));
            }
            else if(_loc3_ >= 100 && _loc3_ < 111)
            {
               _loc1_ = new Bitmap(GameKernel.getTextureInstance(CScienceReader.getInstance().TechArr[_loc3_].imageFileName));
               _loc2_ = new Bitmap(GameKernel.getTextureInstance(CScienceReader.getInstance().TechArr[_loc3_].imageFileName));
            }
            this.mc = new MovieClip();
            this.mc.addChild(_loc1_);
            this.mc1 = new MovieClip();
            this.mc1.addChild(_loc2_);
            _loc1_.width = 46;
            _loc1_.height = 46;
            _loc2_.width = _loc1_.width * 0.5;
            _loc2_.height = _loc1_.width * 0.5;
            _loc2_.x = 5;
            _loc2_.y = 5;
            this.mcarr.push(this.mc);
            this.mcarr1.push(this.mc1);
            _loc3_++;
         }
      }
   }
}

