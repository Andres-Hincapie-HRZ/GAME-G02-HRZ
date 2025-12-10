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
import java.util.LinkedList; // Lista enlazada

// Anotaciones Lombok aplicadas a la clase
@Data // Genera getters, setters, toString, equals, hashCode
@SuperBuilder(toBuilder = true) // Genera builder con toBuilder y soporte para herencia
@NoArgsConstructor // Genera constructor vacío
// Clase que representa un incidente de inundación de paquetes en el sistema de riesgo
public class PacketFloodIncident extends RiskIncident { // Extiende RiskIncident

    private String email; // Email del usuario involucrado
    private String discord; // ID de Discord del usuario
    private String accountName; // Nombre de la cuenta
    private String username; // Nombre de usuario en el juego

    private int guid; // GUID del usuario
    private long userId; // ID del usuario

    private int totalReports; // Número total de reportes de inundación
    private int totalCount; // Conteo total de paquetes

    private double ppt; // Paquetes por tick (velocidad de inundación)

    private LinkedList<String> lastPackets; // Lista de últimos paquetes detectados
    private Date lastDetection; // Fecha de última detección
    private String accountId; // ID de la cuenta

}
