package
{
   public class GameRes_ScienceInfoXml
   {
      
      public static var data:XML = <data>
	<ScienceInfo Type="PopWnd" Rectangle="20,15,295,236" ResKey="GameRes" Visible="1" Enabled="0" Dragable="0" BackgroundColor="0x000000" BackgroundAlpha="1">
		<BuildingName Type="Text" Rectangle="30,0,80,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xFFFFFF" Border="0" IsShow="1" Selectabled="0" TextDefault="Extractor de metal:"/>
		<BuildingLvTxt Type="Text" Rectangle="0,20,40,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xFFFFFF" Border="0" IsShow="1" Selectabled="0" TextDefault="Nv. 2"/>
		
		<CommentDesc Type="Text" Rectangle="0,40,250,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xFFFFFF" Border="0" IsShow="1" Selectabled="0" TextDefault="Un lugar para extraer y refinar metal. Mejóralo para aumentar la producción de metal."/>
		
		<MoneyIcon Type="Texture" ResKey="GameRes" Texture="Gold" IsShow="" Rectangle="0,80,16,16" Visible="1"/>
		<Moneytext Type="Text" Rectangle="30,80,50,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xFFFFFF" Border="0" IsShow="1" Selectabled="0 " TextDefault="30000"/>
		<TimeIcon Type="Texture" ResKey="GameRes" Texture="Time" IsShow="" Rectangle="0,110,16,16" Visible="1"/>
		<Timetext Type="Text" Rectangle="30,110,50,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xFFFFFF" Border="0" IsShow="1" Selectabled="0 " TextDefault="30000"/>
		
		<CashIcon Type="Texture" ResKey="GameRes" Texture="Fund" IsShow="" Rectangle="0,140,20,20" Visible="1"/>
		<Cashtext Type="Text" Rectangle="30,140,50,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xFFFFFF" Border="0" IsShow="1" Selectabled="0 " TextDefault="30000"/>
		
		<Context Type="Text" Rectangle="0,170,80,120" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xFFFFFF" Border="0" IsShow="1" Selectabled="0 " TextDefault="Descripción"/>
		
   </ScienceInfo>
</data>;
      
      public function GameRes_ScienceInfoXml()
      {
         super();
      }
   }
}

