package logic.ui
{
   import logic.entry.shipmodel.FleetPropertyInfo;
   import logic.entry.shipmodel.ShipbodyInfo;
   import logic.entry.shipmodel.ShipmodelInfo;
   import logic.entry.shipmodel.ShippartInfo;
   import logic.reader.CShipmodelReader;
   
   public class FleetProperty
   {
      
      private static var instance:FleetProperty;
      
      public var fleetproperty:FleetPropertyInfo;
      
      private var Locomotivity:int = 0;
      
      public function FleetProperty()
      {
         super();
      }
      
      public static function getInstance() : FleetProperty
      {
         if(instance == null)
         {
            instance = new FleetProperty();
         }
         return instance;
      }
      
      public function ShipProperty(param1:ShipmodelInfo, param2:int, param3:FleetPropertyInfo) : FleetPropertyInfo
      {
         this.Locomotivity = 0;
         param3 = this.shipbodyProperty(param1.m_BodyId,param2,param3);
         var _loc4_:int = 0;
         while(_loc4_ < param1.m_PartNum)
         {
            param3 = this.shippartProperty(param1.m_PartId[_loc4_],param2,param3);
            _loc4_++;
         }
         if(param3.Locomotivity == 0)
         {
            param3.Locomotivity = this.Locomotivity;
         }
         else if(param3.Locomotivity > 0 && this.Locomotivity < param3.Locomotivity)
         {
            param3.Locomotivity = this.Locomotivity;
         }
         return param3;
      }
      
      public function shipbodyProperty(param1:int, param2:int, param3:FleetPropertyInfo) : FleetPropertyInfo
      {
         var _loc4_:ShipbodyInfo = CShipmodelReader.getInstance().getShipBodyInfo(param1);
         if(this.Locomotivity == 0)
         {
            this.Locomotivity = _loc4_.Locomotivity;
         }
         param3.Storage += _loc4_.Storage * param2;
         param3.Endure += _loc4_.Endure * param2;
         param3.Endure += _loc4_.Shield * param2;
         param3.ShipCount += param2;
         return param3;
      }
      
      public function shippartProperty(param1:int, param2:int, param3:FleetPropertyInfo) : FleetPropertyInfo
      {
         var _loc4_:ShippartInfo = CShipmodelReader.getInstance().getShipPartInfo(param1);
         this.Locomotivity += _loc4_.Locomotivity;
         param3.Storage += _loc4_.Storage * param2;
         param3.Supply += _loc4_.Supply * param2;
         param3.Endure += _loc4_.Endure * param2;
         param3.Endure += _loc4_.Shield * param2;
         param3.MinAssault += _loc4_.MinAssault * param2;
         return param3;
      }
   }
}

