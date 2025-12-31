package com.star.frameworks.ui
{
   import com.star.frameworks.utils.CGlobeFuncUtil;
   import com.star.frameworks.utils.ObjectUtil;
   import flash.errors.IllegalOperationError;
   
   public class CUIParser
   {
      
      private var m_container:ICUIComponent;
      
      private var popWnd:ICUIComponent;
      
      public function CUIParser(param1:XML)
      {
         super();
         this.m_container = new CUIComponent();
         this.m_container.HasChild(true);
         this.m_container.setShow(true);
         this.Load(param1);
      }
      
      private function Load(param1:XML) : void
      {
         var _loc2_:int = int(param1.*.elements().length());
         this.m_container.setName(param1.*.name());
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this.LoadData(param1.*.elements()[_loc3_]);
            this.m_container.addComponent(this.popWnd);
            _loc3_++;
         }
      }
      
      private function LoadData(param1:XML, param2:ICUIComponent = null) : void
      {
         var _loc3_:CUIFormat = this.parseFormat(param1);
         var _loc4_:CUIDecorator = new CUIDecorator(_loc3_);
         if(ObjectUtil.isNull(param2))
         {
            this.popWnd = _loc4_.getICUImpl();
            this.Iterator(this.popWnd,param1);
         }
         else
         {
            if(param2 is ICUIWindow || param2 is ICUIMovieClip)
            {
               _loc4_.getICUImpl().setParent(param2);
               param2.addComponent(_loc4_.getICUImpl());
            }
            if(_loc4_.getICUImpl() is ICUIWindow || _loc4_.getICUImpl() is ICUIMovieClip)
            {
               this.Iterator(_loc4_.getICUImpl(),param1);
            }
         }
      }
      
      private function Iterator(param1:ICUIComponent, param2:XML) : void
      {
         var ele:XML = null;
         var uiFormat:CUIFormat = null;
         var uiDescorate:CUIDecorator = null;
         var container:ICUIComponent = param1;
         var conf:XML = param2;
         for each(ele in conf.elements())
         {
            if(this.isOwnChild(ele))
            {
               this.LoadData(ele,container);
            }
            else
            {
               uiFormat = this.parseFormat(ele);
               try
               {
                  uiDescorate = new CUIDecorator(uiFormat);
                  if(container is ICUIWindow || container is ICUIMovieClip)
                  {
                     if(container.isHasChild())
                     {
                        container.addComponent(uiDescorate.getICUImpl());
                     }
                  }
               }
               catch(e:Error)
               {
                  throw new IllegalOperationError("UI初始化实例化错误 [文件路径:" + conf.name() + " [标签类型:" + uiFormat.type + " ] ******[标签名字: " + uiFormat.name + "]" + e.message);
               }
            }
         }
      }
      
      private function parseFormat(param1:XML) : CUIFormat
      {
         var _loc2_:CUIFormat = new CUIFormat();
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
      
      public function getPopWindow() : ICUIComponent
      {
         return this.m_container;
      }
      
      private function isOwnChild(param1:XML) : Boolean
      {
         return param1.elements().length() != 0 ? true : false;
      }
   }
}

