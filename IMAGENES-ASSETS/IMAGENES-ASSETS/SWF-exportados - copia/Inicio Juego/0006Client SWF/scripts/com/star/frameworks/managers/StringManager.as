package com.star.frameworks.managers
{
   import logic.game.GameKernel;
   
   public class StringManager
   {
      
      private static var messageArr:Array;
      
      private static var instance:StringManager;
      
      public function StringManager()
      {
         var _loc2_:XML = null;
         var _loc3_:String = null;
         super();
         var _loc1_:XML = ResManager.getInstance().getXml(ResManager.GAMERES,"Message");
         _loc1_.ignoreWhite = false;
         messageArr = new Array();
         for each(_loc2_ in _loc1_.*)
         {
            _loc3_ = String(_loc2_);
            messageArr[_loc2_.@id] = _loc3_.replace(/\^/g," ");
         }
         GameKernel.resManager.removeXML(ResManager.GAMERES,"Message");
      }
      
      public static function getInstance() : StringManager
      {
         if(instance == null)
         {
            instance = new StringManager();
         }
         return instance;
      }
      
      public static function wrapperString(param1:String, param2:String = null) : String
      {
         if(param2 == null)
         {
            return param1;
         }
         return "<font color=\'" + param2 + "\'>" + param1 + "</font>";
      }
      
      public function getMessageString(param1:String) : String
      {
         if(messageArr[param1] == null)
         {
            return "";
         }
         return messageArr[param1];
      }
   }
}

