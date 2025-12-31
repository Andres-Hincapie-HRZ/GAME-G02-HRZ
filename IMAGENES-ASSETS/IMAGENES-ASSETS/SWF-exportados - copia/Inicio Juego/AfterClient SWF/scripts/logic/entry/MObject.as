package logic.entry
{
   import com.star.frameworks.display.Container;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import logic.game.GameKernel;
   
   public class MObject extends Container
   {
      
      public var objects:Array;
      
      protected var cacheAs:Boolean;
      
      public var args:String;
      
      public var newObjects:Array;
      
      protected var _priority:int;
      
      protected var _Mc:MovieClip;
      
      public function MObject(param1:String = null, param2:int = 0, param3:int = 0, param4:Boolean = false)
      {
         super();
         this.objects = new Array();
         this.newObjects = new Array();
         this.mouseEnabled = true;
         if(param1)
         {
            this.args = this.name = param1;
            this._Mc = GameKernel.getMovieClipInstance(param1,param2,param3,this.cacheAs);
            if(this._Mc != null)
            {
               this._Mc.cacheAsBitmap = param4;
               this._Mc.mouseEnabled = false;
               this._Mc.tabChildren = false;
               this._Mc.tabEnabled = false;
               addChild(this._Mc);
            }
         }
      }
      
      public function addObject(param1:MObject) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         if(param1 != null)
         {
            if(this.newObjects.indexOf(param1) == -1)
            {
               if(param1.parent != null && param1.parent is MObject)
               {
                  MObject(param1.parent).removeObject(param1);
               }
               while(_loc3_ <= this.newObjects.length)
               {
                  if(this.newObjects[_loc3_] == null)
                  {
                     _loc2_ = true;
                     break;
                  }
                  if(param1._priority < this.newObjects[_loc3_]._priority)
                  {
                     addChildAt(param1,getChildIndex(this.newObjects[_loc3_]));
                     this.newObjects.splice(_loc3_,0,param1);
                     _loc2_ = true;
                     break;
                  }
                  _loc3_++;
               }
               if(_loc2_)
               {
                  this.newObjects.push(param1);
                  addChild(param1);
               }
            }
         }
      }
      
      public function getObject(param1:String) : MObject
      {
         return getChildByName(param1) as MObject;
      }
      
      public function gotoAndPlayFrame(param1:Object) : void
      {
         if(this._Mc != null)
         {
            this._Mc.model.gotoAndPlay(param1);
         }
      }
      
      public function gotoAndStopFrame(param1:Object) : void
      {
         if(this._Mc != null)
         {
            this._Mc.gotoAndStop(param1);
         }
      }
      
      public function stop() : void
      {
         if(this._Mc != null)
         {
            this._Mc.stop();
         }
      }
      
      public function removeMc() : void
      {
         if(this._Mc != null)
         {
            this._Mc.stop();
            removeChild(this._Mc);
         }
      }
      
      public function removeObject(param1:MObject) : void
      {
         var _loc2_:int = 0;
         if(param1 != null)
         {
            _loc2_ = int(this.newObjects.indexOf(param1));
            if(_loc2_ != -1)
            {
               this.newObjects.splice(_loc2_,1);
               if(param1.parent != null && param1.parent == this)
               {
                  removeChild(param1);
                  param1 = null;
               }
            }
         }
      }
      
      public function getChildMcInstance(param1:String) : MovieClip
      {
         if(this._Mc != null)
         {
            return this._Mc[param1] as MovieClip;
         }
         return null;
      }
      
      public function getChildTFInstance(param1:String) : TextField
      {
         if(this._Mc != null)
         {
            return TextField(this._Mc[param1]);
         }
         return null;
      }
      
      public function set Priority(param1:int) : void
      {
         if(this._priority != param1)
         {
            this._priority = param1;
            if(parent != null && parent is MObject)
            {
               MObject(parent).Sort(this);
            }
         }
      }
      
      public function get Priority() : int
      {
         return this._priority;
      }
      
      private function Sort(param1:MObject) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(param1.parent == this)
         {
            _loc2_ = int(this.newObjects.indexOf(param1));
            if(_loc2_ != -1)
            {
               removeChild(param1);
               this.newObjects.splice(_loc2_,1);
               _loc3_ = 0;
               while(_loc3_++ < this.newObjects.length)
               {
                  if(param1.Priority < this.newObjects[_loc3_].Priority && contains(this.newObjects[_loc3_]))
                  {
                     addChildAt(param1,getChildIndex(this.newObjects[_loc3_]));
                     this.newObjects.splice(_loc3_,0,param1);
                     break;
                  }
               }
               if(_loc3_ >= this.newObjects.length)
               {
                  this.newObjects.push(param1);
                  addChild(param1);
               }
            }
         }
      }
      
      public function getMC() : MovieClip
      {
         return this._Mc;
      }
      
      public function Clone() : MObject
      {
         return new MObject(this.args,x,y,this.cacheAs);
      }
   }
}

