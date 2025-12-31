package logic.widget
{
   import com.star.frameworks.geom.CFilter;
   import com.star.frameworks.managers.StringManager;
   import flash.display.DisplayObject;
   import gs.TweenLite;
   import logic.action.ConstructionAction;
   import logic.entry.Equiment;
   import logic.entry.EquimentTypeEnum;
   import logic.entry.FortificationStar;
   import logic.entry.GamePlayer;
   import logic.entry.StarLevelEntry;
   import logic.entry.blurprint.EquimentBlueprint;
   import logic.reader.CConstructionReader;
   import logic.reader.FortificationStarReader;
   import logic.reader.StarLevelReader;
   
   public class ConstructionUtil
   {
      
      public function ConstructionUtil()
      {
         super();
      }
      
      public static function parserDependBuilding(param1:String) : Array
      {
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc5_:Object = null;
         var _loc6_:String = null;
         var _loc7_:Object = null;
         _loc2_ = Search(param1) == true ? param1.split(";") : [param1];
         var _loc4_:Array = new Array();
         if(_loc2_.length == 1)
         {
            _loc5_ = new Object();
            _loc3_ = _loc2_[0].split(":");
            _loc5_.BuildID = _loc3_[0];
            _loc5_.Lv = int(_loc3_[1]);
            _loc4_.push(_loc5_);
         }
         else
         {
            for each(_loc6_ in _loc2_)
            {
               _loc3_ = _loc6_.split(":");
               _loc7_ = new Object();
               _loc7_.BuildID = _loc3_[0];
               _loc7_.Lv = int(_loc3_[1]);
               _loc4_.push(_loc7_);
            }
         }
         return _loc4_;
      }
      
      public static function getDependStr(param1:Array) : String
      {
         var _loc3_:Object = null;
         var _loc2_:* = "";
         for each(_loc3_ in param1)
         {
            _loc2_ += CConstructionReader.getInstance().Read(_loc3_.BuildID).BuildingName + StringManager.getInstance().getMessageString("BuildingText21") + (_loc3_.Lv + 1);
            _loc2_ += "\n";
         }
         return _loc2_;
      }
      
      public static function filterConstructions(param1:Array) : Array
      {
         var _loc3_:int = 0;
         if(param1 == null || 0 == param1.length)
         {
            return null;
         }
         var _loc2_:Array = new Array();
         for each(_loc3_ in param1)
         {
            if(!(_loc3_ == EquimentTypeEnum.EQUIMENT_TYPE_RESSTORECENTER || _loc3_ == EquimentTypeEnum.EQUIMENT_TYPE_CIVICISM || _loc3_ == EquimentTypeEnum.EQUIMENT_TYPE_SPACESTATION))
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public static function setDependStrFontFormat(param1:Array, param2:String, param3:String = "#ff0000") : String
      {
         var _loc5_:Object = null;
         var _loc6_:* = null;
         if(param2 == null || param2 == "")
         {
            return "";
         }
         var _loc4_:String = "";
         for each(_loc5_ in param1)
         {
            _loc4_ = CConstructionReader.getInstance().Read(_loc5_.BuildID).BuildingName + StringManager.getInstance().getMessageString("BuildingText21") + (_loc5_.Lv + 1);
            if(param2.match(_loc4_))
            {
               _loc6_ = "<font color=\'" + param3 + "\'>" + _loc4_ + "</font>";
               param2 = param2.replace(_loc4_,_loc6_);
            }
         }
         return param2;
      }
      
      public static function rePlace(param1:String, param2:String) : String
      {
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc3_:String = "";
         _loc4_ = Search(param1) == true ? param1.split(";") : [param1];
         _loc5_ = Search(param2) == true ? param2.split(";") : [param2];
         if(_loc4_.length < _loc5_.length)
         {
            return param1;
         }
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_.length)
         {
            if(_loc4_[_loc6_] != undefined)
            {
               _loc4_[_loc6_] += _loc5_[_loc6_] + "\n";
            }
            _loc6_++;
         }
         return _loc3_.concat(_loc4_);
      }
      
      public static function getComment(param1:String) : Array
      {
         var _loc2_:Array = null;
         return Search(param1) == true ? param1.split("#") : [param1];
      }
      
      public static function HaveNextLevel(param1:int) : Boolean
      {
         var _loc3_:EquimentBlueprint = null;
         var _loc2_:Equiment = ConstructionAction.getInstance().getEquiment(param1).Instance as Equiment;
         if(_loc2_)
         {
            _loc3_ = CConstructionReader.getInstance().Read(_loc2_.EquimentInfoData.BuildID);
            return _loc2_.EquimentInfoData.LevelId < _loc3_.MaxLevel;
         }
         return false;
      }
      
      public static function checkConsortBuildingUpgrate(param1:int) : Boolean
      {
         var _loc2_:StarLevelEntry = StarLevelReader.getInstance().Read(param1);
         return GamePlayer.getInstance().currentWealth > _loc2_.needRiches;
      }
      
      public static function checkConsortBuildingUpgrateExpectSpaceStation(param1:int, param2:int) : Boolean
      {
         var _loc3_:FortificationStar = FortificationStarReader.getInstance().Read(param1,param2);
         return GamePlayer.getInstance().currentWealth > _loc3_.Wealth;
      }
      
      public static function checkIsFullLevel(param1:int, param2:int) : Boolean
      {
         if(param1 == EquimentTypeEnum.EQUIMENT_TYPE_SPACESTATION)
         {
            return param2 >= 100;
         }
         var _loc3_:FortificationStar = FortificationStarReader.getInstance().Read(param1,0);
         return param2 >= _loc3_.MaxLevel;
      }
      
      public static function Search(param1:String, param2:String = ";") : Boolean
      {
         if(param1 == null || param1 == "")
         {
            return false;
         }
         if(param1.indexOf(param2) == -1)
         {
            return false;
         }
         return true;
      }
      
      public static function getAttackRangle(param1:int, param2:String) : int
      {
         if(param2 == null || param2 == "")
         {
            return 0;
         }
         if(param2.indexOf("") == -1)
         {
            return 0;
         }
         var _loc3_:Array = param2.split(":");
         if(param1 == EquimentTypeEnum.EQUIMENT_TYPE_THUNDER_GUN)
         {
            return int(_loc3_[0]);
         }
         return int(_loc3_[0]) + parseInt(ConstructionAction.defendTechObj.AddRange);
      }
      
      public static function Animation(param1:DisplayObject, param2:int, param3:int) : void
      {
         TweenLite.to(param1,1,{
            "x":param1.x - param2,
            "y":param1.y - param3
         });
      }
      
      public static function getConstructionByPosXY(param1:int, param2:int) : Equiment
      {
         var _loc4_:Equiment = null;
         var _loc3_:Array = ConstructionAction.outSideContuctionList.Values();
         for each(_loc4_ in _loc3_)
         {
            if(_loc4_.EquimentInfoData.PosX == param1 && Boolean(_loc4_.EquimentInfoData.PosY))
            {
               return _loc4_;
            }
         }
         return null;
      }
      
      public static function getConstructionCount(param1:int, param2:EquimentBlueprint) : int
      {
         var _loc3_:int = 0;
         switch(param1)
         {
            case EquimentTypeEnum.EQUIMENT_TYPE_HELIUM_3:
               _loc3_ = param2.equimentLevel.civicismLevel.He3ResNum;
               break;
            case EquimentTypeEnum.EQUIMENT_TYPE_METAL:
               _loc3_ = param2.equimentLevel.civicismLevel.MetalResNum;
               break;
            case EquimentTypeEnum.EQUIMENT_TYPE_HOMEREGION:
               _loc3_ = param2.equimentLevel.civicismLevel.HouseNum;
               break;
            case EquimentTypeEnum.EQUIMENT_TYPE_RESSTORECENTER:
               _loc3_ = param2.equimentLevel.civicismLevel.StorageNum;
               break;
            case EquimentTypeEnum.EQUIMENT_TYPE_UNION:
               _loc3_ = param2.equimentLevel.civicismLevel.AlliancecenterNum;
               break;
            case EquimentTypeEnum.EQUIMENT_TYPE_SHIPBUILDING:
               _loc3_ = param2.equimentLevel.civicismLevel.ShipyardNum;
               break;
            case EquimentTypeEnum.EQUIMENT_TYPE_COMMANDERCENTER:
               _loc3_ = param2.equimentLevel.civicismLevel.LeadercenterNum;
               break;
            case EquimentTypeEnum.EQUIMENT_TYPE_TECHRESEARCHCENTER:
               _loc3_ = param2.equimentLevel.civicismLevel.TechNum;
               break;
            case EquimentTypeEnum.EQUIMENT_TYPE_COMPOSITIONCENTER:
               _loc3_ = param2.equimentLevel.civicismLevel.SynthesisNum;
               break;
            case EquimentTypeEnum.EQUIMENT_TYPE_TRADEPORT:
               _loc3_ = param2.equimentLevel.civicismLevel.TradecenterNum;
               break;
            case EquimentTypeEnum.EQUIMENT_TYPE_WEAPONRESEARCHCENTER:
               _loc3_ = param2.equimentLevel.civicismLevel.ComponentNum;
               break;
            case EquimentTypeEnum.EQUIMENT_TYPE_SHIPRECAIM:
               _loc3_ = param2.equimentLevel.civicismLevel.ShipReclaimNum;
               break;
            case EquimentTypeEnum.EQUIMENT_TYPE_RADAR:
               _loc3_ = param2.equimentLevel.civicismLevel.RaderNum * (1 + GamePlayer.getInstance().AddBuiltNum);
               break;
            case EquimentTypeEnum.EQUIMENT_TYPE_PARTICLE:
               _loc3_ = param2.defendLevel.ParticleCannonNum * (1 + GamePlayer.getInstance().AddBuiltNum);
               break;
            case EquimentTypeEnum.EQUIMENT_TYPE_METEOR:
               _loc3_ = param2.defendLevel.MeteorNum * (1 + GamePlayer.getInstance().AddBuiltNum);
               break;
            case EquimentTypeEnum.EQUIMENT_TYPE_AIRCRAFT_GUN:
               _loc3_ = param2.defendLevel.AntiaircraftGunNum * (1 + GamePlayer.getInstance().AddBuiltNum);
               break;
            case EquimentTypeEnum.EQUIMENT_TYPE_THUNDER_GUN:
               _loc3_ = param2.defendLevel.ThorCannonNum + GamePlayer.getInstance().AddThorNum;
               break;
            default:
               _loc3_ = 1;
         }
         return _loc3_;
      }
      
      public static function GetConstructionLoadName(param1:int, param2:String) : String
      {
         var _loc3_:int = param2.length;
         if(param1 == EquimentTypeEnum.EQUIMENT_TYPE_HELIUM_3 || param1 == EquimentTypeEnum.EQUIMENT_TYPE_METAL || param1 == EquimentTypeEnum.EQUIMENT_TYPE_RESSTORECENTER || param1 == EquimentTypeEnum.EQUIMENT_TYPE_WEAPONRESEARCHCENTER || param1 == EquimentTypeEnum.EQUIMENT_TYPE_SHIPRECAIM || param1 == EquimentTypeEnum.EQUIMENT_TYPE_CIVICISM || param1 == EquimentTypeEnum.EQUIMENT_TYPE_RADAR || param1 == EquimentTypeEnum.EQUIMENT_TYPE_TECHRESEARCHCENTER || param1 == EquimentTypeEnum.EQUIMENT_TYPE_TRADEPORT || param1 == EquimentTypeEnum.EQUIMENT_TYPE_COMMANDERCENTER || param1 == EquimentTypeEnum.EQUIMENT_TYPE_UNION || param1 == EquimentTypeEnum.EQUIMENT_TYPE_HOMEREGION || param1 == EquimentTypeEnum.EQUIMENT_TYPE_SHIPBUILDING)
         {
            param2 = param2.substr(0,_loc3_ - 1);
         }
         return param2;
      }
      
      public function setRepairState(param1:Equiment, param2:Boolean = true) : void
      {
         var _loc3_:CFilter = null;
         if(param2)
         {
            _loc3_ = new CFilter();
            _loc3_.generate_colorMatrix_filter();
            param1.filters = _loc3_.getFilter(true);
            return;
         }
         param1.filters = null;
      }
   }
}

