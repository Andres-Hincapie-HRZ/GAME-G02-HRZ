package logic.manager
{
   import com.star.frameworks.managers.ResManager;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import logic.action.GalaxyMapAction;
   import logic.entry.FarmlandConfig;
   import logic.entry.GStar;
   
   public class FarmLandMananger
   {
      
      private static var _instance:FarmLandMananger = null;
      
      private var _configList:Array = new Array();
      
      private var _starLevel:int = 6;
      
      private var _selfFarmlands:Array = new Array();
      
      private var _othersFarmlands:Array = new Array();
      
      private var _othersHasRender:Boolean = false;
      
      public function FarmLandMananger(param1:HHH)
      {
         super();
         this.InitData();
      }
      
      public static function get instance() : FarmLandMananger
      {
         if(!_instance)
         {
            _instance = new FarmLandMananger(new HHH());
         }
         return _instance;
      }
      
      private function InitData() : void
      {
         var _loc2_:XML = null;
         var _loc3_:FarmlandConfig = null;
         var _loc1_:XML = ResManager.getInstance().getXml(ResManager.GAMERES,"FarmLand");
         for each(_loc2_ in _loc1_.*)
         {
            _loc3_ = new FarmlandConfig();
            _loc3_._id = _loc2_.@Id;
            _loc3_._level = _loc2_.@Lv;
            _loc3_._posX = _loc2_.@PosX;
            _loc3_._posY = _loc2_.@PosY;
            this._configList.push(_loc3_);
         }
      }
      
      public function getGStarLevel(param1:int) : Array
      {
         var _loc3_:FarmlandConfig = null;
         var _loc2_:Array = new Array();
         for each(_loc3_ in this._configList)
         {
            if(_loc3_._level <= param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function getIntersection(param1:int, param2:int) : Array
      {
         var _loc8_:FarmlandConfig = null;
         var _loc11_:int = 0;
         var _loc3_:GStar = GalaxyManager.instance.getData(param1);
         var _loc4_:GStar = GalaxyManager.instance.getData(param2);
         var _loc5_:Array = this.getGStarLevel(_loc3_.Level);
         var _loc6_:Array = this.getGStarLevel(_loc4_.Level);
         var _loc7_:Array = new Array();
         var _loc9_:Array = new Array();
         var _loc10_:int = 0;
         while(_loc10_ < _loc5_.length)
         {
            _loc8_ = _loc5_[_loc10_] as FarmlandConfig;
            _loc5_[_loc10_] = param1 + _loc8_._posX * GalaxyManager.MAX_MAPAREAGRID + _loc8_._posY;
            _loc10_++;
         }
         _loc10_ = 0;
         while(_loc10_ < _loc6_.length)
         {
            _loc8_ = _loc6_[_loc10_] as FarmlandConfig;
            _loc6_[_loc10_] = param2 + _loc8_._posX * GalaxyManager.MAX_MAPAREAGRID + _loc8_._posY;
            _loc10_++;
         }
         _loc10_ = 0;
         while(_loc10_ < _loc5_.length)
         {
            _loc11_ = 0;
            while(_loc11_ < _loc6_.length)
            {
               if(_loc5_[_loc10_] == _loc6_[_loc11_])
               {
                  _loc9_.push(_loc5_[_loc10_]);
               }
               _loc11_++;
            }
            _loc10_++;
         }
         return _loc9_;
      }
      
      public function RenderFarmland(param1:int, param2:int, param3:GStar, param4:Boolean = false) : void
      {
         var _loc7_:FarmlandConfig = null;
         if(!param4 && this._othersHasRender)
         {
            return;
         }
         var _loc5_:int = param2 + param1 * GalaxyManager.AREAGRIDY * 3;
         var _loc6_:Array = FarmLandMananger.instance.getGStarLevel(param3.Level + 1);
         var _loc8_:int = 0;
         while(_loc8_ < _loc6_.length)
         {
            _loc7_ = _loc6_[_loc8_] as FarmlandConfig;
            FarmLandMananger.instance.RenderOneFarmland(param1 + _loc7_._posX,param2 + _loc7_._posY,param4);
            _loc8_++;
         }
         if(!param4)
         {
            this._othersHasRender = true;
         }
      }
      
      public function RenderOneFarmland(param1:int, param2:int, param3:Boolean = false) : void
      {
         var _loc4_:Shape = new Shape();
         _loc4_.name = "farmland";
         if(param3)
         {
            _loc4_.graphics.beginFill(16777215,0.1);
         }
         else
         {
            _loc4_.graphics.beginFill(16711680,0.1);
         }
         _loc4_.graphics.drawRect(0,0,GalaxyMapAction.ballGridW,GalaxyMapAction.ballGridH);
         _loc4_.graphics.endFill();
         _loc4_.x = param1 * GalaxyMapAction.ballGridW;
         _loc4_.y = param2 * GalaxyMapAction.ballGridH;
         GalaxyMapAction.instance.curMapSprite.addChild(_loc4_);
         if(param3)
         {
            this._selfFarmlands.push(_loc4_);
         }
         else
         {
            this._othersFarmlands.push(_loc4_);
         }
      }
      
      public function RenderMyFarmland(param1:int, param2:int, param3:int) : void
      {
         var _loc5_:FarmlandConfig = null;
         var _loc4_:Array = FarmLandMananger.instance.getGStarLevel(param1 + 1);
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_.length)
         {
            _loc5_ = _loc4_[_loc6_];
            FarmLandMananger.instance.RenderOneFarmland(param2 + _loc5_._posX,param3 + _loc5_._posY,true);
            _loc6_++;
         }
      }
      
      public function RemoverFarmland(param1:Boolean = false) : void
      {
         var _loc2_:Array = null;
         if(param1)
         {
            _loc2_ = this._selfFarmlands;
         }
         else
         {
            _loc2_ = this._othersFarmlands;
         }
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            GalaxyMapAction.instance.curMapSprite.removeChild(_loc2_[_loc3_] as DisplayObject);
            _loc3_++;
         }
         _loc2_.splice(0);
         if(!param1)
         {
            this._othersHasRender = false;
         }
      }
      
      public function setFarmland(param1:int, param2:int) : void
      {
         var _loc3_:Shape = new Shape();
         _loc3_.name = "farmland";
         _loc3_.graphics.beginFill(16777215,0.1);
         _loc3_.graphics.drawRect(0,0,GalaxyMapAction.ballGridW,GalaxyMapAction.ballGridH);
         _loc3_.graphics.endFill();
         _loc3_.x = param1 * GalaxyMapAction.ballGridW;
         _loc3_.y = param2 * GalaxyMapAction.ballGridH;
         GalaxyMapAction.instance.curMapSprite.addChild(_loc3_);
         this._selfFarmlands.push(_loc3_);
      }
      
      public function removeSelfFarmland() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._selfFarmlands.length)
         {
            GalaxyMapAction.instance.curMapSprite.removeChild(this._selfFarmlands[_loc1_] as DisplayObject);
            _loc1_++;
         }
         this._selfFarmlands.splice(0);
      }
      
      public function setOthersFarmland(param1:int, param2:int) : void
      {
         var _loc3_:Shape = new Shape();
         _loc3_.name = "farmland";
         _loc3_.graphics.beginFill(16711680,0.1);
         _loc3_.graphics.drawRect(0,0,GalaxyMapAction.ballGridW,GalaxyMapAction.ballGridH);
         _loc3_.graphics.endFill();
         _loc3_.x = param1 * GalaxyMapAction.ballGridW;
         _loc3_.y = param2 * GalaxyMapAction.ballGridH;
         GalaxyMapAction.instance.curMapSprite.addChild(_loc3_);
         this._othersFarmlands.push(_loc3_);
      }
      
      public function removeOthersFarmland() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._othersFarmlands.length)
         {
            GalaxyMapAction.instance.curMapSprite.removeChild(this._othersFarmlands[_loc1_] as DisplayObject);
            _loc1_++;
         }
         this._othersFarmlands.splice(0);
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
