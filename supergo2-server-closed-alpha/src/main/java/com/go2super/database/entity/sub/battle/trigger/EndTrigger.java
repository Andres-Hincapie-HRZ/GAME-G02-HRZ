// Paquete que contiene la clase, parte del módulo de triggers de batalla
package com.go2super.database.entity.sub.battle.trigger;

// Importación de la clase base para triggers de acciones de batalla
import com.go2super.database.entity.sub.battle.BattleActionTrigger;

// Importaciones de Lombok para generar código automáticamente
import lombok.Getter; // Genera getters para todos los campos
import lombok.NoArgsConstructor; // Genera constructor sin argumentos
import lombok.ToString; // Genera toString que incluye campos de la superclase
import lombok.experimental.SuperBuilder; // Genera builder con soporte para herencia

// Anotaciones Lombok aplicadas a la clase
@Getter // Genera métodos getter para shipTeamId
@SuperBuilder(toBuilder = true) // Genera builder con método toBuilder y soporte para herencia
@NoArgsConstructor // Genera constructor vacío
@ToString(callSuper = true) // Genera toString que llama al de la superclase
// Clase que representa un trigger para el final de la acción de un equipo de naves en batalla
public class EndTrigger extends BattleActionTrigger { // Extiende BattleActionTrigger

    // Campo privado que almacena el ID del equipo de naves que termina su acción
    private int shipTeamId; // ID del equipo de naves involucrado en el trigger de fin

}
