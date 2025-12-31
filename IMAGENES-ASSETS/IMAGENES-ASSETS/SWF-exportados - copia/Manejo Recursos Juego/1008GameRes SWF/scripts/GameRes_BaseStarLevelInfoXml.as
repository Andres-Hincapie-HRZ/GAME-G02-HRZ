package
{
   public class GameRes_BaseStarLevelInfoXml
   {
      
      public static var data:XML = <data>
	<!--
	<CapacityInfo Type="PopWnd"  Spacing="2" Rectangle="20,15,295,236" ResKey="GameRes" Visible="1" Enabled="0" Dragable="0" BackgroundColor="0x000000" BackgroundAlpha="1">
		<BuildingName Type="Text" Rectangle="10,10,80,20"  SText="S_X1_10"  Font="Tahoma" FontSize="12" FontColor="0xFFFFFF" Border="0" IsShow="1" Selectabled="0" TextDefault="Resource Storage:"/>
		<BuildingLvTxt Type="Text" Rectangle="120,10,60,20"  SText="S_X1_10"  Font="Tahoma" FontSize="12" FontColor="0x00ff00" Border="0" IsShow="1" Selectabled="0" TextDefault="Lv1"/>
		<CommentDesc Type="Text" Rectangle="10,50,250,20"  SText="S_X1_10"  Font="Tahoma" FontSize="12" FontColor="0xFFFFFF" Border="0" IsShow="1" Selectabled="0" TextDefault="開採及提煉金屬的場所，升級可增加產量。"/>
		<LevelCommentDesc Type="Text" Rectangle="10,70,250,20"  SText="S_X1_10"  Font="Tahoma" FontSize="12" FontColor="0xFFFFFF" Border="0" IsShow="0" Selectabled="0" TextDefault=""/>
		<StateDesc Type="Text" Rectangle="10,200,150,20"  SText="S_X1_10"  Font="Tahoma" FontSize="12" FontColor="0xFF0000" Border="0" IsShow="1" Selectabled="0" TextDefault="(Can only be upgraded by a Colonel)"/>
     </CapacityInfo>
     -->
     <CapacityInfo Type="PopWnd" LayoutType="0" Spacing="2" Rectangle="20,15,295,236" ResKey="GameRes" Visible="1" Enabled="0" Dragable="0" BackgroundColor="0x000000" BackgroundAlpha="1">
		<BuildingName Type="Text" Rectangle="10,10,80,20" SText="S_X1_10" Font="Tahoma" WrapWord="0" FontSize="12" FontColor="0xccba7a" Border="0" IsShow="1" Selectabled="0" TextDefault="Recursos almacenados:"/>
		<BuildingLvTxt Type="Text" Rectangle="140,10,100,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0x00ff00" Border="0" IsShow="1" Selectabled="0" TextDefault="Lv1"/>
		
		<CommentDesc Type="Text" Rectangle="10,50,250,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xFFFFFF" Border="0" IsShow="0" Selectabled="0" TextDefault="Un lugar para extraer y refinar metal. Mejóralo para aumentar la producción de metal."/>
		<LevelCommentDesc Type="Text" Rectangle="10,70,250,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xFFFFFF" Border="0" IsShow="0" Selectabled="0" TextDefault=""/>
		
		<DescTxt Type="Text" Rectangle="10,40,100,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xccba7a" Border="0" IsShow="0" Selectabled="0" TextDefault="Bonus de nivel actual:"/>
		
		<MetalOut Type="Text" Rectangle="10,60,120,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xccba7a" Border="0" IsShow="0" Selectabled="0" TextDefault="Producción de metal:"/>
		<MetalOutTxt Type="Text" Rectangle="140,60,100,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0x00ff00" Border="0" IsShow="0" Selectabled="0" TextDefault=""/>
		
		<He3Out Type="Text" Rectangle="10,80,120,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xccba7a" Border="0" IsShow="0" Selectabled="0" TextDefault="Producción de He3:"/>
		<He3OutTxt Type="Text" Rectangle="140,80,100,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0x00ff00" Border="0" IsShow="0" Selectabled="0" TextDefault=""/>
		
		<MoneyOut Type="Text" Rectangle="10,100,120,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xccba7a" Border="0" IsShow="0" Selectabled="0" TextDefault="Producción de oro:"/>
		<MoneyOutTxt Type="Text" Rectangle="140,100,100,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0x00ff00" Border="0" IsShow="0" Selectabled="0" TextDefault=""/>
		
		<MakeShipOut Type="Text" Rectangle="10,120,120,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xccba7a" Border="0" IsShow="0" Selectabled="0" TextDefault="Tasa de construcción de naves:"/>
		<MakeShipOutTxt Type="Text" Rectangle="140,120,100,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0x00ff00" Border="0" IsShow="0" Selectabled="0" TextDefault=""/>
		
		<TechResearchOut Type="Text" Rectangle="10,140,120,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xccba7a" Border="0" IsShow="0" Selectabled="0" TextDefault="Tasa de investigación científica:"/>
		<TechResearchTxt Type="Text" Rectangle="140,140,100,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0x00ff00" Border="0" IsShow="0" Selectabled="0" TextDefault=""/>
		
		<CommentDesc Type="Text" Rectangle="10,260,150,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xFF0000" WrapWord="0" Border="1" IsShow="1" Selectabled="0" TextDefault="Solo un coronel puede hacer mejoras."/>
     </CapacityInfo>
</data>;
      
      public function GameRes_BaseStarLevelInfoXml()
      {
         super();
      }
   }
}

