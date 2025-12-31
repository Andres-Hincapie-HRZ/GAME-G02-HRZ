package
{
   public class GameRes_DailyAwardXml
   {
      
      public static var data:XML = <AWARD ID="1" Name="日常任务奖励">
        <Level AwardID="0" AwardName="Bronze Award" comment="The rewards are 20 Loudspeakers or 1 Resource Box or 1 SP Card." PointDepend="10" AwardItem="921:928:927" ItemNum="20:1:1" AccessProbability="50:30:20"/>
        <Level AwardID="1" AwardName="Silver Award" comment="The rewards are 20 Loudspeakers or 2 Resource Boxes or 2 SP Cards or 1 Primary He3 Pack or 1 Primary Metal Pack." PointDepend="30" AwardItem="921:928:927:915:912" ItemNum="20:2:2:1:1" AccessProbability="40:30:10:10:10"/>
        <Level AwardID="2" AwardName="Gold Award" comment="The rewards are 5 Resource Boxes or 4 SP Cards or 2 Primary He3 Packs or 2 Primary Metal Packs or 1 Metal Gathering Accelerate or 1 He3 Gathering Accelerate or 1 Construction Card or 1 Galaxy Transfer or 1 Extra Tax." PointDepend="50" AwardItem="928:927:915:912:905:906:900:923:907" ItemNum="5:4:2:2:1:1:1:1:1" AccessProbability="30:30:10:10:5:5:2:3:5"/>
        <Level AwardID="3" AwardName="Diamond Award" comment="The reward is 1 Gem Rawstone" PointDepend="70" AwardItem="1119" ItemNum="1" AccessProbability="100"/>
</AWARD>;
      
      public function GameRes_DailyAwardXml()
      {
         super();
      }
   }
}

