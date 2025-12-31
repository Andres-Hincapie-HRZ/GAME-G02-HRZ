package logic.entry.blurprint
{
   public class EquimentLevel extends Level
   {
      
      public var civicismLevel:CivicismLevel;
      
      public var shipBuild:ShipBuildingLevel;
      
      public var OutHelium_3:int;
      
      public var OutMetal:int;
      
      public var OutMoney:int;
      
      public var MostMoney:int;
      
      public var MostHelium_3:int;
      
      public var MostMetal:int;
      
      public var CommanderNum:int;
      
      public var DecreaseTax:int;
      
      public var ResourceRecycle:int;
      
      public function EquimentLevel()
      {
         super();
         this.civicismLevel = null;
         this.shipBuild = null;
         this.DecreaseTax = 0;
      }
   }
}

