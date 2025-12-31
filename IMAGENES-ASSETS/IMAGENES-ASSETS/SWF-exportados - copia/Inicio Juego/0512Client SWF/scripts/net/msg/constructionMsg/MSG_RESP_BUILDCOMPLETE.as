package net.msg.constructionMsg
{
   import com.star.frameworks.net.MsgTypes;
   import net.common.MsgHead;
   import net.common.iMsgHead;
   
   public class MSG_RESP_BUILDCOMPLETE extends MsgHead implements iMsgHead
   {
      
      private static var varList:Array = new Array();
      
      public var GalaxyMapId:int;
      
      public var GalaxyId:int;
      
      public var IndexId:int;
      
      public function MSG_RESP_BUILDCOMPLETE()
      {
         super();
         if(varList.length == 0)
         {
            this.pushField("GalaxyMapId","4");
            this.pushField("GalaxyId","4");
            this.pushField("IndexId","4");
            getVarType(this);
         }
         usType = MsgTypes._MSG_RESP_BUILDCOMPLETE;
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

