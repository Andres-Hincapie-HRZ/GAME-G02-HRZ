package net.msg
{
   import net.common.MsgHead;
   import net.common.MsgTypes;
   import net.common.iMsgHead;
   
   public class MSG_REQUEST_CREATEROLEINFO extends MsgHead implements iMsgHead
   {
      
      private static var varList:Array = new Array();
      
      public var SeqId:int;
      
      public var Guid:int;
      
      public var Name:String;
      
      public var roleHeadID:int;
      
      public function MSG_REQUEST_CREATEROLEINFO()
      {
         super();
         if(varList.length == 0)
         {
            this.pushField("SeqId","4");
            this.pushField("Guid","4");
            this.pushField("Name",MsgTypes.MAX_NAME + "");
            this.pushField("roleHeadID","4");
            getVarType(this);
         }
         usType = MsgTypes._MSG_REQUEST_CREATEROLE;
         usSize = getObjectLen(this);
      }
      
      public function get varlist() : Array
      {
         return varList;
      }
      
      override public function pushField(param1:String, param2:String, param3:Array = null) : void
      {
         super.pushField(param1,param2,varList);
      }
   }
}

