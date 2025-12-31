package logic.entry.blurprint
{
   public class Level
   {
      
      public var LevelID:int;
      
      public var needTime:int;
      
      public var CostMetal:int;
      
      public var CostHelium_3:int;
      
      public var CostFunds:int;
      
      public var CostCash:int;
      
      public var OccupationSpace:String;
      
      public var ImageName:String;
      
      public var Dependbuilding:String;
      
      public var LevelComment:String;
      
      public function Level()
      {
         super();
         this.CostMetal = -1;
         this.CostHelium_3 = -1;
         this.CostFunds = -1;
      }
   }
}

