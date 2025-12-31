package logic.reader
{
   import com.star.frameworks.managers.ResManager;
   import com.star.frameworks.utils.HashSet;
   import logic.entry.shipmodel.ShipbodyInfo;
   import logic.entry.shipmodel.ShippartInfo;
   import logic.game.GameKernel;
   
   public class CShipmodelReader
   {
      
      private static var instance:CShipmodelReader;
      
      private var _ShipBodyList:Array;
      
      private var _ShipPartList:Array;
      
      private var _BodyTypeList:HashSet;
      
      public var _PartFuncTypeList:HashSet;
      
      public var _PartTypeList:HashSet;
      
      public function CShipmodelReader()
      {
         super();
         this._ShipBodyList = new Array();
         this._ShipPartList = new Array();
         this._BodyTypeList = new HashSet();
         this._PartFuncTypeList = new HashSet();
         this._PartTypeList = new HashSet();
         this.Parser();
      }
      
      public static function getInstance() : CShipmodelReader
      {
         if(instance == null)
         {
            instance = new CShipmodelReader();
         }
         return instance;
      }
      
      private function Parser() : void
      {
         this.ReadAllBody();
         this.ReadAllPart();
      }
      
      public function getShipBodyInfo(param1:int) : ShipbodyInfo
      {
         if(param1 < 0 || param1 >= this._ShipBodyList.length)
         {
            return null;
         }
         return this._ShipBodyList[param1];
      }
      
      public function getShipPartInfo(param1:int) : ShippartInfo
      {
         if(param1 < 0 || param1 >= this._ShipPartList.length)
         {
            return null;
         }
         return this._ShipPartList[param1];
      }
      
      private function ReadAllBody() : void
      {
         var _loc2_:XML = null;
         var _loc3_:XMLList = null;
         var _loc4_:XML = null;
         var _loc5_:ShipbodyInfo = null;
         var _loc1_:XML = GameKernel.resManager.getXml(ResManager.GAMERES,"ShipBody");
         for each(_loc2_ in _loc1_.List)
         {
            _loc3_ = _loc2_.children();
            for each(_loc4_ in _loc3_)
            {
               _loc5_ = new ShipbodyInfo();
               _loc5_.KindName = _loc2_.@KindName;
               _loc5_.KindId = _loc2_.@KindID;
               _loc5_.Name = _loc4_.@Name;
               _loc5_.BodyType = _loc4_.@BodyType;
               _loc5_.HullEfficacy = _loc4_.@HullEfficacy;
               _loc5_.GroupID = _loc4_.@GroupID;
               _loc5_.GroupLV = _loc4_.@GroupLV;
               _loc5_.Metal = _loc4_.@Metal;
               _loc5_.He3 = _loc4_.@He3;
               _loc5_.Money = _loc4_.@Money;
               _loc5_.Shield = _loc4_.@Shield;
               _loc5_.Endure = _loc4_.@Endure;
               _loc5_.Cubage = _loc4_.@Cubage;
               _loc5_.Stability = _loc4_.@Stability;
               _loc5_.Yare = _loc4_.@Yare;
               _loc5_.Defend = _loc4_.@Defend;
               _loc5_.Blast = _loc4_.@Blast;
               _loc5_.DefendType = _loc4_.@DefendType;
               _loc5_.Storage = _loc4_.@Storage;
               _loc5_.TransitionTime = _loc4_.@TransitionTime;
               _loc5_.StartSupply = _loc4_.@StartSupply;
               _loc5_.UnitSupply = _loc4_.@UnitSupply;
               _loc5_.Locomotivity = _loc4_.@Locomotivity;
               _loc5_.ValidNum = _loc4_.@ValidNum;
               _loc5_.CreateTime = _loc4_.@CreateTime;
               _loc5_.ShowLevel = _loc4_.@ShowLevel;
               _loc5_.Order = _loc4_.@Order;
               _loc5_.ImageFileName = _loc4_.@ImageFileName;
               _loc5_.Id = this._ShipBodyList.length;
               _loc5_.UpgradeTime = _loc4_.@UpgradeTime;
               _loc5_.UpgradeMoney = _loc4_.@UpgradeMoney;
               _loc5_.ImageIcon = _loc4_.@ImageIcon;
               _loc5_.SmallIcon = _loc4_.@SmallIcon;
               _loc5_.Comment2 = _loc4_.@Comment2;
               _loc5_.Comment = _loc4_.@Comment;
               this._ShipBodyList.push(_loc5_);
               this.AddToBodyTypeList(_loc5_.KindId,this._ShipBodyList.length - 1);
            }
         }
      }
      
      private function AddToBodyTypeList(param1:int, param2:int) : void
      {
         var _loc3_:Array = null;
         if(this._BodyTypeList.ContainsKey(param1))
         {
            _loc3_ = this._BodyTypeList.Get(param1);
         }
         else
         {
            _loc3_ = new Array();
            this._BodyTypeList.Put(param1,_loc3_);
         }
         _loc3_.push(param2);
      }
      
      public function GetBodyArrayByType(param1:int) : Array
      {
         return this._BodyTypeList.Get(param1);
      }
      
      public function GetPartArrayByType(param1:int) : Array
      {
         return this._PartTypeList.Get(param1);
      }
      
      private function ReadAllPart() : void
      {
         var _loc2_:XML = null;
         var _loc3_:XMLList = null;
         var _loc4_:XML = null;
         var _loc5_:ShippartInfo = null;
         var _loc1_:XML = GameKernel.resManager.getXml(ResManager.GAMERES,"ShipPart");
         for each(_loc2_ in _loc1_.List)
         {
            _loc3_ = _loc2_.children();
            for each(_loc4_ in _loc3_)
            {
               _loc5_ = new ShippartInfo();
               _loc5_.KindName = _loc2_.@KindName;
               _loc5_.KindId = _loc2_.@Kind;
               _loc5_.FuncTypeId = _loc2_.@Type;
               _loc5_.Name = _loc4_.@Name;
               _loc5_.GroupID = _loc4_.@GroupID;
               _loc5_.GroupLV = _loc4_.@GroupLV;
               _loc5_.Comment = _loc4_.@Comment;
               _loc5_.Metal = _loc4_.@Metal;
               _loc5_.Money = _loc4_.@Money;
               _loc5_.He3 = _loc4_.@He3;
               _loc5_.Supply = _loc4_.@Supply;
               _loc5_.Cubage = _loc4_.@Cubage;
               _loc5_.Weight = _loc4_.@Weight;
               _loc5_.Turn = _loc4_.@Turn;
               _loc5_.MinRange = _loc4_.@MinRange;
               _loc5_.MaxRange = _loc4_.@MaxRange;
               _loc5_.MinAssault = _loc4_.@MinAssault;
               _loc5_.MaxAssault = _loc4_.@MaxAssault;
               _loc5_.Backfill = _loc4_.@Backfill;
               _loc5_.Ratio = _loc4_.@Ratio;
               _loc5_.CreateTime = _loc4_.@CreateTime;
               _loc5_.ImageFileName = _loc4_.@ImageFileName;
               _loc5_.Shield = _loc4_.@Shield;
               _loc5_.Endure = _loc4_.@Endure;
               _loc5_.Locomotivity = _loc4_.@Locomotivity;
               _loc5_.Storage = _loc4_.@Storage;
               _loc5_.Yare = _loc4_.@Yare;
               _loc5_.UnitSupply = _loc4_.@UnitSupply;
               _loc5_.UpgradeTime = _loc4_.@UpgradeTime;
               _loc5_.UpgradeMoney = _loc4_.@UpgradeMoney;
               _loc5_.TransitionTime = _loc4_.@TransitionTime;
               _loc5_.Limit = _loc4_.@Limit;
               _loc5_.HurtType = _loc4_.@HurtType;
               _loc5_.Comment2 = _loc4_.@Comment2;
               _loc5_.First = _loc4_.@First;
               _loc5_.Headoff = _loc4_.@Headoff;
               _loc5_.Id = this._ShipPartList.length;
               this._ShipPartList.push(_loc5_);
               if(_loc4_.@HidePart != 1)
               {
                  this.AddToPartTypeList(_loc5_.FuncTypeId,_loc5_.KindId,this._ShipPartList.length - 1);
               }
            }
         }
      }
      
      private function AddToPartTypeList(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         if(this._PartFuncTypeList.ContainsKey(param1))
         {
            _loc4_ = this._PartFuncTypeList.Get(param1);
         }
         else
         {
            _loc4_ = new Array();
            this._PartFuncTypeList.Put(param1,_loc4_);
         }
         if(this._PartTypeList.ContainsKey(param2))
         {
            _loc5_ = this._PartTypeList.Get(param2);
         }
         else
         {
            _loc4_.push(param2);
            _loc5_ = new Array();
            this._PartTypeList.Put(param2,_loc5_);
         }
         _loc5_.push(param3);
      }
      
      public function GetBodyIdsByGroupId(param1:int, param2:int, param3:int) : Array
      {
         var _loc4_:Array = null;
         var _loc7_:ShipbodyInfo = null;
         if(this._BodyTypeList.ContainsKey(param1))
         {
            _loc4_ = this._BodyTypeList.Get(param1);
         }
         var _loc5_:Array = new Array();
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_.length)
         {
            _loc7_ = this._ShipBodyList[_loc4_[_loc6_]];
            if(_loc7_.GroupID == param2 && _loc7_.GroupLV < param3)
            {
               _loc5_.push(_loc4_[_loc6_]);
            }
            _loc6_++;
         }
         return _loc5_;
      }
      
      public function BodyIsTopLevel(param1:ShipbodyInfo) : Boolean
      {
         var _loc2_:Array = null;
         var _loc4_:ShipbodyInfo = null;
         if(this._BodyTypeList.ContainsKey(param1.KindId))
         {
            _loc2_ = this._BodyTypeList.Get(param1.KindId);
         }
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = this._ShipBodyList[_loc2_[_loc3_]];
            if(_loc4_.GroupID == param1.GroupID && _loc4_.GroupLV > param1.GroupLV)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      public function GetNextLevelBody(param1:ShipbodyInfo) : ShipbodyInfo
      {
         var _loc2_:Array = null;
         var _loc6_:ShipbodyInfo = null;
         if(this._BodyTypeList.ContainsKey(param1.KindId))
         {
            _loc2_ = this._BodyTypeList.Get(param1.KindId);
         }
         var _loc3_:int = param1.GroupLV + 1;
         var _loc4_:ShipbodyInfo = null;
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc6_ = this._ShipBodyList[_loc2_[_loc5_]];
            if(_loc6_.GroupID == param1.GroupID && _loc6_.GroupLV >= _loc3_)
            {
               if(_loc4_ == null || _loc4_.GroupLV > _loc6_.GroupLV)
               {
                  _loc4_ = _loc6_;
               }
            }
            _loc5_++;
         }
         return _loc4_;
      }
      
      public function GetPartIdsByGroupId(param1:int, param2:int, param3:int) : Array
      {
         var _loc4_:Array = null;
         var _loc6_:int = 0;
         var _loc7_:ShippartInfo = null;
         if(this._PartTypeList.ContainsKey(param1))
         {
            _loc4_ = this._PartTypeList.Get(param1);
         }
         var _loc5_:Array = new Array();
         for each(_loc6_ in _loc4_)
         {
            _loc7_ = this._ShipPartList[_loc6_];
            if(_loc7_.GroupID == param2 && _loc7_.GroupLV < param3)
            {
               _loc5_.push(_loc6_);
            }
         }
         return _loc5_;
      }
      
      public function PartIsTopLevel(param1:ShippartInfo) : Boolean
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:ShippartInfo = null;
         if(this._PartTypeList.ContainsKey(param1.KindId))
         {
            _loc2_ = this._PartTypeList.Get(param1.KindId);
         }
         for each(_loc3_ in _loc2_)
         {
            _loc4_ = this._ShipPartList[_loc3_];
            if(_loc4_.GroupID == param1.GroupID && _loc4_.GroupLV > param1.GroupLV)
            {
               return true;
            }
         }
         return false;
      }
      
      public function GetNextLevelPart(param1:ShippartInfo) : ShippartInfo
      {
         var _loc2_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:ShippartInfo = null;
         if(this._PartTypeList.ContainsKey(param1.KindId))
         {
            _loc2_ = this._PartTypeList.Get(param1.KindId);
         }
         var _loc3_:int = param1.GroupLV + 1;
         var _loc4_:ShippartInfo = null;
         for each(_loc5_ in _loc2_)
         {
            _loc6_ = this._ShipPartList[_loc5_];
            if(_loc6_.GroupID == param1.GroupID && _loc6_.GroupLV >= _loc3_)
            {
               if(_loc4_ == null || _loc4_.GroupLV > _loc6_.GroupLV)
               {
                  _loc4_ = _loc6_;
               }
            }
         }
         return _loc4_;
      }
      
      public function SearchShipBody(param1:String) : Array
      {
         var _loc3_:ShipbodyInfo = null;
         var _loc2_:Array = new Array();
         for each(_loc3_ in this._ShipBodyList)
         {
            if(_loc3_.Name.toLowerCase().indexOf(param1) >= 0)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function GetFirstLevelBody(param1:int) : HashSet
      {
         var _loc4_:int = 0;
         var _loc5_:ShipbodyInfo = null;
         var _loc2_:Array = this.GetBodyArrayByType(param1);
         var _loc3_:HashSet = new HashSet();
         for each(_loc4_ in _loc2_)
         {
            _loc5_ = this.getShipBodyInfo(_loc4_);
            if(_loc5_.GroupLV == 1)
            {
               _loc3_.Put(_loc5_.GroupID,_loc5_);
            }
         }
         return _loc3_;
      }
      
      public function GetFirstLevelPart(param1:int) : HashSet
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc7_:ShippartInfo = null;
         var _loc2_:HashSet = new HashSet();
         _loc3_ = this._PartFuncTypeList.Get(param1);
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = this._PartTypeList.Get(_loc4_);
            for each(_loc6_ in _loc5_)
            {
               _loc7_ = this.getShipPartInfo(_loc6_);
               if(_loc7_.GroupLV == 1)
               {
                  _loc2_.Put(_loc7_.KindId + "," + _loc7_.GroupID,_loc7_);
               }
            }
         }
         return _loc2_;
      }
   }
}

