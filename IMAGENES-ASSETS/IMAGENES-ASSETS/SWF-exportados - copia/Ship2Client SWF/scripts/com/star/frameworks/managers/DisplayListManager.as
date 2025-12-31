package com.star.frameworks.managers
{
   import com.star.frameworks.utils.HashSet;
   
   public class DisplayListManager
   {
      
      private static var instance:DisplayListManager = null;
      
      private var displayList:HashSet;
      
      public function DisplayListManager()
      {
         super();
         this.displayList = new HashSet();
      }
      
      public static function getInstance() : DisplayListManager
      {
         if(instance == null)
         {
            instance = new DisplayListManager();
         }
         return instance;
      }
      
      public function getDisplayList() : HashSet
      {
         return this.displayList;
      }
      
      public function addDisplayList(param1:String, param2:*) : void
      {
         if(this.displayList.ContainsKey(param1))
         {
            return;
         }
         this.displayList.Put(param1,param2);
      }
      
      public function getDisplayItem(param1:String) : *
      {
         return this.displayList.Get(param1);
      }
      
      public function removeItem(param1:String) : void
      {
         if(Boolean(this.displayList.Length()) && this.displayList.ContainsKey(param1))
         {
            this.displayList.Remove(param1);
         }
      }
      
      public function clearDisplayList() : void
      {
         if(this.displayList.Length())
         {
            this.displayList.removeAll();
         }
      }
   }
}

