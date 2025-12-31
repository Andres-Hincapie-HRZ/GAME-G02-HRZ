package logic.entry
{
   public class EquimentData
   {
      
      public var IndexId:int;
      
      public var StarId:int;
      
      public var BuildID:int;
      
      public var BuildName:String;
      
      public var LevelId:int;
      
      public var needTime:int;
      
      public var ConsortiaLeader:int;
      
      public var GalaxyId:int;
      
      public var GalaxyMapId:int;
      
      public var PosX:int;
      
      public var PosY:int;
      
      public var MaxEndure:uint;
      
      public var Endure:uint;
      
      public function EquimentData()
      {
         super();
         this.IndexId = -1;
         this.StarId = -1;
         this.BuildID = -1;
         this.BuildName = null;
         this.LevelId = -1;
         this.needTime = -1;
         this.ConsortiaLeader = -1;
         this.GalaxyId = -1;
         this.GalaxyMapId = -1;
         this.PosX = 0;
         this.PosY = 0;
      }
   }
}

