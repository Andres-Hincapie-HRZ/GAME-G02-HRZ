// Paquete que contiene la clase, parte del módulo de triggers de batalla
package com.go2super.database.entity.sub.battle.trigger;

// Importaciones de entidades y servicios relacionados con batalla
import com.go2super.database.entity.sub.battle.BattleActionTrigger; // Clase base para triggers de acciones de batalla
import com.go2super.database.entity.sub.battle.meta.FortCellAttackMeta; // Metadatos de ataque de fuerte
import com.go2super.database.entity.sub.battle.meta.ShipCellAttackMeta; // Metadatos de ataque de nave (no usado en este archivo)
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
// Clase que representa un trigger para ataque de fuerte contra flota en batalla
public class FortAttackFleetTrigger extends BattleActionTrigger { // Extiende BattleActionTrigger

    // ID del fuerte atacante y lista de metadatos de ataques
    private int attackerFortId; // ID del fuerte atacante
    private List<FortCellAttackMeta> attacks; // Lista de metadatos de ataques del fuerte

    // Lista de acciones de paquetes de ataque, no persistente
    @Transient
    private List<ShipAttackPacketAction> shipAttackPacketActions = new ArrayList<>(); // Acciones de ataque

    // Método para obtener metadatos de ataque por ID del fuerte atacante
    public FortCellAttackMeta getMeta(int fromFortId) { // Retorna metadatos de ataque para un ID de fuerte específico
        // Itera sobre la lista de ataques
        for(FortCellAttackMeta attackMeta : attacks)
            // Si el ID del fuerte atacante coincide, retorna el metadato
            if(attackMeta.getFromFortId() == fromFortId)
                return attackMeta;
        // Si no encuentra, retorna null
        return null;
    }

}
