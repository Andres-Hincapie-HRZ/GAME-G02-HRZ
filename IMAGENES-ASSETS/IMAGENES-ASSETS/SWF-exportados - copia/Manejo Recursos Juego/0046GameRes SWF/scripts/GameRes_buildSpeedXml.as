package
{
   public class GameRes_buildSpeedXml
   {
      
      public static var data:XML = <Part ID="1" Name="Speed Up">
	<BuildingSpeed Type="0">
	 <List0 Name="Reduce 30 mins" Time="1800" Credit="3"/>
 	 <List1 Name="Reduce 2 h" Time="7200" Credit="12"/>
 	 <List2 Name="Reduce 8 h" Time="28800" Credit="48"/>
 	 <List3 Name="Reduce 24 h" Time="86400" Credit="144"/>
 	 <List4 Name="Complete" Time="0" Credit="0" Variable="600"/>
	</BuildingSpeed>

	<TechSpeed Type="1">
	 <List0 Name="Reduce 30mins" Time="1800" Credit="3"/>
	 <List1 Name="Reduce 2h" Time="7200" Credit="12"/>
	 <List2 Name="Reduce 8h" Time="28800" Credit="48"/>
	 <List3 Name="Reduce 24h" Time="86400" Credit="144"/>
 	 <List4 Name="Complete" Time="0" Credit="0" Variable="600"/>
	</TechSpeed>

	<ShipSpeed Type="2">
 	 <List0 Name="Reduce 30mins" Time="1800" Credit="8"/>
 	 <List1 Name="Reduce 2h" Time="7200" Credit="32"/>
 	 <List2 Name="Reduce 8h" Time="28800" Credit="128"/>
 	 <List3 Name="Reduce 24h" Time="86400" Credit="384"/>
 	 <List4 Name="Complete" Time="0" Credit="0" Variable="225"/>
	</ShipSpeed>
</Part>;
      
      public function GameRes_buildSpeedXml()
      {
         super();
      }
   }
}

