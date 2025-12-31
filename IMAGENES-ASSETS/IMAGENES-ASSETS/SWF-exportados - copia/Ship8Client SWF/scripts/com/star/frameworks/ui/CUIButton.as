package com.star.frameworks.ui
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.geom.RectangleKit;
   import com.star.frameworks.managers.ResManager;
   import com.star.frameworks.utils.HashSet;
   import flash.display.DisplayObject;
   import flash.display.SimpleButton;
   import flash.text.TextField;
   
   public class CUIButton extends CUIComponent implements ICUIButton
   {
      
      private var button:SimpleButton;
      
      private var btnLib:HashSet;
      
      public function CUIButton(param1:CUIFormat = null)
      {
         super(param1);
         this.container = new Container();
      }
      
      override public function initComponent() : void
      {
         setType("CUIButton");
         HasChild(true);
         this.btnLib = new HashSet();
         setShow(getFormat().isShow);
         setName(getFormat().name);
         setVisible(getFormat().visible);
         CacheAsBitMap = true;
         setXYWH(getFormat().rectangle);
         getContainer().x = getX();
         getContainer().y = getY();
         getContainer().buttonMode = true;
         this.button = new SimpleButton();
         this.button.name = getType();
         this.button.upState = this.createRectIcon(getFormat().resKey,getFormat().texture,getFormat().defaultTexture);
         this.button.downState = this.createRectIcon(getFormat().resKey,getFormat().texture,getFormat().defaultTexture.Merger(0,getHeight(),0,0));
         this.button.overState = this.createRectIcon(getFormat().resKey,getFormat().texture,getFormat().defaultTexture.Merger(0,getHeight() << 1,0,0));
         this.button.hitTestState = this.button.upState;
         getContainer().addChild(this.button);
         if(Boolean(getFormat().sText) && Boolean(getFormat().textOffset))
         {
         }
      }
      
      public function createRectIcon(param1:String, param2:String, param3:RectangleKit) : DisplayObject
      {
         if(!this.btnLib.ContainsKey(param3.toString()))
         {
            this.btnLib.Put(param3.toString(),ResManager.getInstance().getRectTexure(param1,param2,param3));
         }
         return this.btnLib.Get(param3.toString());
      }
      
      public function createIcon(param1:String, param2:String, param3:Boolean = false) : DisplayObject
      {
         return ResManager.getInstance().getTexture(param1,param2,param3);
      }
      
      public function updateIcon(param1:DisplayObject, param2:String = null) : void
      {
      }
      
      public function installText(param1:String, param2:RectangleKit) : void
      {
      }
      
      public function updateText(param1:String) : void
      {
         TextField(getContainer().getChildByName(getName() + CUITypeEnum.UI_TYPE_LABLE)).text = param1;
      }
      
      public function setDisabled() : void
      {
      }
      
      public function setEnabled() : void
      {
      }
   }
}

