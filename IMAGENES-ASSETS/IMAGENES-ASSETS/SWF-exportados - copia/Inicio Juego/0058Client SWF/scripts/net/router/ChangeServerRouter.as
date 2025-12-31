package net.router
{
   import flash.utils.ByteArray;
   import logic.ui.ChangeServerUI;
   import net.base.NetManager;
   import net.msg.MSG_RESP_CHANGESERVER;
   import net.msg.MSG_RESP_DELETESERVER;
   import net.msg.MSG_RESP_GAMESERVERLIST;
   
   public class ChangeServerRouter
   {
      
      private static var _instance:ChangeServerRouter;
      
      public function ChangeServerRouter()
      {
         super();
      }
      
      public static function get instance() : ChangeServerRouter
      {
         if(_instance == null)
         {
            _instance = new ChangeServerRouter();
         }
         return _instance;
      }
      
      public function resp_MSG_RESP_GAMESERVERLIST(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_GAMESERVERLIST = new MSG_RESP_GAMESERVERLIST();
         NetManager.Instance().readObject(_loc4_,param3);
         ChangeServerUI.getInstance().RespServerList(_loc4_);
      }
      
      public function resp_MSG_RESP_CHANGESERVER(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_CHANGESERVER = new MSG_RESP_CHANGESERVER();
         NetManager.Instance().readObject(_loc4_,param3);
         ChangeServerUI.getInstance().RespChangeServer(_loc4_);
      }
      
      public function Resp_MSG_RESP_DELETESERVER(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_DELETESERVER = new MSG_RESP_DELETESERVER();
         NetManager.Instance().readObject(_loc4_,param3);
         ChangeServerUI.getInstance().Resp_MSG_RESP_DELETESERVER(_loc4_);
      }
   }
}

