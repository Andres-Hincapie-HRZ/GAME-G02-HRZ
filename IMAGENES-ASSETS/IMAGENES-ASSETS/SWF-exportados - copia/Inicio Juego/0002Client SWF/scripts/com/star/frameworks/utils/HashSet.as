package com.star.frameworks.utils
{
   import flash.utils.Dictionary;
   
   public class HashSet
   {
      
      private var length:int = 0;
      
      private var content:Dictionary = null;
      
      public function HashSet(param1:Boolean = true)
      {
         super();
         this.content = new Dictionary(param1);
      }
      
      public function Length() : int
      {
         return this.length;
      }
      
      public function isEmpty() : Boolean
      {
         return this.length == 0;
      }
      
      public function Keys() : Array
      {
         var _loc3_:* = undefined;
         var _loc1_:Array = new Array(this.length);
         var _loc2_:int = 0;
         for(_loc3_ in this.content)
         {
            _loc1_[_loc2_] = _loc3_;
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function Values() : Array
      {
         var _loc3_:* = undefined;
         var _loc1_:Array = new Array(this.length);
         var _loc2_:int = 0;
         for each(_loc3_ in this.content)
         {
            _loc1_[_loc2_] = _loc3_;
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function ContainsKey(param1:*) : Boolean
      {
         if(this.content[param1] != undefined)
         {
            return true;
         }
         return false;
      }
      
      public function Get(param1:*) : *
      {
         var _loc2_:* = this.content[param1];
         if(_loc2_ != undefined)
         {
            return _loc2_;
         }
         return null;
      }
      
      public function GetValue(param1:*) : *
      {
         return this.content[param1];
      }
      
      public function Put(param1:*, param2:*) : *
      {
         var _loc3_:Boolean = false;
         var _loc4_:* = undefined;
         if(param1 == null)
         {
            throw new ArgumentError("cannot put a value with undefined or null key!");
         }
         if(param2 == null)
         {
            return this.Remove(param1);
         }
         _loc3_ = this.ContainsKey(param1);
         if(!_loc3_)
         {
            ++this.length;
         }
         _loc4_ = this.Get(param1);
         this.content[param1] = param2;
         return _loc4_;
      }
      
      public function Remove(param1:*) : *
      {
         var _loc2_:Boolean = this.ContainsKey(param1);
         if(!_loc2_)
         {
            return null;
         }
         delete this.content[param1];
         param1 = null;
         --this.length;
      }
      
      public function Clear() : void
      {
         this.length = 0;
         this.content = new Dictionary();
      }
      
      public function Clone() : HashSet
      {
         var _loc2_:* = undefined;
         var _loc1_:HashSet = new HashSet();
         for(_loc2_ in this.content)
         {
            _loc1_.Put(_loc2_,this.content[_loc2_]);
         }
         return _loc1_;
      }
      
      public function toString() : String
      {
         var _loc1_:Array = this.Keys();
         var _loc2_:Array = this.Values();
         var _loc3_:String = "HaseSet Content:\n";
         var _loc4_:int = 0;
         while(_loc4_ < _loc1_.length)
         {
            _loc3_ += _loc1_[_loc4_] + " -> " + _loc2_[_loc4_] + "\n";
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function removeAll() : void
      {
         var _loc2_:* = undefined;
         if(this.isEmpty())
         {
            return;
         }
         var _loc1_:Array = this.Keys();
         for each(_loc2_ in _loc1_)
         {
            this.Remove(_loc2_);
            _loc2_ = null;
         }
      }
   }
}

