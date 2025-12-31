package com.star.frameworks.facebook
{
   public class FacebookUserInfo
   {
      
      public var uid:Number;
      
      public var level:int;
      
      public var serverId:int;
      
      public var name:String;
      
      public var _first_name:String;
      
      public var sex:Boolean;
      
      public var pic_square:String;
      
      public var pic:String;
      
      public var locale:String;
      
      public var current_location:String;
      
      private var _profile_url:String;
      
      public var sexWord:String;
      
      public var birthday:String;
      
      public var FacebookName:String;
      
      public function FacebookUserInfo()
      {
         super();
      }
      
      public function SetSex(param1:String) : void
      {
         this.sexWord = param1;
         if(param1 == "男" || param1 == "male" || param1 == "男性")
         {
            this.sex = true;
         }
         else
         {
            this.sex = false;
         }
      }
      
      public function get profile_url() : String
      {
         return "http://www.facebook.com/profile.php?id=" + this.uid;
      }
      
      public function set first_name(param1:String) : void
      {
         this.FacebookName = param1;
         this._first_name = param1;
      }
      
      public function get first_name() : String
      {
         return this._first_name;
      }
      
      public function set DefaultName(param1:String) : void
      {
         this._first_name = param1;
      }
   }
}

