package
{
   public class GameRes_StarInfoTipXml
   {
      
      public static var data:XML = <data>
	<StarInfoTip Type="PopWnd" LayoutType="-1" Rectangle="20,15,295,236" ResKey="GameRes" Visible="1" Enabled="0" Dragable="0" BackgroundColor="0x000000" BackgroundAlpha="1">
		<UesrLevel Type="Text" Rectangle="10,10,60,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xFFFFFF" Border="0" IsShow="1" Selectabled="0" TextDefault="LV:"/>
		<UserGuid Type="Text" Rectangle="80,10,150,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xFFFFFF" Border="0" IsShow="1" Selectabled="0" TextDefault="ID:"/>
		<UserImag Type="Texture" ResKey="GameRes" Texture="Metal" IsShow="1" Rectangle="10,40,50,50" Visible="1"/>
		<Location Type="Text" Rectangle="80,40,150,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xFFFFFF" Border="0" IsShow="1" Selectabled="0 " TextDefault="Coordinates"/>
		<Corps Type="Text" Rectangle="80,70,150,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xFFFFFF" Border="0" IsShow="1" Selectabled="0 " TextDefault="Corps "/>
		<Status Type="Text" Rectangle="80,100,150,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xFFFFFF" Border="0" IsShow="1" Selectabled="0 " TextDefault="Status"/>
		<UserName Type="Text" Rectangle="10,100,50,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xFFFFFF" Border="0" IsShow="1" Selectabled="0 " TextDefault="Name"/>
   </StarInfoTip>
</data>;
      
      public function GameRes_StarInfoTipXml()
      {
         super();
      }
   }
}

