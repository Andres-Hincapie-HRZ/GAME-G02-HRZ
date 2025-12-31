package
{
   public class GameRes_DailyAwardXml
   {
      
      public static var data:XML = <AWARD ID="1" Name="日常任务奖励">
        <Level AwardID="0" AwardName="Premio de bronce" comment="Recibes 1 de los siguientes premios: 20 antenas, 1 cofre de recursos o 1 carta de movimiento." PointDepend="10" AwardItem="921:928:927" ItemNum="20:1:1" AccessProbability="50:30:20"/>
        <Level AwardID="1" AwardName="Premio de plata" comment="Recibes 1 de los siguientes premios: 20 antenas, 2 cofres de recursos, 2 cartas de movimiento, 1 lote primario de He3 o 1 lote primario de metal." PointDepend="30" AwardItem="921:928:927:915:912" ItemNum="20:2:2:1:1" AccessProbability="40:30:10:10:10"/>
        <Level AwardID="2" AwardName="Premio de oro" comment="Recibes 1 de los siguientes premios: 5 cofres de recursos, 4 cartas de movimiento, 2 lotes primarios de He3, 2 lotes primarios de metal, 1 mejora de producción de metal, 1 mejora de producción de He3, 1 carta de construcción, 1 transferencia galáctica o 1 impuesto extra." PointDepend="50" AwardItem="928:927:915:912:905:906:900:923:907" ItemNum="5:4:2:2:1:1:1:1:1" AccessProbability="30:30:10:10:5:5:2:3:5"/>
        <Level AwardID="3" AwardName="Premio de diamante" comment="Recibes 1 joya en bruto." PointDepend="70" AwardItem="1119" ItemNum="1" AccessProbability="100"/>
</AWARD>;
      
      public function GameRes_DailyAwardXml()
      {
         super();
      }
   }
}

