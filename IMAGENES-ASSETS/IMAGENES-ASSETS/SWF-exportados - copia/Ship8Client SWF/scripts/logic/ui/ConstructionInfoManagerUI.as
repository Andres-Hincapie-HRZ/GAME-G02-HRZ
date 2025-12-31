package logic.ui
{
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.utils.ObjectUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import logic.action.ConstructionAction;
   import logic.entry.Equiment;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.game.GameKernel;
   import logic.game.GameSetting;
   import logic.manager.GameInterActiveManager;
   import logic.widget.OperationWidget;
   
   public class ConstructionInfoManagerUI extends AbstractPopUp
   {
      
      private static var instance:ConstructionInfoManagerUI;
      
      private var resBuildBtn:HButton;
      
      private var cityBuildBtn:HButton;
      
      private var beautifybuildBtn:HButton;
      
      private var armbuildBtn:HButton;
      
      private var defensebuildBtn:HButton;
      
      private var upBtn:HButton;
      
      private var downBtn:HButton;
      
      private var cancelBtn:HButton;
      
      private var _tabIndex:int;
      
      private var _preTabIndex:int;
      
      private var _cellItemList:Array;
      
      private var _pageId:int;
      
      private var _curBid:int;
      
      private var _preBid:int;
      
      public function ConstructionInfoManagerUI()
      {
         super();
         this._preBid = -1;
         this._curBid = 0;
         setPopUpName("ConstructionInfoManagerUI");
      }
      
      public static function getInstance() : ConstructionInfoManagerUI
      {
         if(instance == null)
         {
            instance = new ConstructionInfoManagerUI();
         }
         return instance;
      }
      
      override public function Init() : void
      {
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            GameKernel.popUpDisplayManager.Show(instance);
            return;
         }
         this._mc = new MObject("BuildinfoScene",400,250);
         this._tabIndex = 0;
         this.initMcElement();
         this.loadOwnConstructionList();
         GameKernel.popUpDisplayManager.Regisger(instance);
         OperationWidget.getInstance().Hide();
      }
      
      override public function initMcElement() : void
      {
         var _loc1_:MovieClip = this._mc.getMC();
         this.resBuildBtn = new HButton(_loc1_.btn_resbuild);
         this.cityBuildBtn = new HButton(_loc1_.btn_citybuild);
         this.beautifybuildBtn = new HButton(_loc1_.btn_beautifybuild);
         this.armbuildBtn = new HButton(_loc1_.btn_armbuild);
         this.defensebuildBtn = new HButton(_loc1_.btn_defensebuild);
         this.cancelBtn = new HButton(_loc1_.btn_cancel);
         this.upBtn = new HButton(_loc1_.btn_up);
         this.downBtn = new HButton(_loc1_.btn_down);
         GameInterActiveManager.InstallInterActiveEvent(this.resBuildBtn.m_movie,ActionEvent.ACTION_CLICK,this.onNagivateHandler);
         GameInterActiveManager.InstallInterActiveEvent(this.cityBuildBtn.m_movie,ActionEvent.ACTION_CLICK,this.onNagivateHandler);
         GameInterActiveManager.InstallInterActiveEvent(this.beautifybuildBtn.m_movie,ActionEvent.ACTION_CLICK,this.onNagivateHandler);
         GameInterActiveManager.InstallInterActiveEvent(this.armbuildBtn.m_movie,ActionEvent.ACTION_CLICK,this.onNagivateHandler);
         GameInterActiveManager.InstallInterActiveEvent(this.defensebuildBtn.m_movie,ActionEvent.ACTION_CLICK,this.onNagivateHandler);
         GameInterActiveManager.InstallInterActiveEvent(this.cancelBtn.m_movie,ActionEvent.ACTION_CLICK,this.onNagivateHandler);
         GameInterActiveManager.InstallInterActiveEvent(this.upBtn.m_movie,ActionEvent.ACTION_CLICK,this.onPageHandler);
         GameInterActiveManager.InstallInterActiveEvent(this.downBtn.m_movie,ActionEvent.ACTION_CLICK,this.onPageHandler);
         ConstructionDetailManagerUI.getInstance().Init(this._mc.getMC());
      }
      
      private function loadOwnConstructionList() : void
      {
         this.bindConstruction(this.sortConstructionTypeList());
      }
      
      public function showConstructionDetailList(param1:int) : void
      {
         var _loc2_:Array = null;
         var _loc4_:Equiment = null;
         this._curBid = param1;
         if(this._curBid == this._preBid)
         {
            return;
         }
         this._preBid = this._curBid;
         if(this._tabIndex == GameSetting.CONSTRUCTION_TYPE_DEFENSE)
         {
            _loc2_ = ConstructionAction.outSideContuctionList.Values();
         }
         else
         {
            _loc2_ = ConstructionAction.constuctionList.Values();
         }
         var _loc3_:Array = new Array();
         for each(_loc4_ in _loc2_)
         {
            if(_loc4_.EquimentInfoData.BuildID == param1)
            {
               _loc3_.push(_loc4_.EquimentInfoData);
            }
         }
         this.removeOwnConstuctionItem();
         this.bindConstruction(_loc3_);
      }
      
      private function bindConstruction(param1:Array) : void
      {
         var _loc4_:ConstructionInfoCellUI = null;
         var _loc5_:MovieClip = null;
         this._cellItemList = new Array();
         var _loc2_:int = Math.min(param1.length,(this._pageId + 1) * GameSetting.CONSTRUCTION_OWER_CELL_NUMBER);
         var _loc3_:int = this._pageId * GameSetting.CONSTRUCTION_OWER_CELL_NUMBER;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new ConstructionInfoCellUI(_loc3_,param1[_loc3_]);
            _loc4_.setConstructionName();
            _loc4_.setConstuctionLv();
            _loc4_.setCellItemCostTime();
            _loc4_.setFunctionBtnState();
            this._cellItemList.push(_loc4_);
            _loc5_ = this._mc.getMC().getChildByName("mc_list" + (_loc3_ - this._pageId * GameSetting.CONSTRUCTION_OWER_CELL_NUMBER)) as MovieClip;
            _loc5_.addChild(_loc4_);
            _loc3_++;
         }
         this.setLRBtnState();
      }
      
      public function syncConstruction(param1:int) : void
      {
         var _loc2_:ConstructionInfoCellUI = null;
         if(this._cellItemList == null || this._cellItemList.length == 0)
         {
            return;
         }
         for each(_loc2_ in this._cellItemList)
         {
            if(_loc2_.ConstructionData.IndexId == param1)
            {
               _loc2_.setUnUpgrade();
            }
         }
      }
      
      public function clearConstructionList(param1:int) : void
      {
         var _loc3_:ConstructionInfoCellUI = null;
         if(this._cellItemList == null || this._cellItemList.length == 0)
         {
            return;
         }
         var _loc2_:int = 0;
         for each(_loc3_ in this._cellItemList)
         {
            if(_loc3_.ConstructionData.IndexId == param1)
            {
               _loc3_.Clear();
               this._cellItemList.splice(_loc2_,1);
               _loc3_ = null;
               this.setConstructionTabSwitch();
               return;
            }
            _loc2_++;
         }
      }
      
      public function syncCellItem() : void
      {
         var _loc1_:ConstructionInfoCellUI = null;
         if(this._cellItemList == null || this._cellItemList.length == 0)
         {
            return;
         }
         for each(_loc1_ in this._cellItemList)
         {
            _loc1_.setCellItemCostTime();
         }
      }
      
      private function setLRBtnState() : void
      {
         var _loc1_:Array = this.sortConstructionTypeList();
         if(this._pageId == 0)
         {
            this.upBtn.setBtnDisabled(true);
         }
         if(_loc1_.length == 0)
         {
            this.downBtn.setBtnDisabled(true);
            this.upBtn.setBtnDisabled(true);
            return;
         }
         if(this._pageId == 0)
         {
            this.upBtn.setBtnDisabled(true);
         }
         else
         {
            this.upBtn.setBtnDisabled(false);
         }
         if(GameSetting.CONSTRUCTION_OWER_CELL_NUMBER >= _loc1_.length)
         {
            this.downBtn.setBtnDisabled(true);
         }
         else
         {
            this.downBtn.setBtnDisabled(false);
         }
      }
      
      public function sortConstructionTypeList() : Array
      {
         var _loc2_:Array = null;
         var _loc3_:Equiment = null;
         var _loc1_:Array = new Array();
         if(this._tabIndex == GameSetting.CONSTRUCTION_TYPE_DEFENSE)
         {
            _loc2_ = ConstructionAction.outSideContuctionList.Values();
         }
         else
         {
            _loc2_ = ConstructionAction.constuctionList.Values();
         }
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_.BlurPrint.UIType == this._tabIndex)
            {
               _loc1_.push(_loc3_.EquimentInfoData);
            }
         }
         _loc1_.sortOn("LevelId",Array.NUMERIC);
         return _loc1_;
      }
      
      public function setConstructionTabSwitch() : void
      {
         if(this._preTabIndex === this._tabIndex)
         {
            return;
         }
         this.removeOwnConstuctionItem();
         this.loadOwnConstructionList();
         ConstructionDetailManagerUI.getInstance().setConstructionTabSwitch();
      }
      
      private function removeOwnConstuctionItem() : void
      {
         var _loc1_:ConstructionInfoCellUI = null;
         for each(_loc1_ in this._cellItemList)
         {
            if(_loc1_.parent)
            {
               _loc1_.parent.removeChild(_loc1_);
            }
         }
         ObjectUtil.ClearArray(this._cellItemList);
         this._cellItemList = null;
      }
      
      private function onNagivateHandler(param1:MouseEvent) : void
      {
         this._pageId = 0;
         this._preTabIndex = this._tabIndex;
         switch(param1.target.name)
         {
            case "btn_resbuild":
               this._tabIndex = GameSetting.CONSTRUCTION_TYPE_RES;
               this.setConstructionTabSwitch();
               break;
            case "btn_citybuild":
               this._tabIndex = GameSetting.CONSTRUCTION_TYPE_CIVICISM;
               this.setConstructionTabSwitch();
               break;
            case "btn_beautifybuild":
               this._tabIndex = GameSetting.CONSTRUCTION_TYPE_DIY;
               this.setConstructionTabSwitch();
               break;
            case "btn_armbuild":
               this._tabIndex = GameSetting.CONSTRUCTION_TYPE_MILITARY;
               this.setConstructionTabSwitch();
               break;
            case "btn_defensebuild":
               this._tabIndex = GameSetting.CONSTRUCTION_TYPE_DEFENSE;
               this.setConstructionTabSwitch();
               break;
            case "btn_cancel":
               this.Hide();
         }
      }
      
      public function Hide() : void
      {
         GameKernel.popUpDisplayManager.Hide(instance);
      }
      
      private function onPageHandler(param1:MouseEvent) : void
      {
         switch(param1.target.name)
         {
            case "btn_up":
               this._pageId = Math.max(0,--this._pageId);
               this.setConstructionTabSwitch();
               break;
            case "btn_down":
               ++this._pageId;
               this.setConstructionTabSwitch();
         }
      }
   }
}

