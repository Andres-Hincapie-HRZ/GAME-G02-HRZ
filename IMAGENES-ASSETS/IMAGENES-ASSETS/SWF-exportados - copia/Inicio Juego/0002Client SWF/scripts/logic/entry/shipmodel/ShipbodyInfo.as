package logic.entry.shipmodel
{
   import logic.entry.GamePlayer;
   import logic.entry.ScienceSystem;
   
   public class ShipbodyInfo
   {
      
      public var Id:int;
      
      public var KindId:int;
      
      public var Name:String;
      
      public var KindName:String;
      
      public var BodyType:int;
      
      public var HullEfficacy:String;
      
      public var GroupID:int;
      
      public var GroupLV:int;
      
      public var Metal:int;
      
      public var He3:int;
      
      public var Money:int;
      
      public var _Shield:int;
      
      public var _Endure:int;
      
      public var Cubage:int;
      
      public var Stability:Number;
      
      public var _Yare:Number;
      
      public var Defend:Number;
      
      public var Blast:Number;
      
      public var DefendType:int;
      
      public var Storage:int;
      
      public var TransitionTime:int;
      
      public var StartSupply:int;
      
      public var UnitSupply:int;
      
      public var Locomotivity:int;
      
      public var ValidNum:int;
      
      public var CreateTime:int;
      
      public var ShowLevel:int;
      
      public var Order:int;
      
      public var ImageFileName:String;
      
      public var UpgradeTime:int;
      
      public var UpgradeMoney:int;
      
      public var ImageIcon:String;
      
      public var SmallIcon:String;
      
      public var Comment2:String;
      
      public var Comment:String;
      
      public function ShipbodyInfo()
      {
         super();
      }
      
      public function get Shield() : int
      {
         var _loc1_:Number = this._Shield;
         _loc1_ *= 1 + this.ShieldUpgrade();
         return int(_loc1_);
      }
      
      public function set Shield(param1:int) : void
      {
         this._Shield = param1;
      }
      
      public function ShieldUpgrade() : Number
      {
         var _loc1_:Number = 0;
         var _loc2_:Number = 0;
         ScienceSystem.getinstance().GetScienceData(70);
         _loc1_ = Number(GamePlayer.getInstance().ScienceOjbect.Shield);
         ScienceSystem.getinstance().GetScienceData(71);
         _loc1_ += Number(GamePlayer.getInstance().ScienceOjbect.Shield);
         ScienceSystem.getinstance().GetScienceData(74);
         return _loc1_ + Number(GamePlayer.getInstance().ScienceOjbect.Shield);
      }
      
      public function get Endure() : int
      {
         var _loc1_:Number = this._Endure;
         _loc1_ *= 1 + this.EndureUpgrade();
         return int(_loc1_);
      }
      
      public function set Endure(param1:int) : void
      {
         this._Endure = param1;
      }
      
      public function EndureUpgrade() : Number
      {
         ScienceSystem.getinstance().GetScienceData(70);
         var _loc1_:Number = Number(GamePlayer.getInstance().ScienceOjbect.Endure);
         ScienceSystem.getinstance().GetScienceData(80);
         _loc1_ += Number(GamePlayer.getInstance().ScienceOjbect.Endure);
         ScienceSystem.getinstance().GetScienceData(83);
         return _loc1_ + Number(GamePlayer.getInstance().ScienceOjbect.Endure);
      }
      
      public function YareUpgrade() : Number
      {
         ScienceSystem.getinstance().GetScienceData(70);
         var _loc1_:Number = Number(GamePlayer.getInstance().ScienceOjbect.Yare);
         ScienceSystem.getinstance().GetScienceData(82);
         return _loc1_ + Number(GamePlayer.getInstance().ScienceOjbect.Yare);
      }
      
      public function get Yare() : Number
      {
         var _loc1_:Number = this._Yare;
         _loc1_ = _loc1_ * (1 + this.YareUpgrade()) * 10;
         _loc1_ = int(Math.round(_loc1_)) / 10;
         return Number(_loc1_);
      }
      
      public function set Yare(param1:Number) : void
      {
         this._Yare = param1;
      }
   }
}

