// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity.sub;

// Importaciones de Lombok para generar código automáticamente
import lombok.Data; // Genera getters, setters, toString, equals, hashCode

// Anotaciones Lombok aplicadas a la clase
@Data // Genera getters, setters, toString, equals, hashCode
// Clase que representa una nave magullada/dañada en batalla
public class BruiseShip {

    private int shipModelId; // ID del modelo de nave
    private int num; // Número de naves magulladas

    // Constructor con parámetros
    public BruiseShip(int shipModelId, int num) {
        this.shipModelId = shipModelId; // Asigna ID del modelo
        this.num = num; // Asigna número
    }

    // Método estático para crear instancia de BruiseShip
    public static BruiseShip of(int shipModelId, int num) {
        return new BruiseShip(shipModelId, num); // Retorna nueva instancia
    }

}
