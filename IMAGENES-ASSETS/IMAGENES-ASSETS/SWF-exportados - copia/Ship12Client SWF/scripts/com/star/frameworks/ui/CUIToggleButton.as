package com.star.frameworks.ui
{
   import com.star.frameworks.errors.CError;
   import com.star.frameworks.geom.RectangleKit;
   import com.star.frameworks.managers.ResManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   
   public class CUIToggleButton extends CUIComponent implements ICUIButton
   {
      
      private var defaultState:DisplayObject;
      
      private var overState:DisplayObject;
      
      private var pressState:DisplayObject;
      
      public function CUIToggleButton(param1:CUIFormat = null)
      {
         super(param1);
      }
      
      override public function initComponent() : void
      {
         setType("CUIToggleButton");
         HasChild(true);
         setShow(getFormat().isShow);
         setName(getFormat().name);
         setVisible(getFormat().visible);
         setEnable(getFormat().visible);
         setXYWH(getFormat().rectangle);
         this.container.mouseEnabled = isEnabled();
         getContainer().x = getX();
         getContainer().y = getY();
         if(getFormat().border && Boolean(getFormat().borderColor))
         {
            getContainer().fillRectangleWithBorder(0,0,getFormat().textOffset.width,getFormat().textOffset.height,13421772,0,1,getFormat().borderColor);
         }
         getContainer().visible = isVisible();
         this.overState = ResManager.getInstance().getRectTexure(getFormat().resKey,getFormat().texture,getFormat().overTexture,false);
         this.pressState = ResManager.getInstance().getRectTexure(getFormat().resKey,getFormat().texture,getFormat().pressedTexture,false);
         this.defaultState = this.createRectIcon(getFormat().resKey,getFormat().texture,getFormat().imageTexture);
         if(getFormat().backgroundTexture)
         {
            getContainer().Base_SetBackGround(Bitmap(this.createIcon(getFormat().resKey,getFormat().backgroundTexture)));
         }
         if(getFormat().texture && getFormat().imageTexture && Boolean(getFormat().textOffset))
         {
            getContainer().addChild(this.defaultState);
         }
         getContainer().addEventListener(MouseEvent.MOUSE_OVER,this.__onOver,false,0,true);
         getContainer().addEventListener(MouseEvent.CLICK,this.__onClick);
         getContainer().addEventListener(MouseEvent.MOUSE_OUT,this.__onOut,false,0,true);
      }
      
      public function createRectIcon(param1:String, param2:String, param3:RectangleKit) : DisplayObject
      {
         return ResManager.getInstance().getRectTexure(param1,param2,param3);
      }
      
      public function createIcon(param1:String, param2:String, param3:Boolean = false) : DisplayObject
      {
         return ResManager.getInstance().getTexture(param1,param2,param3);
      }
      
      public function updateIcon(param1:DisplayObject, param2:String = null) : void
      {
         if(getContainer().Base_getChildNumber() < 0)
         {
            throw new CError("不存在子对象");
         }
         if(param2)
         {
            getContainer().name = param2;
         }
         var _loc3_:Bitmap = getContainer().getChildAt(0) as Bitmap;
         getContainer().removeChild(_loc3_);
         _loc3_.bitmapData.dispose();
         _loc3_ = null;
         if(param1 is Bitmap)
         {
            param1.x = getFormat().textOffset.x;
            param1.y = getFormat().textOffset.y;
            getContainer().Base_SetBackGround(Bitmap(param1));
         }
         getContainer().addChild(param1);
      }
      
      public function installText(param1:String, param2:RectangleKit) : void
      {
      }
      
      public function setDisabled() : void
      {
      }
      
      public function setEnabled() : void
      {
      }
      
      private function __onOver(param1:MouseEvent) : void
      {
         if(!getContainer().getChildByName(this.pressState.name))
         {
            getContainer().addChildAt(this.overState,getContainer().numChildren - 1);
         }
      }
      
      private function __onClick(param1:MouseEvent) : void
      {
         if(!getContainer().getChildByName(this.pressState.name))
         {
            getContainer().addChildAt(this.pressState,getContainer().numChildren - 1);
         }
      }
      
      private function __onOut(param1:MouseEvent) : void
      {
         if(!getContainer().getChildByName(this.pressState.name))
         {
            getContainer().removeChild(this.overState);
         }
      }
   }
}

