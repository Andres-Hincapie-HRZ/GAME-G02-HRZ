package com.star.frameworks.utils
{
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class ResourceHandler extends URLLoader
   {
      
      public static var musicSet:Array = new Array();
      
      private var resPath:String;
      
      public var resSet:HashSet = new HashSet();
      
      public var pathObj:Object;
      
      public var noteSet:Array = new Array();
      
      public function ResourceHandler(param1:String)
      {
         super(new URLRequest(param1));
         addEventListener(Event.COMPLETE,this.__onCompleted);
         addEventListener(IOErrorEvent.IO_ERROR,this.__onError);
      }
      
      private function __onCompleted(param1:Event) : void
      {
         var _loc2_:XML = null;
         var _loc3_:int = 0;
         var _loc4_:XML = null;
         var _loc5_:XML = null;
         var _loc6_:XML = XML(param1.currentTarget.data);
         this.pathObj = new Object();
         this.resPath = _loc6_.resources.attribute("path");
         this.pathObj["cdn"] = this.resPath;
         this.pathObj["res"] = _loc6_.resources.attribute("res");
         this.pathObj["client"] = _loc6_.resources.attribute("client");
         this.pathObj["floor"] = _loc6_.resources.attribute("floor");
         this.pathObj["avatar"] = _loc6_.resources.attribute("avatar");
         this.pathObj["sp"] = _loc6_.resources.attribute("sp");
         this.pathObj["map"] = _loc6_.resources.attribute("gMap");
         this.pathObj["galaxy"] = _loc6_.resources.attribute("galaxyAssetPath");
         for each(_loc2_ in _loc6_.resources.elements())
         {
            this.resSet.Put(_loc2_.@name.toString(),this.resPath + this.pathObj["res"] + _loc2_.@src.toString());
         }
         _loc3_ = 0;
         while(_loc3_ < _loc6_.music.elements().length())
         {
            _loc4_ = _loc6_.music.elements()[_loc3_];
            musicSet.push([_loc4_.@name,_loc6_.music.@path + _loc6_.music.@res + _loc4_.@src,_loc4_.@type]);
            _loc3_++;
         }
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_.Note.elements().length())
         {
            _loc5_ = _loc6_.Note.elements()[_loc7_];
            this.noteSet.push(_loc5_.@src);
            _loc7_++;
         }
      }
      
      private function __onError(param1:IOErrorEvent) : void
      {
         trace("config.xml Loader Error");
      }
      
      public function Destroy() : void
      {
         this.removeEventListener(Event.COMPLETE,this.__onCompleted);
         this.close();
      }
      
      public function getResourceUrl(param1:String) : String
      {
         return this.resPath + param1;
      }
   }
}

