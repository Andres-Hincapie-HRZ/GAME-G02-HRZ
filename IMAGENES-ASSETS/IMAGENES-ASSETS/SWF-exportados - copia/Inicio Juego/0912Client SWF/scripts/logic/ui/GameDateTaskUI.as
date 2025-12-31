package logic.ui
{
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.managers.StringManager;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.entry.ScienceSystem;
   import logic.entry.shipmodel.ShipbodyInfo;
   import logic.entry.shipmodel.ShippartInfo;
   import logic.game.GameKernel;
   import logic.game.GameMouseZoneManager;
   import logic.manager.FightManager;
   import logic.manager.GameInterActiveManager;
   import logic.manager.InstanceManager;
   import logic.reader.CShipmodelReader;
   import logic.ui.info.BleakingLineForThai;
   import logic.widget.ConstructionOperationWidget;
   import logic.widget.DataWidget;
   import net.base.NetManager;
   import net.msg.sciencesystem.MSG_REQUEST_TECHUPGRADEINFO;
   import net.router.UpgradeRouter;
   
   public class GameDateTaskUI
   {
      
      private static var m_Instance:GameDateTaskUI;
      
      public static const STATE_COPY:int = 0;
      
      public static const STATE_MATCH:int = 1;
      
      public static const STATE_GATE:int = 2;
      
      public static const STATE_CONSTELLATION:int = 3;
      
      public static var IsShow:Boolean = false;
      
      private var m_ProgressTask:MovieClip;
      
      private var m_DataTask:MovieClip;
      
      private var m_Copy:MovieClip;
      
      private var m_UpgradeTech:MovieClip;
      
      private var m_UpgradeComponent:MovieClip;
      
      private var m_CloseBtn:HButton;
      
      private var m_NewPlayerTipBtn:HButton;
      
      private var m_EnterCopyBtn:HButton;
      
      private var m_SelectCopyBtn:HButton;
      
      private var m_SelectCopy1Btn:HButton;
      
      private var m_SelectCopy2Btn:HButton;
      
      private var m_SelectCopy3Btn:HButton;
      
      private var m_EnterBtn:HButton;
      
      private var m_tfCopyconetent:TextField;
      
      private var m_tfReward:TextField;
      
      private var m_lotteryNum:TextField;
      
      private var m_lotteryBtn:HButton;
      
      private var m_UI:MObject;
      
      private var m_First:Boolean;
      
      private var m_EnterState:int;
      
      private var m_IsClick:Boolean = false;
      
      private var m_CopycontentText:TextField;
      
      private var m_RewardText:TextField;
      
      private var m_txt0:TextField;
      
      private var m_txt1:TextField;
      
      private var curType:int = -1;
      
      public function GameDateTaskUI()
      {
         super();
         this.m_EnterState = -1;
         this.m_First = false;
      }
      
      public static function GetInstance() : GameDateTaskUI
      {
         if(m_Instance == null)
         {
            m_Instance = new GameDateTaskUI();
         }
         return m_Instance;
      }
      
      public function Init() : void
      {
         var _loc1_:MSG_REQUEST_TECHUPGRADEINFO = new MSG_REQUEST_TECHUPGRADEINFO();
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc1_);
         if(this.m_UI != null)
         {
            TaskSceneUI.getInstance().GetTaskCount(this.TaskCountCallback);
            UpgradeUI.getInstance().GetUpgradeInfo(this.GetUpgradeInfoCallback);
            this.UpdateCopyTask();
            this.UpdateLottery();
            this.UpdateTechTask();
            this.Show();
            return;
         }
         this.m_UI = new MObject("DaytaskScene");
         this.m_UI.x = GameKernel.fullRect.x + GameKernel.getInstance().stage.stageWidth / 2;
         this.m_UI.y = 300;
         this.initMcElement();
         this.Show();
      }
      
      public function Show() : void
      {
         if(IsShow)
         {
            return;
         }
         GameDateTaskUI.IsShow = true;
         if(GameKernel.renderManager.getScene().getContainer().getChildByName("ChangenameMc") != null)
         {
            GameKernel.renderManager.getScene().addComponentAt(this.m_UI,GameKernel.renderManager.getScene().getChildrenNumber() - 3);
         }
         else
         {
            GameKernel.renderManager.lockScene(true);
            GameKernel.renderManager.getScene().addComponent(this.m_UI);
         }
      }
      
      public function Hide() : void
      {
         if(IsShow)
         {
            GameKernel.renderManager.getScene().removeComponent(this.m_UI);
            GameKernel.renderManager.lockScene(false);
            GameDateTaskUI.IsShow = false;
         }
      }
      
      public function initMcElement() : void
      {
         var _loc1_:MovieClip = this.m_UI.getMC();
         this.InstallProgressTaskModule();
         this.InstallComponentTaskModule();
         this.InstallCopyTaskModule();
         this.InstallDayTaskModule();
         this.InstallTechTaskModule();
         if(this.m_NewPlayerTipBtn == null)
         {
            this.m_NewPlayerTipBtn = new HButton(_loc1_.btn_entertask);
         }
         if(this.m_CloseBtn == null)
         {
            this.m_CloseBtn = new HButton(_loc1_.btn_cancel);
         }
         if(this.m_SelectCopyBtn == null)
         {
            this.m_SelectCopyBtn = new HButton(_loc1_.btn_copy0);
         }
         if(this.m_SelectCopy1Btn == null)
         {
            this.m_SelectCopy1Btn = new HButton(_loc1_.btn_copy1);
         }
         if(this.m_SelectCopy2Btn == null)
         {
            this.m_SelectCopy2Btn = new HButton(_loc1_.btn_copy2);
         }
         if(this.m_SelectCopy3Btn == null)
         {
            this.m_SelectCopy3Btn = new HButton(_loc1_.btn_copy3);
         }
         if(this.m_EnterBtn == null)
         {
            this.m_EnterBtn = new HButton(_loc1_.btn_enter);
         }
         if(this.m_tfCopyconetent == null)
         {
            this.m_tfCopyconetent = _loc1_.tf_copycontent as TextField;
         }
         if(this.m_tfReward == null)
         {
            this.m_tfReward = _loc1_.tf_reward as TextField;
         }
         if(this.m_lotteryBtn == null)
         {
            this.m_lotteryBtn = new HButton(_loc1_.btn_lottery);
         }
         if(this.m_lotteryNum == null)
         {
            this.m_lotteryNum = _loc1_.tf_lotterynum as TextField;
         }
         if(this.m_txt0 == null)
         {
            this.m_txt0 = _loc1_.tf_txt0 as TextField;
         }
         if(this.m_txt1 == null)
         {
            this.m_txt1 = _loc1_.tf_txt1 as TextField;
         }
         if(this.m_CopycontentText == null)
         {
            this.m_CopycontentText = _loc1_.tf_copycontent as TextField;
         }
         if(this.m_RewardText == null)
         {
            this.m_RewardText = _loc1_.tf_reward as TextField;
         }
         TaskSceneUI.getInstance().GetTaskCount(this.TaskCountCallback);
         this.UpdateComponentTask();
         this.UpdateCopyTask();
         this.UpdateLottery();
         GameInterActiveManager.InstallInterActiveEvent(this.m_CloseBtn.m_movie,ActionEvent.ACTION_CLICK,this.onCloseWnd);
         GameInterActiveManager.InstallInterActiveEvent(this.m_NewPlayerTipBtn.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
         GameInterActiveManager.InstallInterActiveEvent(this.m_SelectCopyBtn.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
         GameInterActiveManager.InstallInterActiveEvent(this.m_SelectCopy1Btn.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
         GameInterActiveManager.InstallInterActiveEvent(this.m_SelectCopy2Btn.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
         GameInterActiveManager.InstallInterActiveEvent(this.m_SelectCopy3Btn.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
         GameInterActiveManager.InstallInterActiveEvent(this.m_EnterBtn.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
         GameInterActiveManager.InstallInterActiveEvent(this.m_lotteryBtn.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
      }
      
      private function InstallProgressTaskModule() : void
      {
         var _loc1_:MovieClip = this.m_UI.getMC();
         this.m_ProgressTask = _loc1_.mc_task;
         var _loc2_:HButton = new HButton(this.m_ProgressTask.btn_look);
         GameInterActiveManager.InstallInterActiveEvent(_loc2_.m_movie,ActionEvent.ACTION_CLICK,this.onEnterProgressTask);
      }
      
      public function UpdateProgressTask(param1:int, param2:int) : void
      {
         var _loc3_:MovieClip = this.m_UI.getMC();
         this.m_ProgressTask = _loc3_.mc_task;
         var _loc4_:TextField = this.m_ProgressTask.tf_num0 as TextField;
         var _loc5_:TextField = this.m_ProgressTask.tf_num1 as TextField;
         _loc5_.text = param1.toString();
         _loc4_.text = param2.toString();
      }
      
      private function TaskCountCallback(param1:int, param2:int, param3:int, param4:int) : void
      {
         this.UpdateProgressTask(param2,param1);
         this.UpdateDayTask(param4,param3);
      }
      
      private function InstallDayTaskModule() : void
      {
         var _loc1_:MovieClip = this.m_UI.getMC();
         this.m_DataTask = _loc1_.mc_daytask;
         var _loc2_:HButton = new HButton(this.m_DataTask.btn_look);
         GameInterActiveManager.InstallInterActiveEvent(_loc2_.m_movie,ActionEvent.ACTION_CLICK,this.onEnterDayTask);
      }
      
      public function UpdateDayTask(param1:int, param2:int) : void
      {
         var _loc3_:MovieClip = this.m_UI.getMC();
         this.m_DataTask = _loc3_.mc_daytask;
         var _loc4_:TextField = this.m_DataTask.tf_num0 as TextField;
         var _loc5_:TextField = this.m_DataTask.tf_num1 as TextField;
         _loc5_.text = param1.toString();
         _loc4_.text = param2.toString();
      }
      
      private function InstallCopyTaskModule() : void
      {
         var _loc1_:MovieClip = this.m_UI.getMC();
         this.m_Copy = _loc1_.mc_copy;
         var _loc2_:TextField = this.m_Copy.tf_num0 as TextField;
         var _loc3_:TextField = this.m_Copy.tf_num1 as TextField;
         var _loc4_:HButton = new HButton(this.m_Copy.btn_look);
         GameInterActiveManager.InstallInterActiveEvent(_loc4_.m_movie,ActionEvent.ACTION_CLICK,this.onEnterCopyTask);
      }
      
      public function UpdateCopyTask() : void
      {
         var _loc1_:MovieClip = this.m_UI.getMC();
         this.m_Copy = _loc1_.mc_copy;
         var _loc2_:TextField = this.m_Copy.tf_num0 as TextField;
         var _loc3_:TextField = this.m_Copy.tf_num1 as TextField;
         _loc2_.text = InstanceManager.instance.passedFB.length.toString();
         this.SetCopyStatue(this.curType);
      }
      
      private function InstallTechTaskModule() : void
      {
         var _loc1_:MovieClip = this.m_UI.getMC();
         this.m_UpgradeTech = _loc1_.mc_tech;
         var _loc2_:HButton = new HButton(this.m_UpgradeTech.btn_look);
         GameInterActiveManager.InstallInterActiveEvent(_loc2_.m_movie,ActionEvent.ACTION_CLICK,this.onEnterTechTask);
         this.UpdateTechTask();
      }
      
      public function UpdateTechTask() : void
      {
         if(this.m_UI == null)
         {
            return;
         }
         var _loc1_:MovieClip = this.m_UI.getMC();
         this.m_UpgradeTech = _loc1_.mc_tech;
         var _loc2_:TextField = this.m_UpgradeTech.tf_techname as TextField;
         var _loc3_:TextField = this.m_UpgradeTech.tf_grade as TextField;
         var _loc4_:TextField = this.m_UpgradeTech.tf_time as TextField;
         var _loc5_:Object = ScienceSystem.getinstance().ScienceObj;
         if(_loc5_.leve != undefined)
         {
            _loc2_.text = _loc5_.name;
            _loc3_.text = StringManager.getInstance().getMessageString("TechnologyBtn9") + _loc5_.leve + "-->" + (_loc5_.leve + 1);
            _loc4_.text = DataWidget.localToDataZone(_loc5_.needtime);
         }
         else
         {
            _loc2_.text = "";
            _loc3_.text = "";
            _loc4_.text = "";
         }
      }
      
      private function InstallComponentTaskModule() : void
      {
         var _loc1_:MovieClip = this.m_UI.getMC();
         this.m_UpgradeComponent = _loc1_.mc_weapon;
         var _loc2_:TextField = this.m_UpgradeComponent.tf_name0 as TextField;
         var _loc3_:TextField = this.m_UpgradeComponent.tf_grade0 as TextField;
         var _loc4_:TextField = this.m_UpgradeComponent.tf_name1 as TextField;
         var _loc5_:TextField = this.m_UpgradeComponent.tf_grade1 as TextField;
         var _loc6_:TextField = this.m_UpgradeComponent.tf_time0 as TextField;
         var _loc7_:TextField = this.m_UpgradeComponent.tf_time1 as TextField;
         var _loc8_:HButton = new HButton(this.m_UpgradeComponent.btn_look);
         GameInterActiveManager.InstallInterActiveEvent(_loc8_.m_movie,ActionEvent.ACTION_CLICK,this.onEnterComponentTask);
      }
      
      private function UpdateComponentTask() : void
      {
         var _loc8_:ShipbodyInfo = null;
         var _loc9_:ShippartInfo = null;
         var _loc1_:MovieClip = this.m_UI.getMC();
         this.m_UpgradeComponent = _loc1_.mc_weapon;
         var _loc2_:TextField = this.m_UpgradeComponent.tf_name0 as TextField;
         var _loc3_:TextField = this.m_UpgradeComponent.tf_grade0 as TextField;
         var _loc4_:TextField = this.m_UpgradeComponent.tf_time0 as TextField;
         var _loc5_:TextField = this.m_UpgradeComponent.tf_name1 as TextField;
         var _loc6_:TextField = this.m_UpgradeComponent.tf_grade1 as TextField;
         var _loc7_:TextField = this.m_UpgradeComponent.tf_time1 as TextField;
         if(UpgradeRouter.instance.CurUpgradeBodyId != -1)
         {
            _loc8_ = CShipmodelReader.getInstance().getShipBodyInfo(UpgradeRouter.instance.CurUpgradeBodyId);
            if(_loc8_ != null)
            {
               _loc2_.text = _loc8_.Name;
               _loc3_.text = StringManager.getInstance().getMessageString("TechnologyBtn9") + _loc8_.GroupLV + "-->" + (_loc8_.GroupLV + 1);
               _loc4_.text = DataWidget.localToDataZone(UpgradeRouter.instance.CurUpgradeBodyNeedTime);
            }
            else
            {
               _loc2_.text = "";
               _loc3_.text = "";
               _loc4_.text = "";
            }
         }
         if(UpgradeRouter.instance.CurUpgradePartId != -1)
         {
            _loc9_ = CShipmodelReader.getInstance().getShipPartInfo(UpgradeRouter.instance.CurUpgradePartId);
            if(_loc9_ != null)
            {
               _loc5_.text = _loc9_.Name;
               _loc6_.text = StringManager.getInstance().getMessageString("TechnologyBtn9") + _loc9_.GroupLV + "-->" + (_loc9_.GroupLV + 1);
               _loc7_.text = DataWidget.localToDataZone(UpgradeRouter.instance.CurUpgradePartNeedTime);
            }
            else
            {
               _loc5_.text = "";
               _loc6_.text = "";
               _loc7_.text = "";
            }
         }
      }
      
      private function GetUpgradeInfoCallback() : void
      {
         this.UpdateComponentTask();
      }
      
      public function UpdateLottery() : void
      {
         if(this.m_lotteryNum == null)
         {
            return;
         }
         if(GamePlayer.getInstance().LotteryStatus == 0)
         {
            this.m_lotteryNum.text = StringManager.getInstance().getMessageString("MainUITXT42");
         }
         else
         {
            this.m_lotteryNum.text = StringManager.getInstance().getMessageString("MainUITXT41");
         }
      }
      
      private function onCloseWnd(param1:MouseEvent) : void
      {
         this.Hide();
      }
      
      private function onEnterDayTask(param1:MouseEvent) : void
      {
         TaskSceneUI.getInstance().ShowDayTask();
         this.Hide();
      }
      
      private function onEnterProgressTask(param1:MouseEvent) : void
      {
         TaskSceneUI.getInstance().ShowProgressTask();
         this.Hide();
      }
      
      private function onEnterCopyTask(param1:MouseEvent) : void
      {
         this.GoCopy();
         this.onCloseWnd(param1);
      }
      
      private function GoCopy(param1:int = 1) : void
      {
         GameMouseZoneManager.NagivateToolBarByName("btn_gohome",false);
         GameMouseZoneManager.NagivateToolBarByName("btn_galaxy",false);
         switch(InstanceManager.instance.curStatus)
         {
            case 0:
               InstanceUI.instance.Init();
               InstanceUI.instance.setSelectBtn(null,param1);
               break;
            case 2:
               InstanceManager.instance.request_MSG_REQUEST_ECTYPEINFO(1);
               FightManager.instance.CleanFight();
               break;
            case 3:
               InstanceManager.instance.requestNextFB();
         }
      }
      
      private function onEnterTechTask(param1:MouseEvent) : void
      {
         ScienceSystemUi.getInstance().onCloseWnd(param1);
         ScienceSystemUi.getInstance().Init();
         GameKernel.popUpDisplayManager.Show(ScienceSystemUi.getInstance());
         var _loc2_:MSG_REQUEST_TECHUPGRADEINFO = new MSG_REQUEST_TECHUPGRADEINFO();
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc2_);
         this.Hide();
      }
      
      private function onEnterComponentTask(param1:MouseEvent) : void
      {
         GameMouseZoneManager.NagivateToolBarByName("btn_research",true);
         this.Hide();
      }
      
      private function SetCopyStatue(param1:int) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         this.curType = param1;
         switch(param1)
         {
            case -1:
               break;
            case 0:
               _loc2_ = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
               this.m_tfCopyconetent.htmlText = _loc2_ + StringManager.getInstance().getMessageString("MainUITXT43");
               this.m_tfCopyconetent.wordWrap = true;
               this.m_tfCopyconetent.multiline = true;
               this.m_tfCopyconetent.autoSize = "left";
               BleakingLineForThai.GetInstance().BleakThaiLanguage(this.m_tfCopyconetent,9555199);
               if(!this.m_First)
               {
                  this.m_tfCopyconetent.y -= 8;
               }
               this.m_RewardText.htmlText = StringManager.getInstance().getMessageString("MainUITXT44");
               BleakingLineForThai.GetInstance().BleakThaiLanguage(this.m_RewardText,2412994);
               _loc3_ = StringManager.getInstance().getMessageString("MainUITXT45");
               _loc4_ = StringManager.getInstance().getMessageString("MainUITXT46");
               if(GamePlayer.getInstance().DefyEctypeNum >= 3)
               {
                  _loc3_ = _loc3_.replace("!#",0);
                  _loc4_ = _loc4_.replace("!#",0);
               }
               else if(GamePlayer.getInstance().DefyEctypeNum == 2)
               {
                  _loc3_ = _loc3_.replace("!#",0);
                  _loc4_ = _loc4_.replace("!#",1);
               }
               else if(GamePlayer.getInstance().DefyEctypeNum == 1)
               {
                  _loc3_ = _loc3_.replace("!#",1);
                  _loc4_ = _loc4_.replace("!#",1);
               }
               else if(GamePlayer.getInstance().DefyEctypeNum == 0)
               {
                  _loc3_ = _loc3_.replace("!#",2);
                  _loc4_ = _loc4_.replace("!#",1);
               }
               this.m_txt0.htmlText = _loc3_;
               this.m_txt1.htmlText = _loc4_;
               this.m_First = true;
               break;
            case 1:
               _loc2_ = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
               this.m_tfCopyconetent.htmlText = _loc2_ + StringManager.getInstance().getMessageString("MainUITXT47");
               this.m_tfCopyconetent.wordWrap = true;
               this.m_tfCopyconetent.multiline = true;
               this.m_tfCopyconetent.autoSize = "left";
               BleakingLineForThai.GetInstance().BleakThaiLanguage(this.m_tfCopyconetent,9555199);
               if(!this.m_First)
               {
                  this.m_tfCopyconetent.y -= 8;
               }
               this.m_RewardText.htmlText = StringManager.getInstance().getMessageString("MainUITXT48");
               BleakingLineForThai.GetInstance().BleakThaiLanguage(this.m_RewardText,2412994);
               _loc3_ = StringManager.getInstance().getMessageString("MainUITXT49");
               _loc3_ = _loc3_.replace("!#",Math.max(0,3 - GamePlayer.getInstance().MatchCount));
               this.m_txt0.htmlText = _loc3_;
               this.m_txt1.htmlText = "";
               this.m_First = true;
               break;
            case 2:
               _loc2_ = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
               this.m_tfCopyconetent.htmlText = _loc2_ + StringManager.getInstance().getMessageString("Boss19");
               this.m_tfCopyconetent.wordWrap = true;
               this.m_tfCopyconetent.multiline = true;
               this.m_tfCopyconetent.autoSize = "left";
               BleakingLineForThai.GetInstance().BleakThaiLanguage(this.m_tfCopyconetent,9555199);
               if(!this.m_First)
               {
                  this.m_tfCopyconetent.y -= 8;
               }
               this.m_RewardText.htmlText = StringManager.getInstance().getMessageString("Boss20");
               BleakingLineForThai.GetInstance().BleakThaiLanguage(this.m_RewardText,2412994);
               this.m_txt0.text = "";
               this.m_txt1.text = "";
               this.m_First = true;
               break;
            case 3:
               _loc2_ = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
               this.m_tfCopyconetent.htmlText = _loc2_ + StringManager.getInstance().getMessageString("Boss40");
               this.m_tfCopyconetent.wordWrap = true;
               this.m_tfCopyconetent.multiline = true;
               this.m_tfCopyconetent.autoSize = "left";
               BleakingLineForThai.GetInstance().BleakThaiLanguage(this.m_tfCopyconetent,9555199);
               if(!this.m_First)
               {
                  this.m_tfCopyconetent.y -= 8;
               }
               this.m_RewardText.htmlText = StringManager.getInstance().getMessageString("Boss41");
               BleakingLineForThai.GetInstance().BleakThaiLanguage(this.m_RewardText,2412994);
               this.m_txt0.text = "";
               this.m_txt1.text = "";
               this.m_First = true;
         }
      }
      
      private function onHandler(param1:MouseEvent) : void
      {
         var _loc3_:String = null;
         var _loc2_:String = param1.currentTarget.name;
         switch(_loc2_)
         {
            case "btn_entertask":
               TaskSceneUI.getInstance().ShowProgressTask();
               break;
            case "btn_enter":
               if(!this.m_IsClick)
               {
                  return;
               }
               if(this.m_EnterState == -1)
               {
                  return;
               }
               if(this.m_EnterState == GameDateTaskUI.STATE_COPY)
               {
                  this.GoCopy();
                  break;
               }
               if(this.m_EnterState == GameDateTaskUI.STATE_MATCH)
               {
                  if(InstanceManager.instance.curStatus != InstanceManager.FB_NONE && InstanceManager.instance.curEctype > -1 && InstanceManager.instance.curEctype != 1000)
                  {
                     _loc3_ = StringManager.getInstance().getMessageString("BattleTXT23");
                     MessageBox.show(_loc3_);
                     break;
                  }
                  ConstructionOperationWidget.getInstance().openGalaxyMatchUI();
                  break;
               }
               if(this.m_EnterState == GameDateTaskUI.STATE_GATE)
               {
                  this.GoCopy(2);
                  break;
               }
               if(this.m_EnterState == GameDateTaskUI.STATE_CONSTELLATION)
               {
                  this.GoCopy(3);
               }
               break;
            case "btn_copy0":
               this.m_IsClick = true;
               this.m_EnterState = GameDateTaskUI.STATE_COPY;
               this.m_SelectCopyBtn.setSelect(true);
               this.m_SelectCopy1Btn.setSelect(false);
               this.m_SelectCopy2Btn.setSelect(true);
               this.m_SelectCopy3Btn.setSelect(false);
               this.SetCopyStatue(0);
               return;
            case "btn_copy1":
               this.m_IsClick = true;
               this.m_EnterState = GameDateTaskUI.STATE_MATCH;
               this.m_SelectCopyBtn.setSelect(false);
               this.m_SelectCopy1Btn.setSelect(true);
               this.m_SelectCopy2Btn.setSelect(false);
               this.m_SelectCopy3Btn.setSelect(false);
               this.SetCopyStatue(1);
               return;
            case "btn_copy2":
               this.m_IsClick = true;
               this.m_EnterState = GameDateTaskUI.STATE_GATE;
               this.m_SelectCopyBtn.setSelect(false);
               this.m_SelectCopy1Btn.setSelect(false);
               this.m_SelectCopy2Btn.setSelect(true);
               this.m_SelectCopy3Btn.setSelect(false);
               this.SetCopyStatue(2);
               return;
            case "btn_copy3":
               this.m_IsClick = true;
               this.m_EnterState = GameDateTaskUI.STATE_CONSTELLATION;
               this.m_SelectCopyBtn.setSelect(false);
               this.m_SelectCopy1Btn.setSelect(false);
               this.m_SelectCopy2Btn.setSelect(false);
               this.m_SelectCopy3Btn.setSelect(true);
               this.SetCopyStatue(3);
               return;
            case "btn_lottery":
               LotteryUi.getInstance().Init();
               GameKernel.popUpDisplayManager.Show(LotteryUi.getInstance());
         }
         ScienceSystemUi.getInstance().onCloseWnd(param1);
         this.Hide();
      }
   }
}

