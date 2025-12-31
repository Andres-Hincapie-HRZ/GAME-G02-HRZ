package logic.reader
{
   import com.star.frameworks.managers.ResManager;
   import logic.entry.FlagShip;
   import logic.entry.FlagShipPart;
   import logic.game.GameKernel;
   
   public class FlagShipReader
   {
      
      private static var instance:FlagShipReader;
      
      private var FlagshipXml:XML;
      
      private var FlagShipList:Array;
      
      public function FlagShipReader()
      {
         super();
         this.FlagshipXml = GameKernel.resManager.getXml(ResManager.GAMERES,"Flagship");
      }
      
      public static function getInstance() : FlagShipReader
      {
         if(instance == null)
         {
            instance = new FlagShipReader();
         }
         return instance;
      }
      
      public function GetOpenCellMoney(param1:int) : int
      {
         var _loc2_:XML = null;
         var _loc3_:XML = null;
         for each(_loc2_ in this.FlagshipXml.List)
         {
            if(_loc2_.@ID == 2)
            {
               _loc3_ = _loc2_.*[param1];
               return _loc3_.@OpenMall;
            }
         }
         return 0;
      }
      
      public function GetFlagShip() : Array
      {
         var _loc1_:XML = null;
         var _loc2_:XML = null;
         var _loc3_:int = 0;
         var _loc4_:FlagShip = null;
         var _loc5_:Array = null;
         var _loc6_:String = null;
         var _loc7_:FlagShipPart = null;
         var _loc8_:int = 0;
         if(this.FlagShipList != null)
         {
            return this.FlagShipList;
         }
         this.FlagShipList = new Array();
         for each(_loc1_ in this.FlagshipXml.List)
         {
            if(_loc1_.@ID == 0)
            {
               for each(_loc2_ in _loc1_.*)
               {
                  _loc3_ = int(_loc2_.@Hide);
                  if(_loc3_ != 1)
                  {
                     _loc4_ = new FlagShip();
                     _loc4_.PropsId = _loc2_.@PropsId;
                     _loc4_.PropsInfo = CPropsReader.getInstance().GetPropsInfo(_loc4_.PropsId);
                     _loc4_.NeedMoney = _loc2_.@NeedMoney;
                     _loc5_ = String(_loc2_.@NeedParts).split(";");
                     for each(_loc6_ in _loc5_)
                     {
                        _loc7_ = new FlagShipPart();
                        _loc8_ = int(_loc6_.indexOf(":"));
                        _loc7_.PropsId = parseInt(_loc6_.substr(0,_loc8_));
                        _loc7_.PropsInfo = CPropsReader.getInstance().GetPropsInfo(_loc7_.PropsId);
                        _loc7_.Num = parseInt(_loc6_.substr(_loc8_ + 1));
                        _loc4_.NeedParts.push(_loc7_);
                     }
                     this.FlagShipList.push(_loc4_);
                  }
               }
            }
         }
         return this.FlagShipList;
      }
   }
}

