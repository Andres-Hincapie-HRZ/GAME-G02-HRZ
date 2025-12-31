// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity.sub;

// Importaciones de Lombok para generar código automáticamente
import lombok.Data; // Genera getters, setters, toString, equals, hashCode

// Anotaciones Lombok aplicadas a la clase
@Data // Genera getters, setters, toString, equals, hashCode
// Clase que representa una estructura en batalla (edificio)
public class BattleStructure {

    private int buildingId; // ID del edificio
    private int level; // Nivel del edificio

    private int health; // Salud actual
    private int maxHealth; // Salud máxima

    private boolean destroyed = false; // Si está destruida (por defecto false)

}
