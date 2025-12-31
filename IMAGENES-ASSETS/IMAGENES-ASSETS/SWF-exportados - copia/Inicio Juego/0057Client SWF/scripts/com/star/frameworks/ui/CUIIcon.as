package com.star.frameworks.ui
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.errors.CError;
   import com.star.frameworks.geom.RectangleKit;
   import com.star.frameworks.graphics.ColorKit;
   import com.star.frameworks.graphics.GraphicsKit;
   import com.star.frameworks.graphics.PenKit;
   import com.star.frameworks.graphics.SolidBrush;
   import com.star.frameworks.managers.ResManager;
   
   public class CUIIcon extends CUIComponent implements ICUIcon
   {
      
      public function CUIIcon(param1:CUIFormat = null)
      {
         super(param1);
         this.container = new Container();
      }
      
      override public function initComponent() : void
      {
         setType("CUIIcon");
         setName(getFormat().name);
         setShow(getFormat().isShow);
         setXYWH(getFormat().rectangle);
         setEnable(getFormat().enabled);
         setVisible(getFormat().visible);
         getContainer().name = getFormat().name;
         getContainer().x = getX();
         getContainer().y = getY();
         getContainer().scaleX = getFormat().scaleX;
         getContainer().scaleY = getFormat().scaleY;
         getContainer().rotation = getFormat().rotation;
         graphics = new GraphicsKit(getContainer().graphics);
         if(getFormat().border && Boolean(getFormat().borderColor))
         {
            this.graphics.drawRectangle(new PenKit(new ColorKit(getFormat().borderColor,getFormat().borderAlpha)),0,0,getWidth(),getHeight());
         }
         if(Boolean(getFormat().backgroundTexture) && !getFormat().imageTexture)
         {
            this.loadTexture(getFormat().resKey,getFormat().backgroundTexture);
         }
         if(Boolean(getFormat().texture) && Boolean(getFormat().imageTexture))
         {
            this.loadRect(getFormat().resKey,getFormat().texture,getFormat().imageTexture);
         }
         if(getFormat().backgroundColor)
         {
            if(getFormat().round)
            {
               this.fillRoundRect(new RectangleKit(0,0,getWidth(),getHeight()),getFormat().round,getFormat().backgroundColor,getFormat().backgroundAlpha);
            }
            else
            {
               this.fillRect(new RectangleKit(0,0,getWidth(),getHeight()),getFormat().backgroundColor,getFormat().backgroundAlpha);
            }
         }
         if(Boolean(getFormat().sText) && Boolean(getFormat().textDefault))
         {
            this.installText();
         }
      }
      
      public function loadTexture(param1:String, param2:String, param3:Boolean = false) : void
      {
         if(!param2)
         {
            throw new CError("没有指定外部图片名称");
         }
         getContainer().addChild(ResManager.getInstance().getTexture(param1,param2,param3));
      }
      
      public function loadRect(param1:String, param2:String, param3:RectangleKit) : void
      {
         if(!param3)
         {
            throw new CError("没有指定外部图片区域");
         }
         getContainer().addChild(ResManager.getInstance().getRectTexure(param1,param2,param3));
      }
      
      public function installText() : void
      {
      }
      
      public function unLoadRect() : void
      {
         getContainer().removeChildAt(container.numChildren - 1);
      }
      
      public function changeRect(param1:RectangleKit) : void
      {
         if(!param1)
         {
            if(!rect)
            {
               throw new CError("没有指定外部图片区域");
            }
         }
         this.unLoadRect();
         this.loadRect(getFormat().resKey,getFormat().texture,param1);
      }
      
      public function drawRect(param1:RectangleKit) : void
      {
         this.graphics = new GraphicsKit(getContainer().graphics);
         this.graphics.drawRectangle(new PenKit(new ColorKit()),param1.x,param1.y,param1.width,param1.height);
      }
      
      public function drawRoundRect(param1:RectangleKit, param2:Number = 10) : void
      {
         this.graphics = new GraphicsKit(getContainer().graphics);
         this.graphics.drawRoundRect(new PenKit(new ColorKit()),param1.x,param1.y,param1.width,param1.height,param2);
      }
      
      public function fillRoundRect(param1:RectangleKit, param2:Number = 25, param3:uint = 0, param4:Number = 1) : void
      {
         this.graphics = new GraphicsKit(getContainer().graphics);
         this.graphics.fillRoundRect(new SolidBrush(new ColorKit(param3,param4)),param1.x,param1.y,param1.width,param1.height,param2);
      }
      
      public function fillRect(param1:RectangleKit, param2:uint = 0, param3:Number = 1) : void
      {
         this.graphics = new GraphicsKit(getContainer().graphics);
         this.graphics.fillRectangle(new SolidBrush(new ColorKit(param2,param3)),param1.x,param1.y,param1.width,param1.height);
      }
   }
}

