package net.msg.constructionMsg
{
   import net.common.MsgHead;
   import net.common.MsgTypes;
   import net.common.iMsgHead;
   
   public class MSG_RESP_CREATEBUILD extends MsgHead implements iMsgHead
   {
      
      private static var varList:Array = new Array();
      
      public var BuildingId:int;
      
      public var LevelId:int;
      
      public var IndexId:int;
      
      public var NeedTime:int;
      
      public var Gas:int;
      
      public var Metal:int;
      
      public var Money:int;
      
      public function MSG_RESP_CREATEBUILD()
      {
         super();
         if(varList.length == 0)
         {
            this.pushField("BuildingId","4");
            this.pushField("LevelId","4");
            this.pushField("IndexId","4");
            this.pushField("NeedTime","4");
            this.pushField("Gas","4");
            this.pushField("Metal","4");
            this.pushField("Money","4");
            getVarType(this);
         }
         usType = MsgTypes._MSG_RESP_CREATEBUILD;
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

