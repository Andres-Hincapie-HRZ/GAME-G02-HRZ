package logic.manager
{
   import logic.entry.GamePlayer;
   import net.msg.galaxyMap.MSG_HOLDGALAXY_TEMP;
   import net.msg.ship.MSG_SHIPTEAMHOLDGALAXY;
   
   public class HoldGalaxyManager
   {
      
      private static var _instance:HoldGalaxyManager = null;
      
      private var _holdGalaxys:Array = new Array();
      
      public function HoldGalaxyManager(param1:HHH)
      {
         super();
      }
      
      public static function get instance() : HoldGalaxyManager
      {
         if(_instance == null)
         {
            _instance = new HoldGalaxyManager(new HHH());
         }
         return _instance;
      }
      
      public function init(param1:MSG_SHIPTEAMHOLDGALAXY) : void
      {
         var _loc3_:MSG_HOLDGALAXY_TEMP = null;
         this._holdGalaxys.splice(0);
         var _loc2_:int = 0;
         while(_loc2_ < param1.DataLen)
         {
            _loc3_ = param1.Data[_loc2_] as MSG_HOLDGALAXY_TEMP;
            this.holdGalaxys.push(_loc3_);
            _loc2_++;
         }
         GalaxyManager.instance.fresh();
      }
      
      public function isHoldGalaxy(param1:int) : Boolean
      {
         var _loc2_:MSG_HOLDGALAXY_TEMP = null;
         if(GamePlayer.getInstance().galaxyID == param1)
         {
            return true;
         }
         var _loc3_:int = 0;
         while(_loc3_ < this._holdGalaxys.length)
         {
            _loc2_ = this._holdGalaxys[_loc3_];
            if(_loc2_.GalaxyId == param1)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      public function get holdGalaxys() : Array
      {
         return this._holdGalaxys;
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
