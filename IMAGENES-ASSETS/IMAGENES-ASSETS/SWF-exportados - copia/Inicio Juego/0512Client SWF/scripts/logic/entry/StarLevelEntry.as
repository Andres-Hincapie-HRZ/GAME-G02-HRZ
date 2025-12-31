package logic.entry
{
   public class StarLevelEntry
   {
      
      public var buildName:String;
      
      public var level:int;
      
      public var shipNum:int;
      
      public var affect:Number;
      
      public var needRiches:int;
      
      public var imageName:String;
      
      public function StarLevelEntry()
      {
         super();
         this.level = -1;
         this.shipNum = 0;
         this.affect = 0;
         this.needRiches = 0;
         this.imageName = null;
      }
   }
}

