// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity.sub;

// Importaciones de Lombok para generar código automáticamente
import lombok.*; // Incluye Builder, AllArgsConstructor, NoArgsConstructor, ToString, Setter, Getter

// Importaciones estándar de Java
import java.util.Date; // Clase para fechas (no usada en este archivo)
import java.util.List; // Interfaz de lista (no usada en este archivo)

// Anotaciones Lombok aplicadas a la clase
@Builder(toBuilder = true) // Genera builder con toBuilder
@AllArgsConstructor(access = AccessLevel.PACKAGE) // Constructor con todos los argumentos (paquete privado)
@NoArgsConstructor(access = AccessLevel.PACKAGE) // Constructor vacío (paquete privado)
@ToString // Genera toString
@Setter // Genera setters
@Getter // Genera getters
// Clase que representa una métrica/contador en el sistema
public class Metric {

    private String identifier; // Identificador único de la métrica
    private int value; // Valor actual de la métrica

    // Método para agregar cantidad al valor
    public void add(int amount) {
        value += amount; // Incrementa el valor
    }

    // Método para restar cantidad al valor
    public void sub(int amount) {
        value -= amount; // Decrementa el valor
    }

    // Método para resetear el valor a 0
    public void reset() {
        value = 0; // Establece valor en cero
    }

}
