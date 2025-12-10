// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity.sub;

// Importación de enum JumpType
import com.go2super.obj.type.JumpType; // Tipo de salto/transmisión

// Importaciones de Lombok para generar código automáticamente
import lombok.Builder; // Genera patrón builder
import lombok.Data; // Genera getters, setters, toString, equals, hashCode

// Importaciones estándar de Java
import java.util.Date; // Clase para fechas

// Anotaciones Lombok aplicadas a la clase
@Data // Genera getters, setters, toString, equals, hashCode
@Builder // Genera patrón builder
// Clase que representa la transmisión/salto de una flota
public class FleetTransmission {

    private int galaxyId; // ID de la galaxia destino
    private JumpType jumpType; // Tipo de salto/transmisión

    private int total; // Total de unidades en transmisión
    private Date until; // Fecha hasta la que dura la transmisión

}
