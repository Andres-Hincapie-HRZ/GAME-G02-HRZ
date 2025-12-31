package logic.widget
{
   import com.star.frameworks.geom.PointKit;
   import flash.events.MouseEvent;
   import logic.action.ConstructionAction;
   import logic.game.GameSetting;
   
   public class OutSideGalaxiasUtil
   {
      
      public function OutSideGalaxiasUtil()
      {
         super();
      }
      
      public static function getMapXY(param1:int) : PointKit
      {
         var _loc2_:PointKit = null;
         var _loc3_:int = 0;
         _loc2_ = new PointKit();
         _loc3_ = Math.sqrt(Number(param1));
         var _loc4_:int = param1 - _loc3_ * _loc3_;
         if(_loc3_ > _loc4_)
         {
            _loc2_.x = _loc3_;
            _loc2_.y = _loc4_;
         }
         else
         {
            _loc2_.y = _loc3_;
            _loc2_.x = _loc4_ - _loc3_;
         }
         return _loc2_;
      }
      
      public static function GetMapValue(param1:int, param2:int) : int
      {
         var _loc3_:int = 0;
         if(param1 > param2)
         {
            _loc3_ = param1 * param1 + param2;
         }
         else
         {
            _loc3_ = param2 * param2 + param2 + param1;
         }
         return _loc3_;
      }
      
      public static function getPosition(param1:MouseEvent) : PointKit
      {
         var _loc2_:PointKit = null;
         if(param1 == null)
         {
            return _loc2_;
         }
         if(param1.target.name == "mc_mask")
         {
            if(ConstructionAction.currentTarget)
            {
               _loc2_ = new PointKit();
               _loc2_.x = ConstructionAction.currentTarget.EquimentInfoData.PosX;
               _loc2_.y = ConstructionAction.currentTarget.EquimentInfoData.PosY;
               return _loc2_;
            }
         }
         return getPosition2(param1.localX,param1.localY);
      }
      
      public static function getPosition2(param1:Number, param2:Number) : PointKit
      {
         var _loc3_:PointKit = new PointKit();
         var _loc4_:Number = GameSetting.MAP_OUTSIDE_GRID_WIDTH;
         var _loc5_:Number = GameSetting.MAP_OUTSIDE_GRID_HEIGHT;
         var _loc6_:int = Math.floor(param1 / _loc4_ + param2 / _loc5_ - GameSetting.MAP_OUTSIDE_GRID_NUMBER2);
         var _loc7_:int = Math.floor(param2 / _loc5_ - param1 / _loc4_ + GameSetting.MAP_OUTSIDE_GRID_NUMBER2);
         _loc3_.x = _loc6_;
         _loc3_.y = _loc7_;
         return _loc3_;
      }
      
      public static function getLocalXY(param1:PointKit) : PointKit
      {
         var _loc2_:int = GameSetting.MAP_OUTSIDE_GRID_WIDTH * 0.5 * (GameSetting.MAP_OUTSIDE_GRID_NUMBER - param1.y + param1.x);
         var _loc3_:int = GameSetting.MAP_OUTSIDE_GRID_HEIGHT * 0.5 * (param1.x + param1.y + 1);
         return new PointKit(_loc2_,_loc3_);
      }
   }
}

