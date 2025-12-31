package logic.reader
{
   import com.star.frameworks.managers.ResManager;
   import logic.entry.commander.CommanderXmlInfo;
   import logic.game.GameKernel;
   
   public class CCommanderReader
   {
      
      private static var instance:CCommanderReader;
      
      private var _xmlList:XMLList;
      
      private var _xml:XML;
      
      private var _xmlExpList:XMLList;
      
      public var m_skillName:String;
      
      public var m_ImageFileName:String;
      
      public var m_CommanderType:String;
      
      public var m_Comment:String;
      
      public var m_type:int;
      
      public function CCommanderReader()
      {
         super();
         this._xmlList = GameKernel.resManager.getXml(ResManager.GAMERES,"Commander").*.* as XMLList;
         this._xml = GameKernel.resManager.getXml(ResManager.GAMERES,"Commander");
      }
      
      public static function getInstance() : CCommanderReader
      {
         if(instance == null)
         {
            instance = new CCommanderReader();
         }
         return instance;
      }
      
      public function getcommander(param1:int) : void
      {
         this.m_skillName = this._xmlList[param1].@SkillName;
         this.m_ImageFileName = this._xmlList[param1].@ImageFileName;
         this.m_CommanderType = this._xmlList[param1].@CommanderType;
         this.m_Comment = this._xmlList[param1].@Comment;
         this.m_type = this._xmlList[param1].@Type;
      }
      
      public function getCommanderName(param1:int) : String
      {
         return this._xmlList[param1].@Name;
      }
      
      public function getCommanderImage(param1:int) : String
      {
         return this._xmlList[param1].@Image;
      }
      
      public function getCommanderAvatar(param1:int) : String
      {
         return this._xmlList[param1].@ImageFileName;
      }
      
      public function getCommanderSkillName(param1:int) : String
      {
         return this._xmlList[param1].@SkillName;
      }
      
      public function getCommanderDescription(param1:int) : String
      {
         return this._xmlList[param1].@Description;
      }
      
      public function getCommanderCommanderType(param1:int) : int
      {
         return int(this._xmlList[param1].@CommanderType);
      }
      
      public function getCommanderType(param1:int) : int
      {
         return int(this._xmlList[param1].@Type);
      }
      
      public function GetCommanderInfo(param1:int) : CommanderXmlInfo
      {
         var _loc2_:CommanderXmlInfo = new CommanderXmlInfo();
         _loc2_.CommanderType = this._xmlList[param1].@CommanderType;
         _loc2_.Comment = this._xmlList[param1].@Comment;
         _loc2_.ImageFileName = this._xmlList[param1].@ImageFileName;
         _loc2_.SkillName = this._xmlList[param1].@SkillName;
         _loc2_.Type = this._xmlList[param1].@Type;
         _loc2_.Name = this._xmlList[param1].@Name;
         return _loc2_;
      }
      
      public function GetCommanderExp(param1:int) : int
      {
         var _loc4_:XML = null;
         var _loc2_:XMLList = this._xml.Exp.*;
         var _loc3_:int = 0;
         for each(_loc4_ in _loc2_)
         {
            _loc3_++;
         }
         if(param1 >= _loc3_)
         {
            return 0;
         }
         return int(_loc2_[param1].@Exp);
      }
      
      public function GetComposeRate(param1:int) : int
      {
         var _loc2_:XMLList = this._xml.probability.*;
         var _loc3_:XML = _loc2_[param1];
         return _loc3_.@probability;
      }
      
      public function GetCommandPullulate(param1:int, param2:int, param3:Object) : Object
      {
         var _loc6_:XML = null;
         var _loc4_:XMLList = this._xml.CommandPullulate.*;
         var _loc5_:int = 0;
         for each(_loc6_ in _loc4_)
         {
            if(_loc6_.@CommandType == param1 && _loc6_.@CommandStar == param2)
            {
               param3.Frigate = _loc6_.@Frigate;
               param3.Cruiser = _loc6_.@Cruiser;
               param3.Warship = _loc6_.@Warship;
               return param3;
            }
            _loc5_++;
         }
         return param3;
      }
   }
}

