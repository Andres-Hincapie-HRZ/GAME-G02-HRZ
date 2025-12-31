package com.star.frameworks.display
{
   import com.star.frameworks.geom.PointKit;
   import com.star.frameworks.ui.ICUIComponent;
   import com.star.frameworks.utils.ObjectUtil;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class Container extends Sprite
   {
      
      private var containerBg:Bitmap;
      
      public function Container(param1:String = "Container")
      {
         super();
         param1 = param1;
         mouseEnabled = false;
         tabEnabled = false;
         tabChildren = false;
      }
      
      public static function getInstance() : Container
      {
         return new Container();
      }
      
      public function setEnable(param1:Boolean) : void
      {
         mouseEnabled = param1;
      }
      
      public function setLocationXY(param1:int, param2:int) : void
      {
         this.x = param1;
         this.y = param2;
      }
      
      public function Base_AddChild(param1:ICUIComponent) : void
      {
         super.addChild(param1.getComponent());
      }
      
      public function Base_AddChildAt(param1:ICUIComponent, param2:int) : void
      {
         super.addChildAt(param1.getComponent(),param2);
      }
      
      public function Base_getChildNumber() : int
      {
         return super.numChildren;
      }
      
      public function Base_SetBackGround(param1:Bitmap) : void
      {
         if(this.containerBg == null)
         {
            this.containerBg = param1;
            addChildAt(this.containerBg,0);
         }
      }
      
      public function get BackgroundWH() : PointKit
      {
         if(this.containerBg)
         {
            return new PointKit(this.containerBg.width,this.containerBg.height);
         }
         return new PointKit();
      }
      
      public function Base_SetBackGroundIcon(param1:ICUIComponent) : void
      {
         super.addChildAt(param1.getComponent(),0);
      }
      
      public function Base_GetBackGround() : Bitmap
      {
         return this.containerBg;
      }
      
      public function Base_ChangeBackGround(param1:Bitmap) : void
      {
         this.containerBg = param1;
      }
      
      public function Base_AddBitMap(param1:Bitmap) : void
      {
         if(param1 == null)
         {
            return;
         }
         super.addChild(param1);
      }
      
      public function Base_RemoveChild(param1:DisplayObject) : void
      {
         super.removeChild(param1);
      }
      
      public function Base_RemoveChildAt(param1:int) : void
      {
         super.removeChildAt(param1);
      }
      
      public function Base_RemoveComponent(param1:ICUIComponent) : void
      {
         if(param1)
         {
            this.Base_RemoveChild(param1.getComponent());
         }
      }
      
      public function Base_RemoveChildAll() : void
      {
         var _loc1_:* = undefined;
         while(this.Base_getChildNumber() > 0)
         {
            _loc1_ = getChildAt(0);
            this.Base_RemoveChild(_loc1_);
            _loc1_ = null;
         }
      }
      
      public function drawRectangleBorder(param1:int, param2:int, param3:uint, param4:Number, param5:String = "normal", param6:String = null, param7:String = null, param8:Number = 3, param9:Array = null) : void
      {
         graphics.lineStyle(1,param3,param4,false,param5,param6,param7,param8);
         this.x = param1;
         this.y = param2;
         if(ObjectUtil.isArray(param9) && !ObjectUtil.isNull(param9))
         {
            this.graphics.moveTo(param9[0].x,param9[0].y);
            this.graphics.lineTo(param9[1].x,param9[1].y);
            this.graphics.lineTo(param9[2].x,param9[2].y);
            this.graphics.lineTo(param9[3].x,param9[3].y);
            this.graphics.lineTo(param9[4].x,param9[4].y);
         }
      }
      
      public function fillRectangleWithBorder(param1:int, param2:int, param3:int, param4:int, param5:uint = 0, param6:Number = 1, param7:Number = 1, param8:uint = 16777215, param9:Number = 1) : void
      {
         graphics.beginFill(param5,param6);
         graphics.lineStyle(param7,param8,param9);
         graphics.drawRect(param1,param2,param3,param4);
         graphics.endFill();
      }
      
      public function fillRectangleWithoutBorder(param1:int, param2:int, param3:int, param4:int, param5:uint = 0, param6:Number = 1) : void
      {
         graphics.clear();
         graphics.beginFill(param5,param6);
         graphics.drawRect(param1,param2,param3,param4);
         graphics.endFill();
      }
      
      public function Gc() : void
      {
         var _loc1_:DisplayObject = null;
         while(this.numChildren > 0)
         {
            _loc1_ = getChildAt(0);
            this.removeChild(_loc1_);
            _loc1_ = null;
         }
      }
   }
}

