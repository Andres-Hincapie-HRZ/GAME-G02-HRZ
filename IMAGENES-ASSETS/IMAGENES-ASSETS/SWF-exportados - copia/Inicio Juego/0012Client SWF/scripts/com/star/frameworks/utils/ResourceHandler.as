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
         var _loc3_:XML = null;
         var _loc4_:int = 0;
         var _loc6_:XML = null;
         var _loc7_:XML = null;
         var _loc2_:XML = XML(param1.currentTarget.data);
         this.pathObj = new Object();
         this.resPath = _loc2_.resources.attribute("path");
         this.pathObj["cdn"] = this.resPath;
         this.pathObj["res"] = _loc2_.resources.attribute("res");
         this.pathObj["client"] = _loc2_.resources.attribute("client");
         this.pathObj["floor"] = _loc2_.resources.attribute("floor");
         this.pathObj["avatar"] = _loc2_.resources.attribute("avatar");
         this.pathObj["sp"] = _loc2_.resources.attribute("sp");
         this.pathObj["map"] = _loc2_.resources.attribute("gMap");
         this.pathObj["galaxy"] = _loc2_.resources.attribute("galaxyAssetPath");
         for each(_loc3_ in _loc2_.resources.elements())
         {
            this.resSet.Put(_loc3_.@name.toString(),this.resPath + this.pathObj["res"] + _loc3_.@src.toString());
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_.music.elements().length())
         {
            _loc6_ = _loc2_.music.elements()[_loc4_];
            musicSet.push([_loc6_.@name,_loc2_.music.@path + _loc2_.music.@res + _loc6_.@src,_loc6_.@type]);
            _loc4_++;
         }
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_.Note.elements().length())
         {
            _loc7_ = _loc2_.Note.elements()[_loc5_];
            this.noteSet.push(_loc7_.@src);
            _loc5_++;
         }
      }
      
      private function __onError(param1:IOErrorEvent) : void
      {
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

