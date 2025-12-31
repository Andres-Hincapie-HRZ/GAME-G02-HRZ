package logic.ui
{
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.managers.StringManager;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import logic.action.ConstructionAction;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.game.GameKernel;
   import logic.impl.IModulePopUp;
   import logic.manager.GameInterActiveManager;
   import logic.ui.info.BleakingLineForThai;
   import logic.utils.UpdateResource;
   import logic.widget.ConstructionOperationWidget;
   import logic.widget.OperationEnum;
   import net.router.CommanderRouter;
   
   public class MallBuyModulesPopup implements IModulePopUp
   {
      
      private static var instance:MallBuyModulesPopup;
      
      protected var _name:String;
      
      protected var _popWnd:MovieClip;
      
      protected var _content:TextField;
      
      protected var _okayBtn:HButton;
      
      protected var _cancelBtn:HButton;
      
      private var _parent:String;
      
      private var _propID:int;
      
      private var _ShowUserView:int;
      
      public function MallBuyModulesPopup()
      {
         super();
      }
      
      public static function getInstance() : MallBuyModulesPopup
      {
         if(instance == null)
         {
            instance = new MallBuyModulesPopup();
         }
         return instance;
      }
      
      public function Init() : void
      {
         this._ShowUserView = 0;
         if(this._popWnd)
         {
            this.setTFState();
            GameInterActiveManager.InstallInterActiveEvent(this._okayBtn.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
            GameInterActiveManager.InstallInterActiveEvent(this._cancelBtn.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
            return;
         }
         this._popWnd = GameKernel.getMovieClipInstance("MallgoodsPopup");
         this._popWnd.x = GameKernel.getInstance().stage.stageWidth - this._popWnd.width * 0.5 >> 1;
         this._popWnd.x += this._popWnd.width * 0.25;
         this._popWnd.y = 300;
         this._content = this._popWnd.tf_content as TextField;
         this._okayBtn = new HButton(this._popWnd.mc_build);
         this._cancelBtn = new HButton(this._popWnd.btn_cancel);
         this._propID = 900;
         this.setTFState();
         GameInterActiveManager.InstallInterActiveEvent(this._okayBtn.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
         GameInterActiveManager.InstallInterActiveEvent(this._cancelBtn.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
      }
      
      public function setToolPropID(param1:int) : void
      {
         if(this._propID == param1)
         {
            return;
         }
         this._propID = param1;
      }
      
      public function setMessage(param1:String) : void
      {
         this._content.text = "  " + param1;
      }
      
      public function setShowUserView(param1:int) : void
      {
         this._ShowUserView = param1;
      }
      
      public function setparent(param1:String) : void
      {
         this._parent = param1;
      }
      
      private function setTFState() : void
      {
         if(this._content == null)
         {
            return;
         }
         this._okayBtn.m_movie.visible = true;
         switch(ConstructionOperationWidget.currenCmd)
         {
            case OperationEnum.OPERATION_TYPE_UPGRADE:
               if(ConstructionAction.getInstance().CheckConstructionProgreeIsFull())
               {
                  if(GamePlayer.getInstance().constructionQueueOpenNum)
                  {
                     this._content.text = "  " + StringManager.getInstance().getMessageString("BuildingText19");
                     this._okayBtn.setBtnDisabled(true);
                     break;
                  }
                  this._content.text = "  " + StringManager.getInstance().getMessageString("BuildingText4");
                  this._okayBtn.setBtnDisabled(false);
               }
               break;
            case OperationEnum.OPERATION_TYPE_SPEED:
               this._okayBtn.m_movie.visible = true;
               this._content.text = "  " + StringManager.getInstance().getMessageString("BuildingText3");
               break;
            case OperationEnum.OPERATION_TYPE_SPEED_BY_COINS:
               this._content.text = "  " + StringManager.getInstance().getMessageString("BuildingText16");
               break;
            case OperationEnum.OPERATION_TYPE_XIDIAN:
               this._okayBtn.m_movie.visible = false;
               this._content.text = "  " + StringManager.getInstance().getMessageString("CommanderText71");
               break;
            case OperationEnum.OPERATION_TYPE_NOINTOCOMMANDER:
               this._okayBtn.m_movie.visible = false;
               this._content.text = "  " + StringManager.getInstance().getMessageString("CommanderText11");
               break;
            case OperationEnum.OPERATION_TYPE_BAGNOINTO:
               this._okayBtn.m_movie.visible = false;
               this._content.text = "  " + StringManager.getInstance().getMessageString("CommanderText12");
               break;
            case OperationEnum.OPERATION_TYPE_NOSPEED:
               this._okayBtn.m_movie.visible = false;
               this._content.text = "  " + StringManager.getInstance().getMessageString("ShipText24");
               break;
            case OperationEnum.OPERATION_TYPE_NOXIDIAN:
               this._okayBtn.m_movie.visible = false;
               this._content.text = "  " + StringManager.getInstance().getMessageString("CommanderText72");
               break;
            case OperationEnum.OPERATION_TYPE_CANNOTCARD:
               this._okayBtn.m_movie.visible = false;
               this._content.text = "  " + StringManager.getInstance().getMessageString("CommanderText97");
               break;
            case OperationEnum.OPERATION_TYPE_CONDITIONSCHANGECARD:
               this._okayBtn.m_movie.visible = false;
               this._content.text = "  " + StringManager.getInstance().getMessageString("CommanderText98");
               break;
            case OperationEnum.OPERATION_TYPE_NOCASH:
               this._okayBtn.m_movie.visible = false;
               this._content.text = "  " + StringManager.getInstance().getMessageString("ShipText20");
               break;
            case OperationEnum.OPERATION_TYPE_ERRORCANCEL:
               this._okayBtn.m_movie.visible = false;
               this._content.text = "  " + StringManager.getInstance().getMessageString("ShipText22");
               break;
            case OperationEnum.OPERATION_TYPE_SHIPTEAM:
               this._okayBtn.m_movie.visible = false;
               this._content.text = "  " + StringManager.getInstance().getMessageString("CommanderText76");
               break;
            case OperationEnum.OPERATION_TYPE_NOBUY:
               this._okayBtn.m_movie.visible = false;
               this._content.text = "  " + StringManager.getInstance().getMessageString("ItemText14");
               break;
            case OperationEnum.OPERATION_TYPE_BAGALL:
               this._okayBtn.m_movie.visible = false;
               this._content.text = "  " + StringManager.getInstance().getMessageString("BagTXT16");
               break;
            case OperationEnum.OPERATION_TYPE_NORESEARCHCENTERS:
               this._okayBtn.m_movie.visible = false;
               this._content.text = "  " + StringManager.getInstance().getMessageString("ShipText28");
               break;
            case OperationEnum.OPERATION_TYPE_CARDNOINTO:
               this._okayBtn.m_movie.visible = false;
               this._content.text = "  " + StringManager.getInstance().getMessageString("CommanderText111");
               break;
            case OperationEnum.OPERATION_TYPE_NOJOIN:
               this._okayBtn.m_movie.visible = false;
               this._content.text = "  " + StringManager.getInstance().getMessageString("Boss177");
               break;
            case OperationEnum.OPERATION_TYPE_COINJOIN:
               this._okayBtn.m_movie.visible = false;
               this._content.text = "  " + StringManager.getInstance().getMessageString("Boss185");
         }
         BleakingLineForThai.GetInstance().BleakThaiLanguage(this._content,65535);
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
      
      private function onHandler(param1:MouseEvent) : void
      {
         var _loc2_:Boolean = false;
         this._okayBtn.setBtnDisabled(false);
         switch(param1.target.name)
         {
            case "mc_build":
               StateHandlingUI.getInstance().Init();
               StateHandlingUI.getInstance().setParent("_ResPlaneUI");
               StateHandlingUI.getInstance().getstate(this._propID);
               StateHandlingUI.getInstance().InitPopUp();
               GameKernel.popUpDisplayManager.Show(StateHandlingUI.getInstance());
               PropsBuyUI.getInstance().ShowCreateCorpsUI = this._ShowUserView;
               this.Hide(true);
               break;
            case "btn_cancel":
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
               if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_BAGNOINTO)
               {
                  if(this._parent == "FleetEditUI")
                  {
                     this._parent = "";
                     FleetEditUI.getInstance().removeBackMC();
                  }
                  else if(this._parent == "packUi")
                  {
                     this._parent = "";
                     PackUi.getInstance().Hider();
                  }
                  else if(this._parent == "commandercard")
                  {
                     this._parent = "";
                     CommandercardSceneUI.getinstance().removeBackMC();
                  }
                  else
                  {
                     CommanderSceneUI.getInstance().removeBackMC();
                  }
                  this.Hide(true);
                  return;
               }
               if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_BAGALL)
               {
                  this.Hide(true);
                  return;
               }
               if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_NOINTOCOMMANDER)
               {
                  if(this._parent == "FleetEditUI")
                  {
                     this._parent = "";
                     FleetEditUI.getInstance().removeBackMC();
                  }
                  else
                  {
                     CommanderSceneUI.getInstance().removeBackMC();
                  }
                  this.Hide(true);
                  return;
               }
               if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_NOSPEED)
               {
                  ShipmodelUI.getInstance().removeBackMC();
                  this.Hide(true);
                  return;
               }
               if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_NOXIDIAN)
               {
                  CommanderSceneUI.getInstance().removeBackMC();
                  this.Hide(true);
                  return;
               }
               if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_CANNOTCARD)
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
               if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_NOCASH)
               {
                  ShipmodelUI.getInstance().removeBackMC();
                  this.Hide(true);
                  return;
               }
               if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_ERRORCANCEL)
               {
                  ShipmodelUI.getInstance().removeBackMC();
                  this.Hide(true);
                  return;
               }
               if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_SHIPTEAM)
               {
                  this.Hide(true);
                  return;
               }
               if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_NOBUY)
               {
                  this.Hide(true);
                  return;
               }
               if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_NORESEARCHCENTERS)
               {
                  ShipmodelUI.getInstance().removeBackMC();
                  this.Hide(true);
                  return;
               }
               if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_CARDNOINTO)
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

