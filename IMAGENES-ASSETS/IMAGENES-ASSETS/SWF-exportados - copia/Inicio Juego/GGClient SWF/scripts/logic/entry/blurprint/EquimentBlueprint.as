package logic.entry.blurprint
{
   import com.star.frameworks.geom.PointKit;
   
   public class EquimentBlueprint
   {
      
      public var BuildingID:int = -1;
      
      public var BuildingName:String;
      
      public var BuildingClass:int;
      
      public var BuildingType:int;
      
      public var Comment1:String;
      
      public var UIType:int;
      
      public var MaxLevel:int;
      
      public var InteractiveBoxType:int;
      
      public var react1:PointKit;
      
      public var react2:PointKit;
      
      public var react3:PointKit;
      
      public var react4:PointKit;
      
      public var IconName:String;
      
      public var Center1:PointKit;
      
      public var equimentLevel:EquimentLevel;
      
      public var defendLevel:DefendBuildLevel;
      
      public var Exchange:int;
      
      public function EquimentBlueprint()
      {
         super();
         this.BuildingName = null;
         this.BuildingClass = -1;
         this.BuildingType = -1;
         this.UIType = -1;
         this.MaxLevel = 0;
         this.Comment1 = null;
         this.equimentLevel = null;
         this.defendLevel = null;
      }
   }
}

