package logic.reader
{
   import com.star.frameworks.managers.ResManager;
   import logic.entry.ScienceSystem;
   
   public class CScienceReader
   {
      
      private static var instance:CScienceReader;
      
      private var WeaponTechXML:XML;
      
      private var DefenceTechXML:XML;
      
      private var TechXML:XML;
      
      private var LotteryXML:XML;
      
      public var WeaponTechAry:Array = new Array();
      
      public var weaponarr:Array = new Array();
      
      public var DefenceTechAry:Array = new Array();
      
      public var defencearr:Array = new Array();
      
      public var TechArr:Array = new Array();
      
      public var techarr:Array = new Array();
      
      public var zxpd:Boolean = true;
      
      public var depd:Boolean = true;
      
      public var tepd:Boolean = true;
      
      public var Lotteryarr:Array = new Array();
      
      public function CScienceReader()
      {
         super();
         this.WeaponTechXML = ResManager.getInstance().getXml(ResManager.GAMERES,"WeaponTech");
         this.DefenceTechXML = ResManager.getInstance().getXml(ResManager.GAMERES,"DefenceTech");
         this.TechXML = ResManager.getInstance().getXml(ResManager.GAMERES,"BuildingTech");
         this.LotteryXML = ResManager.getInstance().getXml(ResManager.GAMERES,"Lottery");
         this.getLotteryXML();
      }
      
      public static function getInstance() : CScienceReader
      {
         if(instance == null)
         {
            instance = new CScienceReader();
         }
         return instance;
      }
      
      private function getLotteryXML() : void
      {
         var _loc1_:Object = null;
         var _loc2_:XML = null;
         this.Lotteryarr.length = 0;
         for each(_loc2_ in this.LotteryXML.*)
         {
            _loc1_ = new Object();
            _loc1_.Name = _loc2_.@Name;
            _loc1_.ImageFileName = _loc2_.@ImageFileName;
            _loc1_.Num = _loc2_.@Num;
            _loc1_.Comment = _loc2_.@Comment;
            _loc1_.OrderID = _loc2_.@OrderID;
            this.Lotteryarr.push(_loc1_);
         }
      }
      
      public function getTechXML() : void
      {
         var _loc1_:Object = null;
         var _loc4_:XML = null;
         var _loc5_:Object = null;
         var _loc6_:uint = 0;
         var _loc7_:XML = null;
         if(!this.tepd)
         {
            return;
         }
         this.tepd = false;
         var _loc2_:int = -1;
         this.techarr.length = 0;
         this.TechArr.length = 0;
         var _loc3_:uint = 0;
         while(_loc3_ < 100)
         {
            _loc1_ = new Object();
            this.TechArr.push(_loc1_);
            this.techarr.push(_loc1_);
            _loc3_++;
         }
         for each(_loc4_ in this.TechXML.*)
         {
            _loc2_++;
            _loc1_ = new Object();
            _loc1_.name = _loc4_.@Name;
            _loc1_.kind = _loc4_.@Kind;
            _loc1_.comment = _loc4_.@Comment;
            _loc1_.tech = _loc4_.@Tech;
            _loc1_.imageFileName = _loc4_.@ImageFileName;
            _loc1_.title = _loc4_.@Title;
            _loc1_.TechMemo = _loc4_.@TechMemo;
            this.TechArr.push(_loc1_);
         }
         _loc6_ = 0;
         while(_loc6_ < this.TechArr.length)
         {
            this.techarr[_loc6_] = new Array();
            if(_loc6_ >= 100)
            {
               for each(_loc7_ in this.TechXML.Building[_loc6_ - 100].*)
               {
                  _loc5_ = new Object();
                  _loc5_.TechMemo = " ";
                  _loc5_.Comment = _loc7_.@Comment;
                  _loc5_.Title = _loc7_.@Title;
                  _loc5_.Money = _loc7_.@Money;
                  _loc5_.Time = int(_loc7_.@Time) / (1 + ScienceSystem.getinstance().IncTechPercent * 0.01);
                  _loc5_.TechMemo = _loc7_.@TechMemo;
                  _loc5_.IncreaseBuildQueue = _loc7_.@IncreaseBuildQueue;
                  _loc5_.DecreaseMetalConsume = _loc7_.@DecreaseMetalConsume;
                  _loc5_.DecreaseHe3Consume = _loc7_.@DecreaseHe3Consume;
                  _loc5_.DecreaseMoneyConsume = _loc7_.@DecreaseMoneyConsume;
                  _loc5_.IncreaseBuilding = _loc7_.@IncreaseBuilding;
                  _loc5_.IncreaseMetalOut = _loc7_.@IncreaseMetalOut;
                  _loc5_.IncreaseHe3Out = _loc7_.@IncreaseHe3Out;
                  _loc5_.IncreaseMoneyOut = _loc7_.@IncreaseMoneyOut;
                  _loc5_.IncreaseMetalCapacity = _loc7_.@IncreaseMetalCapacity;
                  _loc5_.IncreaseHe3Capacity = _loc7_.@IncreaseHe3Capacity;
                  _loc5_.IncreaseMoneyCapacity = _loc7_.@IncreaseMoneyCapacity;
                  _loc5_.IncreaseShipBuild = _loc7_.@IncreaseShipBuild;
                  _loc5_.DecreaseShipMetalConsume = _loc7_.@DecreaseShipMetalConsume;
                  _loc5_.DecreaseShipHe3Consume = _loc7_.@DecreaseShipHe3Consume;
                  _loc5_.DecreaseShipMoneyConsume = _loc7_.@DecreaseShipMoneyConsume;
                  this.techarr[_loc6_].push(_loc5_);
                  this.techarr.push(this.techarr[_loc6_]);
               }
            }
            _loc6_++;
         }
      }
      
      public function getDefenceTechXML() : void
      {
         var _loc1_:Object = null;
         var _loc4_:XML = null;
         var _loc5_:Object = null;
         var _loc6_:uint = 0;
         var _loc7_:XML = null;
         if(!this.depd)
         {
            return;
         }
         this.depd = false;
         var _loc2_:int = -1;
         this.defencearr.length = 0;
         this.DefenceTechAry.length = 0;
         var _loc3_:uint = 0;
         while(_loc3_ < 70)
         {
            _loc1_ = new Object();
            this.DefenceTechAry.push(_loc1_);
            this.defencearr.push(_loc1_);
            _loc3_++;
         }
         for each(_loc4_ in this.DefenceTechXML.*)
         {
            _loc2_++;
            _loc1_ = new Object();
            _loc1_.name = _loc4_.@Name;
            _loc1_.kind = _loc4_.@Kind;
            _loc1_.comment = _loc4_.@Comment;
            _loc1_.tech = _loc4_.@Tech;
            _loc1_.imageFileName = _loc4_.@ImageFileName;
            _loc1_.title = _loc4_.@Title;
            _loc1_.TechMemo = _loc4_.@TechMemo;
            this.DefenceTechAry.push(_loc1_);
         }
         _loc6_ = 0;
         while(_loc6_ < this.DefenceTechAry.length)
         {
            this.defencearr[_loc6_] = new Array();
            if(_loc6_ >= 70)
            {
               for each(_loc7_ in this.DefenceTechXML.List[_loc6_ - 70].*)
               {
                  _loc5_ = new Object();
                  _loc5_.TechMemo = " ";
                  _loc5_.Comment = _loc7_.@Comment;
                  _loc5_.Title = _loc7_.@Title;
                  _loc5_.Money = _loc7_.@Money;
                  _loc5_.Time = int(_loc7_.@Time) / (1 + ScienceSystem.getinstance().IncTechPercent * 0.01);
                  _loc5_.TechMemo = _loc7_.@TechMemo;
                  _loc5_.AddThorNum = _loc7_.@AddThorNum;
                  _loc5_.AddBuiltNum = _loc7_.@AddBuiltNum;
                  _loc5_.DecreaseMetalConsume = _loc7_.@DecreaseMetalConsume;
                  _loc5_.DecreaseHe3Consume = _loc7_.@DecreaseHe3Consume;
                  _loc5_.DecreaseMoneyConsume = _loc7_.@DecreaseMoneyConsume;
                  _loc5_.IncreaseBuilding = _loc7_.@IncreaseBuilding;
                  _loc5_.Endure = _loc7_.@Endure;
                  _loc5_.Shield = _loc7_.@Shield;
                  _loc5_.AddAssault = _loc7_.@AddAssault;
                  _loc5_.AddRange = _loc7_.@AddRange;
                  _loc5_.Yare = _loc7_.@Yare;
                  this.defencearr[_loc6_].push(_loc5_);
                  this.defencearr.push(this.defencearr[_loc6_]);
               }
            }
            _loc6_++;
         }
      }
      
      public function getWeaponTechXML() : void
      {
         var _loc1_:Object = null;
         var _loc3_:XML = null;
         var _loc4_:Object = null;
         var _loc5_:uint = 0;
         var _loc6_:XML = null;
         if(!this.zxpd)
         {
            return;
         }
         this.zxpd = false;
         var _loc2_:int = -1;
         this.weaponarr.length = 0;
         this.WeaponTechAry.length = 0;
         for each(_loc3_ in this.WeaponTechXML.*)
         {
            _loc2_++;
            _loc1_ = new Object();
            _loc1_.name = _loc3_.@Name;
            _loc1_.kind = _loc3_.@Kind;
            _loc1_.comment = _loc3_.@Comment;
            _loc1_.tech = _loc3_.@Tech;
            _loc1_.imageFileName = _loc3_.@ImageFileName;
            _loc1_.title = _loc3_.@Title;
            _loc1_.TechMemo = _loc3_.@TechMemo;
            this.WeaponTechAry.push(_loc1_);
         }
         _loc5_ = 0;
         while(_loc5_ < this.WeaponTechAry.length)
         {
            this.weaponarr[_loc5_] = new Array();
            for each(_loc6_ in this.WeaponTechXML.List[_loc5_].*)
            {
               _loc4_ = new Object();
               _loc4_.TechMemo = " ";
               _loc4_.Comment = _loc6_.@Comment;
               _loc4_.Title = _loc6_.@Title;
               _loc4_.Money = _loc6_.@Money;
               _loc4_.Time = int(_loc6_.@Time) / (1 + ScienceSystem.getinstance().IncTechPercent * 0.01);
               _loc4_.TechMemo = _loc6_.@TechMemo;
               _loc4_.LowCubage = _loc6_.@LowCubage;
               _loc4_.Hit = _loc6_.@Hit;
               _loc4_.BoostCarry = _loc6_.@BoostCarry;
               _loc4_.DecBackfill = _loc6_.@DecBackfill;
               _loc4_.DecHes = _loc6_.@DecHes;
               _loc4_.DecHeadoff = _loc6_.@DecHeadoff;
               _loc4_.Turn = _loc6_.@Turn;
               this.weaponarr[_loc5_].push(_loc4_);
               this.weaponarr.push(this.weaponarr[_loc5_]);
            }
            _loc5_++;
         }
      }
   }
}

