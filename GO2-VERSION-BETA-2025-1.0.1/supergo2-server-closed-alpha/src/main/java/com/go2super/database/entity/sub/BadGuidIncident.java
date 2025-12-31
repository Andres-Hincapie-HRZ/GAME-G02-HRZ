// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity.sub;

// Importación de entidad padre para incidentes de riesgo
import com.go2super.database.entity.RiskIncident; // Entidad base para incidentes de riesgo

// Importaciones de Lombok para generar código automáticamente
import lombok.Data; // Genera getters, setters, toString, equals, hashCode
import lombok.NoArgsConstructor; // Genera constructor vacío
import lombok.experimental.SuperBuilder; // Genera builder con soporte para herencia

// Importaciones estándar de Java
import java.util.Date; // Clase para fechas
import java.util.List; // Interfaz de lista

// Anotaciones Lombok para generar código boilerplate
@Data // Genera getters, setters, toString, equals, hashCode
@SuperBuilder(toBuilder = true) // Genera builder con toBuilder y soporte para herencia
@NoArgsConstructor // Genera constructor vacío
// Clase que representa un incidente de GUID malo en el sistema de riesgo
public class BadGuidIncident extends RiskIncident { // Extiende RiskIncident para herencia

    private String email; // Email del usuario involucrado en el incidente
    private String discord; // ID de Discord del usuario
    private String accountName; // Nombre de la cuenta del usuario
    private String username; // Nombre de usuario en el juego

    private int guid; // GUID único del usuario
    private long userId; // ID único del usuario

    private int targetGuid; // GUID del objetivo del incidente (posiblemente inválido)
    private int totalCount; // Número total de veces que se detectó este incidente
    private List<String> lastDetections; // Lista de las últimas detecciones del incidente

    private Date lastDetection; // Fecha y hora de la última detección
    private String accountId; // ID de la cuenta asociada

}
