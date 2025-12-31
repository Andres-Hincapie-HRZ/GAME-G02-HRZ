package
{
   import flash.display.*;
   import flash.text.*;
   import flash.utils.ByteArray;
   
   public class GameRes extends Sprite
   {
      
      private var imgMap:Object = null;
      
      private var xmlMap:Object = null;
      
      private var cssMap:Object = null;
      
      private var fontMap:Object = null;
      
      public var MessageXML:Class = GameRes_MessageXML;
      
      public var TemplateXml:Class = GameRes_TemplateXml;
      
      public var InfoXml:Class = GameRes_InfoXml;
      
      public var CapacityInfoXml:Class = GameRes_CapacityInfoXml;
      
      public var BaseInfoXML:Class = GameRes_BaseInfoXML;
      
      public var ScienceInfoXml:Class = GameRes_ScienceInfoXml;
      
      public var PackInfoXml:Class = GameRes_PackInfoXml;
      
      public var CommanderInfoTipXml:Class = GameRes_CommanderInfoTipXml;
      
      public var ShipModleInfoTipXml:Class = GameRes_ShipModleInfoTipXml;
      
      public var BodyInfoTipXml:Class = GameRes_BodyInfoTipXml;
      
      public var PartInfoTipXml:Class = GameRes_PartInfoTipXml;
      
      public var StarInfoTipXml:Class = GameRes_StarInfoTipXml;
      
      public var ShipTeamInfoTipXml:Class = GameRes_ShipTeamInfoTipXml;
      
      public var CustomTipXml:Class = GameRes_CustomTipXml;
      
      public var LocusTipXml:Class = GameRes_LocusTipXml;
      
      public var StarLevelnfoXml:Class = GameRes_StarLevelnfoXml;
      
      public var BaseStarLevelInfoXml:Class = GameRes_BaseStarLevelInfoXml;
      
      public var PropsInfoTipXml:Class = GameRes_PropsInfoTipXml;
      
      public var GMNotify:Class = GameRes_GMNotify;
      
      private var GameFont:Class = GameRes_GameFont;
      
      public var configCSS:Class = GameRes_configCSS;
      
      public var buildXml:Class = GameRes_buildXml;
      
      public var buildSpeedXml:Class = GameRes_buildSpeedXml;
      
      public var shipBodyXml:Class = GameRes_shipBodyXml;
      
      public var shipPartXml:Class = GameRes_shipPartXml;
      
      public var propsXml:Class = GameRes_propsXml;
      
      public var LotteryXml:Class = GameRes_LotteryXml;
      
      public var corpsXml:Class = GameRes_corpsXml;
      
      public var CommanderXml:Class = GameRes_CommanderXml;
      
      public var DefenceTechXml:Class = GameRes_DefenceTechXml;
      
      public var LevelsXml:Class = GameRes_LevelsXml;
      
      public var WeaponTechXml:Class = GameRes_WeaponTechXml;
      
      public var BuildingTechXml:Class = GameRes_BuildingTechXml;
      
      public var OthersXml:Class = GameRes_OthersXml;
      
      public var GalaxyMapXml:Class = GameRes_GalaxyMapXml;
      
      public var StarLevelXml:Class = GameRes_StarLevelXml;
      
      public var FieldResourceXml:Class = GameRes_FieldResourceXml;
      
      public var CorpsShopXml:Class = GameRes_CorpsShopXml;
      
      public var ShipModelXml:Class = GameRes_ShipModelXml;
      
      public var FortificationXml:Class = GameRes_FortificationXml;
      
      public var RacingRewardXml:Class = GameRes_RacingRewardXml;
      
      public var FarmLandXml:Class = GameRes_FarmLandXml;
      
      public var InstanceXml:Class = GameRes_InstanceXml;
      
      public var InstanceChallenge:Class = GameRes_InstanceChallenge;
      
      public var InstanceTipXml:Class = GameRes_InstanceTipXml;
      
      public var FortificationStarXml:Class = GameRes_FortificationStarXml;
      
      public var MainTaskXml:Class = GameRes_MainTaskXml;
      
      public var ExtendTaskXml:Class = GameRes_ExtendTaskXml;
      
      public var DailyTaskXml:Class = GameRes_DailyTaskXml;
      
      public var DailyAwardXml:Class = GameRes_DailyAwardXml;
      
      public var GalaxyMapDirtXml:Class = GameRes_GalaxyMapDirtXml;
      
      public var CorpsPirateXml:Class = GameRes_CorpsPirateXml;
      
      public var PirateInfoTipXml:Class = GameRes_PirateInfoTipXml;
      
      public var StageModeXml:Class = GameRes_StageModeXml;
      
      public var InstanceConstellationsXml:Class = GameRes_InstanceConstellationsXml;
      
      public var FlagshipXML:Class = GameRes_FlagshipXML;
      
      public var CmosLotteryXML:Class = GameRes_CmosLotteryXML;
      
      public var BattleShopXML:Class = GameRes_BattleShopXML;
      
      public function GameRes()
      {
         super();
         this.cssMap = new Object();
         var _loc1_:ByteArray = new this.configCSS() as ByteArray;
         this.cssMap["Base"] = new StyleSheet();
         this.cssMap["Base"].parseCSS(_loc1_.toString());
         this.fontMap = new Object();
         this.fontMap["GameFont"] = this.GameFont;
         Font.registerFont(this.GameFont);
         this.imgMap = new Object();
         this.xmlMap = new Object();
         this.xmlMap["Build"] = XML(this.buildXml.data);
         this.xmlMap["buildSpeed"] = XML(this.buildSpeedXml.data);
         this.xmlMap["ShipBody"] = XML(this.shipBodyXml.data);
         this.xmlMap["ShipPart"] = XML(this.shipPartXml.data);
         this.xmlMap["Commander"] = XML(this.CommanderXml.data);
         this.xmlMap["Message"] = XML(this.MessageXML.data);
         this.xmlMap["Template"] = XML(this.TemplateXml.data);
         this.xmlMap["Info"] = XML(this.InfoXml.data);
         this.xmlMap["ScienceInfo"] = XML(this.ScienceInfoXml.data);
         this.xmlMap["PackInfo"] = XML(this.PackInfoXml.data);
         this.xmlMap["BaseInfo"] = XML(this.BaseInfoXML.data);
         this.xmlMap["Message"] = XML(this.MessageXML.data);
         this.xmlMap["DefenceTech"] = XML(this.DefenceTechXml.data);
         this.xmlMap["WeaponTech"] = XML(this.WeaponTechXml.data);
         this.xmlMap["Levels"] = XML(this.LevelsXml.data);
         this.xmlMap["CapacityInfo"] = XML(this.CapacityInfoXml.data);
         this.xmlMap["Levels"] = XML(this.LevelsXml.data);
         this.xmlMap["BuildingTech"] = XML(this.BuildingTechXml.data);
         this.xmlMap["Props"] = XML(this.propsXml.data);
         this.xmlMap["Lottery"] = XML(this.LotteryXml.data);
         this.xmlMap["Corps"] = XML(this.corpsXml.data);
         this.xmlMap["CommanderInfoTip"] = XML(this.CommanderInfoTipXml.data);
         this.xmlMap["ShipModleInfoTip"] = XML(this.ShipModleInfoTipXml.data);
         this.xmlMap["BodyInfoTip"] = XML(this.BodyInfoTipXml.data);
         this.xmlMap["PartInfoTip"] = XML(this.PartInfoTipXml.data);
         this.xmlMap["Others"] = XML(this.OthersXml.data);
         this.xmlMap["StarInfoTip"] = XML(this.StarInfoTipXml.data);
         this.xmlMap["ShipTeamInfoTip"] = XML(this.ShipTeamInfoTipXml.data);
         this.xmlMap["CustomTip"] = XML(this.CustomTipXml.data);
         this.xmlMap["GalaxyMap"] = XML(this.GalaxyMapXml.data);
         this.xmlMap["StarLevel"] = XML(this.StarLevelXml.data);
         this.xmlMap["StarLevelnfo"] = XML(this.StarLevelnfoXml.data);
         this.xmlMap["BaseStarLevelInfo"] = XML(this.BaseStarLevelInfoXml.data);
         this.xmlMap["FarmLand"] = XML(this.FarmLandXml.data);
         this.xmlMap["Instance"] = XML(this.InstanceXml.data);
         this.xmlMap["InstanceChallenge"] = XML(this.InstanceChallenge.data);
         this.xmlMap["InstanceTip"] = XML(this.InstanceTipXml.data);
         this.xmlMap["FortificationStar"] = XML(this.FortificationStarXml.data);
         this.xmlMap["MainTask"] = XML(this.MainTaskXml.data);
         this.xmlMap["ExtendTask"] = XML(this.ExtendTaskXml.data);
         this.xmlMap["PropsInfoTip"] = XML(this.PropsInfoTipXml.data);
         this.xmlMap["FieldResource"] = XML(this.FieldResourceXml.data);
         this.xmlMap["DailyTask"] = XML(this.DailyTaskXml.data);
         this.xmlMap["DailyAward"] = XML(this.DailyAwardXml.data);
         this.xmlMap["GalaxyMapDirt"] = XML(this.GalaxyMapDirtXml.data);
         this.xmlMap["CorpsShop"] = XML(this.CorpsShopXml.data);
         this.xmlMap["ShipModel"] = XML(this.ShipModelXml.data);
         this.xmlMap["GMNotify"] = XML(this.GMNotify.data);
         this.xmlMap["Fortification"] = XML(this.FortificationXml.data);
         this.xmlMap["CorpsPirate"] = XML(this.CorpsPirateXml.data);
         this.xmlMap["PirateInfoTip"] = XML(this.PirateInfoTipXml.data);
         this.xmlMap["LocusTip"] = XML(this.LocusTipXml.data);
         this.xmlMap["StageMode"] = XML(this.StageModeXml.data);
         this.xmlMap["InstanceConstellations"] = XML(this.InstanceConstellationsXml.data);
         this.xmlMap["Flagship"] = XML(this.FlagshipXML.data);
         this.xmlMap["CmosLottery"] = XML(this.CmosLotteryXML.data);
         this.xmlMap["BattleShop"] = XML(this.BattleShopXML.data);
         this.xmlMap["RacingReward"] = XML(this.RacingRewardXml.data);
      }
      
      public function getImg(param1:String) : Class
      {
         return this.imgMap[param1];
      }
      
      public function getXml(param1:String) : XML
      {
         return this.xmlMap[param1] as XML;
      }
      
      public function removeXML(param1:String) : void
      {
         delete this.xmlMap[param1];
         this.xmlMap[param1] = null;
      }
      
      public function getCss(param1:String) : StyleSheet
      {
         return this.cssMap[param1] as StyleSheet;
      }
      
      public function getFont(param1:String) : *
      {
         return this.fontMap[param1];
      }
   }
}

