package logic.ui
{
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.managers.StringManager;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import logic.action.ConstructionAction;
   import logic.action.StarSurfaceAction;
   import logic.entry.Equiment;
   import logic.entry.EquimentData;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.manager.GameInterActiveManager;
   import logic.ui.info.CTipModule;
   import logic.ui.info.ConstructionTipFactory;
   import logic.ui.info.IInfoDecorate;
   import logic.widget.ConstructionUtil;
   import logic.widget.DataWidget;
   import logic.widget.OperationWidget;
   
   public class ConstructionInfoCellUI extends MObject
   {
      
      private var _index:int;
      
      private var _equiment:EquimentData;
      
      private var _speedBtn:HButton;
      
      private var _cancelBtn:HButton;
      
      private var _upgrateBtn:HButton;
      
      private var _destoryBtn:HButton;
      
      private var _buildNameTF:TextField;
      
      private var _costTimeTf:TextField;
      
      private var _buildLvTF:TextField;
      
      private var _isUpgrade:Boolean;
      
      private var _infoDecorate:IInfoDecorate;
      
      private var _isUpgradeAble:Boolean;
      
      public function ConstructionInfoCellUI(param1:int, param2:EquimentData)
      {
         super("BuildinfoContainerMc");
         this._index = param1;
         this._equiment = param2;
         this._isUpgrade = false;
         this._isUpgradeAble = false;
         this.Init();
      }
      
      public function get ConstructionData() : EquimentData
      {
         return this._equiment;
      }
      
      public function get IsUpgrade() : Boolean
      {
         return this._isUpgrade;
      }
      
      public function set IsUpgrade(param1:Boolean) : void
      {
         this._isUpgrade = param1;
      }
      
      private function Init() : void
      {
         this._buildNameTF = getMC().tf_buildname as TextField;
         this._buildLvTF = getMC().tf_LV as TextField;
         this._costTimeTf = getMC().tf_time as TextField;
         this._speedBtn = new HButton(getMC().btn_add);
         this._cancelBtn = new HButton(getMC().btn_delete);
         this._upgrateBtn = new HButton(getMC().btn_upgrade);
         this._destoryBtn = new HButton(getMC().btn_cancel);
         GameInterActiveManager.InstallInterActiveEvent(this._speedBtn.m_movie,ActionEvent.ACTION_CLICK,this.onCellUIHandler);
         GameInterActiveManager.InstallInterActiveEvent(this._cancelBtn.m_movie,ActionEvent.ACTION_CLICK,this.onCellUIHandler);
         GameInterActiveManager.InstallInterActiveEvent(this._upgrateBtn.m_movie,ActionEvent.ACTION_CLICK,this.onCellUIHandler);
         GameInterActiveManager.InstallInterActiveEvent(this._destoryBtn.m_movie,ActionEvent.ACTION_CLICK,this.onCellUIHandler);
         GameInterActiveManager.InstallInterActiveEvent(this._upgrateBtn.m_movie,ActionEvent.ACTION_MOUSE_OVER,this.onCellOverHandler);
         GameInterActiveManager.InstallInterActiveEvent(this._upgrateBtn.m_movie,ActionEvent.ACTION_MOUSE_OUT,this.onCellOutHandler);
         GameInterActiveManager.InstallInterActiveEvent(this._buildNameTF,ActionEvent.ACTION_CLICK,this.onGoto);
         this._isUpgradeAble = ConstructionUtil.HaveNextLevel(this._equiment.BuildID);
         if(!this._isUpgradeAble)
         {
            this._upgrateBtn.setVisible(false);
         }
         this.setOperationBtnState();
      }
      
      public function setConstructionName() : void
      {
         this._buildNameTF.text = this._equiment.BuildName;
      }
      
      public function setOperationBtnState() : void
      {
         if(this._isUpgradeAble)
         {
            if(!ConstructionAction.getInstance().checkCanBuild(this._equiment.BuildID,this._equiment.LevelId + 1))
            {
               this._upgrateBtn.setBtnDisabled(true);
               this._upgrateBtn.m_movie.mouseEnabled = true;
            }
            else
            {
               this._upgrateBtn.setBtnDisabled(false);
            }
         }
      }
      
      public function setConstuctionLv() : void
      {
         this._buildLvTF.text = "Lv:" + (this._equiment.LevelId + 1);
      }
      
      public function setFunctionBtnState() : void
      {
         if(this._isUpgrade)
         {
            this._speedBtn.setBtnDisabled(true);
            this._speedBtn.setVisible(false);
         }
         else
         {
            this._speedBtn.setBtnDisabled(false);
            this._speedBtn.setVisible(true);
         }
      }
      
      public function setCellItemCostTime() : void
      {
         if(this._equiment.needTime)
         {
            this._isUpgrade = true;
            this._costTimeTf.text = DataWidget.localToDataZone(this._equiment.needTime);
            this._costTimeTf.textColor = 16711680;
         }
         else
         {
            this._isUpgrade = false;
            this._costTimeTf.text = StringManager.getInstance().getMessageString("ItemText18");
            this._costTimeTf.textColor = 0;
         }
      }
      
      public function setUnUpgrade() : void
      {
         this._isUpgrade = false;
         this._costTimeTf.text = StringManager.getInstance().getMessageString("ItemText18");
         this._costTimeTf.textColor = 0;
      }
      
      private function onGoto(param1:MouseEvent) : void
      {
         var _loc2_:Object = ConstructionAction.getInstance().getEquiment(this._equiment.IndexId);
         var _loc3_:Equiment = _loc2_.Instance as Equiment;
         var _loc4_:Number = stage.stageWidth >> 1;
         var _loc5_:Number = stage.stageHeight >> 1;
         var _loc6_:Point = _loc3_.localToGlobal(new Point(0,0));
         var _loc7_:Number = _loc6_.x - _loc4_ + _loc3_.width * 0.5;
         var _loc8_:Number = _loc6_.y - _loc5_ + _loc3_.height * 0.5;
         ConstructionAction.currentTarget = _loc3_;
         ConstructionAction.getInstance().removeOtherSenseZone(_loc3_);
         _loc3_.addEquimentSenseZone();
         ConstructionInfoManagerUI.getInstance().Hide();
         ConstructionUtil.Animation(StarSurfaceAction.getInstance().SurFaceContainer,_loc7_,_loc8_);
      }
      
      public function Clear() : void
      {
         if(this.parent)
         {
            stop();
            GameInterActiveManager.unInstallnterActiveEvent(this._speedBtn.m_movie,ActionEvent.ACTION_CLICK,this.onCellUIHandler);
            GameInterActiveManager.unInstallnterActiveEvent(this._cancelBtn.m_movie,ActionEvent.ACTION_CLICK,this.onCellUIHandler);
            GameInterActiveManager.unInstallnterActiveEvent(this._upgrateBtn.m_movie,ActionEvent.ACTION_CLICK,this.onCellUIHandler);
            GameInterActiveManager.unInstallnterActiveEvent(this._destoryBtn.m_movie,ActionEvent.ACTION_CLICK,this.onCellUIHandler);
            GameInterActiveManager.unInstallnterActiveEvent(this._upgrateBtn.m_movie,ActionEvent.ACTION_MOUSE_OVER,this.onCellOverHandler);
            GameInterActiveManager.unInstallnterActiveEvent(this._upgrateBtn.m_movie,ActionEvent.ACTION_MOUSE_OUT,this.onCellOutHandler);
            GameInterActiveManager.unInstallnterActiveEvent(this._buildNameTF,ActionEvent.ACTION_CLICK,this.onGoto);
            this.parent.removeChild(this);
         }
      }
      
      private function onCellUIHandler(param1:MouseEvent) : void
      {
         var _loc2_:Object = ConstructionAction.getInstance().getEquiment(this._equiment.IndexId);
         switch(param1.target.name)
         {
            case "btn_delete":
            case "btn_add":
               break;
            case "btn_upgrade":
               if(ConstructionAction.getInstance().CheckConstructionProgreeIsFull())
               {
                  UpgradeModulesPopUp.getInstance().Init();
                  UpgradeModulesPopUp.getInstance().Show();
                  return;
               }
               if(ConstructionAction.getInstance().checkCanBuild(this._equiment.BuildID,this._equiment.LevelId + 1))
               {
                  ConstructionAction.currentTarget = _loc2_.Instance;
                  this.IsUpgrade = true;
                  ConstructionAction.getInstance().createBuildRequest(_loc2_.Instance);
                  ConstructionAction.BuildingList.push(_loc2_.Instance);
                  this._speedBtn.setBtnDisabled(true);
                  this._costTimeTf.text = StringManager.getInstance().getMessageString("ItemText19");
               }
               OperationWidget.getInstance().Hide();
               break;
            case "btn_cancel":
               ConstructionAction.getInstance().deleteBuildRequest(this._equiment.IndexId);
         }
      }
      
      private function onCellOverHandler(param1:MouseEvent) : void
      {
         this._infoDecorate = ConstructionTipFactory.setInfoDecorate("Info");
         if(this._isUpgradeAble)
         {
            ConstructionAction.getInstance().checkCanBuild(this._equiment.BuildID,this._equiment.LevelId + 1);
            this._infoDecorate.setInfoValue(this._equiment.BuildID,this._equiment.LevelId + 1,CTipModule.MODULE_UPGRADE);
         }
         this._infoDecorate.Show(param1.stageX,param1.stageY);
      }
      
      private function onCellOutHandler(param1:MouseEvent) : void
      {
         this._infoDecorate.Hide();
      }
   }
}

