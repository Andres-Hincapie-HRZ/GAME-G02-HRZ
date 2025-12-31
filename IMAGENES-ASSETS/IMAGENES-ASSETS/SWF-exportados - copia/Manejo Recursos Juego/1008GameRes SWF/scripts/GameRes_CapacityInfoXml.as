package
{
   public class GameRes_CapacityInfoXml
   {
      
      public static var data:XML = <data>
	<CapacityInfo Type="PopWnd" Rectangle="20,15,295,236" ResKey="GameRes" Visible="1" Enabled="0" Dragable="0" BackgroundColor="0x000000" BackgroundAlpha="1">
		<BuildingName Type="Text" Rectangle="70,5,80,20" SText="S_X1_10" Font="Tahoma" WrapWord="0" FontSize="12" FontColor="0xccba7a" Border="0" IsShow="1" Selectabled="0" TextDefault="Recursos almacenados:"/>
		<BuildingLvTxt Type="Text" Rectangle="150,5,180,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0x00ff00" Anchor="1" Border="0" IsShow="1" Selectabled="0" TextDefault="Lv1"/>
		<Comment1 Type="Text" Rectangle="60,30,60,20" SText="S_X1_10" Font="Tahoma" FontSize="12" WrapWord="0" FontColor="0xccba7a" Border="0" IsShow="1" Selectabled="0" TextDefault="Capacidad actual"/>
		<Comment2 Type="Text" Rectangle="130,30,60,20" SText="S_X1_10" Font="Tahoma" FontSize="12" WrapWord="0" FontColor="0xccba7a" Border="0" Anchor="1" IsShow="1" Selectabled="0" TextDefault="Capacidad máx."/>		

		<Metal Type="Text" Rectangle="10,50,70,20" SText="S_X1_10" Font="Tahoma" FontSize="12" WrapWord="0" FontColor="0xccba7a" Border="0" IsShow="1" Selectabled="0 " TextDefault="Metal: "/>
		<MetalCurrentTXT Type="Text" Rectangle="80,50,70,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0x00ff00" Border="0" IsShow="1" Selectabled="0 " TextDefault="1"/>	
		<MetalmaxTXT Type="Text" Rectangle="150,50,70,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0x00ff00" Border="0" IsShow="1" Selectabled="0 " TextDefault="1"/>	

		<He3 Type="Text" Rectangle="10,70,70,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xccba7a" Border="0" IsShow="1" Selectabled="0 " TextDefault="He3: "/>
		<He3CurrentTXT Type="Text" Rectangle="80,70,70,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0x00ff00" Border="0" IsShow="1" Selectabled="0 " TextDefault="1"/>	
		<He3MaxTXT Type="Text" Rectangle="150,70,70,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0x00ff00" Border="0" IsShow="1" Selectabled="0 " TextDefault="1"/>	

		<Money Type="Text" Rectangle="10,90,70,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xccba7a" Border="0" IsShow="1" Selectabled="0 " TextDefault="Oro: "/>
		<MoneyCurrentTXT Type="Text" Rectangle="80,90,70,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0x00ff00" Border="0" IsShow="1" Selectabled="0 " TextDefault="1"/>	
		<MoneyMaxTXT Type="Text" Rectangle="150,90,70,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0x00ff00" Border="0" IsShow="1" Selectabled="0 " TextDefault="1"/>	
	</CapacityInfo>
</data>;
      
      public function GameRes_CapacityInfoXml()
      {
         super();
      }
   }
}

