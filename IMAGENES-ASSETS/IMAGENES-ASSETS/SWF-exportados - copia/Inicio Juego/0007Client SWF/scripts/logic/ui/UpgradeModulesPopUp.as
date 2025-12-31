package logic.ui
{
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.managers.StringManager;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import logic.action.ConstructionAction;
   import logic.entry.ConstructionState;
   import logic.entry.HButton;
   import logic.game.GameKernel;
   import logic.impl.IModulePopUp;
   import logic.manager.GameInterActiveManager;
   import logic.ui.info.BleakingLineForThai;
   import logic.utils.UpdateResource;
   import logic.widget.ConstructionOperationWidget;
   import logic.widget.OperationEnum;
   import logic.widget.ProgressListToolBarWidget;
   import net.router.CommanderRouter;
   import net.router.ShipmodelRouter;
   
   public class UpgradeModulesPopUp implements IModulePopUp
   {
      
      private static var instance:UpgradeModulesPopUp;
      
      protected var _name:String;
      
      protected var _popWnd:MovieClip;
      
      protected var _numTF:TextField;
      
      protected var _okayBtn:HButton;
      
      protected var _cancelBtn:HButton;
      
      private var _num:int;
      
      private var m_name:String;
      
      private var callBack:Function;
      
      public function UpgradeModulesPopUp()
      {
         super();
      }
      
      public static function getInstance() : UpgradeModulesPopUp
      {
         if(instance == null)
         {
            instance = new UpgradeModulesPopUp();
         }
         return instance;
      }
      
      public function Init() : void
      {
         if(this._popWnd)
         {
            this.setTFState();
            GameInterActiveManager.InstallInterActiveEvent(this._okayBtn.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
            GameInterActiveManager.InstallInterActiveEvent(this._cancelBtn.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
            return;
         }
         this._popWnd = GameKernel.getMovieClipInstance("HireScenePopup");
         this._popWnd.x = GameKernel.getInstance().stage.stageWidth - this._popWnd.width * 0.5 >> 1;
         this._popWnd.x += this._popWnd.width * 0.25;
         this._popWnd.y = 300;
         this._numTF = this._popWnd.tf_content as TextField;
         this._okayBtn = new HButton(this._popWnd.mc_ensure);
         this._cancelBtn = new HButton(this._popWnd.btn_cancel);
         this.setTFState();
         GameInterActiveManager.InstallInterActiveEvent(this._okayBtn.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
         GameInterActiveManager.InstallInterActiveEvent(this._cancelBtn.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
      }
      
      private function setTFState() : void
      {
         if(this._numTF == null)
         {
            return;
         }
         switch(ConstructionOperationWidget.currenCmd)
         {
            case OperationEnum.OPERATION_TYPE_DESTORY:
               this._numTF.text = "  " + StringManager.getInstance().getMessageString("BuildingText2") + ConstructionAction.currentTarget.EquimentInfoData.BuildName;
               break;
            case OperationEnum.OPERATION_TYPE_CANCEL:
               this._numTF.text = "  " + StringManager.getInstance().getMessageString("BuildingText1") + ConstructionAction.currentTarget.EquimentInfoData.BuildName + StringManager.getInstance().getMessageString("BuildingText20");
               break;
            case OperationEnum.OPERATION_TYPE_UPGRADE:
               this._numTF.text = "  " + StringManager.getInstance().getMessageString("BuildingText4");
               break;
            case OperationEnum.OPERATION_TYPE_SPEED:
               this._numTF.text = "  " + StringManager.getInstance().getMessageString("BuildingText3");
               break;
            case OperationEnum.OPERATION_TYPE_SPEED_BY_COINS:
               this._numTF.text = "  " + StringManager.getInstance().getMessageString("BuildingText16");
               break;
            case OperationEnum.OPERATION_TYPE_CANCEL_UPGRADE:
               this._numTF.text = "  " + StringManager.getInstance().getMessageString("TechnologyText3");
               break;
            case OperationEnum.OPERATION_TYPE_CANCEL_PACKAGE_TOOL:
               this._numTF.text = "  " + StringManager.getInstance().getMessageString("ItemText11");
               break;
            case OperationEnum.OPERATION_TYPE_BODY_SPEED_UPGRADE:
               this._numTF.text = "  " + StringManager.getInstance().getMessageString("TechnologyText3");
               break;
            case OperationEnum.OPERATION_TYPE_CANCEL_CREATE:
               this._numTF.text = "  " + StringManager.getInstance().getMessageString("ShipText18");
               break;
            case OperationEnum.OPERATION_TYPE_DELSHIPMODEL:
               this._numTF.text = "  " + StringManager.getInstance().getMessageString("ShipText19");
               break;
            case OperationEnum.OPERATION_TYPE_NOCASH:
               this._numTF.text = "  " + StringManager.getInstance().getMessageString("ShipText20");
               break;
            case OperationEnum.OPERATION_TYPE_XIDIAN:
               this._numTF.text = "  " + StringManager.getInstance().getMessageString("CommanderText71");
               break;
            case OperationEnum.OPERATION_TYPE_FIRECOMMANDER:
               this._numTF.text = "  " + StringManager.getInstance().getMessageString("CommanderText90") + String(this.m_name) + StringManager.getInstance().getMessageString("CommanderText91");
               break;
            case OperationEnum.OPERATION_TYPE_NOSPEED:
               this._numTF.text = "  " + StringManager.getInstance().getMessageString("ShipText24");
               break;
            case OperationEnum.OPERATION_TYPE_INTOID:
               this._numTF.text = "  " + StringManager.getInstance().getMessageString("RankingTXT01");
               break;
            case OperationEnum.OPERATION_TYPE_NOFINDID:
               this._numTF.text = "  " + StringManager.getInstance().getMessageString("RankingTXT02");
               break;
            case OperationEnum.OPERATION_TYPE_CANNOTCARD:
               this._numTF.text = "  " + StringManager.getInstance().getMessageString("CommanderText97");
               break;
            case OperationEnum.OPERATION_TYPE_CHANGECARD:
               this._numTF.text = "  " + StringManager.getInstance().getMessageString("CommanderText95") + String(this.m_name) + StringManager.getInstance().getMessageString("CommanderText96");
               break;
            case OperationEnum.OPERATION_TYPE_CONDITIONSCHANGECARD:
               this._numTF.text = "  " + StringManager.getInstance().getMessageString("CommanderText98");
               break;
            case OperationEnum.OPERATION_TYPE_BAGNOINTO:
               this._numTF.text = "  " + StringManager.getInstance().getMessageString("CommanderText12");
               break;
            case OperationEnum.OPERATION_TYPE_BATCHFIRE:
               this._numTF.htmlText = "  " + StringManager.getInstance().getMessageString("CommanderText19");
               break;
            case OperationEnum.OPERATION_TYPE_NOJOIN:
               this._numTF.htmlText = "  " + StringManager.getInstance().getMessageString("Boss177");
               break;
            case OperationEnum.OPERATION_TYPE_COINJOIN:
               this._numTF.text = "  " + StringManager.getInstance().getMessageString("Boss185");
         }
         BleakingLineForThai.GetInstance().BleakThaiLanguage(this._numTF,16777215);
      }
      
      public function Show() : void
      {
         if(GameKernel.renderManager.getUI().getContainer().contains(this._popWnd))
         {
            return;
         }
         this.AddEvent();
         GameKernel.renderManager.lockScene(true);
         GameKernel.renderManager.getUI().addComponent(this._popWnd);
      }
      
      public function Hide(param1:Boolean = false) : void
      {
         if(GameKernel.renderManager.getUI().getContainer().contains(this._popWnd))
         {
            GameKernel.renderManager.getUI().removeComponent(this._popWnd);
            GameKernel.renderManager.lockScene(false);
            this.Remove();
         }
      }
      
      public function getModulePopUp() : DisplayObject
      {
         return this._popWnd;
      }
      
      public function AddEvent() : void
      {
         GameInterActiveManager.InstallInterActiveEvent(this._okayBtn.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
         GameInterActiveManager.InstallInterActiveEvent(this._cancelBtn.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
      }
      
      public function Remove() : void
      {
         GameInterActiveManager.unInstallnterActiveEvent(this._okayBtn.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
         GameInterActiveManager.unInstallnterActiveEvent(this._cancelBtn.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
      }
      
      public function getbeingCreateNum(param1:int) : void
      {
         this._num = param1;
      }
      
      public function getdelShipmodel(param1:int) : void
      {
         this._num = param1;
      }
      
      public function getCommanderName(param1:String) : void
      {
         this.m_name = param1;
      }
      
      private function onHandler(param1:MouseEvent) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         this._okayBtn.setBtnDisabled(false);
         switch(param1.target.name)
         {
            case "mc_ensure":
               if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_DESTORY)
               {
                  if(GameKernel.currentMapModelIndex & 1)
                  {
                     ConstructionAction.currentTarget.HideEquimentInfluence();
                  }
                  ConstructionAction.getInstance().deleteBuildRequest(ConstructionAction.currentTarget.EquimentInfoData.IndexId);
               }
               else if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_CANCEL)
               {
                  if(ConstructionAction.currentTarget.State == ConstructionState.STATE_UPDATE || ConstructionAction.currentTarget.State == ConstructionState.STATE_BUILING)
                  {
                     if(GameKernel.currentMapModelIndex & 1)
                     {
                        ConstructionAction.currentTarget.HideEquimentInfluence();
                     }
                     ConstructionAction.getInstance().cancelBuildRequest(ConstructionAction.currentTarget.EquimentInfoData.IndexId);
                     ProgressListToolBarWidget.getInstance().Destory(ConstructionAction.currentTarget);
                     switch(ConstructionAction.currentTarget.State)
                     {
                        case ConstructionState.STATE_BUILING:
                           if(ConstructionAction.currentTarget.parent)
                           {
                              ConstructionAction.currentTarget.parent.removeChild(ConstructionAction.currentTarget);
                           }
                     }
                     ConstructionAction.currentTarget = null;
                  }
               }
               else
               {
                  if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_CANCEL_UPGRADE)
                  {
                     ScienceSystemUi.getInstance().CANCEL();
                     ScienceSystemUi.getInstance().Hider();
                     this.Hide(true);
                     return;
                  }
                  if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_CANCEL_PACKAGE_TOOL)
                  {
                     PackUi.getInstance().DeleteGoods();
                     PackUi.getInstance().Hider(1);
                     this.Hide(true);
                     return;
                  }
                  if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_CANCEL_CREATE)
                  {
                     ShipmodelRouter.instance.sendmsgCANCELSHIP(this._num);
                     ShipmodelUI.getInstance().removeBackMC();
                     this.Hide(true);
                     return;
                  }
                  if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_DELSHIPMODEL)
                  {
                     ShipmodelUI.getInstance()._delmodel(this._num);
                     this.Hide(true);
                     return;
                  }
                  if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_NOCASH)
                  {
                     ShipmodelUI.getInstance().removeBackMC();
                     this.Hide(true);
                     return;
                  }
                  if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_XIDIAN)
                  {
                     _loc2_ = false;
                     _loc2_ = UpdateResource.getInstance().pdHd(924);
                     if(_loc2_ == true)
                     {
                        CommanderSceneUI.getInstance().removeBackMC();
                        this.Hide(true);
                        CommanderRouter.instance.onSendMsgCLEARCOMMANDERPERCENT(CommanderSceneUI.getInstance().m_commanderInfo.commander_commanderId);
                     }
                     else
                     {
                        this.Hide(true);
                        StateHandlingUI.getInstance().Init();
                        StateHandlingUI.getInstance().setParent("CommanderSceneUI");
                        StateHandlingUI.getInstance().getstate(924);
                        StateHandlingUI.getInstance().InitPopUp();
                        GameKernel.popUpDisplayManager.Show(StateHandlingUI.getInstance());
                     }
                     return;
                  }
                  if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_FIRECOMMANDER)
                  {
                     this.Hide(true);
                     CommanderSceneUI.getInstance().removeBackMC();
                     CommanderSceneUI.getInstance().callback();
                     return;
                  }
                  if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_NOSPEED)
                  {
                     ShipmodelUI.getInstance().removeBackMC();
                     this.Hide(true);
                     return;
                  }
                  if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_INTOID)
                  {
                     RankingSceneUI.getInstance().removeBackMC();
                     this.Hide(true);
                     return;
                  }
                  if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_NOFINDID)
                  {
                     RankingSceneUI.getInstance().removeBackMC();
                     this.Hide(true);
                     return;
                  }
                  if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_CANNOTCARD)
                  {
                     CommanderSceneUI.getInstance().removeBackMC();
                     this.Hide(true);
                     return;
                  }
                  if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_CHANGECARD)
                  {
                     CommanderSceneUI.getInstance().removeBackMC();
                     this.Hide(true);
                     _loc3_ = false;
                     _loc3_ = UpdateResource.getInstance().pdHd(926);
                     if(_loc3_ == true)
                     {
                        CommanderRouter.instance.sendmsgCOMMANDERCHANGECARD(CommanderSceneUI.getInstance().m_commanderInfo.commander_commanderId);
                     }
                     else
                     {
                        CommanderSceneUI.getInstance().ChangeCard();
                     }
                     return;
                  }
                  if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_CONDITIONSCHANGECARD)
                  {
                     CommanderSceneUI.getInstance().removeBackMC();
                     this.Hide(true);
                     return;
                  }
                  if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_BAGNOINTO)
                  {
                     CommanderSceneUI.getInstance().removeBackMC();
                     this.Hide(true);
                     return;
                  }
                  if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_BATCHFIRE)
                  {
                     CommanderSceneUI.getInstance().removeBackMC();
                     this.Hide(true);
                     CommanderSceneUI.getInstance().Clickbatchfire();
                     return;
                  }
                  if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_NOJOIN)
                  {
                     GymkhanaUI.getInstance().removeBackMC();
                     this.Hide(true);
                     return;
                  }
                  if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_COINJOIN)
                  {
                     GymkhanaUI.getInstance().sendTZ();
                     GymkhanaUI.getInstance().removeBackMC();
                     this.Hide(true);
                     return;
                  }
               }
               this.Hide();
               break;
            case "btn_cancel":
               if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_CANCEL_UPGRADE)
               {
                  ScienceSystemUi.getInstance().Hider();
                  this.Hide(true);
                  return;
               }
               if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_CANCEL_PACKAGE_TOOL)
               {
                  PackUi.getInstance().Hider(1);
                  this.Hide(true);
                  return;
               }
               if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_CANCEL_CREATE)
               {
                  ShipmodelUI.getInstance().removeBackMC();
                  this.Hide(true);
                  return;
               }
               if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_DELSHIPMODEL)
               {
                  this.Hide(true);
                  return;
               }
               if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_NOCASH)
               {
                  ShipmodelUI.getInstance().removeBackMC();
                  this.Hide(true);
                  return;
               }
               if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_XIDIAN)
               {
                  CommanderSceneUI.getInstance().removeBackMC();
                  this.Hide(true);
                  return;
               }
               if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_FIRECOMMANDER)
               {
                  CommanderSceneUI.getInstance().removeBackMC();
                  this.Hide(true);
                  return;
               }
               if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_NOSPEED)
               {
                  ShipmodelUI.getInstance().removeBackMC();
                  this.Hide(true);
                  return;
               }
               if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_INTOID)
               {
                  RankingSceneUI.getInstance().removeBackMC();
                  this.Hide(true);
                  return;
               }
               if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_NOFINDID)
               {
                  RankingSceneUI.getInstance().removeBackMC();
                  this.Hide(true);
                  return;
               }
               if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_CANNOTCARD)
               {
                  CommanderSceneUI.getInstance().removeBackMC();
                  this.Hide(true);
                  return;
               }
               if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_CHANGECARD)
               {
                  CommanderSceneUI.getInstance().removeBackMC();
                  this.Hide(true);
                  return;
               }
               if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_CONDITIONSCHANGECARD)
               {
                  CommanderSceneUI.getInstance().removeBackMC();
                  this.Hide(true);
                  return;
               }
               if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_BAGNOINTO)
               {
                  CommanderSceneUI.getInstance().removeBackMC();
                  this.Hide(true);
                  return;
               }
               if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_BATCHFIRE)
               {
                  CommanderSceneUI.getInstance().removeBackMC();
                  this.Hide(true);
                  return;
               }
               if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_NOJOIN)
               {
                  GymkhanaUI.getInstance().removeBackMC();
                  this.Hide(true);
                  return;
               }
               if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_COINJOIN)
               {
                  GymkhanaUI.getInstance().removeBackMC();
                  this.Hide(true);
                  return;
               }
               this.Hide();
         }
      }
   }
}

