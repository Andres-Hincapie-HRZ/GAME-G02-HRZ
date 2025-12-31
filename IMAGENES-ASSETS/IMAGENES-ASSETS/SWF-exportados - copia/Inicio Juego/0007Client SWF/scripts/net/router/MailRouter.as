package net.router
{
   import flash.utils.ByteArray;
   import logic.ui.MailUI_Detail;
   import logic.ui.MailUI_Inbox;
   import logic.widget.NotifyWidget;
   import net.base.NetManager;
   import net.msg.mail.MSG_RESP_EMAILGOODS;
   import net.msg.mail.MSG_RESP_EMAILINFO;
   import net.msg.mail.MSG_RESP_NEWEMAILNOTICE;
   import net.msg.mail.MSG_RESP_READEMAIL;
   
   public class MailRouter
   {
      
      private static var _instance:MailRouter;
      
      public function MailRouter()
      {
         super();
      }
      
      public static function get instance() : MailRouter
      {
         if(_instance == null)
         {
            _instance = new MailRouter();
         }
         return _instance;
      }
      
      public function resp_MSG_RESP_EMAILINFO(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_EMAILINFO = new MSG_RESP_EMAILINFO();
         NetManager.Instance().readObject(_loc4_,param3);
         MailUI_Inbox.getInstance().OnReceiveMail(_loc4_);
      }
      
      public function resp_MSG_RESP_READEMAIL(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_READEMAIL = new MSG_RESP_READEMAIL();
         NetManager.Instance().readObject(_loc4_,param3);
         MailUI_Detail.getInstance().OnGetDetail(_loc4_);
      }
      
      public function resp_MSG_RESP_EMAILGOODS(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_EMAILGOODS = new MSG_RESP_EMAILGOODS();
         NetManager.Instance().readObject(_loc4_,param3);
         MailUI_Detail.getInstance().OnReceiveGoods(_loc4_);
      }
      
      public function resp_MSG_RESP_NEWEMAILNOTICE(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_NEWEMAILNOTICE = new MSG_RESP_NEWEMAILNOTICE();
         NetManager.Instance().readObject(_loc4_,param3);
         NotifyWidget.getInstance().addNotify(0);
      }
   }
}

