// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity.sub;

// Importaciones de Lombok para generar código automáticamente
import lombok.Data; // Genera getters, setters, toString, equals, hashCode

// Anotaciones Lombok aplicadas a la clase
@Data // Genera getters, setters, toString, equals, hashCode
// Clase que representa un cache de estadísticas de nave en batalla
public class BattleShipCache {

    private int guid; // GUID del usuario propietario
    private int shipModelId; // ID del modelo de nave

    private double shootdowns; // Número de derribos realizados
    private double highestAttack; // Ataque más alto realizado

}
