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
      
      public function ResourceHandler(res:String)
      {
         super(new URLRequest(res));
         addEventListener(Event.COMPLETE,this.__onCompleted);
         addEventListener(IOErrorEvent.IO_ERROR,this.__onError);
      }
      
      private function __onCompleted(e:Event) : void
      {
         var ele:XML = null;
         var i:int = 0;
         var item:XML = null;
         var notes:XML = null;
         var resXml:XML = XML(e.currentTarget.data);
         this.pathObj = new Object();
         this.resPath = resXml.resources.attribute("path");
         this.pathObj["cdn"] = this.resPath;
         this.pathObj["res"] = resXml.resources.attribute("res");
         this.pathObj["client"] = resXml.resources.attribute("client");
         this.pathObj["floor"] = resXml.resources.attribute("floor");
         this.pathObj["avatar"] = resXml.resources.attribute("avatar");
         this.pathObj["sp"] = resXml.resources.attribute("sp");
         this.pathObj["map"] = resXml.resources.attribute("gMap");
         this.pathObj["galaxy"] = resXml.resources.attribute("galaxyAssetPath");
         for each(ele in resXml.resources.elements())
         {
            this.resSet.Put(ele.@name.toString(),this.resPath + this.pathObj["res"] + ele.@src.toString());
         }
         for(i = 0; i < resXml.music.elements().length(); i++)
         {
            item = resXml.music.elements()[i];
            musicSet.push([item.@name,resXml.music.@path + resXml.music.@res + item.@src,item.@type]);
         }
         for(var j:int = 0; j < resXml.Note.elements().length(); j++)
         {
            notes = resXml.Note.elements()[j];
            this.noteSet.push(notes.@src);
         }
      }
      
      private function __onError(e:IOErrorEvent) : void
      {
         trace("config.xml Loader Error");
      }
      
      public function Destroy() : void
      {
         this.removeEventListener(Event.COMPLETE,this.__onCompleted);
         this.close();
      }
      
      public function getResourceUrl(url:String) : String
      {
         return this.resPath + url;
      }
   }
}

