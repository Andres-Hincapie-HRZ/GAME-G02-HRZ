package net.router
{
   import com.star.frameworks.managers.StringManager;
   import flash.utils.ByteArray;
   import logic.action.ChatAction;
   import logic.entry.ChannelEnum;
   import logic.ui.BattlefieldUI;
   import net.base.NetManager;
   import net.msg.fightMsg.MSG_RESP_DUPLICATE_BULLETIN;
   import net.msg.fightMsg.MSG_RESP_WARFIELD_PLAYERLIST;
   import net.msg.fightMsg.MSG_RESP_WARFIELD_STATUS;
   
   public class BattleFieldRouter
   {
      
      private static var _instance:BattleFieldRouter;
      
      public function BattleFieldRouter()
      {
         super();
      }
      
      public static function get instance() : BattleFieldRouter
      {
         if(_instance == null)
         {
            _instance = new BattleFieldRouter();
         }
         return _instance;
      }
      
      public function resp_MSG_RESP_WARFIELD_STATUS(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_WARFIELD_STATUS = new MSG_RESP_WARFIELD_STATUS();
         NetManager.Instance().readObject(_loc4_,param3);
         BattlefieldUI.getInstance().RestStatusMsg(_loc4_);
      }
      
      public function resp_MSG_RESP_DUPLICATE_BULLETIN(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc5_:String = null;
         var _loc4_:MSG_RESP_DUPLICATE_BULLETIN = new MSG_RESP_DUPLICATE_BULLETIN();
         NetManager.Instance().readObject(_loc4_,param3);
         if(_loc4_.BulletinType == 0)
         {
            _loc5_ = StringManager.getInstance().getMessageString("Boss155");
            _loc5_ = _loc5_.replace("@@1",_loc4_.Countdown);
            ChatAction.getInstance().appendMsgContent(_loc5_,ChannelEnum.CHANNEL_SYSTEM);
         }
      }
      
      public function resp_MSG_RESP_WARFIELD_PLAYERLIST(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_WARFIELD_PLAYERLIST = new MSG_RESP_WARFIELD_PLAYERLIST();
         NetManager.Instance().readObject(_loc4_,param3);
         BattlefieldUI.getInstance().RespMemberList(_loc4_);
      }
   }
}

