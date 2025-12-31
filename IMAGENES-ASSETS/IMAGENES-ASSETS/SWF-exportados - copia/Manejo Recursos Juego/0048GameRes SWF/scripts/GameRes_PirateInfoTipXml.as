package
{
   public class GameRes_PirateInfoTipXml
   {
      
      public static var data:XML = <data>
	<PirateInfo Type="PopWnd" LayoutType="-1" Spacing="2" Rectangle="10,10,150,246" ResKey="GameRes" Visible="1" Enabled="0" Dragable="0" BackgroundColor="0x000000" BackgroundAlpha="1">
		<PirateName Type="Text" Rectangle="10,5,80,20" SText="S_X1_10" Font="Times New Roman" FontSize="12" FontColor="0xccba7a" Border="0" IsShow="1" Selectabled="0" TextDefault="Lv："/>
		<Level Type="Text" Rectangle="90,5,40,20" SText="S_X1_10" Font="Times New Roman" FontSize="12" FontColor="0x00ff00" Border="0" IsShow="1" Selectabled="0" TextDefault=""/>

		<Caption1 Type="Text" Rectangle="10,35,100,20" SText="S_X1_10" Font="Times New Roman" FontSize="12" FontColor="0xccba7a" Border="0" IsShow="1" Selectabled="0" TextDefault=""/>
		<Value1 Type="Text" Rectangle="90,35,40,20" SText="S_X1_10" Font="Times New Roman" FontSize="12" FontColor="0x00ff00" Border="0" IsShow="1" Selectabled="0" TextDefault=""/>

		<Caption2 Type="Text" Rectangle="10,60,100,20" SText="S_X1_10" Font="Times New Roman" FontSize="12" FontColor="0xccba7a" Border="0" IsShow="1" Selectabled="0" TextDefault=""/>
		<Aim Type="Texture" ResKey="GameRes" Texture="ToolReward" IsShow="" Rectangle="90,60,20,20" Visible="1"/>
		<Value2 Type="Text" Rectangle="110,60,40,20" SText="S_X1_10" Font="Times New Roman" FontSize="12" FontColor="0x00ff00" Border="0" IsShow="1" Selectabled="0" TextDefault=""/>

		<Caption3 Type="Text" Rectangle="10,85,100,20" SText="S_X1_10" Font="Times New Roman" FontSize="12" FontColor="0xccba7a" Border="0" IsShow="1" Selectabled="0" TextDefault=""/>
		<Value3 Type="Text" Rectangle="90,85,200,20" SText="S_X1_10" Font="Times New Roman" FontSize="12" FontColor="0xff0000" Border="0" IsShow="1" Selectabled="0" TextDefault=""/>
		<Value4 Type="Text" Rectangle="90,110,200,20" SText="S_X1_10" Font="Times New Roman" FontSize="12" FontColor="0xff0000" Border="0" IsShow="1" Selectabled="0" TextDefault=""/>

		<Comment Type="Text" Rectangle="10,135,200,40" SText="S_X1_10" Font="Times New Roman" FontSize="12" FontColor="0xFFFFFF" Border="0" IsShow="1" WrapWord="1" Selectabled="0" TextDefault="" AutoSize="left"/>
   </PirateInfo>
</data>;
      
      public function GameRes_PirateInfoTipXml()
      {
         super();
      }
   }
}

