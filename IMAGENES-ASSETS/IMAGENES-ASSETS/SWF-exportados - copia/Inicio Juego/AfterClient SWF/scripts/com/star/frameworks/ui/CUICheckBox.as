package com.star.frameworks.ui
{
   import com.star.frameworks.managers.ResManager;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   
   public class CUICheckBox extends CUIComponent
   {
      
      private var m_default:DisplayObject;
      
      private var m_over:DisplayObject;
      
      private var m_Selected:DisplayObject;
      
      public function CUICheckBox(param1:CUIFormat = null)
      {
         super(param1);
      }
      
      override public function initComponent() : void
      {
         setType("CUICheckBox");
         HasChild(true);
         setShow(getFormat().isShow);
         setName(getFormat().name);
         setXYWH(getFormat().rectangle);
         getContainer().name = getFormat().name;
         getContainer().mouseEnabled = getFormat().enabled;
         getContainer().visible = getFormat().visible;
         getContainer().x = getX();
         getContainer().y = getY();
         getContainer().cacheAsBitmap = true;
         getContainer().buttonMode = true;
         if(getFormat().defaultTexture)
         {
            this.m_default = ResManager.getInstance().getRectTexure(getFormat().resKey,getFormat().texture,getFormat().defaultTexture,true,"check");
            getContainer().addChild(this.m_default);
         }
         if(getFormat().enabled)
         {
            getContainer().addEventListener(MouseEvent.MOUSE_OVER,this.__onOver,false,0,true);
            getContainer().addEventListener(MouseEvent.MOUSE_OUT,this.__onOut,false,0,true);
            getContainer().addEventListener(MouseEvent.CLICK,this.__onSelected);
         }
         if(getFormat().checked)
         {
            this.m_Selected = ResManager.getInstance().getRectTexure(getFormat().resKey,getFormat().texture,getFormat().defaultTexture.Merger(0,this.m_default.height,0,0));
         }
      }
      
      private function __onOver(param1:MouseEvent) : void
      {
         if(!this.m_over)
         {
            this.m_over = ResManager.getInstance().getRectTexure(getFormat().resKey,getFormat().texture,getFormat().defaultTexture.Merger(0,2 * this.m_default.height,0,0));
         }
         getContainer().addChild(this.m_over);
      }
      
      private function __onOut(param1:MouseEvent) : void
      {
         if(this.m_over)
         {
            getContainer().removeChild(this.m_over);
            this.m_over = null;
         }
      }
      
      private function __onSelected(param1:MouseEvent) : void
      {
         if(!this.m_Selected)
         {
            this.m_Selected = ResManager.getInstance().getRectTexure(getFormat().resKey,getFormat().texture,getFormat().defaultTexture.Merger(0,this.m_default.height,0,0));
            getContainer().addChild(this.m_Selected);
            getContainer().removeEventListener(MouseEvent.MOUSE_OVER,this.__onOver);
            getContainer().removeEventListener(MouseEvent.MOUSE_OUT,this.__onOut);
         }
         else
         {
            getContainer().addEventListener(MouseEvent.MOUSE_OVER,this.__onOver);
            getContainer().addEventListener(MouseEvent.MOUSE_OUT,this.__onOut);
            getContainer().removeChild(this.m_Selected);
            this.m_Selected = null;
         }
      }
   }
}

