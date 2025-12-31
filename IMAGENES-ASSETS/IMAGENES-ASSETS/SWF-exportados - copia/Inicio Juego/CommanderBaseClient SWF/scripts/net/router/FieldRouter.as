package net.router
{
   import flash.utils.ByteArray;
   import logic.ui.FieldUI;
   import logic.ui.FieldUI_DomainPop;
   import net.base.NetManager;
   import net.msg.field.MSG_RESP_FIELDRESOURCE;
   import net.msg.field.MSG_RESP_FIELDRESOURCELOG;
   import net.msg.field.MSG_RESP_FRIENDFIELDSTATUS;
   import net.msg.field.MSG_RESP_GETFIELDRESOURCE;
   import net.msg.field.MSG_RESP_GROWFIELDRESOURCE;
   import net.msg.field.MSG_RESP_HELPFIELDCENTERRESOURCE;
   import net.msg.field.MSG_RESP_THIEVEFIELDRESOURCE;
   
   public class FieldRouter
   {
      
      private static var _instance:FieldRouter;
      
      public function FieldRouter()
      {
         super();
      }
      
      public static function get instance() : FieldRouter
      {
         if(_instance == null)
         {
            _instance = new FieldRouter();
         }
         return _instance;
      }
      
      public function resp_MSG_RESP_FIELDRESOURCE(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_FIELDRESOURCE = new MSG_RESP_FIELDRESOURCE();
         NetManager.Instance().readObject(_loc4_,param3);
         FieldUI.getInstance().RespFieldInfo(_loc4_);
      }
      
      public function resp_MSG_RESP_GROWFIELDRESOURCE(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_GROWFIELDRESOURCE = new MSG_RESP_GROWFIELDRESOURCE();
         NetManager.Instance().readObject(_loc4_,param3);
         FieldUI.getInstance().RespGrowField(_loc4_);
      }
      
      public function resp_MSG_RESP_GETFIELDRESOURCE(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_GETFIELDRESOURCE = new MSG_RESP_GETFIELDRESOURCE();
         NetManager.Instance().readObject(_loc4_,param3);
         FieldUI.getInstance().RespGetField(_loc4_);
      }
      
      public function resp_MSG_RESP_THIEVEFIELDRESOURCE(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_THIEVEFIELDRESOURCE = new MSG_RESP_THIEVEFIELDRESOURCE();
         NetManager.Instance().readObject(_loc4_,param3);
         FieldUI.getInstance().RespThieveField(_loc4_);
      }
      
      public function resp_MSG_RESP_FIELDRESOURCELOG(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_FIELDRESOURCELOG = new MSG_RESP_FIELDRESOURCELOG();
         NetManager.Instance().readObject(_loc4_,param3);
         FieldUI_DomainPop.getInstance().ShowFieldLog(_loc4_);
      }
      
      public function resp_MSG_RESP_HELPFIELDCENTERRESOURCE(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_HELPFIELDCENTERRESOURCE = new MSG_RESP_HELPFIELDCENTERRESOURCE();
         NetManager.Instance().readObject(_loc4_,param3);
         FieldUI.getInstance().RespHelp(_loc4_);
      }
      
      public function resp_MSG_RESP_FRIENDFIELDSTATUS(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_FRIENDFIELDSTATUS = new MSG_RESP_FRIENDFIELDSTATUS();
         NetManager.Instance().readObject(_loc4_,param3);
         FieldUI.getInstance().RespFriendFieldStatus(_loc4_);
      }
   }
}

