package net.msg.constructionMsg
{
   import com.star.frameworks.net.MsgTypes;
   import net.common.MsgHead;
   import net.common.iMsgHead;
   
   public class MSG_REQUEST_CREATEBUILD extends MsgHead implements iMsgHead
   {
      
      private static var varList:Array = new Array();
      
      public var seqId:int;
      
      public var Guid:int;
      
      public var BuilingId:int;
      
      public var IndexId:int;
      
      public var posX:int;
      
      public var posY:int;
      
      public function MSG_REQUEST_CREATEBUILD()
      {
         super();
         if(varList.length == 0)
         {
            this.pushField("seqId","4");
            this.pushField("Guid","4");
            this.pushField("BuilingId","4");
            this.pushField("IndexId","4");
            this.pushField("posX","2");
            this.pushField("posY","2");
            getVarType(this);
         }
         usType = MsgTypes._MSG_REQUEST_CREATEBUILD;
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

