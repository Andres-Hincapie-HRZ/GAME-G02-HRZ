package
{
   public class GameRes_GMNotify
   {
      
      public static var data:XML = <data>
	<CustomTip Type="PopWnd" Rectangle="20,15,200,100" ResKey="GameRes" Visible="1" Enabled="0" Dragable="0" BackgroundColor="0x000000" BackgroundAlpha="1">
		<Content Type="Text" Rectangle="10,10,200,80" SText="S_X1_10" Font="Times New Roman" FontSize="12" FontColor="0xFFFFFF" Border="0" IsShow="1" Selectabled="0" WrapWord="1" TextDefault=""/>
		<NextIcon Type="Texture" ResKey="GameRes" Texture="Metal" IsShow="0" Rectangle="10,90,20,20" Visible="1"/>
		<NextIcon Type="Texture" ResKey="GameRes" Texture="He3" IsShow="0" Rectangle="10,90,20,20" Visible="1"/>
	</CustomTip>
</data>;
      
      public function GameRes_GMNotify()
      {
         super();
      }
   }
}

