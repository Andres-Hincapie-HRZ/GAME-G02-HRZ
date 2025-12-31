package logic.widget.com
{
   import com.star.frameworks.geom.RectangleKit;
   import com.star.frameworks.utils.CGlobeFuncUtil;
   import flash.display.DisplayObject;
   import logic.widget.tips.CToolTip;
   
   public class ComXmlParser
   {
      
      private var _toolTipPopUp:CToolTip;
      
      private var _iDecorate:IComponent;
      
      private var _xmlList:XMLList;
      
      public var _rect:RectangleKit;
      
      private var LastX:int;
      
      private var LastY:int;
      
      private var TipRect:RectangleKit;
      
      private var LayoutType:int;
      
      private var spacing:int;
      
      public function ComXmlParser(param1:XML)
      {
         super();
         this._xmlList = param1.* as XMLList;
         this.Parser();
      }
      
      private function Parser() : void
      {
         var _loc3_:* = undefined;
         var _loc1_:String = this._xmlList.name();
         var _loc2_:String = this._xmlList.@Type;
         this.LayoutType = this._xmlList.@LayoutType;
         this.spacing = this._xmlList.@Spacing;
         this._rect = CGlobeFuncUtil.ParserStrToRectangle(this._xmlList.@Rectangle);
         this.LastX = this._rect.x;
         this.LastY = this._rect.y;
         this._toolTipPopUp = new CToolTip(this._rect);
         this._toolTipPopUp.LayOutType = this.LayoutType;
         this._toolTipPopUp.Spacing = this.spacing;
         for each(_loc3_ in this._xmlList.elements())
         {
            this.ParserData(_loc3_);
         }
      }
      
      private function ParserData(param1:XML) : void
      {
         var _loc2_:ComFormat = this.parserItemComFormat(param1);
         var _loc3_:ComDecorator = new ComDecorator(_loc2_);
         var _loc4_:Object = new Object();
         _loc4_.Format = _loc2_;
         _loc4_.Display = _loc3_.getIDecorate().getComponent();
         this._toolTipPopUp.Data.push(_loc4_);
         var _loc5_:IComponent = _loc3_.getIDecorate();
         var _loc6_:DisplayObject = _loc5_.getComponent();
         if(this.LayoutType == 1)
         {
            _loc6_.y = this.LastY;
            this.LastY += _loc5_.getRect().height + this.spacing;
         }
         else if(this.LayoutType == 2)
         {
            if(this.LastX + _loc5_.getRect().width > this._rect.width)
            {
               this.LastY += _loc5_.getRect().height + this.spacing;
               _loc6_.y = this.LastY;
               _loc6_.x = this._rect.x;
               this.LastX = _loc5_.getRect().width + this.spacing;
            }
            else
            {
               _loc6_.y = this.LastY;
               _loc6_.x = this.LastX;
               this.LastX += _loc5_.getRect().width;
            }
         }
         if(_loc2_.isShow)
         {
            this._toolTipPopUp.getDecorate().addChild(_loc6_);
         }
      }
      
      public function getToolTipDecorate() : CToolTip
      {
         return this._toolTipPopUp;
      }
      
      private function parserItemComFormat(param1:XML) : ComFormat
      {
         var _loc2_:ComFormat = new ComFormat();
         _loc2_.name = param1.name();
         if(param1.attribute("Type").length())
         {
            _loc2_.type = param1.@Type;
         }
         if(param1.attribute("Template").length())
         {
            _loc2_.template = param1.@Template;
         }
         if(param1.attribute("SText").length())
         {
            _loc2_.sText = param1.@SText;
         }
         if(param1.attribute("Rectangle").length())
         {
            _loc2_.rectangle = CGlobeFuncUtil.ParserStrToRectangle(param1.@Rectangle);
         }
         if(param1.attribute("ImageTexture").length())
         {
            _loc2_.imageTexture = CGlobeFuncUtil.ParserStrToRectangle(param1.@ImageTexture);
         }
         if(param1.attribute("BackgroundTexture").length())
         {
            _loc2_.backgroundTexture = param1.@BackgroundTexture;
         }
         if(param1.attribute("DefaultTexture").length())
         {
            _loc2_.defaultTexture = CGlobeFuncUtil.ParserStrToRectangle(param1.@DefaultTexture);
         }
         if(param1.attribute("PressedTexture").length())
         {
            _loc2_.pressedTexture = CGlobeFuncUtil.ParserStrToRectangle(param1.@PressedTexture);
         }
         if(param1.attribute("OverTexture").length())
         {
            _loc2_.overTexture = CGlobeFuncUtil.ParserStrToRectangle(param1.@OverTexture);
         }
         if(param1.attribute("Visible").length())
         {
            _loc2_.visible = param1.@Visible != 0;
         }
         if(param1.attribute("Anchor").length())
         {
            _loc2_.anchor = param1.Anchor != 0;
         }
         if(param1.attribute("Enabled").length())
         {
            _loc2_.enabled = param1.@Enabled != 0;
         }
         if(param1.attribute("Dragable").length())
         {
            _loc2_.dragable = param1.@Dragable != 0;
         }
         if(param1.attribute("Selectabled").length())
         {
            _loc2_.selectable = param1.@Selectabled != 0;
         }
         if(param1.attribute("TextType").length())
         {
            _loc2_.textType = param1.@TextType;
         }
         if(param1.attribute("Password").length())
         {
            _loc2_.password = param1.@Password != 0;
         }
         if(param1.attribute("IsAutoSize").length())
         {
            _loc2_.isAutoSize = param1.@IsAutoSize != 0;
         }
         if(param1.attribute("AutoSize").length())
         {
            _loc2_.autoSize = param1.@AutoSize;
         }
         if(param1.attribute("WrapWord").length())
         {
            _loc2_.wrapWord = param1.@WrapWord != 0;
         }
         if(param1.attribute("McClass").length())
         {
            _loc2_.mcClass = param1.@McClass;
         }
         if(param1.attribute("Font").length())
         {
            _loc2_.font = param1.@Font;
         }
         if(param1.attribute("FontSize").length())
         {
            _loc2_.fontSize = param1.@FontSize;
         }
         if(param1.attribute("FontColor").length())
         {
            _loc2_.fontColor = param1.@FontColor;
         }
         if(param1.attribute("TextAlpha").length())
         {
            _loc2_.textAlpha = param1.@TextAlpha;
         }
         if(param1.attribute("TextOffset").length())
         {
            _loc2_.textOffset = CGlobeFuncUtil.ParserStrToRectangle(param1.@TextOffset);
         }
         if(param1.attribute("Border").length())
         {
            _loc2_.border = param1.@Border != 0;
         }
         if(param1.attribute("BorderColor").length())
         {
            _loc2_.borderColor = uint(param1.@BorderColor);
         }
         if(param1.attribute("BorderAlpha").length())
         {
            _loc2_.borderAlpha = param1.@BorderAlpha;
         }
         if(param1.attribute("TextAlpha").length())
         {
            _loc2_.textAlpha = param1.@TextAlpha;
         }
         if(param1.attribute("Align").length())
         {
            _loc2_.align = param1.@Align;
         }
         if(param1.attribute("BackgroundColor").length())
         {
            _loc2_.backgroundColor = param1.@BackgroundColor;
         }
         if(param1.attribute("ForegroundColor").length())
         {
            _loc2_.foregroundColor = param1.@ForegroundColor;
         }
         if(param1.attribute("BackgroundAlpha").length())
         {
            _loc2_.backgroundAlpha = param1.@BackgroundAlpha;
         }
         if(param1.attribute("ImageAlpha").length())
         {
            _loc2_.imageAlpha = param1.@ImageAlpha;
         }
         if(param1.attribute("Scroll").length())
         {
            _loc2_.scroll = param1.@Scroll;
         }
         if(param1.attribute("TextDefault").length())
         {
            _loc2_.textDefault = param1.@TextDefault;
         }
         if(param1.attribute("TextFormat").length())
         {
            _loc2_.textFormat = param1.@TextFormat;
         }
         if(param1.attribute("Texture").length())
         {
            _loc2_.texture = param1.@Texture;
         }
         if(param1.attribute("CellHeight").length())
         {
            _loc2_.cellHeight = param1.@CellHeight;
         }
         if(param1.attribute("Opaque").length())
         {
            _loc2_.opaque = param1.@Opaque != 0;
         }
         if(param1.attribute("TabbedTitle").length())
         {
            _loc2_.tabbebTitle = param1.@TabbedTitle;
         }
         if(param1.attribute("ListCellClass").length())
         {
            _loc2_.listCellClass = param1.@ListCellClass;
         }
         if(param1.attribute("ResKey").length())
         {
            _loc2_.resKey = param1.@ResKey;
         }
         if(param1.attribute("Restrict").length())
         {
            _loc2_.restrict = param1.@Restrict;
         }
         if(param1.attribute("ComboBoxHeight").length())
         {
            _loc2_.comboBoxHeight = param1.@ComboBoxHeight;
         }
         if(param1.attribute("ScaleX").length())
         {
            _loc2_.scaleX = param1.@ScaleX;
         }
         if(param1.attribute("ScaleY").length())
         {
            _loc2_.scaleY = param1.@ScaleY;
         }
         if(param1.attribute("Rotation").length())
         {
            _loc2_.rotation = param1.@Rotation;
         }
         if(param1.attribute("Checked").length())
         {
            _loc2_.checked = param1.@Checked != 0;
         }
         if(param1.attribute("IsShow").length())
         {
            _loc2_.isShow = param1.@IsShow != 0;
         }
         return _loc2_;
      }
   }
}

