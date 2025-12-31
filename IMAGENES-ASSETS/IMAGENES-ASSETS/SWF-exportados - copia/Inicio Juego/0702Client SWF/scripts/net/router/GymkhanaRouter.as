package net.router
{
   import flash.utils.ByteArray;
   import logic.action.ConstructionAction;
   import logic.entry.GamePlayer;
   import logic.ui.GymkhanaUI;
   import logic.ui.MallBuyModulesPopup;
   import logic.ui.RacerankingSceneUI;
   import logic.widget.ConstructionOperationWidget;
   import logic.widget.OperationEnum;
   import net.base.NetManager;
   import net.msg.gymkhanaMSg.*;
   
   public class GymkhanaRouter
   {
      
      private static var instance:GymkhanaRouter = null;
      
      public var InShipAry:Array = new Array();
      
      public var OutShipAry:Array = new Array();
      
      public var EnemyDataAry:Array = new Array();
      
      public var RacingReportAry:Array = new Array();
      
      public var RankId:int;
      
      public var RewardValue:int;
      
      public var RacingNum:int;
      
      public var RacingRewardFlag:int;
      
      public var m_racingPageId:int;
      
      public var m_userCount:int;
      
      public function GymkhanaRouter()
      {
         super();
      }
      
      public static function getinstance() : GymkhanaRouter
      {
         if(instance == null)
         {
            instance = new GymkhanaRouter();
         }
         return instance;
      }
      
      public function REQUEST_JOINRACING(param1:int) : void
      {
         var _loc2_:MSG_REQUEST_JOINRACING = new MSG_REQUEST_JOINRACING();
         _loc2_.UserId = param1;
         NetManager.Instance().sendObject(_loc2_);
      }
      
      public function REQUEST_RACINGINFO(param1:int) : void
      {
         this.InShipAry.splice(0);
         this.OutShipAry.splice(0);
         this.OutShipAry.length = 0;
         var _loc2_:MSG_REQUEST_RACINGINFO = new MSG_REQUEST_RACINGINFO();
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         _loc2_.UserId = param1;
         NetManager.Instance().sendObject(_loc2_);
      }
      
      public function resp_MSG_RESP_RACINGINFO(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc10_:RacingEnemyInfo = null;
         var _loc11_:RacingEnemyInfo = null;
         var _loc12_:Boolean = false;
         var _loc13_:int = 0;
         var _loc14_:RacingEnemyInfo = null;
         var _loc15_:RacingReportInfo = null;
         var _loc16_:RacingReportInfo = null;
         var _loc4_:MSG_RESP_RACINGINFO = new MSG_RESP_RACINGINFO();
         NetManager.Instance().readObject(_loc4_,param3);
         this.RankId = _loc4_.RankId;
         this.RewardValue = _loc4_.RewardValue;
         this.RacingRewardFlag = _loc4_.RacingRewardFlag;
         this.RacingNum = _loc4_.RacingNum;
         var _loc5_:int = _loc4_.EnemyLen;
         var _loc6_:int = _loc4_.ReportLen;
         var _loc7_:int = _loc4_.UserId;
         this.EnemyDataAry.length = 0;
         this.RacingReportAry.length = 0;
         var _loc8_:int = 0;
         while(_loc8_ < _loc5_)
         {
            _loc10_ = _loc4_.EnemyData[_loc8_] as RacingEnemyInfo;
            _loc11_ = new RacingEnemyInfo();
            _loc11_.UserId = _loc10_.UserId;
            _loc11_.RankId = _loc10_.RankId;
            _loc11_.GameServerId = _loc10_.GameServerId;
            _loc11_.Name = _loc10_.Name;
            _loc12_ = false;
            _loc13_ = 0;
            while(_loc13_ < this.EnemyDataAry.length)
            {
               _loc14_ = this.EnemyDataAry[_loc13_] as RacingEnemyInfo;
               if(_loc11_.RankId < _loc14_.RankId)
               {
                  if(_loc13_ == 0)
                  {
                     this.EnemyDataAry.unshift(_loc11_);
                  }
                  else
                  {
                     this.EnemyDataAry.splice(_loc13_ - 1,0,_loc11_);
                  }
                  _loc12_ = true;
                  break;
               }
               _loc13_++;
            }
            if(_loc12_ == false)
            {
               this.EnemyDataAry.push(_loc11_);
            }
            _loc8_++;
         }
         var _loc9_:int = 0;
         while(_loc9_ < _loc6_)
         {
            _loc15_ = _loc4_.ReportData[_loc9_] as RacingReportInfo;
            _loc16_ = new RacingReportInfo();
            _loc16_.Type = _loc15_.Type;
            _loc16_.Time = _loc15_.Time;
            _loc16_.ReportDate = _loc15_.ReportDate;
            _loc16_.RankChange = _loc15_.RankChange;
            _loc16_.Name = _loc15_.Name;
            this.RacingReportAry.push(_loc16_);
            _loc9_++;
         }
         GymkhanaUI.getInstance().showList();
      }
      
      public function REQUEST_RACINGBATTLE(param1:Number, param2:Number) : void
      {
         var _loc3_:MSG_REQUEST_RACINGBATTLE = new MSG_REQUEST_RACINGBATTLE();
         _loc3_.SeqId = GamePlayer.getInstance().seqID++;
         _loc3_.Guid = GamePlayer.getInstance().Guid;
         _loc3_.UserId = param1;
         _loc3_.ObjUserId = param2;
         NetManager.Instance().sendObject(_loc3_);
      }
      
      public function resp_MSG_RESP_RACINGBATTLE(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_RACINGBATTLE = new MSG_RESP_RACINGBATTLE();
         NetManager.Instance().readObject(_loc4_,param3);
         var _loc5_:int = _loc4_.ErrorCode;
         var _loc6_:int = _loc4_.UserId;
         if(_loc5_ == 1)
         {
            GymkhanaUI.getInstance().addBackMC();
            ConstructionOperationWidget.currenCmd = OperationEnum.OPERATION_TYPE_NOJOIN;
            MallBuyModulesPopup.getInstance().Init();
            MallBuyModulesPopup.getInstance().Show();
            GymkhanaUI.getInstance().openBtn2();
         }
         else if(this.RacingNum >= 10)
         {
            ConstructionAction.getInstance().costResource(0,0,0,10);
         }
      }
      
      public function REQUEST_RACINGAWARD() : void
      {
         var _loc1_:MSG_REQUEST_RACINGAWARD = new MSG_REQUEST_RACINGAWARD();
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc1_);
      }
      
      public function resp_MSG_RESP_RACINGAWARD(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_RACINGAWARD = new MSG_RESP_RACINGAWARD();
         NetManager.Instance().readObject(_loc4_,param3);
         var _loc5_:int = int(_loc4_.WarScoreExchange);
         GymkhanaUI.getInstance().update();
      }
      
      public function REQUEST_SETRACINGSHIPTEAM(param1:int, param2:Array) : void
      {
         var _loc3_:MSG_REQUEST_SETRACINGSHIPTEAM = new MSG_REQUEST_SETRACINGSHIPTEAM();
         _loc3_.SeqId = GamePlayer.getInstance().seqID++;
         _loc3_.Guid = GamePlayer.getInstance().Guid;
         _loc3_.ShipTeamLen = param1;
         _loc3_.ShipTeamId = param2;
         NetManager.Instance().sendObject(_loc3_);
      }
      
      public function resp_MSG_RESP_SETRACINGSHIPTEAM(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_SETRACINGSHIPTEAM = new MSG_RESP_SETRACINGSHIPTEAM();
         NetManager.Instance().readObject(_loc4_,param3);
         var _loc5_:int = _loc4_.ShipTeamLen;
         var _loc6_:Array = _loc4_.ShipTeamId;
         GymkhanaRouter.getinstance().REQUEST_RACINGINFO(GamePlayer.getInstance().userID);
      }
      
      public function resp_MSG_RESP_RACINGINFOSHIPTEAM(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc6_:MSG_RESP_RACINGINFOSHIPTEAM_TEMP = null;
         var _loc7_:MSG_RESP_RACINGINFOSHIPTEAM_TEMP = null;
         var _loc8_:MSG_RESP_RACINGINFOSHIPTEAM_TEMP = null;
         var _loc9_:MSG_RESP_RACINGINFOSHIPTEAM_TEMP = null;
         var _loc4_:MSG_RESP_RACINGINFOSHIPTEAM = new MSG_RESP_RACINGINFOSHIPTEAM();
         NetManager.Instance().readObject(_loc4_,param3);
         var _loc5_:int = 0;
         if(_loc4_.Type == 0)
         {
            while(_loc5_ < _loc4_.DataLen)
            {
               _loc6_ = _loc4_.Data[_loc5_] as MSG_RESP_RACINGINFOSHIPTEAM_TEMP;
               _loc7_ = new MSG_RESP_RACINGINFOSHIPTEAM_TEMP();
               _loc7_.TeamName = _loc6_.TeamName;
               _loc7_.ShipTeamId = _loc6_.ShipTeamId;
               _loc7_.CommanderId = _loc6_.CommanderId;
               _loc7_.BodyId = _loc6_.BodyId;
               if(_loc7_.BodyId != -1)
               {
                  _loc7_.ShipNum = _loc6_.ShipNum;
                  this.InShipAry.push(_loc7_);
               }
               _loc5_++;
            }
         }
         else
         {
            while(_loc5_ < _loc4_.DataLen)
            {
               _loc8_ = _loc4_.Data[_loc5_] as MSG_RESP_RACINGINFOSHIPTEAM_TEMP;
               _loc9_ = new MSG_RESP_RACINGINFOSHIPTEAM_TEMP();
               _loc9_.TeamName = _loc8_.TeamName;
               _loc9_.ShipTeamId = _loc8_.ShipTeamId;
               _loc9_.CommanderId = _loc8_.CommanderId;
               _loc9_.BodyId = _loc8_.BodyId;
               _loc9_.ShipNum = _loc8_.ShipNum;
               this.OutShipAry.push(_loc9_);
               _loc5_++;
            }
         }
         GymkhanaUI.getInstance().openBtn();
         GymkhanaUI.getInstance().showShipList();
      }
      
      public function DUPLICATE_STATUS() : void
      {
         var _loc1_:MSG_DUPLICATE_STATUS = new MSG_DUPLICATE_STATUS();
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         _loc1_.Duplicate = 50;
         _loc1_.Status = 0;
         NetManager.Instance().sendObject(_loc1_);
      }
      
      public function resp_MSG_DUPLICATE_STATUS(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_DUPLICATE_STATUS = new MSG_DUPLICATE_STATUS();
         NetManager.Instance().readObject(_loc4_,param3);
         if(_loc4_.Duplicate == 50)
         {
            GymkhanaUI.getInstance().setStatus(_loc4_.Status);
            if(_loc4_.Status == 1)
            {
               GymkhanaUI.getInstance().closeEve();
            }
         }
      }
      
      public function REQUEST_RACINGRANK(param1:int = -1) : void
      {
         var _loc2_:MSG_REQUEST_RACINGRANK = new MSG_REQUEST_RACINGRANK();
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         _loc2_.UserId = -1;
         _loc2_.PageId = param1;
         NetManager.Instance().sendObject(_loc2_);
      }
      
      public function resp_MSG_RACINGRANK(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc7_:MSG_RESP_RACINGRANK_TEMP = null;
         var _loc4_:MSG_RESP_RACINGRANK = new MSG_RESP_RACINGRANK();
         NetManager.Instance().readObject(_loc4_,param3);
         this.m_racingPageId = _loc4_.PageId;
         this.m_userCount = _loc4_.UserCount;
         var _loc5_:Array = new Array();
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_.DataLen)
         {
            _loc7_ = _loc4_.Data[_loc6_] as MSG_RESP_RACINGRANK_TEMP;
            _loc5_.push(_loc7_);
            _loc6_++;
         }
         RacerankingSceneUI.getInstance().showList(_loc5_);
      }
   }
}

