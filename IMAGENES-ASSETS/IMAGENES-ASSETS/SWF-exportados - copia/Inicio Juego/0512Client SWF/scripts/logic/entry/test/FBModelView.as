package logic.entry.test
{
   import flash.display.Bitmap;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import logic.entry.FBModel;
   import logic.game.GameFont;
   import logic.game.GameKernel;
   import logic.manager.InstanceManager;
   import logic.ui.tip.InstanceTip;
   
   public class FBModelView extends Sprite
   {
      
      private var _parent:DisplayObjectContainer;
      
      private var _mc:MovieClip;
      
      private var _line:Shape;
      
      private var _numTexture:Bitmap;
      
      private var _data:FBModel;
      
      private var _pass:Boolean = false;
      
      private var _selected:Boolean = false;
      
      private var _isNew:Boolean = false;
      
      private var _hasNext:Boolean = false;
      
      public function FBModelView(param1:DisplayObjectContainer, param2:FBModel, param3:FBModel = null)
      {
         super();
         this._parent = param1;
         this._data = param2;
         if(param3)
         {
            this._hasNext = true;
         }
         this._mc = GameKernel.getMovieClipInstance(this._data.McName);
         this._mc.stop();
         this._mc.addEventListener(MouseEvent.MOUSE_OVER,this.onOver);
         this._mc.addEventListener(MouseEvent.CLICK,this.onSelect);
         addChild(this._mc);
         var _loc4_:String = this._data.ID < 10 ? "0" + this._data.ID : this._data.ID + "";
         this._numTexture = new Bitmap(GameFont.getIntByString(_loc4_));
         this._numTexture.x = -8;
         this._numTexture.y = -3;
         addChild(this._numTexture);
         x = this._data.PosX;
         y = this._data.PosY;
         if(this._hasNext)
         {
            this._line = new Shape();
            this._line.graphics.lineStyle(1,this._data.LineColor,1);
            this._line.alpha = 0.5;
            this._line.graphics.moveTo(0,0);
            this._line.graphics.lineTo(param3.PosX - param2.PosX,param3.PosY - param2.PosY);
            this._line.x = param2.PosX;
            this._line.y = param2.PosY;
         }
         this.isOrderToPass();
      }
      
      public function Init() : void
      {
         if(this._hasNext)
         {
            this._parent.addChildAt(this._line,2);
         }
         this._parent.addChild(this);
      }
      
      public function Release() : void
      {
         this._parent.removeChild(this);
         if(this._hasNext)
         {
            this._parent.removeChild(this._line);
         }
      }
      
      private function onSelect(param1:MouseEvent) : void
      {
         InstanceManager.instance.setFBSelectedFalse();
         if(this._pass || this._isNew)
         {
            this._selected = !this._selected;
            if(this._selected)
            {
               this._mc.gotoAndStop("selected");
               InstanceManager.instance.curSelectFB = this._data;
            }
            else if(!this._selected && this._pass)
            {
               this._mc.gotoAndStop("over");
            }
            else if(!this._selected && this._isNew)
            {
               this._mc.gotoAndStop("open");
            }
            else
            {
               this._mc.gotoAndStop("up");
            }
         }
      }
      
      private function onOver(param1:MouseEvent) : void
      {
         if(!this._selected || this._pass || this._isNew)
         {
            this._mc.filters = [new GlowFilter(49133)];
         }
         this._mc.addEventListener(MouseEvent.MOUSE_OUT,this.onOut);
         var _loc2_:Point = new Point(482,175);
         InstanceTip.instance.Show(_loc2_,this._data,InstanceManager.instance.checkNeeded(this._data));
      }
      
      private function onOut(param1:MouseEvent) : void
      {
         if(!this._selected && !this._pass && !this._isNew)
         {
            this._mc.gotoAndStop("up");
         }
         else if(!this._selected && !this._pass && this._isNew)
         {
            this._mc.gotoAndStop("open");
         }
         InstanceTip.instance.Hide();
         this._mc.filters = null;
         this._mc.removeEventListener(MouseEvent.MOUSE_OUT,this.onOut);
      }
      
      public function get pass() : Boolean
      {
         return this._pass;
      }
      
      public function set pass(param1:Boolean) : void
      {
         this._pass = param1;
         if(this._pass)
         {
            if(this._line)
            {
               this._line.alpha = 1;
            }
            this._mc.gotoAndStop("over");
         }
         else
         {
            if(this._line)
            {
               this._line.alpha = 0.5;
            }
            this._mc.gotoAndStop("up");
         }
      }
      
      public function get selected() : Boolean
      {
         return this._selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         this._selected = param1;
         if(!this._selected && this._pass)
         {
            this._mc.gotoAndStop("over");
         }
         else if(!this._selected && this._isNew)
         {
            this._mc.gotoAndStop("open");
         }
         else if(!this._selected && !this._pass && !this._isNew)
         {
            this._mc.gotoAndStop("up");
         }
      }
      
      public function get Ectype() : int
      {
         return this._data.EctypeID;
      }
      
      public function get isNew() : Boolean
      {
         return this._isNew;
      }
      
      public function set isNew(param1:Boolean) : void
      {
         this._isNew = param1;
         if(this._isNew)
         {
            this._mc.gotoAndStop("open");
         }
      }
      
      public function isOrderToPass() : Boolean
      {
         if(this._data.Needed == -1)
         {
            this.pass = true;
         }
         return this._data.Needed == -1;
      }
   }
}

