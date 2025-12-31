package logic.game
{
   public final class CDN
   {
      
      public static var CDN_PATH:String;
      
      public static var avatar:String;
      
      public static var floor:String;
      
      public static var spAvatar:String;
      
      public static var client:String;
      
      public static var res:String;
      
      public static var map:String;
      
      public static var galayPath:String;
      
      private static var instance:CDN;
      
      public static const SUB_ASSET_SURFACE:String = "surface/";
      
      public static const SUB_ASSET_GALAXY:String = "galaxy/";
      
      public static const SUB_ASSET_OUTSIDE:String = "outside/";
      
      public function CDN()
      {
         super();
      }
      
      public static function getInstance() : CDN
      {
         if(instance == null)
         {
            instance = new CDN();
         }
         return instance;
      }
      
      public function Parser(param1:Object) : void
      {
         CDN_PATH = param1.cdn;
         res = param1.res;
         client = param1.client;
         floor = param1.floor;
         spAvatar = param1.sp;
         avatar = param1.avatar;
         map = param1.map;
         galayPath = param1.galaxy;
      }
   }
}

