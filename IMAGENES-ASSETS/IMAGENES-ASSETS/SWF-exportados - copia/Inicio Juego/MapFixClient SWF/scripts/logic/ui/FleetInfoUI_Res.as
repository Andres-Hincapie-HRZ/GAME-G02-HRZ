package logic.ui
{
   import com.star.frameworks.display.loader.ImageLoader;
   import com.star.frameworks.utils.HashSet;
   import flash.display.Bitmap;
   import logic.game.GameKernel;
   
   public class FleetInfoUI_Res
   {
      
      private static var instance:FleetInfoUI_Res;
      
      private var FacebookUserImgCallback:Function;
      
      public var FacebookUserImg:HashSet;
      
      public function FleetInfoUI_Res()
      {
         super();
         this.FacebookUserImg = new HashSet();
      }
      
      public static function GetInstance() : FleetInfoUI_Res
      {
         if(instance == null)
         {
            instance = new FleetInfoUI_Res();
         }
         return instance;
      }
      
      public function GetFacebookUserImg(param1:Number, param2:String, param3:Function) : void
      {
         var _loc4_:Bitmap = null;
         var _loc7_:Bitmap = null;
         var _loc8_:Bitmap = null;
         if(GameKernel.ForRenRen != 1)
         {
            if(GameKernel.facebookFriendImage.ContainsKey(param1))
            {
               _loc7_ = GameKernel.facebookFriendImage.Get(param1);
               if((Boolean(_loc7_)) && Boolean(_loc7_.bitmapData))
               {
                  _loc4_ = new Bitmap(_loc7_.bitmapData.clone());
               }
               else
               {
                  _loc4_ = new Bitmap();
               }
               param3(param1,_loc4_);
               return;
            }
            if(this.FacebookUserImg.ContainsKey(param1))
            {
               _loc8_ = this.FacebookUserImg.Get(param1);
               if(_loc8_)
               {
                  _loc4_ = new Bitmap(_loc8_.bitmapData.clone());
               }
               else
               {
                  _loc4_ = new Bitmap();
               }
               param3(param1,_loc4_);
               return;
            }
         }
         var _loc5_:Object = {
            "UserId":param1,
            "Callback":param3
         };
         var _loc6_:ImageLoader = new ImageLoader();
         _loc6_.LoadImage(param2,_loc5_,this.GetFacebookUserImgCallback,GameKernel.ForRenRen == 1);
      }
      
      private function GetFacebookUserImgCallback(param1:Object, param2:Object) : void
      {
         var _loc3_:Bitmap = null;
         if(GameKernel.ForRenRen == 1)
         {
            if(param2 != null)
            {
               this.FacebookUserImg.Put(param1.UserId,param2);
            }
            if(param1.Callback != null)
            {
               param1.Callback(param1.UserId,param2);
            }
         }
         else
         {
            _loc3_ = null;
            if(param2 != null)
            {
               this.FacebookUserImg.Put(param1.UserId,param2);
               _loc3_ = new Bitmap(Bitmap(param2).bitmapData.clone());
            }
            if(param1.Callback != null)
            {
               param1.Callback(param1.UserId,_loc3_);
            }
         }
         if(param1.UserId == FaceBookUI.getInstance().currentUserId)
         {
            PlayerInfoUI.getInstance().bindFriendImage(param1.UserId);
         }
         param1 = null;
      }
   }
}

