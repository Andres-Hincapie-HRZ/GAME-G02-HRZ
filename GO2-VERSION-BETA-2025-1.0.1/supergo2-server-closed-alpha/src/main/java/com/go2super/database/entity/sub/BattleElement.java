// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity.sub;

// Importación de tipo de elemento de batalla
import com.go2super.database.entity.type.BattleElementType;

// Importaciones de servicios de batalla
import com.go2super.service.battle.BattleCell; // Celda de batalla
import com.go2super.service.battle.astar.Node; // Nodo para pathfinding A*
import com.go2super.service.battle.pathfinder.GO2Node; // Nodo personalizado GO2

// Importaciones de Lombok para generar código automáticamente
import lombok.*; // Incluye NoArgsConstructor, ToString, Setter, Getter

// Importaciones estándar de Java
import java.io.Serializable; // Para serialización

// Anotaciones Lombok aplicadas a la clase
@NoArgsConstructor(access = AccessLevel.PACKAGE) // Constructor vacío (paquete privado)
@ToString // Genera toString
@Setter // Genera setters
@Getter // Genera getters
// Clase abstracta que representa un elemento en batalla
public abstract class BattleElement implements Serializable {

    public BattleElementType type; // Tipo del elemento de batalla

    // Constructor que inicializa el tipo
    public BattleElement(BattleElementType type) {
        this.type = type; // Asigna el tipo
    }

    // Método para obtener la celda de batalla en una matriz de celdas
    public BattleCell getCell(BattleCell[][] cells) {
        return cells[getPosX()][getPosY()]; // Retorna la celda en las coordenadas del elemento
    }

    // Método para obtener un nodo A* basado en la posición
    public Node getNode() {
        return new Node(getPosX(), getPosY()); // Crea nodo con coordenadas
    }

    // Método para obtener un nodo GO2 basado en la posición
    public GO2Node getGO2Node() {
        return new GO2Node(getPosX(), getPosY()); // Crea nodo GO2 con coordenadas
    }

    // Métodos abstractos que deben ser implementados por subclases
    public abstract int getPosX(); // Retorna coordenada X

    public abstract int getPosY(); // Retorna coordenada Y

    public abstract boolean canAttack(BattleElement target); // Verifica si puede atacar al objetivo

}
