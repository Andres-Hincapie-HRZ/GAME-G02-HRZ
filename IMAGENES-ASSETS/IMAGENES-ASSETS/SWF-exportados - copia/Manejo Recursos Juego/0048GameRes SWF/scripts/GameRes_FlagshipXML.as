package
{
   public class GameRes_FlagshipXML
   {
      
      public static var data:XML = <Flagship Name="旗舰配置">
  <List ID="0" Name="旗舰配置">
    <List0 PropsId="-1" NeedParts="3000:200;3001:200;3002:200;3003:200;3004:200" NeedMoney="500000"/>
	<List1 PropsId="876" NeedParts="3000:100;3001:100;3002:100" NeedMoney="300000"/>
	<List2 PropsId="877" NeedParts="3001:100;3002:100;3003:100" NeedMoney="300000"/>
	<List3 PropsId="878" NeedParts="3000:80;3001:80;3002:80;3003:80" NeedMoney="300000"/>
	<List4 PropsId="879" NeedParts="3000:900;3001:900;3004:900" NeedMoney="500000" Hide="1"/>
	<List5 PropsId="880" NeedParts="3000:250;3004:60" NeedMoney="500000"/>
	<List6 PropsId="881" NeedParts="3000:80;3001:80;3002:80;3003:80;3004:50" NeedMoney="500000"/>
	<List7 PropsId="882" NeedParts="3001:180;3002:180;3003:60" NeedMoney="500000"/>
	<List8 PropsId="883" NeedParts="3000:900;3001:900;3004:900" NeedMoney="500000" Hide="1"/>
	<List9 PropsId="4460" NeedParts="3000:900;3001:900;3004:900" NeedMoney="500000" Hide="1"/>
	<List10 PropsId="4459" NeedParts="3000:900;3001:900;3004:900" NeedMoney="500000" Hide="1"/>
  </List>
  <List ID="1" Name="宝藏刷新时间">
    <List0 RefreshTime="3600" Props="3101:30:30;3200:10:10;4489:5:5;4490:5:5" MinLevel="1" MaxLevel="4" MinNum="5" MaxNum="5" Destroytime="14400"/>
    <List1 RefreshTime="3600" Props="3101:40:40;3200:20:20;4489:5:5;4490:5:5" MinLevel="1" MaxLevel="4" MinNum="10" MaxNum="10" Destroytime="14400"/>
    <List2 RefreshTime="3600" Props="3101:50:50;3200:30:30;4489:7:7;4490:7:7" MinLevel="1" MaxLevel="4" MinNum="15" MaxNum="15" Destroytime="14400"/>
    <List3 RefreshTime="3600" Props="3101:70:70;3200:40:40;4489:7:7;4490:7:7" MinLevel="1" MaxLevel="4" MinNum="20" MaxNum="20" Destroytime="14400"/>
    <List4 RefreshTime="3600" Props="3101:90:90;3200:50:50;4489:10:10;4490:10:10" MinLevel="1" MaxLevel="4" MinNum="25" MaxNum="25" Destroytime="14400"/>
    <List5 RefreshTime="3600" Props="3101:130:130;3200:60:60;4489:10:10;4490:10:10" MinLevel="1" MaxLevel="5" MinNum="30" MaxNum="30" Destroytime="14400"/>
    <List6 RefreshTime="3600" Props="3101:200:200;3200:75:75;4489:12:12;4490:12:12" MinLevel="1" MaxLevel="5" MinNum="40" MaxNum="40" Destroytime="14400"/>
    <List7 RefreshTime="3600" Props="3101:290:290;3200:90:90;4489:12:12;4490:12:12" MinLevel="1" MaxLevel="5" MinNum="55" MaxNum="55" Destroytime="14400"/>
    <List8 RefreshTime="3600" Props="3101:400:400;3200:110:110;4489:15:15;4490:15:15" MinLevel="1" MaxLevel="5" MinNum="75" MaxNum="75" Destroytime="14400"/>
    <List9 RefreshTime="3600" Props="3101:530:530;3200:135:135;4489:15:15;4490:15:15" MinLevel="1" MaxLevel="5" MinNum="100" MaxNum="100" Destroytime="14400"/>
	<List10 RefreshTime="3600" Props="3101:600:600;3200:150:150;3004:10:10" MinLevel="1" MaxLevel="5" MinNum="100" MaxNum="100" Destroytime="14400"/>
	<List11 RefreshTime="3600" Props="3101:650:650;3200:200:200;4594:1:1" MinLevel="1" MaxLevel="5" MinNum="100" MaxNum="100" Destroytime="14400"/>
	<List12 RefreshTime="3600" Props="3101:700:700;3200:250:250;4595:1:1" MinLevel="1" MaxLevel="5" MinNum="100" MaxNum="100" Destroytime="14400"/>
	<List13 RefreshTime="3600" Props="3101:750:750;3200:300:300;4595:1:1" MinLevel="1" MaxLevel="5" MinNum="100" MaxNum="100" Destroytime="14400"/>
	<List14 RefreshTime="3600" Props="3101:900:900;3200:350:350;4596:1:1" MinLevel="1" MaxLevel="5" MinNum="100" MaxNum="100" Destroytime="14400"/>
	
	
  </List>
  <List ID="2" Name="背包芯片">
    <List0 OpenMall="1"/>
    <List1 OpenMall="2"/>
    <List2 OpenMall="3"/>
    <List3 OpenMall="4"/>
    <List4 OpenMall="5"/>
    <List5 OpenMall="6"/>
    <List6 OpenMall="7"/>
    <List7 OpenMall="8"/>
    <List8 OpenMall="9"/>
    <List9 OpenMall="10"/>
    <List10 OpenMall="11"/>
    <List11 OpenMall="12"/>
    <List12 OpenMall="13"/>
    <List13 OpenMall="14"/>
    <List14 OpenMall="15"/>
  </List>
  <List ID="3" Name="克制关系">
    <List Flagship="1" Comment="旗舰标志编号必须大于0开始">
      <List Flagship="6" Ratio="0.1"/>
    </List>
    <List Flagship="2">
      <List Flagship="1" Ratio="0.1"/>
    </List>
    <List Flagship="3">
      <List Flagship="2" Ratio="0.1"/>
    </List>
    <List Flagship="4">
      <List Flagship="3" Ratio="0.1"/>
    </List>
    <List Flagship="5">
      <List Flagship="4" Ratio="0.1"/>
    </List>
    <List Flagship="6">
      <List Flagship="5" Ratio="0.1"/>
    </List>
    <List Flagship="7">
      <List Flagship="0" Ratio="0.1"/>
    </List>
	 <List Flagship="8">
      <List Flagship="1" Ratio="0.1"/>
      <List Flagship="2" Ratio="0.1"/>
      <List Flagship="3" Ratio="0.1"/>
      <List Flagship="4" Ratio="0.1"/>
      <List Flagship="5" Ratio="0.1"/>
      <List Flagship="6" Ratio="0.1"/>
      <List Flagship="7" Ratio="0.1"/>
      <List Flagship="8" Ratio="0.1"/>
	  <List Flagship="9" Ratio="0.1"/>
	  <List Flagship="10" Ratio="0.1"/>
    </List>
	 <List Flagship="9">
      <List Flagship="7" Ratio="0.1"/>
    </List>
	 <List Flagship="10">
      <List Flagship="9" Ratio="0.1"/>
    </List>
	<List Flagship="11">
      <List Flagship="13" Ratio="0.1"/>
    </List>
	<List Flagship="12">
      <List Flagship="11" Ratio="0.1"/>
    </List>
	<List Flagship="13">
      <List Flagship="12" Ratio="0.1"/>
    </List>
	<List Flagship="14">
      <List Flagship="13" Ratio="0.1"/>
    </List>
	<List Flagship="15">
      <List Flagship="14" Ratio="0.1"/>
    </List>
	
  </List>
</Flagship>;
      
      public function GameRes_FlagshipXML()
      {
         super();
      }
   }
}

