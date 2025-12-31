package net.common
{
   public interface iMsgHead
   {
      
      function pushField(param1:String, param2:String, param3:Array = null) : void;
      
      function getObjectLen(param1:Object) : int;
      
      function getVarType(param1:*) : void;
      
      function setVarType(param1:Object) : void;
   }
}

