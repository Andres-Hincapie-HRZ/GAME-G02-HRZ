package net.base
{
   import flash.utils.ByteArray;
   
   public interface iMsgSocket
   {
      
      function readData(param1:Object, param2:ByteArray) : int;
      
      function sendData(param1:Object, param2:ByteArray) : void;
   }
}

