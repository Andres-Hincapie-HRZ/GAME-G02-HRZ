package logic.entry
{
   public class FortificationStar
   {
      
      public var BuildingID:int;
      
      public var BuildingName:String;
      
      public var MaxLevel:int;
      
      public var LevelID:int;
      
      public var Defend:int;
      
      public var DefendType:int;
      
      public var Endure:int;
      
      public var Range:int;
      
      public var BackFill:int;
      
      public var AttackType:int;
      
      public var Fly:int;
      
      public var ImageName:String;
      
      public var Comment1:String;
      
      public var LevelComment:String;
      
      public var Wealth:int;
      
      public var InteractiveBoxType:int;
      
      public function FortificationStar()
      {
         super();
         this.BuildingID = -1;
         this.MaxLevel = 0;
         this.LevelID = -1;
         this.Defend = 0;
         this.Endure = 0;
         this.Range = 0;
         this.BackFill = -1;
         this.AttackType = 0;
         this.Fly = -1;
         this.Wealth = -1;
         this.InteractiveBoxType = -1;
      }
   }
}

