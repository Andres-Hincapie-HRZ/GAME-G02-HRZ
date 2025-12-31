package logic.entry.blurprint
{
   public class DefendBuildLevel extends Level
   {
      
      public var ParticleCannonNum:int;
      
      public var MeteorNum:int;
      
      public var AntiaircraftGunNum:int;
      
      public var ThorCannonNum:int;
      
      public var RepairCost:int;
      
      public var RepairTime:int;
      
      public var DependSpaceStation:int;
      
      public var AttackRange:String;
      
      public function DefendBuildLevel()
      {
         super();
         this.ParticleCannonNum = -1;
         this.MeteorNum = -1;
         this.AntiaircraftGunNum = -1;
         this.ThorCannonNum = -1;
         this.RepairCost = -1;
         this.RepairTime = -1;
         this.DependSpaceStation = -1;
         this.AttackRange = null;
      }
   }
}

