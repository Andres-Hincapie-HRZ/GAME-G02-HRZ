package com.star.frameworks.utils
{
   import flash.utils.Dictionary;
   
   public class HashSet
   {
      
      private var length:int = 0;
      
      private var content:Dictionary = null;
      
      public function HashSet(bool:Boolean = true)
      {
         super();
         this.content = new Dictionary(bool);
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
         var i:* = undefined;
         var temp:Array = new Array(this.length);
         var index:int = 0;
         for(i in this.content)
         {
            temp[index] = i;
            index++;
         }
         return temp;
      }
      
      public function Values() : Array
      {
         var i:* = undefined;
         var temp:Array = new Array(this.length);
         var index:int = 0;
         for each(i in this.content)
         {
            temp[index] = i;
            index++;
         }
         return temp;
      }
      
      public function ContainsKey(key:*) : Boolean
      {
         if(this.content[key] != undefined)
         {
            return true;
         }
         return false;
      }
      
      public function Get(key:*) : *
      {
         var value:* = this.content[key];
         if(value != undefined)
         {
            return value;
         }
         return null;
      }
      
      public function GetValue(key:*) : *
      {
         return this.Get(key);
      }
      
      public function Put(key:*, value:*) : *
      {
         var exists:Boolean = false;
         var oldValue:* = undefined;
         if(key == null)
         {
            throw new ArgumentError("cannot put a value with undefined or null key!");
         }
         if(value == null)
         {
            return this.Remove(key);
         }
         exists = this.ContainsKey(key);
         if(!exists)
         {
            ++this.length;
         }
         oldValue = this.Get(key);
         this.content[key] = value;
         return oldValue;
      }
      
      public function Remove(key:*) : *
      {
         var exist:Boolean = this.ContainsKey(key);
         if(!exist)
         {
            return null;
         }
         delete this.content[key];
         key = null;
         --this.length;
      }
      
      public function Clear() : void
      {
         this.length = 0;
         this.content = new Dictionary();
      }
      
      public function Clone() : HashSet
      {
         var i:* = undefined;
         var temp:HashSet = new HashSet();
         for(i in this.content)
         {
            temp.Put(i,this.content[i]);
         }
         return temp;
      }
      
      public function toString() : String
      {
         var ks:Array = this.Keys();
         var vs:Array = this.Values();
         var temp:String = "HaseSet Content:\n";
         for(var i:int = 0; i < ks.length; i++)
         {
            temp += ks[i] + " -> " + vs[i] + "\n";
         }
         return temp;
      }
      
      public function removeAll() : void
      {
         var i:* = undefined;
         if(this.isEmpty())
         {
            return;
         }
         var keyArray:Array = this.Keys();
         for each(i in keyArray)
         {
            this.Remove(i);
            i = null;
         }
      }
   }
}

