package com.star.frameworks.facebook
{
   import com.facebook.events.FacebookEvent;
   import com.facebook.facebook_internal;
   
   use namespace facebook_internal;
   
   public class FacebookClient_GetUserInfosCallback
   {
      
      public var GetUserInfosCallback:Function;
      
      public function FacebookClient_GetUserInfosCallback()
      {
         super();
      }
      
      public function GetUserInfoByUserIdsCallback(param1:FacebookEvent) : void
      {
         var _loc3_:Array = null;
         var _loc4_:XML = null;
         var _loc5_:int = 0;
         var _loc6_:XML = null;
         if(param1.success)
         {
            _loc3_ = new Array();
            _loc4_ = new XML(param1.data.rawResult);
            for each(_loc6_ in _loc4_.user)
            {
               _loc3_[_loc5_] = new FacebookUserInfo();
               _loc3_[_loc5_].uid = _loc6_.uid;
               _loc3_[_loc5_].name = _loc6_.name;
               _loc3_[_loc5_].first_name = _loc6_.first_name;
               _loc3_[_loc5_].SetSex(_loc6_.sex);
               _loc3_[_loc5_].pic_square = _loc6_.pic_square;
               _loc3_[_loc5_].locale = _loc6_.locale;
               _loc3_[_loc5_].current_location = _loc6_.current_location;
               _loc5_++;
            }
            this.CallbackOnGetUserInfoByUserIds(_loc3_);
         }
         else
         {
            this.CallbackOnGetUserInfoByUserIds(null);
         }
      }
      
      private function CallbackOnGetUserInfoByUserIds(param1:Array) : void
      {
         if(this.GetUserInfosCallback != null)
         {
            this.GetUserInfosCallback(param1);
         }
      }
   }
}

