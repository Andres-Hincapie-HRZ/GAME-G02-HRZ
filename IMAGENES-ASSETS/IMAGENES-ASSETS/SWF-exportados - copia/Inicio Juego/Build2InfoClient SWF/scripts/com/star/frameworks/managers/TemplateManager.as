package com.star.frameworks.managers
{
   import com.star.frameworks.utils.HashSet;
   
   public class TemplateManager
   {
      
      private static var instance:TemplateManager = null;
      
      private var listCellLib:HashSet;
      
      private var basicUILib:HashSet;
      
      private var wndUILib:HashSet;
      
      public function TemplateManager()
      {
         super();
         this.listCellLib = new HashSet();
         this.basicUILib = new HashSet();
         this.wndUILib = new HashSet();
      }
      
      public static function getInstance() : TemplateManager
      {
         if(instance == null)
         {
            instance = new TemplateManager();
         }
         return instance;
      }
      
      public function getListCellLib() : HashSet
      {
         return this.listCellLib;
      }
      
      public function getBasicUILib() : HashSet
      {
         return this.basicUILib;
      }
      
      public function getWndUILib() : HashSet
      {
         return this.wndUILib;
      }
   }
}

