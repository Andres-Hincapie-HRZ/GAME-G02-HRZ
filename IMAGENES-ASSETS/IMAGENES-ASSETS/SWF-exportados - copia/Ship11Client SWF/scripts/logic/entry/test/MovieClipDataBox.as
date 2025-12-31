package logic.entry.test
{
   import com.star.frameworks.utils.HashSet;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import logic.entry.HButton;
   
   public class MovieClipDataBox
   {
      
      private static var mc:MovieClip;
      
      private static var tf:TextField;
      
      private var childrenNames:HashSet = null;
      
      private var hbuttons:HashSet = null;
      
      public function MovieClipDataBox(param1:MovieClip = null, param2:Boolean = false)
      {
         super();
         this.childrenNames = new HashSet();
         this.hbuttons = new HashSet();
         if(param1)
         {
            this.Initialize(param1,param2);
         }
      }
      
      public function Initialize(param1:MovieClip, param2:Boolean = false) : void
      {
         var _loc4_:* = undefined;
         var _loc5_:HButton = null;
         var _loc3_:int = 0;
         while(_loc3_ < param1.numChildren)
         {
            _loc4_ = param1.getChildAt(_loc3_);
            if(_loc4_ is MovieClip)
            {
               mc = _loc4_ as MovieClip;
               mc.stop();
               if(param2)
               {
                  _loc5_ = new HButton(mc);
                  this.hbuttons.Put(mc.name,_loc5_);
               }
               this.childrenNames.Put(mc.name,mc);
               this.Initialize(mc);
            }
            else if(_loc4_ is TextField)
            {
               tf = _loc4_ as TextField;
               this.childrenNames.Put(tf.name,tf);
            }
            _loc3_++;
         }
      }
      
      public function contains(param1:String) : Boolean
      {
         return this.childrenNames.ContainsKey(param1);
      }
      
      public function keys() : Array
      {
         return this.childrenNames.Keys();
      }
      
      public function values() : Array
      {
         return this.childrenNames.Values();
      }
      
      public function length() : int
      {
         return this.childrenNames.Length();
      }
      
      public function getTF(param1:String) : TextField
      {
         if(this.contains(param1))
         {
            return this.childrenNames.Get(param1) as TextField;
         }
         return null;
      }
      
      public function getMC(param1:String) : MovieClip
      {
         if(this.contains(param1))
         {
            return this.childrenNames.Get(param1) as MovieClip;
         }
         return null;
      }
      
      public function getHBtn(param1:String) : HButton
      {
         if(this.hbuttons.ContainsKey(param1))
         {
            return this.hbuttons.Get(param1) as HButton;
         }
         return null;
      }
   }
}

