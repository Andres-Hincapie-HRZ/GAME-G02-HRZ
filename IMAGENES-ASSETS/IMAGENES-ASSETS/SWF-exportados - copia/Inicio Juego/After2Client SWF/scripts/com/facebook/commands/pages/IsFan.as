package com.facebook.commands.pages
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   
   use namespace facebook_internal;
   
   public class IsFan extends FacebookCall
   {
      
      public static const METHOD_NAME:String = "pages.isFan";
      
      public static const SCHEMA:Array = ["page_id","uid"];
      
      public var uid:String;
      
      public var page_id:String;
      
      public function IsFan(param1:String = null, param2:String = null)
      {
         super(METHOD_NAME);
         this.page_id = param1;
         this.uid = param2;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,this.page_id,this.uid);
         super.facebook_internal::initialize();
      }
   }
}

