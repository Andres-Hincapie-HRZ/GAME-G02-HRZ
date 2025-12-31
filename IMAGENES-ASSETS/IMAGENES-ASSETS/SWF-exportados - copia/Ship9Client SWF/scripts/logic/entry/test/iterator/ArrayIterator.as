package logic.entry.test.iterator
{
   public class ArrayIterator implements IIterator
   {
      
      private var _first:uint = 0;
      
      private var _end:uint = 0;
      
      private var _index:uint = 0;
      
      private var _collection:Array;
      
      public function ArrayIterator(param1:Array)
      {
         super();
         this._collection = param1;
         this._index = 0;
         this._end = param1.length;
      }
      
      public function hasNext() : Boolean
      {
         return this._index < this._end;
      }
      
      public function next() : Object
      {
         var _loc1_:Object = this._collection[this._index];
         ++this._index;
         return _loc1_;
      }
      
      public function reset() : void
      {
         this._index = 0;
      }
      
      public function get end() : uint
      {
         return this._end;
      }
      
      public function get first() : uint
      {
         return this._first;
      }
      
      public function get index() : uint
      {
         return this._index;
      }
   }
}

