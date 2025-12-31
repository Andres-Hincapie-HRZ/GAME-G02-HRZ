package logic.widget.com
{
   import com.star.frameworks.geom.RectangleKit;
   
   public class ComFormat
   {
      
      public static const POPWND:String = "PopWnd";
      
      public static const IMAGE:String = "Texture";
      
      public static const TEXT:String = "Text";
      
      public static const PROGRESS:String = "Progress";
      
      public var type:String;
      
      public var template:String;
      
      public var name:String;
      
      public var rectangle:RectangleKit;
      
      public var align:String = "left";
      
      public var textOffset:RectangleKit;
      
      public var sText:String;
      
      public var visible:Boolean = true;
      
      public var selectable:Boolean = false;
      
      public var enabled:Boolean = true;
      
      public var dragable:Boolean = false;
      
      public var scroll:Boolean = false;
      
      public var isAutoSize:Boolean = false;
      
      public var autoSize:String = "left";
      
      public var wrapWord:Boolean = true;
      
      public var maxText:int = 0;
      
      public var password:Boolean = false;
      
      public var textType:String;
      
      public var backgroundColor:uint = 0;
      
      public var foregroundColor:uint = 16777215;
      
      public var backgroundAlpha:Number = 0;
      
      public var imageAlpha:Number = 1;
      
      public var imageTexture:RectangleKit;
      
      public var backgroundTexture:String;
      
      public var fontColor:uint;
      
      public var font:String = "宋体";
      
      public var fontSize:Number = 12;
      
      public var textAlpha:Number = 0;
      
      public var defaultTexture:RectangleKit;
      
      public var pressedTexture:RectangleKit;
      
      public var overTexture:RectangleKit;
      
      public var mcClass:String = null;
      
      public var border:Boolean = false;
      
      public var borderColor:uint = 0;
      
      public var borderAlpha:Number = 0;
      
      public var textFormat:int = 0;
      
      public var textDefault:String = "Text";
      
      public var texture:String;
      
      public var cellHeight:int = 0;
      
      public var opaque:Boolean = true;
      
      public var tabbebTitle:String;
      
      public var round:int = 0;
      
      public var listCellClass:String;
      
      public var resKey:String = "GameRes";
      
      public var restrict:String;
      
      public var comboBoxHeight:int;
      
      public var scaleX:Number = 1;
      
      public var scaleY:Number = 1;
      
      public var rotation:Number = 0;
      
      public var checked:Boolean;
      
      public var isShow:Boolean;
      
      public var anchor:Boolean;
      
      public function ComFormat()
      {
         super();
      }
   }
}

