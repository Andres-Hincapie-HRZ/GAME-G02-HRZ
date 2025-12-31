package
{
   public class GameRes_BuildingTechXml
   {
      
      public static var data:XML = <Tech ID="1" Name="建筑科技">
    <Building GroupID="100" Name="Construcción simultánea" Level="Level1" Kind="2" ImageFileName="Tech100" Comment="Añade espacios de construcción de instalaciones.">
        <Level GroupLV="1" Comment="Añade 1 espacio al programa de construcción." Title="1" Money="1000" Time="20" IncreaseBuildQueue="1"/>
    </Building>
    <Building GroupID="101" Name="Materiales de calidad" Level="Level1" TechMemo="Se necesita Mejora de construcción nv. 3." Kind="2" Tech="102:3" ImageFileName="Tech102" Comment="Reduce la cantidad de recursos necesarios para la construcción; En el primer nivel, se necesita un 1% menos de recursos.">
        <Level GroupLV="1" Comment="Los recursos necesarios para construir se reducen un 1%; Siguiente nivel: dichos recursos se reducen un 2%." Title="1/10" Money="1200" Time="240" DecreaseMetalConsume="1" DecreaseHe3Consume="1" DecreaseMoneyConsume="1"/>
        <Level GroupLV="2" Comment="Los recursos necesarios para construir se reducen un 2%; Siguiente nivel: dichos recursos se reducen un 3%." Title="2/10" Money="2352" Time="470" DecreaseMetalConsume="2" DecreaseHe3Consume="2" DecreaseMoneyConsume="2"/>
        <Level GroupLV="3" Comment="Los recursos necesarios para construir se reducen un 3%; Siguiente nivel: dichos recursos se reducen un 4%." Title="3/10" Money="4608" Time="922" DecreaseMetalConsume="3" DecreaseHe3Consume="3" DecreaseMoneyConsume="3"/>
        <Level GroupLV="4" Comment="Los recursos necesarios para construir se reducen un 4%; Siguiente nivel: dichos recursos se reducen un 5%." Title="4/10" Money="9030" Time="1806" DecreaseMetalConsume="4" DecreaseHe3Consume="4" DecreaseMoneyConsume="4"/>
        <Level GroupLV="5" Comment="Los recursos necesarios para construir se reducen un 5%; Siguiente nivel: dichos recursos se reducen un 6%." Title="5/10" Money="17706" Time="3541" DecreaseMetalConsume="5" DecreaseHe3Consume="5" DecreaseMoneyConsume="5"/>
        <Level GroupLV="6" Comment="Los recursos necesarios para construir se reducen un 6%; Siguiente nivel: dichos recursos se reducen un 8%." Title="6/10" Money="34710" Time="6942" DecreaseMetalConsume="6" DecreaseHe3Consume="6" DecreaseMoneyConsume="6"/>
        <Level GroupLV="7" Comment="Los recursos necesarios para construir se reducen un 8%; Siguiente nivel: dichos recursos se reducen un 10%." Title="7/10" Money="68028" Time="13606" DecreaseMetalConsume="8" DecreaseHe3Consume="8" DecreaseMoneyConsume="8"/>
        <Level GroupLV="8" Comment="Los recursos necesarios para construir se reducen un 10%; Siguiente nivel: dichos recursos se reducen un 12%." Title="8/10" Money="133344" Time="26669" DecreaseMetalConsume="10" DecreaseHe3Consume="10" DecreaseMoneyConsume="10"/>
        <Level GroupLV="9" Comment="Los recursos necesarios para construir se reducen un 12%; Siguiente nivel: dichos recursos se reducen un 15%." Title="9/10" Money="261354" Time="52271" DecreaseMetalConsume="12" DecreaseHe3Consume="12" DecreaseMoneyConsume="12"/>
        <Level GroupLV="10" Comment="Los recursos necesarios para construir se reducen un &lt;font color='#00FF00'&gt;15%&lt;/font&gt;." Title="10" Money="512250" Time="102450" DecreaseMetalConsume="15" DecreaseHe3Consume="15" DecreaseMoneyConsume="15"/>
    </Building>
    <Building GroupID="102" Name="Mejora de construcción" Level="Level1" TechMemo="Se necesita Construcción simultánea nv. 1." Kind="2" Tech="100:1" ImageFileName="Tech101" Comment="Aumenta la velocidad de construcción; En el primer nivel, se aumenta un 1% la velocidad de construcción.">
        <Level GroupLV="1" Comment="Aumenta un 1% la velocidad de construcción; Siguiente nivel: aumenta un 2% la velocidad de construcción." Title="1/10" Money="2400" Time="480" IncreaseBuilding="1"/>
        <Level GroupLV="2" Comment="Aumenta un 2% la velocidad de construcción; Siguiente nivel: aumenta un 3% la velocidad de construcción." Title="2/10" Money="4704" Time="941" IncreaseBuilding="2"/>
        <Level GroupLV="3" Comment="Aumenta un 3% la velocidad de construcción; Siguiente nivel: aumenta un 4% la velocidad de construcción." Title="3/10" Money="9216" Time="1843" IncreaseBuilding="3"/>
        <Level GroupLV="4" Comment="Aumenta un 4% la velocidad de construcción; Siguiente nivel: aumenta un 5% la velocidad de construcción." Title="4/10" Money="18066" Time="3613" IncreaseBuilding="4"/>
        <Level GroupLV="5" Comment="Aumenta un 5% la velocidad de construcción; Siguiente nivel: aumenta un 6% la velocidad de construcción." Title="5/10" Money="35418" Time="7084" IncreaseBuilding="5"/>
        <Level GroupLV="6" Comment="Aumenta un 6% la velocidad de construcción; Siguiente nivel: aumenta un 8% la velocidad de construcción." Title="6/10" Money="69420" Time="13884" IncreaseBuilding="6"/>
        <Level GroupLV="7" Comment="Aumenta un 8% la velocidad de construcción; Siguiente nivel: aumenta un 10% la velocidad de construcción." Title="7/10" Money="136062" Time="27212" IncreaseBuilding="8"/>
        <Level GroupLV="8" Comment="Aumenta un 10% la velocidad de construcción; Siguiente nivel: aumenta un 12% la velocidad de construcción." Title="8/10" Money="266688" Time="53338" IncreaseBuilding="10"/>
        <Level GroupLV="9" Comment="Aumenta un 12% la velocidad de construcción; Siguiente nivel: aumenta un 15% la velocidad de construcción." Title="9/10" Money="522708" Time="104542" IncreaseBuilding="12"/>
        <Level GroupLV="10" Comment="Aumenta un &lt;font color='#00FF00'&gt;15%&lt;/font&gt; la velocidad de construcción." Title="10" Money="1024506" Time="204901" IncreaseBuilding="15"/>
    </Building>
    <Building GroupID="103" Name="Mejora de construcción de naves" Level="Level1" Kind="2" ImageFileName="Tech103" Comment="Aumenta la velocidad de construcción de naves; En el primer nivel, se aumenta un 1% la velocidad de construcción.">
        <Level GroupLV="1" Comment="Aumenta un 1% la velocidad de construcción de naves; Siguiente nivel: aumenta un 2% la velocidad de construcción de naves." Title="1/10" Money="990" Time="198" IncreaseShipBuild="1"/>
        <Level GroupLV="2" Comment="Aumenta un 2% la velocidad de construcción de naves; Siguiente nivel: aumenta un 3% la velocidad de construcción de naves." Title="2/10" Money="2226" Time="445" IncreaseShipBuild="2"/>
        <Level GroupLV="3" Comment="Aumenta un 3% la velocidad de construcción de naves; Siguiente nivel: aumenta un 4% la velocidad de construcción de naves." Title="3/10" Money="5010" Time="1002" IncreaseShipBuild="3"/>
        <Level GroupLV="4" Comment="Aumenta un 4% la velocidad de construcción de naves; Siguiente nivel: aumenta un 5% la velocidad de construcción de naves." Title="4/10" Money="11274" Time="2255" IncreaseShipBuild="4"/>
        <Level GroupLV="5" Comment="Aumenta un 5% la velocidad de construcción de naves; Siguiente nivel: aumenta un 6% la velocidad de construcción de naves." Title="5/10" Money="25368" Time="5074" IncreaseShipBuild="5"/>
        <Level GroupLV="6" Comment="Aumenta un 6% la velocidad de construcción de naves; Siguiente nivel: aumenta un 8% la velocidad de construcción de naves." Title="6/10" Money="57084" Time="11417" IncreaseShipBuild="6"/>
        <Level GroupLV="7" Comment="Aumenta un 8% la velocidad de construcción de naves; Siguiente nivel: aumenta un 10% la velocidad de construcción de naves." Title="7/10" Money="128448" Time="25690" IncreaseShipBuild="8"/>
        <Level GroupLV="8" Comment="Aumenta un 10% la velocidad de construcción de naves; Siguiente nivel: aumenta un 12% la velocidad de construcción de naves." Title="8/10" Money="289008" Time="57802" IncreaseShipBuild="10"/>
        <Level GroupLV="9" Comment="Aumenta un 12% la velocidad de construcción de naves; Siguiente nivel: aumenta un 15% la velocidad de construcción de naves." Title="9/10" Money="650268" Time="130054" IncreaseShipBuild="12"/>
        <Level GroupLV="10" Comment="Aumenta un &lt;font color='#00FF00'&gt;15%&lt;/font&gt; la velocidad de construcción de naves." Title="10" Money="1463112" Time="292622" IncreaseShipBuild="15"/>
    </Building>
    <Building GroupID="104" Name="Logística de construcción de naves" Level="Level1" TechMemo="Se necesita Mejora de construcción de naves nv. 2." Kind="2" Tech="103:2" ImageFileName="Tech104" Comment="Reduce la cantidad de recursos necesarios para la construcción de naves; En el primer nivel, se necesita un 1% menos de recursos.">
        <Level GroupLV="1" Comment="Los recursos necesarios para construir naves se reducen un 1%; Siguiente nivel: dichos recursos se reducen un 2%." Title="1/10" Money="1386" Time="277" DecreaseShipMetalConsume="1" DecreaseShipHe3Consume="1" DecreaseShipMoneyConsume="1"/>
        <Level GroupLV="2" Comment="Los recursos necesarios para construir naves se reducen un 2%; Siguiente nivel: dichos recursos se reducen un 3%." Title="2/10" Money="3114" Time="623" DecreaseShipMetalConsume="2" DecreaseShipHe3Consume="2" DecreaseShipMoneyConsume="2"/>
        <Level GroupLV="3" Comment="Los recursos necesarios para construir naves se reducen un 3%; Siguiente nivel: dichos recursos se reducen un 4%." Title="3/10" Money="7014" Time="1403" DecreaseShipMetalConsume="3" DecreaseShipHe3Consume="3" DecreaseShipMoneyConsume="3"/>
        <Level GroupLV="4" Comment="Los recursos necesarios para construir naves se reducen un 4%; Siguiente nivel: dichos recursos se reducen un 5%." Title="4/10" Money="15786" Time="3157" DecreaseShipMetalConsume="4" DecreaseShipHe3Consume="4" DecreaseShipMoneyConsume="4"/>
        <Level GroupLV="5" Comment="Los recursos necesarios para construir naves se reducen un 5%; Siguiente nivel: dichos recursos se reducen un 6%." Title="5/10" Money="35520" Time="7104" DecreaseShipMetalConsume="5" DecreaseShipHe3Consume="5" DecreaseShipMoneyConsume="5"/>
        <Level GroupLV="6" Comment="Los recursos necesarios para construir naves se reducen un 6%; Siguiente nivel: dichos recursos se reducen un 8%." Title="6/10" Money="79920" Time="15984" DecreaseShipMetalConsume="6" DecreaseShipHe3Consume="6" DecreaseShipMoneyConsume="6"/>
        <Level GroupLV="7" Comment="Los recursos necesarios para construir naves se reducen un 8%; Siguiente nivel: dichos recursos se reducen un 10%." Title="7/10" Money="179826" Time="35965" DecreaseShipMetalConsume="8" DecreaseShipHe3Consume="8" DecreaseShipMoneyConsume="8"/>
        <Level GroupLV="8" Comment="Los recursos necesarios para construir naves se reducen un 10%; Siguiente nivel: dichos recursos se reducen un 12%." Title="8/10" Money="404610" Time="80922" DecreaseShipMetalConsume="10" DecreaseShipHe3Consume="10" DecreaseShipMoneyConsume="10"/>
        <Level GroupLV="9" Comment="Los recursos necesarios para construir naves se reducen un 12%; Siguiente nivel: dichos recursos se reducen un 15%." Title="9/10" Money="910380" Time="182076" DecreaseShipMetalConsume="12" DecreaseShipHe3Consume="12" DecreaseShipMoneyConsume="12"/>
        <Level GroupLV="10" Comment="Los recursos necesarios para construir naves se reducen un &lt;font color='#00FF00'&gt;15%&lt;/font&gt;." Title="10" Money="2048358" Time="409672" DecreaseShipMetalConsume="15" DecreaseShipHe3Consume="15" DecreaseShipMoneyConsume="15"/>
    </Building>
    <Building GroupID="105" Name="Construcción de naves sincronizada" Level="Level1" TechMemo="Se necesita Logística de construcción de naves nv. 4." Kind="2" Tech="104:4" ImageFileName="Tech105" Comment="Añade espacios de construcción de naves.">
        <Level GroupLV="1" Comment="Añade 1 espacio al programa de construcción de naves." Title="1" Money="174000" Time="34800" IncreaseShipQueue="1"/>
    </Building>
    <Building GroupID="106" Name="Extracción a gran escala" Level="Level1" Kind="2" ImageFileName="Tech106" Comment="Aumenta la producción de metal; En el primer nivel, la producción aumenta un 1%.">
        <Level GroupLV="1" Comment="Aumenta un 1% la producción de metal; Siguiente nivel: aumenta un 2% la producción de metal." Title="1/10" Money="1740" Time="348" IncreaseMetalOut="1"/>
        <Level GroupLV="2" Comment="Aumenta un 2% la producción de metal; Siguiente nivel: aumenta un 3% la producción de metal." Title="2/10" Money="3408" Time="682" IncreaseMetalOut="2"/>
        <Level GroupLV="3" Comment="Aumenta un 3% la producción de metal; Siguiente nivel: aumenta un 4% la producción de metal." Title="3/10" Money="6684" Time="1337" IncreaseMetalOut="3"/>
        <Level GroupLV="4" Comment="Aumenta un 4% la producción de metal; Siguiente nivel: aumenta un 5% la producción de metal." Title="4/10" Money="13098" Time="2620" IncreaseMetalOut="4"/>
        <Level GroupLV="5" Comment="Aumenta un 5% la producción de metal; Siguiente nivel: aumenta un 6% la producción de metal." Title="5/10" Money="25674" Time="5135" IncreaseMetalOut="5"/>
        <Level GroupLV="6" Comment="Aumenta un 6% la producción de metal; Siguiente nivel: aumenta un 7% la producción de metal." Title="6/10" Money="50328" Time="10066" IncreaseMetalOut="6"/>
        <Level GroupLV="7" Comment="Aumenta un 7% la producción de metal; Siguiente nivel: aumenta un 8% la producción de metal." Title="7/10" Money="98646" Time="19729" IncreaseMetalOut="7"/>
        <Level GroupLV="8" Comment="Aumenta un 8% la producción de metal; Siguiente nivel: aumenta un 9% la producción de metal." Title="8/10" Money="193344" Time="38669" IncreaseMetalOut="8"/>
        <Level GroupLV="9" Comment="Aumenta un 9% la producción de metal; Siguiente nivel: aumenta un 10% la producción de metal." Title="9/10" Money="378960" Time="75792" IncreaseMetalOut="9"/>
        <Level GroupLV="10" Comment="Aumenta un &lt;font color='#00FF00'&gt;10%&lt;/font&gt; la producción de metal." Title="10" Money="742764" Time="148553" IncreaseMetalOut="10"/>
    </Building>
    <Building GroupID="107" Name="Química a gran escala" Level="Level1" TechMemo="Se necesita Producción a gran escala nv. 2." Kind="2" Tech="106:2" ImageFileName="Tech107" Comment="Aumenta la producción de He3; En el primer nivel, la producción aumenta un 1%.">
        <Level GroupLV="1" Comment="Aumenta un 1% la producción de He3; Siguiente nivel: aumenta un 2% la producción de He3." Title="1/10" Money="2400" Time="480" IncreaseHe3Out="1"/>
        <Level GroupLV="2" Comment="Aumenta un 2% la producción de He3; Siguiente nivel: aumenta un 3% la producción de He3." Title="2/10" Money="4704" Time="941" IncreaseHe3Out="2"/>
        <Level GroupLV="3" Comment="Aumenta un 3% la producción de He3; Siguiente nivel: aumenta un 4% la producción de He3." Title="3/10" Money="9216" Time="1843" IncreaseHe3Out="3"/>
        <Level GroupLV="4" Comment="Aumenta un 4% la producción de He3; Siguiente nivel: aumenta un 5% la producción de He3." Title="4/10" Money="18060" Time="3612" IncreaseHe3Out="4"/>
        <Level GroupLV="5" Comment="Aumenta un 5% la producción de He3; Siguiente nivel: aumenta un 6% la producción de He3." Title="5/10" Money="35412" Time="7082" IncreaseHe3Out="5"/>
        <Level GroupLV="6" Comment="Aumenta un 6% la producción de He3; Siguiente nivel: aumenta un 7% la producción de He3." Title="6/10" Money="69420" Time="13884" IncreaseHe3Out="6"/>
        <Level GroupLV="7" Comment="Aumenta un 7% la producción de He3; Siguiente nivel: aumenta un 8% la producción de He3." Title="7/10" Money="136056" Time="27211" IncreaseHe3Out="7"/>
        <Level GroupLV="8" Comment="Aumenta un 8% la producción de He3; Siguiente nivel: aumenta un 9% la producción de He3." Title="8/10" Money="266688" Time="53338" IncreaseHe3Out="8"/>
        <Level GroupLV="9" Comment="Aumenta un 9% la producción de He3; Siguiente nivel: aumenta un 10% la producción de He3." Title="9/10" Money="522708" Time="104542" IncreaseHe3Out="9"/>
        <Level GroupLV="10" Comment="Aumenta un &lt;font color='#00FF00'&gt;10%&lt;/font&gt; la producción de He3." Title="10" Money="1024500" Time="204900" IncreaseHe3Out="10"/>
    </Building>
    <Building GroupID="108" Name="Inversión a gran escala" Level="Level1" TechMemo="Se necesita Química a gran escala nv. 2." Kind="2" Tech="107:2" ImageFileName="Tech108" Comment="Aumenta la producción de oro; En el primer nivel, la producción aumenta un 1%.">
        <Level GroupLV="1" Comment="Aumenta un 1% la producción de oro; Siguiente nivel: aumenta un 2% la producción." Title="1/10" Money="3570" Time="714" IncreaseMoneyOut="1"/>
        <Level GroupLV="2" Comment="Aumenta un 2% la producción de oro; Siguiente nivel: aumenta un 3% la producción." Title="2/10" Money="6996" Time="1399" IncreaseMoneyOut="2"/>
        <Level GroupLV="3" Comment="Aumenta un 3% la producción de oro; Siguiente nivel: aumenta un 4% la producción." Title="3/10" Money="13710" Time="2742" IncreaseMoneyOut="3"/>
        <Level GroupLV="4" Comment="Aumenta un 4% la producción de oro; Siguiente nivel: aumenta un 5% la producción." Title="4/10" Money="26880" Time="5376" IncreaseMoneyOut="4"/>
        <Level GroupLV="5" Comment="Aumenta un 5% la producción de oro; Siguiente nivel: aumenta un 6% la producción." Title="5/10" Money="52680" Time="10536" IncreaseMoneyOut="5"/>
        <Level GroupLV="6" Comment="Aumenta un 6% la producción de oro; Siguiente nivel: aumenta un 7% la producción." Title="6/10" Money="103260" Time="20652" IncreaseMoneyOut="6"/>
        <Level GroupLV="7" Comment="Aumenta un 7% la producción de oro; Siguiente nivel: aumenta un 8% la producción." Title="7/10" Money="202392" Time="40478" IncreaseMoneyOut="7"/>
        <Level GroupLV="8" Comment="Aumenta un 8% la producción de oro; Siguiente nivel: aumenta un 9% la producción." Title="8/10" Money="396696" Time="79339" IncreaseMoneyOut="8"/>
        <Level GroupLV="9" Comment="Aumenta un 9% la producción de oro; Siguiente nivel: aumenta un 10% la producción." Title="9/10" Money="777528" Time="155506" IncreaseMoneyOut="9"/>
        <Level GroupLV="10" Comment="Aumenta un &lt;font color='#00FF00'&gt;10%&lt;/font&gt; la producción de oro." Title="10" Money="1523952" Time="304790" IncreaseMoneyOut="10"/>
    </Building>
    <Building GroupID="109" Name="Ampliar capacidad" Level="Level1" TechMemo="Se necesita Inversión a gran escala nv. 4." Kind="2" Tech="108:4" ImageFileName="Tech109" Comment="Aumenta la capacidad total del almacén de recursos; En el primer nivel, suma 50.000 a la capacidad de almacenamiento.">
        <Level GroupLV="1" Comment="Suma 50.000 a la capacidad total de almacenamiento de metal, He3 y oro; Siguiente nivel: suma 100.000 a la capacidad de almacenamiento de metal, He3 y oro." Title="1/10" Money="3540" Time="708" IncreaseMetalCapacity="50000" IncreaseHe3Capacity="50000" IncreaseMoneyCapacity="50000"/>
        <Level GroupLV="2" Comment="Suma 100.000 a la capacidad total de almacenamiento de metal, He3 y oro; Siguiente nivel: suma 150.000 a la capacidad de almacenamiento de metal, He3 y oro." Title="2/10" Money="6936" Time="1387" IncreaseMetalCapacity="100000" IncreaseHe3Capacity="100000" IncreaseMoneyCapacity="100000"/>
        <Level GroupLV="3" Comment="Suma 150.000 a la capacidad total de almacenamiento de metal, He3 y oro; Siguiente nivel: suma 200.000 a la capacidad de almacenamiento de metal, He3 y oro." Title="3/10" Money="13596" Time="2719" IncreaseMetalCapacity="150000" IncreaseHe3Capacity="150000" IncreaseMoneyCapacity="150000"/>
        <Level GroupLV="4" Comment="Suma 200.000 a la capacidad total de almacenamiento de metal, He3 y oro; Siguiente nivel: suma 250.000 a la capacidad de almacenamiento de metal, He3 y oro." Title="4/10" Money="26652" Time="5330" IncreaseMetalCapacity="200000" IncreaseHe3Capacity="200000" IncreaseMoneyCapacity="200000"/>
        <Level GroupLV="5" Comment="Suma 250.000 a la capacidad total de almacenamiento de metal, He3 y oro; Siguiente nivel: suma 300.000 a la capacidad de almacenamiento de metal, He3 y oro." Title="5/10" Money="52242" Time="10448" IncreaseMetalCapacity="250000" IncreaseHe3Capacity="250000" IncreaseMoneyCapacity="250000"/>
        <Level GroupLV="6" Comment="Suma 300.000 a la capacidad total de almacenamiento de metal, He3 y oro; Siguiente nivel: suma 350.000 a la capacidad de almacenamiento de metal, He3 y oro." Title="6/10" Money="102396" Time="20479" IncreaseMetalCapacity="300000" IncreaseHe3Capacity="300000" IncreaseMoneyCapacity="300000"/>
        <Level GroupLV="7" Comment="Suma 350.000 a la capacidad total de almacenamiento de metal, He3 y oro; Siguiente nivel: suma 400.000 a la capacidad de almacenamiento de metal, He3 y oro." Title="7/10" Money="200694" Time="40139" IncreaseMetalCapacity="350000" IncreaseHe3Capacity="350000" IncreaseMoneyCapacity="350000"/>
        <Level GroupLV="8" Comment="Suma 400.000 a la capacidad total de almacenamiento de metal, He3 y oro; Siguiente nivel: suma 450.000 a la capacidad de almacenamiento de metal, He3 y oro." Title="8/10" Money="393360" Time="78672" IncreaseMetalCapacity="400000" IncreaseHe3Capacity="400000" IncreaseMoneyCapacity="400000"/>
        <Level GroupLV="9" Comment="Suma 450.000 a la capacidad total de almacenamiento de metal, He3 y oro; Siguiente nivel: suma 500.000 a la capacidad de almacenamiento de metal, He3 y oro." Title="9/10" Money="770994" Time="154199" IncreaseMetalCapacity="450000" IncreaseHe3Capacity="450000" IncreaseMoneyCapacity="450000"/>
        <Level GroupLV="9" Comment="Suma &lt;font color='#00FF00'&gt;500.000&lt;/font&gt; a la capacidad total de almacenamiento de metal, He3 y oro." Title="10" Money="1511148" Time="302230" IncreaseMetalCapacity="500000" IncreaseHe3Capacity="500000" IncreaseMoneyCapacity="500000"/>
    </Building>
    <Building GroupID="110" Name="Tecnología de reparación" Level="Level1" TechMemo="Se necesita Construcción de naves sincronizada nv. 1." Kind="2" Tech="105:1" ImageFileName="Tech111" Comment="Aumenta el porcentaje de naves que puedes reparar. Siguiente nivel: aumenta el porcentaje de naves que puedes reparar en un 1%.">
        <Level GroupLV="1" Comment="Aumenta el porcentaje de naves que puedes reparar en un 1% ;Siguiente nivel:aumenta el porcentaje de naves que puedes reparar en un 2%" Title="1/10" Money="5310" Time="1062" RepairRate="1"/>
        <Level GroupLV="2" Comment="Aumenta el porcentaje de naves que puedes reparar en un 2% ;Siguiente nivel:aumenta el porcentaje de naves que puedes reparar en un 3%" Title="2/10" Money="10404" Time="2080.5" RepairRate="2"/>
        <Level GroupLV="3" Comment="Aumenta el porcentaje de naves que puedes reparar en un 3% ;Siguiente nivel:aumenta el porcentaje de naves que puedes reparar en un 4%" Title="3/10" Money="20394" Time="4078.5" RepairRate="3"/>
        <Level GroupLV="4" Comment="Aumenta el porcentaje de naves que puedes reparar en un 4% ;Siguiente nivel:aumenta el porcentaje de naves que puedes reparar en un 5%" Title="4/10" Money="39978" Time="7995" RepairRate="4"/>
        <Level GroupLV="5" Comment="Aumenta el porcentaje de naves que puedes reparar en un 5% ;Siguiente nivel:aumenta el porcentaje de naves que puedes reparar en un 6%" Title="5/10" Money="78363" Time="15672" RepairRate="5"/>
        <Level GroupLV="6" Comment="Aumenta el porcentaje de naves que puedes reparar en un 6% ;Siguiente nivel:aumenta el porcentaje de naves que puedes reparar en un 7%" Title="6/10" Money="153594" Time="30718.5" RepairRate="6"/>
        <Level GroupLV="7" Comment="Aumenta el porcentaje de naves que puedes reparar en un 7% ;Siguiente nivel:aumenta el porcentaje de naves que puedes reparar en un 8%" Title="7/10" Money="301041" Time="60208.5" RepairRate="7"/>
        <Level GroupLV="8" Comment="Aumenta el porcentaje de naves que puedes reparar en un 8% ;Siguiente nivel:aumenta el porcentaje de naves que puedes reparar en un 9%" Title="8/10" Money="590040" Time="118008" RepairRate="8"/>
        <Level GroupLV="9" Comment="Aumenta el porcentaje de naves que puedes reparar en un 9% ;Siguiente nivel:aumenta el porcentaje de naves que puedes reparar en un 10%" Title="9/10" Money="1156491" Time="231298.5" RepairRate="9"/>
        <Level GroupLV="10" Comment="Aumenta el porcentaje de naves que puedes reparar en un &lt;font color='#00FF00'&gt;10%&lt;/font&gt;." Title="10" Money="2266722" Time="453345" RepairRate="10"/>
    </Building>
</Tech>;
      
      public function GameRes_BuildingTechXml()
      {
         super();
      }
   }
}

