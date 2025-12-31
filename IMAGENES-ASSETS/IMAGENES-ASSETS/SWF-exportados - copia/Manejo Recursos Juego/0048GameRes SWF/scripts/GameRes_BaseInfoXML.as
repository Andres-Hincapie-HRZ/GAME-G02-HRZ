package
{
   public class GameRes_BaseInfoXML
   {
      
      public static var data:XML = <data>
	<CapacityInfo Type="PopWnd" LayoutType="0" Spacing="6" Rectangle="20,15,295,236" ResKey="GameRes" Visible="1" Enabled="0" Dragable="0" BackgroundColor="0x000000" BackgroundAlpha="1">
		<BuildingName Type="Text" Rectangle="10,10,100,20" SText="S_X1_10" Font="Tahoma" FontSize="12" WrapWord="0" FontColor="0xccba7a" AutoSize="left" Border="0" IsShow="1" Selectabled="0" TextDefault="Resource Storage:"/>
		<BuildingLvTxt Type="Text" Rectangle="120,10,120,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0x00ff00" Anchor="1" Border="0" IsShow="1" Selectabled="0" TextDefault="Lv1"/>
		<CommentDesc Type="Text" Rectangle="10,50,250,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xFFFFFF" Border="0" IsShow="1" Selectabled="0" TextDefault="A place to extract and refine metal. Upgrade to increase the production of metal."/>
     	<LevelCommentDesc Type="Text" Rectangle="10,70,250,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0x00ff00" Border="0" IsShow="1" Selectabled="0" TextDefault="12312"/>
     	<RepairTimeDesc Type="Text" Rectangle="10,90,70,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xff0000" Border="0" IsShow="1" Selectabled="0" TextDefault="Repair Time:"/>
     	<RepairTimeTxt Type="Text" Rectangle="70,90,150,20" SText="S_X1_10" Font="Tahoma" FontSize="12" FontColor="0xff0000" Border="0" IsShow="1" Selectabled="0" TextDefault="00:00:00"/>
     </CapacityInfo>
</data>;
      
      public function GameRes_BaseInfoXML()
      {
         super();
      }
   }
}

