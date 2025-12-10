// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity.sub;

// Importación de enum para tipos de incidentes de corporación
import com.go2super.database.entity.type.CorpIncidentType; // Enum que define tipos de incidentes corporativos

// Importaciones de Lombok para generar código automáticamente
import lombok.Builder; // Genera patrón builder
import lombok.Data; // Genera getters, setters, toString, equals, hashCode

// Importaciones estándar de Java
import java.util.Date; // Clase para fechas

// Anotaciones Lombok aplicadas a la clase
@Data // Genera getters, setters, toString, equals, hashCode
@Builder // Genera patrón builder
// Clase que representa un incidente ocurrido en una corporación
public class CorpIncident {

    private CorpIncidentType type; // Tipo de incidente (enum)
    private Date date; // Fecha y hora en que ocurrió el incidente

    private String sourceName; // Nombre del origen del incidente
    private String objectName; // Nombre del objeto afectado

    private Long sourceUserId; // ID del usuario que originó el incidente
    private Long sourceObjectId; // ID del objeto que originó el incidente

    private int guid; // GUID relacionado con el incidente
    private int extend; // Información adicional/extendida
    private int incidentType; // Tipo numérico del incidente

}
