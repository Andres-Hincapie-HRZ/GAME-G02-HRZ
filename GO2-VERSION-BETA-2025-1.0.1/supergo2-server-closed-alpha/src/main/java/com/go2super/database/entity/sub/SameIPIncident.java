// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity.sub;

// Importación de entidad padre para incidentes de riesgo
import com.go2super.database.entity.RiskIncident; // Entidad base para incidentes de riesgo

// Importaciones de Lombok para generar código automáticamente
import lombok.Data; // Genera getters, setters, toString, equals, hashCode
import lombok.NoArgsConstructor; // Genera constructor vacío
import lombok.experimental.SuperBuilder; // Genera builder con soporte para herencia

// Importaciones estándar de Java
import java.util.ArrayList; // Lista dinámica
import java.util.List; // Interfaz de lista

// Anotaciones Lombok aplicadas a la clase
@Data // Genera getters, setters, toString, equals, hashCode
@SuperBuilder(toBuilder = true) // Genera builder con toBuilder y soporte para herencia
@NoArgsConstructor // Genera constructor vacío
// Clase que representa un incidente de misma IP en el sistema de riesgo
public class SameIPIncident extends RiskIncident { // Extiende RiskIncident

    private String ip; // Dirección IP involucrada en el incidente

    private List<UserSameIPIncidentInfo> users = new ArrayList<>(); // Lista de usuarios asociados a esta IP

}
