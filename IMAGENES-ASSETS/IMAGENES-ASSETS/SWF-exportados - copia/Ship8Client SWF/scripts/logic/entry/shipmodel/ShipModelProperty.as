package logic.entry.shipmodel
{
   import logic.entry.GamePlayer;
   import logic.entry.ScienceSystem;
   import logic.ui.ShipmodelUI;
   import net.router.ShipmodelRouter;
   
   public class ShipModelProperty
   {
      
      public var ShipName:String = "";
      
      public var KindName:String = "";
      
      public var Shield:int = 0;
      
      public var Endure:int = 0;
      
      public var MinAssault:int = 0;
      
      public var MaxAssault:int = 0;
      
      public var Locomotivity:int = 0;
      
      public var Yare:Number = 0;
      
      public var MinRange:int = 0;
      
      public var MaxRange:int = 0;
      
      public var Storage:int = 0;
      
      public var Cubage:int = 0;
      
      public var TransitionTime:int = 0;
      
      public var UnitSupply:int = 0;
      
      public var CreateTime:int = 0;
      
      public var ValidNum:int = 0;
      
      public var Metal:int = 0;
      
      public var He3:int = 0;
      
      public var money:int = 0;
      
      public var shipmodelproAry:Array = new Array();
      
      public var costShipAry:Array = new Array();
      
      public function ShipModelProperty()
      {
         super();
      }
      
      public function getCostShip() : void
      {
      }
      
      public function getshipPro() : void
      {
         ScienceSystem.getinstance().CreateShipData();
         this.shipmodelproAry.push(String(this.Shield));
         this.shipmodelproAry.push(String(this.Endure));
         var _loc1_:String = String(this.MinAssault) + "-" + String(this.MaxAssault);
         this.shipmodelproAry.push(_loc1_);
         this.shipmodelproAry.push(String(this.Locomotivity));
         this.shipmodelproAry.push(String(this.Yare));
         _loc1_ = String(this.MinRange) + "-" + this.MaxRange;
         this.shipmodelproAry.push(_loc1_);
         _loc1_ = ShipmodelUI.getInstance().changetime(this.TransitionTime);
         this.shipmodelproAry.push(_loc1_);
         this.CreateTime = int(this.CreateTime / (1 + ShipmodelRouter.instance.m_IncShipPercent * 0.01));
         if(this.CreateTime < 1)
         {
            this.CreateTime = 1;
         }
         _loc1_ = ShipmodelUI.getInstance().changetime(this.CreateTime);
         this.shipmodelproAry.push(_loc1_);
         this.shipmodelproAry.push(this.KindName);
         this.shipmodelproAry.push(this.ValidNum);
         this.Metal = (this.Metal * 100 - this.Metal * GamePlayer.getInstance().m_DecreaseShipMetalConsume) / 100;
         this.He3 = (this.He3 * 100 - this.He3 * GamePlayer.getInstance().m_DecreaseShipHe3Consume) / 100;
         this.money = (this.money * 100 - this.money * GamePlayer.getInstance().m_DecreaseShipMoneyConsume) / 100;
         this.shipmodelproAry.push(String(this.Metal));
         this.shipmodelproAry.push(String(this.He3));
         this.shipmodelproAry.push(String(this.money));
      }
      
      public function getCost() : void
      {
         ScienceSystem.getinstance().CreateShipData();
         this.Metal = (this.Metal * 100 - this.Metal * GamePlayer.getInstance().m_DecreaseShipMetalConsume) / 100;
         this.He3 = (this.He3 * 100 - this.He3 * GamePlayer.getInstance().m_DecreaseShipHe3Consume) / 100;
         this.money = (this.money * 100 - this.money * GamePlayer.getInstance().m_DecreaseShipMoneyConsume) / 100;
      }
   }
}

