package logic.ui
{
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.StringUitl;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import logic.action.ConstructionAction;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.game.GameKernel;
   import logic.game.GameSetting;
   import logic.manager.GameInterActiveManager;
   import logic.manager.GamePopUpDisplayManager;
   import logic.reader.ConstructionSpeedReader;
   import logic.widget.ConstructionOperationWidget;
   import logic.widget.OperationEnum;
   import logic.widget.ProgressEntryIso;
   
   public class ConstructionSpeedPopUp extends AbstractPopUp
   {
      
      private static var instance:ConstructionSpeedPopUp;
      
      private var radiocashBtn:HButton;
      
      private var radiogoldBtn:HButton;
      
      private var _okayBtn:HButton;
      
      private var _cancelBtn:HButton;
      
      private var _remianTime:String;
      
      private var _tfTimeTxt:TextField;
      
      private var _tfSpeedTimeTxt:TextField;
      
      private var _tfAllcashTxt:TextField;
      
      private var _tfAllgoldTxt:TextField;
      
      private var _speedItemList:Array;
      
      private var _speedTimeList:Array;
      
      private var _speedCachList:Array;
      
      private var _selectItemIndex:int;
      
      private var _selectIndex:int;
      
      public var _selectType:int;
      
      private var _iconList:Array;
      
      private var _entryIso:ProgressEntryIso;
      
      public function ConstructionSpeedPopUp()
      {
         super();
         setPopUpName("ConstructionSpeedPopUp");
      }
      
      public static function getInstance() : ConstructionSpeedPopUp
      {
         if(instance == null)
         {
            instance = new ConstructionSpeedPopUp();
         }
         return instance;
      }
      
      override public function Init() : void
      {
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            this.setOperationHistory();
            return;
         }
         this._mc = new MObject("BuildspeedMc",GameSetting.GAME_STAGE_WIDTH >> 1,(GameSetting.GAME_STAGE_HEIGHT >> 1) - 100);
         this.initMcElement();
         this._selectItemIndex = -1;
         GameKernel.popUpDisplayManager.Regisger(instance);
      }
      
      override public function initMcElement() : void
      {
         var _loc3_:HButton = null;
         var _loc4_:TextField = null;
         var _loc5_:TextField = null;
         var _loc6_:MovieClip = null;
         this._speedItemList = new Array();
         this._speedTimeList = new Array();
         this._speedCachList = new Array();
         this._iconList = new Array();
         var _loc1_:MovieClip = this._mc.getMC();
         this._okayBtn = new HButton(_loc1_.btn_ensure);
         this._cancelBtn = new HButton(_loc1_.btn_cancel);
         this._tfSpeedTimeTxt = _loc1_.tf_remaintime as TextField;
         this._tfTimeTxt = _loc1_.tf_remaintime as TextField;
         this._tfAllcashTxt = _loc1_.tf_allcash as TextField;
         this._tfAllgoldTxt = _loc1_.tf_allgold as TextField;
         this.radiocashBtn = new HButton(_loc1_.radiocash);
         this.radiogoldBtn = new HButton(_loc1_.radiogold);
         this.radiogoldBtn.setSelect(true);
         this._selectType = 1;
         var _loc2_:int = 0;
         while(_loc2_ < 5)
         {
            _loc3_ = new HButton(MovieClip(_loc1_.getChildByName("radio" + _loc2_)));
            this._speedItemList.push(_loc3_);
            _loc4_ = _loc1_.getChildByName("tf_speedtime" + _loc2_) as TextField;
            this._speedTimeList.push(_loc4_);
            _loc5_ = _loc1_.getChildByName("tf_cash" + _loc2_) as TextField;
            this._speedCachList.push(_loc5_);
            _loc6_ = _loc1_.getChildByName("mc_cash" + _loc2_) as MovieClip;
            this._iconList.push(_loc6_);
            GameInterActiveManager.InstallInterActiveEvent(_loc3_.m_movie,ActionEvent.ACTION_CLICK,this.onSpeedHandler);
            _loc2_++;
         }
         this.selectPayForIcon(this._selectType);
         GameInterActiveManager.InstallInterActiveEvent(this._okayBtn.m_movie,ActionEvent.ACTION_CLICK,this.onOkayHandler);
         GameInterActiveManager.InstallInterActiveEvent(this._cancelBtn.m_movie,ActionEvent.ACTION_CLICK,this.onOkayHandler);
         GameInterActiveManager.InstallInterActiveEvent(this.radiocashBtn.m_movie,ActionEvent.ACTION_CLICK,this.onSelectPayforType);
         GameInterActiveManager.InstallInterActiveEvent(this.radiogoldBtn.m_movie,ActionEvent.ACTION_CLICK,this.onSelectPayforType);
      }
      
      public function selectPayForIcon(param1:int = 0) : void
      {
         var _loc2_:MovieClip = null;
         if(this._iconList.length == 0)
         {
            return;
         }
         for each(_loc2_ in this._iconList)
         {
            _loc2_.gotoAndStop(param1 + 1);
         }
      }
      
      private function setOperationHistory() : void
      {
         this._okayBtn.setBtnDisabled(false);
         if(this._selectType == 0)
         {
            this.radiocashBtn.setSelect(true);
            this.radiogoldBtn.setSelect(false);
         }
         else if(this._selectType == 1)
         {
            this.radiogoldBtn.setSelect(true);
            this.radiocashBtn.setSelect(false);
         }
         this.selectPayForIcon(this._selectType);
         if(this._speedItemList == null || this._speedItemList.length == 0)
         {
            return;
         }
         this.Sort(this._selectItemIndex);
         this.validateCondition(parseInt(TextField(this._speedCachList[this._selectIndex]).text));
      }
      
      public function setProgressEntryIso(param1:ProgressEntryIso, param2:int = 0) : void
      {
         this._entryIso = param1;
         ConstructionAction.curProgressIso = param1;
         this.setCredit(param2,this._entryIso.Construction.EquimentInfoData.needTime);
         this.validateCondition(parseInt(TextField(this._speedCachList[this._selectIndex]).text));
      }
      
      public function getProgressEntryIso() : ProgressEntryIso
      {
         return this._entryIso;
      }
      
      public function setConstructionCostTime(param1:String) : void
      {
         this._tfTimeTxt.text = param1;
      }
      
      public function setCredit(param1:int, param2:int) : void
      {
         var _loc5_:HButton = null;
         var _loc6_:Object = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         if(this._speedItemList.length == 0)
         {
            return;
         }
         var _loc3_:int = 0;
         var _loc4_:int = 4;
         for each(_loc5_ in this._speedItemList)
         {
            _loc6_ = ConstructionSpeedReader.getInstance().Read(_loc4_ % this._speedItemList.length,param1);
            _loc4_++;
            TextField(this._speedTimeList[_loc3_]).text = _loc6_.Name;
            TextField(this._speedCachList[_loc3_]).text = _loc6_.Credit;
            if(_loc6_.Time == 0 && _loc6_.Variable != undefined)
            {
               if(this._selectItemIndex == -1)
               {
                  _loc5_.setSelect(true);
                  this._selectItemIndex = 4;
               }
               TextField(this._speedTimeList[_loc3_]).text = StringManager.getInstance().getMessageString("BuildingText15");
               _loc7_ = param2;
               if(_loc7_ % _loc6_.Variable == 0)
               {
                  _loc8_ = _loc7_ / _loc6_.Variable;
               }
               else
               {
                  _loc8_ = _loc7_ / _loc6_.Variable + 1;
               }
               TextField(this._speedCachList[_loc3_]).text = String(int(_loc6_.Credit) + _loc8_);
            }
            _loc3_++;
         }
         this.validateCondition(parseInt(TextField(this._speedCachList[this._selectIndex]).text));
         this._tfAllcashTxt.text = StringUitl.toUSFormat(GamePlayer.getInstance().cash);
         this._tfAllgoldTxt.text = StringUitl.toUSFormat(GamePlayer.getInstance().coins);
      }
      
      private function validateCondition(param1:int) : void
      {
         switch(this._selectType)
         {
            case 0:
               if(GamePlayer.getInstance().cash >= param1)
               {
                  this._okayBtn.setBtnDisabled(false);
                  break;
               }
               this._okayBtn.setBtnDisabled(true);
               break;
            case 1:
               if(GamePlayer.getInstance().coins >= param1)
               {
                  this._okayBtn.setBtnDisabled(false);
                  break;
               }
               this._okayBtn.setBtnDisabled(true);
         }
      }
      
      private function onSpeedHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = parseInt(param1.target.name.replace("radio",""));
         this._selectIndex = _loc2_;
         this._selectItemIndex = (_loc2_ - 1 + this._speedItemList.length) % this._speedItemList.length;
         this.Sort(this._selectItemIndex);
         this.validateCondition(parseInt(TextField(this._speedCachList[this._selectIndex]).text));
      }
      
      private function Sort(param1:int) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._speedItemList.length)
         {
            if((param1 + 1) % this._speedItemList.length == _loc2_)
            {
               HButton(this._speedItemList[_loc2_]).setSelect(true);
            }
            else
            {
               HButton(this._speedItemList[_loc2_]).setSelect(false);
            }
            _loc2_++;
         }
      }
      
      private function onSelectPayforType(param1:MouseEvent) : void
      {
         switch(param1.target.name)
         {
            case "radiocash":
               this.radiocashBtn.setSelect(true);
               this.radiogoldBtn.setSelect(false);
               this._selectType = 0;
               break;
            case "radiogold":
               this.radiogoldBtn.setSelect(true);
               this.radiocashBtn.setSelect(false);
               this._selectType = 1;
         }
         this.selectPayForIcon(this._selectType);
         this.validateCondition(parseInt(TextField(this._speedCachList[this._selectIndex]).text));
      }
      
      private function onOkayHandler(param1:MouseEvent) : void
      {
         var _loc2_:Object = null;
         switch(param1.target.name)
         {
            case "btn_ensure":
               this._okayBtn.setBtnDisabled(true);
               if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_BODY_SPEED_UPGRADE)
               {
                  this.SpeedupShipUpgrade();
                  return;
               }
               if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_SPEED)
               {
                  if(this._selectItemIndex == -1)
                  {
                     return;
                  }
                  _loc2_ = ConstructionSpeedReader.getInstance().Read(this._selectItemIndex,ConstructionSpeedReader.SPEED_TYPE_BUILD);
                  switch(this._selectType)
                  {
                     case 0:
                        if(GamePlayer.getInstance().cash < _loc2_.Credit)
                        {
                           ConstructionOperationWidget.currenCmd = OperationEnum.OPERATION_TYPE_SPEED;
                           UpgradeModulesPopUp.getInstance().Init();
                           UpgradeModulesPopUp.getInstance().Show();
                           GamePopUpDisplayManager.getInstance().Hide(instance);
                           return;
                        }
                        break;
                     case 1:
                        if(GamePlayer.getInstance().coins == 0 || GamePlayer.getInstance().coins < _loc2_.Credit)
                        {
                           ConstructionOperationWidget.currenCmd = OperationEnum.OPERATION_TYPE_SPEED_BY_COINS;
                           UpgradeModulesPopUp.getInstance().Init();
                           UpgradeModulesPopUp.getInstance().Show();
                           GamePopUpDisplayManager.getInstance().Hide(instance);
                           return;
                        }
                  }
                  this.selectPayForIcon(this._selectType);
                  ConstructionAction.getInstance().sendConstructionSpeedRequest(this._entryIso.Construction.EquimentInfoData.IndexId,this._selectItemIndex,this._selectType);
                  ConstructionOperationWidget.getInstance().Hide();
               }
               break;
            case "btn_cancel":
               if(ConstructionOperationWidget.currenCmd == OperationEnum.OPERATION_TYPE_BODY_SPEED_UPGRADE)
               {
                  GamePopUpDisplayManager.getInstance().Hide(instance);
                  UpgradeUI.getInstance().HideLock();
                  return;
               }
               ConstructionOperationWidget.getInstance().Hide();
         }
         GamePopUpDisplayManager.getInstance().Hide(instance);
      }
      
      private function SpeedupShipUpgrade() : void
      {
         if(this._selectItemIndex == -1)
         {
            return;
         }
         var _loc1_:Object = ConstructionSpeedReader.getInstance().Read(this._selectItemIndex,ConstructionSpeedReader.SPEED_TYPE_SHIP);
         if(_loc1_ == null)
         {
            return;
         }
         if(this._selectType == 0)
         {
            if(GamePlayer.getInstance().cash < _loc1_.Credit)
            {
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("BuildingText3"),0);
               return;
            }
         }
         else if(GamePlayer.getInstance().coins < _loc1_.Credit)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("BuildingText16"),0);
            return;
         }
         UpgradeUI.getInstance().UpgradeSpeed(this._selectType,this._selectItemIndex);
         GamePopUpDisplayManager.getInstance().Hide(instance);
         UpgradeUI.getInstance().HideLock();
      }
   }
}

