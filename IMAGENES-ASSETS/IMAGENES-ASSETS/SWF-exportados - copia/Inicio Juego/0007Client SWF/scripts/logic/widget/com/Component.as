package logic.widget.com
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.geom.RectangleKit;
   import flash.display.DisplayObject;
   
   public class Component implements IComponent
   {
      
      protected var rect:RectangleKit;
      
      protected var name:String;
      
      protected var type:String;
      
      protected var container:Container;
      
      protected var format:ComFormat;
      
      protected var enable:Boolean;
      
      protected var visible:Boolean;
      
      protected var show:Boolean;
      
      protected var parent:IComponent;
      
      public function Component()
      {
         super();
      }
      
      public function Init() : void
      {
      }
      
      public function setType(param1:String) : void
      {
         param1 = param1;
      }
      
      public function setFormat(param1:ComFormat) : void
      {
         this.format = param1;
      }
      
      public function getFormat() : ComFormat
      {
         return this.format;
      }
      
      public function setRect(param1:RectangleKit) : void
      {
         this.rect = param1;
      }
      
      public function getRect() : RectangleKit
      {
         return this.rect;
      }
      
      public function setName(param1:String) : void
      {
         this.name = param1;
      }
      
      public function getName() : String
      {
         return this.name;
      }
      
      public function getContainer() : Container
      {
         return this.container;
      }
      
      public function getComponent() : DisplayObject
      {
         return null;
      }
   }
}

