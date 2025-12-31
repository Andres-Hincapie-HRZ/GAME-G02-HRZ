package logic.ui
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Point;
   import gs.TweenLite;
   import gs.easing.Linear;
   
   public class MapShowAnimation
   {
      
      private static var _instance:MapShowAnimation;
      
      public function MapShowAnimation()
      {
         super();
      }
      
      public static function GetInstance() : MapShowAnimation
      {
         if(_instance == null)
         {
            _instance = new MapShowAnimation();
         }
         return _instance;
      }
      
      public function ShowMap(param1:Bitmap, param2:int, param3:Function = null, param4:* = null) : void
      {
         var _loc5_:MapShowAnimationInfo = new MapShowAnimationInfo();
         _loc5_.SourceBitmap = param1;
         _loc5_.OnShowOver = param3;
         _loc5_.Sender = param4;
         this.AddAnimationBitmap(_loc5_);
         _loc5_.AnimationBitmap.alpha = 0;
         TweenLite.to(_loc5_.AnimationBitmap,param2,{
            "alpha":1,
            "ease":Linear,
            "onComplete":this.ShowMapCompleted,
            "onCompleteParams":[_loc5_]
         });
      }
      
      public function ThrowMap(param1:Bitmap, param2:Sprite, param3:int, param4:int, param5:int, param6:Function = null, param7:* = null) : void
      {
         param1.visible = false;
         var _loc8_:MapShowAnimationInfo = new MapShowAnimationInfo();
         _loc8_.SourceBitmap = param1;
         _loc8_.AnimationBitmap = new Bitmap(_loc8_.SourceBitmap.bitmapData);
         var _loc9_:Point = param1.parent.localToGlobal(new Point(param1.x,param1.y));
         _loc9_ = param2.globalToLocal(_loc9_);
         _loc8_.AnimationBitmap.x = _loc9_.x;
         _loc8_.AnimationBitmap.y = _loc9_.y;
         param2.addChild(_loc8_.AnimationBitmap);
         TweenLite.to(_loc8_.AnimationBitmap,param3,{
            "alpha":0,
            "x":param4,
            "y":param5,
            "ease":Linear,
            "onComplete":this.ThrowMapCompleted,
            "onCompleteParams":[_loc8_]
         });
      }
      
      public function RemoveMap(param1:Bitmap, param2:Sprite, param3:int, param4:int, param5:Function = null, param6:* = null) : void
      {
         param1.visible = false;
         var _loc7_:MapShowAnimationInfo = new MapShowAnimationInfo();
         _loc7_.SourceBitmap = param1;
         _loc7_.AnimationBitmap = new Bitmap(_loc7_.SourceBitmap.bitmapData);
         var _loc8_:Point = param1.parent.localToGlobal(new Point(param1.x,param1.y));
         _loc8_ = param2.globalToLocal(_loc8_);
         _loc7_.AnimationBitmap.x = _loc8_.x;
         _loc7_.AnimationBitmap.y = _loc8_.y;
         param2.addChild(_loc7_.AnimationBitmap);
         var _loc9_:int = _loc7_.AnimationBitmap.x - _loc7_.AnimationBitmap.width / 2;
         var _loc10_:int = _loc7_.AnimationBitmap.y - _loc7_.AnimationBitmap.height / 2;
         TweenLite.to(_loc7_.AnimationBitmap,param3,{
            "alpha":0,
            "x":_loc9_,
            "y":_loc10_,
            "scaleX":2,
            "scaleY":2,
            "ease":Linear,
            "onComplete":this.ThrowMapCompleted,
            "onCompleteParams":[_loc7_]
         });
      }
      
      private function ThrowMapCompleted(param1:MapShowAnimationInfo) : void
      {
         if(param1.AnimationBitmap.parent != null)
         {
            param1.AnimationBitmap.parent.removeChild(param1.AnimationBitmap);
         }
         if(param1.OnShowOver != null)
         {
            param1.OnShowOver(param1.Sender);
         }
      }
      
      private function ShowMapCompleted(param1:MapShowAnimationInfo) : void
      {
         param1.SourceBitmap.visible = true;
         if(param1.AnimationBitmap.parent != null)
         {
            param1.AnimationBitmap.parent.removeChild(param1.AnimationBitmap);
         }
         if(param1.OnShowOver != null)
         {
            param1.OnShowOver(param1.Sender);
         }
      }
      
      private function AddAnimationBitmap(param1:MapShowAnimationInfo) : void
      {
         param1.AnimationBitmap = new Bitmap();
         param1.AnimationBitmap.bitmapData = param1.SourceBitmap.bitmapData;
         param1.AnimationBitmap.filters = param1.SourceBitmap.filters;
         param1.SourceBitmap.visible = false;
         param1.AnimationBitmap.width = param1.SourceBitmap.width;
         param1.AnimationBitmap.height = param1.SourceBitmap.height;
         param1.AnimationBitmap.x = param1.SourceBitmap.x;
         param1.AnimationBitmap.y = param1.SourceBitmap.y;
         param1.SourceBitmap.parent.addChild(param1.AnimationBitmap);
      }
   }
}

