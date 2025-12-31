package logic.ui
{
   public class FleetInfoUI_Router
   {
      
      public static var ShowFleetInfoFunction:Function;
      
      public function FleetInfoUI_Router()
      {
         super();
      }
      
      public static function Show(param1:int) : void
      {
         if(ShowFleetInfoFunction != null)
         {
            ShowFleetInfoFunction(param1);
            ShowFleetInfoFunction = null;
         }
      }
   }
}

