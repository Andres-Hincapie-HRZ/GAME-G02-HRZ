package logic.entry
{
   import com.star.frameworks.managers.StringManager;
   import flash.display.MovieClip;
   import logic.action.GalaxyMapAction;
   import logic.game.GameKernel;
   import logic.game.GameStateManager;
   import logic.manager.GalaxyManager;
   import logic.reader.CPlayerLevelsReader;
   import logic.ui.EnjoyUi;
   import logic.ui.FillGamePlayerInfoUI;
   import logic.ui.GameDateTaskUI;
   import logic.ui.PlayerInfoUI;
   import logic.ui.ResPlaneUI;
   import logic.ui.TaskSceneUI;
   import net.base.NetManager;
   import net.msg.MSG_REQUEST_COMPLETEGUIDE;
   import net.msg.MSG_REQUEST_PLAYERINFO;
   import net.msg.MSG_RESP_PLAYERRESOURCE;
   import net.msg.MSG_ROLE_INFO;
   import net.msg.reward.MSG_RESP_ONLINEAWARD;
   
   public class GamePlayer
   {
      
      private static var instance:GamePlayer = null;
      
      public var m_speedcreateShipTime:int = 0;
      
      public var m_DecreaseShipMetalConsume:int = 0;
      
      public var m_DecreaseShipHe3Consume:int = 0;
      
      public var m_DecreaseShipMoneyConsume:int = 0;
      
      public var m_IfbeingCreatShip:Boolean;
      
      public var AddThorNum:int = 0;
      
      public var AddBuiltNum:Number = 0;
      
      public var ScienceOjbect:Object = new Object();
      
      public var m_ParallelCreateShip:int = 0;
      
      public var seqID:int = 1;
      
      public var userID:Number = 0;
      
      public var sessionKey:String;
      
      public var giftId:int = -1;
      
      public var gameUrl:String;
      
      public var language:int = 0;
      
      public var isFan:int = 0;
      
      public var serverPort:int = 0;
      
      public var isCanSearchAll:int = 1;
      
      public var mutetime:int;
      
      public var logOutTime:int;
      
      public var readPackNum:int;
      
      public var isGm:int;
      
      public var DefaultName:String;
      
      public var Name:String;
      
      public var cJob:int;
      
      public var ucGender:int;
      
      public var Guid:int;
      
      public var GmFlag:int;
      
      public var Credit:int;
      
      public var Sign:String;
      
      public var consortiaId:int = -1;
      
      public var consortiaName:String;
      
      public var ClientActiveTime:int;
      
      public var GameSign:String;
      
      public var UserMoney:int;
      
      public var UserCrystal:int;
      
      public var UserHe3:int;
      
      public var UserMetal:int;
      
      public var UserPopulation:int;
      
      public var ResGas:int;
      
      public var ResStorageGas:int;
      
      public var ResMetal:int;
      
      public var ResStorageMetal:int;
      
      public var ResMoney:int;
      
      public var ResStorageMoney:int;
      
      public var OutGas:int;
      
      public var OutMetal:int;
      
      public var OutMoney:int;
      
      public var MaxSpValue:int;
      
      public var SpValue:int;
      
      public var MoneyBuyNum:int;
      
      public var currentWealth:int;
      
      public var HeadId:int;
      
      public var KeyData:int;
      
      public var imageUrl:String;
      
      public var srcUserId:Number = 0;
      
      public var objUserId:Number = 0;
      
      public var coins:int;
      
      public var cash:int;
      
      public var exp:int;
      
      public var level:int = -1;
      
      public var commandernum:int;
      
      public var isLoadOver:Boolean = false;
      
      public var isLogin:Boolean = false;
      
      public var logoutExp:int;
      
      public var logoutCoins:int;
      
      public var cashEmployee:int;
      
      public var isShowLevelUp:Boolean = false;
      
      public var isShowOnlineAward:Boolean = false;
      
      public var constructionProgressNum:int = 1;
      
      public var IncreaseBuildQueue:int = 0;
      
      public var constructionQueueOpenNum:int = 0;
      
      public var galaxyMapID:int = -1;
      
      public var galaxyID:int = -1;
      
      public var galaxyStar:GStar = null;
      
      public var PropsPack:int;
      
      public var PropsCorpsPack:int;
      
      public var req_GalaxyID:int = -1;
      
      public var Guide:int;
      
      public var ConsortiaJob:int;
      
      public var ConsortiaUnionLevel:int;
      
      public var ConsortiaShopLevel:int;
      
      public var GameServerId:int;
      
      public var Commander_Card:int;
      
      public var Commander_Credit:int;
      
      public var Commander_Card2:int;
      
      public var Commander_Card3:int;
      
      public var Commander_CardUnion:int;
      
      public var TechQueueCredit:int;
      
      public var LotteryCredit:int;
      
      public var ShipSpeedCredit:int;
      
      public var LotteryStatus:int;
      
      public var ConsortiaThrowValue:int;
      
      public var ConsortiaUnionValue:int;
      
      public var ConsortiaShopValue:int;
      
      public var DefaultServerId:int;
      
      public var NewServerID:int;
      
      public var RegisterFlag:int = 0;
      
      public var RegisterName:String = "";
      
      private var taskMc:MovieClip;
      
      public var isGuideComplete:Boolean;
      
      public var AddPackMoney:int;
      
      public var DefyEctypeNum:int;
      
      public var MatchCount:int;
      
      public var Badge:int;
      
      public var Honor:int;
      
      public var ChargeFlag:int;
      
      public var MvpUrl:String;
      
      public var IsGlobal:String;
      
      public var TollGate:int;
      
      public var RewardMsg:MSG_RESP_ONLINEAWARD;
      
      public var VipBuffer:Boolean;
      
      public var ServerDate:Date;
      
      public function GamePlayer()
      {
         super();
         this.VipBuffer = false;
         this.isGuideComplete = false;
      }
      
      public static function getInstance() : GamePlayer
      {
         if(instance == null)
         {
            instance = new GamePlayer();
         }
         return instance;
      }
      
      public function init(param1:MSG_ROLE_INFO) : void
      {
         this.galaxyMapID = param1.GalaxyMapId;
         this.galaxyID = param1.GalaxyId;
         this.consortiaId = param1.ConsortiaId;
         this.PropsPack = param1.PropsPack;
         this.PropsCorpsPack = param1.PropsCorpsPack;
         this.ConsortiaJob = param1.ConsortiaJob;
         this.ConsortiaUnionLevel = param1.ConsortiaUnionLevel;
         this.ConsortiaShopLevel = param1.ConsortiaShopLevel;
         this.GameServerId = param1.GameServerId;
         this.TollGate = param1.TollGate;
         GalaxyMapAction.instance.RefreshServerName();
         this.Commander_Card = param1.Commander_Card;
         this.Commander_Credit = param1.Commander_Credit;
         this.Commander_Card2 = param1.Commander_Card2;
         this.Commander_Card3 = param1.Commander_Card3;
         this.Commander_CardUnion = param1.Commander_CardUnion;
         this.ConsortiaThrowValue = param1.ConsortiaThrowValue;
         this.ConsortiaUnionValue = param1.ConsortiaUnionValue;
         this.ConsortiaShopValue = param1.ConsortiaShopValue;
         this.ServerDate = new Date(param1.Year,param1.Month - 1,param1.Day);
         ResPlaneUI.getInstance().ServerTime = param1.ServerTime;
         this.LotteryCredit = param1.LotteryCredit;
         this.TechQueueCredit = 0;
         this.ChargeFlag = param1.ChargeFlag;
         if(param1.ChargeFlag > 0)
         {
            ResPlaneUI.getInstance().btn_mvp.setVisible(true);
         }
         this.LotteryStatus = param1.LotteryStatus;
         this.ShipSpeedCredit = param1.ShipSpeedCredit;
         this.AddPackMoney = param1.AddPackMoney;
         this.Name = param1.Name;
         this.DefyEctypeNum = param1.DefyEctypeNum;
         this.Honor = param1.Honor;
         this.Badge = param1.Badge;
         if(!this.galaxyStar)
         {
            this.galaxyStar = new GStar(this.galaxyID,GalaxyType.GT_4);
            this.galaxyStar.GalaxyMapId = this.galaxyMapID;
         }
         GalaxyMapAction.instance.curStar = this.galaxyStar;
         GalaxyManager.instance.enterStar = this.galaxyStar;
         if(this.Name == "" || this.Name == null)
         {
            FillGamePlayerInfoUI.getInstance().Init();
         }
         if(GameDateTaskUI.IsShow)
         {
            GameDateTaskUI.GetInstance().UpdateLottery();
         }
      }
      
      public function sendGameGuidCompletedState() : void
      {
         var _loc1_:MSG_REQUEST_COMPLETEGUIDE = new MSG_REQUEST_COMPLETEGUIDE();
         _loc1_.Guid = this.Guid;
         _loc1_.SeqId = this.seqID++;
         NetManager.Instance().sendObject(_loc1_);
         this.isGuideComplete = false;
      }
      
      public function updatePlayerResource(param1:MSG_RESP_PLAYERRESOURCE) : void
      {
         if(GameStateManager.playerPlace == GamePlaceType.PLACE_HOME)
         {
            GamePlayer.getInstance().UserMetal = param1.UserMetal;
            GamePlayer.getInstance().UserHe3 = param1.UserGas;
            GamePlayer.getInstance().UserMoney = param1.UserMoney;
            GamePlayer.getInstance().cash = param1.Credit;
            GamePlayer.getInstance().exp = param1.Exp;
            GamePlayer.getInstance().DefyEctypeNum = param1.DefyEctypeNum;
            GamePlayer.getInstance().MatchCount = param1.MatchCount;
            GamePlayer.getInstance().TollGate = param1.TollGate;
            if(param1.Level == 0 || GamePlayer.getInstance().level != param1.Level)
            {
               if(GamePlayer.getInstance().level != -1 && param1.Level + 1 >= 10 && (param1.Level + 1) % 10 == 0)
               {
                  EnjoyUi.getInstance().PublishMessage(StringManager.getInstance().getMessageString("EmailText39"),StringManager.getInstance().getMessageString("EmailText29"),StringManager.getInstance().getMessageString("EmailText30"),"LvIncrease",StringManager.getInstance().getMessageString("Publish_2"));
               }
               GamePlayer.getInstance().level = param1.Level;
               GamePlayer.getInstance().commandernum = CPlayerLevelsReader.getInstance().Read(param1.Level).CommanderNum;
            }
            GamePlayer.getInstance().coins = param1.Coins;
            GamePlayer.getInstance().OutGas = param1.OutGas;
            GamePlayer.getInstance().OutMetal = param1.OutMetal;
            GamePlayer.getInstance().OutMoney = param1.OutMoney;
            GamePlayer.getInstance().MaxSpValue = param1.MaxSpValue;
            GamePlayer.getInstance().SpValue = param1.SpValue;
            GamePlayer.getInstance().MoneyBuyNum = param1.MoneyBuyNum;
            ResPlaneUI.getInstance().updateResPlane();
            PlayerInfoUI.getInstance().bindPlayerInfo();
         }
      }
      
      public function isYourHome() : Boolean
      {
         return this.srcUserId == this.objUserId ? true : false;
      }
      
      public function handlerGameServerRequest() : void
      {
         var _loc1_:MSG_REQUEST_PLAYERINFO = new MSG_REQUEST_PLAYERINFO();
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.HdFlag = GameKernel.platform2;
         NetManager.Instance().sendObject(_loc1_);
         TaskSceneUI.getInstance().StartTaskTimer();
      }
      
      public function DisabledForVersion() : Boolean
      {
         return this.language >= 10;
      }
   }
}

