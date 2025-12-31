package logic.reader
{
   import com.star.frameworks.managers.ResManager;
   import com.star.frameworks.utils.HashSet;
   import logic.entry.DiamondInfo;
   import logic.entry.ScrollPropsInfo;
   import logic.entry.props.propsInfo;
   import logic.game.GameKernel;
   
   public class CPropsReader
   {
      
      private static var instance:CPropsReader;
      
      private var PropsList:HashSet;
      
      public var MallPropsList:Array;
      
      public var MallPropsList1:Array;
      
      public var MallPropsList2:Array;
      
      public var MallPropsList3:Array;
      
      public var List16:Array;
      
      public var MallPropsList_Badge:Array;
      
      public var MallPropsList_Honor:Array;
      
      private var SkillpsList:Array;
      
      private var PropsTypeList:HashSet;
      
      private var DiamondList:HashSet;
      
      public var MultiList3:Array;
      
      public var MultiList4:Array;
      
      public var ScrollPropsInfoList:HashSet;
      
      public var ValueNameList:Array = new Array("Aim","Blench","Electron","Priority","Assault","Endure","Shield","BlastHurt","Blast","DoubleHit","RepairShield","Exp");
      
      public var RaidPropsList42:Array;
      
      public var RaidPropsList43:Array;
      
      public function CPropsReader()
      {
         super();
         this.PropsList = new HashSet();
         this.MallPropsList = new Array();
         this.MallPropsList1 = new Array();
         this.MallPropsList2 = new Array();
         this.MallPropsList3 = new Array();
         this.MallPropsList_Honor = new Array();
         this.MallPropsList_Badge = new Array();
         this.SkillpsList = new Array();
         this.PropsTypeList = new HashSet();
         this.DiamondList = new HashSet();
         this.ScrollPropsInfoList = new HashSet();
         this.MultiList3 = new Array();
         this.MultiList4 = new Array();
         this.RaidPropsList42 = new Array();
         this.RaidPropsList43 = new Array();
         this.ReadAll();
      }
      
      public static function getInstance() : CPropsReader
      {
         if(instance == null)
         {
            instance = new CPropsReader();
         }
         return instance;
      }
      
      private function ReadAll() : void
      {
         var _loc2_:XML = null;
         var _loc3_:XMLList = null;
         var _loc4_:XML = null;
         var _loc5_:int = 0;
         var _loc6_:propsInfo = null;
         var _loc7_:int = 0;
         var _loc8_:propsInfo = null;
         var _loc9_:int = 0;
         this.List16 = new Array();
         this.SkillpsList.length = 0;
         var _loc1_:XML = GameKernel.resManager.getXml(ResManager.GAMERES,"Props");
         for each(_loc2_ in _loc1_.List)
         {
            _loc3_ = _loc2_.children();
            for each(_loc4_ in _loc3_)
            {
               _loc5_ = 1;
               if(_loc2_.@PackID == 1)
               {
                  _loc5_ = 9;
               }
               if(_loc4_.@PropsId == 504)
               {
               }
               _loc7_ = 0;
               while(_loc7_ < _loc5_)
               {
                  _loc8_ = new propsInfo();
                  if(_loc7_ == 0)
                  {
                     _loc6_ = _loc8_;
                  }
                  _loc8_.PackID = _loc2_.@PackID;
                  _loc8_.Id = _loc4_.@PropsId;
                  _loc8_.List = _loc2_.@ID;
                  _loc8_.Id += _loc7_;
                  _loc8_.Name = _loc4_.@Name;
                  _loc8_.ShipBodyID = _loc4_.@ShipBodyID;
                  _loc8_.ShipPartID = _loc4_.@ShipPartID;
                  _loc8_.ImageFileName = _loc4_.@ImageFileName;
                  if(_loc8_.PackID == 1)
                  {
                     _loc9_ = _loc8_.Id % 9 + 1;
                     _loc8_.ImageFileName += _loc9_;
                  }
                  _loc8_.Comment = _loc4_.@Comment;
                  _loc8_.CommanderType = _loc4_.@CommanderType;
                  _loc8_.SkillID = _loc4_.@SkillID;
                  _loc8_.FrontComment = _loc4_.@FrontComment;
                  _loc8_.FrontID = _loc4_.@FrontID;
                  _loc8_.Cash = _loc4_.@Cash;
                  _loc8_.OrderID = _loc4_.@OrderID;
                  _loc8_.AssortID = _loc4_.@AssortID;
                  _loc8_.Fettle = _loc4_.@Fettle;
                  _loc8_.UseMoney = _loc4_.@UseMoney;
                  _loc8_.SuspendID = _loc4_.@SuspendID;
                  _loc8_.BuyBadge = _loc4_.@BuyBadge;
                  _loc8_.BuyHonor = _loc4_.@BuyHonor;
                  _loc8_.Probability = _loc4_.@Probability * 100;
                  _loc8_.GroupId = _loc4_.@GroupID;
                  _loc8_.Exp = _loc4_.@EXP;
                  _loc8_.PropsColor = _loc4_.@PropsColor;
                  _loc8_.CostPirateCoin = _loc4_.@CostPirateCoin;
                  this.AddChipValue(_loc8_,_loc4_,"Endure");
                  this.AddChipValue(_loc8_,_loc4_,"Shield");
                  this.AddChipValue(_loc8_,_loc4_,"AddDefence");
                  this.AddChipValue(_loc8_,_loc4_,"Stability");
                  this.AddChipValue(_loc8_,_loc4_,"ShieldAbsorb");
                  this.AddChipValue(_loc8_,_loc4_,"FurbishEndure");
                  this.AddChipValue(_loc8_,_loc4_,"FurbishShield");
                  this.AddChipValue(_loc8_,_loc4_,"ReduceTransitionTime");
                  this.AddChipValue(_loc8_,_loc4_,"MinAssault");
                  this.AddChipValue(_loc8_,_loc4_,"MaxAssault");
                  if(_loc8_.Fettle == 0)
                  {
                     _loc8_.Fettle = 99;
                  }
                  this.PropsList.Put(_loc8_.Id,_loc8_);
                  if(_loc8_.List == 16)
                  {
                     this.List16.push(_loc8_);
                  }
                  _loc7_++;
               }
               if(_loc6_.PackID > 1 && _loc6_.Cash > 0)
               {
                  this.MallPropsList.push(_loc6_);
                  if(_loc6_.AssortID == 1)
                  {
                     this.MallPropsList1.push(_loc6_);
                  }
                  else if(_loc6_.AssortID == 2)
                  {
                     this.MallPropsList2.push(_loc6_);
                  }
                  else if(_loc6_.AssortID == 3)
                  {
                     this.MallPropsList3.push(_loc6_);
                  }
               }
               if(_loc6_.BuyBadge > 0)
               {
                  this.MallPropsList_Badge.push(_loc6_);
               }
               if(_loc6_.BuyHonor > 0)
               {
                  this.MallPropsList_Honor.push(_loc6_);
               }
               if(_loc6_.PackID == 1)
               {
                  this.SkillpsList.push(_loc6_);
               }
               this.AddTypeList(_loc6_);
               if(_loc6_.PackID == 3)
               {
                  this.AddDiamondList(_loc4_,_loc6_);
               }
               if(_loc6_.List == 33)
               {
                  this.AddScrollPropsInfo(_loc4_);
               }
               if(_loc6_.List == 42)
               {
                  this.RaidPropsList42.push(_loc6_);
               }
               if(_loc6_.List == 43)
               {
                  this.RaidPropsList43.push(_loc6_);
               }
            }
         }
         this.MallPropsList.sortOn(["Fettle","OrderID"],Array.NUMERIC);
         this.MallPropsList1.sortOn(["Fettle","OrderID"],Array.NUMERIC);
         this.MallPropsList2.sortOn(["Fettle","OrderID"],Array.NUMERIC);
         this.MallPropsList3.sortOn(["Fettle","OrderID"],Array.NUMERIC);
         this.MallPropsList_Badge.sortOn(["Fettle","OrderID"],Array.NUMERIC);
         this.MallPropsList_Honor.sortOn(["Fettle","OrderID"],Array.NUMERIC);
      }
      
      private function AddChipValue(param1:propsInfo, param2:XML, param3:String) : void
      {
         var _loc4_:Number = Number(param2.attribute(param3));
         if(_loc4_ != 0)
         {
            param1.ChipValue = _loc4_;
         }
      }
      
      private function AddDiamondList(param1:XML, param2:propsInfo) : void
      {
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         var _loc3_:DiamondInfo = new DiamondInfo();
         _loc3_.PropsId = param1.@PropsId;
         _loc3_.SuspendID = param1.@SuspendID;
         _loc3_.GemLevel = param1.@GemLevel;
         _loc3_.GemKindID = param1.@GemKindID;
         _loc3_.GemValue = param1.@GemValue;
         _loc3_.GemColor = param1.@GemColor;
         _loc3_.Diamond = param1.@Diamond;
         _loc3_.BlastHurt = param1.@BlastHurt;
         _loc3_.OrderID = param1.@OrderID;
         _loc3_.Eolith = param1.@Eolith;
         _loc3_.GemID = param1.@GemID;
         if(_loc3_.GemID == 5)
         {
         }
         _loc3_.ResultGem = param1.@ResultGem;
         _loc3_.Gem1ID = param1.@Gem1ID;
         _loc3_.PropsInfo = param2;
         this.DiamondList.Put(_loc3_.PropsId,_loc3_);
         if(_loc3_.PropsInfo.List >= 40)
         {
            _loc3_.GemaValueList = new Object();
            _loc4_ = 0;
            while(_loc4_ < 12)
            {
               _loc5_ = Number(param1.attribute(this.ValueNameList[_loc4_]));
               if(_loc5_ != 0)
               {
                  _loc3_.GemaValueList[this.ValueNameList[_loc4_]] = _loc5_;
               }
               _loc4_++;
            }
         }
         if(param2.List == 40)
         {
            this.MultiList3.push(_loc3_);
         }
         else if(param2.List == 41)
         {
            this.MultiList4.push(_loc3_);
         }
      }
      
      private function AddScrollPropsInfo(param1:XML) : void
      {
         var _loc2_:ScrollPropsInfo = new ScrollPropsInfo();
         _loc2_.PropsId = param1.@PropsId;
         _loc2_.SkillID = param1.@SkillID;
         _loc2_.Skill0 = param1.@Skill0;
         _loc2_.Skill1 = param1.@Skill1;
         this.ScrollPropsInfoList.Put(_loc2_.PropsId,_loc2_);
      }
      
      public function GetDiamond(param1:int) : DiamondInfo
      {
         return this.DiamondList.Get(param1);
      }
      
      private function AddTypeList(param1:propsInfo) : void
      {
         var _loc2_:Array = null;
         if(this.PropsTypeList.ContainsKey(param1.PackID))
         {
            _loc2_ = this.PropsTypeList.Get(param1.PackID);
         }
         else
         {
            _loc2_ = new Array();
            this.PropsTypeList.Put(param1.PackID,_loc2_);
         }
         _loc2_.push(param1);
      }
      
      public function GetPropsInfo(param1:int) : propsInfo
      {
         var _loc2_:int = param1;
         var _loc3_:propsInfo = null;
         if(this.PropsList.ContainsKey(param1))
         {
            _loc3_ = this.PropsList.Get(param1);
         }
         else
         {
            param1 /= 9;
            param1 *= 9;
            if(this.PropsList.ContainsKey(param1))
            {
               _loc3_ = this.PropsList.Get(param1);
            }
         }
         return _loc3_;
      }
      
      public function GetCommanderProID(param1:int) : int
      {
         var _loc2_:uint = 0;
         while(_loc2_ < this.SkillpsList.length)
         {
            if(this.SkillpsList[_loc2_].SkillID == param1)
            {
               return this.SkillpsList[_loc2_].Id;
            }
            _loc2_++;
         }
         return -1;
      }
      
      public function SearchProps(param1:int, param2:String) : Array
      {
         var _loc5_:propsInfo = null;
         var _loc3_:Array = new Array();
         var _loc4_:Array = this.PropsTypeList.Get(param1);
         for each(_loc5_ in _loc4_)
         {
            if(_loc5_.Name.toLowerCase().indexOf(param2) >= 0)
            {
               _loc3_.push(_loc5_);
            }
         }
         return _loc3_;
      }
   }
}

