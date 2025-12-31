package logic.reader
{
   import com.star.frameworks.geom.PointKit;
   import com.star.frameworks.managers.ResManager;
   import com.star.frameworks.utils.HashSet;
   import logic.entry.ConstructionDataCache;
   import logic.entry.EquimentTypeEnum;
   import logic.entry.blurprint.CivicismLevel;
   import logic.entry.blurprint.DefendBuildLevel;
   import logic.entry.blurprint.EquimentBlueprint;
   import logic.entry.blurprint.EquimentLevel;
   import logic.entry.blurprint.Level;
   import logic.entry.blurprint.ShipBuildingLevel;
   import logic.game.GameKernel;
   
   public class CConstructionReader
   {
      
      private static var instance:CConstructionReader;
      
      private var _bluePrintList:HashSet;
      
      private var _xmlList:XMLList;
      
      public function CConstructionReader()
      {
         super();
         this._bluePrintList = new HashSet();
         this.Parser();
         this.parserConstructionType();
      }
      
      public static function getInstance() : CConstructionReader
      {
         if(instance == null)
         {
            instance = new CConstructionReader();
         }
         return instance;
      }
      
      public function get BluePrintList() : HashSet
      {
         return this._bluePrintList;
      }
      
      private function Parser() : void
      {
         this._xmlList = GameKernel.resManager.getXml(ResManager.GAMERES,"Build").* as XMLList;
      }
      
      private function parserConstructionType() : void
      {
         var _loc1_:XML = null;
         if(!this._xmlList)
         {
            this.Parser();
         }
         for each(_loc1_ in this._xmlList)
         {
            ConstructionDataCache.getInstance().CachePool[_loc1_.@UIType].push(_loc1_.@BuildingID);
         }
      }
      
      public function Read(param1:int = 0, param2:int = 0) : EquimentBlueprint
      {
         var _loc3_:XML = null;
         var _loc5_:XML = null;
         var _loc6_:EquimentBlueprint = null;
         var _loc7_:DefendBuildLevel = null;
         var _loc8_:EquimentLevel = null;
         var _loc9_:CivicismLevel = null;
         var _loc10_:ShipBuildingLevel = null;
         _loc3_ = this._xmlList[param1] as XML;
         if(_loc3_ == null)
         {
            return new EquimentBlueprint();
         }
         var _loc4_:int = Math.max(0,param2);
         _loc5_ = _loc3_.*[_loc4_] as XML;
         _loc6_ = new EquimentBlueprint();
         _loc6_.BuildingID = _loc3_.@BuildingID;
         _loc6_.BuildingName = _loc3_.@BuildingName;
         _loc6_.BuildingClass = _loc3_.@BuildingClass;
         _loc6_.BuildingType = _loc3_.@BuildingType;
         _loc6_.Comment1 = _loc3_.@Comment1;
         _loc6_.MaxLevel = _loc3_.@MaxLevel;
         _loc6_.InteractiveBoxType = _loc3_.@InteractiveBoxType;
         _loc6_.react1 = this.parserToPointKit(_loc3_.@react1);
         _loc6_.react2 = this.parserToPointKit(_loc3_.@react2);
         _loc6_.react3 = this.parserToPointKit(_loc3_.@react3);
         _loc6_.react4 = this.parserToPointKit(_loc3_.@react4);
         _loc6_.Center1 = this.parserToPointKit(_loc3_.@Center1);
         _loc6_.UIType = _loc3_.@UIType;
         _loc6_.IconName = _loc3_.@IconName;
         _loc6_.Exchange = _loc5_.@Exchange * 100;
         if(int(_loc6_.BuildingClass) & 1)
         {
            _loc7_ = new DefendBuildLevel();
            _loc7_.AntiaircraftGunNum = _loc5_.@AntiaircraftGunNum;
            _loc7_.CostFunds = _loc5_.@CostFunds;
            _loc7_.LevelComment = _loc5_.@LevelComment;
            _loc7_.CostHelium_3 = _loc5_.@CostHelium_3;
            _loc7_.CostMetal = _loc5_.@CostMetal;
            _loc7_.DependSpaceStation = _loc5_.@DependSpaceStation;
            _loc7_.ImageName = _loc5_.@ImageName;
            _loc7_.LevelComment = _loc5_.@LevelComment;
            _loc7_.LevelID = _loc5_.@LevelID;
            _loc7_.Dependbuilding = _loc5_.@Dependbuilding;
            _loc7_.MeteorNum = _loc5_.@MeteorNum;
            _loc7_.OccupationSpace = _loc5_.@OccupationSpace;
            _loc7_.ParticleCannonNum = _loc5_.@ParticleCannonNum;
            _loc7_.RepairCost = _loc5_.@RepairCost;
            _loc7_.RepairTime = _loc5_.@RepairTime;
            _loc7_.ThorCannonNum = _loc5_.@ThorCannonNum;
            _loc7_.needTime = _loc5_.@Time;
            _loc7_.AttackRange = _loc5_.@AttackRange;
            _loc6_.defendLevel = _loc7_;
         }
         else
         {
            _loc8_ = new EquimentLevel();
            _loc8_.LevelID = _loc5_.@LevelID;
            _loc8_.needTime = _loc5_.@Time;
            _loc8_.LevelComment = _loc5_.@LevelComment;
            _loc8_.CostHelium_3 = _loc5_.@CostHelium_3;
            _loc8_.CostMetal = _loc5_.@CostMetal;
            _loc8_.CostFunds = _loc5_.@CostFunds;
            _loc8_.CostCash = _loc5_.@CostCash;
            _loc8_.MostMoney = _loc5_.@MostMoney;
            _loc8_.ImageName = _loc5_.@ImageName;
            _loc8_.OccupationSpace = _loc5_.@OccupationSpace;
            _loc8_.OutHelium_3 = _loc5_.@OutHelium_3;
            _loc8_.OutMetal = _loc5_.@OutMetal;
            _loc8_.OutMoney = _loc5_.@OutMoney;
            _loc8_.CommanderNum = _loc5_.@CommanderNum;
            _loc8_.Dependbuilding = _loc5_.@Dependbuilding;
            _loc8_.MostMetal = _loc5_.@MostMetal;
            _loc8_.MostHelium_3 = _loc5_.@MostHelium_3;
            _loc8_.DecreaseTax = _loc5_.@Tax;
            _loc8_.ResourceRecycle = _loc5_.@ResourceRecycle;
            _loc6_.equimentLevel = _loc8_;
            if(param1 == EquimentTypeEnum.EQUIMENT_TYPE_CIVICISM)
            {
               _loc9_ = new CivicismLevel();
               _loc9_.AlliancecenterNum = _loc5_.@AlliancecenterNum;
               _loc9_.MetalResNum = _loc5_.@MetalResourcesNum;
               _loc9_.He3ResNum = _loc5_.@He3ResourcesNum;
               _loc9_.ComponentNum = _loc5_.@ComponentNum;
               _loc9_.LeadercenterNum = _loc5_.@LeadercenterNum;
               _loc9_.HouseNum = _loc5_.@HouseNum;
               _loc9_.ShipyardNum = _loc5_.@ShipyardNum;
               _loc9_.StorageNum = _loc5_.@StorageNum;
               _loc9_.TechNum = _loc5_.@TechNum;
               _loc9_.TradecenterNum = _loc5_.@TradecenterNum;
               _loc9_.SynthesisNum = _loc5_.@SynthesisNum;
               _loc9_.RaderNum = _loc5_.@RaderNum;
               _loc9_.ShipReclaimNum = _loc5_.@ShipReclaimNum;
               _loc9_.Dependbuilding = _loc5_.@Dependbuilding;
               _loc6_.equimentLevel.civicismLevel = _loc9_;
            }
            else if(param1 == EquimentTypeEnum.EQUIMENT_TYPE_SHIPBUILDING)
            {
               _loc10_ = new ShipBuildingLevel();
               _loc10_.ShipProductionQueue = _loc5_.@ShipProductionQueue;
               _loc10_.IncreaseShipProduce = _loc5_.@IncreaseShipProduce;
               _loc6_.equimentLevel.shipBuild = _loc10_;
            }
         }
         return _loc6_;
      }
      
      public function getNextLevel(param1:int, param2:int, param3:int) : Level
      {
         var _loc6_:DefendBuildLevel = null;
         var _loc7_:EquimentLevel = null;
         var _loc8_:CivicismLevel = null;
         var _loc9_:ShipBuildingLevel = null;
         var _loc4_:XML = this._xmlList[param1] as XML;
         var _loc5_:XML = _loc4_.*[param3 + 1] as XML;
         if(param2 & 1)
         {
            _loc6_ = new DefendBuildLevel();
            _loc6_.AntiaircraftGunNum = _loc5_.@AntiaircraftGunNum;
            _loc6_.CostFunds = _loc5_.@CostFunds;
            _loc6_.CostHelium_3 = _loc5_.@CostHelium_3;
            _loc6_.CostMetal = _loc5_.@CostMetal;
            _loc6_.DependSpaceStation = _loc5_.@DependSpaceStation;
            _loc6_.ImageName = _loc5_.@ImageName;
            _loc6_.LevelComment = _loc5_.@LevelComment;
            _loc6_.LevelID = _loc5_.@LevelID;
            _loc6_.MeteorNum = _loc5_.@MeteorNum;
            _loc6_.OccupationSpace = _loc5_.@OccupationSpace;
            _loc6_.ParticleCannonNum = _loc5_.@ParticleCannonNum;
            _loc6_.RepairCost = _loc5_.@RepairCost;
            _loc6_.RepairTime = _loc5_.@RepairTime;
            _loc6_.ThorCannonNum = _loc5_.@ThorCannonNum;
            _loc6_.needTime = _loc5_.@Time;
            _loc6_.AttackRange = _loc5_.@AttackRange;
            return _loc6_;
         }
         _loc7_ = new EquimentLevel();
         _loc7_.LevelID = _loc5_.@LevelID;
         _loc7_.needTime = _loc5_.@Time;
         _loc7_.CostHelium_3 = _loc5_.@CostHelium_3;
         _loc7_.CostMetal = _loc5_.@CostMetal;
         _loc7_.CostFunds = _loc5_.@CostFunds;
         _loc7_.CostCash = _loc5_.@CostCash;
         _loc7_.MostMoney = _loc5_.@MostMoney;
         _loc7_.ImageName = _loc5_.@ImageName;
         _loc7_.OutHelium_3 = _loc5_.@OutHelium_3;
         _loc7_.OutMetal = _loc5_.@OutMetal;
         _loc7_.OutMoney = _loc5_.@OutMoney;
         _loc7_.OccupationSpace = _loc5_.@OccupationSpace;
         _loc7_.CommanderNum = _loc5_.@CommanderNum;
         _loc7_.Dependbuilding = _loc5_.@Dependbuilding;
         _loc7_.DecreaseTax = _loc5_.@Tax;
         _loc7_.ResourceRecycle = _loc5_.@ResourceRecycle;
         if(param1 == EquimentTypeEnum.EQUIMENT_TYPE_CIVICISM)
         {
            _loc8_ = new CivicismLevel();
            _loc8_.AlliancecenterNum = _loc5_.@AlliancecenterNum;
            _loc8_.MetalResNum = _loc5_.@MetalResourcesNum;
            _loc8_.He3ResNum = _loc5_.@He3ResourcesNum;
            _loc8_.ComponentNum = _loc5_.@ComponentNum;
            _loc8_.LeadercenterNum = _loc5_.@LeadercenterNum;
            _loc8_.HouseNum = _loc5_.@HouseNum;
            _loc8_.ShipyardNum = _loc5_.@ShipyardNum;
            _loc8_.StorageNum = _loc5_.@StorageNum;
            _loc8_.TechNum = _loc5_.@TechNum;
            _loc8_.TradecenterNum = _loc5_.@TradecenterNum;
            _loc8_.SynthesisNum = _loc5_.@SynthesisNum;
            _loc8_.RaderNum = _loc5_.@RaderNum;
            _loc8_.ShipReclaimNum = _loc5_.@ShipReclaimNum;
            _loc8_.Dependbuilding = _loc5_.@Dependbuilding;
            _loc7_.civicismLevel = _loc8_;
         }
         else if(param1 == EquimentTypeEnum.EQUIMENT_TYPE_SHIPBUILDING)
         {
            _loc9_ = new ShipBuildingLevel();
            _loc9_.ShipProductionQueue = _loc5_.@ShipProductionQueue;
            _loc9_.IncreaseShipProduce = _loc5_.@IncreaseShipProduce;
            _loc7_.shipBuild = _loc9_;
         }
         return _loc7_;
      }
      
      private function parserToPointKit(param1:String) : PointKit
      {
         var _loc2_:PointKit = new PointKit();
         var _loc3_:Array = param1.split(",");
         _loc2_.x = _loc3_[0];
         _loc2_.y = _loc3_[1];
         return _loc2_;
      }
   }
}

