package logic.widget.tips
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.geom.RectangleKit;
   import flash.display.Shape;
   import flash.filters.DropShadowFilter;
   
   public class CToolTipBgDecorate
   {
      
      private var _decorate:Container;
      
      private var _rect:RectangleKit;
      
      private var _bgFill:Shape;
      
      private var _fillColor:uint;
      
      private var _leftTopIcon:CToolTipIcon;
      
      private var _rightTopIcon:CToolTipIcon;
      
      private var _topCenterIcon:CToolTipIcon;
      
      private var _leftBottomIcon:CToolTipIcon;
      
      private var _rightBottomIcon:CToolTipIcon;
      
      private var _bottomCenterIcon:CToolTipIcon;
      
      private var _leftCenterIcon:CToolTipIcon;
      
      private var _rightCenterIcon:CToolTipIcon;
      
      public function CToolTipBgDecorate(param1:RectangleKit, param2:uint = 0)
      {
         super();
         this._rect = param1;
         this._fillColor = param2;
         this._bgFill = new Shape();
         this._decorate = new Container("CToolTipBgDecorate");
         this._decorate.mouseChildren = false;
      }
      
      public function get Decorate() : Container
      {
         return this._decorate;
      }
      
      public function get Rect() : RectangleKit
      {
         return this._rect;
      }
      
      public function Render(param1:RectangleKit) : void
      {
         this._rect = param1;
         this.Clear();
         this.Paint();
         this.fillBackgroundColor();
      }
      
      private function fillBackgroundColor() : void
      {
         this._bgFill.graphics.clear();
         this._bgFill.graphics.beginFill(this._fillColor,0.6);
         this._bgFill.graphics.drawRoundRect(0,0,this._rect.width - 1,this._rect.height - 1,5,5);
         this._bgFill.graphics.endFill();
         this._bgFill.filters = [new DropShadowFilter()];
         this._decorate.addChild(this._bgFill);
      }
      
      private function Clear() : void
      {
         if(this._leftTopIcon)
         {
            this._leftTopIcon.Clear();
         }
         if(this._leftBottomIcon)
         {
            this._leftBottomIcon.Clear();
         }
         if(this._rightTopIcon)
         {
            this._rightTopIcon.Clear();
         }
         if(this._topCenterIcon)
         {
            this._topCenterIcon.Clear();
         }
         if(this._rightBottomIcon)
         {
            this._rightBottomIcon.Clear();
         }
         if(this._bottomCenterIcon)
         {
            this._bottomCenterIcon.Clear();
         }
         if(this._leftCenterIcon)
         {
            this._leftCenterIcon.Clear();
         }
         if(this._rightCenterIcon)
         {
            this._rightCenterIcon.Clear();
         }
         var _loc1_:int = 0;
         while(_loc1_ < this._decorate.numChildren)
         {
            this._decorate.removeChildAt(_loc1_);
            _loc1_++;
         }
         this._leftTopIcon = null;
         this._leftBottomIcon = null;
         this._rightTopIcon = null;
         this._topCenterIcon = null;
         this._rightBottomIcon = null;
         this._bottomCenterIcon = null;
         this._leftCenterIcon = null;
         this._rightCenterIcon = null;
         this._bgFill.graphics.clear();
      }
      
      private function Paint() : void
      {
         this._leftTopIcon = new CToolTipIcon(CToolTipIconEnum.ICON_LEFT_TOP);
         this._leftBottomIcon = new CToolTipIcon(CToolTipIconEnum.ICON_LEFT_BOTTOM);
         this._rightTopIcon = new CToolTipIcon(CToolTipIconEnum.ICON_RIGHT_TOP);
         this._topCenterIcon = new CToolTipIcon(CToolTipIconEnum.ICON_TOP_CENTER);
         this._rightBottomIcon = new CToolTipIcon(CToolTipIconEnum.ICON_RIGHT_BOTTOM);
         this._bottomCenterIcon = new CToolTipIcon(CToolTipIconEnum.ICON_BOTTOM_CENTER);
         this._leftCenterIcon = new CToolTipIcon(CToolTipIconEnum.ICON_LEFT_CENTER);
         this._rightCenterIcon = new CToolTipIcon(CToolTipIconEnum.ICON_RIGHT_CENTER);
         this._leftTopIcon.setLocationXY(0,0);
         this._leftBottomIcon.setLocationXY(0,this._rect.height - this._leftBottomIcon.getHeigth());
         this._leftCenterIcon.setLocationXY(0,this._leftTopIcon.getHeigth());
         this._leftCenterIcon.setHeight(this._rect.height - this._leftTopIcon.getHeigth() - this._leftBottomIcon.getHeigth());
         this._rightTopIcon.setLocationXY(this._rect.width - this._rightTopIcon.getWidth(),0);
         this._rightBottomIcon.setLocationXY(this._rect.width - this._rightBottomIcon.getWidth(),this._rect.height - this._rightBottomIcon.getHeigth());
         this._rightCenterIcon.setLocationXY(this._rect.width - this._rightCenterIcon.getWidth(),this._rightTopIcon.getHeigth());
         this._rightCenterIcon.setHeight(this._rect.height - this._rightTopIcon.getHeigth() - this._rightBottomIcon.getHeigth());
         this._topCenterIcon.setLocationXY(this._leftTopIcon.getWidth(),0);
         this._topCenterIcon.setWidth(this._rect.width - this._leftTopIcon.getWidth() - this._rightTopIcon.getWidth());
         this._bottomCenterIcon.setLocationXY(this._leftBottomIcon.getWidth(),this._rect.height - this._bottomCenterIcon.getHeigth());
         this._bottomCenterIcon.setWidth(this._rect.width - this._leftBottomIcon.getWidth() - this._rightBottomIcon.getWidth());
         this._decorate.addChild(this._leftTopIcon.getInstance());
         this._decorate.addChild(this._rightTopIcon.getInstance());
         this._decorate.addChild(this._topCenterIcon.getInstance());
         this._decorate.addChild(this._leftBottomIcon.getInstance());
         this._decorate.addChild(this._rightBottomIcon.getInstance());
         this._decorate.addChild(this._bottomCenterIcon.getInstance());
         this._decorate.addChild(this._leftCenterIcon.getInstance());
         this._decorate.addChild(this._rightCenterIcon.getInstance());
      }
   }
}

