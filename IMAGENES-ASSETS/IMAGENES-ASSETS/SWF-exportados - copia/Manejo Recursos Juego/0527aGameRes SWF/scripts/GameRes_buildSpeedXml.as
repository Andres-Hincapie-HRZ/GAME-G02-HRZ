package
{
   public class GameRes_buildSpeedXml
   {
      
      public static var data:XML = <Part ID="1" Name="Speed Up">
	<BuildingSpeed Type="0">
	 <List0 Name="Reducir 30 minutos" Time="1800" Credit="3"/>
 	 <List1 Name="Reducir 2 horas" Time="7200" Credit="12"/>
 	 <List2 Name="Reducir 8 horas" Time="28800" Credit="48"/>
 	 <List3 Name="Reducir 24 horas" Time="86400" Credit="144"/>
 	 <List4 Name="Completa" Time="0" Credit="0" Variable="600"/>
	</BuildingSpeed>

	<TechSpeed Type="1">
	 <List0 Name="Reducir 30 minutos" Time="1800" Credit="3"/>
	 <List1 Name="Reducir 2 horas" Time="7200" Credit="12"/>
	 <List2 Name="Reducir 8 horas" Time="28800" Credit="48"/>
	 <List3 Name="Reducir 24 horas" Time="86400" Credit="144"/>
 	 <List4 Name="Completa" Time="0" Credit="0" Variable="600"/>
	</TechSpeed>

	<ShipSpeed Type="2">
 	 <List0 Name="Reducir 30 minutos" Time="1800" Credit="8"/>
 	 <List1 Name="Reducir 2 horas" Time="7200" Credit="32"/>
 	 <List2 Name="Reducir 8 horas" Time="28800" Credit="128"/>
 	 <List3 Name="Reducir 24 horas" Time="86400" Credit="384"/>
 	 <List4 Name="Completa" Time="0" Credit="0" Variable="225"/>
	</ShipSpeed>
</Part>;
      
      public function GameRes_buildSpeedXml()
      {
         super();
      }
   }
}

