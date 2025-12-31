package net.router
{
   import com.star.frameworks.debug.Log;
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.net.MsgDefine;
   import com.star.frameworks.utils.HashSet;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.external.ExternalInterface;
   import flash.utils.ByteArray;
   import logic.entry.GamePlayer;
   import logic.game.GameKernel;
   import logic.game.GameLogic;
   import logic.ui.CreateRoleUI;
   import logic.ui.ErrorPopup;
   import logic.ui.FillGamePlayerInfoUI;
   import logic.ui.GameServerListUI;
   import logic.ui.LoginUI;
   import logic.ui.MainUI;
   import logic.ui.MessagePopup;
   import logic.ui.PlayerInfoUI;
   import logic.ui.ResPlaneUI;
   import logic.ui.modifyNameUI;
   import logic.widget.CMediaPlayer;
   import net.base.NetManager;
   import net.base.NetRouter;
   import net.msg.MSG_LOGINSERVER_CHECKREGISTERNAMERESP;
   import net.msg.MSG_LOGINSERVER_GAMESERVERLISTRESP;
   import net.msg.MSG_LOGINSERVER_GAMESERVERLISTRESP_TEMP;
   import net.msg.MSG_LOGINSERVER_VALIDATE;
   import net.msg.MSG_RESP_PAYMENTSUCCEED;
   import net.msg.MSG_RESP_PLAYERRESOURCE;
   import net.msg.MSG_RESP_UPDATEPLAYERNAME;
   import net.msg.MSG_ROLE_INFO;
   
   public class GameRouter
   {
      
      private static var _instance:GameRouter = null;
      
      private var taskMc:MovieClip;
      
      public function GameRouter()
      {
         super();
      }
      
      public static function get instance() : GameRouter
      {
         if(_instance == null)
         {
            _instance = new GameRouter();
         }
         return _instance;
      }
      
      public function resp_MSG_GAMESERVER_LOGINRESP(param1:int, param2:int, param3:ByteArray) : void
      {
         ExternalInterface.call("console.log","[#] BLB " + param1 + " :: " + param2);
         var dd:int = 0;
         var list:HashSet = null;
         var sour:MovieClip = null;
         var uSize:* = param1;
         var uType:* = param2;
         ExternalInterface.call("console.log","[#] usSize " + uSize + ", usType " + uType);
         var Buf:ByteArray = param3;
         NetManager.Instance().stopCount();
         Buf.readShort();
         Buf.readShort();
         var error:int = Buf.readByte();
         ExternalInterface.call("console.log","[#] Error = " + error);
         if(error)
         {
            Log.SaveLog(10050 + error);
            ErrorPopup.getInstance().Init();
            ErrorPopup.getInstance().setErrorMsg(StringManager.getInstance().getMessageString("Server24"),error);
         }
         else
         {
            Log.SaveLog(1005);
            GameKernel.getInstance().isInit = true;
            MsgDefine.Instance().FillMsgLength(Buf,3);
            ExternalInterface.call("console.log","[#] Buf = " + Buf);
            dd = MsgDefine.Instance().GetIntFromBuffer(Buf.readByte(),Buf.readByte(),Buf.readByte(),Buf.readByte());
            ExternalInterface.call("console.log","[#] GUID = " + dd);
            GamePlayer.getInstance().Guid = dd;
            GamePlayer.getInstance().Guide = MsgDefine.Instance().GetIntFromBuffer(Buf.readByte(),Buf.readByte(),Buf.readByte(),Buf.readByte());
            ExternalInterface.call("console.log","[#] guide = " + GamePlayer.getInstance().Guide);
            if(0 == GamePlayer.getInstance().Guide)
            {
               GamePlayer.getInstance().isGuideComplete = true;
               this.DoInitGameHandler();
               return;
            }
            this.DoInitGameHandler();
         }
      }
      
      private function DoInitGameHandler() : void
      {
         GameKernel.renderManager.showLoadingMc(false);
         GameKernel.resManager.unRegisterRes("login_asset");
         MainUI.getInstance().Init();
         GameLogic.getInstance().initGameProfile();
         GameKernel.getInstance().initFaceBook();
         NetManager.Instance().StartSendActiveMsg();
      }
      
      private function onEnter(param1:Event) : void
      {
         if(this.taskMc && this.taskMc.currentFrame == this.taskMc.totalFrames)
         {
            GameKernel.renderManager.getScene().getContainer().removeEventListener(Event.ENTER_FRAME,this.onEnter);
            this.taskMc.stop();
            GameKernel.renderManager.getScene().removeComponent(this.taskMc);
            CMediaPlayer.getInstance().Clear();
            this.taskMc = null;
            GamePlayer.getInstance().isGuideComplete = true;
            this.DoInitGameHandler();
         }
      }
      
      public function resp_MSG_LOGINSERVER_VALIDATE(param1:int, param2:int, param3:ByteArray) : void
      {
         NetManager.Instance().stopCount();
         var _loc4_:MSG_LOGINSERVER_VALIDATE = new MSG_LOGINSERVER_VALIDATE();
         NetManager.Instance().readObject(_loc4_,param3);
         NetRouter.Instance().checkOutText = _loc4_.CheckOutText;
         NetManager.Instance().gameServerHost = _loc4_.Ip;
         NetManager.Instance().gameServerPort = _loc4_.Port;
         GameKernel.getInstance().isGameServer = true;
         NetRouter.ConnLoginServer = true;
         NetManager.Instance().ConnectGameServer();
      }
      
      public function resp_MSG_CREATE_ROLE(param1:int, param2:int, param3:ByteArray) : void
      {
         param3.readShort();
         param3.readShort();
         GamePlayer.getInstance().Guid = MsgDefine.Instance().GetIntFromBuffer(param3.readByte(),param3.readByte(),param3.readByte(),param3.readByte());
         LoginUI.getInstance().Release();
         CreateRoleUI.getInstance().Init();
      }
      
      public function resp_MSG_CREATE_ROLE_NAME(param1:int, param2:int, param3:ByteArray) : void
      {
         GameServerListUI.GetInstance().Release();
         param3.readShort();
         param3.readShort();
         var _loc4_:int = param3.readByte();
         switch(_loc4_)
         {
            case 0:
               GamePlayer.getInstance().Name = FillGamePlayerInfoUI.getInstance().PlayerNameTxt.text;
               PlayerInfoUI.getInstance().UpdateUserName();
               FillGamePlayerInfoUI.getInstance().Release();
               break;
            case 1:
               FillGamePlayerInfoUI.getInstance().PlayerNameTxt.text = "";
               FillGamePlayerInfoUI.getInstance().Tip.text = StringManager.getInstance().getMessageString("FriendText23");
               break;
            case 2:
               FillGamePlayerInfoUI.getInstance().PlayerNameTxt.text = "";
               FillGamePlayerInfoUI.getInstance().Tip.text = StringManager.getInstance().getMessageString("FriendText24");
         }
      }
      
      public function resp_MSG_ROLE_INFO(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_ROLE_INFO = new MSG_ROLE_INFO();
         NetManager.Instance().readObject(_loc4_,param3);
         GamePlayer.getInstance().init(_loc4_);
         MapRouter.instance.resp_MSG_RESP_HOLDGALAXYINFO();
      }
      
      public function resp_LOGINSERVER_GAMESERVERLISTRESP(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc7_:MSG_LOGINSERVER_GAMESERVERLISTRESP_TEMP = null;
         Log.SaveLog(10031);
         NetManager.Instance().DisConnect();
         NetManager.Instance().stopCount();
         var _loc4_:MSG_LOGINSERVER_GAMESERVERLISTRESP = new MSG_LOGINSERVER_GAMESERVERLISTRESP();
         NetManager.Instance().readObject(_loc4_,param3);
         GamePlayer.getInstance().DefaultServerId = _loc4_.DefaultServerId;
         GamePlayer.getInstance().NewServerID = _loc4_.NewServerId;
         var _loc5_:Array = new Array();
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_.DataLen)
         {
            _loc7_ = _loc4_.Data[_loc6_];
            _loc5_.push(_loc7_);
            _loc6_++;
         }
         _loc5_.reverse();
         GameServerListUI.GetInstance().Init();
         GameServerListUI.GetInstance().SetSelectServerName(GamePlayer.getInstance().DefaultServerId);
         GameServerListUI.GetInstance().SetServerData(_loc5_);
         GameServerListUI.GetInstance().SetCurrentSelectServerStatue();
      }
      
      public function resp_LOGINSERVER_CHECKREGISTERNAMERESP(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_LOGINSERVER_CHECKREGISTERNAMERESP = new MSG_LOGINSERVER_CHECKREGISTERNAMERESP();
         NetManager.Instance().readObject(_loc4_,param3);
         switch(_loc4_.ErrorCode)
         {
            case 1:
               GameServerListUI.GetInstance().ErrorTip = StringManager.getInstance().getMessageString("ItemText21");
               break;
            case 2:
               GameServerListUI.GetInstance().ErrorTip = StringManager.getInstance().getMessageString("ItemText22");
         }
      }
      
      public function resp_MSG_PLAYERRESOURCE(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_PLAYERRESOURCE = new MSG_RESP_PLAYERRESOURCE();
         NetManager.Instance().readObject(_loc4_,param3);
         GamePlayer.getInstance().updatePlayerResource(_loc4_);
      }
      
      public function Resp_MSG_RESP_UPDATEPLAYERNAME(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_UPDATEPLAYERNAME = new MSG_RESP_UPDATEPLAYERNAME();
         NetManager.Instance().readObject(_loc4_,param3);
         modifyNameUI.getInstance().Resp_MSG_RESP_UPDATEPLAYERNAME(_loc4_);
      }
      
      public function Resp_MSG_RESP_PAYMENTSUCCEED(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_PAYMENTSUCCEED = new MSG_RESP_PAYMENTSUCCEED();
         NetManager.Instance().readObject(_loc4_,param3);
         GamePlayer.getInstance().cash = GamePlayer.getInstance().cash + _loc4_.Credit;
         ResPlaneUI.getInstance().updateResPlane();
         var _loc5_:String = StringManager.getInstance().getMessageString("Boss89");
         _loc5_ = _loc5_.replace("@@1",_loc4_.Credit);
         MessagePopup.getInstance().Show(_loc5_,1);
      }
   }
}

