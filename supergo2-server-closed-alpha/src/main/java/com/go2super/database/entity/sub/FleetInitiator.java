// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity.sub;

// Importación de enum JumpType
import com.go2super.obj.type.JumpType; // Tipo de salto/transmisión

// Importaciones de Lombok para generar código automáticamente
import lombok.Builder; // Genera patrón builder
import lombok.Data; // Genera getters, setters, toString, equals, hashCode

// Anotaciones Lombok aplicadas a la clase
@Data // Genera getters, setters, toString, equals, hashCode
@Builder // Genera patrón builder
// Clase que representa el iniciador de una flota (tipo de salto)
public class FleetInitiator {

    private JumpType jumpType; // Tipo de salto que inició la flota

}