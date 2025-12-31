package logic.widget
{
   import com.star.frameworks.geom.PointKit;
   import com.star.frameworks.utils.ObjectUtil;
   import logic.action.OutSideGalaxiasAction;
   import logic.game.GameSetting;
   
   public class AttackRangeUtil
   {
      
      private static var instance:AttackRangeUtil;
      
      private static const HV_COST:int = 2;
      
      private static const SLANT_COST:int = 1;
      
      private var _startPoint:PointKit;
      
      private var _outSideGrid:Array;
      
      private var _resultList:Array;
      
      private var _range:int;
      
      private var outSideAction:OutSideGalaxiasAction;
      
      public function AttackRangeUtil()
      {
         super();
         this._outSideGrid = new Array();
         this._resultList = new Array();
         this.outSideAction = OutSideGalaxiasAction.getInstance();
      }
      
      public static function getInstance() : AttackRangeUtil
      {
         if(instance == null)
         {
            instance = new AttackRangeUtil();
         }
         return instance;
      }
      
      public function get StartPoint() : PointKit
      {
         return this._startPoint;
      }
      
      public function get Range() : int
      {
         return this._range;
      }
      
      private function getOutSideGrid(param1:int, param2:int) : Object
      {
         return this.outSideAction.getGridObject(param1,param2);
      }
      
      private function resetGridList() : void
      {
         var _loc1_:Object = null;
         for each(_loc1_ in this._outSideGrid)
         {
            _loc1_.distance = -1;
            _loc1_.isCover = false;
         }
      }
      
      public function Find(param1:PointKit, param2:int) : void
      {
         if(Boolean(this._startPoint) && this._startPoint.equels(param1))
         {
            return;
         }
         if(this._startPoint)
         {
            this.Clear();
         }
         this._startPoint = param1;
         this._range = param2;
         var _loc3_:Object = this.getOutSideGrid(this._startPoint.x,this._startPoint.y);
         _loc3_.distance = this._range;
         if(this._outSideGrid.length)
         {
            ObjectUtil.ClearArray(this._outSideGrid);
         }
         this.getBoundGridList(this._startPoint);
         if(this._outSideGrid == null || this._outSideGrid.length == 0)
         {
            this.Clear();
            return;
         }
         this.Iterative();
         this.Filter();
      }
      
      private function Iterative() : void
      {
         var _loc2_:Object = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._range)
         {
            for each(_loc2_ in this._outSideGrid)
            {
               if(_loc2_.distance > 0)
               {
                  this.getBoundGridList(new PointKit(_loc2_.px,_loc2_.py));
               }
            }
            _loc1_++;
         }
      }
      
      public function cloneResult() : Array
      {
         return this._resultList.concat();
      }
      
      private function Filter() : void
      {
         var _loc1_:Object = null;
         for each(_loc1_ in this._outSideGrid)
         {
            if(this._resultList.indexOf(_loc1_) == -1 && this.getOutSideGrid(this._startPoint.x,this._startPoint.y) != _loc1_)
            {
               this._resultList.push(_loc1_);
            }
         }
         ObjectUtil.ClearArray(this._outSideGrid);
      }
      
      private function getBoundGridList(param1:PointKit) : void
      {
         var _loc5_:Object = null;
         var _loc6_:int = 0;
         var _loc2_:Array = new Array();
         var _loc3_:int = param1.x;
         var _loc4_:int = param1.y;
         if(this.CheckIsValid(param1))
         {
            _loc5_ = this.getOutSideGrid(param1.x,param1.y);
            if(this.CheckIsValid(new PointKit(_loc3_ - 1,_loc4_)))
            {
               if(!this.IsExists(_loc3_ - 1,_loc4_))
               {
                  if(_loc5_.distance)
                  {
                     this.getOutSideGrid(_loc3_ - 1,_loc4_).distance = _loc5_.distance - AttackRangeUtil.SLANT_COST;
                     this.getOutSideGrid(_loc3_ - 1,_loc4_).isCover = true;
                     this.getOutSideGrid(_loc3_ - 1,_loc4_).father = _loc5_;
                     _loc2_.push(this.getOutSideGrid(_loc3_ - 1,_loc4_));
                  }
               }
            }
            if(this.CheckIsValid(new PointKit(_loc3_,_loc4_ + 1)))
            {
               if(!this.IsExists(_loc3_,_loc4_ + 1))
               {
                  if(_loc5_.distance)
                  {
                     this.getOutSideGrid(_loc3_,_loc4_ + 1).distance = _loc5_.distance - AttackRangeUtil.SLANT_COST;
                     this.getOutSideGrid(_loc3_,_loc4_ + 1).isCover = true;
                     this.getOutSideGrid(_loc3_,_loc4_ + 1).father = _loc5_;
                     _loc2_.push(this.getOutSideGrid(_loc3_,_loc4_ + 1));
                  }
               }
            }
            if(this.CheckIsValid(new PointKit(_loc3_,_loc4_ - 1)))
            {
               if(!this.IsExists(_loc3_,_loc4_ - 1))
               {
                  if(_loc5_.distance)
                  {
                     this.getOutSideGrid(_loc3_,_loc4_ - 1).distance = _loc5_.distance - AttackRangeUtil.SLANT_COST;
                     this.getOutSideGrid(_loc3_,_loc4_ - 1).isCover = true;
                     this.getOutSideGrid(_loc3_,_loc4_ - 1).father = _loc5_;
                     _loc2_.push(this.getOutSideGrid(_loc3_,_loc4_ - 1));
                  }
               }
            }
            if(this.CheckIsValid(new PointKit(_loc3_ + 1,_loc4_)))
            {
               if(!this.IsExists(_loc3_ + 1,_loc4_))
               {
                  if(_loc5_.distance)
                  {
                     this.getOutSideGrid(_loc3_ + 1,_loc4_).distance = _loc5_.distance - AttackRangeUtil.SLANT_COST;
                     this.getOutSideGrid(_loc3_ + 1,_loc4_).isCover = true;
                     this.getOutSideGrid(_loc3_ + 1,_loc4_).father = _loc5_;
                     _loc2_.push(this.getOutSideGrid(_loc3_ + 1,_loc4_));
                  }
               }
            }
            _loc6_ = _loc5_.distance - AttackRangeUtil.HV_COST;
            if(_loc6_ > 0)
            {
               if(this.CheckIsValid(new PointKit(_loc3_ - 1,_loc4_ + 1)))
               {
                  if(!this.IsExists(_loc3_ - 1,_loc4_ + 1))
                  {
                     if(_loc5_.distance > 1)
                     {
                        this.getOutSideGrid(_loc3_ - 1,_loc4_ + 1).distance = _loc5_.distance - AttackRangeUtil.HV_COST;
                        this.getOutSideGrid(_loc3_ - 1,_loc4_ + 1).isCover = true;
                        this.getOutSideGrid(_loc3_ - 1,_loc4_ + 1).father = _loc5_;
                        _loc2_.push(this.getOutSideGrid(_loc3_ - 1,_loc4_ + 1));
                     }
                  }
               }
               if(this.CheckIsValid(new PointKit(_loc3_ + 1,_loc4_ - 1)))
               {
                  if(!this.IsExists(_loc3_ + 1,_loc4_ - 1))
                  {
                     if(_loc5_.distance > 1)
                     {
                        this.getOutSideGrid(_loc3_ + 1,_loc4_ - 1).distance = _loc5_.distance - AttackRangeUtil.HV_COST;
                        this.getOutSideGrid(_loc3_ + 1,_loc4_ - 1).isCover = true;
                        this.getOutSideGrid(_loc3_ + 1,_loc4_ - 1).father = _loc5_;
                        _loc2_.push(this.getOutSideGrid(_loc3_ + 1,_loc4_ - 1));
                     }
                  }
               }
               if(this.CheckIsValid(new PointKit(_loc3_ - 1,_loc4_ - 1)))
               {
                  if(!this.IsExists(_loc3_ - 1,_loc4_ - 1))
                  {
                     if(_loc5_.distance > 1)
                     {
                        this.getOutSideGrid(_loc3_ - 1,_loc4_ - 1).distance = _loc5_.distance - AttackRangeUtil.HV_COST;
                        this.getOutSideGrid(_loc3_ - 1,_loc4_ - 1).isCover = true;
                        this.getOutSideGrid(_loc3_ - 1,_loc4_ - 1).father = _loc5_;
                        _loc2_.push(this.getOutSideGrid(_loc3_ - 1,_loc4_ - 1));
                     }
                  }
               }
               if(this.CheckIsValid(new PointKit(_loc3_ + 1,_loc4_ + 1)))
               {
                  if(!this.IsExists(_loc3_ + 1,_loc4_ + 1))
                  {
                     if(_loc5_.distance > 1)
                     {
                        this.getOutSideGrid(_loc3_ + 1,_loc4_ + 1).distance = _loc5_.distance - AttackRangeUtil.HV_COST;
                        this.getOutSideGrid(_loc3_ + 1,_loc4_ + 1).isCover = true;
                        this.getOutSideGrid(_loc3_ + 1,_loc4_ + 1).father = _loc5_;
                        _loc2_.push(this.getOutSideGrid(_loc3_ + 1,_loc4_ + 1));
                     }
                  }
               }
            }
         }
         this._outSideGrid = this._outSideGrid.concat(_loc2_);
      }
      
      private function applyFilter() : void
      {
         var _loc1_:Object = null;
         for each(_loc1_ in this._resultList)
         {
            OutSideGalaxiasAction.getInstance().FillGraphics(_loc1_.px,_loc1_.py);
         }
      }
      
      private function CheckIsValid(param1:PointKit) : Boolean
      {
         if(param1.x >= 0 && param1.x < GameSetting.MAP_OUTSIDE_GRID_NUMBER && (param1.y >= 0 && param1.y < GameSetting.MAP_OUTSIDE_GRID_NUMBER))
         {
            return true;
         }
         return false;
      }
      
      private function IsExists(param1:int, param2:int) : Boolean
      {
         if(this._outSideGrid == null || this._outSideGrid.length == 0)
         {
            return false;
         }
         return this.getOutSideGrid(param1,param2).distance != -1;
      }
      
      public function Clear() : void
      {
         OutSideGalaxiasAction.getInstance().rePaintRegion();
         this.getOutSideGrid(this._startPoint.x,this._startPoint.y).distance = -1;
         this.resetGridList();
         ObjectUtil.ClearArray(this._resultList);
      }
      
      private function destoryArray(param1:Array) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = param1.pop();
            _loc3_.distance = -1;
            _loc3_ = null;
            _loc2_++;
         }
         param1 = new Array();
      }
   }
}

