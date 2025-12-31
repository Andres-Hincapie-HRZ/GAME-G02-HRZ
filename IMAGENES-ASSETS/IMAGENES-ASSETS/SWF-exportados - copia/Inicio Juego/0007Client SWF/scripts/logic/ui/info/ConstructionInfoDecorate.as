package logic.ui.info
{
   public class ConstructionInfoDecorate extends AbstractInfoDecorate
   {
      
      private static var instance:ConstructionInfoDecorate;
      
      public function ConstructionInfoDecorate()
      {
         super();
      }
      
      public static function getInstance() : ConstructionInfoDecorate
      {
         if(instance == null)
         {
            instance = new ConstructionInfoDecorate();
         }
         return instance;
      }
   }
}

