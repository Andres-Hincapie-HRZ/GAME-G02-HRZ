package net.router
{
   import flash.utils.ByteArray;
   import logic.action.ActionModuleDefined;
   import logic.action.ChatAction;
   import logic.manager.GameModuleActionManager;
   import net.base.NetManager;
   import net.msg.chatMsg.MSG_CHAT_MESSAGE;
   import net.msg.chatMsg.MSG_RESP_GALAXYBROADCAST;
   import net.msg.chatMsg.MSG_RESP_USERINFO;
   
   public class ChatRouter
   {
      
      private static var instance:ChatRouter;
      
      public function ChatRouter()
      {
         super();
      }
      
      public static function getInstance() : ChatRouter
      {
         if(instance == null)
         {
            instance = new ChatRouter();
         }
         return instance;
      }
      
      public function resp_Msg_ChatMessage(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_CHAT_MESSAGE = new MSG_CHAT_MESSAGE();
         NetManager.Instance().readObject(_loc4_,param3);
         ChatAction(GameModuleActionManager.getModuleInstance(ActionModuleDefined.Chat_action)).RESP_MSG_CHATMESSAGE(_loc4_);
      }
      
      public function resp_Msg_UserInfo(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_USERINFO = new MSG_RESP_USERINFO();
         NetManager.Instance().readObject(_loc4_,param3);
         ChatAction(GameModuleActionManager.getModuleInstance(ActionModuleDefined.Chat_action)).resp_Msg_UserInfo(_loc4_);
      }
      
      public function resp_Msg_GALAXYBROADCAST(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_GALAXYBROADCAST = new MSG_RESP_GALAXYBROADCAST();
         NetManager.Instance().readObject(_loc4_,param3);
         ChatAction(GameModuleActionManager.getModuleInstance(ActionModuleDefined.Chat_action)).RESP_MSG_GALAXYBROADCAST(_loc4_);
      }
   }
}

