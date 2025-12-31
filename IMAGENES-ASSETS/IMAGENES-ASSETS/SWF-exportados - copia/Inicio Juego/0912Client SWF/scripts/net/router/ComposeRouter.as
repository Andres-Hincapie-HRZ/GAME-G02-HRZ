package net.router
{
   import com.star.frameworks.managers.StringManager;
   import flash.utils.ByteArray;
   import logic.action.ChatAction;
   import logic.entry.ChannelEnum;
   import logic.entry.DiamondInfo;
   import logic.entry.GamePlayer;
   import logic.entry.commander.CommanderXmlInfo;
   import logic.entry.props.propsInfo;
   import logic.reader.CCommanderReader;
   import logic.reader.CPropsReader;
   import logic.ui.ComposeUI;
   import logic.ui.ComposeUI_Commander;
   import logic.ui.ComposeUI_CommanderChip;
   import logic.ui.ComposeUI_Diamond;
   import logic.ui.ComposeUI_FlagShip;
   import logic.ui.EnjoyUi;
   import net.base.NetManager;
   import net.msg.Compose.MSG_RESP_COMMANDERINSERTCMOS;
   import net.msg.Compose.MSG_RESP_COMMANDERINSERTSTONE;
   import net.msg.Compose.MSG_RESP_COMMANDERUNIONSTONE;
   import net.msg.Compose.MSG_RESP_UNIONCOMMANDERCARD;
   import net.msg.Compose.MSG_RESP_UNIONCOMMANDERCARDBRO;
   import net.msg.Compose.MSG_RESP_UNIONDOUBLESKILLCARD;
   import net.msg.FlagShip.MSG_RESP_UNIONFLAGSHIP;
   import net.msg.MSG_RESP_REFRESHWALL;
   import net.msg.commanderMsg.MSG_RESP_COMMANDERCARDBRO;
   
   public class ComposeRouter
   {
      
      private static var _instance:ComposeRouter;
      
      private var MsgList:Array = new Array();
      
      public function ComposeRouter()
      {
         super();
      }
      
      public static function get instance() : ComposeRouter
      {
         if(_instance == null)
         {
            _instance = new ComposeRouter();
         }
         return _instance;
      }
      
      public function resp_MSG_RESP_UNIONCOMMANDERCARD(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_UNIONCOMMANDERCARD = new MSG_RESP_UNIONCOMMANDERCARD();
         NetManager.Instance().readObject(_loc4_,param3);
         ComposeUI.getInstance().RespCompose(_loc4_);
      }
      
      public function resp_MSG_RESP_UNIONDOUBLESKILLCARD(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_UNIONDOUBLESKILLCARD = new MSG_RESP_UNIONDOUBLESKILLCARD();
         NetManager.Instance().readObject(_loc4_,param3);
         ComposeUI.getInstance().resp_MSG_RESP_UNIONDOUBLESKILLCARD(_loc4_);
      }
      
      private function GetCommanderTypStr(param1:int) : String
      {
         var _loc2_:String = null;
         if(param1 < 5)
         {
            _loc2_ = StringManager.getInstance().getMessageString("CommanderText" + int(111 + param1));
         }
         else
         {
            _loc2_ = StringManager.getInstance().getMessageString("Boss34");
         }
         return _loc2_;
      }
      
      public function resp_MSG_RESP_UNIONCOMMANDERCARDBRO(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc7_:* = null;
         var _loc4_:MSG_RESP_UNIONCOMMANDERCARDBRO = new MSG_RESP_UNIONCOMMANDERCARDBRO();
         NetManager.Instance().readObject(_loc4_,param3);
         var _loc5_:CommanderXmlInfo = CCommanderReader.getInstance().GetCommanderInfo(_loc4_.SkillId);
         var _loc6_:int = CPropsReader.getInstance().GetCommanderProID(_loc4_.SkillId) + _loc4_.CardLevel;
         var _loc8_:String = this.GetCommanderTypStr(_loc5_.Type);
         if(_loc4_.SuccessFlag == 1)
         {
            _loc7_ = "<a href=\'event:" + _loc4_.Guid + "," + _loc4_.Name + "\'>[" + _loc4_.Name + "]</a>" + StringManager.getInstance().getMessageString("ChatingTXT24") + StringManager.getInstance().getMessageString("CommanderText" + int(113 + _loc4_.CardLevel)) + _loc8_ + "<font color=\'#99FFFF\'>" + "<a href=\"event:" + "2," + _loc6_ + "," + _loc4_.Guid + "," + _loc5_.Name + "\">" + " [" + _loc5_.Name + "]" + "</a></font>";
         }
         else
         {
            _loc7_ = "<a href=\'event:" + _loc4_.Guid + "," + _loc4_.Name + "\'>[" + _loc4_.Name + "]</a>" + StringManager.getInstance().getMessageString("ChatingTXT27") + StringManager.getInstance().getMessageString("CommanderText" + int(113 + _loc4_.CardLevel)) + _loc8_ + "<font color=\'#99FFFF\'>" + "<a href=\"event:" + "2," + _loc6_ + "," + _loc4_.Guid + "," + _loc5_.Name + "\">" + " [" + _loc5_.Name + "]" + "</a></font>" + StringManager.getInstance().getMessageString("ChatingTXT28");
         }
         ChatAction.getInstance().appendMsgContent(_loc7_,ChannelEnum.CHANNEL_SYSTEM,_loc4_.Name);
      }
      
      public function resp_MSG_RESP_COMMANDERCARDBRO(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc9_:* = null;
         var _loc12_:String = null;
         var _loc4_:MSG_RESP_COMMANDERCARDBRO = new MSG_RESP_COMMANDERCARDBRO();
         NetManager.Instance().readObject(_loc4_,param3);
         var _loc5_:propsInfo = CPropsReader.getInstance().GetPropsInfo(_loc4_.SrcPropsId);
         var _loc6_:propsInfo = CPropsReader.getInstance().GetPropsInfo(_loc4_.ObjPropsId);
         var _loc7_:CommanderXmlInfo = CCommanderReader.getInstance().GetCommanderInfo(_loc6_.SkillID);
         var _loc8_:int = _loc4_.ObjPropsId;
         var _loc10_:String = StringManager.getInstance().getMessageString("CommanderText132");
         _loc9_ = "<a href=\"event:" + _loc4_.Guid + "," + _loc4_.Name + "\">" + _loc4_.Name + "</a>";
         _loc10_ = _loc10_.replace("@@1",_loc9_);
         var _loc11_:int = _loc5_.Id - 1551;
         if(_loc11_ < 3)
         {
            _loc12_ = "#00F800";
         }
         else if(_loc11_ < 5)
         {
            _loc12_ = "#0090F8";
         }
         else
         {
            _loc12_ = "#C800F8";
         }
         _loc10_ = _loc10_.replace("@@2","<font color=\'" + _loc12_ + "\'>" + _loc5_.Name + "</font>");
         var _loc13_:int = 113 + _loc4_.CardLevel;
         if(_loc4_.CardLevel == 2)
         {
            _loc13_ = 131;
         }
         _loc9_ = StringManager.getInstance().getMessageString("CommanderText" + _loc13_) + this.GetCommanderTypStr(_loc7_.Type) + "<font color=\'#99FFFF\'>" + "<a href=\"event:" + _loc7_.Type + "," + _loc8_ + "," + _loc4_.Guid + "," + _loc7_.Name + "\">" + " [" + _loc7_.Name + "]" + "</a></font>";
         _loc10_ = _loc10_.replace("@@3",_loc9_);
         ChatAction.getInstance().appendMsgContent(_loc10_,ChannelEnum.CHANNEL_SYSTEM,_loc4_.Name);
      }
      
      public function resp_MSG_RESP_COMMANDERUNIONSTONE(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc5_:DiamondInfo = null;
         var _loc6_:* = null;
         var _loc4_:MSG_RESP_COMMANDERUNIONSTONE = new MSG_RESP_COMMANDERUNIONSTONE();
         NetManager.Instance().readObject(_loc4_,param3);
         if(_loc4_.BroFlag == 1)
         {
            _loc5_ = CPropsReader.getInstance().GetDiamond(_loc4_.PropsId);
            _loc6_ = "<a href=\"event:" + _loc4_.Guid + "," + _loc4_.Name + "\">[" + _loc4_.Name + "]</a>  " + StringManager.getInstance().getMessageString("CorpsText146");
            if(_loc5_.GemLevel == 3)
            {
               _loc6_ += "<font color=\'#0090F8\'>";
            }
            else
            {
               _loc6_ += "<font color=\'#C800F8\'>";
            }
            _loc6_ += int(_loc5_.GemLevel + 1) + StringManager.getInstance().getMessageString("CorpsText147") + "<a href=\"event:" + ChatAction.TOOL_TYPE + "," + _loc5_.PropsId + "," + _loc4_.Guid + "," + _loc5_.PropsInfo.Name + "\">" + "[" + _loc5_.PropsInfo.Name + "]" + "</a></font>";
            ChatAction.getInstance().appendMsgContent(_loc6_,ChannelEnum.CHANNEL_SYSTEM,_loc4_.Name);
         }
         if(_loc4_.Guid == GamePlayer.getInstance().Guid)
         {
            ComposeUI_Diamond.GetInstance().RespComposeMsg(_loc4_);
         }
      }
      
      public function resp_MSG_RESP_COMMANDERINSERTSTONE(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_COMMANDERINSERTSTONE = new MSG_RESP_COMMANDERINSERTSTONE();
         NetManager.Instance().readObject(_loc4_,param3);
         ComposeUI_Commander.GetInstance().RespInsetDiamond(_loc4_);
      }
      
      public function resp_MSG_RESP_REFRESHWALL(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_REFRESHWALL = new MSG_RESP_REFRESHWALL();
         NetManager.Instance().readObject(_loc4_,param3);
         EnjoyUi.getInstance().Resp_MSG_RESP_REFRESHWALL(_loc4_);
      }
      
      public function resp_MSG_RESP_UNIONFLAGSHIP(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_UNIONFLAGSHIP = new MSG_RESP_UNIONFLAGSHIP();
         NetManager.Instance().readObject(_loc4_,param3);
         ComposeUI_FlagShip.GetInstance().Resp_MSG_RESP_UNIONFLAGSHIP(_loc4_);
      }
      
      public function Resp_MSG_RESP_COMMANDERINSERTCMOS(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_COMMANDERINSERTCMOS = new MSG_RESP_COMMANDERINSERTCMOS();
         NetManager.Instance().readObject(_loc4_,param3);
         ComposeUI_CommanderChip.GetInstance().Resp_MSG_RESP_COMMANDERINSERTCMOS(_loc4_);
      }
   }
}

