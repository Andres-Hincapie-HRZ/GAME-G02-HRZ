package com.star.frameworks.managers
{
   import com.star.frameworks.errors.CError;
   import com.star.frameworks.geom.RectangleKit;
   import com.star.frameworks.utils.CGlobeFuncUtil;
   import com.star.frameworks.utils.HashSet;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.StyleSheet;
   import flash.utils.ByteArray;
   
   public class ResManager
   {
      
      public static const GAMERES:String = "GameRes";
      
      private static var instance:ResManager = null;
      
      public var resLib:HashSet;
      
      public var imgLib:HashSet;
      
      public var rectImgLib:HashSet;
      
      public var audioLib:HashSet;
      
      public function ResManager()
      {
         super();
         this.resLib = new HashSet();
         this.imgLib = new HashSet();
         this.rectImgLib = new HashSet();
         this.audioLib = new HashSet();
      }
      
      public static function getInstance() : ResManager
      {
         if(instance == null)
         {
            instance = new ResManager();
         }
         return instance;
      }
      
      public function registAudio(param1:String, param2:*) : void
      {
         if(this.audioLib.ContainsKey(param1))
         {
            return;
         }
         this.audioLib.Put(param1,param2);
      }
      
      public function registerRes(param1:String, param2:*) : void
      {
         if(this.resLib.ContainsKey(param1))
         {
            return;
         }
         this.resLib.Put(param1,param2);
      }
      
      public function unRegisterRes(param1:String) : void
      {
         var _loc2_:* = undefined;
         if(this.resLib.ContainsKey(param1))
         {
            _loc2_ = this.resLib.Get(param1);
            this.resLib.Remove(param1);
            _loc2_ = null;
         }
      }
      
      public function getImage(param1:String, param2:String) : Bitmap
      {
         var _loc3_:Class = null;
         var _loc4_:Bitmap = null;
         if(!this.resLib.ContainsKey(param1))
         {
            throw new CError("无法找到指定资源[" + param1 + "]");
         }
         if(this.resLib.Get(param1).getImg(param2) == null)
         {
            throw new CError("不存在指定图片[" + param2 + "]");
         }
         if(!this.imgLib.ContainsKey(param2))
         {
            _loc3_ = this.resLib.Get(param1).getImg(param2);
            _loc4_ = new _loc3_() as Bitmap;
            this.imgLib.Put(param2,_loc4_);
            return _loc4_;
         }
         return this.imgLib.Get(param2);
      }
      
      public function getDat(param1:String, param2:String) : ByteArray
      {
         if(!this.resLib.ContainsKey(param1))
         {
            throw new CError("无法找到指定资源[" + param1 + "]");
         }
         if(this.resLib.Get(param1).getDat(param2) == null)
         {
            throw new CError("不存在指定文件[" + param2 + "]");
         }
         return this.resLib.Get(param1).getDat(param2);
      }
      
      public function setImgSequence(param1:String) : void
      {
      }
      
      public function getImageBytes(param1:String, param2:String) : ByteArray
      {
         var _loc3_:Class = null;
         var _loc4_:Bitmap = null;
         var _loc5_:ByteArray = null;
         if(!this.resLib.ContainsKey(param1))
         {
            throw new CError("无法找到指定资源[" + param1 + "]");
         }
         if(this.resLib.Get(param1).getImg(param2) == null)
         {
            throw new CError("不存在指定图片[" + param2 + "]");
         }
         if(!this.imgLib.ContainsKey(param2))
         {
            _loc3_ = this.resLib.Get(param1).getImg(param2);
            _loc4_ = new _loc3_() as Bitmap;
            _loc5_ = this.compressBit(_loc4_);
            this.imgLib.Put(param2,_loc5_);
            return _loc5_;
         }
         return this.imgLib.Get(param2);
      }
      
      public function compressBit(param1:Bitmap) : ByteArray
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeUnsignedInt(param1.bitmapData.width);
         _loc2_.writeBytes(param1.bitmapData.getPixels(param1.bitmapData.rect));
         _loc2_.compress();
         return _loc2_;
      }
      
      public function readBitMapBytes(param1:ByteArray, param2:Rectangle) : Bitmap
      {
         param1.uncompress();
         var _loc3_:int = int(param1.readUnsignedInt());
         var _loc4_:int = (param1.length - 4) / 4 / _loc3_;
         var _loc5_:BitmapData = new BitmapData(param2.width,param2.height,true,0);
         _loc5_.setPixels(param2,param1);
         return new Bitmap(_loc5_);
      }
      
      public function getXml(param1:String, param2:String) : XML
      {
         if(!this.resLib.ContainsKey(param1))
         {
            throw new CError("无法找到指定资源[" + param1 + "]");
         }
         if(this.resLib.Get(param1).getXml(param2) == null)
         {
            throw new CError("不存在指定文件[" + param2 + "]");
         }
         return this.resLib.Get(param1).getXml(param2);
      }
      
      public function removeXML(param1:String, param2:String) : void
      {
         if(this.resLib.ContainsKey(param1))
         {
            this.resLib.Get(param1).removeXML(param2);
         }
      }
      
      public function removeImg(param1:String, param2:String) : void
      {
         if(this.resLib.ContainsKey(param1))
         {
            this.resLib.Get(param1).removeImg(param2);
         }
      }
      
      public function getCss(param1:String, param2:String) : StyleSheet
      {
         if(!this.resLib.ContainsKey(param1))
         {
            throw new CError("无法找到指定资源[" + param1 + "]");
         }
         if(this.resLib.Get(param1).getCss(param2) == null)
         {
            throw new CError("不存在指定文件[" + param2 + "]");
         }
         return this.resLib.Get(param1).getCss(param2);
      }
      
      public function getRectTexure(param1:String, param2:String, param3:RectangleKit, param4:Boolean = true, param5:String = null) : Bitmap
      {
         if(this.rectImgLib.ContainsKey(param2 + param3.toString()))
         {
            if(param4)
            {
               return CGlobeFuncUtil.copyTexture(this.rectImgLib.Get(param2 + param3.toString()),param5);
            }
            return this.rectImgLib.Get(param2 + param3.toString());
         }
         this.copyRectTexture(param1,param2,param3,param5);
         if(param4)
         {
            return CGlobeFuncUtil.copyTexture(this.rectImgLib.Get(param2 + param3.toString()),param5);
         }
         return this.rectImgLib.Get(param2 + param3.toString());
      }
      
      public function copyRectTexture(param1:String, param2:String, param3:RectangleKit, param4:String = null) : void
      {
         var _loc5_:Bitmap = this.getImage(param1,param2);
         var _loc6_:BitmapData = new BitmapData(param3.width,param3.height);
         _loc6_.copyPixels(_loc5_.bitmapData,new Rectangle(param3.x,param3.y,param3.width,param3.height),new Point(0,0));
         var _loc7_:Bitmap = new Bitmap(_loc6_);
         _loc7_.smoothing = true;
         if(param4)
         {
            _loc7_.name = param4;
         }
         this.rectImgLib.Put(param2 + param3.toString(),_loc7_);
      }
      
      public function getTexture(param1:String, param2:String, param3:Boolean = false) : Bitmap
      {
         if(param3)
         {
            return CGlobeFuncUtil.copyTexture(this.getImage(param1,param2));
         }
         return this.getImage(param1,param2);
      }
      
      public function IsExists(param1:String) : Boolean
      {
         return this.resLib.ContainsKey(param1);
      }
      
      public function getRes(param1:String) : *
      {
         if(!this.resLib.ContainsKey(param1))
         {
            throw new CError("无法找到指定特效文件" + param1);
         }
         return this.resLib.Get(param1);
      }
      
      public function getFont(param1:String, param2:String) : *
      {
         return this.resLib.Get(param1).getFont(param2);
      }
   }
}

