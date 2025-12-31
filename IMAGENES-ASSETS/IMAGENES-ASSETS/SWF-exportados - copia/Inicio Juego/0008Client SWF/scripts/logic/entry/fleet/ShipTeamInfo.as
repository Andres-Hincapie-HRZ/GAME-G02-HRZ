package logic.entry.fleet
{
   public class ShipTeamInfo
   {
      
      public var ShipModelId:Array = new Array(9);
      
      public var Num:Array = new Array(9);
      
      public var Locomotivity:Array = new Array(9);
      
      public function ShipTeamInfo()
      {
         super();
         var _loc1_:int = 0;
         while(_loc1_ < 9)
         {
            this.ShipModelId[_loc1_] = -1;
            this.Num[_loc1_] = -1;
            this.Locomotivity[_loc1_] = 0;
            _loc1_++;
         }
      }
   }
}

