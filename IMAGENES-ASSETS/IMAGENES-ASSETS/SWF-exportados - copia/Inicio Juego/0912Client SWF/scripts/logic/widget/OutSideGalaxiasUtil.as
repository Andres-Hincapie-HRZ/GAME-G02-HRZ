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
         var _loc2_:PointKit = new PointKit();
         if(param1 == null)
         {
            return _loc2_;
         }
         if(param1.target.name == "mc_mask")
         {
            if(ConstructionAction.currentTarget)
            {
               _loc2_.x = ConstructionAction.currentTarget.EquimentInfoData.PosX;
               _loc2_.y = ConstructionAction.currentTarget.EquimentInfoData.PosY;
            }
            return _loc2_;
         }
         var _loc3_:Number = GameSetting.MAP_OUTSIDE_GRID_WIDTH;
         var _loc4_:Number = GameSetting.MAP_OUTSIDE_GRID_HEIGHT;
         var _loc5_:Number = -_loc4_ / _loc3_;
         var _loc6_:Number = _loc4_ * GameSetting.MAP_OUTSIDE_GRID_NUMBER * 0.5;
         var _loc7_:Number = Math.sqrt(_loc3_ * 0.5 * (_loc3_ * 0.5) + _loc4_ * 0.5 * (_loc4_ * 0.5));
         var _loc8_:Number = param1.localY - _loc5_ * param1.localX;
         var _loc9_:int = Math.floor((_loc8_ - _loc6_) / _loc7_);
         _loc5_ = _loc4_ / _loc3_;
         _loc8_ = param1.localY - _loc5_ * param1.localX;
         var _loc10_:int = Math.floor((_loc8_ + _loc6_) / _loc7_);
         _loc2_.x = _loc9_;
         _loc2_.y = _loc10_;
         return _loc2_;
      }
      
      public static function getPosition2(param1:Number, param2:Number) : PointKit
      {
         var _loc3_:PointKit = new PointKit();
         var _loc4_:Number = GameSetting.MAP_OUTSIDE_GRID_WIDTH;
         var _loc5_:Number = GameSetting.MAP_OUTSIDE_GRID_HEIGHT;
         var _loc6_:Number = -_loc5_ / _loc4_;
         var _loc7_:Number = _loc5_ * GameSetting.MAP_OUTSIDE_GRID_NUMBER * 0.5;
         var _loc8_:Number = Math.sqrt(_loc4_ * 0.5 * (_loc4_ * 0.5) + _loc5_ * 0.5 * (_loc5_ * 0.5));
         var _loc9_:Number = param2 - _loc6_ * param1;
         var _loc10_:int = Math.floor((_loc9_ - _loc7_) / _loc8_);
         _loc6_ = _loc5_ / _loc4_;
         _loc9_ = param2 - _loc6_ * param1;
         var _loc11_:int = Math.floor((_loc9_ + _loc7_) / _loc8_);
         _loc3_.x = _loc10_;
         _loc3_.y = _loc11_;
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

