// Paquete que contiene la clase, parte del módulo de triggers de batalla
package com.go2super.database.entity.sub.battle.trigger;

// Importaciones de entidades y servicios relacionados con batalla
import com.go2super.database.entity.sub.battle.BattleActionTrigger; // Clase base para triggers de acciones de batalla
import com.go2super.service.BattleService; // Servicio de batalla (no usado directamente en este archivo)
import lombok.Getter; // Genera getters
import lombok.NoArgsConstructor; // Genera constructor vacío
import lombok.ToString; // Genera toString
import lombok.experimental.SuperBuilder; // Genera builder con herencia

// Anotaciones Lombok
@Getter // Genera getters para todos los campos
@SuperBuilder(toBuilder = true) // Genera builder con toBuilder y soporte para herencia
@NoArgsConstructor // Genera constructor vacío
@ToString(callSuper = true) // Genera toString que incluye superclase
// Clase que representa un trigger para rotación de flota en batalla
public class FleetRotateTrigger extends BattleActionTrigger { // Extiende BattleActionTrigger

    // Campos para identificar y definir la rotación
    private int guid; // GUID único (posiblemente del usuario o sesión)
    private int shipTeamId; // ID del equipo de naves que rota
    private int direction; // Dirección de la rotación

}
