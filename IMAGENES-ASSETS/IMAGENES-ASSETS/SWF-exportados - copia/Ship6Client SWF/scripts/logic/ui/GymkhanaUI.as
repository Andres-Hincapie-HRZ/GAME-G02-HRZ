package logic.ui
{
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.facebook.FacebookUserInfo;
   import com.star.frameworks.managers.StringManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.entry.ScienceSystem;
   import logic.entry.shipmodel.ShipbodyInfo;
   import logic.game.GameKernel;
   import logic.manager.FightManager;
   import logic.manager.GalaxyManager;
   import logic.manager.GameInterActiveManager;
   import logic.reader.CShipmodelReader;
   import logic.reader.RacingRewardReader;
   import logic.ui.info.BleakingLineForThai;
   import logic.utils.UpdateResource;
   import logic.widget.ConstructionOperationWidget;
   import logic.widget.OperationEnum;
   import net.msg.gymkhanaMSg.MSG_RESP_RACINGINFOSHIPTEAM_TEMP;
   import net.msg.gymkhanaMSg.RacingEnemyInfo;
   import net.msg.gymkhanaMSg.RacingReportInfo;
   import net.router.GymkhanaRouter;
   
   public class GymkhanaUI extends AbstractPopUp
   {
      
      public static var instance:GymkhanaUI;
      
      private var btn_challenge:HButton;
      
      private var btn_selecte:HButton;
      
      private var btn_addfleet:HButton;
      
      private var btn_close:HButton;
      
      private var btn_claim:HButton;
      
      private var enemyMCAry:Array;
      
      private var shipMCAry:Array;
      
      private var ReportMCAry:Array;
      
      private var m_chooseId:int = -1;
      
      private var UserIdList:Array = new Array();
      
      private var UserNameList:Array = new Array();
      
      private var m_page:int = 0;
      
      private var m_status:int = 0;
      
      private var backMc:MovieClip = new MovieClip();
      
      public function GymkhanaUI()
      {
         super();
         setPopUpName("RaceScene");
      }
      
      public static function getInstance() : GymkhanaUI
      {
         if(instance == null)
         {
            instance = new GymkhanaUI();
         }
         return instance;
      }
      
      override public function Init() : void
      {
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            return;
         }
         this._mc = new MObject("RaceScene",378,308);
         GameKernel.popUpDisplayManager.Regisger(instance);
         this.initMcElement();
      }
      
      override public function initMcElement() : void
      {
         _mc.getMC().btn_left0.visible = false;
         _mc.getMC().btn_right0.visible = false;
         this.btn_challenge = new HButton(_mc.getMC().btn_challenge);
         new HButton(_mc.getMC().btn_help);
         new HButton(_mc.getMC().btn_ranking);
         GameInterActiveManager.InstallInterActiveEvent(_mc.getMC().btn_ranking,ActionEvent.ACTION_CLICK,this.chickButton);
         GameInterActiveManager.InstallInterActiveEvent(this.btn_challenge.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         GameInterActiveManager.InstallInterActiveEvent(_mc.getMC().btn_help,ActionEvent.ACTION_CLICK,this.chickButton);
         this.btn_addfleet = new HButton(_mc.getMC().btn_addfleet);
         GameInterActiveManager.InstallInterActiveEvent(this.btn_addfleet.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         this.btn_close = new HButton(_mc.getMC().btn_close);
         this.btn_claim = new HButton(_mc.getMC().btn_claim);
         GameInterActiveManager.InstallInterActiveEvent(this.btn_close.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         GameInterActiveManager.InstallInterActiveEvent(this.btn_claim.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         GameInterActiveManager.InstallInterActiveEvent(this.btn_claim.m_movie,ActionEvent.ACTION_ROLL_OVER,this.roll_over);
         GameInterActiveManager.InstallInterActiveEvent(this.btn_claim.m_movie,ActionEvent.ACTION_ROLL_OUT,this.roll_out);
         GameInterActiveManager.InstallInterActiveEvent(_mc.getMC().mc_click,ActionEvent.ACTION_ROLL_OVER,this.roll_over);
         GameInterActiveManager.InstallInterActiveEvent(_mc.getMC().mc_click,ActionEvent.ACTION_ROLL_OUT,this.roll_out);
         GameInterActiveManager.InstallInterActiveEvent(_mc.getMC().btn_left,ActionEvent.ACTION_CLICK,this.chickButton);
         GameInterActiveManager.InstallInterActiveEvent(_mc.getMC().btn_right,ActionEvent.ACTION_CLICK,this.chickButton);
         GameInterActiveManager.InstallInterActiveEvent(_mc.getMC().mc_help,ActionEvent.ACTION_CLICK,this.chickButton);
         this.enemyMCAry = new Array();
         var _loc1_:int = 0;
         while(_loc1_ < 9)
         {
            this.enemyMCAry[_loc1_] = _mc.getMC().getChildByName("mc_a" + _loc1_) as MovieClip;
            this.enemyMCAry[_loc1_].mouseEnabled = true;
            this.enemyMCAry[_loc1_].mouseChildren = false;
            this.enemyMCAry[_loc1_].buttonMode = true;
            this.enemyMCAry[_loc1_].gotoAndStop("up");
            GameInterActiveManager.InstallInterActiveEvent(this.enemyMCAry[_loc1_],ActionEvent.ACTION_CLICK,this.choose);
            _loc1_++;
         }
         this.shipMCAry = new Array();
         var _loc2_:int = 0;
         while(_loc2_ < 4)
         {
            this.shipMCAry[_loc2_] = _mc.getMC().getChildByName("mc_list" + _loc2_) as MovieClip;
            new HButton((this.shipMCAry[_loc2_] as MovieClip).btn_cancel);
            GameInterActiveManager.InstallInterActiveEvent((this.shipMCAry[_loc2_] as MovieClip).btn_cancel,ActionEvent.ACTION_CLICK,this.cancelChoose);
            _loc2_++;
         }
         this.ReportMCAry = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < 5)
         {
            this.ReportMCAry[_loc3_] = _mc.getMC().getChildByName("mc_" + _loc3_) as MovieClip;
            _loc3_++;
         }
      }
      
      public function showList() : void
      {
         var _loc4_:RacingEnemyInfo = null;
         var _loc5_:MovieClip = null;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         var _loc8_:RacingReportInfo = null;
         var _loc9_:MovieClip = null;
         var _loc10_:int = 0;
         var _loc11_:String = null;
         var _loc12_:MovieClip = null;
         _mc.getMC().mc_help.visible = false;
         _mc.getMC().txt_rankingpre.text = GymkhanaRouter.getinstance().RankId;
         if(GymkhanaRouter.getinstance().RacingNum < 10)
         {
            _mc.getMC().txt_times.text = int(10 - GymkhanaRouter.getinstance().RacingNum);
            _mc.getMC().txt_title.htmlText = StringManager.getInstance().getMessageString("Boss183");
         }
         else if(GymkhanaRouter.getinstance().RacingNum < 15)
         {
            _mc.getMC().txt_times.text = int(15 - GymkhanaRouter.getinstance().RacingNum);
            _mc.getMC().txt_title.htmlText = StringManager.getInstance().getMessageString("Boss184");
         }
         else
         {
            _mc.getMC().txt_times.text = int(0);
            _mc.getMC().txt_title.htmlText = StringManager.getInstance().getMessageString("Boss184");
         }
         if(GymkhanaRouter.getinstance().RacingRewardFlag == 0)
         {
            this.btn_claim.setBtnDisabled(false);
         }
         else
         {
            this.btn_claim.setBtnDisabled(true);
         }
         this.UserIdList.splice(0);
         this.UserNameList.splice(0);
         this.m_chooseId = -1;
         var _loc1_:int = 0;
         while(_loc1_ < GymkhanaRouter.getinstance().EnemyDataAry.length)
         {
            _loc4_ = GymkhanaRouter.getinstance().EnemyDataAry[_loc1_] as RacingEnemyInfo;
            _loc5_ = this.enemyMCAry[_loc1_] as MovieClip;
            _loc5_.gotoAndStop(1);
            _loc5_.visible = true;
            _loc5_.txt_name.text = _loc4_.Name;
            _loc5_.txt_ranking.text = _loc4_.RankId;
            _loc6_ = _loc4_.GameServerId + 1;
            if(_loc6_ >= 10)
            {
               _loc7_ = StringManager.getInstance().getMessageString("Boss189") + _loc6_;
            }
            else
            {
               _loc7_ = StringManager.getInstance().getMessageString("Boss189") + "0" + _loc6_;
            }
            _loc5_.txt_service.text = _loc7_;
            this.UserIdList.push(_loc4_.UserId);
            this.UserNameList.push(_loc4_.Name);
            _loc1_++;
         }
         while(_loc1_ < 9)
         {
            _loc5_ = this.enemyMCAry[_loc1_] as MovieClip;
            _loc5_.visible = false;
            _loc1_++;
         }
         GameKernel.getPlayerFacebookInfoArray(this.UserIdList,this.getPlayerFacebookInfoArrayCallback,this.UserNameList);
         var _loc2_:int = 0;
         var _loc3_:* = int(GymkhanaRouter.getinstance().RacingReportAry.length - 1);
         while(_loc3_ >= 0)
         {
            _loc8_ = GymkhanaRouter.getinstance().RacingReportAry[_loc3_] as RacingReportInfo;
            _loc9_ = this.ReportMCAry[_loc2_] as MovieClip;
            _loc9_.mc_statue.visible = true;
            _loc9_.mc_up.visible = true;
            _loc10_ = int(_loc8_.Time);
            _loc6_ = _loc8_.ReportDate + 1;
            if(_loc6_ >= 10)
            {
               _loc7_ = _loc6_.toString();
            }
            else
            {
               _loc7_ = "0" + _loc6_;
            }
            if(_loc8_.Type == 0)
            {
               if(_loc10_ <= 3600)
               {
                  _loc10_ = 1;
               }
               else
               {
                  _loc10_ /= 3600;
               }
               if(_loc8_.RankChange == 10000)
               {
                  _loc9_.mc_statue.gotoAndStop(1);
                  _loc9_.mc_up.gotoAndStop(3);
                  _loc11_ = StringManager.getInstance().getMessageString("Boss176").replace("@@3",_loc7_).replace("@@1",_loc10_);
                  _loc9_.txt_event.htmlText = _loc11_.replace("@@2",_loc8_.Name);
               }
               else if(_loc8_.RankChange == -10000)
               {
                  _loc9_.mc_statue.gotoAndStop(2);
                  _loc9_.mc_up.gotoAndStop(3);
                  _loc11_ = StringManager.getInstance().getMessageString("Boss175").replace("@@3",_loc7_).replace("@@1",_loc10_);
                  _loc9_.txt_event.htmlText = _loc11_.replace("@@2",_loc8_.Name);
               }
               else if(_loc8_.RankChange == 0)
               {
                  _loc9_.mc_statue.gotoAndStop(1);
                  _loc9_.mc_up.gotoAndStop(3);
                  _loc11_ = StringManager.getInstance().getMessageString("Boss176").replace("@@3",_loc7_).replace("@@1",_loc10_);
                  _loc9_.txt_event.htmlText = _loc11_.replace("@@2",_loc8_.Name);
               }
               else if(_loc8_.RankChange < 0)
               {
                  _loc9_.mc_statue.gotoAndStop(2);
                  _loc9_.mc_up.gotoAndStop(2);
                  _loc11_ = StringManager.getInstance().getMessageString("Boss175").replace("@@3",_loc7_).replace("@@1",_loc10_);
                  _loc9_.txt_event.htmlText = _loc11_.replace("@@2",_loc8_.Name);
               }
            }
            else if(_loc8_.RankChange == 10000)
            {
               _loc9_.mc_statue.gotoAndStop(1);
               _loc9_.mc_up.gotoAndStop(3);
               _loc9_.txt_event.htmlText = StringManager.getInstance().getMessageString("Boss173").replace("@@1",_loc8_.Name);
            }
            else if(_loc8_.RankChange == -10000)
            {
               _loc9_.mc_statue.gotoAndStop(2);
               _loc9_.mc_up.gotoAndStop(3);
               _loc9_.txt_event.htmlText = StringManager.getInstance().getMessageString("Boss174").replace("@@1",_loc8_.Name);
            }
            else if(_loc8_.RankChange > 0)
            {
               _loc9_.mc_statue.gotoAndStop(1);
               _loc9_.mc_up.gotoAndStop(1);
               _loc9_.txt_event.htmlText = StringManager.getInstance().getMessageString("Boss173").replace("@@1",_loc8_.Name);
            }
            else
            {
               _loc9_.mc_statue.gotoAndStop(2);
               _loc9_.mc_up.gotoAndStop(3);
               _loc9_.txt_event.htmlText = StringManager.getInstance().getMessageString("Boss174").replace("@@1",_loc8_.Name);
            }
            _loc3_ = ++_loc3_ - 1;
         }
         while(_loc2_ < 5)
         {
            _loc12_ = this.ReportMCAry[_loc2_] as MovieClip;
            _loc12_.mc_statue.visible = false;
            _loc12_.mc_up.visible = false;
            _loc2_++;
         }
         this.btn_challenge.setBtnDisabled(true);
         if(OutShipUI.getInstance().IsVisible())
         {
            OutShipUI.getInstance().m_page = 0;
            OutShipUI.getInstance().clearShipStata();
            OutShipUI.getInstance().showList();
         }
      }
      
      private function clearList() : void
      {
         var _loc2_:MovieClip = null;
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            _loc2_ = this.shipMCAry[_loc1_] as MovieClip;
            while(_loc2_.mc_commanderbase.numChildren > 1)
            {
               _loc2_.mc_commanderbase.removeChildAt(1);
            }
            while(_loc2_.mc_fleetbase.numChildren > 1)
            {
               _loc2_.mc_fleetbase.removeChildAt(1);
            }
            _loc2_.visible = false;
            _loc1_++;
         }
      }
      
      public function showShipList() : void
      {
         var _loc4_:MSG_RESP_RACINGINFOSHIPTEAM_TEMP = null;
         var _loc5_:MovieClip = null;
         var _loc6_:Bitmap = null;
         var _loc7_:ShipbodyInfo = null;
         var _loc8_:BitmapData = null;
         var _loc9_:Bitmap = null;
         this.clearList();
         var _loc1_:int = 0 + this.m_page * 4;
         var _loc2_:int = 0;
         while(_loc2_ < 4 && _loc1_ < GymkhanaRouter.getinstance().InShipAry.length)
         {
            _loc4_ = GymkhanaRouter.getinstance().InShipAry[_loc1_] as MSG_RESP_RACINGINFOSHIPTEAM_TEMP;
            _loc5_ = this.shipMCAry[_loc2_] as MovieClip;
            _loc5_.visible = true;
            _loc6_ = CommanderSceneUI.getInstance().CommanderImg(_loc4_.CommanderId);
            _loc5_.mc_commanderbase.addChild(_loc6_);
            _loc7_ = CShipmodelReader.getInstance().getShipBodyInfo(_loc4_.BodyId);
            _loc8_ = GameKernel.getTextureInstance(_loc7_.SmallIcon);
            _loc9_ = new Bitmap(_loc8_);
            _loc5_.mc_fleetbase.addChild(_loc9_);
            _loc5_.tf_fleetnum.text = _loc4_.ShipNum;
            _loc5_.tf_fleetname.text = _loc4_.TeamName;
            _loc1_++;
            _loc2_++;
         }
         var _loc3_:int = GymkhanaRouter.getinstance().InShipAry.length / 4;
         if(GymkhanaRouter.getinstance().InShipAry.length % 4 != 0)
         {
            _loc3_++;
         }
         if(_loc3_ == 0)
         {
            _loc3_ = 1;
         }
         _mc.getMC().tf_selectednum.text = int(this.m_page + 1) + "/" + _loc3_;
      }
      
      private function getPlayerFacebookInfoArrayCallback(param1:Array) : void
      {
         var _loc2_:FacebookUserInfo = null;
         if(param1 == null)
         {
            return;
         }
         for each(_loc2_ in param1)
         {
            FleetInfoUI_Res.GetInstance().GetFacebookUserImg(_loc2_.uid,_loc2_.pic_square,this.GetFacebookUserImgCallback);
         }
      }
      
      private function GetFacebookUserImgCallback(param1:Number, param2:DisplayObject) : void
      {
         var _loc4_:RacingEnemyInfo = null;
         var _loc5_:MovieClip = null;
         var _loc6_:MovieClip = null;
         if(param2 == null)
         {
            return;
         }
         var _loc3_:int = 0;
         while(_loc3_ < GymkhanaRouter.getinstance().EnemyDataAry.length)
         {
            _loc4_ = GymkhanaRouter.getinstance().EnemyDataAry[_loc3_] as RacingEnemyInfo;
            if(_loc4_.UserId == param1)
            {
               _loc5_ = this.enemyMCAry[_loc3_] as MovieClip;
               if(_loc5_ == null)
               {
                  return;
               }
               _loc6_ = _loc5_.getChildByName("mc_commanderbase") as MovieClip;
               if(_loc6_.numChildren > 0)
               {
                  _loc6_.removeChildAt(0);
               }
               if(param2 != null)
               {
                  param2.width = 40;
                  param2.height = 40;
                  _loc6_.addChild(param2);
               }
            }
            _loc3_++;
         }
      }
      
      public function update() : void
      {
         this.btn_claim.setBtnDisabled(true);
         var _loc1_:Object = RacingRewardReader.getInstance().ReData(GymkhanaRouter.getinstance().RankId);
         GamePlayer.getInstance().WarScoreExchange = GamePlayer.getInstance().WarScoreExchange + _loc1_.Reward;
      }
      
      private function roll_over(param1:Event) : void
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         var _loc6_:Point = null;
         var _loc7_:Object = null;
         var _loc8_:TextField = null;
         var _loc9_:String = null;
         var _loc2_:TextField = new TextField();
         if(param1.currentTarget.name == "btn_challenge")
         {
            if(GymkhanaRouter.getinstance().RacingNum <= 9)
            {
               return;
            }
            _loc3_ = StringManager.getInstance().getMessageString("Boss185");
            _loc2_.text = _loc3_;
            _loc2_.wordWrap = true;
            _loc2_.autoSize = TextFieldAutoSize.LEFT;
            _loc4_ = _loc2_.width;
            _loc2_.multiline = true;
            _loc2_.width = 150;
            Suspension.getInstance();
            Suspension.getInstance().Init(_loc2_.width,_loc2_.height + 20,1);
            _loc5_ = param1.currentTarget as MovieClip;
            _loc6_ = _loc5_.localToGlobal(new Point(0,_loc5_.height));
            _loc6_ = this._mc.getMC().globalToLocal(_loc6_);
            Suspension.getInstance().setLocationXY(_loc6_.x,_loc6_.y);
            Suspension.getInstance().putRectOnlyOne(0,"    " + _loc2_.text,_loc2_.width,_loc2_.height);
         }
         else if(param1.currentTarget.name == "btn_claim")
         {
            _loc7_ = RacingRewardReader.getInstance().ReData(GymkhanaRouter.getinstance().RankId);
            _loc3_ = StringManager.getInstance().getMessageString("Boss181").replace("@@1",_loc7_.Reward);
            _loc2_.text = _loc3_;
            _loc2_.width = _loc2_.textWidth + 20;
            _loc2_.height = _loc2_.textHeight + 10;
            _loc8_ = new TextField();
            Suspension.getInstance();
            if(_loc7_.PropsId != "")
            {
               Suspension.getInstance().Init(_loc2_.width,_loc2_.height + 20,1);
            }
            else
            {
               Suspension.getInstance().Init(_loc2_.width,_loc2_.height,1);
            }
            _loc5_ = param1.currentTarget as MovieClip;
            _loc6_ = _loc5_.localToGlobal(new Point(0,_loc5_.height));
            _loc6_ = this._mc.getMC().globalToLocal(_loc6_);
            Suspension.getInstance().setLocationXY(_loc6_.x,_loc6_.y);
            Suspension.getInstance().putRectOnlyOne(0,"    " + _loc2_.text,_loc2_.width,_loc2_.height);
            if(_loc7_.PropsId != "")
            {
               _loc9_ = StringManager.getInstance().getMessageString("Boss182");
               Suspension.getInstance().putRectOnlyOne(1,"    " + _loc9_,_loc2_.width,_loc2_.height);
            }
         }
         else if(param1.currentTarget.name == "mc_click")
         {
            _loc3_ = StringManager.getInstance().getMessageString("Boss186");
            _loc2_.text = _loc3_;
            _loc2_.wordWrap = true;
            _loc2_.autoSize = TextFieldAutoSize.LEFT;
            _loc2_.multiline = true;
            _loc2_.width = _loc2_.textWidth + 20;
            _loc2_.height = _loc2_.textHeight + 10;
            Suspension.getInstance();
            Suspension.getInstance().Init(_loc2_.width,_loc2_.height,1);
            _loc5_ = param1.currentTarget as MovieClip;
            _loc6_ = _loc5_.localToGlobal(new Point(0,_loc5_.height));
            _loc6_ = this._mc.getMC().globalToLocal(_loc6_);
            Suspension.getInstance().setLocationXY(_loc6_.x,_loc6_.y);
            Suspension.getInstance().putRectOnlyOne(0,"    " + _loc2_.text,_loc2_.width,_loc2_.height);
         }
         BleakingLineForThai.GetInstance().BleakThaiLanguage(_loc2_);
         this._mc.getMC().addChild(Suspension.getInstance());
      }
      
      private function roll_out(param1:Event) : void
      {
         if(Suspension.getNullInstance() == null)
         {
            return;
         }
         this._mc.getMC().removeChild(Suspension.getInstance());
         Suspension.getInstance().delinstance();
      }
      
      public function sendTZ() : void
      {
         GymkhanaRouter.getinstance().REQUEST_RACINGBATTLE(GamePlayer.getInstance().userID,(GymkhanaRouter.getinstance().EnemyDataAry[this.m_chooseId] as RacingEnemyInfo).UserId);
         this.btn_challenge.setBtnDisabled(true);
      }
      
      public function closeEve() : void
      {
         GameKernel.popUpDisplayManager.Hide(instance);
      }
      
      public function openBtn2() : void
      {
         this.btn_challenge.setBtnDisabled(false);
      }
      
      private function chickButton(param1:Event) : void
      {
         var _loc2_:Object = null;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         if(param1.currentTarget.name == "btn_close")
         {
            this.closeEve();
         }
         else if(param1.currentTarget.name == "btn_addfleet")
         {
            OutShipUI.getInstance().Init();
            GameKernel.popUpDisplayManager.Show(OutShipUI.getInstance());
            OutShipUI.getInstance().m_page = 0;
            OutShipUI.getInstance().clearShipStata();
            OutShipUI.getInstance().showList();
         }
         else if(param1.currentTarget.name == "btn_challenge")
         {
            if(GymkhanaRouter.getinstance().RacingNum >= 10)
            {
               if(GamePlayer.getInstance().cash < 10)
               {
                  ConstructionOperationWidget.currenCmd = OperationEnum.OPERATION_TYPE_NOCASH;
                  PrepaidModulePopup.getInstance().setString("commandercard");
                  PrepaidModulePopup.getInstance().Init();
                  PrepaidModulePopup.getInstance().setParent(this);
                  PrepaidModulePopup.getInstance().Show();
                  return;
               }
               this.addBackMC();
               ConstructionOperationWidget.currenCmd = OperationEnum.OPERATION_TYPE_COINJOIN;
               UpgradeModulesPopUp.getInstance().Init();
               UpgradeModulesPopUp.getInstance().Show();
               return;
            }
            GymkhanaRouter.getinstance().REQUEST_RACINGBATTLE(GamePlayer.getInstance().userID,(GymkhanaRouter.getinstance().EnemyDataAry[this.m_chooseId] as RacingEnemyInfo).UserId);
            this.btn_challenge.setBtnDisabled(true);
         }
         else if(param1.currentTarget.name == "btn_claim")
         {
            _loc2_ = RacingRewardReader.getInstance().ReData(GymkhanaRouter.getinstance().RankId);
            if(_loc2_.PropsId != "")
            {
               if(this.DetectionBag())
               {
                  return;
               }
               _loc3_ = String(_loc2_.PropsId).split(",");
               UpdateResource.getInstance().AddToPack(int(_loc3_[0]),int(_loc3_[1]),1);
            }
            GymkhanaRouter.getinstance().REQUEST_RACINGAWARD();
            this.btn_claim.setBtnDisabled(true);
         }
         else if(param1.currentTarget.name == "btn_left")
         {
            if(this.m_page == 0)
            {
               return;
            }
            --this.m_page;
            this.showShipList();
         }
         else if(param1.currentTarget.name == "btn_right")
         {
            _loc4_ = GymkhanaRouter.getinstance().InShipAry.length / 4;
            if(GymkhanaRouter.getinstance().InShipAry.length % 4 == 0 && GymkhanaRouter.getinstance().InShipAry.length > 0)
            {
               _loc4_--;
            }
            if(_loc4_ == this.m_page)
            {
               return;
            }
            ++this.m_page;
            this.showShipList();
         }
         else if(param1.currentTarget.name == "mc_help")
         {
            _mc.getMC().mc_help.visible = false;
         }
         else if(param1.currentTarget.name == "btn_help")
         {
            _mc.getMC().mc_help.visible = true;
         }
         else if(param1.currentTarget.name == "btn_ranking")
         {
            this.addBackMC();
            RacerankingSceneUI.getInstance().Init();
            GymkhanaRouter.getinstance().REQUEST_RACINGRANK();
            GameKernel.popUpDisplayManager.Show(RacerankingSceneUI.getInstance());
         }
      }
      
      private function cancelChoose(param1:Event) : void
      {
         var _loc6_:MSG_RESP_RACINGINFOSHIPTEAM_TEMP = null;
         var _loc7_:MSG_RESP_RACINGINFOSHIPTEAM_TEMP = null;
         var _loc2_:int = int(String(param1.currentTarget.parent.name).slice(7));
         var _loc3_:int = _loc2_ + this.m_page * 4;
         GymkhanaRouter.getinstance().InShipAry.splice(_loc3_,1);
         var _loc4_:Array = new Array();
         var _loc5_:int = 0;
         while(_loc5_ < GymkhanaRouter.getinstance().InShipAry.length)
         {
            _loc6_ = GymkhanaRouter.getinstance().InShipAry[_loc5_] as MSG_RESP_RACINGINFOSHIPTEAM_TEMP;
            _loc7_ = new MSG_RESP_RACINGINFOSHIPTEAM_TEMP();
            _loc7_.TeamName = _loc6_.TeamName;
            _loc7_.ShipTeamId = _loc6_.ShipTeamId;
            _loc7_.CommanderId = _loc6_.CommanderId;
            _loc7_.BodyId = _loc6_.BodyId;
            _loc7_.ShipNum = _loc6_.ShipNum;
            _loc4_.push(_loc7_.ShipTeamId);
            _loc5_++;
         }
         GymkhanaRouter.getinstance().REQUEST_SETRACINGSHIPTEAM(_loc4_.length,_loc4_);
         this.closeBtn();
      }
      
      public function closeBtn() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            this.shipMCAry[_loc1_] = _mc.getMC().getChildByName("mc_list" + _loc1_) as MovieClip;
            (this.shipMCAry[_loc1_] as MovieClip).btn_cancel.mouseEnabled = false;
            _loc1_++;
         }
      }
      
      public function openBtn() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            this.shipMCAry[_loc1_] = _mc.getMC().getChildByName("mc_list" + _loc1_) as MovieClip;
            (this.shipMCAry[_loc1_] as MovieClip).btn_cancel.mouseEnabled = true;
            _loc1_++;
         }
      }
      
      private function choose(param1:Event) : void
      {
         var _loc2_:int = int(String(param1.currentTarget.name).slice(4));
         if(_loc2_ == this.m_chooseId)
         {
            return;
         }
         if(this.m_chooseId != -1)
         {
            (this.enemyMCAry[this.m_chooseId] as MovieClip).gotoAndStop("up");
         }
         (this.enemyMCAry[_loc2_] as MovieClip).gotoAndStop("selected");
         this.m_chooseId = _loc2_;
         if(this.m_chooseId != -1)
         {
            if(GymkhanaRouter.getinstance().RacingNum < 15 && GymkhanaRouter.getinstance().InShipAry.length > 0)
            {
               this.btn_challenge.setBtnDisabled(false);
            }
         }
      }
      
      public function addBackMC() : void
      {
         this.backMc.graphics.clear();
         this.backMc.graphics.beginFill(16711935,0);
         this.backMc.graphics.drawRect(-380,-340,760,850);
         this.backMc.graphics.endFill();
         this._mc.getMC().addChild(this.backMc);
      }
      
      public function removeBackMC() : void
      {
         this._mc.getMC().removeChild(this.backMc);
      }
      
      private function DetectionBag() : Boolean
      {
         if(GamePlayer.getInstance().PropsPack - ScienceSystem.getinstance().Packarr.length == 0)
         {
            StoragepopupTip.getInstance().Init();
            StoragepopupTip.getInstance().Show();
            if(GamePlayer.getInstance().PropsPack == PackUi.getInstance().maxNum)
            {
               StoragepopupTip.getInstance().ppd(2);
            }
            else
            {
               StoragepopupTip.getInstance().ppd(1);
            }
            return true;
         }
         return false;
      }
      
      public function setStatus(param1:int) : void
      {
         this.m_status = param1;
      }
      
      public function getStatus() : int
      {
         return this.m_status;
      }
      
      public function leave() : void
      {
         if(this.m_status == 1)
         {
            FightManager.instance.CleanFight();
            GalaxyManager.instance.sendRequestGalaxy();
            GymkhanaRouter.getinstance().DUPLICATE_STATUS();
            this.m_status = 0;
         }
      }
   }
}

