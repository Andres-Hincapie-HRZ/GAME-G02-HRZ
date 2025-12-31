package com.star.frameworks.ui
{
   import com.star.frameworks.graphics.ColorKit;
   import com.star.frameworks.graphics.GraphicsKit;
   import com.star.frameworks.graphics.PenKit;
   import com.star.frameworks.graphics.SolidBrush;
   import com.star.frameworks.managers.ResManager;
   import flash.display.DisplayObject;
   
   public class CUIPopWnd extends CUIComponent implements ICUIWindow
   {
      
      public function CUIPopWnd(param1:CUIFormat = null)
      {
         super(param1);
      }
      
      override public function initComponent() : void
      {
         setType("POPWND");
         HasChild(true);
         setName(getFormat().name);
         setShow(getFormat().isShow);
         setVisible(getFormat().visible);
         setEnable(getFormat().enabled);
         setXYWH(getFormat().rectangle);
         getContainer().x = getX();
         getContainer().y = getY();
         getContainer().name = getName();
         if(getFormat().backgroundTexture)
         {
            getContainer().Base_SetBackGround(ResManager.getInstance().getTexture(getFormat().resKey,getFormat().backgroundTexture));
         }
         if(Boolean(getFormat().imageTexture) && Boolean(getFormat().texture))
         {
            getContainer().Base_SetBackGround(ResManager.getInstance().getRectTexure(getFormat().resKey,getFormat().texture,getFormat().imageTexture));
         }
         graphics = new GraphicsKit(getContainer().graphics);
         switch(getFormat().round)
         {
            case 0:
               if(getFormat().border || Boolean(getFormat().borderColor))
               {
                  this.graphics.drawRectangle(new PenKit(new ColorKit(getFormat().borderColor,getFormat().borderAlpha)),0,0,getWidth(),getHeight());
               }
               if(Boolean(getFormat().backgroundColor) || Boolean(getFormat().backgroundAlpha))
               {
                  this.graphics.fillRectangle(new SolidBrush(new ColorKit(getFormat().backgroundColor,getFormat().backgroundAlpha)),0,0,getWidth(),getHeight());
               }
               break;
            default:
               if(getFormat().border || Boolean(getFormat().borderColor))
               {
                  this.graphics.drawRoundRect(new PenKit(new ColorKit(getFormat().borderColor,getFormat().borderAlpha)),0,0,getWidth(),getHeight(),getFormat().round);
               }
               if(Boolean(getFormat().backgroundColor) || Boolean(getFormat().backgroundAlpha))
               {
                  this.graphics.fillRoundRect(new SolidBrush(new ColorKit(getFormat().backgroundColor,getFormat().backgroundAlpha)),0,0,getWidth(),getHeight(),getFormat().round);
               }
         }
      }
      
      override public function getComponent() : DisplayObject
      {
         return this.container;
      }
      
      public function installText(param1:ICUIText, param2:ICUIComponent = null) : void
      {
         if(isHasChild() && Boolean(getFormat().textOffset))
         {
            if(param2)
            {
               param2.addComponent(param1);
            }
            else
            {
               getContainer().Base_AddChild(param1);
            }
         }
      }
      
      public function installTitle(param1:ICUIcon) : void
      {
         if(isHasChild())
         {
            addComponent(param1);
         }
      }
      
      public function installButton(param1:ICUIButton) : void
      {
         if(isHasChild())
         {
            getContainer().Base_AddChild(param1);
         }
      }
      
      public function installUI(param1:String) : void
      {
      }
      
      public function installTexture(param1:ICUIcon) : void
      {
         if(isHasChild() && Boolean(texture))
         {
            getContainer().Base_AddChild(param1);
         }
      }
   }
}

