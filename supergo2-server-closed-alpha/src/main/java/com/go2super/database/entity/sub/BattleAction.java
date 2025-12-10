// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity.sub;

// Importación de trigger de acción de batalla
import com.go2super.database.entity.sub.battle.BattleActionTrigger;

// Importaciones de Lombok para generar código automáticamente
import lombok.*; // Incluye Builder, AllArgsConstructor, NoArgsConstructor, ToString, Setter, Getter

// Importaciones estándar de Java
import java.util.LinkedList; // Lista enlazada

// Anotaciones Lombok aplicadas a la clase
@Builder(toBuilder = true) // Genera builder con toBuilder
@AllArgsConstructor(access = AccessLevel.PACKAGE) // Constructor con todos los argumentos (paquete privado)
@NoArgsConstructor(access = AccessLevel.PACKAGE) // Constructor vacío (paquete privado)
@ToString // Genera toString
@Setter // Genera setters
@Getter // Genera getters
// Clase que representa una acción en batalla
public class BattleAction {

    private int actionId; // ID único de la acción

    private String type; // Tipo de acción (ej. ataque, movimiento)
    private int involvedId; // ID de la entidad involucrada

    private LinkedList<BattleActionTrigger> triggers; // Lista enlazada de triggers de la acción

    // Método para agregar un trigger a la acción
    public void addTrigger(BattleActionTrigger trigger) {
        triggers.add(trigger); // Agrega el trigger a la lista
    }

    // Método para calcular el próximo ID de trigger
    public int calculateNextTriggerId() {
        return triggers.size(); // Retorna el tamaño de la lista (siguiente ID)
    }

}
