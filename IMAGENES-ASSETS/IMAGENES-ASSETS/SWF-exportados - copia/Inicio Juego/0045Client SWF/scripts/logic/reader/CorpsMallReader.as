package logic.reader
{
   import com.star.frameworks.managers.ResManager;
   import com.star.frameworks.utils.HashSet;
   import logic.entry.CorpsMallItem;
   import logic.entry.shipmodel.ShipmodelInfo;
   import logic.game.GameKernel;
   
   public class CorpsMallReader
   {
      
      private static var instance:CorpsMallReader;
      
      private var MallGoodsList:HashSet;
      
      private var ModelList:Array;
      
      public function CorpsMallReader()
      {
         super();
         this.MallGoodsList = new HashSet();
         this.ModelList = new Array();
         this.ReadAll();
      }
      
      public static function getInstance() : CorpsMallReader
      {
         if(instance == null)
         {
            instance = new CorpsMallReader();
         }
         return instance;
      }
      
      private function ReadAll() : void
      {
         this.ReadMallItem();
         this.ReadShipModel();
      }
      
      private function ReadMallItem() : void
      {
         var _loc4_:XML = null;
         var _loc5_:CorpsMallItem = null;
         var _loc6_:Array = null;
         var _loc1_:XML = GameKernel.resManager.getXml(ResManager.GAMERES,"CorpsShop");
         var _loc2_:XMLList = _loc1_.children();
         var _loc3_:int = 0;
         for each(_loc4_ in _loc2_)
         {
            _loc5_ = new CorpsMallItem();
            _loc5_.Id = _loc3_;
            (++_loc5_).Name = _loc4_.@Name;
            _loc5_.ShipModelId = _loc4_.@ShipModelId;
            _loc5_.ShipSell = _loc4_.@ShipSell;
            _loc5_.NeedLv = _loc4_.@NeedLv;
            _loc5_.SellNumber = _loc4_.@SellNumber;
            _loc6_ = this.MallGoodsList.Get(_loc5_.NeedLv);
            if(_loc6_ == null)
            {
               _loc6_ = new Array();
               this.MallGoodsList.Put(_loc5_.NeedLv,_loc6_);
            }
            _loc6_.push(_loc5_);
         }
      }
      
      private function ReadShipModel() : void
      {
         var _loc3_:XML = null;
         var _loc4_:ShipmodelInfo = null;
         var _loc5_:String = null;
         var _loc1_:XML = GameKernel.resManager.getXml(ResManager.GAMERES,"ShipModel");
         var _loc2_:XMLList = _loc1_.children();
         for each(_loc3_ in _loc2_)
         {
            _loc4_ = new ShipmodelInfo();
            _loc4_.m_ShipName = _loc3_.@Name;
            _loc4_.m_BodyId = _loc3_.@BodyId;
            _loc4_.m_PubFlag = _loc3_.@PubFlag;
            _loc5_ = _loc3_.@PartInfo;
            _loc4_.m_PartId = _loc5_.split(",");
            _loc4_.m_PartNum = _loc4_.m_PartId.length;
            this.ModelList.push(_loc4_);
         }
      }
      
      public function GetMallItemByLevel(param1:int) : Array
      {
         return this.MallGoodsList.Get(param1);
      }
      
      public function GetShipModel(param1:int) : ShipmodelInfo
      {
         return this.ModelList[param1];
      }
   }
}

