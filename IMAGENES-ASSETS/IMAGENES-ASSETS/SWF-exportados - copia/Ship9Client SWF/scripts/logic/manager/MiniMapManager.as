package logic.manager
{
   import com.star.frameworks.utils.HashSet;
   import logic.entry.GamePlayer;
   
   public class MiniMapManager
   {
      
      private static var _instance:MiniMapManager = null;
      
      private var _corps:HashSet = new HashSet();
      
      public function MiniMapManager(param1:HHH)
      {
         super();
      }
      
      public static function get instance() : MiniMapManager
      {
         if(!_instance)
         {
            _instance = new MiniMapManager(new HHH());
         }
         return _instance;
      }
      
      public function pushCorps(param1:int) : void
      {
         if(param1 == GamePlayer.getInstance().galaxyID)
         {
            return;
         }
         this._corps.Put(param1 + "",param1);
      }
      
      public function getAllCorps() : Array
      {
         return this._corps.Keys();
      }
   }
}

class HHH
{
   
   public function HHH()
   {
      super();
   }
}
