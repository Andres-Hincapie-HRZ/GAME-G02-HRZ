package
{
   public class GameRes_OthersXml
   {
      
      public static var data:XML = <Others Name="其它">
  <List ID="0" Name="靈敏度">
    <List0 Min="0" Max="3.9" TypeName="低"/>
    <List1 Min="4" Max="6.9" TypeName="較低"/>
    <List2 Min="7" Max="9.9" TypeName="中等"/>
    <List3 Min="10" Max="12.9" TypeName="較高"/>
    <List4 Min="13" Max="16" TypeName="高"/>
  </List>
  <List ID="1" Name="防禦力">
    <List0 Min="0" Max="3.9" TypeName="低"/>
    <List1 Min="4" Max="6.9" TypeName="較低"/>
    <List2 Min="7" Max="9.9" TypeName="中等"/>
    <List3 Min="10" Max="12.9" TypeName="較高"/>
    <List4 Min="13" Max="16" TypeName="高"/>
  </List>
  <List ID="2" Name="穩固率">
    <List0 Min="0" Max="60" TypeName="低"/>
    <List1 Min="61" Max="120" TypeName="較低"/>
    <List2 Min="121" Max="180" TypeName="中等"/>
    <List3 Min="181" Max="240" TypeName="較高"/>
    <List4 Min="241" Max="300" TypeName="高"/>
  </List>
  <List ID="3" Name="轉向力">
    <List0 Min="0" Max="3.9" TypeName="低"/>
    <List1 Min="4" Max="6.9" TypeName="较低"/>
    <List2 Min="7" Max="9.9" TypeName="中等"/>
    <List3 Min="10" Max="12.9" TypeName="较高"/>
    <List4 Min="13" Max="16" TypeName="高"/>
  </List>
  <List ID="4" Name="數值條">
    <List0 Type="護盾" Max="2000"/>
    <List1 Type="結構" Max="8000"/>
    <List2 Type="移動力" Max="10"/>
    <List3 Type="靈敏度" Max="15"/>
    <List4 Type="穩固率" Max="500"/>
    <List5 Type="防禦力" Max="15"/>
    <List6 Type="存儲空間" Max="180"/>
    <List7 Type="安裝空間" Max="900"/>
    <List8 Type="建造時間" Max="240"/>
    <List9 Type="躍遷時間" Max="380"/>
    <List10 Type="攻擊力" Max="1000"/>
    <List11 Type="有效射程" Max="10"/>
    <List12 Type="裝填回合" Max="6"/>
    <List13 Type="組件體積" Max="95"/>
    <List14 Type="轉向力" Max="16"/>
  </List>
  <List ID="5" Name="战场参数">
	<List0 Type="1" BeginDay="5" BeginTime="20:00:00" EndDay="6" EndTime="11:59:59" BattleEndDay="6" BattleEndTime="23:59:59" MaxUser="900"/>
	<List1 Type="2" BeginDay="0" BeginTime="00:00:00" EndDay="0" EndTime="11:59:59" BattleEndDay="0" BattleEndTime="23:59:59" MaxUser="60"/>
  </List>
</Others>;
      
      public function GameRes_OthersXml()
      {
         super();
      }
   }
}

