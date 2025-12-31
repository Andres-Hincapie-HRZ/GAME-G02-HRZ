package logic.widget.com
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.geom.RectangleKit;
   import flash.display.DisplayObject;
   
   public interface IComponent
   {
      
      function Init() : void;
      
      function getComponent() : DisplayObject;
      
      function setRect(param1:RectangleKit) : void;
      
      function getRect() : RectangleKit;
      
      function getName() : String;
      
      function setName(param1:String) : void;
      
      function getFormat() : ComFormat;
      
      function setFormat(param1:ComFormat) : void;
      
      function getContainer() : Container;
      
      function setType(param1:String) : void;
   }
}

