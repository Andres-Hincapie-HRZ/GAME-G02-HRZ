package com.star.frameworks.ui
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.geom.RectangleKit;
   import com.star.frameworks.managers.ResManager;
   import flash.display.DisplayObject;
   
   public class CUITabPanel extends CUIPopWnd implements ICUITabPanel
   {
      
      private var btnArea:Container;
      
      private var leftBtn:DisplayObject;
      
      private var rightBtn:DisplayObject;
      
      private var pressState:DisplayObject;
      
      public function CUITabPanel(param1:CUIFormat = null)
      {
         super(param1);
      }
      
      override public function initComponent() : void
      {
         var _loc1_:Array = null;
         var _loc2_:int = 0;
         setType("CUITabPanel");
         HasChild(true);
         setShow(getFormat().isShow);
         setName(getFormat().name);
         setEnable(getFormat().enabled);
         setVisible(getFormat().visible);
         setXYWH(getFormat().rectangle);
         getContainer().name = getName();
         getContainer().mouseEnabled = isEnabled();
         getContainer().visible = isVisible();
         getContainer().x = getX();
         getContainer().y = getY();
         if(getFormat().tabbebTitle)
         {
            _loc1_ = getFormat().tabbebTitle.split("|");
            if(_loc1_.length)
            {
               this.btnArea = new Container();
               this.btnArea.name = getName() + "BtnArea";
               this.installLeftIcon();
               _loc2_ = 0;
               while(_loc2_ < _loc1_.length)
               {
                  this.installTab(_loc2_,_loc1_[_loc2_]);
                  _loc2_++;
               }
               this.installRightIcon();
            }
            getContainer().addChild(this.btnArea);
         }
      }
      
      public function installTab(param1:int, param2:String) : void
      {
      }
      
      public function installLeftIcon() : void
      {
         this.leftBtn = ResManager.getInstance().getRectTexure(ResManager.GAMERES,getFormat().texture,new RectangleKit(320,137,17,20),true,getName + CUITypeEnum.UI_TYPE_BUTTON);
         this.btnArea.addChild(this.leftBtn);
      }
      
      public function installRightIcon() : void
      {
         this.rightBtn = ResManager.getInstance().getRectTexure(ResManager.GAMERES,getFormat().texture,new RectangleKit(320,159,17,20),true,getName + CUITypeEnum.UI_TYPE_BUTTON);
         this.rightBtn.x = this.btnArea.width;
         this.btnArea.addChild(this.rightBtn);
      }
   }
}

