package logic.ui
{
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.utils.HashSet;
   import com.star.frameworks.utils.ObjectUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import logic.entry.EquimentData;
   import logic.entry.HButton;
   import logic.manager.GameInterActiveManager;
   
   public class ConstructionDetailManagerUI
   {
      
      private static var instance:ConstructionDetailManagerUI;
      
      private var _Index:int;
      
      private var _pageId:int;
      
      private var miniupBtn:HButton;
      
      private var minidownBtn:HButton;
      
      private var _target:MovieClip;
      
      private var _cellItemList:Array;
      
      private var _tabIndex:int;
      
      private var _preTabIndex:int;
      
      public function ConstructionDetailManagerUI()
      {
         super();
      }
      
      public static function getInstance() : ConstructionDetailManagerUI
      {
         if(instance == null)
         {
            instance = new ConstructionDetailManagerUI();
         }
         return instance;
      }
      
      public function Init(param1:MovieClip) : void
      {
         this._target = param1;
         this.miniupBtn = new HButton(this._target.btn_miniup);
         this.minidownBtn = new HButton(this._target.btn_minidown);
         GameInterActiveManager.InstallInterActiveEvent(this.miniupBtn.m_movie,ActionEvent.ACTION_CLICK,this.onPageHandler);
         GameInterActiveManager.InstallInterActiveEvent(this.minidownBtn.m_movie,ActionEvent.ACTION_CLICK,this.onPageHandler);
         this.loadContructionDetailInfo();
      }
      
      private function loadContructionDetailInfo() : void
      {
         var _loc6_:ConstructionDetailCellItem = null;
         var _loc7_:MovieClip = null;
         this._cellItemList = new Array();
         var _loc1_:Array = ConstructionInfoManagerUI.getInstance().sortConstructionTypeList();
         var _loc2_:HashSet = this.getDifferentConstructionList(_loc1_);
         var _loc3_:Array = _loc2_.Values();
         var _loc4_:int = Math.min(_loc2_.Length(),(this._pageId + 1) * 3);
         var _loc5_:int = this._pageId * 3;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = new ConstructionDetailCellItem(_loc5_,_loc3_[_loc5_]);
            _loc6_.setConstructionName();
            _loc6_.setConstructionImage();
            _loc6_.setConstructionNum();
            this._cellItemList.push(_loc6_);
            _loc7_ = this._target.getChildByName("mc_base" + (_loc5_ - this._pageId * 3)) as MovieClip;
            _loc7_.addChild(_loc6_);
            _loc5_++;
         }
         this.setLRBtnState();
      }
      
      private function removeConstuctionDetailItem() : void
      {
         var _loc1_:ConstructionDetailCellItem = null;
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
      
      private function setLRBtnState() : void
      {
         var _loc1_:Array = ConstructionInfoManagerUI.getInstance().sortConstructionTypeList();
         var _loc2_:HashSet = this.getDifferentConstructionList(_loc1_);
         if(_loc2_.Length() == 0)
         {
            this.miniupBtn.setBtnDisabled(true);
            this.minidownBtn.setBtnDisabled(true);
            return;
         }
         if(this._pageId == 0)
         {
            this.miniupBtn.setBtnDisabled(true);
         }
         else
         {
            this.miniupBtn.setBtnDisabled(false);
         }
         if((this._pageId + 1) * 3 >= _loc2_.Length())
         {
            this.minidownBtn.setBtnDisabled(true);
         }
         else
         {
            this.minidownBtn.setBtnDisabled(false);
         }
      }
      
      public function setConstructionTabSwitch() : void
      {
         this.removeConstuctionDetailItem();
         this.loadContructionDetailInfo();
      }
      
      private function getDifferentConstructionList(param1:Array) : HashSet
      {
         var _loc3_:EquimentData = null;
         var _loc2_:HashSet = new HashSet();
         for each(_loc3_ in param1)
         {
            _loc2_.Put(_loc3_.BuildID,_loc3_);
         }
         return _loc2_;
      }
      
      private function onPageHandler(param1:MouseEvent) : void
      {
         switch(param1.target.name)
         {
            case "btn_miniup":
               this._pageId = Math.max(0,--this._pageId);
               this.setConstructionTabSwitch();
               break;
            case "btn_minidown":
               ++this._pageId;
               this.setConstructionTabSwitch();
         }
      }
   }
}

