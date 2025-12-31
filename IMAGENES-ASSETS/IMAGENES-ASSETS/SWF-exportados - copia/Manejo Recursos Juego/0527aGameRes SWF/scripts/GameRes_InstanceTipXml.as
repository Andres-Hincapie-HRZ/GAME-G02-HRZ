package
{
   public class GameRes_InstanceTipXml
   {
      
      public static var data:XML = <data>
	<InstanceTip Tpye="PopWnd" LayoutType="0" Rectangle="20,0,325,366" ResKey="GameRes" Visible="1" Enabled="0" Dragable="0" BackgroundColor="0x00FFFF" BackgroundAlpha="1">
		<FBName Type="Text" Rectangle="10,10,280,20" SText="S_X1_18" Font="Tahoma" FontSize="18" FontColor="0xCC3399" Border="0" IsShow="1" Selectabled="0" TextDefault="    Nada"/>
		
		<FBDiscTxt Type="Text" Rectangle="10,30,80,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0x99FFFF" Border="0" IsShow="1" Selectabled="0" TextDefault="Descripción: "/>
		<FBDisc Type="Text" Rectangle="10,42,230,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0x65FFCC" Border="0" IsShow="1" Selectabled="0" TextDefault="" AutoSize="left"/>
		
		<AssiqnmentTxt Type="Text" Rectangle="10,290,180,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0x99FFFF" Border="0" IsShow="1" Selectabled="0" TextDefault="Desafío:"/>
		<Assiqnment Type="Text" Rectangle="10,290,180,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0x65FFCC" Border="0" IsShow="1" Selectabled="0" TextDefault=""/>
		
		<FBMaxUserTxt Type="Text" Rectangle="10,150,110,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xFFFFFF" Border="0" IsShow="1" Selectabled="0" TextDefault="Jugadores máx.:"/>
		<FBMaxUser Type="Text" Rectangle="100,150,80,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xFFFFFF" Border="0" IsShow="1" Selectabled="0" TextDefault="99999999"/>
		
		<FBMaxTeamTxt Type="Text" Rectangle="10,170,80,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xFFFFFF" Border="0" IsShow="1" Selectabled="0" TextDefault="Flotas máx.:"/>
		<FBMaxTeam Type="Text" Rectangle="100,170,80,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xFFFFFF" Border="0" IsShow="1" Selectabled="0" TextDefault="999999999"/>
		
		<!--FBMaxShipTxt Type="Text" Rectangle="10,190,80,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xFFFFFF" Border="0" IsShow="1" Selectabled="0" TextDefault="最大舰船数量"/>
		<FBMaxShip Type="Text" Rectangle="90,190,80,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xFFFFFF" Border="0" IsShow="1" Selectabled="0" TextDefault="999999"/-->
		
		<FBMaxGateTxt Type="Text" Rectangle="10,190,80,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xFFFFFF" Border="0" IsShow="1" Selectabled="0" TextDefault="Controles:"/>
		<FBMaxGate Type="Text" Rectangle="100,190,80,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xFFFFFF" Border="0" IsShow="1" Selectabled="0" TextDefault="999999"/>
		
		<FBExpTxt Type="Text" Rectangle="10,210,80,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xFFFFFF" Border="0" IsShow="1" Selectabled="0" TextDefault="EXP.:"/>
		<FBExp Type="Text" Rectangle="100,210,80,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xFFFFFF" Border="0" IsShow="1" Selectabled="0" TextDefault="999999"/>
		
		<FBRewardTxt Type="Text" Rectangle="10,230,80,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xFFFFFF" Border="0" IsShow="1" Selectabled="0" TextDefault="Premios:"/>
		<FBRewardName Type="Text" Rectangle="10,250,220,20" SText="S_X1_10" Font="Times New Roman" FontSize="12" FontColor="0xFFFFFF" Border="0" IsShow="1" Selectabled="0" TextDefault="[999999]"/>
		<FBRewardName2 Type="Text" Rectangle="10,270,220,260" SText="S_X1_10" Font="Timess New Roman" FontSize="12" FontColor="0xFFFFFF" Border="0" IsShow="1" Selectabled="0" TextDefault=""/>
		<FBReward Type="Texture" Rectangle="10,295,80,30" ResKey="GameRes" Texture="Metal" IsShow="1" Visible="1"/>
		<FBReward2 Type="Texture" Rectangle="70,295,150,30" ResKey="GameRes" Texture="" IsShow="1" Visible="1"/>
		
		<NeedTxt Type="Text" Rectangle="10,320,180,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0x99FFFF" Border="0" IsShow="1" Selectabled="0" TextDefault="Completa antes la misión:"/>
		<NeedName Type="Text" Rectangle="155,320,180,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0x65FFCC" Border="0" IsShow="1" Selectabled="0" TextDefault=""/>
	</InstanceTip>
</data>;
      
      public function GameRes_InstanceTipXml()
      {
         super();
      }
   }
}

