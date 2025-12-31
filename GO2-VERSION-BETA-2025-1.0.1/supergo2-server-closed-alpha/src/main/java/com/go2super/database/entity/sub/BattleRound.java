// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity.sub;

// Importaciones de Lombok para generar código automáticamente
import lombok.*; // Incluye Builder, AllArgsConstructor, NoArgsConstructor, ToString, Setter, Getter

// Importaciones estándar de Java
import java.util.List; // Interfaz de lista

// Anotaciones Lombok aplicadas a la clase
@Builder(toBuilder = true) // Genera builder con toBuilder
@AllArgsConstructor(access = AccessLevel.PACKAGE) // Constructor con todos los argumentos (paquete privado)
@NoArgsConstructor(access = AccessLevel.PACKAGE) // Constructor vacío (paquete privado)
@ToString // Genera toString
@Setter // Genera setters
@Getter // Genera getters
// Clase que representa una ronda de batalla
public class BattleRound {

    private int roundId; // ID único de la ronda

    private List<BattleFleet> fleets; // Lista de flotas en la ronda
    private List<BattleFort> forts; // Lista de fortificaciones en la ronda

    private List<BattleAction> actions; // Lista de acciones en la ronda

    // Método para agregar una acción a la ronda
    public void addAction(BattleAction action) {
        actions.add(action); // Agrega la acción a la lista
    }

    // Método para calcular el próximo ID de acción
    public int calculateNextActionId() {
        return actions.size(); // Retorna el tamaño de la lista (siguiente ID)
    }

}
