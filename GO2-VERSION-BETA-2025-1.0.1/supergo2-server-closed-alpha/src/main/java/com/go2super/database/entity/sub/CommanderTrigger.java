// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity.sub;

// Importaciones de Lombok para generar código automáticamente
import lombok.AllArgsConstructor; // Genera constructor con todos los argumentos
import lombok.Builder; // Genera patrón builder
import lombok.Data; // Genera getters, setters, toString, equals, hashCode
import lombok.NoArgsConstructor; // Genera constructor vacío

// Importaciones estándar de Java
import java.io.Serializable; // Para serialización

// Anotaciones Lombok aplicadas a la clase
@Data // Genera getters, setters, toString, equals, hashCode
@Builder // Genera patrón builder
@NoArgsConstructor // Genera constructor vacío
@AllArgsConstructor // Genera constructor con todos los argumentos
// Clase que representa el trigger/habilidad especial de un comandante
public class CommanderTrigger implements Serializable {

    private double rate; // Tasa de activación del trigger (probabilidad)

    private double accuracy; // Modificador de puntería cuando se activa
    private double dodge; // Modificador de esquiva cuando se activa
    private double speed; // Modificador de velocidad cuando se activa
    private double electron; // Modificador de electrónica cuando se activa

    private double procA; // Parámetro de procedimiento A
    private double procB; // Parámetro de procedimiento B
    private double procC; // Parámetro de procedimiento C
    private double procD; // Parámetro de procedimiento D

}
