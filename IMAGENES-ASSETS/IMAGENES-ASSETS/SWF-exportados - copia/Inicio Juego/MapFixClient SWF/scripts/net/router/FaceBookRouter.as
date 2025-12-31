package net.router
{
   import flash.utils.ByteArray;
   import logic.action.FaceBookAction;
   import net.base.NetManager;
   import net.msg.facebook.MSG_RESP_FRIENDINFO;
   
   public class FaceBookRouter
   {
      
      private static var instance:FaceBookRouter;
      
      public function FaceBookRouter()
      {
         super();
      }
      
      public static function getInstance() : FaceBookRouter
      {
         if(instance == null)
         {
            instance = new FaceBookRouter();
         }
         return instance;
      }
      
      public function resp_MSG_FACEBOOKINFO(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_FRIENDINFO = new MSG_RESP_FRIENDINFO();
         NetManager.Instance().readObject(_loc4_,param3);
         FaceBookAction.getInstance().resp_Msg_FaceBookInfo(_loc4_);
      }
   }
}

