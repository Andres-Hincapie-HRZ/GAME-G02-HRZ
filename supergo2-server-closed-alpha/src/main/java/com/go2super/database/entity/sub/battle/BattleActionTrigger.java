// Paquete que contiene la clase, parte del módulo de base de datos para entidades de batalla
package com.go2super.database.entity.sub.battle;

// Importaciones de Lombok para generar código automáticamente
import lombok.Data; // Genera getters, setters, toString, equals, hashCode
import lombok.NoArgsConstructor; // Genera constructor vacío
import lombok.experimental.SuperBuilder; // Genera builder con soporte para herencia

// Anotaciones Lombok para generar código boilerplate
@Data // Genera getters, setters, toString, equals, hashCode
@SuperBuilder(toBuilder = true) // Genera builder con toBuilder y soporte para herencia
@NoArgsConstructor // Genera constructor vacío
// Clase abstracta base para todos los triggers de acciones de batalla
public abstract class BattleActionTrigger {

    private int id; // ID único del trigger
    private String type; // Tipo de trigger (ej. ataque, movimiento, etc.)
    private long millis; // Timestamp en milisegundos del trigger

}
