// Paquete que contiene la clase, parte del módulo de triggers de batalla
package com.go2super.database.entity.sub.battle.trigger;

// Importaciones de entidades relacionadas con batalla
import com.go2super.database.entity.sub.battle.BattleActionTrigger; // Clase base para triggers de acciones de batalla
import com.go2super.database.entity.type.BattleElementType; // Enum para tipos de elementos de batalla
import lombok.Getter; // Genera getters
import lombok.NoArgsConstructor; // Genera constructor vacío
import lombok.Setter; // Genera setters
import lombok.ToString; // Genera toString
import lombok.experimental.SuperBuilder; // Genera builder con herencia

// Anotaciones Lombok
@Getter // Genera getters para todos los campos
@Setter // Genera setters para todos los campos
@SuperBuilder(toBuilder = true) // Genera builder con toBuilder y soporte para herencia
@NoArgsConstructor // Genera constructor vacío
@ToString(callSuper = true) // Genera toString que incluye superclase
// Clase que representa un trigger para marcar objetivo por flota en batalla
public class FleetMarkTargetTrigger extends BattleActionTrigger { // Extiende BattleActionTrigger

    // Tipo de elemento de batalla que se marca como objetivo
    private BattleElementType elementType; // Tipo del elemento objetivo (ej. nave, fuerte)

    // ID del equipo de naves atacante y ID del objetivo
    private int attackerShipTeamId; // ID del equipo atacante que marca el objetivo
    private int targetId; // ID del objetivo marcado

}
