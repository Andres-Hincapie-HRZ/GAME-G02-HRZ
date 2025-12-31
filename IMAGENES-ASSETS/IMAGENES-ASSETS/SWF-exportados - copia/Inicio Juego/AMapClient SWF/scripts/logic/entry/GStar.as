package logic.entry
{
   public class GStar
   {
      
      public var GalaxyMapId:int = -1;
      
      public var RegionId:uint;
      
      public var ConsortiaName:String = "";
      
      public var UserName:String = "";
      
      public var UserId:Number;
      
      public var GalaxyId:int = -1;
      
      public var Reserve1:int;
      
      public var Reserve2:int;
      
      public var ConsortiaHeadId:int;
      
      public var ConsortiaLevelId:int;
      
      public var Type:int = -1;
      
      public var Level:int = -1;
      
      public var Camp:int = -1;
      
      public var Reserve:int = -1;
      
      public var FightFlag:int = 0;
      
      public var LoserFlag:int = 1;
      
      public var StarFace:int;
      
      public function GStar(param1:int = -1, param2:int = -1)
      {
         super();
         this.GalaxyId = param1;
         this.Type = param2;
      }
   }
}

