package net.router
{
   import com.star.frameworks.managers.StringManager;
   import flash.utils.ByteArray;
   import logic.action.ChatAction;
   import logic.entry.ChannelEnum;
   import logic.game.GameKernel;
   import logic.manager.FightManager;
   import logic.ui.RaidProps;
   import net.base.NetManager;
   import net.msg.RaidProps.MSG_RESP_CAPTURE_ARK_INFO;
   import net.msg.RaidProps.MSG_RESP_CAPTURE_ARK_LIST;
   import net.msg.RaidProps.MSG_RESP_CAPTURE_ARK_ROOM;
   import net.msg.RaidProps.MSG_RESP_CAPTURE_BULLETIN;
   import net.msg.RaidProps.MSG_RESP_DUPLICATE_BATTLE;
   
   public class RaidPropsRouter
   {
      
      private static var _instance:RaidPropsRouter;
      
      public function RaidPropsRouter()
      {
         super();
      }
      
      public static function get instance() : RaidPropsRouter
      {
         if(_instance == null)
         {
            _instance = new RaidPropsRouter();
         }
         return _instance;
      }
      
      public function resp_MSG_RESP_CAPTURE_ARK_LIST(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_CAPTURE_ARK_LIST = new MSG_RESP_CAPTURE_ARK_LIST();
         NetManager.Instance().readObject(_loc4_,param3);
         RaidProps.getInstance().RespRoomList(_loc4_);
      }
      
      public function resp_MSG_RESP_CAPTURE_ARK_ROOM(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_CAPTURE_ARK_ROOM = new MSG_RESP_CAPTURE_ARK_ROOM();
         NetManager.Instance().readObject(_loc4_,param3);
         RaidProps.getInstance().RespRoomStatus(_loc4_);
      }
      
      public function resp_MSG_RESP_CAPTURE_ARK_INFO(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_CAPTURE_ARK_INFO = new MSG_RESP_CAPTURE_ARK_INFO();
         NetManager.Instance().readObject(_loc4_,param3);
         RaidProps.getInstance().RespSelfRoomMsg(_loc4_);
      }
      
      public function resp_MSG_RESP_DUPLICATE_BATTLE(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_DUPLICATE_BATTLE = new MSG_RESP_DUPLICATE_BATTLE();
         NetManager.Instance().readObject(_loc4_,param3);
         FightManager.instance.CleanFight();
         GameKernel.popUpDisplayManager.HideAllPopup();
      }
      
      public function resp_MSG_RESP_CAPTURE_BULLETIN(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc5_:String = null;
         var _loc6_:* = null;
         var _loc4_:MSG_RESP_CAPTURE_BULLETIN = new MSG_RESP_CAPTURE_BULLETIN();
         NetManager.Instance().readObject(_loc4_,param3);
         if(_loc4_.BulletinType == 0)
         {
            if(_loc4_.Countdown == 0)
            {
               _loc5_ = StringManager.getInstance().getMessageString("Boss135");
            }
            else
            {
               _loc5_ = StringManager.getInstance().getMessageString("Boss136");
            }
            _loc6_ = "<a href=\'event:RAID\'>" + StringManager.getInstance().getMessageString("Boss145") + "</a>";
            _loc5_ = _loc5_.replace("@@1",_loc6_);
            ChatAction.getInstance().appendMsgContent(_loc5_,ChannelEnum.CHANNEL_SYSTEM,"",false);
         }
         else
         {
            RaidProps.getInstance().RespMessage(_loc4_);
         }
      }
   }
}

