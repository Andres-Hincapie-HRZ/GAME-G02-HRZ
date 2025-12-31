package logic.ui.info
{
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.StringUitl;
   import logic.action.ConstructionAction;
   import logic.entry.CFortification;
   import logic.entry.EquimentFactory;
   import logic.entry.EquimentTypeEnum;
   import logic.entry.FortificationStar;
   import logic.entry.GamePlayer;
   import logic.entry.StarLevelEntry;
   import logic.entry.blurprint.EquimentBlueprint;
   import logic.reader.CConstructionReader;
   import logic.reader.CFortificationReader;
   import logic.reader.FortificationStarReader;
   import logic.reader.StarLevelReader;
   import logic.ui.ConstructionUI;
   import logic.widget.ConstructionUtil;
   import logic.widget.DataWidget;
   import logic.widget.tips.CToolTipFactory;
   
   public class CTipInfo
   {
      
      private var _buildId:int;
      
      private var _buildLv:int;
      
      private var _buildIndex:int;
      
      private var _module:int;
      
      private var equimentLv:EquimentBlueprint;
      
      private var starLv:StarLevelEntry;
      
      private var _iDecorate:IInfoDecorate;
      
      public function CTipInfo(param1:int, param2:int, param3:int, param4:int, param5:IInfoDecorate)
      {
         super();
         this._buildId = param1;
         this._buildLv = param3;
         this._buildIndex = param2;
         this._module = param4;
         this._iDecorate = param5;
      }
      
      public function Init() : void
      {
         switch(this._module)
         {
            case CTipModule.MODULE_BASEINFO:
               this.initBaseInfo();
               break;
            case CTipModule.MODULE_UPGRADE:
               this.initInfo();
               break;
            case CTipModule.MODULE_CAPACITY:
               this.initCapacity();
               break;
            case CTipModule.MODULE_STARLEVEL:
               this.initStarLevel();
               break;
            case CTipModule.MODULE_BASESTARLEVEL:
               this.initBaseStarLevel();
         }
      }
      
      private function initBaseInfo() : void
      {
         var _loc1_:CFortification = null;
         var _loc2_:String = null;
         this.equimentLv = CConstructionReader.getInstance().Read(this._buildId,this._buildLv);
         this._iDecorate.Update("CommentDesc",this.equimentLv.Comment1);
         this._iDecorate.ReSetShowState("RepairTimeDesc");
         this._iDecorate.ReSetShowState("RepairTimeTxt");
         if(this.equimentLv.BuildingClass & 1)
         {
            this._iDecorate.Update("BuildingName",this.equimentLv.BuildingName);
            this._iDecorate.Update("BuildingLvTxt",StringManager.getInstance().getMessageString("BuildingText21") + (this._buildLv + 1));
            _loc1_ = CFortificationReader.GetInstance().Read(this._buildId,this._buildLv + 1);
            _loc1_.BuildID = this._buildId;
            this._iDecorate.Update("LevelCommentDesc",CFortificationReader.ParserFortication(this.equimentLv.defendLevel.LevelComment,_loc1_));
            if(Boolean(ConstructionAction.currentTarget) && ConstructionAction.currentTarget.EquimentInfoData.needTime < 0)
            {
               this._iDecorate.Update("RepairTimeDesc",null);
               this._iDecorate.Update("RepairTimeTxt",DataWidget.localToDataZone(Math.abs(ConstructionAction.currentTarget.EquimentInfoData.needTime)));
            }
         }
         else
         {
            this._iDecorate.Update("BuildingName",this.equimentLv.BuildingName);
            this._iDecorate.Update("BuildingLvTxt",StringManager.getInstance().getMessageString("BuildingText21") + (this._buildLv + 1));
            this._iDecorate.Update("LevelCommentDesc",this.equimentLv.equimentLevel.LevelComment);
         }
         if(!ConstructionUtil.HaveNextLevel(this._buildIndex))
         {
            _loc2_ = StringManager.getInstance().getMessageString("BuildingText7") + (this._buildLv + 1);
            this._iDecorate.Update("BuildingLvTxt",_loc2_);
            this._iDecorate.setDisableState("BuildingLvTxt",true);
         }
         else
         {
            this._iDecorate.setDisableState("BuildingLvTxt",false);
         }
      }
      
      private function initTechInfo() : void
      {
      }
      
      private function initCapacity() : void
      {
         this.equimentLv = CConstructionReader.getInstance().Read(this._buildId,this._buildLv);
         this._iDecorate.Update("BuildingName",this.equimentLv.BuildingName);
         this._iDecorate.Update("BuildingLvTxt",StringManager.getInstance().getMessageString("BuildingText21") + (this._buildLv + 1));
         this._iDecorate.Update("MetalCurrentTXT",StringUitl.toUSFormat(GamePlayer.getInstance().ResMetal));
         this._iDecorate.Update("He3CurrentTXT",StringUitl.toUSFormat(GamePlayer.getInstance().ResGas));
         this._iDecorate.Update("MoneyCurrentTXT",StringUitl.toUSFormat(GamePlayer.getInstance().ResMoney));
         this._iDecorate.Update("MetalmaxTXT",StringUitl.toUSFormat(GamePlayer.getInstance().ResStorageMetal));
         this._iDecorate.Update("He3MaxTXT",StringUitl.toUSFormat(GamePlayer.getInstance().ResStorageGas));
         this._iDecorate.Update("MoneyMaxTXT",StringUitl.toUSFormat(GamePlayer.getInstance().ResStorageMoney));
      }
      
      private function initInfo() : void
      {
         var _loc1_:Array = null;
         var _loc2_:CFortification = null;
         var _loc3_:EquimentBlueprint = null;
         this.equimentLv = CConstructionReader.getInstance().Read(this._buildId,this._buildLv);
         this._iDecorate.ReSetShowState("UpgradeDepend");
         this._iDecorate.ReSetShowState("UpgradeDependTxt");
         this._iDecorate.ReSetShowState("ConstructionNumTxt");
         if(this._buildLv == 0)
         {
            if(this.equimentLv.BuildingID == -1)
            {
               return;
            }
            this._iDecorate.Update("BuildingName",this.equimentLv.BuildingName);
            this._iDecorate.Update("BuildingLvTxt",StringManager.getInstance().getMessageString("BuildingText21") + (this._buildLv + 1));
            this._iDecorate.Update("CommentDesc",this.equimentLv.Comment1);
            if(Boolean(ConstructionUI.getInstance().CurrentConstructionCell) && ConstructionUI.getInstance().CurrentConstructionCell.isOverLimit())
            {
               this._iDecorate.Update("ConstructionNumTxt",null);
            }
            if(this.equimentLv.BuildingClass & 1)
            {
               _loc1_ = ConstructionUtil.parserDependBuilding(this.equimentLv.defendLevel.Dependbuilding);
               _loc2_ = CFortificationReader.GetInstance().Read(this._buildId,this._buildLv + 1);
               _loc2_.BuildID = this._buildId;
               this._iDecorate.Update("LevelCommentDesc",CFortificationReader.ParserFortication(this.equimentLv.defendLevel.LevelComment,_loc2_));
               this._iDecorate.setSpecialColor("LevelCommentDesc",16750848);
               this._iDecorate.Update("UpgradeMetalDependTxt",StringUitl.toUSFormat(int(this.equimentLv.defendLevel.CostMetal * (1 - ConstructionAction.defendTechObj.DecreaseMetalConsume))));
               this._iDecorate.Update("UpgradeHe3DependTTxt",StringUitl.toUSFormat(int(this.equimentLv.defendLevel.CostHelium_3 * (1 - ConstructionAction.defendTechObj.DecreaseHe3Consume))));
               this._iDecorate.Update("UpgradeMoneyDependTTxt",StringUitl.toUSFormat(int(this.equimentLv.defendLevel.CostFunds * (1 - ConstructionAction.defendTechObj.DecreaseMoneyConsume))));
               CToolTipFactory.dependStr = ConstructionUtil.getDependStr(_loc1_);
               this._iDecorate.Update("UpgradeDepend",null);
               this._iDecorate.Update("UpgradeDependTxt",CToolTipFactory.dependStr,-1,false);
               this._iDecorate.Update("UpgradeTimeTxt",DataWidget.localToDataZone(this.equimentLv.defendLevel.needTime * (1 - ConstructionAction.defendTechObj.IncreaseBuilding)));
            }
            else
            {
               _loc1_ = ConstructionUtil.parserDependBuilding(this.equimentLv.equimentLevel.Dependbuilding);
               this._iDecorate.Update("LevelCommentDesc",this.equimentLv.equimentLevel.LevelComment);
               this._iDecorate.setSpecialColor("LevelCommentDesc",16750848);
               this._iDecorate.Update("UpgradeMetalDependTxt",StringUitl.toUSFormat(int(this.equimentLv.equimentLevel.CostMetal * (1 - ConstructionAction.bulidTechObj.DecreaseMetalConsume))));
               this._iDecorate.Update("UpgradeHe3DependTTxt",StringUitl.toUSFormat(int(this.equimentLv.equimentLevel.CostHelium_3 * (1 - ConstructionAction.bulidTechObj.DecreaseHe3Consume))));
               this._iDecorate.Update("UpgradeMoneyDependTTxt",StringUitl.toUSFormat(int(this.equimentLv.equimentLevel.CostFunds * (1 - ConstructionAction.bulidTechObj.DecreaseMoneyConsume))));
               if(this.equimentLv.UIType == EquimentFactory.EQUIMENT_UI_DIY)
               {
               }
               this._iDecorate.Update("UpgradeDepend",null);
               CToolTipFactory.dependStr = ConstructionUtil.getDependStr(_loc1_);
               this._iDecorate.Update("UpgradeDependTxt",CToolTipFactory.dependStr,-1,false);
               this._iDecorate.ReSetShowState("UpgradeDepend");
               this._iDecorate.Update("UpgradeTimeTxt",DataWidget.localToDataZone(int(this.equimentLv.equimentLevel.needTime * (1 - ConstructionAction.bulidTechObj.IncreaseBuilding))));
            }
         }
         else
         {
            if(this.equimentLv.BuildingID == -1)
            {
               return;
            }
            this._iDecorate.Update("BuildingName",this.equimentLv.BuildingName);
            this._iDecorate.Update("BuildingLvTxt",StringManager.getInstance().getMessageString("BuildingText21") + (this._buildLv + 1));
            this._iDecorate.Update("CommentDesc",this.equimentLv.Comment1);
            this._iDecorate.ReSetShowState("UpgradeTime");
            this._iDecorate.ReSetShowState("UpgradeTimeTxt");
            if(this.equimentLv.BuildingClass & 1)
            {
               if(ConstructionUtil.HaveNextLevel(this._buildIndex))
               {
                  _loc3_ = CConstructionReader.getInstance().Read(this._buildId,this._buildLv);
                  _loc1_ = ConstructionUtil.parserDependBuilding(_loc3_.defendLevel.Dependbuilding);
                  _loc2_ = CFortificationReader.GetInstance().Read(this._buildId,this._buildLv + 1);
                  _loc2_.BuildID = this._buildId;
                  this._iDecorate.Update("LevelCommentDesc",CFortificationReader.ParserFortication(_loc3_.defendLevel.LevelComment,_loc2_));
                  this._iDecorate.setSpecialColor("LevelCommentDesc",16750848);
                  this._iDecorate.Update("UpgradeMetalDependTxt",StringUitl.toUSFormat(int(this.equimentLv.defendLevel.CostMetal * (1 - ConstructionAction.defendTechObj.DecreaseMetalConsume))));
                  this._iDecorate.Update("UpgradeHe3DependTTxt",StringUitl.toUSFormat(int(this.equimentLv.defendLevel.CostHelium_3 * (1 - ConstructionAction.defendTechObj.DecreaseHe3Consume))));
                  this._iDecorate.Update("UpgradeMoneyDependTTxt",StringUitl.toUSFormat(int(this.equimentLv.defendLevel.CostFunds * (1 - ConstructionAction.defendTechObj.DecreaseMoneyConsume))));
                  this._iDecorate.Update("UpgradeTime",null);
                  if(this.equimentLv.BuildingID != EquimentTypeEnum.EQUIMENT_TYPE_SPACESTATION)
                  {
                     CToolTipFactory.dependStr = ConstructionUtil.getDependStr(_loc1_);
                     this._iDecorate.Update("UpgradeDependTxt",CToolTipFactory.dependStr,-1,false);
                     this._iDecorate.Update("UpgradeDepend",null);
                  }
                  this._iDecorate.Update("UpgradeTimeTxt",DataWidget.localToDataZone(int(this.equimentLv.defendLevel.needTime * (1 - ConstructionAction.defendTechObj.IncreaseBuilding))));
               }
               else
               {
                  this._iDecorate.Update("BuildingLvTxt",StringManager.getInstance().getMessageString("BuildingText7") + (this._buildLv + 1));
                  this._iDecorate.setDisableState("BuildingLvTxt",true);
                  this._iDecorate.Update("LevelCommentDesc",this.equimentLv.defendLevel.LevelComment);
                  this._iDecorate.setSpecialColor("LevelCommentDesc",16750848);
               }
            }
            else if(ConstructionUtil.HaveNextLevel(this._buildIndex))
            {
               _loc3_ = CConstructionReader.getInstance().Read(this._buildId,this._buildLv);
               this._iDecorate.Update("UpgradeMetalDependTxt",StringUitl.toUSFormat(int(this.equimentLv.equimentLevel.CostMetal * (1 - ConstructionAction.bulidTechObj.DecreaseMetalConsume))));
               this._iDecorate.Update("UpgradeHe3DependTTxt",StringUitl.toUSFormat(int(this.equimentLv.equimentLevel.CostHelium_3 * (1 - ConstructionAction.bulidTechObj.DecreaseHe3Consume))));
               this._iDecorate.Update("UpgradeMoneyDependTTxt",StringUitl.toUSFormat(int(this.equimentLv.equimentLevel.CostFunds * (1 - ConstructionAction.bulidTechObj.DecreaseMoneyConsume))));
               this._iDecorate.Update("LevelCommentDesc",_loc3_.equimentLevel.LevelComment);
               this._iDecorate.setSpecialColor("LevelCommentDesc",16750848);
               this._iDecorate.Update("UpgradeTime",null);
               _loc1_ = ConstructionUtil.parserDependBuilding(_loc3_.equimentLevel.Dependbuilding);
               this._iDecorate.setDisableState("UpgradeDependTxt",false);
               if(this.equimentLv.UIType == EquimentFactory.EQUIMENT_UI_DIY)
               {
               }
               this._iDecorate.Update("UpgradeDepend",null);
               CToolTipFactory.dependStr = ConstructionUtil.getDependStr(_loc1_);
               this._iDecorate.Update("UpgradeDependTxt",CToolTipFactory.dependStr,-1,false);
               this._iDecorate.Update("UpgradeTimeTxt",DataWidget.localToDataZone(int(_loc3_.equimentLevel.needTime * (1 - ConstructionAction.bulidTechObj.IncreaseBuilding))));
            }
            else
            {
               this._iDecorate.Update("BuildingLvTxt",StringManager.getInstance().getMessageString("BuildingText7") + (this._buildLv + 1));
               this._iDecorate.setDisableState("BuildingLvTxt",true);
               this._iDecorate.Update("LevelCommentDesc",this.equimentLv.equimentLevel.LevelComment);
               this._iDecorate.setSpecialColor("LevelCommentDesc",16750848);
               this._iDecorate.Update("UpgradeMetalDependTxt",StringUitl.toUSFormat(int(this.equimentLv.equimentLevel.CostMetal * (1 - ConstructionAction.bulidTechObj.DecreaseMetalConsume))));
               this._iDecorate.Update("UpgradeHe3DependTTxt",StringUitl.toUSFormat(int(this.equimentLv.equimentLevel.CostHelium_3 * (1 - ConstructionAction.bulidTechObj.DecreaseHe3Consume))));
               this._iDecorate.Update("UpgradeMoneyDependTTxt",StringUitl.toUSFormat(int(this.equimentLv.equimentLevel.CostFunds * (1 - ConstructionAction.bulidTechObj.DecreaseMoneyConsume))));
            }
         }
      }
      
      private function initStarLevel() : void
      {
         var _loc1_:FortificationStar = null;
         var _loc2_:StarLevelEntry = null;
         var _loc3_:FortificationStar = null;
         this._iDecorate.setDisableState("BuildingLvTxt",false);
         this._iDecorate.ReSetShowState("MetalOut");
         this._iDecorate.ReSetShowState("He3Out");
         this._iDecorate.ReSetShowState("MoneyOut");
         this._iDecorate.ReSetShowState("MakeShipOut");
         this._iDecorate.ReSetShowState("TechResearchOut");
         this._iDecorate.ReSetShowState("MetalOutTxt");
         this._iDecorate.ReSetShowState("He3OutTxt");
         this._iDecorate.ReSetShowState("MoneyOutTxt");
         this._iDecorate.ReSetShowState("MakeShipOutTxt");
         this._iDecorate.ReSetShowState("TechResearchTxt");
         this._iDecorate.ReSetShowState("CommentDesc");
         this._iDecorate.ReSetShowState("LevelCommentDesc");
         if(this._buildId == EquimentTypeEnum.EQUIMENT_TYPE_SPACESTATION)
         {
            this.starLv = StarLevelReader.getInstance().Read(this._buildLv + 1);
            this._iDecorate.Update("BuildingName",this.starLv.buildName);
            this._iDecorate.Update("MetalOut",null);
            this._iDecorate.Update("He3Out",null);
            this._iDecorate.Update("MoneyOut",null);
            this._iDecorate.Update("MakeShipOut",null);
            this._iDecorate.Update("TechResearchOut",null);
            this._iDecorate.Update("MetalOutTxt","+" + StringUitl.getMathFormatTwo(String(this.starLv.affect * 100)) + "%");
            this._iDecorate.Update("He3OutTxt","+" + StringUitl.getMathFormatTwo(String(this.starLv.affect * 100)) + "%");
            this._iDecorate.Update("MoneyOutTxt","+" + StringUitl.getMathFormatTwo(String(this.starLv.affect * 100)) + "%");
            this._iDecorate.Update("MakeShipOutTxt","+" + StringUitl.getMathFormatTwo(String(this.starLv.affect * 100)) + "%");
            this._iDecorate.Update("TechResearchTxt","+" + StringUitl.getMathFormatTwo(String(this.starLv.affect * 100)) + "%");
         }
         else
         {
            _loc1_ = FortificationStarReader.getInstance().Read(this._buildId,this._buildLv);
            this._iDecorate.Update("BuildingName",_loc1_.BuildingName);
            this._iDecorate.Update("CommentDesc",_loc1_.Comment1);
            this._iDecorate.Update("BuildingLvTxt",StringManager.getInstance().getMessageString("BuildingText21") + (this._buildLv + 1));
            this._iDecorate.Update("LevelCommentDesc",_loc1_.LevelComment);
            this._iDecorate.setSpecialColor("LevelCommentDesc",16750848);
         }
         if(this._buildId == EquimentTypeEnum.EQUIMENT_TYPE_SPACESTATION)
         {
            _loc2_ = StarLevelReader.getInstance().Read(this._buildLv + 1);
            if(_loc2_.level != -1)
            {
               this._iDecorate.Update("BuildingLvTxt",StringManager.getInstance().getMessageString("BuildingText21") + _loc2_.level);
               this._iDecorate.Update("UpgrateNeedWealthOutTxt",StringUitl.toUSFormat(_loc2_.needRiches));
               if(_loc2_.needRiches > GamePlayer.getInstance().currentWealth)
               {
                  this._iDecorate.setDisableState("UpgrateNeedWealthOutTxt");
               }
               else
               {
                  this._iDecorate.setDisableState("UpgrateNeedWealthOutTxt",false);
               }
            }
         }
         else
         {
            _loc3_ = FortificationStarReader.getInstance().Read(this._buildId,this._buildLv + 1);
            if(_loc3_.LevelID != -1 && _loc3_.LevelID < _loc3_.MaxLevel)
            {
               this._iDecorate.Update("CommentDesc",_loc3_.Comment1);
               this._iDecorate.Update("BuildingLvTxt",StringManager.getInstance().getMessageString("BuildingText21") + (_loc3_.LevelID + 1));
               this._iDecorate.Update("LevelCommentDesc",_loc3_.LevelComment);
               this._iDecorate.setSpecialColor("LevelCommentDesc",16750848);
               this._iDecorate.Update("UpgrateNeedWealthOutTxt",StringUitl.toUSFormat(_loc3_.Wealth));
               if(_loc3_.Wealth > GamePlayer.getInstance().currentWealth)
               {
                  this._iDecorate.setDisableState("UpgrateNeedWealthOutTxt");
               }
               else
               {
                  this._iDecorate.setDisableState("UpgrateNeedWealthOutTxt",false);
               }
            }
            else
            {
               this._iDecorate.Update("BuildingLvTxt",StringManager.getInstance().getMessageString("BuildingText7") + (this._buildLv + 1));
               this._iDecorate.setDisableState("BuildingLvTxt",true);
            }
         }
         this._iDecorate.Update("CurrentWealthhTxt",StringUitl.toUSFormat(GamePlayer.getInstance().currentWealth));
      }
      
      private function initBaseStarLevel() : void
      {
         var _loc1_:FortificationStar = null;
         this._iDecorate.setDisableState("BuildingLvTxt",false);
         this._iDecorate.ReSetShowState("MetalOut");
         this._iDecorate.ReSetShowState("He3Out");
         this._iDecorate.ReSetShowState("MoneyOut");
         this._iDecorate.ReSetShowState("MakeShipOut");
         this._iDecorate.ReSetShowState("TechResearchOut");
         this._iDecorate.ReSetShowState("MetalOutTxt");
         this._iDecorate.ReSetShowState("He3OutTxt");
         this._iDecorate.ReSetShowState("MoneyOutTxt");
         this._iDecorate.ReSetShowState("MakeShipOutTxt");
         this._iDecorate.ReSetShowState("TechResearchTxt");
         if(this._buildId == EquimentTypeEnum.EQUIMENT_TYPE_SPACESTATION)
         {
            this.starLv = StarLevelReader.getInstance().Read(this._buildLv);
            this._iDecorate.ReSetShowState("CommentDesc");
            this._iDecorate.ReSetShowState("LevelCommentDesc");
            this._iDecorate.setSpecialColor("LevelCommentDesc",16750848);
            this._iDecorate.Update("BuildingName",this.starLv.buildName);
            this._iDecorate.Update("BuildingLvTxt",StringManager.getInstance().getMessageString("BuildingText21") + (this._buildLv + 1));
            this._iDecorate.Update("MetalOut",null);
            this._iDecorate.Update("He3Out",null);
            this._iDecorate.Update("MoneyOut",null);
            this._iDecorate.Update("MakeShipOut",null);
            this._iDecorate.Update("TechResearchOut",null);
            this._iDecorate.Update("MetalOutTxt","+" + StringUitl.getMathFormatTwo(String(this.starLv.affect * 100)) + "%");
            this._iDecorate.Update("He3OutTxt","+" + StringUitl.getMathFormatTwo(String(this.starLv.affect * 100)) + "%");
            this._iDecorate.Update("MoneyOutTxt","+" + StringUitl.getMathFormatTwo(String(this.starLv.affect * 100)) + "%");
            this._iDecorate.Update("MakeShipOutTxt","+" + StringUitl.getMathFormatTwo(String(this.starLv.affect * 100)) + "%");
            this._iDecorate.Update("TechResearchTxt","+" + StringUitl.getMathFormatTwo(String(this.starLv.affect * 100)) + "%");
         }
         else
         {
            _loc1_ = FortificationStarReader.getInstance().Read(this._buildId,this._buildLv);
            this._iDecorate.Update("BuildingName",_loc1_.BuildingName);
            this._iDecorate.Update("CommentDesc",_loc1_.Comment1);
            this._iDecorate.Update("BuildingLvTxt",StringManager.getInstance().getMessageString("BuildingText21") + (this._buildLv + 1));
            this._iDecorate.Update("LevelCommentDesc",_loc1_.LevelComment);
            this._iDecorate.setSpecialColor("LevelCommentDesc",16750848);
         }
      }
   }
}

