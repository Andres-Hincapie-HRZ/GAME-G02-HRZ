package logic.game
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.CEffectText;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.geom.Point;
   import gs.TweenLite;
   import logic.action.ConstructionAction;
   import logic.action.FaceBookAction;
   import logic.action.GalaxyMapAction;
   import logic.action.OutSideGalaxiasAction;
   import logic.action.StarSurfaceAction;
   import logic.entry.GStar;
   import logic.entry.GalaxyType;
   import logic.entry.GamePlaceType;
   import logic.entry.GamePlayer;
   import logic.entry.GameStageEnum;
   import logic.manager.FightManager;
   import logic.manager.GalaxyManager;
   import logic.manager.GameLoadingManager;
   import logic.manager.GameScreenManager;
   import logic.manager.HoldGalaxyManager;
   import logic.manager.InstanceManager;
   import logic.ui.BuyGoodsUI;
   import logic.ui.ChatUI;
   import logic.ui.ChipLottery;
   import logic.ui.CommanderSceneUI;
   import logic.ui.ConstructionUI;
   import logic.ui.CorpsListUI;
   import logic.ui.FieldUI;
   import logic.ui.FleetEditUI;
   import logic.ui.FriendsListUI;
   import logic.ui.GameSystemUI;
   import logic.ui.GemcheckPopUI;
   import logic.ui.LoadFleetUI;
   import logic.ui.LotteryUi;
   import logic.ui.MailUI;
   import logic.ui.MallUI;
   import logic.ui.MessagePopup;
   import logic.ui.PackUi;
   import logic.ui.RankingSceneUI;
   import logic.ui.ScienceSystemUi;
   import logic.ui.ShipModeEditUI;
   import logic.ui.ShipmodelUI;
   import logic.ui.TaskSceneUI;
   import logic.ui.UpgradeUI;
   import logic.ui.tip.CustomTip;
   import logic.widget.ConstructionOperationWidget;
   import logic.widget.OperationWidget;
   import logic.widget.ProgressInFriendToolBarWidget;
   import logic.widget.ProgressListToolBarWidget;
   import net.base.NetManager;
   import net.msg.sciencesystem.MSG_REQUEST_TECHUPGRADEINFO;
   import net.router.CommanderRouter;
   
   public class GameMouseZoneManager
   {
      
      private static var flag:Boolean = false;
      
      private static var flagInteractive:Boolean = false;
      
      private static var flagInteractive2:Boolean = false;
      
      private static var flagInteractive3:Boolean = false;
      
      private static var flagInteractive4:Boolean = false;
      
      private static var seeConstruct:Boolean = true;
      
      private static var isProgressShow:Boolean = true;
      
      public static var isEnterSearch:Boolean = false;
      
      public function GameMouseZoneManager()
      {
         super();
      }
      
      public static function ShowTip(param1:Event = null) : void
      {
         var _loc3_:String = null;
         var _loc2_:DisplayObject = param1.target as DisplayObject;
         var _loc4_:Point = _loc2_.localToGlobal(new Point());
         _loc4_.x += _loc2_.width;
         if(GameKernel.ForFB != 1)
         {
            _loc4_.y -= _loc2_.height;
         }
         if(param1.target.name == "tf_num")
         {
            return;
         }
         switch(_loc2_.name)
         {
            case "btn_gohome":
               _loc4_.x -= _loc2_.width;
               _loc3_ = StringManager.getInstance().getMessageString("MainUITXT23");
               break;
            case "btn_galaxy":
               _loc4_.x -= _loc2_.width;
               _loc3_ = StringManager.getInstance().getMessageString("MainUITXT21");
               break;
            case "btn_surface":
               _loc4_.x -= _loc2_.width;
               _loc3_ = StringManager.getInstance().getMessageString("MainUITXT22");
               break;
            case "btn_universe":
               _loc4_.x -= _loc2_.width;
               _loc3_ = StringManager.getInstance().getMessageString("MainUITXT28");
               break;
            case "mc_construct":
               _loc4_.x -= _loc2_.width;
               _loc3_ = StringManager.getInstance().getMessageString("MainUITXT0");
               break;
            case "mc_military":
               _loc4_.x -= _loc2_.width;
               _loc3_ = StringManager.getInstance().getMessageString("MainUITXT1");
               break;
            case "mc_system":
               if(GameKernel.isFullStage)
               {
                  _loc4_.x -= 80;
               }
               else
               {
                  _loc4_.x += _loc2_.width + 40;
               }
               _loc3_ = StringManager.getInstance().getMessageString("MainUITXT37");
               break;
            case "btn_mall":
               if(GameKernel.isFullStage)
               {
                  _loc4_.x -= 60;
               }
               else
               {
                  _loc4_.x += _loc2_.width + 60;
               }
               _loc3_ = StringManager.getInstance().getMessageString("MainUITXT4");
               break;
            case "btn_bag":
               _loc3_ = StringManager.getInstance().getMessageString("MainUITXT20");
               _loc4_.x -= 30;
               _loc4_.y += 10;
               break;
            case "btn_progress":
               if(GameKernel.isFullStage)
               {
                  _loc4_.x -= 122;
               }
               else
               {
                  _loc4_.x += _loc2_.width;
               }
               _loc4_.y -= _loc2_.height;
               _loc3_ = StringManager.getInstance().getMessageString("MainUITXT31");
               break;
            case "mc_alternation":
               _loc4_.x -= _loc2_.width;
               _loc3_ = StringManager.getInstance().getMessageString("MainUITXT2");
               break;
            case "btn_build":
               _loc3_ = StringManager.getInstance().getMessageString("MainUITXT8");
               break;
            case "btn_boatyard":
               _loc3_ = StringManager.getInstance().getMessageString("MainUITXT7");
               break;
            case "btn_technology":
               _loc3_ = StringManager.getInstance().getMessageString("MainUITXT6");
               break;
            case "btn_research":
               _loc3_ = StringManager.getInstance().getMessageString("MainUITXT5");
               break;
            case "btn_commander":
               _loc3_ = StringManager.getInstance().getMessageString("MainUITXT9");
               break;
            case "btn_unload":
               _loc3_ = StringManager.getInstance().getMessageString("MainUITXT10");
               break;
            case "btn_foundfleet":
               _loc3_ = StringManager.getInstance().getMessageString("MainUITXT11");
               break;
            case "btn_printdesign":
               _loc3_ = StringManager.getInstance().getMessageString("MainUITXT12");
               break;
            case "btn_corps":
               _loc3_ = StringManager.getInstance().getMessageString("MainUITXT13");
               break;
            case "btn_friend":
               _loc3_ = StringManager.getInstance().getMessageString("MainUITXT14");
               break;
            case "btn_business":
               _loc3_ = StringManager.getInstance().getMessageString("MainUITXT15");
               break;
            case "btn_ranking":
               _loc3_ = StringManager.getInstance().getMessageString("MainUITXT16");
               break;
            case "btn_task":
               _loc3_ = StringManager.getInstance().getMessageString("MainUITXT18");
               break;
            case "btn_mail":
               _loc3_ = StringManager.getInstance().getMessageString("MainUITXT19");
               break;
            case "btn_storage":
               _loc3_ = StringManager.getInstance().getMessageString("MainUITXT20");
               break;
            case "mc_metal":
               _loc4_.y += _loc2_.height;
               _loc3_ = StringManager.getInstance().getMessageString("MainUITXT24");
               break;
            case "mc_gold":
               _loc4_.y += _loc2_.height;
               _loc3_ = StringManager.getInstance().getMessageString("MainUITXT26");
               break;
            case "mc_He3":
               _loc4_.y += _loc2_.height;
               _loc3_ = StringManager.getInstance().getMessageString("MainUITXT25");
               break;
            case "mc_cash":
               _loc4_.y += _loc2_.height;
               _loc3_ = StringManager.getInstance().getMessageString("MainUITXT27");
               break;
            case "btn_mall0":
               if(GameKernel.isFullStage)
               {
                  _loc4_.x -= 160;
               }
               else
               {
                  _loc4_.x += _loc2_.width;
               }
               _loc4_.y -= _loc2_.height;
               _loc3_ = StringManager.getInstance().getMessageString("ItemText12");
               break;
            case "btn_mall1":
               if(GameKernel.isFullStage)
               {
                  _loc4_.x -= 160;
               }
               else
               {
                  _loc4_.x += _loc2_.width;
               }
               _loc4_.y -= _loc2_.height;
               _loc3_ = StringManager.getInstance().getMessageString("ItemText12");
               break;
            case "btn_mall2":
               if(GameKernel.isFullStage)
               {
                  _loc4_.x -= 160;
               }
               else
               {
                  _loc4_.x += _loc2_.width;
               }
               _loc4_.y -= _loc2_.height;
               _loc3_ = StringManager.getInstance().getMessageString("ItemText12");
               break;
            case "mc_starlist0":
               _loc4_.x -= _loc2_.width;
               _loc3_ = StringManager.getInstance().getMessageString("FriendText14");
               break;
            case "mc_starlist1":
               _loc4_.x -= _loc2_.width;
               _loc3_ = StringManager.getInstance().getMessageString("FriendText15");
               break;
            case "mc_starlist2":
               _loc4_.x -= _loc2_.width;
               _loc3_ = StringManager.getInstance().getMessageString("StarBtn9");
               break;
            case "mc_spplanbar2":
               if(FaceBookAction.getInstance().CurFaceBookFriendInfo == null)
               {
                  _loc3_ = StringManager.getInstance().getMessageString("MainUITXT29") + " " + GamePlayer.getInstance().SpValue;
                  break;
               }
               _loc3_ = StringManager.getInstance().getMessageString("MainUITXT30");
               break;
            case "btn_steal":
               _loc3_ = StringManager.getInstance().getMessageString("MainUITXT33");
               break;
            case "btn_news":
               _loc4_.y += _loc2_.height;
               _loc3_ = StringManager.getInstance().getMessageString("MainUITXT32");
               break;
            case "btn_lottery":
               _loc4_.x += _loc2_.width + 30;
               _loc4_.y += _loc2_.height;
               _loc3_ = StringManager.getInstance().getMessageString("MainUITXT34");
               break;
            case "mc_mall":
               _loc4_.x -= _loc2_.width;
               _loc3_ = StringManager.getInstance().getMessageString("MainUITXT3");
               break;
            case "btn_daytask":
               _loc4_.y += _loc2_.height;
               _loc3_ = StringManager.getInstance().getMessageString("MainUITXT40");
               break;
            case "btn_chip":
               _loc4_.x += _loc2_.width - 20;
               _loc4_.y += _loc2_.height;
               _loc3_ = StringManager.getInstance().getMessageString("Boss70");
         }
         CustomTip.GetInstance().Show(_loc3_,_loc4_);
      }
      
      public static function HideTip(param1:Event) : void
      {
         CustomTip.GetInstance().Hide();
      }
      
      public static function NagivateToolBarByName(param1:String, param2:Boolean) : void
      {
         var _loc3_:GStar = null;
         var _loc4_:int = 0;
         var _loc5_:Container = null;
         var _loc6_:int = 0;
         var _loc7_:MSG_REQUEST_TECHUPGRADEINFO = null;
         var _loc8_:String = null;
         if(param2)
         {
            flag = true;
            flagInteractive = true;
            flagInteractive2 = true;
            flagInteractive3 = true;
            flagInteractive4 = true;
         }
         ChatUI.getInstance().setSpecialTipState(false);
         GameKernel.renderManager.getUI().removeComponent(GemcheckPopUI.getInstance()._mc);
         switch(param1)
         {
            case "btn_gohome":
               InstanceManager.instance.quitInstance();
               GameStateManager.getInstance().goHome();
               break;
            case "btn_universe":
               if(GameKernel.currentGameStage == GameStageEnum.GAME_STAGE_GALAXY)
               {
                  return;
               }
               if(GameKernel.isBuildModule)
               {
                  ConstructionAction.getInstance().clearConstructionModule();
               }
               GameKernel.currentGameStage = GameStageEnum.GAME_STAGE_GALAXY;
               ChatUI.getInstance().TextArea.Validate();
               if(GameLoadingManager.getInstance().IsHadLoad("galaxy_asset"))
               {
                  goForwardGalaxyMap();
                  break;
               }
               if(GameLoadingManager.getInstance().LoadState == GameLoadingManager.STATE_PROGRESS)
               {
                  GameLoadingManager.getInstance().ShowLoadingUI();
                  break;
               }
               if(GameLoadingManager.getInstance().LoadState == GameLoadingManager.STATE_COMPLETED)
               {
                  GameLoadingManager.getInstance().HideLoadingUI();
                  goForwardGalaxyMap();
               }
               break;
            case "btn_galaxy":
               if(GameKernel.isBuildModule)
               {
                  ConstructionAction.getInstance().clearConstructionModule();
               }
               InstanceManager.instance.quitInstance();
               _loc3_ = GalaxyManager.instance.enterStar;
               _loc4_ = _loc3_.FightFlag == 1 ? 1 : 0;
               if(0 == (ConstructionAction.isView | _loc4_ | int(HoldGalaxyManager.instance.isHoldGalaxy(_loc3_.GalaxyId))))
               {
                  if(GameKernel.currentGameStage == GameStageEnum.GAME_STAGE_OUTSIDE)
                  {
                     if(_loc3_.Type == GalaxyType.GT_3)
                     {
                        return;
                     }
                  }
                  else
                  {
                     CEffectText.getInstance().showEffectText(GameKernel.renderManager.getUI().getContainer(),StringManager.getInstance().getMessageString("StarBtn4"));
                  }
                  return;
               }
               if(_loc3_.FightFlag == 1)
               {
                  FightManager.instance.CleanFight();
                  GalaxyManager.instance.sendRequestGalaxy();
               }
               if(_loc3_.Type == GalaxyType.GT_3)
               {
                  if(0 == _loc3_.FightFlag)
                  {
                     return;
                  }
                  gotoOutSideMap();
                  return;
               }
               if(GameStateManager.playerPlace == GamePlaceType.PLACE_HOME)
               {
                  ProgressListToolBarWidget.getInstance().showProgressList();
               }
               if(_loc3_.FightFlag == 1)
               {
                  if(GameStateManager.playerPlace == GamePlaceType.PLACE_FRIENDHOME)
                  {
                     ProgressInFriendToolBarWidget.getInstance().setInFriendProgressListVisible(false);
                  }
               }
               else if(GameStateManager.playerPlace == GamePlaceType.PLACE_FRIENDHOME)
               {
                  ProgressInFriendToolBarWidget.getInstance().showInFriendProgressList();
               }
               gotoOutSideMap();
               break;
            case "btn_surface":
               if(GameKernel.isBuildModule)
               {
                  ConstructionAction.getInstance().clearConstructionModule();
               }
               InstanceManager.instance.quitInstance();
               if(GalaxyManager.instance.enterStar.Type == GalaxyType.GT_3)
               {
                  return;
               }
               gotoStarSurfaceMap();
               if(GameStateManager.playerPlace == GamePlaceType.PLACE_HOME)
               {
                  ProgressInFriendToolBarWidget.getInstance().setInFriendProgressListVisible(true);
               }
               if(GameStateManager.playerPlace == GamePlaceType.PLACE_FRIENDHOME)
               {
                  if(GalaxyManager.instance.enterStar.FightFlag == 1)
                  {
                     ProgressInFriendToolBarWidget.getInstance().setInFriendProgressListVisible(true);
                  }
                  if(!ProgressInFriendToolBarWidget.getInstance().IsShow)
                  {
                     ProgressInFriendToolBarWidget.getInstance().setInFriendProgressListVisible(true);
                  }
               }
               seeConstruct = !seeConstruct;
               break;
            case "mc_construct":
               playSubMenu();
               break;
            case "mc_military":
               playInteractiveSubMenu();
               break;
            case "mc_system":
               playInteractiveSubMenu4();
               break;
            case "mc_mall":
               playInteractiveSubMenu3();
               break;
            case "btn_progress":
               _loc5_ = ProgressListToolBarWidget.getInstance().Wrapper;
               if(isProgressShow)
               {
                  TweenLite.to(_loc5_,1,{
                     "autoAlpha":0,
                     "onComplete":ProgressListToolBarWidget.getInstance().HideProgressList
                  });
               }
               else
               {
                  ProgressListToolBarWidget.getInstance().showProgressList();
                  TweenLite.to(_loc5_,1,{"autoAlpha":1});
               }
               isProgressShow = !isProgressShow;
               break;
            case "mc_alternation":
               playInteractiveSubMenu2();
               break;
            case "btn_foundfleet":
               FleetEditUI.getInstance().Init();
               GameKernel.popUpDisplayManager.Show(FleetEditUI.getInstance());
               CloseSubMenuState();
               break;
            case "btn_printdesign":
               ShipModeEditUI.getInstance().Init();
               GameKernel.popUpDisplayManager.Show(ShipModeEditUI.getInstance());
               CloseSubMenuState();
               break;
            case "btn_research":
               isEnterSearch = true;
               if(ConstructionAction.getInstance().getWeaponResearchNumber() == -1)
               {
                  MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("BuildingText11"),0);
                  break;
               }
               UpgradeUI.getInstance().Init();
               GameKernel.popUpDisplayManager.Show(UpgradeUI.getInstance());
               CloseSubMenuState();
               break;
            case "btn_boatyard":
               if(ConstructionAction.getInstance().getShipBuildingProductNumber() == -1)
               {
                  MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("ShipText6"),0);
               }
               else
               {
                  ShipmodelUI.getInstance().m_beingMcNum = ConstructionAction.getInstance().getShipBuildingProductNumber();
                  ShipmodelUI.getInstance().m_beingMcNum = ShipmodelUI.getInstance().m_beingMcNum + GamePlayer.getInstance().m_ParallelCreateShip;
                  ShipmodelUI.getInstance().Init();
                  _loc6_ = 0;
                  while(_loc6_ < 5)
                  {
                     ShipmodelUI.getInstance().showInitBeingDate(_loc6_);
                     _loc6_++;
                  }
                  ShipmodelUI.getInstance().InitPopUp();
                  GameKernel.popUpDisplayManager.Show(ShipmodelUI.getInstance());
               }
               CloseSubMenuState();
               break;
            case "btn_commander":
               if(ConstructionAction.getInstance().getCommanderCenterNumber() == -1)
               {
                  MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("BuildingText12"),0);
                  break;
               }
               CommanderSceneUI.getInstance().Init();
               if(CommanderRouter.instance.m_commandInfoAry.length > 0)
               {
                  CommanderSceneUI.getInstance().m_choosenum = 0;
                  CommanderSceneUI.getInstance().InitPopUp();
                  GameKernel.getInstance().isCommanderInit = true;
                  CommanderRouter.instance.onSendMsgCommander(CommanderRouter.instance.m_commandInfoAry[0].commander_commanderId);
               }
               else
               {
                  CommanderSceneUI.getInstance().InitPopUp();
                  CommanderSceneUI.getInstance().InitCommanderinfo();
               }
               GameKernel.popUpDisplayManager.Show(CommanderSceneUI.getInstance());
               CloseSubMenuState();
               break;
            case "btn_corps":
               if(ConstructionAction.getInstance().getUnionCenterNumber() == -1)
               {
                  MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("BuildingText13"),0);
                  break;
               }
               CorpsListUI.getInstance().Init();
               GameKernel.popUpDisplayManager.Show(CorpsListUI.getInstance());
               CloseSubMenuState();
               break;
            case "btn_ranking":
               RankingSceneUI.getInstance().Init();
               RankingSceneUI.getInstance().ShowNormalRank();
               GameKernel.popUpDisplayManager.Show(RankingSceneUI.getInstance());
               CloseSubMenuState();
               break;
            case "btn_transition":
               break;
            case "btn_technology":
               ScienceSystemUi.getInstance().Init();
               GameKernel.popUpDisplayManager.Show(ScienceSystemUi.getInstance());
               _loc7_ = new MSG_REQUEST_TECHUPGRADEINFO();
               _loc7_.SeqId = GamePlayer.getInstance().seqID++;
               _loc7_.Guid = GamePlayer.getInstance().Guid;
               NetManager.Instance().sendObject(_loc7_);
               CloseSubMenuState();
               break;
            case "btn_mail":
               MailUI.getInstance().Init();
               GameKernel.popUpDisplayManager.Show(MailUI.getInstance());
               CloseSubMenuState();
               break;
            case "btn_storage":
               PackUi.getInstance().Init();
               GameKernel.popUpDisplayManager.Show(PackUi.getInstance());
               CloseSubMenuState();
               break;
            case "btn_business":
               if(ConstructionAction.getInstance().getTradePortNumber() == -1)
               {
                  MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("BuildingText14"),0);
                  break;
               }
               MallUI.getInstance().Init();
               GameKernel.popUpDisplayManager.Show(MallUI.getInstance());
               CloseSubMenuState();
               break;
            case "btn_friend":
               FriendsListUI.getInstance().Init();
               GameKernel.popUpDisplayManager.Show(FriendsListUI.getInstance());
               CloseSubMenuState();
               break;
            case "btn_build":
               if(GameKernel.isBuildModule)
               {
                  ConstructionAction.getInstance().clearConstructionModule();
               }
               GameMouseZoneManager.setSubMenuState();
               ConstructionOperationWidget.getInstance().Hide();
               OperationWidget.getInstance().Hide();
               if(GameStateManager.playerPlace != GamePlaceType.PLACE_HOME)
               {
                  return;
               }
               if(GameKernel.currentGameStage == GameStageEnum.GAME_STAGE_GALAXY)
               {
                  return;
               }
               if(GalaxyMapAction.instance.curStar.Type == GalaxyType.GT_3)
               {
                  return;
               }
               ConstructionUI.getInstance().Init();
               GameKernel.popUpDisplayManager.Show(ConstructionUI.getInstance());
               break;
            case "btn_unload":
               LoadFleetUI.getInstance().Init();
               GameKernel.popUpDisplayManager.Show(LoadFleetUI.getInstance());
               CloseSubMenuState();
               break;
            case "btn_task":
               TaskSceneUI.getInstance().Init();
               GameKernel.popUpDisplayManager.Show(TaskSceneUI.getInstance());
               CloseSubMenuState();
               break;
            case "btn_steal":
               _loc8_ = GamePlayer.getInstance().Name;
               FieldUI.getInstance().Show(GamePlayer.getInstance().galaxyMapID,GamePlayer.getInstance().galaxyID,GamePlayer.getInstance().userID,_loc8_,GamePlayer.getInstance().Guid);
               CloseSubMenuState();
               break;
            case "btn_mall":
               BuyGoodsUI.getInstance().Init();
               GameKernel.popUpDisplayManager.Show(BuyGoodsUI.getInstance());
               CloseSubMenuState();
               break;
            case "btn_lottery":
               LotteryUi.getInstance().Init();
               GameKernel.popUpDisplayManager.Show(LotteryUi.getInstance());
               CloseSubMenuState();
               break;
            case "btn_chip":
               ChipLottery.getInstance().Show();
               CloseSubMenuState();
         }
         if(ConstructionOperationWidget.getInstance().Operation)
         {
            ConstructionOperationWidget.getInstance().Hide();
         }
         if(GameKernel.currentGameStage != GameStageEnum.GAME_STAGE_OUTSIDE && GameKernel.currentGameStage != GameStageEnum.GAME_STAGE_STARSURFACE)
         {
            OutSideGalaxiasAction.getInstance().removeCreateEvent();
         }
      }
      
      public static function onNagivateToolBar(param1:Event = null) : void
      {
         NagivateToolBarByName(param1.target.name,false);
      }
      
      public static function setSubMenuState() : void
      {
         if(flagInteractive)
         {
            GameSystemUI.getInstance().HideInteractiveSubMenu();
            flagInteractive = !flagInteractive;
            flagInteractive2 = !flagInteractive2;
         }
         if(flag)
         {
            flag = !flag;
            GameSystemUI.getInstance().HideSubMenu();
         }
         if(flagInteractive2)
         {
            GameSystemUI.getInstance().HideInteractiveSubMenu2();
            flagInteractive2 = !flagInteractive2;
         }
         if(flagInteractive3)
         {
            GameSystemUI.getInstance().HideInteractiveSubMenu3();
            flagInteractive3 = !flagInteractive3;
         }
         if(flagInteractive4)
         {
            GameSystemUI.getInstance().HideInteractiveSubMenu4();
            flagInteractive4 = !flagInteractive4;
         }
      }
      
      public static function CloseSubMenuState() : void
      {
         GameSystemUI.getInstance().HideInteractiveSubMenu();
         flagInteractive = false;
         GameSystemUI.getInstance().HideSubMenu();
         flag = false;
         GameSystemUI.getInstance().HideInteractiveSubMenu2();
         flagInteractive2 = false;
         GameSystemUI.getInstance().HideInteractiveSubMenu3();
         flagInteractive3 = false;
         GameSystemUI.getInstance().HideInteractiveSubMenu4();
         flagInteractive4 = false;
      }
      
      public static function playSubMenu() : void
      {
         if(flag)
         {
            GameSystemUI.getInstance().HideSubMenu();
         }
         else
         {
            if(flagInteractive)
            {
               playInteractiveSubMenu();
            }
            if(flagInteractive2)
            {
               playInteractiveSubMenu2();
            }
            if(flagInteractive3)
            {
               playInteractiveSubMenu3();
            }
            if(flagInteractive4)
            {
               playInteractiveSubMenu4();
            }
            GameSystemUI.getInstance().ShowSubMenu();
         }
         flag = !flag;
      }
      
      public static function playInteractiveSubMenu() : void
      {
         if(flagInteractive)
         {
            GameSystemUI.getInstance().HideInteractiveSubMenu();
         }
         else
         {
            if(flag)
            {
               playSubMenu();
            }
            if(flagInteractive2)
            {
               playInteractiveSubMenu2();
            }
            if(flagInteractive3)
            {
               playInteractiveSubMenu3();
            }
            if(flagInteractive4)
            {
               playInteractiveSubMenu4();
            }
            GameSystemUI.getInstance().ShowInteractiveSubMenu();
         }
         flagInteractive = !flagInteractive;
      }
      
      public static function playInteractiveSubMenu2() : void
      {
         if(flagInteractive2)
         {
            GameSystemUI.getInstance().HideInteractiveSubMenu2();
         }
         else
         {
            if(flag)
            {
               playSubMenu();
            }
            if(flagInteractive)
            {
               playInteractiveSubMenu();
            }
            if(flagInteractive3)
            {
               playInteractiveSubMenu3();
            }
            if(flagInteractive4)
            {
               playInteractiveSubMenu4();
            }
            GameSystemUI.getInstance().ShowInteractiveSubMenu2();
         }
         flagInteractive2 = !flagInteractive2;
      }
      
      public static function playInteractiveSubMenu3() : void
      {
         if(flagInteractive3)
         {
            GameSystemUI.getInstance().HideInteractiveSubMenu3();
         }
         else
         {
            if(flag)
            {
               playSubMenu();
            }
            if(flagInteractive)
            {
               playInteractiveSubMenu();
            }
            if(flagInteractive2)
            {
               playInteractiveSubMenu2();
            }
            if(flagInteractive4)
            {
               playInteractiveSubMenu4();
            }
            GameSystemUI.getInstance().ShowInteractiveSubMenu3();
         }
         flagInteractive3 = !flagInteractive3;
      }
      
      public static function playInteractiveSubMenu4() : void
      {
         if(flagInteractive4)
         {
            GameSystemUI.getInstance().HideInteractiveSubMenu4();
         }
         else
         {
            if(flag)
            {
               playSubMenu();
            }
            if(flagInteractive)
            {
               playInteractiveSubMenu();
            }
            if(flagInteractive2)
            {
               playInteractiveSubMenu2();
            }
            if(flagInteractive3)
            {
               playInteractiveSubMenu3();
            }
            GameSystemUI.getInstance().ShowInteractiveSubMenu4();
         }
         flagInteractive4 = !flagInteractive4;
      }
      
      public static function gotoStarSurfaceMap(param1:Event = null) : void
      {
         if(GameKernel.isBuildModule)
         {
            ConstructionAction.getInstance().clearConstructionModule();
         }
         GameKernel.currentMapModelIndex = 0;
         GameKernel.currentGameStage = GameStageEnum.GAME_STAGE_STARSURFACE;
         ChatUI.getInstance().TextArea.Validate();
         if(GameStateManager.playerPlace == GamePlaceType.PLACE_HOME)
         {
            ProgressListToolBarWidget.getInstance().showProgressList();
         }
         StarSurfaceAction.getInstance().Init();
         GameScreenManager.getInstance().ShowScreen(StarSurfaceAction.getInstance());
         ConstructionAction.getInstance().SufFaceUI = StarSurfaceAction.getInstance().LayOut;
         seeConstruct = !seeConstruct;
      }
      
      public static function gotoOutSideMap() : void
      {
         GameKernel.currentMapModelIndex = 1;
         GameKernel.currentGameStage = GameStageEnum.GAME_STAGE_OUTSIDE;
         ChatUI.getInstance().TextArea.Validate();
         OutSideGalaxiasAction.getInstance().Init();
         if(GameStateManager.playerPlace == GamePlaceType.PLACE_HOME)
         {
            ProgressListToolBarWidget.getInstance().showProgressList();
         }
         GameScreenManager.getInstance().ShowScreen(OutSideGalaxiasAction.getInstance());
         ConstructionAction.getInstance().SufFaceUI = OutSideGalaxiasAction.getInstance().OutSideDefendContainer;
      }
      
      public static function goForwardGalaxyMap() : void
      {
         var _loc1_:Bitmap = null;
         InstanceManager.instance.quitInstance();
         if(GameKernel.isFullStage)
         {
            if(GalaxyMapAction.instance.galaxyMapBgWidth == 0 && GalaxyMapAction.instance.galayMapBgHeight == 0)
            {
               _loc1_ = new Bitmap(GameKernel.getTextureInstance("Map2"));
               GalaxyMapAction.instance.getGalaxyMapBg().Base_SetBackGround(_loc1_);
               GalaxyMapAction.instance.getGalaxyMapBg().width = GameKernel.fullRect.width;
               GalaxyMapAction.instance.getGalaxyMapBg().height = GameKernel.fullRect.height;
            }
         }
         else
         {
            GalaxyMapAction.instance.getGalaxyMapBg().Base_SetBackGround(new Bitmap(GameKernel.getTextureInstance("Map2")));
            GalaxyMapAction.instance.cacheGalaxyMapBgWH();
         }
         if(GameKernel.isBuildModule)
         {
            ConstructionAction.getInstance().clearConstructionModule();
         }
         ProgressListToolBarWidget.getInstance().HideProgressList();
         ProgressInFriendToolBarWidget.getInstance().setInFriendProgressListVisible(false);
         GalaxyManager.instance.gotoGalaxyMap();
         GameSystemUI.getInstance().setViewFaceBookGalaxyState(false);
         GameScreenManager.getInstance().ShowScreen(GalaxyMapAction.instance);
         GameKernel.currentGameStage = GameStageEnum.GAME_STAGE_GALAXY;
      }
   }
}

