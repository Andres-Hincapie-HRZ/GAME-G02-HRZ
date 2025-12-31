package net.router
{
   import com.star.frameworks.managers.StringManager;
   import flash.utils.ByteArray;
   import logic.ui.FieldUI;
   import logic.ui.FriendsListUI;
   import logic.ui.InvitePopupUI;
   import logic.ui.MailUI_Friends;
   import logic.ui.MessagePopup;
   import net.base.NetManager;
   import net.msg.friend.MSG_RESP_ADDFRIEND;
   import net.msg.friend.MSG_RESP_ADDFRIENDAUTH;
   import net.msg.friend.MSG_RESP_FRIENDLIST;
   import net.msg.friend.MSG_RESP_FRIENDPASSAUTH;
   
   public class FriendRouter
   {
      
      private static var _instance:FriendRouter;
      
      public function FriendRouter()
      {
         super();
      }
      
      public static function get instance() : FriendRouter
      {
         if(_instance == null)
         {
            _instance = new FriendRouter();
         }
         return _instance;
      }
      
      public function resp_MSG_RESP_FRIENDLIST(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_FRIENDLIST = new MSG_RESP_FRIENDLIST();
         NetManager.Instance().readObject(_loc4_,param3);
         if(_loc4_.Type == 0)
         {
            FriendsListUI.getInstance().RespFriends(_loc4_);
         }
         else if(_loc4_.Type == 1)
         {
            MailUI_Friends.getInstance().RespFriends(_loc4_);
         }
         else if(_loc4_.Type == 2)
         {
            FieldUI.getInstance().RespFriends(_loc4_);
         }
      }
      
      public function resp_MSG_RESP_ADDFRIENDAUTH(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_ADDFRIENDAUTH = new MSG_RESP_ADDFRIENDAUTH();
         NetManager.Instance().readObject(_loc4_,param3);
         InvitePopupUI.getInstance().RespIviteMsg(_loc4_);
      }
      
      public function resp_MSG_RESP_FRIENDPASSAUTH(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_FRIENDPASSAUTH = new MSG_RESP_FRIENDPASSAUTH();
         NetManager.Instance().readObject(_loc4_,param3);
         FriendsListUI.getInstance().RespFassAuth(_loc4_);
      }
      
      public function resp_MSG_RESP_ADDFRIEND(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_ADDFRIEND = new MSG_RESP_ADDFRIEND();
         NetManager.Instance().readObject(_loc4_,param3);
         switch(_loc4_.ErrorCode)
         {
            case 0:
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("FriendText18"),0);
               break;
            case 1:
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("FriendText17"),0);
               break;
            case 2:
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("FriendText17"),0);
               break;
            case 3:
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("FriendText19"),0);
         }
      }
   }
}

