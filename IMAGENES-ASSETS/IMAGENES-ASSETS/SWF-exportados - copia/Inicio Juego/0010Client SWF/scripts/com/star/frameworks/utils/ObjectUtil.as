package com.star.frameworks.utils
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.ui.ICUIComponent;
   import com.star.frameworks.ui.ICUIMovieClip;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.errors.IllegalOperationError;
   import flash.net.registerClassAlias;
   import flash.utils.ByteArray;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   public class ObjectUtil
   {
      
      public function ObjectUtil()
      {
         super();
      }
      
      public static function isString(param1:*) : Boolean
      {
         return typeof param1 == "string" || param1 is String;
      }
      
      public static function isNumber(param1:*) : Boolean
      {
         return typeof param1 == "number" || param1 is Number;
      }
      
      public static function isBoolean(param1:*) : Boolean
      {
         return typeof param1 == "boolean" || param1 is Boolean;
      }
      
      public static function isFunction(param1:*) : Boolean
      {
         return typeof param1 == "function" || param1 is Function;
      }
      
      public static function isUndefined(param1:*) : Boolean
      {
         return typeof param1 == "undefined" || param1 is undefined;
      }
      
      public static function isArray(param1:*) : Boolean
      {
         return getQualifiedClassName(param1) == "Array" ? true : false;
      }
      
      public static function isNull(param1:*) : Boolean
      {
         return param1 == null ? true : false;
      }
      
      public static function ClearArray(param1:Array) : void
      {
         var _loc2_:* = undefined;
         if(!param1)
         {
            return;
         }
         if(!param1.length)
         {
            return;
         }
         while(param1.length)
         {
            _loc2_ = param1.pop();
            _loc2_ = null;
         }
      }
      
      public static function cloneObject(param1:*) : *
      {
         var _loc2_:String = getQualifiedClassName(param1);
         var _loc3_:String = _loc2_.split("::")[1];
         var _loc4_:Class = Class(getDefinitionByName(_loc2_));
         registerClassAlias(_loc3_,_loc4_);
         var _loc5_:ByteArray = new ByteArray();
         _loc5_.writeObject(param1);
         _loc5_.position = 0;
         return _loc5_.readObject();
      }
      
      public static function getObjectClassName(param1:*) : String
      {
         return getQualifiedClassName(param1);
      }
      
      public static function getObjectClass(param1:String) : Class
      {
         return Class(getDefinitionByName(param1));
      }
      
      public static function getPackageName(param1:*) : String
      {
         return getQualifiedClassName(param1).split("::")[0];
      }
      
      public static function Dispose(param1:DisplayObject) : void
      {
         var _loc2_:* = undefined;
         if(isNull(param1))
         {
            throw new IllegalOperationError("组件对象为空");
         }
         if(param1 is DisplayObjectContainer && param1 is Container)
         {
            while(Container(param1).numChildren > 0)
            {
               _loc2_ = Container(param1).getChildAt(0);
               Container(param1).removeChild(_loc2_);
               _loc2_ = null;
            }
            Container(param1).graphics.clear();
         }
      }
      
      public static function Clone(param1:*) : *
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeObject(param1);
         _loc2_.position = 0;
         return _loc2_.readObject();
      }
      
      public static function fetchMovieClipInstance(param1:ICUIComponent) : MovieClip
      {
         if(Boolean(param1) && param1 is ICUIMovieClip)
         {
            return Container(ICUIMovieClip(param1).getComponent()).getChildAt(0) as MovieClip;
         }
         return null;
      }
   }
}

