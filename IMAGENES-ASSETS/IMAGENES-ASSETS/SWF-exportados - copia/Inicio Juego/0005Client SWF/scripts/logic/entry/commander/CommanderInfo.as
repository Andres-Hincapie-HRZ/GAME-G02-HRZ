package logic.entry.commander
{
   public class CommanderInfo
   {
      
      public var HasCardLevel:Boolean;
      
      public var commander_name:String = "";
      
      public var commander_userId:Number;
      
      public var commander_commanderId:int;
      
      public var commander_shipTeamId:int;
      
      public var commander_restTime:int;
      
      public var commander_exp:int;
      
      public var commander_aim:int;
      
      public var commander_blench:int;
      
      public var commander_priority:int;
      
      public var commander_electron:int;
      
      public var commander_skill:int;
      
      public var commander_cardLevel:int;
      
      public var commander_level:int;
      
      public var commander_type:int;
      
      public var commander_state:int;
      
      public var Reserve:int;
      
      public var commander_commanderZJ:String = "";
      
      public var commander_TeamBody:Array = new Array();
      
      public var commander_Target:int;
      
      public var commander_TargetInterval:int;
      
      public var commander_Stone:Array = new Array();
      
      public var commander_StoneHole:int;
      
      public var commander_AimPer:int;
      
      public var commander_BlenchPer:int;
      
      public var commander_PriorityPer:int;
      
      public var commander_ElectronPer:int;
      
      public var ChipList:Array;
      
      public var ChipExpList:Array;
      
      public function CommanderInfo()
      {
         super();
      }
   }
}

