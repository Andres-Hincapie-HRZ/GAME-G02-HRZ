package com.star.frameworks.ui
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.geom.RectangleKit;
   import com.star.frameworks.graphics.GraphicsKit;
   import com.star.frameworks.utils.HashSet;
   import com.star.frameworks.utils.StringUitl;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Stage;
   
   public class CUIComponent implements ICUIComponent
   {
      
      protected var rect:RectangleKit;
      
      protected var name:String;
      
      protected var type:String;
      
      protected var hasChild:Boolean;
      
      protected var container:Container;
      
      protected var clipRect:RectangleKit;
      
      protected var format:CUIFormat;
      
      protected var isChild:Boolean;
      
      protected var graphics:GraphicsKit;
      
      protected var enable:Boolean;
      
      protected var texture:String;
      
      protected var visible:Boolean;
      
      protected var dragging:Boolean;
      
      protected var childs:HashSet;
      
      protected var show:Boolean;
      
      protected var parent:ICUIComponent;
      
      public function CUIComponent(param1:CUIFormat = null)
      {
         super();
         this.setFormat(param1);
      }
      
      public function initComponent() : void
      {
      }
      
      public function getComponent() : DisplayObject
      {
         return this.container;
      }
      
      public function getFormat() : CUIFormat
      {
         return this.format;
      }
      
      public function setFormat(param1:CUIFormat) : void
      {
         this.format = param1;
      }
      
      public function setXYWH(param1:RectangleKit) : void
      {
         this.rect = param1;
      }
      
      public function setLocationXY(param1:int, param2:int) : void
      {
         if(this.getComponent())
         {
            this.getComponent().x = param1;
            this.getComponent().y = param2;
            this.rect.x = param1;
            this.rect.y = param2;
         }
      }
      
      public function setSizeWH(param1:int, param2:int) : void
      {
         if(this.getComponent())
         {
            this.getComponent().width = param1;
            this.getComponent().height = param2;
            this.rect.width = param1;
            this.rect.height = param2;
         }
      }
      
      public function getRect() : RectangleKit
      {
         return this.rect;
      }
      
      public function isShow() : Boolean
      {
         return this.show;
      }
      
      public function setShow(param1:Boolean) : void
      {
         this.show = param1;
      }
      
      public function setTexure(param1:String) : void
      {
         this.texture = param1;
      }
      
      public function getTexure() : String
      {
         return this.texture;
      }
      
      public function getChildrenSet() : HashSet
      {
         return this.childs;
      }
      
      public function addComponent(param1:*) : void
      {
         var _loc2_:Object = null;
         if(this.isHasChild())
         {
            _loc2_ = new Object();
            _loc2_.Index = this.getChildrenNumber();
            _loc2_.Component = param1;
            if(param1 is ICUIComponent)
            {
               _loc2_.Show = ICUIComponent(param1).isShow();
               this.childs.Put(ICUIComponent(param1).getName(),_loc2_);
               ICUIComponent(param1).setParent(this);
               if(_loc2_.Show)
               {
                  this.container.Base_AddChild(param1);
               }
            }
            else if(param1 is MovieClip || param1 is DisplayObject)
            {
               this.childs.Put(param1.name,_loc2_);
               this.container.addChild(param1);
            }
         }
      }
      
      public function addComponentAt(param1:*, param2:int) : void
      {
         var _loc3_:Object = null;
         if(this.isHasChild())
         {
            _loc3_ = new Object();
            _loc3_.Index = param2;
            _loc3_.Component = param1;
            if(param1 is ICUIComponent)
            {
               _loc3_.Show = ICUIComponent(param1).isShow();
               this.childs.Put(ICUIComponent(param1).getName(),_loc3_);
               ICUIComponent(param1).setParent(this);
               if(_loc3_.Show)
               {
                  if(param2 >= this.container.Base_getChildNumber())
                  {
                     this.container.Base_AddChild(param1);
                  }
                  else
                  {
                     this.container.Base_AddChildAt(param1,param2);
                  }
               }
            }
            else if(param1 is MovieClip || param1 is DisplayObject)
            {
               this.childs.Put(param1.name,_loc3_);
               this.getContainer().addChildAt(param1,param2);
            }
         }
      }
      
      public function getComponentByName(param1:String) : ICUIComponent
      {
         if(this.isHasChild())
         {
            param1 = StringUitl.Trim(param1);
            if(this.childs.ContainsKey(param1))
            {
               return this.childs.Get(param1).Component;
            }
            return null;
         }
         return null;
      }
      
      public function getChildByName(param1:String) : DisplayObject
      {
         if(this.isHasChild())
         {
            param1 = StringUitl.Trim(param1);
            if(this.childs.ContainsKey(param1))
            {
               return this.childs.Get(param1).Component as DisplayObject;
            }
            return null;
         }
         return null;
      }
      
      public function getChildrenNumber() : int
      {
         if(this.isHasChild() && Boolean(this.childs))
         {
            return this.childs.Length();
         }
         return 0;
      }
      
      public function getAllChildComponent() : HashSet
      {
         if(this.isHasChild())
         {
            return this.childs;
         }
         return null;
      }
      
      public function getComponentByIndex(param1:int) : ICUIComponent
      {
         var _loc2_:Object = null;
         if(this.isHasChild())
         {
            if(Boolean(this.childs) && Boolean(this.childs.Length()))
            {
               for each(_loc2_ in this.childs.Values())
               {
                  if(_loc2_.Index == param1)
                  {
                     return _loc2_.Component;
                  }
               }
            }
            return null;
         }
         return null;
      }
      
      public function removeComponent(param1:*, param2:Boolean = false) : void
      {
         if(this.isHasChild())
         {
            if(param1 is ICUIComponent)
            {
               if(!this.childs.ContainsKey(ICUIComponent(param1).getName()))
               {
                  return;
               }
               this.getContainer().removeChild(ICUIComponent(param1).getComponent());
               if(param2)
               {
                  this.childs.Remove(ICUIComponent(param1).getName());
                  param1 = null;
                  return;
               }
               return;
            }
            if(param1 is MovieClip || param1 is DisplayObject)
            {
               if(!this.childs.ContainsKey(DisplayObject(param1).name))
               {
                  return;
               }
               if(param2)
               {
                  this.childs.Remove(param1.name);
                  this.container.removeChild(param1);
                  param1 = null;
                  return;
               }
               if(this.container.getChildByName(param1.name))
               {
                  this.container.removeChild(param1);
               }
               param1 = null;
               return;
            }
         }
      }
      
      public function setClipRect(param1:RectangleKit) : void
      {
         this.clipRect = param1;
      }
      
      public function getClipRect() : RectangleKit
      {
         return this.clipRect;
      }
      
      public function isHasChild() : Boolean
      {
         return this.hasChild;
      }
      
      public function HasChild(param1:Boolean) : void
      {
         if(param1)
         {
            if(!this.container)
            {
               this.container = new Container();
            }
            this.childs = new HashSet();
         }
         else if(Boolean(this.childs) && Boolean(this.childs.Length()))
         {
            this.childs.removeAll();
            this.childs = null;
         }
         this.hasChild = param1;
      }
      
      public function getX() : int
      {
         return this.rect.x;
      }
      
      public function getY() : int
      {
         return this.rect.y;
      }
      
      public function getLocationX() : int
      {
         if(this.getComponent())
         {
            return this.getComponent().x;
         }
         return 0;
      }
      
      public function getLocationY() : int
      {
         if(this.getComponent())
         {
            return this.getComponent().y;
         }
         return 0;
      }
      
      public function getWidth() : int
      {
         return this.rect.width;
      }
      
      public function getHeight() : int
      {
         return this.rect.height;
      }
      
      public function set CacheAsBitMap(param1:Boolean) : void
      {
         if(this.getComponent())
         {
            this.getComponent().cacheAsBitmap = param1;
         }
      }
      
      public function get CacheAsBitMap() : Boolean
      {
         if(this.getComponent())
         {
            return this.getComponent().cacheAsBitmap;
         }
         return false;
      }
      
      public function getContainer() : Container
      {
         return this.container;
      }
      
      public function getName() : String
      {
         if(this.getContainer())
         {
            return this.getContainer().name;
         }
         return null;
      }
      
      public function getStage() : Stage
      {
         return this.getComponent().stage;
      }
      
      public function setName(param1:String) : void
      {
         if(!this.container)
         {
            this.container = new Container();
         }
         this.container.name = param1;
      }
      
      public function setType(param1:String) : void
      {
         this.type = param1;
      }
      
      public function getType() : String
      {
         return this.type;
      }
      
      public function setEnable(param1:Boolean) : void
      {
         if(this.getContainer())
         {
            this.enable = param1;
            this.getContainer().mouseEnabled = param1;
            return;
         }
         this.enable = param1;
      }
      
      public function isEnabled() : Boolean
      {
         return this.enable;
      }
      
      public function setVisible(param1:Boolean) : void
      {
         if(this.getComponent())
         {
            this.visible = param1;
            this.getComponent().visible = param1;
            return;
         }
         this.visible = param1;
      }
      
      public function isVisible() : Boolean
      {
         return this.visible;
      }
      
      public function setMark(param1:DisplayObject) : void
      {
         if(this.getContainer())
         {
            this.getContainer().mask = param1;
         }
      }
      
      public function setParent(param1:ICUIComponent) : void
      {
         this.parent = param1;
      }
      
      public function getParent() : ICUIComponent
      {
         return this.parent;
      }
      
      public function Show() : void
      {
         var _loc1_:Object = null;
         if(this.getParent())
         {
            if(this.getParent().getChildrenSet().ContainsKey(this.getName()))
            {
               _loc1_ = this.getParent().getChildrenSet().Get(this.getName());
               if(!_loc1_.Show)
               {
                  ICUIComponent(_loc1_.Component).setShow(true);
                  _loc1_.Show = true;
                  this.getParent().addComponentAt(_loc1_.Component,_loc1_.Index);
               }
            }
         }
      }
      
      public function appendTo(param1:String) : void
      {
         param1 = StringUitl.Trim(param1);
         if(Boolean(this.childs) && Boolean(this.childs.Length()))
         {
            if(this.childs.ContainsKey(param1))
            {
               this.childs.Get(param1).Show = true;
               ICUIComponent(this.childs.Get(param1).Component).setShow(true);
               this.container.Base_AddChildAt(this.childs.Get(param1).Component,this.childs.Get(param1).Index);
            }
         }
      }
      
      public function Hide() : void
      {
         var _loc1_:Object = null;
         if(this.getParent())
         {
            if(this.getParent().getChildrenSet().ContainsKey(this.getName()))
            {
               _loc1_ = this.getParent().getChildrenSet().Get(this.getName());
               if(_loc1_.Show)
               {
                  ICUIComponent(_loc1_.Component).setShow(false);
                  _loc1_.Show = false;
                  this.getParent().removeComponent(this,false);
               }
            }
         }
      }
      
      public function addActionEvent(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         if(this.getComponent())
         {
            this.getComponent().addEventListener(param1,param2,param3,param4,param5);
         }
      }
      
      public function removeActionEvent(param1:String, param2:Function, param3:Boolean = false) : void
      {
         if(Boolean(this.getComponent()) && this.getComponent().hasEventListener(param1))
         {
            this.getComponent().removeEventListener(param1,param2,param3);
         }
      }
   }
}

