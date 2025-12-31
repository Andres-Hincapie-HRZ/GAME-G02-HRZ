package com.star.frameworks.stl
{
   import com.star.frameworks.utils.ObjectUtil;
   
   public class QueueList
   {
      
      private var length:int;
      
      private var list:Array;
      
      public function QueueList()
      {
         super();
         this.length = 0;
         this.list = new Array();
      }
      
      public function Length() : int
      {
         return this.length;
      }
      
      public function Push(param1:*) : *
      {
         if(param1 == null)
         {
            return null;
         }
         this.list.push(param1);
         ++this.length;
         return param1;
      }
      
      public function toArray() : Array
      {
         return this.list;
      }
      
      public function Merger(param1:QueueList) : void
      {
      }
      
      public function Pop() : *
      {
         if(this.length == 0)
         {
            return;
         }
         var _loc1_:* = this.list.splice(0,1);
         --this.length;
         return _loc1_;
      }
      
      public function Clear() : void
      {
         ObjectUtil.ClearArray(this.list);
      }
      
      public function toString() : String
      {
         var _loc1_:String = "QueueList Content:\n";
         var _loc2_:int = 0;
         while(_loc2_ < this.list.length)
         {
            _loc1_ += this.list[_loc2_] + "\n";
            _loc2_++;
         }
         return _loc1_;
      }
   }
}

