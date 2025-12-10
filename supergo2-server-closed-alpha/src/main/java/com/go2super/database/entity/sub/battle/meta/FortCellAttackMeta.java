// Paquete que contiene la clase, parte del módulo de base de datos para entidades de batalla
package com.go2super.database.entity.sub.battle.meta;

// Importaciones para tipos de datos y servicios de cálculo de batalla
import com.go2super.obj.game.IntegerArray; // Clase para manejar arreglos de enteros
import com.go2super.service.battle.calculator.FortShootdowns; // Clase para derribos de fuertes
import com.go2super.service.battle.calculator.ShipAttackPacketAction; // Acción de paquete de ataque de nave
import com.go2super.service.battle.calculator.ShipReduction; // Reducción en naves
import lombok.Getter; // Genera getters
import lombok.Setter; // Genera setters
import lombok.ToString; // Genera toString
import org.springframework.data.annotation.Transient; // Campo no persistente

// Importaciones estándar de Java
import java.util.ArrayList; // Lista dinámica
import java.util.Arrays; // Operaciones con arreglos
import java.util.List; // Interfaz de lista

// Anotaciones Lombok
@ToString // Genera toString
@Setter // Genera setters
@Getter // Genera getters
public class FortCellAttackMeta { // Clase para metadatos de ataque de fuerte en celda de batalla

    // Campos públicos para ID del equipo de naves objetivo y reducciones en suministro y almacenamiento
    public int targetShipTeamId; // ID del equipo de naves objetivo
    public int targetReduceSupply; // Reducción en suministro del objetivo
    public int targetReduceStorage; // Reducción en almacenamiento del objetivo

    // Arreglos para reducciones en HP y número de naves del objetivo (9 posiciones, probablemente para flota)
    public int[] targetReduceHp = new int[9]; // Reducciones en puntos de vida por posición
    public int[] targetReduceShipNum = new int[9]; // Reducciones en número de naves por posición

    // Campos privados para uso interno (IDs de fuerte, equipo de naves, usuarios)
    private int fromFortId; // ID del fuerte atacante
    private int toShipTeamId; // ID del equipo de naves defensor

    private int fromUserGuid; // GUID del usuario atacante
    private int toUserGuid; // GUID del usuario defensor

    private int toAmount; // Cantidad relacionada con el defensor
    private int toId; // ID genérico del defensor

    private boolean attack; // Bandera que indica si es un ataque

    // Campos para utilidad de matriz (posicionamiento del defensor)
    private int defenderDirection; // Dirección del defensor
    private int defenderSegmentedPosIndex; // Índice de posición segmentada del defensor
    private int defenderPosIndex; // Índice de posición del defensor
    private int defenderPos; // Posición del defensor

    // Campos para utilidad de reproducción (playback)
    private List<ShipReduction> shipReductions; // Lista de reducciones en naves
    private List<FortShootdowns> fortShootdowns; // Lista de derribos de fuertes

    // Lista de acciones de paquetes de ataque de naves, no persistente
    @Transient
    private List<ShipAttackPacketAction> shipAttackPacketActions = new ArrayList<>(); // Acciones de ataque

    // Constructor que inicializa arreglos con 0
    public FortCellAttackMeta() {
        Arrays.fill(targetReduceHp, 0); // Llena arreglo de reducción de HP con 0
        Arrays.fill(targetReduceShipNum, 0); // Llena arreglo de reducción de número de naves con 0
    }

    // Métodos para obtener buffers de IntegerArray
    public IntegerArray targetReduceHp() { // Retorna IntegerArray de targetReduceHp
        return new IntegerArray(targetReduceHp);
    }

    public IntegerArray targetReduceShipNum() { // Retorna IntegerArray de targetReduceShipNum
        return new IntegerArray(targetReduceShipNum);
    }

}
