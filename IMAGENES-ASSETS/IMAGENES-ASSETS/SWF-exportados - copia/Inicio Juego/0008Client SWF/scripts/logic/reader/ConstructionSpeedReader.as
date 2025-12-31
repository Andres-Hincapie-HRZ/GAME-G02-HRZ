package logic.reader
{
   import com.star.frameworks.managers.ResManager;
   import logic.game.GameKernel;
   
   public class ConstructionSpeedReader
   {
      
      private static var instance:ConstructionSpeedReader;
      
      public static const SPEED_TYPE_BUILD:int = 0;
      
      public static const SPEED_TYPE_TECH:int = 1;
      
      public static const SPEED_TYPE_SHIP:int = 2;
      
      private var _list:XMLList;
      
      private var _count:int;
      
      public function ConstructionSpeedReader()
      {
         super();
         var _loc1_:XML = GameKernel.resManager.getXml(ResManager.GAMERES,"buildSpeed");
         this._list = _loc1_.* as XMLList;
         this._count = _loc1_.elements().length();
      }
      
      public static function getInstance() : ConstructionSpeedReader
      {
         if(instance == null)
         {
            instance = new ConstructionSpeedReader();
         }
         return instance;
      }
      
      public function Read(param1:int = 0, param2:int = 0) : Object
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:XML = null;
         var _loc6_:Object = null;
         if(_loc3_ != ConstructionSpeedReader.SPEED_TYPE_BUILD && _loc3_ != ConstructionSpeedReader.SPEED_TYPE_SHIP && _loc3_ != ConstructionSpeedReader.SPEED_TYPE_TECH)
         {
            throw new Error("边界溢出");
         }
         _loc3_ = int(this._list[param2].@Type);
         for each(_loc5_ in this._list[_loc3_].*)
         {
            if(param1 == _loc4_)
            {
               _loc6_ = new Object();
               _loc6_.Type = _loc3_;
               _loc6_.Name = _loc5_.@Name;
               _loc6_.Time = _loc5_.@Time;
               _loc6_.Credit = _loc5_.@Credit;
               if(_loc5_.@Variable != undefined)
               {
                  _loc6_.Variable = _loc5_.@Variable;
               }
               return _loc6_;
            }
            _loc4_++;
         }
         return null;
      }
   }
}

