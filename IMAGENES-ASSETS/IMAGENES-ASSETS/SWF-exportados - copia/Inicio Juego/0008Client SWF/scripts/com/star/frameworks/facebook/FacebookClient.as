package com.star.frameworks.facebook
{
   import com.adobe.serialization.json.JSON;
   import com.facebook.Facebook;
   import com.facebook.commands.fql.FqlQuery;
   import com.facebook.commands.friends.GetAppUsers;
   import com.facebook.commands.pages.GetPageInfo;
   import com.facebook.commands.pages.IsFan;
   import com.facebook.commands.photos.UploadPhoto;
   import com.facebook.commands.users.GetInfo;
   import com.facebook.commands.users.HasAppPermission;
   import com.facebook.data.BooleanResultData;
   import com.facebook.data.auth.ExtendedPermissionValues;
   import com.facebook.data.friends.GetAppUserData;
   import com.facebook.data.photos.FacebookPhoto;
   import com.facebook.data.users.FacebookUser;
   import com.facebook.data.users.GetInfoData;
   import com.facebook.events.FacebookEvent;
   import com.facebook.facebook_internal;
   import com.facebook.session.WebSession;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.external.ExternalInterface;
   import flash.utils.Timer;
   import logic.game.GameKernel;
   
   use namespace facebook_internal;
   
   public class FacebookClient
   {
      
      private static var _Instance:FacebookClient = null;
      
      private var fbook:Facebook;
      
      private var _friendsInfo:Array;
      
      private var _FacebookFriendsInfo:Array;
      
      private var _SelfInfo:FacebookUserInfo;
      
      private var OnGetAppFriends:Function = null;
      
      private var OnPublishStream:Function = null;
      
      private var OnUploadPicture:Function = null;
      
      private var OnHasUploadPhotoPermission:Function = null;
      
      private var OnSendAppNotification:Function = null;
      
      private var OnGetFacebookFriends:Function = null;
      
      private var OnGetFacebookFriend:Function = null;
      
      private var OnGetLoginUserInfo:Function = null;
      
      private var OnGetUserInfoByUserId:Function = null;
      
      private var OnGetUserInfoByUserIds:Function = null;
      
      private var OnBecomeFan:Function = null;
      
      private var OnGetFanCount:Function = null;
      
      private var PublishStreamContent:String;
      
      private var PublishAttachment:Object;
      
      private var InitStatus:int;
      
      private var _Uid:String;
      
      private var HasSetCallback:Boolean = false;
      
      private var _TargetFriendId:Number;
      
      private var _PublishWithJS:Boolean;
      
      private var _ByPHP:Boolean;
      
      private var IsFanTimerId:uint;
      
      private var _Delay:int = 4000;
      
      private var PageId:String = "122712664409003";
      
      private var IsFanTimer:Timer;
      
      private var _name:String;
      
      private var _caption:String;
      
      private var _description:String;
      
      private var _StreamContent:String;
      
      private var _PicUrl:String;
      
      private var _link:String;
      
      private var _PublishStream3:Boolean = false;
      
      private var _UserId:Number;
      
      private var _UserIdString:String;
      
      public function FacebookClient()
      {
         super();
         this._PublishWithJS = false;
         this._ByPHP = false;
      }
      
      public static function GetSelfInfo() : FacebookUserInfo
      {
         return _Instance._SelfInfo;
      }
      
      public static function Init(param1:String, param2:String, param3:String, param4:String = null, param5:String = "") : int
      {
         return GetInstance()._Init(param1,param2,param3,param4,param5);
      }
      
      public static function PublishStream(param1:String, param2:Function = null, param3:Boolean = false) : void
      {
         GetInstance().PublishStream2(param1,null,0,param2,param3);
      }
      
      public static function PublishStreamWithImage(param1:String, param2:Object = null, param3:Function = null, param4:Boolean = false) : void
      {
         GetInstance().PublishStream2(param1,param2,0,param3,param4);
      }
      
      public static function PublishStreamToFriend(param1:String, param2:Number, param3:Object = null, param4:Function = null, param5:Boolean = false) : void
      {
         GetInstance().PublishStream2(param1,param3,param2,param4,param5);
      }
      
      public static function PublishStream3(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String, param7:Function = null) : void
      {
         GetInstance().PublishStream3(param1,param2,param3,param4,param5,param6,param7);
      }
      
      public static function CallPublishPermission() : void
      {
         ExternalInterface.call("Publish");
      }
      
      public static function GetFacebookFriend(param1:Function, param2:Number) : void
      {
         GetInstance()._GetFacebookFriend(param1,param2);
      }
      
      public static function GetFacebookFriends(param1:Function, param2:int = 1) : void
      {
         GetInstance()._GetFacebookFriends(param1,param2);
      }
      
      public static function GetAppFriends(param1:Function) : void
      {
         GetInstance()._GetAppFriends(param1);
      }
      
      public static function GetLoginUserInfo(param1:Function) : void
      {
         GetInstance()._GetSelfInfo(param1);
      }
      
      public static function HasUploadPhotoPermission(param1:Function) : void
      {
         GetInstance()._HasUploadPhotoPermission(param1);
      }
      
      public static function UploadPicture(param1:BitmapData, param2:String, param3:Function) : void
      {
         GetInstance()._UploadPicture(param1,param2,param3);
      }
      
      public static function GetUserInfoByUserIdSyan(param1:Function, param2:Number) : void
      {
         GetInstance()._GetUserInfoByUserId(param1,param2);
      }
      
      public static function GetUserInfoByUserId(param1:Function, param2:Number) : void
      {
         GetInstance()._GetUserInfoByUserId(param1,param2);
      }
      
      public static function GetUserInfoByUserIdsSyan(param1:Function, param2:Array) : void
      {
         GetInstance()._GetUserInfoByUserIdsSyan(param1,param2);
      }
      
      public static function GetUserInfoByUserIds(param1:Function, param2:Array) : void
      {
         GetInstance()._GetUserInfoByUserIds(param1,param2);
      }
      
      public static function get friendsInfo() : Array
      {
         return GetInstance()._friendsInfo;
      }
      
      public static function get facebookFriendsInfo() : Array
      {
         return GetInstance()._FacebookFriendsInfo;
      }
      
      private static function GetInstance() : FacebookClient
      {
         if(_Instance == null)
         {
            _Instance = new FacebookClient();
         }
         return _Instance;
      }
      
      public static function SetBookmark() : void
      {
         ExternalInterface.call("showBookmarkDialog");
      }
      
      public static function BecomeFan(param1:Function) : void
      {
         GetInstance()._BecomeFan(param1);
      }
      
      public static function GetFanCount(param1:Function) : void
      {
         GetInstance()._GetFanCount(param1);
      }
      
      private function setupCallBacks() : void
      {
         if(this.HasSetCallback)
         {
            return;
         }
         if(ExternalInterface.available)
         {
            try
            {
               ExternalInterface.addCallback("showPermissionDialogBack",GetInstance().showPermissionDialogBack);
               ExternalInterface.addCallback("PublishBack",GetInstance().PublishBack);
               ExternalInterface.addCallback("JSCallback_GetUserInfoByUserId",GetInstance().JSCallback_GetUserInfoByUserId);
               ExternalInterface.addCallback("JSCallback_getPlayerFacebookInfoArray",GetInstance().JSCallback_getPlayerFacebookInfoArray);
               this.HasSetCallback = true;
            }
            catch(error:SecurityError)
            {
               InitStatus = 1;
               return;
            }
            catch(error:Error)
            {
               InitStatus = 2;
               return;
            }
            return;
         }
         this.InitStatus = 3;
      }
      
      private function _Init(param1:String, param2:String, param3:String, param4:String, param5:String) : int
      {
         this._Uid = param4;
         if(param5 != null && param5 != "")
         {
            this._ByPHP = true;
            this.GetFrientsInfo(param5);
         }
         this.InitStatus = 0;
         this.fbook = new Facebook();
         this.fbook.startSession(new WebSession(param1,param2,param3));
         if(param1 == null || param1 == "" || param2 == null || param2 == "" || param3 == "" || param3 == null)
         {
            this.InitStatus = 4;
            return this.InitStatus;
         }
         return this.InitStatus;
      }
      
      private function GetFrientsInfo(param1:String) : void
      {
         var json:Object = null;
         var k:int = 0;
         var j:int = 0;
         var i:int = 0;
         var aUser:FacebookUserInfo = null;
         var t:int = 0;
         var friendString:String = param1;
         try
         {
            this._friendsInfo = new Array();
            this._FacebookFriendsInfo = new Array();
            this._SelfInfo = null;
            json = com.adobe.serialization.json.JSON.decode(friendString);
            k = 0;
            j = 1;
            if(json[1].name == "friendsInfo" || json[1].name == "query1")
            {
               k = 1;
               j = 0;
            }
            i = 0;
            while(i < json[k].fql_result_set.length)
            {
               aUser = new FacebookUserInfo();
               aUser.uid = Number(json[k].fql_result_set[i].uid);
               aUser.name = json[k].fql_result_set[i].name;
               aUser.first_name = json[k].fql_result_set[i].first_name;
               aUser.SetSex(json[k].fql_result_set[i].sex);
               aUser.pic_square = json[k].fql_result_set[i].pic_square;
               aUser.locale = json[k].fql_result_set[i].locale;
               if(json[k].fql_result_set[i].current_location != null && json[k].fql_result_set[i].current_location.city != null)
               {
                  aUser.current_location = json[k].fql_result_set[i].current_location.city;
               }
               aUser.birthday = json[k].fql_result_set[i].birthday;
               if(json[k].fql_result_set[i].uid == this._Uid)
               {
                  this._SelfInfo = aUser;
               }
               else
               {
                  t = 0;
                  while(t < json[j].fql_result_set.length)
                  {
                     if(json[k].fql_result_set[i].uid == json[j].fql_result_set[t].uid)
                     {
                        this._friendsInfo.push(aUser);
                     }
                     t++;
                  }
                  this._FacebookFriendsInfo.push(aUser);
               }
               i++;
            }
         }
         catch(e:Error)
         {
            _friendsInfo = null;
            _FacebookFriendsInfo = null;
            _SelfInfo = null;
         }
      }
      
      private function PublishStream3(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String, param7:Function) : void
      {
         var name:String = param1;
         var caption:String = param2;
         var description:String = param3;
         var StreamContent:String = param4;
         var PicUrl:String = param5;
         var link:String = param6;
         var Callback:Function = param7;
         this._name = name;
         this._caption = caption;
         this._description = description;
         this._StreamContent = StreamContent;
         this._PicUrl = PicUrl;
         this._link = link;
         this.OnPublishStream = Callback;
         try
         {
            this.setupCallBacks();
            ExternalInterface.call("publishFeedDialog_Js",StreamContent,PicUrl,name,caption,description,link);
         }
         catch(e:*)
         {
         }
      }
      
      private function PublishStream2(param1:String, param2:Object, param3:Number, param4:Function, param5:Boolean) : void
      {
         this._PublishWithJS = param5;
         this.PublishStream(param1,param2,param3,param4);
      }
      
      private function PublishStream(param1:String, param2:Object, param3:Number, param4:Function) : void
      {
         this.PublishAttachment = param2;
         this.PublishStreamContent = param1;
         this._TargetFriendId = param3;
         this.OnPublishStream = param4;
         if(this.InitStatus != 0)
         {
            this.CallbackOnPublishStream(false);
            return;
         }
         var _loc5_:HasAppPermission = new HasAppPermission(ExtendedPermissionValues.PUBLISH_STREAM,this._Uid);
         _loc5_.addEventListener(FacebookEvent.COMPLETE,this.onPermissionCheck_PublicStream);
         this.fbook.post(_loc5_);
      }
      
      private function onPermissionCheck_PublicStream(param1:FacebookEvent) : void
      {
      }
      
      private function publishPost() : void
      {
         if(this._PublishStream3)
         {
            GetInstance().PublishStream3(this._name,this._caption,this._description,this._StreamContent,this._PicUrl,this._link,this.OnPublishStream);
         }
      }
      
      private function onPublish(param1:FacebookEvent) : void
      {
         if(param1.success)
         {
            this.CallbackOnPublishStream(true);
         }
         else
         {
            this.CallbackOnPublishStream(false);
         }
      }
      
      private function PublishBack(param1:String) : void
      {
         if(param1 == "0")
         {
            this.CallbackOnPublishStream(true);
         }
         else
         {
            this._PublishStream3 = true;
            this.CallbackOnPublishStream(false);
         }
      }
      
      private function showPermissionDialogBack(param1:String) : void
      {
         if(param1 == "publish_stream")
         {
            this.publishPost();
         }
         else if(param1 == ExtendedPermissionValues.PHOTO_UPLOAD)
         {
            this.CallbackOnHasUploadPhotoPermission(true);
         }
         else
         {
            this.CallbackOnHasUploadPhotoPermission(false);
            this.CallbackOnPublishStream(false);
         }
      }
      
      private function CallbackOnPublishStream(param1:Boolean) : void
      {
         if(this.OnPublishStream != null)
         {
            this.OnPublishStream(param1);
         }
         this.OnPublishStream = null;
      }
      
      private function _GetFacebookFriend(param1:Function, param2:Number) : void
      {
         var _loc3_:FqlQuery = null;
         this.OnGetFacebookFriend = param1;
         if(this.InitStatus != 0)
         {
            this.CallbackOnGetFacebookFriend(null);
            return;
         }
         _loc3_ = new FqlQuery("SELECT uid,name,first_name,sex,pic_square,locale,current_location,birthday FROM user WHERE uid =" + param2.toString());
         _loc3_.addEventListener(FacebookEvent.COMPLETE,this.onGetFacebookUser);
         this.fbook.post(_loc3_);
      }
      
      private function onGetFacebookUser(param1:FacebookEvent) : void
      {
         var _loc3_:XML = null;
         var _loc4_:int = 0;
         var _loc5_:FacebookUserInfo = null;
         var _loc6_:XML = null;
         if(param1.success)
         {
            _loc3_ = new XML(param1.data.rawResult);
            this._FacebookFriendsInfo = new Array();
            _loc4_ = 0;
            _loc5_ = new FacebookUserInfo();
            var _loc7_:int = 0;
            var _loc8_:* = _loc3_.user;
            for each(_loc6_ in _loc8_)
            {
               _loc5_.uid = _loc6_.uid;
               _loc5_.name = _loc6_.name;
               _loc5_.first_name = _loc6_.first_name;
               _loc5_.SetSex(_loc6_.sex);
               _loc5_.pic_square = _loc6_.pic_square;
               _loc5_.locale = _loc6_.locale;
               if(_loc6_.current_location != null && _loc6_.current_location.city != null)
               {
                  _loc5_.current_location = _loc6_.current_location.city;
               }
               _loc5_.birthday = _loc6_.birthday;
            }
            this.CallbackOnGetFacebookFriend(_loc5_);
         }
         else
         {
            this.CallbackOnGetFacebookFriend(null);
         }
      }
      
      private function CallbackOnGetFacebookFriend(param1:FacebookUserInfo) : void
      {
         if(this.OnGetFacebookFriend != null)
         {
            this.OnGetFacebookFriend(param1);
         }
         this.OnGetFacebookFriend = null;
      }
      
      private function _GetFacebookFriends(param1:Function, param2:int) : void
      {
         var _loc3_:FqlQuery = null;
         this.OnGetFacebookFriends = param1;
         if(this.InitStatus != 0)
         {
            this.CallbackOnGetFacebookFriends(false);
            return;
         }
         if(param2 <= 0)
         {
            _loc3_ = new FqlQuery("SELECT uid,name,first_name,sex,pic_square,locale,current_location,birthday FROM user WHERE uid IN (SELECT uid2 FROM friend WHERE uid1=" + this._Uid + " ) AND is_app_user = 0");
         }
         else
         {
            _loc3_ = new FqlQuery("SELECT uid,name,first_name,sex,pic_square,locale,current_location,birthday FROM user WHERE uid IN (SELECT uid2 FROM friend WHERE uid1=" + this._Uid + " ORDER BY rand() LIMIT " + param2.toString() + " ) AND is_app_user = 0");
         }
         _loc3_.addEventListener(FacebookEvent.COMPLETE,this.onGetFacebookUsers);
         this.fbook.post(_loc3_);
      }
      
      private function onGetFacebookUsers(param1:FacebookEvent) : void
      {
         var _loc3_:XML = null;
         var _loc4_:int = 0;
         var _loc5_:XML = null;
         if(param1.success)
         {
            _loc3_ = new XML(param1.data.rawResult);
            this._FacebookFriendsInfo = new Array();
            _loc4_ = 0;
            for each(_loc5_ in _loc3_.user)
            {
               this._FacebookFriendsInfo[_loc4_] = new FacebookUserInfo();
               this._FacebookFriendsInfo[_loc4_].uid = _loc5_.uid;
               this._FacebookFriendsInfo[_loc4_].name = _loc5_.name;
               this._FacebookFriendsInfo[_loc4_].first_name = _loc5_.first_name;
               this._FacebookFriendsInfo[_loc4_].SetSex(_loc5_.sex);
               this._FacebookFriendsInfo[_loc4_].pic_square = _loc5_.pic_square;
               this._FacebookFriendsInfo[_loc4_].locale = _loc5_.locale;
               if(_loc5_.current_location != null && _loc5_.current_location.city != null)
               {
                  this._FacebookFriendsInfo[_loc4_].current_location = _loc5_.current_location.city;
               }
               this._FacebookFriendsInfo[_loc4_].birthday = _loc5_.birthday;
               _loc4_++;
            }
            this.CallbackOnGetFacebookFriends(true);
         }
         else
         {
            this.CallbackOnGetFacebookFriends(false);
         }
      }
      
      private function CallbackOnGetFacebookFriends(param1:Boolean) : void
      {
         if(this.OnGetFacebookFriends != null)
         {
            this.OnGetFacebookFriends(param1);
         }
         this.OnGetFacebookFriends = null;
      }
      
      private function _GetAppFriends(param1:Function) : void
      {
         this.OnGetAppFriends = param1;
         if(this._ByPHP)
         {
            this.CallbackOnGetAppFriends(this._friendsInfo != null);
            return;
         }
         if(this.InitStatus != 0)
         {
            this.CallbackOnGetAppFriends(false);
            return;
         }
         var _loc2_:GetAppUsers = new GetAppUsers();
         _loc2_.addEventListener(FacebookEvent.COMPLETE,this.onGetAppUsers);
         this.fbook.post(_loc2_);
      }
      
      private function onGetAppUsers(param1:FacebookEvent) : void
      {
         var _loc2_:GetAppUserData = null;
         if(param1.success)
         {
            _loc2_ = param1.data as GetAppUserData;
            if(_loc2_.uids != null && _loc2_.uids.length > 0)
            {
               this.GetUserInfo(_loc2_.uids);
            }
            else
            {
               this._friendsInfo = new Array();
               this.CallbackOnGetAppFriends(true);
            }
         }
         else
         {
            this.CallbackOnGetAppFriends(false);
         }
      }
      
      private function GetUserInfo(param1:Array) : void
      {
         var _loc2_:Array = new Array();
         _loc2_[0] = "uid";
         _loc2_[1] = "name";
         _loc2_[2] = "first_name";
         _loc2_[3] = "sex";
         _loc2_[4] = "pic_square";
         _loc2_[5] = "pic";
         _loc2_[6] = "locale";
         _loc2_[7] = "current_location";
         _loc2_[8] = "birthday";
         var _loc3_:GetInfo = new GetInfo(param1,_loc2_);
         _loc3_.addEventListener(FacebookEvent.COMPLETE,this.onGetUserInfo);
         this.fbook.post(_loc3_);
      }
      
      private function onGetUserInfo(param1:FacebookEvent) : void
      {
         var _loc2_:GetInfoData = null;
         var _loc3_:uint = 0;
         var _loc4_:FacebookUser = null;
         if(param1.success)
         {
            _loc2_ = param1.data as GetInfoData;
            this._friendsInfo = new Array();
            _loc3_ = 0;
            while(_loc3_ < _loc2_.userCollection.length)
            {
               _loc4_ = _loc2_.userCollection.getItemAt(_loc3_) as FacebookUser;
               this._friendsInfo[_loc3_] = new FacebookUserInfo();
               this._friendsInfo[_loc3_].uid = _loc4_.uid;
               this._friendsInfo[_loc3_].name = _loc4_.name;
               this._friendsInfo[_loc3_].first_name = _loc4_.first_name;
               this._friendsInfo[_loc3_].SetSex(_loc4_.sex);
               this._friendsInfo[_loc3_].pic_square = _loc4_.pic_square;
               this._friendsInfo[_loc3_].pic = _loc4_.pic;
               this._friendsInfo[_loc3_].locale = _loc4_.locale;
               this._friendsInfo[_loc3_].current_location = _loc4_.current_location.city;
               this._friendsInfo[_loc3_].birthday = _loc4_.birthday;
               _loc3_++;
            }
            this.CallbackOnGetAppFriends(true);
         }
         else
         {
            this.CallbackOnGetAppFriends(false);
         }
      }
      
      private function CallbackOnGetAppFriends(param1:Boolean) : void
      {
         if(this.OnGetAppFriends != null)
         {
            this.OnGetAppFriends(param1);
         }
         this.OnGetAppFriends = null;
      }
      
      private function _GetSelfInfo(param1:Function) : void
      {
         this.OnGetLoginUserInfo = param1;
         if(this._ByPHP)
         {
            this.CallbackOnGetLoginUserInfo(this._SelfInfo);
            return;
         }
         if(this.InitStatus != 0)
         {
            this.CallbackOnGetLoginUserInfo(null);
            return;
         }
         var _loc2_:Array = new Array();
         _loc2_.push(this._Uid);
         var _loc3_:Array = new Array();
         _loc3_[0] = "uid";
         _loc3_[1] = "name";
         _loc3_[2] = "first_name";
         _loc3_[3] = "sex";
         _loc3_[4] = "pic_square";
         _loc3_[5] = "pic";
         _loc3_[6] = "locale";
         _loc3_[7] = "current_location";
         _loc3_[8] = "birthday";
         var _loc4_:GetInfo = new GetInfo(_loc2_,_loc3_);
         _loc4_.addEventListener(FacebookEvent.COMPLETE,this._OnGetLoginUserInfo);
         this.fbook.post(_loc4_);
      }
      
      private function _OnGetLoginUserInfo(param1:FacebookEvent) : void
      {
         var _loc2_:GetInfoData = null;
         var _loc3_:FacebookUserInfo = null;
         var _loc4_:FacebookUser = null;
         if(param1.success)
         {
            _loc2_ = param1.data as GetInfoData;
            if(_loc2_.userCollection.length <= 0)
            {
               this.CallbackOnGetLoginUserInfo(null);
               return;
            }
            _loc3_ = new FacebookUserInfo();
            _loc4_ = _loc2_.userCollection.getItemAt(0) as FacebookUser;
            _loc3_.uid = Number(_loc4_.uid);
            _loc3_.name = _loc4_.name;
            _loc3_.first_name = _loc4_.first_name;
            _loc3_.SetSex(_loc4_.sex);
            _loc3_.pic_square = _loc4_.pic_square;
            _loc3_.pic = _loc4_.pic;
            _loc3_.locale = _loc4_.locale;
            _loc3_.current_location = _loc4_.current_location.city;
            _loc3_.birthday = _loc4_.birthday;
            this.CallbackOnGetLoginUserInfo(_loc3_);
         }
         else
         {
            this.CallbackOnGetLoginUserInfo(null);
         }
      }
      
      private function CallbackOnGetLoginUserInfo(param1:FacebookUserInfo) : void
      {
         if(this.OnGetLoginUserInfo != null)
         {
            this.OnGetLoginUserInfo(param1);
         }
         this.OnGetLoginUserInfo = null;
      }
      
      private function _HasUploadPhotoPermission(param1:Function) : void
      {
         this.OnHasUploadPhotoPermission = param1;
         if(this.InitStatus != 0)
         {
            this.CallbackOnHasUploadPhotoPermission(false);
            return;
         }
         var _loc2_:HasAppPermission = new HasAppPermission(ExtendedPermissionValues.PHOTO_UPLOAD,this.fbook.uid);
         _loc2_.addEventListener(FacebookEvent.COMPLETE,this.onPermissionCheck_PhotoUpload);
         this.fbook.post(_loc2_);
      }
      
      private function onPermissionCheck_PhotoUpload(param1:FacebookEvent) : void
      {
         if(param1.success && (param1.data as BooleanResultData).value)
         {
            this.CallbackOnHasUploadPhotoPermission(true);
         }
         else
         {
            this.setupCallBacks();
            if(ExternalInterface.available)
            {
               ExternalInterface.call("showPermissionDialog",ExtendedPermissionValues.PHOTO_UPLOAD);
            }
            else
            {
               this.CallbackOnHasUploadPhotoPermission(false);
            }
         }
      }
      
      private function CallbackOnHasUploadPhotoPermission(param1:Boolean) : void
      {
         if(this.OnHasUploadPhotoPermission != null)
         {
            this.OnHasUploadPhotoPermission(param1);
         }
         this.OnHasUploadPhotoPermission = null;
      }
      
      private function _UploadPicture(param1:BitmapData, param2:String, param3:Function) : void
      {
         this.OnUploadPicture = param3;
         if(this.InitStatus != 0)
         {
            this.CallbackOnUploadPicture(null);
            return;
         }
         this.UploadPhotoPost(param1,param2);
      }
      
      private function UploadPhotoPost(param1:BitmapData, param2:String = null) : void
      {
         var _loc3_:UploadPhoto = new UploadPhoto(param1,null,param2);
         _loc3_.addEventListener(FacebookEvent.COMPLETE,this.OnUploadPhotoPost);
         this.fbook.post(_loc3_);
      }
      
      private function OnUploadPhotoPost(param1:FacebookEvent) : void
      {
         var _loc2_:PhotoUrl = null;
         var _loc3_:FacebookPhoto = null;
         if(param1.success)
         {
            _loc2_ = new PhotoUrl();
            _loc3_ = param1.data as FacebookPhoto;
            _loc2_.src = _loc3_.src;
            _loc2_.src_big = _loc3_.src_big;
            _loc2_.src_small = _loc3_.src_small;
            _loc2_.link = _loc3_.link;
            this.CallbackOnUploadPicture(_loc2_);
         }
         else
         {
            this.CallbackOnUploadPicture(null);
         }
      }
      
      private function CallbackOnUploadPicture(param1:PhotoUrl) : void
      {
         if(this.OnUploadPicture != null)
         {
            this.OnUploadPicture(param1);
         }
         this.OnUploadPicture = null;
      }
      
      private function _GetUserInfoByUserIdSyan(param1:Function, param2:Number) : void
      {
         var _loc4_:FqlQuery = null;
         var _loc3_:FacebookClient_GetUserInfoCallback = new FacebookClient_GetUserInfoCallback();
         _loc3_.GetUserInfoCallback = param1;
         if(this.InitStatus != 0)
         {
            this.CallbackOnGetUserInfoByUserId(null);
            return;
         }
         _loc4_ = new FqlQuery("SELECT uid,name,first_name,sex,pic_square,locale,current_location,birthday FROM user WHERE uid =" + param2);
         _loc4_.addEventListener(FacebookEvent.COMPLETE,_loc3_.OnGetUserInfoByUserId);
         this.fbook.post(_loc4_);
      }
      
      private function _GetUserInfoByUserId(param1:Function, param2:Number) : void
      {
         var _loc3_:FqlQuery = null;
         this._UserId = param2;
         this.OnGetUserInfoByUserId = param1;
         if(GameKernel.ForJS == 1)
         {
            this.GetUserInfoByUserId_JS();
         }
         else
         {
            if(this.InitStatus != 0)
            {
               this.CallbackOnGetUserInfoByUserId(null);
               return;
            }
            _loc3_ = new FqlQuery("SELECT uid,name,first_name,sex,pic_square,locale,current_location,birthday FROM user WHERE uid =" + param2);
            _loc3_.addEventListener(FacebookEvent.COMPLETE,this._OnGetUserInfoByUserId);
            this.fbook.post(_loc3_);
         }
      }
      
      private function _OnGetUserInfoByUserId(param1:FacebookEvent) : void
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
               if(_loc5_.current_location != null && _loc5_.current_location.city != null)
               {
                  _loc4_.current_location = _loc5_.current_location.city;
               }
               _loc4_.birthday = _loc5_.birthday;
            }
            this.CallbackOnGetUserInfoByUserId(_loc4_);
         }
         else
         {
            this.GetUserInfoByUserId_JS();
         }
      }
      
      private function GetUserInfoByUserId_JS() : void
      {
         if(ExternalInterface.available)
         {
            this.setupCallBacks();
            ExternalInterface.call("GetUserInfoByUserId",this._UserId);
         }
         else
         {
            this.CallbackOnGetUserInfoByUserId(null);
         }
      }
      
      private function JSCallback_GetUserInfoByUserId(param1:String) : void
      {
         var _loc3_:FacebookUserInfo = null;
         if(param1 == null || param1 == "")
         {
            return;
         }
         var _loc2_:Object = com.adobe.serialization.json.JSON.decode(param1);
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.length > 0)
         {
            _loc3_ = new FacebookUserInfo();
            _loc3_.uid = Number(_loc2_[0].uid);
            _loc3_.first_name = _loc2_[0].first_name;
            _loc3_.pic_square = _loc2_[0].pic_square;
            _loc3_.locale = _loc2_[0].locale;
            _loc3_.SetSex(_loc2_[0].sex);
            this.CallbackOnGetUserInfoByUserId(_loc3_);
         }
      }
      
      private function JSCallback_getPlayerFacebookInfoArray(param1:String) : void
      {
         if(param1 == null || param1 == "")
         {
            return;
         }
         var _loc2_:Object = com.adobe.serialization.json.JSON.decode(param1);
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:Array = new Array();
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_[_loc4_] = new FacebookUserInfo();
            _loc3_[_loc4_].uid = Number(_loc2_[_loc4_].uid);
            _loc3_[_loc4_].first_name = _loc2_[_loc4_].first_name;
            _loc3_[_loc4_].pic_square = _loc2_[_loc4_].pic_square;
            _loc3_[_loc4_].locale = _loc2_[_loc4_].locale;
            _loc3_[_loc4_].SetSex(_loc2_[_loc4_].sex);
            _loc4_++;
         }
         this.CallbackOnGetUserInfoByUserIds(_loc3_);
      }
      
      private function CallbackOnGetUserInfoByUserId(param1:FacebookUserInfo) : void
      {
         var _loc2_:Function = null;
         if(this.OnGetUserInfoByUserId != null)
         {
            _loc2_ = this.OnGetUserInfoByUserId;
            this.OnGetUserInfoByUserId = null;
            _loc2_(param1);
         }
      }
      
      private function _GetUserInfoByUserIdsSyan(param1:Function, param2:Array) : void
      {
         var _loc5_:FqlQuery = null;
         var _loc3_:FacebookClient_GetUserInfosCallback = new FacebookClient_GetUserInfosCallback();
         _loc3_.GetUserInfosCallback = param1;
         if(this.InitStatus != 0)
         {
            this.CallbackOnGetUserInfoByUserIds(null);
            return;
         }
         var _loc4_:String = param2.join(",");
         _loc5_ = new FqlQuery("SELECT uid,name,first_name,sex,pic_square,locale,current_location,birthday FROM user WHERE uid in (" + _loc4_ + ")");
         _loc5_.addEventListener(FacebookEvent.COMPLETE,_loc3_.GetUserInfoByUserIdsCallback);
         this.fbook.post(_loc5_);
      }
      
      private function _GetUserInfoByUserIds(param1:Function, param2:Array) : void
      {
         var _loc3_:FqlQuery = null;
         this.OnGetUserInfoByUserIds = param1;
         this._UserIdString = param2.join(",");
         if(GameKernel.ForJS == 1)
         {
            this.GetUserInfoByUserIds_JS();
         }
         else
         {
            if(this.InitStatus != 0)
            {
               this.CallbackOnGetUserInfoByUserIds(null);
               return;
            }
            _loc3_ = new FqlQuery("SELECT uid,name,first_name,sex,pic_square,locale,current_location,birthday FROM user WHERE uid in (" + this._UserIdString + ")");
            _loc3_.addEventListener(FacebookEvent.COMPLETE,this._OnGetUserInfoByUserIds);
            this.fbook.post(_loc3_);
         }
      }
      
      private function _OnGetUserInfoByUserIds(param1:FacebookEvent) : void
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
               if(_loc6_.current_location != null && _loc6_.current_location.city != null)
               {
                  _loc3_[_loc5_].current_location = _loc6_.current_location.city;
               }
               _loc3_[_loc5_].birthday = _loc6_.birthday;
               _loc5_++;
            }
            this.CallbackOnGetUserInfoByUserIds(_loc3_);
         }
         else
         {
            this.GetUserInfoByUserIds_JS();
         }
      }
      
      private function GetUserInfoByUserIds_JS() : void
      {
         if(ExternalInterface.available)
         {
            this.setupCallBacks();
            ExternalInterface.call("getPlayerFacebookInfoArray",this._UserIdString);
         }
         else
         {
            this.CallbackOnGetUserInfoByUserIds(null);
         }
      }
      
      private function CallbackOnGetUserInfoByUserIds(param1:Array) : void
      {
         var _loc2_:Function = null;
         if(this.OnGetUserInfoByUserIds != null)
         {
            _loc2_ = this.OnGetUserInfoByUserIds;
            this.OnGetUserInfoByUserIds = null;
            _loc2_(param1);
         }
      }
      
      private function _BecomeFan(param1:Function) : void
      {
         this.OnBecomeFan = param1;
         if(this.InitStatus != 0)
         {
            this.CallbackOnBecomeFan(false);
            return;
         }
         this.StartTimer();
         ExternalInterface.call("becomeFan");
      }
      
      private function StartTimer() : void
      {
         if(this.IsFanTimer == null)
         {
            this.IsFanTimer = new Timer(this._Delay);
            this.IsFanTimer.addEventListener(TimerEvent.TIMER,this.timerHandler);
            this.IsFanTimer.start();
         }
      }
      
      private function timerHandler(param1:TimerEvent) : void
      {
         this.HasBecomeFan();
      }
      
      private function CallbackOnBecomeFan(param1:Boolean) : void
      {
         if(this.OnBecomeFan != null)
         {
            this.OnBecomeFan(param1);
         }
         this.OnBecomeFan = null;
      }
      
      private function HasBecomeFan() : void
      {
         var _loc1_:IsFan = new IsFan(this.PageId,this._Uid.toString());
         _loc1_.addEventListener(FacebookEvent.COMPLETE,this.OnIsFan);
         this.fbook.post(_loc1_);
      }
      
      private function OnIsFan(param1:FacebookEvent) : void
      {
         var _loc2_:BooleanResultData = null;
         if(param1.success)
         {
            _loc2_ = param1.data as BooleanResultData;
            if(_loc2_.value)
            {
               this.IsFanTimer.stop();
               this.CallbackOnBecomeFan(true);
            }
         }
         else
         {
            this.CallbackOnBecomeFan(false);
         }
      }
      
      private function _GetFanCount(param1:Function) : void
      {
         this.OnGetFanCount = param1;
         if(this.InitStatus != 0)
         {
            this.CallbackOnGetFanCount(0);
            return;
         }
         var _loc2_:Array = new Array();
         _loc2_[0] = "fan_count";
         var _loc3_:Array = new Array();
         _loc3_[0] = this.PageId;
         var _loc4_:GetPageInfo = new GetPageInfo(_loc2_,_loc3_,this._Uid.toString());
         _loc4_.addEventListener(FacebookEvent.COMPLETE,this.OnGetFanCountReturn);
         this.fbook.post(_loc4_);
      }
      
      private function OnGetFanCountReturn(param1:FacebookEvent) : void
      {
         var _loc3_:Array = null;
         var _loc4_:XML = null;
         var _loc5_:XML = null;
         if(param1.success)
         {
            _loc3_ = new Array();
            _loc4_ = new XML(param1.data.rawResult);
            var _loc6_:int = 0;
            var _loc7_:* = _loc4_.page;
            for each(_loc5_ in _loc7_)
            {
               this.CallbackOnGetFanCount(_loc5_.fan_count);
            }
         }
         else
         {
            this.CallbackOnGetFanCount(0);
         }
      }
      
      private function CallbackOnGetFanCount(param1:int) : void
      {
         if(this.OnGetFanCount != null)
         {
            this.OnGetFanCount(param1);
         }
         this.OnGetFanCount = null;
      }
   }
}

