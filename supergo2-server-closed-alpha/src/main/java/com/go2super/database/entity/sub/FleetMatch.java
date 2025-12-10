// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity.sub;

// Importación de enum MatchType
import com.go2super.database.entity.type.MatchType; // Tipo de coincidencia/batalla

// Importaciones de Lombok para generar código automáticamente
import lombok.Builder; // Genera patrón builder
import lombok.Data; // Genera getters, setters, toString, equals, hashCode

// Anotaciones Lombok aplicadas a la clase
@Data // Genera getters, setters, toString, equals, hashCode
@Builder // Genera patrón builder
// Clase que representa una coincidencia/match de flota
public class FleetMatch {

    private String match; // ID o referencia de la coincidencia
    private MatchType matchType; // Tipo de coincidencia (batalla, etc.)

    private int galaxyId; // ID de la galaxia donde ocurre la coincidencia

}
