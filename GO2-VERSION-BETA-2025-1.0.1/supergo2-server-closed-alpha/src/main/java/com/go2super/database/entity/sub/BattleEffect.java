// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity.sub;

// Importaciones de Lombok para generar código automáticamente
import lombok.Data; // Genera getters, setters, toString, equals, hashCode

// Anotaciones Lombok aplicadas a la clase
@Data // Genera getters, setters, toString, equals, hashCode
// Clase que representa un efecto en batalla
public class BattleEffect {

    private int id; // ID único del efecto
    private int round; // Ronda en la que ocurre el efecto

    private double value; // Valor del efecto

}
