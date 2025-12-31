package com.facebook.commands.pages
{
   import com.facebook.facebook_internal;
   import com.facebook.net.FacebookCall;
   import com.facebook.utils.FacebookDataUtils;
   
   use namespace facebook_internal;
   
   public class GetPageInfo extends FacebookCall
   {
      
      public static const METHOD_NAME:String = "pages.getInfo";
      
      public static const SCHEMA:Array = ["fields","page_ids","uid","type"];
      
      public var uid:String;
      
      public var page_ids:Array;
      
      public var fields:Array;
      
      public var type:String;
      
      public var pages:Array;
      
      public function GetPageInfo(param1:Array, param2:Array = null, param3:String = null, param4:String = null)
      {
         super(METHOD_NAME);
         this.fields = param1;
         this.page_ids = param2;
         this.uid = param3;
         this.type = param4;
      }
      
      override facebook_internal function initialize() : void
      {
         applySchema(SCHEMA,FacebookDataUtils.toArrayString(this.fields),FacebookDataUtils.toArrayString(this.page_ids),this.uid,this.type);
         super.facebook_internal::initialize();
      }
   }
}

