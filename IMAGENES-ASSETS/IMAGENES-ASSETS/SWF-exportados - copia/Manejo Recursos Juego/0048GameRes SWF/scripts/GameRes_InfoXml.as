package
{
   public class GameRes_InfoXml
   {
      
      public static var data:XML = <data>
	<ResCapacityInfo Type="PopWnd" LayoutType="0" Spacing="4" Rectangle="20,15,295,236" ResKey="GameRes" Visible="1" Enabled="0" Dragable="0" BackgroundColor="0x000000" BackgroundAlpha="1">
		<BuildingName Type="Text" Rectangle="100,5,80,20" SText="S_X1_10" Font="Tahoma" FontSize="12" WrapWord="0" FontColor="0xccba7a" Border="0" IsShow="1" Selectabled="0" TextDefault="Metal Collecting Center:"/>
		<BuildingLvTxt Type="Text" Rectangle="220,5,230,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0x00ff00" Border="0" IsShow="1" Selectabled="0" TextDefault="Lv2"/>
		<CommentDesc Type="Text" Rectangle="10,25,260,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xFFFFFF" Border="0" IsShow="1" Selectabled="0" TextDefault="A place to extract and refine metal. Upgrade to increase the production of metal."/>
		<LevelCommentDesc Type="Text" Rectangle="10,50,260,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xFFFFFF" Border="0" IsShow="0" Selectabled="0" TextDefault=""/>
		
		<ConMapIcon Type="Texture" ResKey="GameRes" Texture="Metal" IsShow="1" Rectangle="10,90,20,20" Visible="1"/>
		<UpgradeMetalDependTxt Type="Text" Rectangle="30,90,100,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0x00ff00" Border="0" IsShow="1" Selectabled="0 " TextDefault="20000"/>
		<ConMapIcon Type="Texture" ResKey="GameRes" Texture="He3" IsShow="1" Rectangle="10,110,20,20" Visible="1"/>
		<UpgradeHe3DependTTxt Type="Text" Rectangle="30,110,100,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0x00ff00" Border="0" IsShow="1" Selectabled="0 " TextDefault="30000"/>
		<ConMapIcon Type="Texture" ResKey="GameRes" Texture="Gold" IsShow="1" Rectangle="10,130,20,20" Visible="1"/>
		<UpgradeMoneyDependTTxt Type="Text" Rectangle="30,130,100,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0x00ff00" Border="0" IsShow="1" Selectabled="0 " TextDefault="30000"/>
		<UpgradeTime Type="Text" Rectangle="10,160,80,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xccba7a" Border="0" IsShow="1" Selectabled="0 " TextDefault="Time Cost"/>
		<UpgradeTimeTxt Type="Text" Rectangle="90,160,100,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0x00ff00" Border="0" IsShow="1" Selectabled="0 " TextDefault=""/>
		<UpgradeDepend Type="Text" Rectangle="10,180,80,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xccba7a" Border="0" IsShow="0" Selectabled="0 " TextDefault="Upgrade Condition"/>
		<UpgradeDependTxt Type="Text" Rectangle="90,180,150,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xFFFFFF" Border="0" WrapWord="0" IsShow="0" Selectabled="0 " TextDefault=""/>
		<ConstructionNumTxt Type="Text" Rectangle="90,200,100,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xff0000" WrapWord="0" Border="0" IsShow="0" Selectabled="0 " TextDefault="(Upper limit reached)"/>
   </ResCapacityInfo>
</data>;
      
      public function GameRes_InfoXml()
      {
         super();
      }
   }
}

