// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity.sub;

// Importaciones de Lombok para generar código automáticamente
import lombok.Data; // Genera getters, setters, toString, equals, hashCode

// Anotaciones Lombok aplicadas a la clase
@Data // Genera getters, setters, toString, equals, hashCode
// Clase que representa un cache de experiencia de batalla
public class BattleExpCache {

    private int guid; // GUID del usuario
    private int commanderId; // ID del comandante

    private int exp; // Experiencia ganada
    private int headId; // ID de cabeza (posiblemente avatar)
    private int levelId; // ID de nivel

}
