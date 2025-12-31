package com.star.frameworks.facebook
{
   import com.facebook.events.FacebookEvent;
   import com.facebook.facebook_internal;
   
   use namespace facebook_internal;
   
   public class FacebookClient_GetUserInfoCallback
   {
      
      public var GetUserInfoCallback:Function;
      
      public function FacebookClient_GetUserInfoCallback()
      {
         super();
      }
      
      public function OnGetUserInfoByUserId(param1:FacebookEvent) : void
      {
         var _loc3_:XML = null;
         var _loc4_:FacebookUserInfo = null;
         var _loc5_:XML = null;
         if(param1.success)
         {
            _loc3_ = new XML(param1.data.rawResult);
            _loc4_ = new FacebookUserInfo();
            var _loc6_:int = 0;
            var _loc7_:* = _loc3_.user;
            for each(_loc5_ in _loc7_)
            {
               _loc4_.uid = _loc5_.uid;
               _loc4_.name = _loc5_.name;
               _loc4_.first_name = _loc5_.first_name;
               _loc4_.SetSex(_loc5_.sex);
               _loc4_.pic_square = _loc5_.pic_square;
               _loc4_.locale = _loc5_.locale;
               _loc4_.current_location = _loc5_.current_location;
               _loc4_.birthday = _loc5_.birthday;
            }
            this.CallbackOnGetUserInfoByUserId(_loc4_);
         }
         else
         {
            this.CallbackOnGetUserInfoByUserId(null);
         }
      }
      
      private function CallbackOnGetUserInfoByUserId(param1:FacebookUserInfo) : void
      {
         if(this.GetUserInfoCallback != null)
         {
            this.GetUserInfoCallback(param1);
         }
      }
   }
}

