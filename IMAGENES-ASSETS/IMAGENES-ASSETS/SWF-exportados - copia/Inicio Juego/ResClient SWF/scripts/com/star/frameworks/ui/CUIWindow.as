package com.star.frameworks.ui
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.errors.CError;
   import com.star.frameworks.geom.RectangleKit;
   import com.star.frameworks.managers.TemplateManager;
   import com.star.frameworks.utils.CGlobeFuncUtil;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   
   public class CUIWindow extends CUIPopWnd
   {
      
      protected var leftTopImage:ICUIcon = new CUIIcon();
      
      protected var leftBottomImage:ICUIcon = new CUIIcon();
      
      protected var rightTopImage:ICUIcon = new CUIIcon();
      
      protected var rightBottomImage:ICUIcon = new CUIIcon();
      
      protected var topCenterImage:ICUIcon = new CUIIcon();
      
      protected var bottomCenterImage:ICUIcon = new CUIIcon();
      
      protected var leftCenterImage:ICUIcon = new CUIIcon();
      
      protected var rightCenterImage:ICUIcon = new CUIIcon();
      
      protected var bodyImage:ICUIcon = new CUIIcon();
      
      protected var titleIcon:ICUIcon = new CUIIcon();
      
      protected var templateStyle:Object;
      
      private var isDragging:Boolean = false;
      
      private var moving:Boolean = false;
      
      private var startDragX:int = 0;
      
      private var startDragY:int = 0;
      
      private var dragX:int = 0;
      
      private var dragY:int = 0;
      
      public function CUIWindow(param1:CUIFormat = null)
      {
         super(param1);
      }
      
      override public function initComponent() : void
      {
         this.installUI("CUIWindow");
         if(getFormat().template == "UIPopWnd")
         {
            this.installTitle(this.titleIcon);
         }
         if(Boolean(getFormat().textOffset) && Boolean(getFormat().sText))
         {
         }
         if(getFormat().dragable)
         {
            getContainer().addEventListener(MouseEvent.CLICK,this.__onClick,true);
            getContainer().addEventListener(MouseEvent.MOUSE_DOWN,this.__onStartDragging,false,0,true);
         }
      }
      
      override public function installTitle(param1:ICUIcon) : void
      {
         if(param1)
         {
            param1.loadRect(getFormat().resKey,this.templateStyle["Texture"],new RectangleKit(0,192,245,33));
            Container(this.titleIcon.getComponent()).mouseEnabled = true;
            this.titleIcon.getComponent().name = getName() + "_Title";
            this.titleIcon.getComponent().x = (getWidth() - this.titleIcon.getComponent().width) * 0.5;
            this.titleIcon.getComponent().y = -8;
            addComponent(this.titleIcon);
         }
      }
      
      override public function installTexture(param1:ICUIcon) : void
      {
      }
      
      override public function installUI(param1:String) : void
      {
         var _loc2_:ICUIcon = null;
         var _loc3_:ICUIcon = null;
         var _loc4_:ICUIcon = null;
         var _loc5_:ICUIcon = null;
         var _loc6_:ICUIcon = null;
         if(!TemplateManager.getInstance().getWndUILib().ContainsKey(format.template))
         {
            throw new CError("未初始化窗体模板文件" + getFormat().template);
         }
         setType(param1);
         setShow(getFormat().isShow);
         HasChild(true);
         setName(getFormat().name);
         setEnable(getFormat().enabled);
         setVisible(getFormat().visible);
         setXYWH(getFormat().rectangle);
         getContainer().name = getName();
         getContainer().visible = isVisible();
         getContainer().x = getX();
         getContainer().y = getY();
         getContainer().mouseEnabled = isEnabled();
         this.templateStyle = TemplateManager.getInstance().getWndUILib().Get(getFormat().template);
         this.leftTopImage.loadRect(getFormat().resKey,this.templateStyle["Texture"],CGlobeFuncUtil.ParserStrToRectangle(this.templateStyle["WinLeftTop"]));
         this.rightTopImage.loadRect(getFormat().resKey,this.templateStyle["Texture"],CGlobeFuncUtil.ParserStrToRectangle(this.templateStyle["WinRightTop"]));
         this.leftBottomImage.loadRect(getFormat().resKey,this.templateStyle["Texture"],CGlobeFuncUtil.ParserStrToRectangle(this.templateStyle["WinLeftBotton"]));
         this.rightBottomImage.loadRect(getFormat().resKey,this.templateStyle["Texture"],CGlobeFuncUtil.ParserStrToRectangle(this.templateStyle["WinRightBotton"]));
         this.topCenterImage.loadRect(getFormat().resKey,this.templateStyle["Texture"],CGlobeFuncUtil.ParserStrToRectangle(this.templateStyle["WinTopCenter"]));
         this.bottomCenterImage.loadRect(getFormat().resKey,this.templateStyle["Texture"],CGlobeFuncUtil.ParserStrToRectangle(this.templateStyle["WinBottonCenter"]));
         this.leftCenterImage.loadRect(getFormat().resKey,this.templateStyle["Texture"],CGlobeFuncUtil.ParserStrToRectangle(this.templateStyle["WinLeftCenter"]));
         this.rightCenterImage.loadRect(getFormat().resKey,this.templateStyle["Texture"],CGlobeFuncUtil.ParserStrToRectangle(this.templateStyle["WinRightCenter"]));
         this.leftTopImage.getContainer().x = 0;
         this.leftTopImage.getContainer().y = 0;
         this.leftBottomImage.getComponent().y = getHeight() - this.leftBottomImage.getComponent().height;
         this.leftCenterImage.getComponent().y = this.leftTopImage.getComponent().height;
         this.leftCenterImage.getComponent().height = getHeight() - this.leftTopImage.getComponent().height - this.leftBottomImage.getComponent().height;
         this.rightTopImage.getComponent().x = getWidth() - this.rightTopImage.getComponent().width;
         this.rightCenterImage.getComponent().x = getWidth() - this.rightCenterImage.getComponent().width;
         this.rightCenterImage.getComponent().y = this.rightTopImage.getComponent().height;
         this.rightCenterImage.getComponent().height = format.rectangle.height - this.rightTopImage.getComponent().height - this.rightBottomImage.getComponent().height;
         this.rightBottomImage.getComponent().x = getWidth() - this.rightBottomImage.getComponent().width;
         this.rightBottomImage.getComponent().y = getHeight() - this.rightBottomImage.getComponent().height;
         this.topCenterImage.getComponent().x = this.leftTopImage.getComponent().width;
         this.topCenterImage.getComponent().width = getWidth() - this.leftTopImage.getComponent().width - this.rightTopImage.getComponent().width;
         if(getFormat().template == "UIPopWnd")
         {
            this.bottomCenterImage.getComponent().x = this.leftBottomImage.getComponent().width;
            this.bottomCenterImage.getComponent().y = getHeight() - this.bottomCenterImage.getComponent().height - 6;
            this.bottomCenterImage.getComponent().width = getWidth() - this.leftBottomImage.getComponent().width - this.rightBottomImage.getComponent().width;
         }
         else
         {
            this.bottomCenterImage.getComponent().x = this.leftBottomImage.getComponent().width;
            this.bottomCenterImage.getComponent().y = getHeight() - this.bottomCenterImage.getComponent().height;
            this.bottomCenterImage.getComponent().width = getWidth() - this.leftBottomImage.getComponent().width - this.rightBottomImage.getComponent().width;
         }
         if(getFormat().round)
         {
            this.bodyImage.fillRoundRect(new RectangleKit(3,5,getWidth() - 20,getHeight() - 20),getFormat().round,getFormat().backgroundColor,getFormat().backgroundAlpha);
         }
         else
         {
            this.bodyImage.fillRect(new RectangleKit(3,5,getWidth() - 20,getHeight() - 20),getFormat().backgroundColor,getFormat().backgroundAlpha);
         }
         Container(this.bodyImage.getComponent()).mouseEnabled = true;
         addComponent(this.bodyImage);
         if(getFormat().template == "UIPopWnd")
         {
            _loc2_ = new CUIIcon();
            _loc3_ = new CUIIcon();
            _loc4_ = new CUIIcon();
            _loc5_ = new CUIIcon();
            _loc6_ = new CUIIcon();
            _loc2_.loadRect(getFormat().resKey,this.templateStyle["Texture"],CGlobeFuncUtil.ParserStrToRectangle(this.templateStyle["WinBodyLeft"]).Merger(0,0,0,this.bodyImage.getComponent().height));
            _loc3_.loadRect(getFormat().resKey,this.templateStyle["Texture"],CGlobeFuncUtil.ParserStrToRectangle(this.templateStyle["WinBodyRight"]).Merger(0,0,0,this.bodyImage.getComponent().height));
            _loc4_.loadRect(getFormat().resKey,this.templateStyle["Texture"],CGlobeFuncUtil.ParserStrToRectangle(this.templateStyle["WinBodyLeftBottom"]));
            _loc5_.loadRect(getFormat().resKey,this.templateStyle["Texture"],CGlobeFuncUtil.ParserStrToRectangle(this.templateStyle["WinBodyRightBottom"]));
            _loc6_.loadRect(getFormat().resKey,this.templateStyle["Texture"],CGlobeFuncUtil.ParserStrToRectangle(this.templateStyle["WinBodyBottomCenter"]));
            _loc2_.getComponent().x = 15;
            _loc2_.getComponent().y = 5;
            _loc2_.getComponent().height = this.bodyImage.getComponent().height - 10;
            _loc3_.getComponent().x = this.bodyImage.getComponent().width - _loc3_.getComponent().width - 3;
            _loc3_.getComponent().y = 5;
            _loc3_.getComponent().height = this.bodyImage.getComponent().height - 10;
            _loc4_.getComponent().y = this.bodyImage.getComponent().height - _loc4_.getComponent().height;
            _loc5_.getComponent().x = this.bodyImage.getComponent().width - _loc5_.getComponent().width;
            _loc5_.getComponent().y = _loc4_.getComponent().y;
            _loc6_.getComponent().x = _loc4_.getComponent().width;
            _loc6_.getComponent().y = this.bodyImage.getComponent().height - _loc6_.getComponent().height;
            _loc6_.getComponent().width = this.bodyImage.getComponent().width - _loc4_.getComponent().width - _loc5_.getComponent().width;
            addComponent(_loc2_);
            addComponent(_loc3_);
            addComponent(_loc4_);
            addComponent(_loc5_);
            addComponent(_loc6_);
         }
         addComponent(this.leftTopImage);
         addComponent(this.leftBottomImage);
         addComponent(this.rightTopImage);
         addComponent(this.rightBottomImage);
         addComponent(this.topCenterImage);
         addComponent(this.bottomCenterImage);
         addComponent(this.leftCenterImage);
         addComponent(this.rightCenterImage);
      }
      
      private function __onClick(param1:MouseEvent) : void
      {
      }
      
      private function __onStartDragging(param1:MouseEvent) : void
      {
         this.isDragging = true;
         this.moving = false;
         this.startDragX = param1.stageX;
         this.startDragY = param1.stageY;
         this.dragX = getContainer().x;
         this.dragY = getContainer().y;
         getContainer().stage.addEventListener(MouseEvent.MOUSE_UP,this.__onStopDragging,false,0,true);
         getContainer().stage.addEventListener(MouseEvent.MOUSE_MOVE,this.__onDragging,false,0,true);
      }
      
      private function __onDragging(param1:MouseEvent) : void
      {
         this.moving = true;
         if(this.isDragging && param1.target.name === getName() + "_Title")
         {
            this.__onMove(getContainer(),param1.stageX - this.startDragX + this.dragX,param1.stageY - this.startDragY + this.dragY);
         }
      }
      
      private function __onStopDragging(param1:MouseEvent) : void
      {
         if(this.isDragging && this.moving)
         {
            this.isDragging = false;
         }
         else
         {
            this.isDragging = false;
         }
         getContainer().stage.removeEventListener(MouseEvent.MOUSE_UP,this.__onStopDragging);
         getContainer().stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.__onDragging);
      }
      
      private function __onMove(param1:DisplayObject, param2:int, param3:int) : void
      {
         if(param2 <= 0)
         {
            param2 = 0;
         }
         if(param3 <= 0)
         {
            param3 = 0;
         }
         if(param2 <= 0 && param3 <= 0)
         {
            param3 = 0;
         }
         param1.x = param2;
         param1.y = param3;
      }
   }
}

