package logic.entry.shipmodel
{
   import logic.entry.GamePlayer;
   import logic.entry.ScienceSystem;
   
   public class ShippartInfo
   {
      
      public var Id:int;
      
      public var FuncTypeId:int;
      
      public var Name:String;
      
      public var KindId:int;
      
      public var KindName:String;
      
      public var GroupID:int;
      
      public var GroupLV:int;
      
      public var Comment:String;
      
      public var Comment2:String;
      
      public var Metal:int;
      
      public var Money:int;
      
      public var He3:int;
      
      public var _Supply:Number;
      
      public var _Cubage:Number;
      
      public var Weight:int;
      
      public var Turn:Number;
      
      public var _MinRange:int;
      
      public var _MaxRange:int;
      
      public var _MinAssault:int;
      
      public var _MaxAssault:int;
      
      public var _Backfill:int;
      
      public var Ratio:int;
      
      public var CreateTime:int;
      
      public var ImageFileName:String;
      
      public var Shield:int;
      
      public var Endure:int;
      
      public var Locomotivity:int;
      
      public var Storage:int;
      
      public var Yare:Number;
      
      public var UnitSupply:int;
      
      public var UpgradeTime:int;
      
      public var UpgradeMoney:int;
      
      public var TransitionTime:int;
      
      public var Limit:int;
      
      public var HurtType:int;
      
      public var First:int;
      
      public var Headoff:Number;
      
      public function ShippartInfo()
      {
         super();
      }
      
      public function get Cubage() : int
      {
         var _loc1_:Number = this._Cubage;
         _loc1_ *= 1 - this.CubageUpgrade;
         return int(_loc1_);
      }
      
      public function set Cubage(param1:int) : void
      {
         this._Cubage = param1;
      }
      
      public function get MinAssault() : int
      {
         var _loc1_:Number = this._MinAssault;
         _loc1_ *= 1 + this.AssaultUpgrade;
         return Math.round(_loc1_);
      }
      
      public function set MinAssault(param1:int) : void
      {
         this._MinAssault = param1;
      }
      
      public function get MaxAssault() : int
      {
         var _loc1_:Number = this._MaxAssault;
         _loc1_ *= 1 + this.AssaultUpgrade;
         return Math.round(_loc1_);
      }
      
      public function set MaxAssault(param1:int) : void
      {
         this._MaxAssault = param1;
      }
      
      public function get MinRange() : int
      {
         return this._MinRange;
      }
      
      public function set MinRange(param1:int) : void
      {
         this._MinRange = param1;
      }
      
      public function get MaxRange() : int
      {
         return int(this._MaxRange + this.RangeUpgrade);
      }
      
      public function set MaxRange(param1:int) : void
      {
         this._MaxRange = param1;
      }
      
      public function get Backfill() : int
      {
         return this._Backfill - this.BackfillUpgrade;
      }
      
      public function set Backfill(param1:int) : void
      {
         this._Backfill = param1;
      }
      
      public function get Supply() : Number
      {
         var _loc1_:Number = this._Supply;
         _loc1_ *= 1 - this.SupplyUpgrade;
         _loc1_ *= 100;
         return int(Math.round(_loc1_)) / 100;
      }
      
      public function set Supply(param1:Number) : void
      {
         this._Supply = param1;
      }
      
      public function get CubageUpgrade() : Number
      {
         var _loc1_:Number = 0;
         var _loc2_:int = 0;
         if(this.KindId == 12)
         {
            _loc2_ = 3;
         }
         else if(this.KindId == 13)
         {
            _loc2_ = 24;
         }
         else if(this.KindId == 14)
         {
            _loc2_ = 44;
         }
         else if(this.KindId == 15)
         {
            _loc2_ = 60;
         }
         if(_loc2_ > 0)
         {
            ScienceSystem.getinstance().GetScienceData(_loc2_);
            _loc1_ = Number(GamePlayer.getInstance().ScienceOjbect.LowCubage);
         }
         return _loc1_;
      }
      
      public function get AssaultUpgrade() : Number
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc1_:Number = 0;
         var _loc2_:int = -1;
         if(this.KindId == 12)
         {
            _loc2_ = 0;
         }
         else if(this.KindId == 13)
         {
            _loc2_ = 16;
            ScienceSystem.getinstance().GetScienceData(_loc2_);
            _loc1_ = Number(GamePlayer.getInstance().ScienceOjbect.Hit);
            ScienceSystem.getinstance().GetScienceData(31);
            _loc3_ = Number(GamePlayer.getInstance().ScienceOjbect.Hit);
            _loc1_ += _loc3_;
            _loc2_ = 28;
         }
         else if(this.KindId == 14)
         {
            _loc2_ = 32;
            ScienceSystem.getinstance().GetScienceData(_loc2_);
            _loc1_ = Number(GamePlayer.getInstance().ScienceOjbect.Hit);
            _loc2_ = 42;
         }
         else if(this.KindId == 15)
         {
            _loc2_ = 48;
            ScienceSystem.getinstance().GetScienceData(_loc2_);
            _loc1_ = Number(GamePlayer.getInstance().ScienceOjbect.Hit);
            _loc2_ = 58;
         }
         if(_loc2_ >= 0)
         {
            ScienceSystem.getinstance().GetScienceData(_loc2_);
            _loc4_ = Number(GamePlayer.getInstance().ScienceOjbect.Hit);
            _loc1_ += _loc4_;
         }
         return _loc1_;
      }
      
      public function get RangeUpgrade() : int
      {
         var _loc1_:Number = 0;
         if(this.KindId == 12)
         {
            ScienceSystem.getinstance().GetScienceData(14);
            _loc1_ = Number(GamePlayer.getInstance().ScienceOjbect.BoostCarry);
         }
         else if(this.KindId == 15)
         {
            ScienceSystem.getinstance().GetScienceData(63);
            _loc1_ = Number(GamePlayer.getInstance().ScienceOjbect.BoostCarry);
         }
         else if(this.KindId == 14)
         {
            ScienceSystem.getinstance().GetScienceData(47);
            _loc1_ = Number(GamePlayer.getInstance().ScienceOjbect.BoostCarry);
         }
         else if(this.KindId == 13)
         {
            ScienceSystem.getinstance().GetScienceData(31);
            _loc1_ = Number(GamePlayer.getInstance().ScienceOjbect.BoostCarry);
         }
         return _loc1_;
      }
      
      public function get BackfillUpgrade() : int
      {
         var _loc1_:int = 0;
         if(this.KindId == 14)
         {
            ScienceSystem.getinstance().GetScienceData(46);
            _loc1_ = int(GamePlayer.getInstance().ScienceOjbect.DecBackfill);
         }
         else if(this.KindId == 15)
         {
            ScienceSystem.getinstance().GetScienceData(63);
            _loc1_ = int(GamePlayer.getInstance().ScienceOjbect.DecBackfill);
         }
         return _loc1_;
      }
      
      public function get SupplyUpgrade() : Number
      {
         var _loc2_:Number = NaN;
         var _loc1_:Number = 0;
         if(this.KindId == 15)
         {
            ScienceSystem.getinstance().GetScienceData(50);
            _loc1_ = Number(GamePlayer.getInstance().ScienceOjbect.DecHes);
            ScienceSystem.getinstance().GetScienceData(51);
            _loc2_ = Number(GamePlayer.getInstance().ScienceOjbect.DecHes);
            _loc1_ += _loc2_;
         }
         return _loc1_;
      }
      
      public function get TurnUpgrade() : Number
      {
         var _loc3_:Number = NaN;
         var _loc1_:Number = 0;
         var _loc2_:int = -1;
         if(this.KindId == 13)
         {
            _loc2_ = 25;
         }
         else if(this.KindId == 14)
         {
            _loc2_ = 41;
         }
         else if(this.KindId == 15)
         {
            _loc2_ = 49;
         }
         if(_loc2_ >= 0)
         {
            ScienceSystem.getinstance().GetScienceData(_loc2_);
            _loc3_ = Number(GamePlayer.getInstance().ScienceOjbect.Turn);
            _loc1_ += _loc3_;
         }
         return _loc1_;
      }
      
      public function get DecHeadoffUpgrade() : Number
      {
         var _loc3_:Number = NaN;
         var _loc1_:Number = 0;
         var _loc2_:int = -1;
         if(this.KindId == 14)
         {
            _loc2_ = 43;
         }
         else if(this.KindId == 15)
         {
            _loc2_ = 54;
            ScienceSystem.getinstance().GetScienceData(_loc2_);
            _loc1_ = Number(GamePlayer.getInstance().ScienceOjbect.DecHeadoff);
            _loc2_ = 59;
            ScienceSystem.getinstance().GetScienceData(_loc2_);
            _loc3_ = Number(GamePlayer.getInstance().ScienceOjbect.DecHeadoff);
            _loc1_ += _loc3_;
            _loc2_ = 63;
         }
         if(_loc2_ >= 0)
         {
            ScienceSystem.getinstance().GetScienceData(_loc2_);
            _loc3_ = Number(GamePlayer.getInstance().ScienceOjbect.DecHeadoff);
            _loc1_ += _loc3_;
         }
         return _loc1_;
      }
   }
}

