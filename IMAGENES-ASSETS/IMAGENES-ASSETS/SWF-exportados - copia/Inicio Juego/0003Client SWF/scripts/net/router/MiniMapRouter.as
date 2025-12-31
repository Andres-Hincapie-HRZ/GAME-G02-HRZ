package net.router
{
   import flash.utils.ByteArray;
   import logic.action.GalaxyMapAction;
   import logic.manager.GalaxyManager;
   import logic.manager.MiniMapManager;
   import logic.ui.TransforingUI;
   import net.base.NetManager;
   import net.msg.miniMap.MSG_RESP_CONSORTIASTAR;
   import net.msg.miniMap.MSG_RESP_MAPBLOCK;
   import net.msg.miniMap.MSG_RESP_MAPBLOCKFIGHT;
   import net.msg.miniMap.MSG_RESP_MAPBLOCKUSERINFO;
   
   public class MiniMapRouter
   {
      
      private static var _instance:MiniMapRouter = null;
      
      public function MiniMapRouter(param1:HHH)
      {
         super();
      }
      
      public static function resp_MSG_RESP_MAPBLOCK(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_MAPBLOCK = new MSG_RESP_MAPBLOCK();
         NetManager.Instance().readObject(_loc4_,param3);
         GalaxyManager.maxArea = _loc4_.BlockCount;
         GalaxyMapAction.instance.Init();
      }
      
      public static function resp_MSG_RESP_CONSORTIASTAR(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_CONSORTIASTAR = new MSG_RESP_CONSORTIASTAR();
         NetManager.Instance().readObject(_loc4_,param3);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.DataLen)
         {
            MiniMapManager.instance.pushCorps(_loc4_.Data[_loc5_]);
            _loc5_++;
         }
      }
      
      public static function resp_MSG_RESP_MAPBLOCKFIGHT(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_MAPBLOCKFIGHT = new MSG_RESP_MAPBLOCKFIGHT();
         NetManager.Instance().readObject(_loc4_,param3);
         var _loc5_:Array = new Array();
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_.DataLen)
         {
            _loc5_.push(_loc4_.Data[_loc6_]);
            _loc6_++;
         }
         TransforingUI.instance.freshMiniMap(_loc5_);
      }
      
      public static function resp_MSG_RESP_MAPBLOCKUSERINFO(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_MAPBLOCKUSERINFO = new MSG_RESP_MAPBLOCKUSERINFO();
         NetManager.Instance().readObject(_loc4_,param3);
         TransforingUI.instance.updateMinimapInfo(_loc4_);
      }
      
      public static function get instance() : MiniMapRouter
      {
         if(!_instance)
         {
            _instance = new MiniMapRouter(new HHH());
         }
         return _instance;
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
