// Paquete que contiene la clase, parte del módulo de triggers de batalla
package com.go2super.database.entity.sub.battle.trigger;

// Importaciones de entidades y servicios relacionados con batalla
import com.go2super.database.entity.sub.battle.BattleActionTrigger; // Clase base para triggers de acciones de batalla
import com.go2super.service.BattleService; // Servicio de batalla para cálculos de dirección
import lombok.*; // Importa todas las anotaciones Lombok
import lombok.experimental.SuperBuilder; // Genera builder con herencia

// Anotaciones Lombok
@Getter // Genera getters para todos los campos
@SuperBuilder(toBuilder = true) // Genera builder con toBuilder y soporte para herencia
@NoArgsConstructor // Genera constructor vacío
@ToString(callSuper = true) // Genera toString que incluye superclase
// Clase que representa un trigger para movimiento de equipo de naves en batalla
public class MovementTrigger extends BattleActionTrigger { // Extiende BattleActionTrigger

    // ID del equipo de naves y ID del movimiento
    private int shipTeamId; // ID del equipo de naves que se mueve
    private int movementId; // ID único del movimiento

    // Coordenadas de origen
    private int fromX; // Coordenada X de origen
    private int fromY; // Coordenada Y de origen

    // Coordenadas de destino
    private int toX; // Coordenada X de destino
    private int toY; // Coordenada Y de destino

    // Método para calcular la dirección del movimiento basado en coordenadas
    public int calculatePathMovement() { // Calcula y retorna la dirección del movimiento
        return BattleService.getDirection(fromX, fromY, toX, toY); // Usa servicio para obtener dirección
    }

}
