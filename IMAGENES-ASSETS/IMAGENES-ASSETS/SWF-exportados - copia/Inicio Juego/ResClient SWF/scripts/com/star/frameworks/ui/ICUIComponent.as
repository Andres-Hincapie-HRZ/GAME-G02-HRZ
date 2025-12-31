package com.star.frameworks.ui
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.geom.RectangleKit;
   import com.star.frameworks.utils.HashSet;
   import flash.display.DisplayObject;
   import flash.display.Stage;
   
   public interface ICUIComponent
   {
      
      function initComponent() : void;
      
      function getComponent() : DisplayObject;
      
      function setXYWH(param1:RectangleKit) : void;
      
      function setLocationXY(param1:int, param2:int) : void;
      
      function setSizeWH(param1:int, param2:int) : void;
      
      function getRect() : RectangleKit;
      
      function setTexure(param1:String) : void;
      
      function getTexure() : String;
      
      function getX() : int;
      
      function getY() : int;
      
      function getLocationX() : int;
      
      function getLocationY() : int;
      
      function getWidth() : int;
      
      function getHeight() : int;
      
      function set CacheAsBitMap(param1:Boolean) : void;
      
      function get CacheAsBitMap() : Boolean;
      
      function getChildrenSet() : HashSet;
      
      function addComponent(param1:*) : void;
      
      function addComponentAt(param1:*, param2:int) : void;
      
      function getComponentByName(param1:String) : ICUIComponent;
      
      function getChildByName(param1:String) : DisplayObject;
      
      function getComponentByIndex(param1:int) : ICUIComponent;
      
      function getAllChildComponent() : HashSet;
      
      function getChildrenNumber() : int;
      
      function removeComponent(param1:*, param2:Boolean = false) : void;
      
      function setClipRect(param1:RectangleKit) : void;
      
      function getClipRect() : RectangleKit;
      
      function isHasChild() : Boolean;
      
      function HasChild(param1:Boolean) : void;
      
      function getName() : String;
      
      function getStage() : Stage;
      
      function setName(param1:String) : void;
      
      function getFormat() : CUIFormat;
      
      function setFormat(param1:CUIFormat) : void;
      
      function getContainer() : Container;
      
      function setType(param1:String) : void;
      
      function getType() : String;
      
      function setEnable(param1:Boolean) : void;
      
      function isEnabled() : Boolean;
      
      function setVisible(param1:Boolean) : void;
      
      function isVisible() : Boolean;
      
      function setMark(param1:DisplayObject) : void;
      
      function Show() : void;
      
      function appendTo(param1:String) : void;
      
      function Hide() : void;
      
      function isShow() : Boolean;
      
      function setShow(param1:Boolean) : void;
      
      function setParent(param1:ICUIComponent) : void;
      
      function getParent() : ICUIComponent;
      
      function addActionEvent(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void;
      
      function removeActionEvent(param1:String, param2:Function, param3:Boolean = false) : void;
   }
}

