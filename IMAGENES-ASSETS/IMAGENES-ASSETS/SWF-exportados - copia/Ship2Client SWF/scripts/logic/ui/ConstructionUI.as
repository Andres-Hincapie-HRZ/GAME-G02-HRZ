package logic.ui
{
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.ObjectUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import logic.action.ActionModuleDefined;
   import logic.action.ConstructionAction;
   import logic.action.OutSideGalaxiasAction;
   import logic.action.StarSurfaceAction;
   import logic.entry.ConstructionDataCache;
   import logic.entry.Equiment;
   import logic.entry.GameStageEnum;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.entry.blurprint.EquimentBlueprint;
   import logic.game.GameKernel;
   import logic.game.GameSetting;
   import logic.manager.GameInterActiveManager;
   import logic.manager.GameModuleActionManager;
   import logic.reader.CConstructionReader;
   import logic.widget.ConstructionUtil;
   
   public class ConstructionUI extends AbstractPopUp
   {
      
      private static var instance:ConstructionUI;
      
      private var _cancel:HButton;
      
      private var _mall_mc_record:HButton;
      
      private var _mall_mc_expendable:HButton;
      
      private var _mall_mc_harvest:HButton;
      
      private var _mall_mc_stuff:HButton;
      
      private var _mall_mc_defense:HButton;
      
      private var _mc_cash:HButton;
      
      private var _left:HButton;
      
      private var _right:HButton;
      
      private var _page:TextField;
      
      private var _tipTF:TextField;
      
      private var _currentCell:ConstructionCellUI;
      
      private var _currentIndex:int;
      
      private var _preIndex:int;
      
      private var _cellItemList:Array;
      
      private var _currentEquiment:Equiment;
      
      private var _curPage:int;
      
      private var _btnList:Array;
      
      private var conReader:CConstructionReader;
      
      private var constructionAction:ConstructionAction;
      
      private var starSufaceModule:StarSurfaceAction;
      
      private var outSideGalaxiaAction:OutSideGalaxiasAction;
      
      public function ConstructionUI()
      {
         super();
         setPopUpName("ConstructionUI");
         this._currentIndex = -1;
         this._preIndex = -1;
         this._curPage = 0;
         this._btnList = new Array();
         this.conReader = CConstructionReader.getInstance();
         this.starSufaceModule = GameModuleActionManager.getModuleInstance(ActionModuleDefined.StarSurface_action) as StarSurfaceAction;
         this.outSideGalaxiaAction = GameModuleActionManager.getModuleInstance(ActionModuleDefined.OutSideGalaxias_Action) as OutSideGalaxiasAction;
         this.constructionAction = GameModuleActionManager.getModuleInstance(ActionModuleDefined.Construction_action) as ConstructionAction;
      }
      
      public static function getInstance() : ConstructionUI
      {
         if(instance == null)
         {
            instance = new ConstructionUI();
         }
         return instance;
      }
      
      public function get TabIndex() : int
      {
         return this._currentIndex;
      }
      
      public function set TabIndex(param1:int) : void
      {
         this._currentIndex = param1;
      }
      
      public function get CurrentConstructionCell() : ConstructionCellUI
      {
         return this._currentCell;
      }
      
      public function set CurrentConstructionCell(param1:ConstructionCellUI) : void
      {
         this._currentCell = param1;
      }
      
      override public function Init() : void
      {
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            this.setConstructionTabSwitch();
            this.showTip();
            return;
         }
         this._mc = new MObject("BuildScene",400,300);
         this.initMcElement();
         this.loadCellItem();
         GameKernel.popUpDisplayManager.Regisger(instance);
      }
      
      override public function initMcElement() : void
      {
         var _loc1_:MovieClip = this._mc.getMC();
         this._cancel = new HButton(_loc1_.btn_cancel);
         this._mall_mc_record = new HButton(_loc1_.btn_record);
         this._mall_mc_expendable = new HButton(_loc1_.btn_expendable);
         this._mall_mc_harvest = new HButton(_loc1_.btn_harvest);
         this._mall_mc_stuff = new HButton(_loc1_.btn_stuff);
         this._mall_mc_defense = new HButton(_loc1_.btn_defense);
         this._left = new HButton(_loc1_.btn_up);
         this._right = new HButton(_loc1_.btn_down);
         this._tipTF = _loc1_.tf_txt as TextField;
         this._tipTF.text = "";
         this._tipTF.textColor = 65280;
         this._btnList.push(this._mall_mc_record);
         this._btnList.push(this._mall_mc_expendable);
         this._btnList.push(this._mall_mc_harvest);
         this._btnList.push(this._mall_mc_stuff);
         this._btnList.push(this._mall_mc_defense);
         this._page = _loc1_.tf_page as TextField;
         GameInterActiveManager.InstallInterActiveEvent(this._mall_mc_stuff.m_movie,ActionEvent.ACTION_CLICK,this.onNagivateHandler);
         GameInterActiveManager.InstallInterActiveEvent(this._mall_mc_harvest.m_movie,ActionEvent.ACTION_CLICK,this.onNagivateHandler);
         GameInterActiveManager.InstallInterActiveEvent(this._mall_mc_expendable.m_movie,ActionEvent.ACTION_CLICK,this.onNagivateHandler);
         GameInterActiveManager.InstallInterActiveEvent(this._mall_mc_record.m_movie,ActionEvent.ACTION_CLICK,this.onNagivateHandler);
         GameInterActiveManager.InstallInterActiveEvent(this._mall_mc_defense.m_movie,ActionEvent.ACTION_CLICK,this.onNagivateHandler);
         GameInterActiveManager.InstallInterActiveEvent(this._cancel.m_movie,ActionEvent.ACTION_CLICK,this.onCloseWnd);
         GameInterActiveManager.InstallInterActiveEvent(this._left.m_movie,ActionEvent.ACTION_CLICK,this.onLeftHandler);
         GameInterActiveManager.InstallInterActiveEvent(this._right.m_movie,ActionEvent.ACTION_CLICK,this.onRightHandler);
      }
      
      private function showTip() : void
      {
         this._tipTF.text = "";
         if(GameKernel.currentGameStage == GameStageEnum.GAME_STAGE_STARSURFACE && this._currentIndex == GameSetting.CONSTRUCTION_TYPE_DEFENSE)
         {
            this._tipTF.text = StringManager.getInstance().getMessageString("BuildingText18");
         }
         if(GameKernel.currentGameStage == GameStageEnum.GAME_STAGE_OUTSIDE && this._currentIndex != GameSetting.CONSTRUCTION_TYPE_DEFENSE)
         {
            this._tipTF.text = StringManager.getInstance().getMessageString("BuildingText17");
         }
      }
      
      private function setCurrentIndex() : void
      {
         if(GameKernel.currentGameStage == GameStageEnum.GAME_STAGE_OUTSIDE)
         {
            if(this._currentIndex == -1)
            {
               this._currentIndex = GameSetting.CONSTRUCTION_TYPE_DEFENSE;
               this._preIndex = GameSetting.CONSTRUCTION_TYPE_DEFENSE;
               this.setNagivateSelectState(this._mall_mc_defense);
            }
         }
         else if(this._currentIndex == -1)
         {
            this._currentIndex = GameSetting.CONSTRUCTION_TYPE_CIVICISM;
            this._preIndex = GameSetting.CONSTRUCTION_TYPE_CIVICISM;
            this.setNagivateSelectState(this._mall_mc_harvest);
         }
      }
      
      private function loadCellItem() : void
      {
         var _loc3_:EquimentBlueprint = null;
         var _loc5_:ConstructionCellUI = null;
         var _loc6_:MovieClip = null;
         this.setCurrentIndex();
         this._cellItemList = new Array();
         var _loc1_:Array = ConstructionDataCache.getInstance().CachePool[this._currentIndex].sort(Array.NUMERIC);
         _loc1_ = ConstructionUtil.filterConstructions(_loc1_);
         var _loc2_:int = Math.min(_loc1_.length,(this._curPage + 1) * GameSetting.CONSTRUCTION_CELL_NUMBER);
         var _loc4_:int = this._curPage * GameSetting.CONSTRUCTION_CELL_NUMBER;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = this.conReader.Read(_loc1_[_loc4_],0);
            _loc5_ = new ConstructionCellUI(_loc4_,_loc1_[_loc4_],this._currentIndex);
            _loc5_.setConstructionImage(_loc3_.IconName);
            _loc5_.setConstructionName(_loc3_.BuildingName);
            _loc5_.setConstructionNum(this.constructionAction.getConstructionCurrentNum(_loc5_.BuildID),this.constructionAction.getConstructionMaxNum(_loc5_.BuildID));
            _loc5_.setCreateBtnState();
            this._cellItemList.push(_loc5_);
            _loc6_ = this._mc.getMC().getChildByName("mc_list" + (_loc4_ - this._curPage * GameSetting.CONSTRUCTION_CELL_NUMBER)) as MovieClip;
            _loc6_.addChild(_loc5_);
            _loc4_++;
         }
         this.setPage(_loc1_.length);
         this.setLRBtnState();
      }
      
      public function setPage(param1:int) : void
      {
         var _loc2_:int = 0;
         if(param1 % GameSetting.CONSTRUCTION_CELL_NUMBER == 0)
         {
            _loc2_ = Math.floor(param1 / GameSetting.CONSTRUCTION_CELL_NUMBER);
         }
         else
         {
            _loc2_ = Math.floor(param1 / GameSetting.CONSTRUCTION_CELL_NUMBER) + 1;
         }
         this._page.text = String(this._curPage + 1) + "/" + _loc2_.toString();
      }
      
      private function setLRBtnState() : void
      {
         var _loc1_:Array = ConstructionDataCache.getInstance().CachePool[this._currentIndex].sort(Array.NUMERIC);
         this._left.setBtnDisabled(this._curPage == 0);
         this._right.setBtnDisabled((this._curPage + 1) * GameSetting.CONSTRUCTION_CELL_NUMBER >= _loc1_.length);
      }
      
      private function removeCellItem() : void
      {
         var _loc1_:ConstructionCellUI = null;
         for each(_loc1_ in this._cellItemList)
         {
            if(_loc1_.parent)
            {
               _loc1_.parent.removeChild(_loc1_);
               _loc1_.Clear();
               _loc1_ = null;
            }
         }
         ObjectUtil.ClearArray(this._cellItemList);
         this._cellItemList = null;
      }
      
      public function onCloseWnd(param1:MouseEvent) : void
      {
         GameKernel.popUpDisplayManager.Hide(instance);
      }
      
      private function onLeftHandler(param1:MouseEvent) : void
      {
         this._curPage = Math.max(0,--this._curPage);
         this.setConstructionTabSwitch();
      }
      
      private function onRightHandler(param1:MouseEvent) : void
      {
         ++this._curPage;
         this.setConstructionTabSwitch();
      }
      
      public function setConstructionTabSwitch() : void
      {
         if(!GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            return;
         }
         this.removeCellItem();
         this.loadCellItem();
      }
      
      private function setNagivateSelectState(param1:HButton) : void
      {
         var _loc2_:HButton = null;
         if(this._btnList.length == 0)
         {
            return;
         }
         for each(_loc2_ in this._btnList)
         {
            if(param1 == _loc2_)
            {
               param1.setSelect(true);
            }
            else
            {
               _loc2_.setSelect(false);
            }
         }
      }
      
      private function onNagivateHandler(param1:MouseEvent) : void
      {
         this._curPage = 0;
         this._preIndex = this._currentIndex;
         switch(param1.currentTarget.name)
         {
            case "btn_stuff":
               this._currentIndex = GameSetting.CONSTRUCTION_TYPE_RES;
               this.setNagivateSelectState(this._mall_mc_stuff);
               this.setConstructionTabSwitch();
               break;
            case "btn_harvest":
               this._currentIndex = GameSetting.CONSTRUCTION_TYPE_CIVICISM;
               this.setNagivateSelectState(this._mall_mc_harvest);
               this.setConstructionTabSwitch();
               break;
            case "btn_expendable":
               this._currentIndex = GameSetting.CONSTRUCTION_TYPE_DIY;
               this.setNagivateSelectState(this._mall_mc_expendable);
               this.setConstructionTabSwitch();
               break;
            case "btn_record":
               this._currentIndex = GameSetting.CONSTRUCTION_TYPE_MILITARY;
               this.setNagivateSelectState(this._mall_mc_record);
               this.setConstructionTabSwitch();
               break;
            case "btn_defense":
               this._currentIndex = GameSetting.CONSTRUCTION_TYPE_DEFENSE;
               this.setNagivateSelectState(this._mall_mc_defense);
               this.setConstructionTabSwitch();
         }
         this.showTip();
      }
   }
}

