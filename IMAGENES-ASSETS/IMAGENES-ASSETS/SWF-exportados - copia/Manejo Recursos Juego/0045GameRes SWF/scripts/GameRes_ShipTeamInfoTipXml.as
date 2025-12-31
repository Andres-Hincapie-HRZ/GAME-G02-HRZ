package
{
   public class GameRes_ShipTeamInfoTipXml
   {
      
      public static var data:XML = <data>
	<ShipTeamInfoTip Type="PopWnd" LayoutType="-1" Rectangle="20,15,325,266" ResKey="GameRes" Visible="1" Enabled="0" Dragable="0" BackgroundColor="0x000000" BackgroundAlpha="1">
		<ShipName Type="Text" Rectangle="10,10,180,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xFFFFFF" Border="0" IsShow="1" Selectabled="0" TextDefault="adfadfasdf"/>
		
		<CommanderIcon Type="Texture" Rectangle="10,30,50,50" ResKey="GameRes" Texture="Metal" IsShow="1" Visible="1"/>
		
		<CommanderNameTxt Type="Text" Rectangle="60,30,150,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xFFFFFF" Border="0" IsShow="1" Selectabled="0" TextDefault="Commander:"/>
		<CommanderName Type="Text" Rectangle="100,30,150,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xFFFFFF" Border="0" IsShow="1" Selectabled="0" TextDefault=""/>
		
		<CommandLevelTxt Type="Text" Rectangle="60,50,150,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xFFFFFF" Border="0" IsShow="1" Selectabled="0 " TextDefault="LV:"/>
		<CommandLevel Type="Text" Rectangle="100,50,150,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xFFFFFF" Border="0" IsShow="1" Selectabled="0 " TextDefault=""/>
		
		<UserNameTxt Type="Text" Rectangle="10,80,150,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xFFFFFF" Border="0" IsShow="1" Selectabled="0 " TextDefault="Owner:"/>
		<UserName Type="Text" Rectangle="60,80,150,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xFFFFFF" Border="0" IsShow="1" Selectabled="0 " TextDefault=""/>
		
		<CropsTxt Type="Text" Rectangle="10,100,150,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xFFFFFF" Border="0" IsShow="1" Selectabled="0 " TextDefault="Corps:"/>
		<Crops Type="Text" Rectangle="60,100,150,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xFFFFFF" Border="0" IsShow="1" Selectabled="0 " TextDefault=""/>
		
		<He3Txt Type="Text" Rectangle="10,120,150,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xFFFFFF" Border="0" IsShow="1" Selectabled="0 " TextDefault="He3:"/>	
		<He3 Type="Text" Rectangle="60,120,150,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xFFFFFF" Border="0" IsShow="1" Selectabled="0 " TextDefault="12341234"/>	
	</ShipTeamInfoTip>
</data>;
      
      public function GameRes_ShipTeamInfoTipXml()
      {
         super();
      }
   }
}

