// Paquete que contiene la clase, parte del módulo de entidades de base de datos
package com.go2super.database.entity.sub;

// Importación de entidad padre Sanction
import com.go2super.database.entity.Sanction; // Entidad base de sanciones

// Importaciones de Lombok para generar código automáticamente
import lombok.Data; // Genera getters, setters, toString, equals, hashCode
import lombok.NoArgsConstructor; // Genera constructor vacío
import lombok.experimental.SuperBuilder; // Genera builder con soporte para herencia

// Importaciones estándar de Java
import java.util.Date; // Clase para fechas

// Anotaciones Lombok aplicadas a la clase
@Data // Genera getters, setters, toString, equals, hashCode
@SuperBuilder(toBuilder = true) // Genera builder con toBuilder y soporte para herencia
@NoArgsConstructor // Genera constructor vacío
// Clase que representa una sanción temporal aplicada a un usuario
public class TemporalSanction extends Sanction { // Extiende Sanction

    private String timeFormat; // Formato de tiempo de la sanción
    private Date until; // Fecha hasta la que dura la sanción

}
