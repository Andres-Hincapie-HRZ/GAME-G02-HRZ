package logic.reader
{
   import com.star.frameworks.managers.ResManager;
   import com.star.frameworks.utils.StringUitl;
   import logic.action.ConstructionAction;
   import logic.entry.CFortification;
   import logic.entry.EquimentTypeEnum;
   import logic.game.GameKernel;
   
   public class CFortificationReader
   {
      
      private static var m_Instance:CFortificationReader;
      
      private var m_Xml:XML;
      
      private var _xmlList:XMLList;
      
      public function CFortificationReader()
      {
         super();
         this.Parser();
      }
      
      public static function GetInstance() : CFortificationReader
      {
         if(m_Instance == null)
         {
            m_Instance = new CFortificationReader();
         }
         return m_Instance;
      }
      
      public static function ParserFortication(param1:String, param2:CFortification) : String
      {
         if(param2 == null)
         {
            return param1;
         }
         if(param1.search("{Endure}"))
         {
            param1 = param1.replace("{Endure}",StringUitl.toUSFormat(param2.Endure));
         }
         if(param1.search("{Assault}"))
         {
            param1 = param1.replace("{Assault}",StringUitl.toUSFormat(param2.Assault + param2.Assault * ConstructionAction.defendTechObj.AddAssault));
         }
         if(param1.search("{Range}"))
         {
            if(param2.BuildID != -1 && param2.BuildID == EquimentTypeEnum.EQUIMENT_TYPE_THUNDER_GUN)
            {
               param1 = param1.replace("{Range}",param2.Range);
            }
            else
            {
               param1 = param1.replace("{Range}",param2.Range + parseInt(ConstructionAction.defendTechObj.AddRange));
            }
         }
         if(param1.search("{Backfill}"))
         {
            param1 = param1.replace("{Backfill}",param2.BackFill);
         }
         if(param1.search("{Defend}"))
         {
            param1 = param1.replace("{Defend}",param2.Defend);
         }
         return param1;
      }
      
      private function Parser() : void
      {
         this.m_Xml = GameKernel.resManager.getXml(ResManager.GAMERES,"Fortification");
         this._xmlList = this.m_Xml.* as XMLList;
      }
      
      public function Read(param1:int, param2:int) : CFortification
      {
         var _loc3_:int = 0;
         var _loc4_:* = undefined;
         var _loc5_:XML = null;
         var _loc6_:CFortification = null;
         for each(_loc4_ in this.m_Xml.elements())
         {
            if(_loc4_.@BuildingID == param1)
            {
               _loc5_ = this._xmlList[_loc3_].*[param2 - 1] as XML;
               _loc6_ = new CFortification();
               _loc6_.LevelID = _loc5_.@LevelID;
               _loc6_.Assault = _loc5_.@Assault;
               _loc6_.Defend = _loc5_.@Defend;
               _loc6_.DefendType = _loc5_.@DefendType;
               _loc6_.Endure = _loc5_.@Endure;
               _loc6_.AttackType = _loc5_.@AttackType;
               _loc6_.AttackArea = _loc5_.@AttackArea;
               _loc6_.Range = _loc5_.@Range;
               _loc6_.BackFill = _loc5_.@Backfill;
               return _loc6_;
            }
            _loc3_++;
         }
         return null;
      }
   }
}

