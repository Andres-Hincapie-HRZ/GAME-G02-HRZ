package net.base
{
   import com.star.frameworks.debug.Log;
   import com.star.frameworks.managers.RenderManager;
   import com.star.frameworks.managers.StringManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   import flash.utils.clearTimeout;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import logic.entry.GamePlayer;
   import logic.entry.ScienceSystem;
   import logic.game.GameKernel;
   import logic.manager.InstanceManager;
   import logic.ui.ErrorPopup;
   import logic.ui.GameServerListUI;
   import net.common.MsgTypes;
   import net.msg.MSG_CLIENT_LOGINTOG;
   import net.msg.MSG_CLIENT_LOGINTOL;
   import net.router.BattleFieldRouter;
   import net.router.ChangeServerRouter;
   import net.router.ChatRouter;
   import net.router.ChipLotteryRouter;
   import net.router.CommanderRouter;
   import net.router.ComposeRouter;
   import net.router.ConstructionRouter;
   import net.router.CorpsRouter;
   import net.router.CustomRouter;
   import net.router.DestructionShipRouter;
   import net.router.FaceBookRouter;
   import net.router.FieldRouter;
   import net.router.FleetRouter;
   import net.router.FriendRouter;
   import net.router.GalaxyMatchRouter;
   import net.router.GameRouter;
   import net.router.GotoGalaxyRouter;
   import net.router.GymkhanaRouter;
   import net.router.LeaguerangeRouter;
   import net.router.LoadHe3Router;
   import net.router.MailRouter;
   import net.router.MallRouter;
   import net.router.MapRouter;
   import net.router.MiniMapRouter;
   import net.router.RadarRouter;
   import net.router.RaidPropsRouter;
   import net.router.RankRouter;
   import net.router.RewardRouter;
   import net.router.ShipPairRouter;
   import net.router.ShipmodelRouter;
   import net.router.TaskRouter;
   import net.router.UpgradeRouter;
   
   public class NetRouter extends EventDispatcher
   {
      
      private static var netFunction:Array = null;
      
      private static var netRouter:NetRouter = null;
      
      public static var ConnLoginServer:Boolean = false;
      
      public static var ConnCheckServer:Boolean = false;
      
      private var onNetConnect:Function = null;
      
      private var onNetDisconnect:Function = null;
      
      private var onNetError:Function = null;
      
      private var ConnGameServer:Boolean = false;
      
      public var userId:Number;
      
      public var sessionKey:String;
      
      public var version:int;
      
      public var gameserverid:int = -1;
      
      public var checkOutText:String;
      
      private var TimeoutValue:int;
      
      public function NetRouter()
      {
         super();
         netFunction = new Array();
         this.routerFunction();
      }
      
      public static function Instance() : NetRouter
      {
         if(netRouter == null)
         {
            netRouter = new NetRouter();
         }
         return netRouter;
      }
      
      public function release() : void
      {
         netRouter = null;
         netFunction = null;
         this.onNetConnect = null;
         this.onNetDisconnect = null;
         this.onNetError = null;
      }
      
      public function netConnectEvent(param1:Event) : void
      {
         if(this.onNetConnect != null)
         {
            this.onNetConnect();
         }
      }
      
      public function netDisconnectEvent(param1:Event) : void
      {
         if(this.onNetDisconnect != null)
         {
            this.onNetDisconnect();
         }
      }
      
      public function netErrorEvent(param1:Event) : void
      {
         if(this.onNetError != null)
         {
            this.onNetError();
         }
      }
      
      public function msgRouter(param1:ByteArray) : void
      {
         var _loc5_:* = null;
         param1.position = 0;
         var _loc2_:int = MsgSocket.Instance().readMsgSize(param1);
         var _loc3_:int = MsgSocket.Instance().readMsgType(param1);
         param1.position = 0;
         var _loc4_:Boolean = false;
         for(_loc5_ in netFunction)
         {
            if(_loc5_ == _loc3_ + "")
            {
               netFunction[_loc5_](_loc2_,_loc3_,param1);
               _loc4_ = true;
               break;
            }
         }
         if(!_loc4_)
         {
            this.noRouterFunction(_loc2_,_loc3_,param1);
         }
      }
      
      private function noRouterFunction(param1:int, param2:int, param3:ByteArray) : void
      {
      }
      
      private function routerFunction() : void
      {
         this.onNetConnect = this.netConnect;
         this.onNetDisconnect = this.netDisconnect;
         this.onNetError = this.netError;
         netFunction[MsgTypes._MSG_GAMESERVER_LOGINRESP] = GameRouter.instance.resp_MSG_GAMESERVER_LOGINRESP;
         netFunction[MsgTypes._MSG_LOGINSERVER_VALIDATE] = GameRouter.instance.resp_MSG_LOGINSERVER_VALIDATE;
         netFunction[MsgTypes._MSG_ROLE_INFO] = GameRouter.instance.resp_MSG_ROLE_INFO;
         netFunction[MsgTypes._MSG_LOGINSERVER_GAMESERVERLISTRESP] = GameRouter.instance.resp_LOGINSERVER_GAMESERVERLISTRESP;
         netFunction[MsgTypes._MSG_LOGINSERVER_CHECKREGISTERNAMERESP] = GameRouter.instance.resp_LOGINSERVER_CHECKREGISTERNAMERESP;
         netFunction[MsgTypes._MSG_CREATE_ROLE] = GameRouter.instance.resp_MSG_CREATE_ROLE;
         netFunction[MsgTypes._MSG_RESP_UPDATEPLAYERNAME] = GameRouter.instance.Resp_MSG_RESP_UPDATEPLAYERNAME;
         netFunction[MsgTypes._MSG_RESP_CREATEROLE] = GameRouter.instance.resp_MSG_CREATE_ROLE_NAME;
         netFunction[MsgTypes._MSG_RESP_PLAYERRESOURCE] = GameRouter.instance.resp_MSG_PLAYERRESOURCE;
         netFunction[MsgTypes._MSG_RESP_MAPAREA] = MapRouter.instance.resp_MSG_RESP_MAPAREA;
         netFunction[MsgTypes._MSG_RESP_GALAXYSHIP] = MapRouter.instance.resp_MSG_RESP_GALAXYSHIP;
         netFunction[MsgTypes._MSG_RESP_MOVESHIPTEAM] = MapRouter.instance.resp_MSG_RESP_MOVESHIPTEAM;
         netFunction[MsgTypes._MSG_RESP_DIRECTIONSHIPTEAM] = MapRouter.instance.resp_MSG_RESP_DIRECTIONSHIPTEAM;
         netFunction[MsgTypes._MSG_RESP_CREATESHIPTEAM] = MapRouter.instance.resp_MSG_RESP_CREATESHIPTEAM;
         netFunction[MsgTypes._MSG_RESP_DELSHIPTEAMBROADCAST] = MapRouter.instance.resp_MSG_RESP_DELSHIPTEAMBROADCAST;
         netFunction[MsgTypes._MSG_RESP_SHIPTEAMINFO] = MapRouter.instance.resp_MSG_RESP_SHIPTEAMINFO;
         netFunction[MsgTypes._MSG_RESP_JUMPGALAXYSHIP] = MapRouter.instance.resp_MSG_RESP_JUMPGALAXYSHIP;
         netFunction[MsgTypes._MSG_RESP_JUMPSHIPTEAM] = MapRouter.instance.resp_MSG_RESP_JUMPSHIPTEAM;
         netFunction[MsgTypes._MSG_RESP_JUMPSHIPTEAMINFO] = MapRouter.instance.resp_MSG_RESP_JUMPSHIPTEAMINFO;
         netFunction[MsgTypes._MSG_RESP_JUMPSHIPTEAMCOMPLETE] = MapRouter.instance.resp_MSG_RESP_JUMPSHIPTEAMCOMPLETE;
         netFunction[MsgTypes._MSG_RESP_FIGHTINIT_SHIPTEAM] = MapRouter.instance.resp_MSG_RESP_FIGHTINIT_SHIPTEAM;
         netFunction[MsgTypes._MSG_RESP_FIGHTBOUTBEG] = MapRouter.instance.resp_MSG_RESP_FIGHTBOUTBEG;
         netFunction[MsgTypes._MSG_RESP_FIGHTSECTION] = MapRouter.instance.resp_MSG_RESP_FIGHTSECTION;
         netFunction[MsgTypes._MSG_RESP_FIGHTRESULT] = MapRouter.instance.resp_MSG_RESP_FIGHTRESULT;
         netFunction[MsgTypes._MSG_SHIPTEAMHOLDGALAXY] = MapRouter.instance.resp_MSG_SHIPTEAMHOLDGALAXY;
         netFunction[MsgTypes._MSG_RESP_FIGHTINIT_BUILD] = MapRouter.instance.resp_MSG_RESP_FIGHTINIT_BUILD;
         netFunction[MsgTypes._MSG_RESP_FIGHTFORTRESSSECTION] = MapRouter.instance.resp_MSG_RESP_FIGHTFORTRESSSECTION;
         netFunction[MsgTypes._MSG_FIGHTGALAXYBEGIN] = MapRouter.instance.resp_MSG_FIGHTGALAXYBEGIN;
         netFunction[MsgTypes._MSG_RESP_ECTYPESTATE] = InstanceManager.instance.respone_MSG_RESP_ECTYPESTATE;
         netFunction[MsgTypes._MSG_RESP_ECTYPEPASS] = InstanceManager.instance.response_MSG_RESP_ECTYPEPASS;
         netFunction[MsgTypes._MSG_FIGHTGALAXYOVER] = MapRouter.instance.resp_MSG_FIGHTGALAXYOVER;
         netFunction[MsgTypes._MSG_RESP_MAPBLOCK] = MiniMapRouter.resp_MSG_RESP_MAPBLOCK;
         netFunction[MsgTypes._MSG_RESP_CONSORTIASTAR] = MiniMapRouter.resp_MSG_RESP_CONSORTIASTAR;
         netFunction[MsgTypes._MSG_RESP_MAPBLOCKFIGHT] = MiniMapRouter.resp_MSG_RESP_MAPBLOCKFIGHT;
         netFunction[MsgTypes._MSG_RESP_MAPBLOCKUSERINFO] = MiniMapRouter.resp_MSG_RESP_MAPBLOCKUSERINFO;
         netFunction[MsgTypes._MSG_RESP_LOOKUPUSERINFO] = GotoGalaxyRouter.resp_MSG_RESP_LOOKUPUSERINFO;
         netFunction[MsgTypes._MSG_RESP_INSERTFLAGBRO] = MapRouter.instance.resp_MSG_RESP_INSERTFLAGBRO;
         netFunction[MsgTypes._MSG_RESP_MATCHINFO] = GalaxyMatchRouter.resp_MSG_RESP_MATCHINFO;
         netFunction[MsgTypes._MSG_RESP_MATCHPAGE] = GalaxyMatchRouter.resp_MSG_RESP_MATCHPAGE;
         netFunction[MsgTypes._MSG_RESP_FRIENDINFO] = FaceBookRouter.getInstance().resp_MSG_FACEBOOKINFO;
         netFunction[MsgTypes._MSG_RESP_BUILDINFO] = ConstructionRouter.getInstance().resp_Msg_BuildInfo;
         netFunction[MsgTypes._MSG_RESP_CREATEBUILD] = ConstructionRouter.getInstance().resp_Msg_CreateBuild;
         netFunction[MsgTypes._MSG_RESP_BUILDCOMPLETE] = ConstructionRouter.getInstance().resp_Msg_BuildCompleted;
         netFunction[MsgTypes._MSG_RESP_CANCELBUILD] = ConstructionRouter.getInstance().resp_Msg_CancelBuilding;
         netFunction[MsgTypes._MSG_RESP_DELETEBUILD] = ConstructionRouter.getInstance().resp_Msg_DeleteBuilding;
         netFunction[MsgTypes._MSG_RESP_MOVEBUILD] = ConstructionRouter.getInstance().resp_Msg_MoveBuilding;
         netFunction[MsgTypes._MSG_RESP_STORAGERESOURCE] = ConstructionRouter.getInstance().resp_MSG_STORAGERESOURCE;
         netFunction[MsgTypes._MSG_RESP_GETSTORAGERESOURCE] = ConstructionRouter.getInstance().resp_MSG_GETSTORAGERESOURCE;
         netFunction[MsgTypes._MSG_RESP_BUILDINGDEATHCOMPLETE] = ConstructionRouter.getInstance().resp_MSG_BUILDINGDEATHCOMPLETE;
         netFunction[MsgTypes._MSG_RESP_SPEEDBUILDING] = ConstructionRouter.getInstance().resp_MSG_RESP_SPEEDBUILDING;
         netFunction[MsgTypes._MSG_RESP_TIMEQUEUE] = ConstructionRouter.getInstance().resp_MSG_RESP_TIMEQUEUE;
         netFunction[MsgTypes._MSG_RESP_CONSORTIAWEALTH] = ConstructionRouter.getInstance().resp_MSG_RESP_CONSORTIAWEALTH;
         netFunction[MsgTypes._MSG_RESP_CONSORTIABUILDING] = ConstructionRouter.getInstance().resp_MSG_RESP_CONSORTIABUILDING;
         netFunction[MsgTypes._MSG_RESP_SPEEDFRIENDBUILDING] = ConstructionRouter.getInstance().resp_MSG_RESP_SPEEDFRIENDBUILDING;
         netFunction[MsgTypes._MSG_RESP_CREATEBUILDINFO] = ConstructionRouter.getInstance().resp_MSG_RESP_CREATEBUILDINFO;
         netFunction[MsgTypes._MSG_RESP_BUILDINFOFRIEND] = ConstructionRouter.getInstance().resp_MSG_RESP_BUILDINFOFRIEND;
         netFunction[MsgTypes._MSG_RESP_COMMANDERINFO] = CommanderRouter.instance.resp_MSG_RESP_COMMANDERINFO;
         netFunction[MsgTypes._MSG_RESP_CREATECOMMANDER] = CommanderRouter.instance.resp__MSG_RESP_CREATECOMMANDER;
         netFunction[MsgTypes._MSG_RESP_COMMANDERBASEINFO] = CommanderRouter.instance.resp_MSG_RESP_COMMANDERBASEINFO;
         netFunction[MsgTypes._MSG_RESP_RELIVECOMMANDER] = CommanderRouter.instance.resp_MSG_RESP_RELIVECOMMANDER;
         netFunction[MsgTypes._MSG_RESP_RESUMECOMMANDER] = CommanderRouter.instance.resp_MSG_RESP_RESUMECOMMANDER;
         netFunction[MsgTypes._MSG_RESP_COMMANDERCARD] = CommanderRouter.instance.resp_MSG_RESP_COMMANDERCARD;
         netFunction[MsgTypes._MSG_RESP_COMMANDEREDITSHIPTEAM] = CommanderRouter.instance.resp_MSG_RESP_COMMANDEREDITSHIPTEAM;
         netFunction[MsgTypes._MSG_RESP_CLEARCOMMANDERPERCENT] = CommanderRouter.instance.resp_MSG_RESP_CLEARCOMMANDERPERCENT;
         netFunction[MsgTypes._MSG_RESP_COMMANDERCHANGECARD] = CommanderRouter.instance.resp_MSG_RESP_COMMANDERCHANGECARD;
         netFunction[MsgTypes._MSG_RESP_REFRESHCOMMANDERBASEINFO] = CommanderRouter.instance.resp_MSG_RESP_REFRESHCOMMANDERBASEINFO;
         netFunction[MsgTypes._MSG_RESP_DELETECOMMANDER] = CommanderRouter.instance.resp_MSG_RESP_DELETECOMMANDER;
         netFunction[MsgTypes._MSG_RESP_COMMANDERSTONEINFO] = CommanderRouter.instance.resp_MSG_RESP_COMMANDERSTONEINFO;
         netFunction[MsgTypes._MSG_RESP_SHIPMODELINFO] = ShipmodelRouter.instance.resp_MSG_RESP_SHIPMODELINFO;
         netFunction[MsgTypes._MSG_RESP_CREATESHIP] = ShipmodelRouter.instance.resp_MSG_RESP_CREATESHIP;
         netFunction[MsgTypes._MSG_RESP_CANCELSHIP] = ShipmodelRouter.instance.resp_MSG_RESP_CANCELSHIP;
         netFunction[MsgTypes._MSG_RESP_SHIPCREATINGCOMPLETE] = ShipmodelRouter.instance.resp_MSG_RESP_SHIPCREATINGCOMPLETE;
         netFunction[MsgTypes._MSG_RESP_CREATESHIPINFO] = ShipmodelRouter.instance.resp_MSG_RESP_CREATESHIPINFO;
         netFunction[MsgTypes._MSG_RESP_SHIPMODELINFODEL] = ShipmodelRouter.instance.resp_MSG_RESP_SHIPMODELINFODEL;
         netFunction[MsgTypes._MSG_RESP_SPEEDSHIP] = ShipmodelRouter.instance.resp_MSG_RESP_SPEEDSHIP;
         netFunction[MsgTypes._MSG_RESP_SHIPBODYINFO] = ShipmodelRouter.instance.resp_MSG_RESP_SHIPBODYINFO;
         netFunction[MsgTypes._MSG_RESP_CREATESHIPMODEL] = ShipmodelRouter.instance.resp_MSG_RESP_CREATESHIPMODEL;
         netFunction[MsgTypes._MSG_RESP_ARRANGESHIPTEAM] = FleetRouter.instance.resp_MSG_RESP_ARRANGESHIPTEAM;
         netFunction[MsgTypes._MSG_RESP_TEAMMODELINFO] = FleetRouter.instance.resp_MSG_RESP_TEAMMODELINFO;
         netFunction[MsgTypes._MSG_RESP_EDITSHIPTEAM] = FleetRouter.instance.resp_MSG_RESP_EDITSHIPTEAM;
         netFunction[MsgTypes._MSG_RESP_COMMANDERINFOARRANGE] = FleetRouter.instance.resp_MSG_RESP_COMMANDERINFOARRANGE;
         netFunction[MsgTypes._MSG_RESP_SHIPBODYUPGRADE] = UpgradeRouter.instance.resp_MSG_RESP_SHIPBODYUPGRADE;
         netFunction[MsgTypes._MSG_RESP_SHIPBODYUPGRADEINFO] = UpgradeRouter.instance.resp_MSG_RESP_SHIPBODYUPGRADEINFO;
         netFunction[MsgTypes._MSG_RESP_SHIPBODYUPGRADECOMPLETE] = UpgradeRouter.instance.resp_MSG_RESP_SHIPBODYUPGRADECOMPLETE;
         netFunction[MsgTypes._MSG_RESP_LOADSHIPTEAM] = LoadHe3Router.instance.resp_MSG_RESP_LOADSHIPTEAM;
         netFunction[MsgTypes._MSG_RESP_UNLOADSHIPTEAM] = LoadHe3Router.instance.resp_MSG_RESP_UNLOADSHIPTEAM;
         netFunction[MsgTypes._MSG_RESP_CONSORTIAINFO] = CorpsRouter.instance.resp_MSG_RESP_CONSORTIAINFO;
         netFunction[MsgTypes._MSG_RESP_CONSORTIAPROCLAIM] = CorpsRouter.instance.resp_MSG_RESP_CONSORTIAPROCLAIM;
         netFunction[MsgTypes._MSG_RESP_CREATECONSORTIA] = CorpsRouter.instance.resp_MSG_RESP_CREATECONSORTIA;
         netFunction[MsgTypes._MSG_RESP_JOINCONSORTIA] = CorpsRouter.instance.resp_MSG_RESP_JOINCONSORTIA;
         netFunction[MsgTypes._MSG_RESP_CONSORTIAMYSELF] = CorpsRouter.instance.resp_MSG_RESP_CONSORTIAMYSELF;
         netFunction[MsgTypes._MSG_RESP_CONSORTIAMEMBER] = CorpsRouter.instance.resp_MSG_RESP_CONSORTIAMEMBER;
         netFunction[MsgTypes._MSG_RESP_CONSORTIAAUTHUSER] = CorpsRouter.instance.resp_MSG_RESP_CONSORTIAAUTHUSER;
         netFunction[MsgTypes._MSG_RESP_OPERATECONSORTIABRO] = CorpsRouter.instance.resp_MSG_RESP_OPERATECONSORTIABRO;
         netFunction[MsgTypes._MSG_RESP_FRIENDLEVEL] = GameKernel.getInstance().resp_MSG_RESP_FRIENDLEVEL;
         netFunction[MsgTypes._MSG_RESP_EMAILINFO] = MailRouter.instance.resp_MSG_RESP_EMAILINFO;
         netFunction[MsgTypes._MSG_RESP_READEMAIL] = MailRouter.instance.resp_MSG_RESP_READEMAIL;
         netFunction[MsgTypes._MSG_RESP_EMAILGOODS] = MailRouter.instance.resp_MSG_RESP_EMAILGOODS;
         netFunction[MsgTypes._MSG_RESP_TRADEGOODS] = MallRouter.instance.resp_MSG_RESP_TRADEGOODS;
         netFunction[MsgTypes._MSG_RESP_MYTRADEINFO] = MallRouter.instance.resp_MSG_RESP_MYTRADEINFO;
         netFunction[MsgTypes._MSG_RESP_TRADEINFO] = MallRouter.instance.resp_MSG_RESP_TRADEINFO;
         netFunction[MsgTypes._MSG_RESP_BUYTRADEGOODS] = MallRouter.instance.resp_MSG_RESP_BUYTRADEGOODS;
         netFunction[MsgTypes._MSG_RESP_FRIENDLIST] = FriendRouter.instance.resp_MSG_RESP_FRIENDLIST;
         netFunction[MsgTypes._MSG_RESP_ADDFRIENDAUTH] = FriendRouter.instance.resp_MSG_RESP_ADDFRIENDAUTH;
         netFunction[MsgTypes._MSG_RESP_FRIENDPASSAUTH] = FriendRouter.instance.resp_MSG_RESP_FRIENDPASSAUTH;
         netFunction[MsgTypes._MSG_RESP_GALAXYINFO] = MapRouter.instance.resp_MSG_RESP_GALAXYINFO;
         netFunction[MsgTypes._MSG_RESP_MOVEHOME] = MapRouter.instance.resp_MSG_RESP_MOVEHOME;
         netFunction[MsgTypes._MSG_RESP_CONSORTIAFIELD] = CorpsRouter.instance.resp_MSG_RESP_CONSORTIAFIELD;
         netFunction[MsgTypes._MSG_RESP_CONSORTIATHROWVALUE] = CorpsRouter.instance.resp_MSG_RESP_CONSORTIATHROWVALUE;
         netFunction[MsgTypes._MSG_RESP_CONSORTIATHROWRANK] = CorpsRouter.instance.resp_MSG_RESP_CONSORTIATHROWRANK;
         netFunction[MsgTypes._MSG_RESP_CONSORTIAGIVEN] = CorpsRouter.instance.resp_MSG_RESP_CONSORTIAGIVEN;
         netFunction[MsgTypes._MSG_RESP_CONSORTIAUPGRADECOMPLETE] = CorpsRouter.instance.resp_MSG_RESP_CONSORTIAUPGRADECOMPLETE;
         netFunction[MsgTypes._MSG_RESP_CONSORTIAUPGRADE] = CorpsRouter.instance.resp_MSG_RESP_CONSORTIAUPGRADE;
         netFunction[MsgTypes._MSG_RESP_CONSORTIAUPGRADECANCEL] = CorpsRouter.instance.resp_MSG_RESP_CONSORTIAUPGRADECANCEL;
         netFunction[MsgTypes._MSG_RESP_EXCHANGERES] = ConstructionRouter.getInstance().resp_MSG_RESP_EXCHANGERES;
         netFunction[MsgTypes._MSG_RESP_BUYGOODS] = MallRouter.instance.resp_MSG_RESP_BUYGOODS;
         netFunction[MsgTypes._MSG_RESP_SPEEDSHIPBODYUPGRADE] = UpgradeRouter.instance.resp_MSG_RESP_SPEEDSHIPBODYUPGRADE;
         netFunction[MsgTypes._MSG_RESP_GOTORESOURCESTAR] = CorpsRouter.instance.Resp_MSG_RESP_GOTORESOURCESTAR;
         netFunction[MsgTypes._MSG_RESP_DEALCONSORTIAAUTHUSER] = CorpsRouter.instance.resp_MSG_RESP_DEALCONSORTIAAUTHUSER;
         netFunction[MsgTypes._MSG_RESP_TASKINFO] = TaskRouter.instance.resp_MSG_RESP_TASKINFO;
         netFunction[MsgTypes._MSG_RESP_TASKGAIN] = TaskRouter.instance.resp_MSG_RESP_TASKGAIN;
         netFunction[MsgTypes._MSG_RESP_LOADSHIPTEAMALL] = LoadHe3Router.instance.resp_MSG_RESP_LOADSHIPTEAMALL;
         netFunction[MsgTypes._MSG_RESP_CANCELJUMPSHIPTEAM] = MapRouter.instance.resp_MSG_RESP_CANCELJUMPSHIPTEAM;
         netFunction[MsgTypes._MSG_RESP_VIEWJUMPSHIPTEAM] = MapRouter.instance.resp_MSG_RESP_VIEWJUMPSHIPTEAM;
         netFunction[MsgTypes._MSG_RESP_FIELDRESOURCE] = FieldRouter.instance.resp_MSG_RESP_FIELDRESOURCE;
         netFunction[MsgTypes._MSG_RESP_GROWFIELDRESOURCE] = FieldRouter.instance.resp_MSG_RESP_GROWFIELDRESOURCE;
         netFunction[MsgTypes._MSG_RESP_GETFIELDRESOURCE] = FieldRouter.instance.resp_MSG_RESP_GETFIELDRESOURCE;
         netFunction[MsgTypes._MSG_RESP_THIEVEFIELDRESOURCE] = FieldRouter.instance.resp_MSG_RESP_THIEVEFIELDRESOURCE;
         netFunction[MsgTypes._MSG_RESP_NEWEMAILNOTICE] = MailRouter.instance.resp_MSG_RESP_NEWEMAILNOTICE;
         netFunction[MsgTypes._MSG_RESP_FIELDRESOURCELOG] = FieldRouter.instance.resp_MSG_RESP_FIELDRESOURCELOG;
         netFunction[MsgTypes._MSG_RESP_UNIONCOMMANDERCARD] = ComposeRouter.instance.resp_MSG_RESP_UNIONCOMMANDERCARD;
         netFunction[MsgTypes._MSG_RESP_UNIONDOUBLESKILLCARD] = ComposeRouter.instance.resp_MSG_RESP_UNIONDOUBLESKILLCARD;
         netFunction[MsgTypes._MSG_RESP_ADDFRIEND] = FriendRouter.instance.resp_MSG_RESP_ADDFRIEND;
         netFunction[MsgTypes._MSG_RESP_MOVEHOMEBRO] = MapRouter.instance.resp_MSG_RESP_MOVEHOMEBRO;
         netFunction[MsgTypes._MSG_RESP_JUMPSHIPTEAMNOTICE] = RadarRouter.instance.resp_MSG_RESP_JUMPSHIPTEAMNOTICE;
         netFunction[MsgTypes._MSG_RESP_CONSORTIAATTACKINFO] = CorpsRouter.instance.resp_MSG_RESP_CONSORTIAATTACKINFO;
         netFunction[MsgTypes._MSG_RESP_HELPFIELDCENTERRESOURCE] = FieldRouter.instance.resp_MSG_RESP_HELPFIELDCENTERRESOURCE;
         netFunction[MsgTypes._MSG_RESP_GAINDAILYAWARD] = TaskRouter.instance.resp_MSG_RESP_GAINDAILYAWARD;
         netFunction[MsgTypes._MSG_RESP_CONSORTIAUPDATAVALUE] = CorpsRouter.instance.resp_MSG_RESP_CONSORTIAUPDATAVALUE;
         netFunction[MsgTypes._MSG_RESP_FRIENDFIELDSTATUS] = FieldRouter.instance.resp_MSG_RESP_FRIENDFIELDSTATUS;
         netFunction[MsgTypes._MSG_RESP_GAMESERVERLIST] = ChangeServerRouter.instance.resp_MSG_RESP_GAMESERVERLIST;
         netFunction[MsgTypes._MSG_RESP_CHANGESERVER] = ChangeServerRouter.instance.resp_MSG_RESP_CHANGESERVER;
         netFunction[MsgTypes._MSG_RESP_CONSORTIABUYGOODS] = CorpsRouter.instance.resp_MSG_RESP_CONSORTIABUYGOODS;
         netFunction[MsgTypes._MSG_RESP_CONSORTIAEVENT] = CorpsRouter.instance.resp_MSG_RESP_CONSORTIAEVENT;
         netFunction[MsgTypes._MSG_RESP_UNIONCOMMANDERCARDBRO] = ComposeRouter.instance.resp_MSG_RESP_UNIONCOMMANDERCARDBRO;
         netFunction[MsgTypes._MSG_RESP_INSERTFLAGCONSORTIAIMEMBER] = CorpsRouter.instance.resp_MSG_RESP_INSERTFLAGCONSORTIAIMEMBER;
         netFunction[MsgTypes._MSG_RESP_COMMANDERUNIONSTONE] = ComposeRouter.instance.resp_MSG_RESP_COMMANDERUNIONSTONE;
         netFunction[MsgTypes._MSG_RESP_COMMANDERINSERTSTONE] = ComposeRouter.instance.resp_MSG_RESP_COMMANDERINSERTSTONE;
         netFunction[MsgTypes._MSG_RESP_DELETESERVER] = ChangeServerRouter.instance.Resp_MSG_RESP_DELETESERVER;
         netFunction[MsgTypes._MSG_RESP_BRUISESHIPINFO] = ShipPairRouter.instance.resp_MSG_RESP_BRUISESHIPINFO;
         netFunction[MsgTypes._MSG_RESP_SPEEDBRUISESHIP] = ShipPairRouter.instance.resp_MSG_RESP_SPEEDBRUISESHIP;
         netFunction[MsgTypes._MSG_RESP_BRUISESHIPRELIVE] = ShipPairRouter.instance.resp_MSG_RESP_BRUISESHIPRELIVE;
         netFunction[MsgTypes._MSG_RESP_BRUISESHIPDELETE] = ShipPairRouter.instance.resp_MSG_RESP_BRUISESHIPDELETE;
         netFunction[MsgTypes._MSG_RESP_COMMANDERCARDBRO] = ComposeRouter.instance.resp_MSG_RESP_COMMANDERCARDBRO;
         netFunction[MsgTypes._MSG_RESP_CONSORTIAPIRATECHOOSE] = CorpsRouter.instance.resp_MSG_RESP_CONSORTIAPIRATECHOOSE;
         netFunction[MsgTypes._MSG_RESP_CONSORTIAPIRATEBRO] = CorpsRouter.instance.resp_MSG_RESP_CONSORTIAPIRATEBRO;
         netFunction[MsgTypes._MSG_RESP_REFRESHWALL] = ComposeRouter.instance.resp_MSG_RESP_REFRESHWALL;
         netFunction[MsgTypes._MSG_RESP_PASS_TOLLGATE] = MapRouter.instance.resp_MSG_RESP_PASS_TOLLGATE;
         netFunction[MsgTypes._MSG_RESP_ONLINEAWARD] = RewardRouter.instance.Resp_MSG_RESP_ONLINEAWARD;
         netFunction[MsgTypes._MSG_RESP_GETONLINEAWARD] = RewardRouter.instance.Resp_MSG_RESP_GETONLINEAWARD;
         netFunction[MsgTypes._MSG_RESP_UNIONFLAGSHIP] = ComposeRouter.instance.resp_MSG_RESP_UNIONFLAGSHIP;
         netFunction[MsgTypes._MSG_RESP_UNIONSHIPPROPS] = ComposeRouter.instance.resp_MSG_RESP_UNIONSHIPPROPS;
         netFunction[MsgTypes._MSG_RESP_CMOSLOTTERYINFO] = ChipLotteryRouter.instance.Resp_MSG_RESP_CMOSLOTTERYINFO;
         netFunction[MsgTypes._MSG_RESP_GAINCMOSLOTTERY] = ChipLotteryRouter.instance.Resp_MSG_RESP_GAINCMOSLOTTERY;
         netFunction[MsgTypes._MSG_RESP_COMMANDERINSERTCMOS] = ComposeRouter.instance.Resp_MSG_RESP_COMMANDERINSERTCMOS;
         netFunction[MsgTypes._MSG_RESP_UPGRADEFLAGSHIP] = UpgradeRouter.instance.Resp_MSG_RESP_UPGRADEFLAGSHIP;
         netFunction[MsgTypes._MSG_RESP_UPGRADESHIPPROPS] = UpgradeRouter.instance.Resp_MSG_RESP_UPGRADESHIPPROPS;
         netFunction[MsgTypes._MSG_RESP_COMMANDERPROPERTYSTONE] = ComposeRouter.instance.Resp_MSG_RESP_COMMANDERPROPERTYSTONE;
         netFunction[MsgTypes._MSG_CHAT_MESSAGE] = ChatRouter.getInstance().resp_Msg_ChatMessage;
         netFunction[MsgTypes._MSG_RESP_USERINFO] = ChatRouter.getInstance().resp_Msg_UserInfo;
         netFunction[MsgTypes._MSG_RESP_GALAXYBROADCAST] = ChatRouter.getInstance().resp_Msg_GALAXYBROADCAST;
         netFunction[MsgTypes._MSG_RESP_RANKCENT] = RankRouter.getinstance().resp_MSG_RESP_RANKCENT;
         netFunction[MsgTypes._MSG_RESP_RANKKILLTOTAL] = RankRouter.getinstance().resp_MSG_RESP_RANKKILLTOTAL;
         netFunction[MsgTypes._MSG_RESP_CONSORTIARANK] = RankRouter.getinstance().resp_MSG_RESP_CONSORTIARANK;
         netFunction[MsgTypes._MSG_RESP_RANKFIGHT] = RankRouter.getinstance().resp_MSG_RESP_RANKFIGHT;
         netFunction[MsgTypes._MSG_RESP_RANKMATCH] = LeaguerangeRouter.getInstance().resp_MSG_RESP_RANKMATCH;
         netFunction[MsgTypes._MSG_RESP_TECHINFO] = ScienceSystem.getinstance().read_MSG_RESP_TECHINFO;
         netFunction[MsgTypes._MSG_RESP_CREATETECH] = ScienceSystem.getinstance().read_MSG_RESP_CREATETECH;
         netFunction[MsgTypes._MSG_RESP_TECHUPGRADEINFO] = ScienceSystem.getinstance().read_MSG_RESP_TECHUPGRADEINFO;
         netFunction[MsgTypes._MSG_RESP_CREATETECHCOMPLETE] = ScienceSystem.getinstance().read_MSG_RESP_CREATETECHCOMPLETE;
         netFunction[MsgTypes._MSG_RESP_CANCELTECH] = ScienceSystem.getinstance().read_MSG_RESP_CANCELTECH;
         netFunction[MsgTypes._MSG_RESP_SPEEDTECH] = ScienceSystem.getinstance().read_MSG_RESP_SPEEDTECH;
         netFunction[MsgTypes._MSG_RESP_PROPSINFO] = ScienceSystem.getinstance().read_MSG_RESP_PROPSINFO;
         netFunction[MsgTypes._MSG_RESP_USEPROPS] = ScienceSystem.getinstance().read_MSG_RESP_USEPROPS;
         netFunction[MsgTypes._MSG_RESP_ADDPACK] = ScienceSystem.getinstance().read_MSG_RESP_ADDPACK;
         netFunction[MsgTypes._MSG_RESP_DELETEPROPS] = ScienceSystem.getinstance().read_MSG_RESP_DELETEPROPS;
         netFunction[MsgTypes._MSG_RESP_PROPSMOVE] = ScienceSystem.getinstance().read_MSG_RESP_PROPSMOVE;
         netFunction[MsgTypes._MSG_RESP_UNBINDCOMMANDERCARD] = ScienceSystem.getinstance().read_MSG_RESP_UNBINDCOMMANDERCARD;
         netFunction[MsgTypes._MSG_RESP_GAINLOTTERY] = ScienceSystem.getinstance().read_MSG_RESP_GAINLOTTERY;
         netFunction[MsgTypes._MSG_RESP_LOTTERYSTATUS] = ScienceSystem.getinstance().read_MSG_RESP_LOTTERYSTATUS;
         netFunction[MsgTypes._MSG_RESP_RACINGINFO] = GymkhanaRouter.getinstance().resp_MSG_RESP_RACINGINFO;
         netFunction[MsgTypes._MSG_RESP_RACINGBATTLE] = GymkhanaRouter.getinstance().resp_MSG_RESP_RACINGBATTLE;
         netFunction[MsgTypes._MSG_RESP_RACINGAWARD] = GymkhanaRouter.getinstance().resp_MSG_RESP_RACINGAWARD;
         netFunction[MsgTypes._MSG_RESP_SETRACINGSHIPTEAM] = GymkhanaRouter.getinstance().resp_MSG_RESP_SETRACINGSHIPTEAM;
         netFunction[MsgTypes._MSG_RESP_RACINGINFOSHIPTEAM] = GymkhanaRouter.getinstance().resp_MSG_RESP_RACINGINFOSHIPTEAM;
         netFunction[MsgTypes._MSG_DUPLICATE_STATUS] = GymkhanaRouter.getinstance().resp_MSG_DUPLICATE_STATUS;
         netFunction[MsgTypes._MSG_RESP_RACINGRANK] = GymkhanaRouter.getinstance().resp_MSG_RACINGRANK;
         netFunction[MsgTypes._MSG_RESP_DESTROYSHIP] = DestructionShipRouter.instance.resp_MSG_RESP_DESTROYSHIP;
         netFunction[MsgTypes._MSG_RESP_PAYMENTSUCCEED] = GameRouter.instance.Resp_MSG_RESP_PAYMENTSUCCEED;
         netFunction[MsgTypes._MSG_RESP_ARENA_STATUS] = InstanceManager.instance.Resp_MSG_RESP_ARENA_STATUS;
         netFunction[MsgTypes._MSG_RESP_ARENA_PAGE] = InstanceManager.instance.Resp_MSG_RESP_ARENA_PAGE;
         netFunction[MsgTypes._MSG_RESP_CAPTURE_ARK_LIST] = RaidPropsRouter.instance.resp_MSG_RESP_CAPTURE_ARK_LIST;
         netFunction[MsgTypes._MSG_RESP_CAPTURE_ARK_ROOM] = RaidPropsRouter.instance.resp_MSG_RESP_CAPTURE_ARK_ROOM;
         netFunction[MsgTypes._MSG_RESP_CAPTURE_ARK_INFO] = RaidPropsRouter.instance.resp_MSG_RESP_CAPTURE_ARK_INFO;
         netFunction[MsgTypes._MSG_RESP_DUPLICATE_BATTLE] = RaidPropsRouter.instance.resp_MSG_RESP_DUPLICATE_BATTLE;
         netFunction[MsgTypes._MSG_RESP_CAPTURE_BULLETIN] = RaidPropsRouter.instance.resp_MSG_RESP_CAPTURE_BULLETIN;
         netFunction[MsgTypes._MSG_RESP_WARFIELD_STATUS] = BattleFieldRouter.instance.resp_MSG_RESP_WARFIELD_STATUS;
         netFunction[MsgTypes._MSG_RESP_DUPLICATE_BULLETIN] = BattleFieldRouter.instance.resp_MSG_RESP_DUPLICATE_BULLETIN;
         netFunction[MsgTypes._MSG_RESP_WARFIELD_PAGE] = RankRouter.getinstance().resp_MSG_RESP_WARFIELD_PAGE;
         netFunction[MsgTypes._MSG_RESP_WARFIELD_PLAYERLIST] = BattleFieldRouter.instance.resp_MSG_RESP_WARFIELD_PLAYERLIST;
         netFunction[5000] = CustomRouter.instance.Resp_MSG_RESP_CUSTOM_WARN;
         netFunction[5001] = CustomRouter.instance.Resp_MSG_RESP_CUSTOM_MOREINFO;
         netFunction[5002] = CustomRouter.instance.Resp_MSG_RESP_CUSTOM_CONFIGURATION;
      }
      
      private function netConnect() : void
      {
         var _loc1_:MSG_CLIENT_LOGINTOG = null;
         var _loc2_:MSG_CLIENT_LOGINTOL = null;
         var _loc3_:MSG_CLIENT_LOGINTOL = null;
         if(ConnLoginServer && this.ConnGameServer && !ConnCheckServer)
         {
            Log.SaveLog(1004);
            _loc1_ = new MSG_CLIENT_LOGINTOG();
            _loc1_.UserId = this.userId;
            _loc1_.RegisterFlag = GamePlayer.getInstance().RegisterFlag;
            _loc1_.RegisterName = GamePlayer.getInstance().RegisterName;
            _loc1_.CheckOutText = this.checkOutText;
            if(this.sessionKey != null)
            {
               _loc1_.SessionKey = this.sessionKey;
            }
            else
            {
               _loc1_.SessionKey = "7eadc7ea59c0751b554bc298a8cc8123";
            }
            if(_loc1_.RegisterFlag == 1)
            {
               GameServerListUI.GetInstance().Release();
               getTimer();
            }
            NetManager.Instance().sendObject(_loc1_);
            _loc1_.RegisterName = "";
            _loc1_.RegisterFlag = 0;
            this.ConnGameServer = false;
         }
         else if(ConnCheckServer)
         {
            Log.SaveLog(10032);
            _loc2_ = new MSG_CLIENT_LOGINTOL();
            _loc2_.UserId = NetRouter.Instance().userId;
            _loc2_.RegisterFlag = 1;
            _loc2_.RegisterName = GameServerListUI.GetInstance().PlayerNewName;
            GamePlayer.getInstance().RegisterFlag = _loc2_.RegisterFlag;
            GamePlayer.getInstance().RegisterName = GameServerListUI.GetInstance().PlayerNewName;
            if(NetRouter.Instance().sessionKey != null)
            {
               _loc2_.SessionKey = NetRouter.Instance().sessionKey;
            }
            else
            {
               _loc2_.SessionKey = "";
            }
            if(GameServerListUI.GetInstance().ServerID == -1)
            {
               GameServerListUI.GetInstance().ServerID = GamePlayer.getInstance().DefaultServerId;
            }
            _loc2_.GameServerId = GameServerListUI.GetInstance().ServerID;
            NetManager.Instance().sendObject(_loc2_);
            RenderManager.getInstance().lockScene(false);
            ConnCheckServer = false;
         }
         else
         {
            Log.SaveLog(1003);
            _loc3_ = new MSG_CLIENT_LOGINTOL();
            _loc3_.UserId = this.userId;
            if(this.sessionKey != null)
            {
               _loc3_.SessionKey = this.sessionKey;
            }
            else
            {
               _loc3_.SessionKey = "";
            }
            _loc3_.GameServerId = -1;
            this.ConnGameServer = true;
            NetManager.Instance().sendObject(_loc3_);
            _loc3_ = null;
         }
      }
      
      public function StopReconnectTimer() : void
      {
         if(this.TimeoutValue > 0)
         {
            clearTimeout(this.TimeoutValue);
         }
      }
      
      private function netDisconnect() : void
      {
         if(GameKernel.getInstance().isInit == false)
         {
            NetManager.Instance().stopCount();
            this.StopReconnectTimer();
            this.TimeoutValue = setTimeout(this.ReLogin,5000);
         }
         else
         {
            ErrorPopup.getInstance().Init();
            ErrorPopup.getInstance().setErrorMsg(StringManager.getInstance().getMessageString("Server25"));
         }
      }
      
      private function netError() : void
      {
         if(GameKernel.getInstance().isInit == false)
         {
            NetManager.Instance().stopCount();
            this.StopReconnectTimer();
            this.TimeoutValue = setTimeout(this.ReLogin,5000);
         }
         else
         {
            ErrorPopup.getInstance().Init();
            ErrorPopup.getInstance().setErrorMsg(StringManager.getInstance().getMessageString("Server26"));
         }
      }
      
      private function ReLogin() : void
      {
         this.TimeoutValue = -1;
         NetManager.Instance().OnLogin(GamePlayer.getInstance().userID,GamePlayer.getInstance().sessionKey);
      }
   }
}

