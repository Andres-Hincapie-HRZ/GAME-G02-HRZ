// Paquete que contiene la clase, parte del módulo de triggers de batalla
package com.go2super.database.entity.sub.battle.trigger;

// Importaciones de entidades y servicios relacionados con batalla
import com.go2super.database.entity.sub.battle.BattleActionTrigger; // Clase base para triggers de acciones de batalla
import com.go2super.database.entity.sub.battle.meta.AssaultCellAttackMeta; // Metadatos de ataque de asalto
import com.go2super.database.entity.sub.battle.meta.FortCellAttackMeta; // Metadatos de ataque de fuerte (no usado en este archivo)
import com.go2super.service.battle.calculator.ShipAttackPacketAction; // Acción de paquete de ataque de nave
import lombok.Getter; // Genera getters
import lombok.NoArgsConstructor; // Genera constructor vacío
import lombok.Setter; // Genera setters
import lombok.ToString; // Genera toString
import lombok.experimental.SuperBuilder; // Genera builder con herencia
import org.springframework.data.annotation.Transient; // Campo no persistente en DB

// Importaciones estándar de Java
import java.util.ArrayList; // Lista dinámica
import java.util.List; // Interfaz de lista

// Anotaciones Lombok
@Getter // Genera getters para todos los campos
@Setter // Genera setters para todos los campos
@SuperBuilder(toBuilder = true) // Genera builder con toBuilder y soporte para herencia
@NoArgsConstructor // Genera constructor vacío
@ToString(callSuper = true) // Genera toString que incluye superclase
// Clase que representa un trigger para ataque de flota contra fuerte en batalla
public class FleetAttackFortTrigger extends BattleActionTrigger { // Extiende BattleActionTrigger

    // IDs del equipo de naves atacante y fuerte defensor
    private int attackerShipTeamId; // ID del equipo atacante
    private int defenderFortId; // ID del fuerte defensor (comentario indica que fue agregado)

    // Lista de metadatos de ataques de asalto
    private List<AssaultCellAttackMeta> attacks; // Lista de metadatos de ataques

    // Lista de acciones de paquetes de ataque, no persistente
    @Transient
    private List<ShipAttackPacketAction> shipAttackPacketActions = new ArrayList<>(); // Acciones de ataque

    // Método para obtener metadatos de ataque por ID de origen
    public AssaultCellAttackMeta getMeta(int fromId) { // Retorna metadatos de ataque para un ID específico
        // Itera sobre la lista de ataques
        for(AssaultCellAttackMeta attackMeta : attacks)
            // Si el ID de origen coincide, retorna el metadato
            if(attackMeta.getFromId() == fromId)
                return attackMeta;
        // Si no encuentra, retorna null
        return null;
    }

}
